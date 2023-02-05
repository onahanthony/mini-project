resource "aws_lb_target_group" "front" {
  name     = "application-front"
  port     = var.http_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}
resource "aws_lb_target_group_attachment" "attach-app1" {
  target_group_arn = aws_lb_target_group.front.arn
  target_id        = aws_instance.app-server1.id
  port             = var.http_port
}
resource "aws_lb_target_group_attachment" "attach-app2" {
  target_group_arn = aws_lb_target_group.front.arn
  target_id        = aws_instance.app-server2.id
  port             = var.http_port
}
resource "aws_lb_target_group_attachment" "attach-app3" {
  target_group_arn = aws_lb_target_group.front.arn
  target_id        = aws_instance.app-server3.id
  port             = var.http_port
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front.arn
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front.arn
  }
}
resource "aws_lb" "front" {
  name               = "front"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.http-sg.id]
  subnets            = [aws_subnet.private-2a.id, aws_subnet.private-2b.id, aws_subnet.private-2c.id]

  enable_deletion_protection = false

  tags = {
    Environment = "front"
  }
}
