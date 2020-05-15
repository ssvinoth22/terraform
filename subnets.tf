# Create a subnet to launch our instances into
resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc_test.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_public"
  }
}

# Create Nat gw
resource "aws_eip" "nat_gw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.subnet_public.id
}

#MAin route table

resource "aws_route_table" "my_vpc_us_east_1a_nated" {
    vpc_id = aws_vpc.vpc_test.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gw.id
    }

    tags = {
        Name = "Main Route Table for NAT-ed subnet"
    }
}

resource "aws_route_table_association" "my_vpc_nated" {
    subnet_id = aws_subnet.subnet_public.id
    route_table_id = aws_route_table.my_vpc_us_east_1a_nated.id
}