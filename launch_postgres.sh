#!/bin/bash

# Путь к файлу .env
ENV_FILE=.env

# Проверяем, существует ли файл .env
if [ ! -f "$ENV_FILE" ]; then
  echo "Ошибка: Файл .env не найден."
  exit 1
fi

# Чтение переменных из файла .env
export $(grep -v '^#' $ENV_FILE | xargs)

# Запуск контейнера с PostgreSQL
docker run -d \
  --name my_postgres_container \
  -e POSTGRES_USER=$DB_USER \
  -e POSTGRES_PASSWORD=$DB_PASS \
  -e POSTGRES_DB=$DB_NAME \
  -e POSTGRES_HOST=$DB_HOST \
  -e POSTGRES_PORT=$DB_PORT \
  -p $DB_PORT:5432 \
  postgres:latest

# Проверяем статус контейнера
docker ps -a --filter "name=my_postgres_container"
