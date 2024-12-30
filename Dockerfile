# syntax=docker/dockerfile:1
FROM python:3.11

WORKDIR /src

RUN pip install poetry
RUN apt update && apt install -y default-libmysqlclient-dev && apt clean

COPY pyproject.toml poetry.lock ./
RUN poetry install --no-dev

COPY wapang ./wapang
COPY .env.prod ./

CMD ["sh", "-c", "poetry run alembic upgrade head && poetry run uvicorn wapang.main:app --host 0.0.0.0 --port 8000"]