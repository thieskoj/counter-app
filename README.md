## Counter App

A simple Python Flask application that increments and returns a counter value on each request.  
The app is containerized with Docker and designed for local development and deployment.

---

## 🚀 Features
- Flask-based REST API
- Counter persists using a mounted data volume
- Dockerized with Gunicorn for production-style serving
- Simple health and testing via `curl` or browser

---

## 📦 Tech Stack
- Python
- Flask
- Gunicorn
- Docker

---

## ▶️ Run Locally (Without Docker)

```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python counter-app.py

