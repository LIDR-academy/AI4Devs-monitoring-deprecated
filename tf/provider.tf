provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
