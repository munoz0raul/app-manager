#!/bin/bash

while getopts a:f: flag
do
    case "${flag}" in
        a) app=${OPTARG};;
        f) function=${OPTARG};;
    esac
done
echo "App: $app";
echo "Function: $function";

case "$function" in
      start)
          echo "Adding App:$app on /etc/sota/conf.d/z-91-my-local-app-overrides.toml"
          echo "s/\",/\",$app,/g"
          sed -i -e "s/\",/\",$app,/g" /etc/sota/conf.d/z-91-my-local-app-overrides.toml
          echo "Restarting aktualizr-lite"
          systemctl restart aktualizr-lite
          sleep 1
          XDG_RUNTIME_DIR="/run/user/0" /usr/bin/weston-terminal --font-size=20 --shell="$PWD/journalctl.sh" &
          ;;
      stop)
          echo "Removing App:$app on /etc/sota/conf.d/z-91-my-local-app-overrides.toml"
          sed -i -e "s/,$app,/,/g" /etc/sota/conf.d/z-91-my-local-app-overrides.toml
          echo "Restarting aktualizr-lite"
          systemctl restart aktualizr-lite
          ;;
      launch)
            echo "Launch $app"
            case "$app" in
               shellhttpd)
                    XDG_RUNTIME_DIR="/run/user/0" chromium --no-sandbox --user-data-dir=/home/root --in-process-gpu --start-maximized 127.0.0.1:8080 &
                    ;;
                nginx_logo)
                    XDG_RUNTIME_DIR="/run/user/0" chromium --no-sandbox --user-data-dir=/home/root --in-process-gpu --start-maximized 127.0.0.1:8010 &
                    ;;
                nginx_app)
                    XDG_RUNTIME_DIR="/run/user/0" chromium --no-sandbox --user-data-dir=/home/root --in-process-gpu --start-maximized 127.0.0.1:8011 &
                    ;;
                gin)
                    XDG_RUNTIME_DIR="/run/user/0" chromium --no-sandbox --user-data-dir=/home/root --in-process-gpu --start-maximized 127.0.1:3000 &
                    sleep 1
                    XDG_RUNTIME_DIR="/run/user/0" chromium --no-sandbox --user-data-dir=/home/root --in-process-gpu --start-maximized 127.0.1:1880 &
                    ;;
                aws-iotsdk)
                    XDG_RUNTIME_DIR="/run/user/0" chromium --no-sandbox --user-data-dir=/home/root --in-process-gpu --start-maximized https://app.devicepilot.com/#/dashboard?dashboard=eb44a4b0-4c15-11ea-ba6e-5bcdb6cd7a54&fullscreen=true &
                    ;;
                restreamer2)
                    XDG_RUNTIME_DIR="/run/user/0" chromium --no-sandbox --user-data-dir=/home/root --in-process-gpu --start-maximized 127.0.0.1:8092/images/live.jpg &
                    ;;
                python)
                    XDG_RUNTIME_DIR="/run/user/0" chromium --no-sandbox --user-data-dir=/home/root --in-process-gpu --start-maximized 127.0.0.1:3448 &
                    ;;
                code-server)
                    XDG_RUNTIME_DIR="/run/user/0" chromium --no-sandbox --user-data-dir=/home/root --in-process-gpu --start-maximized 127.0.0.1:3449 &
                    ;;
                facemask)
                    ;;
                ros)
                    XDG_RUNTIME_DIR="/run/user/0" /usr/bin/weston-terminal --font-size=20 --shell="$PWD/ros.sh" &
                    sleep 5
                    XDG_RUNTIME_DIR="/run/user/0" /usr/bin/weston-terminal --font-size=20 --shell="$PWD/ros_key.sh" &
                    ;;
                *)
                    ;;
        esac
        ;;
      *)
          echo 'error' >&2
          exit 1
esac

