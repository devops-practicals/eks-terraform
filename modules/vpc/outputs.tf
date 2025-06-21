###### modules/vpc/outputs.tf ######

# Output Public Subnet IDs
output "aws_public_subnet" {
  description = "List of Public Subnet IDs"
  value       = aws_subnet.public_ekscluster_subnet[*].id
}

# Output VPC ID
output "vpc_id" {
  description = "VPC ID of the created VPC"
  value       = aws_vpc.ekscluster.id
}

# Output Internet Gateway ID (Optional)
output "igw_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.ekscluster_gw.id
}

# Output Route Table ID (Optional)
output "route_table_id" {
  description = "Route Table ID associated with public subnets"
  value       = aws_default_route_table.internal_ekscluster_default.id
}
