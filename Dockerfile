FROM python:3.12-slim AS builder

# Install uv directly from the official image binary
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory and configure uv optimizations
WORKDIR /app
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

# Copy dependency configuration files first to leverage Docker caching layers
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project --no-dev


FROM python:3.12-slim

WORKDIR /app

# Copy the pre-compiled 3.12 virtual environment directly from the builder stage
COPY --from=builder /app/.venv /app/.venv

# Copy your local application source code files into the container image
COPY app ./app
COPY artifacts ./artifacts
COPY main.py main.py

# Place the virtual environment's executable paths at the front of the system PATH
ENV PATH="/app/.venv/bin:$PATH"

# Expose the network port Litestar runs on internally
EXPOSE 8000

# Spin up the Uvicorn production server on container launch
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]