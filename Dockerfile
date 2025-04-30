# Use a minimal base image with build tools
FROM ubuntu:22.04

# Set environment variables to avoid interaction during install
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    wget \
    unzip \
    zlib1g-dev \
    libtbb-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory to the HISAT2 repo (assumes this Dockerfile is in the root of the repo)
WORKDIR /hisat2

# Copy the local hisat2 codebase into the container
COPY . /hisat2

# Compile HISAT2
RUN make

# Add the binary location to PATH
ENV PATH="/hisat2:${PATH}"

# Default command to show version
CMD ["hisat2", "--version"]