FROM python:3.10-slim-bullseye
RUN apt-get -y install libpq-dev gcc \
    && pip install psycopg2
COPY requirements.txt ./requirements.txt
RUN python -m pip install -r requirements.txt --no-cache-dir

# Allow statements and log messages to immediately appear in the Knative logs

# Copy local code to the container image.
ENV APP_HOME /
ENV GOOGLE_APPLICATION_CREDENTIALS=./flask-api-360315-649655781aa1.json
ENV PYTHONUNBUFFERED True
WORKDIR /
ADD . /

RUN groupadd -r app && useradd -r -g app app


EXPOSE 8080
CMD [ "python" , "./main.py" ]