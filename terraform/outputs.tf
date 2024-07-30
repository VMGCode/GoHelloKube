output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "EKS Cluster CA data"
  value       = module.eks.cluster_certificate_authority_data
}

output "node_group_role_arn" {
  description = "ARN of the node group role"
  value       = module.eks.node_groups["eks_nodes"].iam_role_arn
}
