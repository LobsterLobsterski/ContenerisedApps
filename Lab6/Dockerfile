# Use official Docker image with Docker CLI
FROM docker:20.10

# Install required tools
RUN apk add --no-cache git bash

# Copy the script
COPY builder.sh /usr/local/bin/builder.sh

# Set permissions
RUN chmod +x /usr/local/bin/builder.sh

# Define ENTRYPOINT
ENTRYPOINT ["builder.sh"]
