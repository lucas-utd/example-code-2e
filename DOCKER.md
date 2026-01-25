# Docker Setup for Fluent Python 2e Example Code

This project includes Docker configuration for easy setup and execution of the Fluent Python 2e example code.

## Files

- **Dockerfile**: Main Docker image definition with Python 3.11 and all required dependencies
- **docker-compose.yml**: Docker Compose configuration for running containers
- **.dockerignore**: Specifies files to exclude from Docker build context

## Quick Start

### Using Docker Compose (Recommended)

#### Run the Python development environment:
```bash
docker compose up -d python-learning
docker compose exec python-learning bash
```

#### Run Jupyter Notebook for interactive learning:
```bash
docker compose up -d jupyter
# Access at http://localhost:8888
```

### Using Docker directly

#### Build the image:
```bash
docker build -t python-learning:latest .
```

#### Run a container:
```bash
docker run -it --rm -v $(pwd):/workspace python-learning:latest bash
```

#### Run tests:
```bash
docker run -it --rm -v $(pwd):/workspace python-learning:latest pytest
```

#### Run specific doctest:
```bash
docker run -it --rm -v $(pwd):/workspace python-learning:latest \
    python3 -m doctest 01-data-model/frenchdeck.doctest -v
```

## Available Tools in Container

- **Python 3.11**: Base Python environment
- **pytest**: Testing framework with doctest module support
- **ruff**: Fast Python linter
- **mypy**: Static type checker
- **jupyter**: Interactive notebook environment
- **ipython**: Interactive Python shell
- **git**: Version control system

## Environment Variables

- `PYTHONUNBUFFERED=1`: Unbuffered output (better logging)
- `PYTHONDONTWRITEBYTECODE=1`: Prevents .pyc file generation
- `PIP_NO_CACHE_DIR=1`: Reduces image size

## Running Tests

```bash
# All tests with doctest modules
docker compose exec python-learning pytest

# Run tests in specific chapter
docker compose exec python-learning pytest 01-data-model/

# Run with nbval for Jupyter notebooks
docker compose exec python-learning pytest --nbval
```

## Interactive Development

```bash
# Start container
docker compose up -d python-learning

# Execute commands
docker compose exec python-learning python3 01-data-model/frenchdeck.py

# Shell access
docker compose exec python-learning bash

# IPython REPL
docker compose exec python-learning ipython

# Stop container
docker compose down
```

## Notes

- All chapter-specific requirements (from `*/requirements.txt`) are automatically installed during build
- The working directory is `/workspace` where the project files are mounted
- Use `--rm` flag with `docker run` to automatically remove container after exit
- For persistent development, use Docker Compose which manages container lifecycle better
