#!/bin/bash

touch README.md

mkdir templates
mkdir static
mkdir static/css
mkdir static/img
mkdir static/js
mkdir media

# создаем виртуальное окружение для локальной разработки
poetry init --no-interaction

poetry add django=^5.0.2
poetry add gunicorn=^21.2.0
poetry add psycopg2-binary=^2.9.9
poetry add environs[django]=^10.3.0
poetry add django-allauth=^0.61.1
# poetry add django-debug-toolbar=^4.3.0

django-admin startproject config .
django-admin startapp users

# копирование стандартных файлов
# файлы докера
cp ./deploy/build/webapp/Dockerfile ./Dockerfile
cp ./deploy/build/webapp/docker-compose.yml ./docker-compose.yml

# настройки django-приложения
mv ./config/settings.py ./config/settings.py.old
cp ./deploy/conf/webapp/settings.py ./config/settings.py

# файлы модели users
rm ./users/admin.py
rm ./users/models.py
cp ./deploy/conf/webapp/users/admin.py ./users/admin.py
cp ./deploy/conf/webapp/users/forms.py ./users/forms.py
cp ./deploy/conf/webapp/users/models.py ./users/models.py

docker-compose up --build

# удаление самого скрипта
rm ./create.sh
