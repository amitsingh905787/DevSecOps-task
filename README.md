DevSecOps Candidate Evaluation Task
Overview

This project demonstrates an end-to-end DevSecOps implementation for a Node.js / Express application with MongoDB, deployed in a secure, containerized Kubernetes environment, simulating a production-grade AWS EKS architecture locally.

The goal is to showcase best practices across:

Secure containerization

CI/CD pipeline security

Infrastructure as Code (Terraform)

Kubernetes hardening

Observability and compliance

Architecture Flow (High Level)
Developer Push Code
        ↓
CI/CD Pipeline (GitHub Actions)
        ↓
Static Code Scan (Semgrep)
        ↓
Docker Image Build (Hardened, Non-Root)
        ↓
Container Vulnerability Scan (Trivy)
        ↓
Security Gate (Fail on HIGH/CRITICAL)
        ↓
Kubernetes Deployment (Minikube / Kind)
        ↓
Monitoring & Alerts (Prometheus)

Repository Structure
.
├── Dockerfile
├── trivy.txt
├── .github/
│   └── workflows/
│       └── devsecops.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── README.md
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── networkpolicy.yaml
│   └── pdb.yaml
├── monitoring/
│   └── prometheus-alerts.yaml
├── REPORT.md
└── README.md

Tools Used
Category	Tools
Containerization	Docker
Image Security	Trivy
CI/CD	GitHub Actions
Static Code Analysis	Semgrep
Infrastructure as Code	Terraform
IaC Security	Checkov / tfsec
Kubernetes	Minikube
Observability	Prometheus
Runtime Validation	kubectl
Setup Steps
1️⃣ Prerequisites

Install the following tools:

Docker
Minikube or Kind
kubectl
Terraform
Trivy
Checkov or tfsec
Git

2️⃣ Start Local Kubernetes Cluster
minikube start
kubectl get nodes

3️⃣ Build Docker Image
docker build -t node-app:latest .

Docker & Image Hardening
Security Measures Implemented

Multi-stage Docker build

Minimal base image (Alpine / Distroless)

Non-root user

Reduced attack surface

Run Trivy Image Scan (Local)
trivy image node-app:latest \
  --severity HIGH,CRITICAL \
  --exit-code 1 \
  > trivy.txt

Output

trivy.txt contains vulnerability scan results

HIGH/CRITICAL findings are fixed or documented

CI/CD Pipeline Security
CI/CD Tool

GitHub Actions

Pipeline Stages

Code checkout

Static code analysis (Semgrep)

Docker image build

Trivy image scan

Pipeline fails on critical vulnerabilities

Image promotion only if security gates pass

Trigger Pipeline
git push origin main

Evidence

GitHub Actions logs

Trivy report uploaded as pipeline artifact

Infrastructure as Code (Terraform – EKS Simulation)
Terraform Components

VPC

Subnets

IAM roles

EKS cluster

Node groups

Validate Terraform Configuration
cd terraform
terraform init
terraform validate

Run Terraform Security Scan
checkov -d . > checkov.txt


or

tfsec . > tfsec.txt

Result

No critical misconfigurations

Security best practices validated

Mapping to Real AWS EKS

Refer to terraform/README.md for detailed explanation of how the Terraform modules map to actual AWS EKS services.

Kubernetes Hardening (Local Cluster)
Apply Kubernetes Manifests
kubectl apply -f k8s/

Validate YAMLs
kubectl apply --dry-run=client -f k8s/

Verify Deployment
kubectl get pods
kubectl get svc

Security Controls Implemented

Non-root containers

PodSecurityContext

Resource requests & limits

NetworkPolicy for isolation

PodDisruptionBudget (optional)

Observability & Monitoring (Prometheus)
Deploy Monitoring Components
kubectl apply -f monitoring/

Sample Alerts

Pod restart frequency

High CPU usage

Validation
kubectl get prometheusrules

Commands Summary (Scans & Tests)
# Docker build
docker build -t node-app:latest .

# Trivy image scan
trivy image node-app:latest --severity HIGH,CRITICAL --exit-code 1

# Terraform validation
terraform validate

# Terraform security scan
checkov -d terraform/

# Kubernetes dry-run validation
kubectl apply --dry-run=client -f k8s/

# Kubernetes status
kubectl get pods

Security & Compliance Summary

Refer to REPORT.md for:

Identified risks

Hardening steps applied

Remaining gaps before production

Recommendations for real AWS deployment

Notes

This setup simulates AWS EKS locally using Minikube

No AWS account is required

Design patterns follow production-ready DevSecOps practices
