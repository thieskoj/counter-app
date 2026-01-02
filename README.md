# Counter App 🚀

[![GitHub Actions](https://img.shields.io/github/workflow/status/thieskoj/counter-app/CI%2FCD%20Docker%20Pipeline?label=CI/CD&logo=github&style=flat-square)](https://github.com/thieskoj/counter-app/actions)
[![Docker](https://img.shields.io/badge/docker-ready-blue?logo=docker&style=flat-square)](https://hub.docker.com/r/thieskoj/counter-app)
[![Snyk](https://img.shields.io/badge/Snyk-secured-brightgreen?logo=snyk&style=flat-square)](https://snyk.io/)
[![SonarCloud](https://img.shields.io/badge/Quality%20Gate-passing-brightgreen?logo=sonarcloud&style=flat-square)](https://sonarcloud.io/)

A simple Python Flask web service that maintains a persistent counter, containerized with Docker, automatically deployed to AWS EC2 via GitHub Actions CI/CD.  

---

## Quick Start ⚡

1. Go to the [Actions tab](https://github.com/thieskoj/counter-app/actions) in this repository.  
2. Select the **CI/CD Docker Pipeline** workflow.  
3. Click **Run workflow** and choose the **development** branch.  
4. Once the workflow completes, your dev environment will be deployed to the configured EC2 instance.  
5. Access the app in your browser via the EC2 public IP: http://<EC2_PUBLIC_IP>


## Table of Contents

- [Features](#features)  
- [Architecture](#architecture)  
- [Prerequisites](#prerequisites)  
- [Local Development](#local-development)  
- [Docker](#docker)  
- [Deployment](#deployment)  
- [CI/CD Pipeline](#cicd-pipeline)  
- [Environment Variables](#environment-variables)  
- [Contributing](#contributing)  
- [License](#license)  

---

## Features

- Flask-based counter service  
- Persistent storage on host volume `/data`  
- Production-ready deployment with **Gunicorn**  
- Security scans integrated with **Snyk** and **SonarCloud**  
- CI/CD automation for build, tag, push, and deploy  
- Multi-stage Dockerfile for smaller runtime image  

---

## Architecture

GitHub Actions CI/CD
│
▼
Docker Build & Push ──> AWS ECR
│
▼
EC2 Deployment
│
▼
Flask App (Gunicorn)


---

## Prerequisites

- Python 3.12+  
- Docker & Docker Compose  
- AWS Account with ECR and EC2  
- GitHub repository with Actions enabled  

---

## Local Development

```bash
git clone git@github.com:thieskoj/counter-app.git
cd counter-app

# Optional: use virtual environment
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Run locally
export COUNTER_FILE=./data/counter.txt
python counter-app.py

# Access at http://localhost:8080
```
http://localhost:8080

```

Docker
Build and run locally:
```bash
docker build -t counter-app:dev .
docker run -d -p 8080:8080 -v $(pwd)/data:/data counter-app:dev
```
Using Docker Compose:
```bash docker-compose up -d
```

App available at:

http://localhost:8080

Deployment
GitHub Actions CI/CD

Development branch:
Non-blocking Snyk/ Sonar scans, pushes Docker image to ECR, deploys to EC2.

Main branch:
Critical Snyk gate (blocking), manual approval required for production EC2 deployment.

AWS EC2 Deployment

Container runs with persistent volume /data

Public IP + mapped port exposes the app in the browser

Environment Variables
Name	Description
COUNTER_FILE	Path to persistent counter file
EC2_HOST	EC2 public IP for deployment
EC2_USER	SSH user (e.g., ubuntu)
EC2_PEM_KEY	SSH private key
AWS_REGION	AWS region for ECR and OIDC
SNYK_TOKEN	Token for Snyk security scanning
SONAR_TOKEN	Token for SonarCloud scanning
CI/CD Pipeline

Automatic semantic versioning (v0.0.X)

Multi-stage Docker builds

Push to AWS ECR

Runs Snyk and SonarCloud security/quality scans

Deploys to EC2 development and production environments

Contributing

Contributions are welcome!
Fork the repo, create a branch, and submit a pull request.

License

MIT License. See LICENSE
 for details.

 ```

---

✅ This version highlights the CI/CD status, Docker readiness, security scan results, and makes your repo more professional-looking with badges.

If you want, I can **also add a “Getting Started” section with a one-liner to deploy the dev environment using GitHub Actions** so newcomers can try the app immediately.  

Do you want me to add that?
```