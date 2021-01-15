#!/bin/bash
source /etc/profile.d/ros/setup.bash && source /etc/profile.d/ros/local_setup.bash && QT_QPA_PLATFORM="wayland" XDG_RUNTIME_DIR="/run/user/0" ros2 run turtlesim turtlesim_node