variable "region" {
  type    = string
  default = "eu-west-3"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key file"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "admin_username" {
  type    = string
  default = "ubuntu"
}
