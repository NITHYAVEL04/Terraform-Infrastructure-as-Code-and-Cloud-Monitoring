terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1" # You can change this to your preferred AWS region
}

# 1. Provision an AWS EC2 Server
resource "aws_instance" "my_server" {
  ami           = "ami-083cf4acad89c8905" # Ubuntu 22.04 LTS AMI (adjust if needed)
  instance_type = "t3.micro"

  tags = {
    Name = "Terraform-DevOps-Server"
  }
}

# 2. Set up CloudWatch Monitoring Alarm for High CPU Usage
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This alarm triggers when server CPU exceeds 80%"

  dimensions = {
    InstanceId = aws_instance.my_server.id
  }
}

output "instance_ip" {
  value       = aws_instance.my_server.public_ip
  description = "Public IP address of the provisioned server"
}
