# syntax=docker/dockerfile:1

# ARG for Python version
ARG PYTHON_VERSION=3.12.2
FROM python:${PYTHON_VERSION}-slim as base

# Python best practices
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Create non-root user
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

# Copy requirements first for caching
COPY requirements.txt .

# Install dependencies using cache mount for pip
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --no-cache-dir -r requirements.txt

# Create data directory and give ownership to appuser
RUN mkdir -p /data && chown appuser:appuser /data

# Switch to non-root user
USER appuser

# Copy application source code
COPY . .

# Environment variable for counter file
ENV COUNTER_FILE=/data/counter.txt

# Expose Flask port
EXPOSE 8080

# Run Flask app using Gunicorn (production-ready)
# The Flask app object must be named 'app' in counter-app.py
CMD ["gunicorn", "counter-app:app", "--bind=0.0.0.0:8080", "--access-logfile", "-", "--error-logfile", "-", "--workers=4"]
