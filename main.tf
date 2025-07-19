resource "aws_lb" "test" {
  name               = "loadbalancerdemo"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["subnet-000d5817b05c45fc2" ,"subnet-0513597d489e87ee9"]

  enable_deletion_protection = false
  
  tags = {
    Environment = "production"
  }
}
