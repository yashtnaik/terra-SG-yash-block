resource "aws_vpc" "My-Test-VPC-Terraform" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.VPC-Name
  }
}


resource "aws_security_group" "allow_tls" {
  name        = var.aws-SG-name
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.My-Test-VPC-Terraform.id

  tags = {
    Name = var.aws-SG-name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = aws_vpc.main.ipv6_cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}