Скопировать директорию default_files и файл create.sh, запустить скрипт, все устанавливается.
Скрипт копирует файлы докера и заменяет файл settings.py и заменяет файлы у модели users (для регистрации в админке).

после запуска, несмотря на ошибки в логах из второй вкладки (или любым другим спопособом - не останавливая docker-compose) подключаемся к контейнеру, формируем и выполняем миграции:
    docker-compose exec web python3 manage.py makemirations
    docker-compose exec web python3 manage.py migrate




