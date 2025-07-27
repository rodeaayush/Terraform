provider "aws" {
  region = var.region
}

# 1) Launch EC2 (no provisioners here)
resource "aws_instance" "vm1" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd unzip
    systemctl enable httpd
    systemctl start httpd
  EOF

  tags = {
    Name = var.instance_name
  }
}

# 2) After the EC2 exists, upload + unpack + copy your website
resource "null_resource" "upload_website" {
  depends_on = [aws_instance.vm1]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_instance.vm1.public_ip
    private_key = file("${path.module}/../ubuntukey.pem")
  }

  # copy the zip
  provisioner "file" {
    source      = "${path.module}/website.zip"
    destination = "/home/ec2-user/website.zip"
  }

  # unzip and move into /var/www/html
  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user",
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "unzip -o website.zip -d website",
      "sudo cp -r website/* /var/www/html/",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"

    ]
  }
}
