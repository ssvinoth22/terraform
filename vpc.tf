# Specify the provider and access details
provider "aws" {
  region = var.aws_region
}

# Create a VPC to launch our instances into
resource "aws_vpc" "vpc_test" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_test"
  }
}

