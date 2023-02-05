  resource "aws_security_group" "http-sg" {
  name        = "allow_http_access"
  description = "allow inbound http traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "from my ip range"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "from my ip range"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "Application-1-sg"
  }
}

resource "aws_instance" "app-server1" {
  instance_type               = var.instance_type
  ami                         = var.ec2_ami
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.http-sg.id]
  subnet_id                   = aws_subnet.private-2a.id
  associate_public_ip_address = true
  tags = {
    Name = "app-server-1"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ../ansible/host_inventory"
  }
}
resource "aws_instance" "app-server2" {
