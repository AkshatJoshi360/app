# Stage 1: Build stage
FROM python:3.13-slim AS builder

WORKDIR /app

# Install build dependencies for mysqlclient
RUN apt-get update && \
    apt-get install -y build-essential default-libmysqlclient-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Stage 2: Production stage
FROM python:3.13-slim

WORKDIR /app

# Copy installed packages and app
COPY --from=builder /usr/local/lib/python3.13/site-packages /usr/local/lib/python3.13/site-packages
COPY --from=builder /app /app

# Expose port
EXPOSE 8000

# Run Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "4", "app:app"]
