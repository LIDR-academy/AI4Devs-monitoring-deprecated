data "aws_iam_policy_document" "s3_access_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.code_bucket.arn}/*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "s3_access_policy" {
  name   = "s3-access-policy"
  policy = data.aws_iam_policy_document.s3_access_policy.json
}

resource "aws_iam_role" "ec2_role" {
  name               = "lti-project-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_s3_access_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "lti-project-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_policy" "allow_get_role" {
  name        = "AllowGetRole"
  description = "Policy to allow iam:GetRole action"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "iam:GetRole"
        Effect   = "Allow"
        Resource = "arn:aws:iam::343218224348:role/lti-project-ec2-role"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_allow_get_role_policy" {
  user       = "monitoring-exercise"
  policy_arn = aws_iam_policy.allow_get_role.arn
}

resource "aws_iam_user_policy_attachment" "attach_ec2_full_access" {
  user       = "monitoring-exercise"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_user_policy_attachment" "attach_ecs_service_role" {
  user       = "monitoring-exercise"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

data "aws_iam_policy_document" "datadog_policy" {
  statement {
    actions = [
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "logs:GetLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "datadog_policy" {
  name   = "datadog-policy"
  policy = data.aws_iam_policy_document.datadog_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_datadog_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.datadog_policy.arn
}
