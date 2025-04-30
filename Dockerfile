FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    wget \
    unzip \
    zlib1g-dev \
    libtbb-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /hisat2

COPY . /hisat2

# Remove incompatible flags for ARM64 (e.g., Apple Silicon or AWS Graviton)
RUN if [ "$(uname -m)" = "aarch64" ]; then \
        sed -i 's/-m32//g' Makefile && \
        sed -i 's/-msse2//g' Makefile ; \
    fi

RUN make

ENV PATH="/hisat2:${PATH}"

CMD ["hisat2", "--version"]
