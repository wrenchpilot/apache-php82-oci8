# Apache PHP 8.2 with OCI8

This project provides a Dockerized environment for running PHP 8.2 with Apache and the Oracle OCI8 extension.

[![Build Docker Image](https://github.com/wrenchpilot/apache-php82-oci8/actions/workflows/docker-image.yml/badge.svg)](https://github.com/wrenchpilot/apache-php82-oci8/actions/workflows/docker-image.yml)

## Features

- PHP 8.2 with Apache
- Oracle Instant Client (Basic, SQLPlus, and SDK)
- OCI8 extension installed via PECL
- Configurable Oracle environment variables
- Apache mod_rewrite enabled

## Prerequisites

- Docker and Docker Compose installed on your system
- Oracle database credentials (if connecting to a database)

## Usage

1. Clone this repository:

   ```bash
   cd apache-php82-oci8
   ```

2. Start the Docker container:

   ```bash
   docker build -t apache-php82-oci8 .
   docker compose up -d
   ```

3. Place your PHP application files in the `/opt/html` directory on your host machine. These will be mapped to `/var/www/html` in the container.

4. Access the application in your browser at `http://localhost`.

## Configuration

- The `docker-compose.yaml` file maps the host directory `/opt/html` to the container's `/var/www/html`. Update this path if needed.
- Oracle environment variables are set in the Dockerfile. Modify them if required.

## Stopping the Container

To stop the container, run:

```bash
docker compose down
```

## Troubleshooting

- Ensure the Oracle Instant Client RPMs are accessible and the URLs in the Dockerfile are valid.
- Check the container logs for errors:

  ```bash
  docker logs apache-php82-oci8
  ```
