# Use lightweight Python base
FROM python:3.10-slim

# Set work directory
WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Expose port
EXPOSE 8080

# Run app with Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
