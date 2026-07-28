output "public_ip" {
  value = aws_eip.freelancescope.public_ip
}

output "instance_id" {
  value = aws_instance.freelancescope.id
}
