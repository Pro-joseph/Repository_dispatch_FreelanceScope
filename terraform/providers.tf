terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "freelancescope-terraform-state"
    key    = "infra/terraform.tfstate"
    region = "eu-west-3"
  }
}

provider "aws" {
  region = var.region
}
