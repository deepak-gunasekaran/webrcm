# Docker Setup Guide

## Overview

This web application has been containerized using Docker. Both a Dockerfile and docker-compose configuration are provided for flexible deployment options.

## Prerequisites

- Docker: [Install Docker Desktop](https://www.docker.com/products/docker-desktop)
- Docker Compose: Included with Docker Desktop

## Building and Running

### Option 1: Using Docker CLI

#### Build the image:
```bash
docker build -t webrcm:latest .
```

#### Run the container:
```bash
docker run -p 3000:3000 webrcm:latest
```

Then open your browser to `http://localhost:3000`

### Option 2: Using Docker Compose (Recommended)

#### Start the application:
```bash
docker-compose up
```

This will automatically build and run the container. The app will be available at `http://localhost:3000`

#### Start in detached mode:
```bash
docker-compose up -d
```

#### Stop the application:
```bash
docker-compose down
```

#### Rebuild without cache:
```bash
docker-compose up --build --no-cache
```

## Project Structure

- **Dockerfile**: Multi-stage build that compiles the React + Vite application and serves it using Vite's preview server
  - Stage 1: Builds the app with Node dependencies
  - Stage 2: Runs the optimized production build

- **.dockerignore**: Specifies files/folders to exclude from the Docker build context

- **docker-compose.yml**: Orchestrates the Docker container setup with environment variables and port mapping

## Environment Configuration

To modify settings, edit `docker-compose.yml`:
- **Port**: Change the first port in `ports: - "3000:3000"` to expose on a different port
- **Environment Variables**: Add or modify the `environment` section

Example for custom port:
```yaml
ports:
  - "8080:3000"  # Access on http://localhost:8080
```

## Troubleshooting

**Port already in use:**
```bash
# Change the exposed port in docker-compose.yml, or use:
docker run -p 8080:3000 webrcm:latest
```

**Clear cached layers:**
```bash
docker-compose up --build --no-cache
```

**View logs:**
```bash
# With docker-compose
docker-compose logs -f

# With Docker CLI
docker logs <container-id>
```

**Remove all images and containers:**
```bash
docker system prune -a
```

## Development

For local development without Docker:
```bash
pnpm install
pnpm run dev     # Start development server on http://localhost:5173
pnpm run build   # Build for production
```

## Notes

- The Dockerfile uses Alpine Linux for a lightweight image (~400MB)
- The multi-stage build optimizes image size by excluding build dependencies from the final image
- The application serves on port 3000 inside the container, mapped to port 3000 on your machine
