Assignment 2 – Multi-Tier Web Infrastructure
Project Overview

This project implements a secure multi-tier web infrastructure on AWS using Terraform and Nginx.
Nginx acts as a reverse proxy and load balancer distributing traffic across multiple backend Apache web servers.

The setup includes:

HTTPS with SSL/TLS

Load balancing

Health checks

Security headers

Rate limiting

Custom error pages

Monitoring and logging

Architecture Overview
┌─────────────────────────────────────────────────┐
│                  Internet                       │
└─────────────────┬───────────────────────────────┘
                  │
                  │ HTTPS (443)
                  │ HTTP (80)
                  ▼
         ┌────────────────────┐
         │   Nginx Server     │
         │  (Load Balancer)   │
         │   - SSL/TLS        │
         │   - Rate Limiting  │
         │   - Reverse Proxy  │
         └────────┬───────────┘
                  │
      ┌───────────┼───────────┐
      │           │           │
      ▼           ▼           ▼
   ┌─────┐     ┌─────┐     ┌─────┐
   │Web-1│     │Web-2│     │Web-3│
   │Apache│    │Apache│    │Apache│
   └─────┘     └─────┘     └─────┘
   Primary     Primary     Backup

Components Description

Nginx Server

Reverse proxy

SSL termination

Load balancing

Security headers

Rate limiting

Backend Web Servers

Apache HTTP server

Serve application content

Health-checked by script

Terraform

Infrastructure provisioning

EC2, security groups, networking

AWS Systems Manager (SSM)

Secure instance access

No SSH key exposure

Prerequisites
Required Tools

Terraform

AWS CLI

SSH client

Nginx

OpenSSL

curl

AWS Credentials Setup
aws configure


Provide:

Access Key

Secret Key

Region

SSH Key Setup
ssh-keygen -t ed25519

Deployment Instructions
Step 1: Initialize Terraform
terraform init

Step 2: Configure Variables

Update backend IPs in:

backend_servers_private_ips = {
  "web-1" = "10.0.10.105"
  "web-2" = "10.0.10.249"
  "web-3" = "10.0.10.232"
}

Step 3: Deploy Infrastructure
terraform apply


Type yes when prompted.

Configuration Guide
Update Backend IPs

Edit:

/etc/nginx/nginx.conf


Update upstream block:

upstream backend_servers {
    server 10.0.10.105;
    server 10.0.10.249;
    server 10.0.10.232 backup;
}


Reload Nginx:

sudo systemctl reload nginx

Testing Procedures

HTTPS Test:

curl -I -k https://<nginx-public-ip>


HTTP to HTTPS Redirect:

curl -I http://<nginx-public-ip>


Load Balancing:

for i in {1..5}; do curl -k https://<nginx-public-ip>; done


Rate Limiting:

for i in {1..30}; do curl -k https://<nginx-public-ip>; done

Architecture Details
Network Topology

Public subnet for Nginx

Private subnet for backend servers

Internet Gateway for external access

Security Groups

Nginx: Allow 80, 443

Backend: Allow 80 from Nginx only

SSH disabled (SSM used)

Load Balancing Strategy

Round-robin

Backup server configured

Failover supported

TroubleshootingAssignment 2 – Multi-Tier Web Infrastructure
Project Overview

This project implements a secure multi-tier web infrastructure on AWS using Terraform and Nginx.
Nginx acts as a reverse proxy and load balancer distributing traffic across multiple backend Apache web servers.

The setup includes:

HTTPS with SSL/TLS

Load balancing

Health checks

Security headers

Rate limiting

Custom error pages

Monitoring and logging

Architecture Overview
┌─────────────────────────────────────────────────┐
│                  Internet                       │
└─────────────────┬───────────────────────────────┘
                  │
                  │ HTTPS (443)
                  │ HTTP (80)
                  ▼
         ┌────────────────────┐
         │   Nginx Server     │
         │  (Load Balancer)   │
         │   - SSL/TLS        │
         │   - Rate Limiting  │
         │   - Reverse Proxy  │
         └────────┬───────────┘
                  │
      ┌───────────┼───────────┐
      │           │           │
      ▼           ▼           ▼
   ┌─────┐     ┌─────┐     ┌─────┐
   │Web-1│     │Web-2│     │Web-3│
   │Apache│    │Apache│    │Apache│
   └─────┘     └─────┘     └─────┘
   Primary     Primary     Backup

Components Description

Nginx Server

Reverse proxy

SSL termination

Load balancing

Security headers

Rate limiting

Backend Web Servers

Apache HTTP server

Serve application content

Health-checked by script

Terraform

Infrastructure provisioning

EC2, security groups, networking

AWS Systems Manager (SSM)

Secure instance access

No SSH key exposure

Prerequisites
Required Tools

Terraform

AWS CLI

SSH client

Nginx

OpenSSL

curl

AWS Credentials Setup
aws configure


Provide:

Access Key

Secret Key

Region

SSH Key Setup
ssh-keygen -t ed25519

Deployment Instructions
Step 1: Initialize Terraform
terraform init

Step 2: Configure Variables

Update backend IPs in:

backend_servers_private_ips = {
  "web-1" = "10.0.10.105"
  "web-2" = "10.0.10.249"
  "web-3" = "10.0.10.232"
}

Step 3: Deploy Infrastructure
terraform apply


Type yes when prompted.

Configuration Guide
Update Backend IPs

Edit:

/etc/nginx/nginx.conf


Update upstream block:

upstream backend_servers {
    server 10.0.10.105;
    server 10.0.10.249;
    server 10.0.10.232 backup;
}


Reload Nginx:

sudo systemctl reload nginx

Testing Procedures

HTTPS Test:

curl -I -k https://<nginx-public-ip>


HTTP to HTTPS Redirect:

curl -I http://<nginx-public-ip>


Load Balancing:

for i in {1..5}; do curl -k https://<nginx-public-ip>; done


Rate Limiting:

for i in {1..30}; do curl -k https://<nginx-public-ip>; done

Architecture Details
Network Topology

Public subnet for Nginx

Private subnet for backend servers

Internet Gateway for external access

Security Groups

Nginx: Allow 80, 443

Backend: Allow 80 from Nginx only

SSH disabled (SSM used)

Load Balancing Strategy

Round-robin

Backup server configured

Failover supported

Troubleshooting
Common Issues

502 Bad Gateway → Backend down

Permission denied → Wrong SSH key or IAM role missing

No instances in SSM → IAM role not attached

Log Locations
/var/log/nginx/access.log
/var/log/nginx/error.log

Debug Commands
sudo nginx -t
sudo systemctl status nginx
ps aux | grep nginx
Common Issues

502 Bad Gateway → Backend down

Permission denied → Wrong SSH key or IAM role missing

No instances in SSM → IAM role not attached

Log Locations
/var/log/nginx/access.log
/var/log/nginx/error.log

Debug Commands
sudo nginx -t
sudo systemctl status nginx
ps aux | grep nginx
