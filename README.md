> **Note:** I am fully aware that granting root access and exposing the Docker socket inside a CI container is a major security anti-pattern for Production environments.

Initially, this project used an isolated TCP proxy (`socat`) to route Docker commands. However, TCP proxies often struggle with buffering long-running stream connections (such as `docker exec` commands used by Ansible under the hood), leading to dropped payloads and pipeline failures. I made a conscious engineering decision to switch to **DooD** specifically for this local sandbox to ensure 100% pipeline stability.

# Local Jenkins CI/CD Environment

This repository contains the infrastructure-as-code setup to spin up a fully functional, containerized Jenkins server on a local machine. It is designed to provide a robust sandbox for developing, testing, and running advanced CI/CD pipelines.

## Architecture Overview

The environment is orchestrated using Docker Compose and provides a ready-to-use CI/CD platform:

* **Custom Jenkins Controller:** A custom Jenkins image running the CI server and UI (including Blue Ocean). It is pre-packaged with essential DevOps tools (`docker`, `docker-compose`, `buildx`, `ansible`, `sshpass`) so it can act as a powerful control node right out of the box.
* **Docker out of Docker (DooD):** The Jenkins container is connected directly to the host machine's Docker daemon via a socket mount (`/var/run/docker.sock`). This allows Jenkins pipelines to natively execute container builds and orchestrate infrastructure using the host's resources.

## Security & Architecture Notes

This repository is strictly optimized for a **local development laboratory**. To achieve maximum stability for complex pipeline executions, specific architectural trade-offs were made.

### 1. Why DooD (Docker-out-of-Docker)?
In this setup, Jenkins runs as the `root` user and mounts the host's `/var/run/docker.sock`. 

**How I would implement this in a Production environment:**
* Use ephemeral pod agents in Kubernetes (Jenkins Kubernetes Plugin).
* Use an isolated Docker daemon setup (DinD - `docker:dind` with TLS certificates).
* Use daemonless build tools like Kaniko or Buildah.

### 2. Local Network Protection
Because the Jenkins container has access to the host's Docker socket, exposing it on a public network (like university Wi-Fi) is extremely dangerous. To mitigate this risk, the `docker-compose.yml` explicitly binds the Jenkins ports to the local loopback interface (`127.0.0.1:8080:8080`). This ensures the Jenkins UI is completely invisible to the external network, keeping the host machine secure.

## Prerequisites & Usage

* **Docker and Docker Compose** installed on your local machine.
* Run `docker compose up -d` to build and start the Jenkins environment.
* To receive external webhooks (e.g., from GitHub) while keeping the host secure, use a tunneling service like `ngrok` or `localtunnel` pointing to your `localhost:8080`.