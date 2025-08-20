FROM python:3-alpine
WORKDIR /app

# Install dependencies
RUN apk update && apk add python3-dev gcc libffi-dev libc-dev

# Create a python3 virtualenv
RUN python3 -m venv pythonvenv

# Restore packages using pip
COPY ./requirements.txt .
RUN ./pythonvenv/bin/pip3 install -r ./requirements.txt

ARG BUILD=DEV
ARG COMMIT_SHA
# Connects the container to the Github repository. See https://docs.github.com/en/packages/learn-github-packages/connecting-a-repository-to-a-package#connecting-a-repository-to-a-container-image-using-the-command-line
LABEL org.opencontainers.image.source=https://github.com/nozzlegear/discord-dynamic-voice-channels
LABEL org.opencontainers.image.revision=$COMMIT_SHA

# Copy source files
COPY . .

# Start the bot
CMD ["pythonvenv/bin/python3", "./start-bot.py"]
