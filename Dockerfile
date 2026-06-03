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

# --- HUGGING FACE SECURITY CONSTRAINTS ---
# Set default environment port for main.py to read
ENV PORT=7860
EXPOSE 7860

# Create a non-root user for safe execution environment
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH
# ----------------------------------------

# Copy the rest of the application code with proper permissions
COPY --chown=user . .

# Command to run the bot
CMD ["python3", "main.py"]
