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

# Copy only app source and dependencies
COPY --from=build /usr/local/lib/python3.12 /usr/local/lib/python3.12
COPY --from=build /usr/local/bin /usr/local/bin
COPY . .

# Create data directory and give permissions
RUN mkdir -p /data && chown -R 10001:10001 /data

# Add non-root user
RUN useradd -u 10001 -m appuser
USER appuser

ENV COUNTER_FILE=/data/counter.txt

EXPOSE 8080

# Flask app must be named counter_app.py with `app = Flask(__name__)`
CMD ["gunicorn", "counter_app:app", "--bind=0.0.0.0:8080", "--workers=4", "--access-logfile=-", "--error-logfile=-"]
