variable "http_port" {
  type    = string
  default = "80"
}

variable "ssh_port" {
  type    = string
  default = "22"
}
variable "ec2_ami" {
  type    = string
  default = "ami-00874d747dde814fa"
}
variable "key_name" {
  type    = string
  default = "my-ssh"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "domain_name" {
  type    = string
  default = "dencoman.me"
}

variable "record_name" {
  type    = string
  default = "www"
}
