###### root/main.tf ######

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

module "vpc" {
  source                  = "./modules/vpc"
  tags                    = "ekscluster"
  instance_tenancy        = "default"
  vpc_cidr                = "10.0.0.0/16"
  access_ip               = "0.0.0.0/0"
  public_sn_count         = 2
  public_cidrs            = ["10.0.1.0/24", "10.0.2.0/24"]
  public_sn_name          = "public-subnet"
  vpc_name                = "ekscluster-vpc"
  map_public_ip_on_launch = true
  rt_route_cidr_block     = "0.0.0.0/0"
}

module "eks" {
  source                  = "./modules/eks"
  aws_public_subnet       = module.vpc.aws_public_subnet
  vpc_id                  = module.vpc.vpc_id
  cluster_name            = "terraform-eks-test-cluster"
  endpoint_public_access  = true
  endpoint_private_access = false
  public_access_cidrs     = ["0.0.0.0/0"]
  node_group_name         = "ekscluster"
  scaling_desired_size    = 1
  scaling_max_size        = 2
  scaling_min_size        = 1
  instance_types          = ["t4g.small"]
  key_pair                = "aws-linux-mumbai"
}
