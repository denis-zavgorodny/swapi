FROM python:2.7

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y sqlite3
RUN apt install -y libmemcached-dev zlib1g-dev libssl-dev

COPY . .
COPY requirements.txt ./
RUN pip install -r requirements.txt
RUN pip install psycopg2-binary

RUN make install
RUN make build
RUN make load_data

EXPOSE 8000

CMD [ "make", "serve" ]
