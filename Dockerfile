
# FROM ubuntu:latest

# WORKDIR /usr/app/src
# ARG LANG="en_US.UTF-8"
# RUN apt-get update\
#     && apt-get install -y --no-install-recommends \
#         apt-utils \
#     # build-essential \
#     # curl \
#         locales \
#         python3-pip \
#         python3-yaml\
#         rsyslog systemd systemd-cron sudo\
#     && apt-get clean 

# RUN pip3 install -r requirements.txt
# RUN pip3 install streamlit
# # EXPOSE 8501
# COPY / ./


# CMD ["streamlit", "run", "app.py"]

FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/PrathamKumar125/AI-Plagiarism-Detetctor.git .

RUN pip3 install -r requirements.txt

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]