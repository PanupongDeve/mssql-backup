FROM python:3.6-slim-jessie AS sqlgen

RUN apt-get update && apt-get install -y --force-yes --no-install-recommends freetds-bin sed libunwind8 libicu52 libssl1.0.0
RUN pip install --upgrade pip
RUN pip install mssql-scripter
ENTRYPOINT ["mssql-scripter"]
