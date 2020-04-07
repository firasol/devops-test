# base image
#FROM python:3.8.1-slim
FROM python:3.8.1

# install netcat
RUN apt-get update && \
    apt-get -y install netcat && \
    apt-get clean

# set working directory
WORKDIR /app

# add and install requirements.txt
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# add entrypoint.sh
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# add the app
COPY ./app.py /app/app.py

# expose port
EXPOSE 5000

# run the server
CMD [ "/app/entrypoint.sh" ]
