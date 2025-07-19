resource "aws_security_group" "tf_sg" {
  name        = "tf_sg"
  description = "Allow HTTPS to web server"
  vpc_id      = "vpc-05bdcc8880aab85ab"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    
  }
 ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}


resource "aws_lb" "test" {
  name               = "loadbalancerdemo"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf_sg.id]
  subnets            = ["subnet-0b5fe6746ff2f3430" , "subnet-04fe3b0de658613bc"]

  enable_deletion_protection = false
  
  tags = {
    Environment = "production"
  }
}
