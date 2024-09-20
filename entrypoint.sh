#!/bin/sh

# Set default values for environment variables if not provided
LOG_DIR="${LOG_DIR:-/fluent-bit/logs}"
LOGROTATE_CONF="${LOGROTATE_CONF:-/etc/logrotate.d/my-logs}"
CRON_LOG="${CRON_LOG:-/var/log/cron.log}"

# Create directories if they do not exist
mkdir -p "$LOG_DIR"
mkdir -p "$(dirname "$LOGROTATE_CONF")"
mkdir -p "$(dirname "$CRON_LOG")"

# Ensure cron log file exists
touch "$CRON_LOG"

# Start crond
crond

# Write the custom logrotate configuration to the specified location
# You can either pass this as a volume or through environment variables
echo "$LOGROTATE_CONF_CONTENT" > "$LOGROTATE_CONF"

# Fix permissions of the log directory to avoid logrotate permission errors
chmod 755 "$LOG_DIR"

# Run logrotate with the provided configuration
logrotate -f "$LOGROTATE_CONF"

# Keep the container running and tail the cron log
tail -f "$CRON_LOG"
