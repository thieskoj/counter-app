# -------- BUILD STAGE --------
FROM python:3.12-slim AS build

WORKDIR /app

# Install build dependencies only here
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# -------- RUNTIME STAGE --------
FROM python:3.12-slim

WORKDIR /app

# Copy only what is needed at runtime
COPY --from=build /usr/local/lib/python3.12 /usr/local/lib/python3.12
COPY --from=build /usr/local/bin /usr/local/bin

COPY . .

# Security hardening
RUN useradd -m appuser
USER appuser

EXPOSE 8080
CMD ["gunicorn", "counter_app:app", "--bind=0.0.0.0:8080"]