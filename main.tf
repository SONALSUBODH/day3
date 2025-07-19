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


resource "aws_lb" "tessubnet-0513597d489e87ee9t" {
  name               = "loadbalancerdemo"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf_sg.id]
  subnets            = ["subnet-0513597d489e87ee9" , "subnet-04fe3b0de658613bc"]

  enable_deletion_protection = false
  
  tags = {
    Environment = "production"
  }
}
resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-05bdcc8880aab85ab"
}
resource "aws_lb_target_group" "test1" {
  name     = "tf-example-lb-tg-1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-05bdcc8880aab85ab"
}
resource "aws_lb_target_group" "test2" {
  name     = "tf-example-lb-tg-2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-05bdcc8880aab85ab"
}
resource "aws_launch_template" "foobar" {
  name   = "test"
  image_id      = "ami-0f918f7e67a3323f0"
  instance_type = "t3.small"
}

resource "aws_autoscaling_group" "autoscale" {
  name                  = "test-autoscaling-group"  
  availability_zones    = ["ap-south-1b" , "ap-south-1a"]
  desired_capacity      = 3
  max_size              = 6
  min_size              = 3
  health_check_type     = "EC2"
  termination_policies  = ["OldestInstance"]
 

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
}
