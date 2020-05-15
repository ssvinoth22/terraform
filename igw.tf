# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "igw_test" {
  vpc_id = aws_vpc.vpc_test.id
  tags = {
    Name = "igw_test"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.vpc_test.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_test.id
}