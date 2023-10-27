/*====
Variables used across all modules
======*/
locals {
  dev_availability_zones = ["${var.region}a", "${var.region}b"]
  environment = "dev"
}

/*==== A partir daqui precisamos de um arquivo no S3======*/

module "lambda" {
  source = "./modules/lambda"

  environment = local.environment
  bucket_name = "tech-challenge-soat1-grp13-s3-auth"
  project_version = "1.0"
}

module "apigateway" {
  source = "./modules/apigateway"

  environment = local.environment
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
  lambda_function_name = module.lambda.lambda_function_name
}