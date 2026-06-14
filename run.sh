#!/bin/bash

if [ "$1" = "build_generator" ]; then
    docker build -t data-generator ./generator

elif [ "$1" = "run_generator" ]; then
    mkdir -p "$(pwd)/data"
    docker run --rm -v "$(pwd)/data:/data" data-generator

elif [ "$1" = "create_local_data" ]; then
    mkdir -p "$(pwd)/local_data"
    python3 ./generator/generate.py "$(pwd)/local_data"

elif [ "$1" = "build_reporter" ]; then
    docker build -t data-reporter ./reporter

elif [ "$1" = "run_reporter" ]; then
    docker run --rm -v "$(pwd)/data:/data" data-reporter

elif [ "$1" = "structure" ]; then
    ls -R

elif [ "$1" = "clear_data" ]; then
    rm -f "$(pwd)/data/"*.csv "$(pwd)/data/"*.html
    echo "Директория data/ очищена"

elif [ "$1" = "inside_generator" ]; then
    docker run --rm --entrypoint sh -v "$(pwd)/data:/data" data-generator -c "ls -la /data"

elif [ "$1" = "inside_reporter" ]; then
    docker run --rm --entrypoint sh -v "$(pwd)/data:/data" data-reporter -c "ls -la /data"

elif [ "$1" = "report_server" ]; then
    echo "Запуск сервера Python на порту 8000..."
    docker run --rm -d --name hw3-report-server -p 8000:8000 -v "$(pwd)/data:/data" -w /data python:3.12-slim python -m http.server 8000
    echo "Сервер поднят! Сделайте порт 8000 публичным в Codespaces."

elif [ "$1" = "stop_server" ]; then
    docker stop hw3-report-server
    docker rm hw3-report-server
    echo "Сервер остановлен."

else
    echo "Ошибка: введите правильную команду."
fi