# Use official Python runtime as base image
FROM python:3.11-slim

# Set metadata
LABEL maintainer="Python Learning"
LABEL description="Docker image for Fluent Python 2e example code"

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Set working directory
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /workspace/

# Install Python development tools and project dependencies
RUN pip install --upgrade pip setuptools wheel && \
    pip install 'pytest<8.0' 'nbval<0.10' ruff mypy jupyter ipython

# Install any chapter-specific requirements
RUN for req_file in */requirements.txt; do \
        if [ -f "$req_file" ]; then \
            pip install -r "$req_file"; \
        fi; \
    done

# Set default command to bash shell
CMD ["/bin/bash"]
