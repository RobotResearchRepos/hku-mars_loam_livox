FROM osrf/ros:melodic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y git \
 && rm -rf /var/lib/apt/lists/*

# apt packages
RUN apt-get update \
 && apt-get install -y libceres-dev \
 && rm -rf /var/lib/apt/lists/*
 
# Code repository

RUN mkdir -p /catkin_ws/src/

RUN git clone https://github.com/Livox-SDK/livox_ros_driver /catkin_ws/src/livox_ros_driver

RUN git clone --recurse-submodules \
      https://github.com/RobotResearchRepos/hku-mars_loam_livox \
      /catkin_ws/src/loam_livox

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && apt-get update \
 && rosdep install -r -y \
     --from-paths /catkin_ws/src \
     --ignore-src \
 && rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && cd /catkin_ws \
 && catkin_make
 
 
