locals {
  prefix = "richie-terraform-1"
}

resource "aws_ecr_repository" "my_sample_repo" {
  name = "${local.prefix}"
  image_tag_mutability = "MUTABLE"

  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "${local.prefix}-ecs"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    richie-ecsdemo-1 = { #This is service-name
      cpu    = 512
      memory = 1024

      # Container definition(s)
      container_definitions = {

        ecs-sample = {
          cpu       = 512
          memory    = 1024
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/richie-ecr:latest"
          # image = "255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/${local.prefix}:latest"
          port_mappings = [
            {
              containerPort = 8080
              protocol      = "tcp"
            }
          ]
          # readonly_root_filesystem= false
        }
      }

      assign_public_ip = true
      deployment_minimum_healthy_percent = 100
      subnet_ids = flatten(data.aws_subnets.public.ids)
      security_group_ids = [module.ecs_sg.security_group_id]

    }
  }

  tags = {
    Environment = "Development"
    Project     = "${local.prefix}-example"
  }
}

module "ecs_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1.0"

  name = "${local.prefix}-ecs-sg"
  description = "Security group for ecs"

  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-8080-tcp"]
  egress_rules        = ["all-all"]
}
