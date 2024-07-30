 Hello World Go Application with Kubernetes

This is a simple "Hello World" web application written in Go, containerized with Docker, and deployed using Kubernetes. The project uses Helm for Kubernetes deployments and GitHub Actions for CI/CD.

## Prerequisites

Ensure you have the following tools installed:

- Docker
- Kubernetes (kubectl)
- Minikube (optional for local testing)
- Helm
- Go
- Terraform
- AWS CLI (if using AWS)
- GitHub account

## Setup

### 1. Clone the Repository

Clone the repository to your local machine:

```sh
git clone https://github.com/your-username/hello-world-go-k8s.git
cd hello-world-go-k8s
```
### 2. Initialize Go Module
Navigate to the app directory and initialize the Go module:

```sh
cd app
go mod init hello-world-go
go mod tidy
```
### 3. Build and Run Locally

Build the Docker image and run the container:

```sh
docker build -t hello-world-go .
docker run -p 8080:8080 hello-world-go
You should be able to access the application at http://localhost:8080.
```
### 4. Run Unit Tests
Run the unit tests for the Go application:

```sh
cd app
go test -v
```
Using Terraform to Provision Infrastructure

### 5. Set Up AWS Credentials
Configure your AWS CLI with appropriate credentials:

```sh
aws configure
```
### 6. Provision EKS Cluster with Terraform
Navigate to the terraform-eks directory:

```sh
cd terraform-eks
```

Initialize Terraform:

```sh
terraform init
```
Apply Terraform configuration:

```sh
terraform apply
```

### 7. Update kubeconfig
Update your kubeconfig to use the new EKS cluster:

```sh
aws eks --region <region> update-kubeconfig --name <cluster_name>
```

Deploy to Kubernetes using Helm

### 8. Deploy the Application with Helm
Ensure you are using the correct Kubernetes context:

```sh
kubectl config use-context <your-eks-cluster-context>
```
Deploy the application using Helm:

```sh
helm upgrade --install hello-world-go helm/ --set image.repository=your-docker-username/hello-world-go --set image.tag=latest
```
Verify the deployment:

```sh
kubectl get pods
kubectl get services
```
Accessing the Application

### 9. Port Forwarding (Local)
If using Minikube or local setup:

Start port forwarding:

```sh
kubectl port-forward svc/hello-world-go-service 8080:80
```
Access the application:

Open a web browser and navigate to http://localhost:8080.

Alternatively, use curl:

```sh
curl http://localhost:8080
```
### 10. Accessing EKS Service

If using an EKS cluster, ensure the service type is LoadBalancer and get the external IP:

```sh
kubectl get svc hello-world-go-service
```
Access the application using the external IP provided by the LoadBalancer service.