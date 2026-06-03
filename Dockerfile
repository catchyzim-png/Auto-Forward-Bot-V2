FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install --no-cache-dir -U pip && \
    pip3 install --no-cache-dir -U -r requirements.txt

# --- HUGGING FACE COMPATIBILITY ADDITIONS ---
# Expose the mandatory port Hugging Face listens to
EXPOSE 7860

# Create a non-root user and grant permissions to /app 
# (Hugging Face strictly prefers non-root execution containers)
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH
# --------------------------------------------

# Copy the rest of the application code
COPY --chown=user . .

# Command to run the bot
CMD ["python3", "main.py"]
