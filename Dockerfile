FROM python:3.9-slim

WORKDIR /app

# Install only build tools needed for scipy, scikit-learn, xgboost, etc.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gfortran \
    liblapack-dev \
    libblas-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
