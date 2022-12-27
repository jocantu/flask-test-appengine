FROM python:3.10-slim-bullseye
RUN  apt-get update
RUN apt-get -y install libpq-dev gcc
COPY requirements.txt ./requirements.txt
RUN python -m pip install -r requirements.txt --no-cache-dir

# Allow statements and log messages to immediately appear in the Knative logs

# Copy local code to the container image.
ENV APP_HOME /
ENV GOOGLE_APPLICATION_CREDENTIALS=./dulcet-bucksaw-347721-d0151f3efb60.json
ENV PYTHONUNBUFFERED True

ADD . /

RUN groupadd -r app && useradd -r -g app app


EXPOSE 8080
CMD gunicorn -b :8080 main.py