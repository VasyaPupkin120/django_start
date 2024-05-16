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
rm db.sqlite
django-admin startapp users

# копирование стандартных файлов
# файлы докера
cp ./default_files/deploy/Dockerfile ./Dockerfile
cp ./default_files/deploy/docker-compose.yml ./docker-compose.yml
mkdir deploy
mkdir deploy/nginx
mkdir deploy/db
cp ./default_files/deploy/nginx/* ./deploy/nginx
cp ./default_files/deploy/db/* ./deploy/db

# настройки всего проекта
mv ./config/settings.py ./config/settings.py.old
cp ./default_files/config/settings.py ./config/settings.py

# файлы модели users
rm ./users/admin.py
rm ./users/models.py
cp ./default_files/users/admin.py ./users/admin.py
cp ./default_files/users/forms.py ./users/forms.py
cp ./default_files/users/models.py ./users/models.py

# удаление стандартных файлов
rm -r ./default_files/

docker-compose up --build

# удаление самого скрипта
rm ./create.sh
