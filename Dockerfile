FROM python:3-alpine
WORKDIR /app

# Install dependencies
RUN apk update && apk add python3-dev gcc libffi-dev libc-dev

# Create a python3 virtualenv
RUN python3 -m venv pythonvenv

# Restore packages using pip
COPY ./requirements.txt .
RUN ./pythonvenv/bin/pip3 install -r ./requirements.txt

# Copy source files
COPY . .

# Start the bot
CMD ["pythonvenv/bin/python3", "./start-bot.py"]
