terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}


resource "aws_instance" "instance" {
  count = 1
  ami = "ami-065deacbcaac64cf2"
  #ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = "t2.micro"
  key_name               = "gkey"
  user_data              = file("dockerjenkins.sh")
  tags = {
    Name = "dockerjenkinss"
  }
#   connection {
#     type = "ssh"
#     host = self.public_ip
#     user = "ubuntu"
#     private_key = file("C:/Users/valters.k.rozentals/Desktop/projects/Terraform-ec2-docker-jenkins-pythonscript/ec2")
#     timeout = "1m"
#   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


# resource "aws_key_pair" "deployer" {
#   key_name   = "ec2"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+ue+gZBWwKMv0Lutr5HW2yROmMXx5pc3yfAoKh7VMdTERk9c2eGmQmEUeYJgBMahpNCABQ7MKZTPfaKTuJGzcdOKPrnefYVUhvqrUYnWgUGo34mQJeulpf5WEIYKLcU+VXIfR1xOaHNEuRBjIVYsG3Llv+bJw/xpTE+3WoXlMkPhrkB3QVp1lZZX9yUTjRNJZO8+g00SYHWUEtm1Bpig5CF6+8T/mUNvEeTCBgUR8NnFsNp8P552JGBM7gBHPp996YKoNuZWHLbjBM3WFh0Dk9ohbNesO8AfnKO9hpj194c/gNRAGcmsznp/zncUCNJ8+kpqqUr4D2uNJIZjDxYMD dir/valters.k.rozentals@LVAGPLTP4106"
# }