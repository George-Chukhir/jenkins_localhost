# Local Jenkins CI/CD Environment

This repository contains the infrastructure-as-code setup to spin up a fully functional, containerized Jenkins server on a local machine. It is designed to provide a robust sandbox for developing, testing, and running advanced CI/CD pipelines.

## Architecture
The environment is orchestrated using Docker and consists of two main containers communicating over a dedicated custom Docker network:

1. **Jenkins Controller:** The primary container running the Jenkins server, UI (including Blue Ocean), and pipeline execution engine. It comes pre-configured with the necessary tools to interact with Docker.
2. **Docker Daemon (DinD) / Socket:** A secondary service (or mounted socket) that provides Docker daemon capabilities to the Jenkins container. This allows Jenkins pipelines to securely execute `docker build`, `docker push`, and `docker compose` commands internally.
3. **Custom Network:** A dedicated bridge network ensuring isolated and secure communication between Jenkins and the Docker daemon.

**Prerequisites:**
* Docker and Docker Compose installed on your local machine.

