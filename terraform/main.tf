resource "aws_security_group" "freelancescope" {
  name        = "freelancescope-sg"
  description = "FreelanceScope security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "freelancescope" {
  domain = "vpc"
}

resource "aws_instance" "freelancescope" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.freelancescope.key_name
  vpc_security_group_ids = [aws_security_group.freelancescope.id]

  user_data_base64 = base64encode(templatefile("${path.module}/cloud-init.yml", {}))

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "freelancescope-vm"
  }
}

resource "aws_eip_association" "freelancescope" {
  instance_id   = aws_instance.freelancescope.id
  allocation_id = aws_eip.freelancescope.id
}

resource "aws_key_pair" "freelancescope" {
  key_name   = "freelancescope-key"
  public_key = file(var.ssh_public_key_path)
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-24.04-amd64-server-*"]
  }
}
