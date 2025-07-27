provider "aws" {
  region = var.region
}

resource "aws_instance" "vm1" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = var.instance_name
  }
   user_data = <<-EOF
    #!/bin/bash
    sudo -i 
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd 
    echo "Hello World" > /var/www/html/index.html
    EOF
}