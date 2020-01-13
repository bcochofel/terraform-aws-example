# main.tf
provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "example" {
  ami             = "ami-23a48cc8" # Ubuntu 14.04 LTS AMD64 in eu-central-1
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my-key.key_name
  security_groups = [aws_security_group.allow_ssh.name]
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my-key" {
  key_name   = "my-key"
  public_key = var.pubkey
}

output "example_public_dns" {
  value = aws_instance.example.public_dns
}

