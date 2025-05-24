# Apache PHP 8.2 with OCI8

This project provides a Dockerized environment for running PHP 8.2 with Apache and the Oracle OCI8 extension.

[![Build Docker Image](https://github.com/wrenchpilot/apache-php82-oci8/actions/workflows/docker-image.yml/badge.svg)](https://github.com/wrenchpilot/apache-php82-oci8/actions/workflows/docker-image.yml)

## Features

- PHP 8.2 with Apache
- Oracle Instant Client 19.3.0.0.0 (Basic, SQLPlus, and SDK)
- OCI8 extension installed via PECL (3.4.0)
- Configurable Oracle environment variables
- Apache mod_rewrite enabled

## Prerequisites

- Docker and Docker Compose installed on your system
- Oracle database credentials (if connecting to a database)

## Usage

1. Clone this repository:

   ```bash
   git clone https://github.com/your-user/apache-php82-oci8.git
   cd apache-php82-oci8
   ```

2. Build the image (default Oracle client version 19.3):

   ```bash
   docker build -t apache-php82-oci8 .
   ```

3. (Optional) Build with a custom Oracle client version:

   ```bash
   docker build \
     --build-arg ORACLE_CLIENT_VERSION=19.20.0.0.0 \
     -t apache-php82-oci8:19.20 .
   ```

4. Start the container:

   ```bash
   docker compose up -d
   ```

5. For production use, place your PHP application files in the `/opt/html` directory on your host machine. These will be mapped to `/var/www/html` in the container.

## Configuration

- The `docker-compose.yaml` file maps the host directory `/opt/html` to the container's `/var/www/html`. Update this path if needed.
- Oracle environment variables are set in the Dockerfile. Modify them if required, and use the `ORACLE_CLIENT_VERSION` build argument to choose a different version.

## Stopping the Container

To stop the container, run:

```bash
docker compose down
```

## Testing OCI

- Edit `oci.php` to include your Oracle database credentials by setting the `$HOST`, `$SID`, `$USERNAME`, and `$PASSWORD` variables at the top of the file.
- Access the script by navigating to [http://localhost/oci.php](http://localhost/oci.php) in your web browser.

## Troubleshooting

- Check the container logs for errors:

  ```bash
  docker logs apache-php82-oci8
  ```

## Versions

- PHP Info Screenshot:

  ![PHP Info](screenshots/01-php.png)

- OCI8 Extension Screenshot:

  ![OCI8 Extension](screenshots/02-oci.png)
