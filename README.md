# Комментарии к выполненыым заданиям

## Task1 - Ansible

- В качестве inventory был использован облачный сервер на ОС Debian 12, под которую и был написан playbook. Тестирование на данном севере прошло успешно
- Playbook использует роль `nginx`, выполняющую все необходимые шаги, предусмотренные условием
- Для серверов Ubuntu была написана роль для удаления предустановленного веб-сервера Apache — `delete_apache`. Необходимость использования `delete_apache` возникает из-за конфликта Apache и Nginx на порту 80
- Сертификаты для сервера были сгенерированы локально, помещены в `files` и скопированы на сервер. Однако имелась идея использования шаблона скрипта, выполняющего генерацию сертификата при его отсутствии непосредственно на сервере. В демонстрационных целях шаблон помещен в `templates`
- Импровизированная страница `index.html` копировалась на сервер и использовалась как индикатор успешной настройки
- Скрипт `run_playbook.sh` для удобного запуска playbook

Структура проекта:
```
task1_ansible/
├── playbook.yaml
├── inventory.yaml
├── ansible.cfg
├── run_playbook.sh
└── roles/
    ├── nginx/
    │   ├── tasks/
    │   │   └── main.yaml
    │   ├── templates/
    │   │   ├── nginx.conf.j2
    │   │   └── cert_issue.sh.j2
    │   ├── vars/
    │   │   └── main.yaml
    │   ├── defaults/
    │   │   └── main.yaml
    │   └── files/
    │       ├── index.html
    │       ├── cert.crt
    │       └── cert.key
    └── delete_apache/
        └── tasks/
            └── main.yaml
```
Скриншот и лог выполнения playbook в репозитории под именами `ansible_success_screenshot.png` и `ansible.log` соответственно.

## Task2 - Docker

curl -vk https://localhost:443 &> result.txt