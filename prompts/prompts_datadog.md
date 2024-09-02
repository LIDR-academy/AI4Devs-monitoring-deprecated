** Prompt 1**
Quiero añadir integración de Datadog en mi codebase de Terraform en @tf  . Cuáles son los bloques que necesito añadir para empezar a andar? Más adelante específicaré que componentes quiero que estén monitorizados por Datadog

** Prompt 2**
Puedo poner cualquier valor para "datadog_app_key" o tiene que ser consistente con algo de mi cuenta de Datadog o AWS?

** Prompt 3**
@tf Quiero generar lo necesario para monitorizar con Datadog, como especificado en  las instancias ec2 descritas en  . Genera todo lo necesario en @iam.tf , asumiendo que el setup de las credenciales AWS sólo tienen lo que viene por defecto

** Prompt 4**
Cuando hago un "tofu plan" en @tf , obtengo el siguiente error:

│ Error: reading IAM Role (lti-project-ec2-role): operation error IAM: GetRole, https response error StatusCode: 403, RequestID: c7d86437-5cd1-40d4-ae1f-1f5111b09290, api error AccessDenied: User: arn:aws:iam::343218224348:user/monitoring-exercise is not authorized to perform: iam:GetRole on resource: role lti-project-ec2-role because no identity-based policy allows the iam:GetRole action

