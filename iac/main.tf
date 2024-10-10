provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "posweb-myapp-2024"
  vpc_security_group_ids = [aws_security_group.posweb_myapp_2024_sg.id]
  user_data = base64encode(data.template_file.user_data.rendered)

  tags = {
    Name = "HelloWorld2"
  }
}