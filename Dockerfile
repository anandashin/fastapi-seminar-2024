# syntax=docker/dockerfile:1
FROM python:3.11

WORKDIR /src

RUN curl -sSL https://install.python-poetry.org | python3 - --version 1.5.1
RUN apt update && apt install -y default-libmysqlclient-dev && apt clean

COPY pyproject.toml poetry.lock ./
RUN poetry install --no-dev && rm -rf /root/.cache/pypoetry /root/.cache/pip

COPY wapang ./wapang
COPY .env.local ./

CMD ["poetry", "run", "uvicorn", "wapang.main:app", "--host", "0.0.0.0", "--port", "8000"]