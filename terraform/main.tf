provider "aws" {
  region = "eu-north-1"
}

# Security Group allowing SSH and app traffic
resource "aws_security_group" "invento_sg" {
  name        = "invento-sg"
  description = "Allow SSH and app access"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
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

# EC2 Instance
resource "aws_instance" "invento" {
  ami           = "ami-0becc523130ac9d5d"
  instance_type = "t3.medium"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.invento_sg.id]

  tags = {
    Name = "InventoWareApp"
  }

  provisioner "remote-exec" {
    inline = [
  "sudo apt-get update -y",
  "sudo apt-get install docker.io -y",
  "sudo systemctl start docker",
  "sudo usermod -aG docker ubuntu"
]


    connection {
      type        = "ssh"
      user        = "ubuntu"  # ✅ change from ec2-user to ubuntu
      private_key = file("~/.ssh/jenkins_invento.pem")
      host        = self.public_ip
    }
  }
}


