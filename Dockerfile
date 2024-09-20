FROM alpine:latest
MAINTAINER Anatoliy Kotsur <akotsur@3ipk.com>
LABEL maintainer "Anatoliy Kotsur <akotsur@3ipk.com>"

# Install necessary packages: cron, logrotate, and bash (for scripting)
RUN apk add --no-cache \
    logrotate \
    dcron \
    bash

# Create directories for logrotate configuration and cron jobs
RUN mkdir -p /etc/logrotate.d /etc/cron.d /var/log

# Copy the custom entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Define the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

