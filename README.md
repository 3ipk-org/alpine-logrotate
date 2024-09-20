# Logrotate Docker Image Based on Alpine

This repository provides a Docker image for managing log rotation using `logrotate` and `cron` on an Alpine Linux base.

## Pulling the Image

To pull the Docker image, use the following command:

```bash
docker pull ghcr.io/3ipk-org/alpine-logrotate:latest
```

## Usage

You can run the Docker container using the following command.

Example:
```bash
docker run -d \
  --name logrotate \
  -e LOG_DIR="/fluent-bit/logs" \
  -e LOGROTATE_CONF="/etc/logrotate.d/fluent-bit" \
  -e CRON_LOG="/var/log/cron.log" \
  -e LOGROTATE_CONF_CONTENT="/fluent-bit/logs/*.log {\n  daily\n  missingok\n  compress\n  delaycompress\n  notifempty\n  create 0640 root root\n  sharedscripts\n  postrotate\n    rm -f /fluent-bit/logs/*.log\n    echo \"Logs deleted from /fluent-bit/logs\" >> /var/log/cron.log\n  endscript\n}" \
  -v fluent-bit-logs:/fluent-bit/logs \
  ghcr.io/3ipk-org/alpine-logrotate:latest
```

### Environment Variables

The following environment variables can be set to customize the behavior of the container:

- `LOG_DIR`: The directory where logs are stored. Default is `/fluent-bit/logs`.
- `LOGROTATE_CONF`: The path for the logrotate configuration file. Default is `/etc/logrotate.d/my-logs`.
- `CRON_LOG`: The path for the cron log file. Default is `/var/log/cron.log`.
- `LOGROTATE_CONF_CONTENT`: The logrotate configuration content, defined as a multi-line string.

## License

This project is licensed under the [MIT License](LICENSE).
