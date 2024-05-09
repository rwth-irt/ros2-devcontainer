# Good minimal starting point from Allison Thackston, which includes dev tools like curl, cmake, git, ros-dev-tools, ...
# FROM althack/ros2:humble-dev 
# If you need GUIs and Gazebo
FROM althack/ros2:humble-full
# If you need CUDA use
# FROM althack/ros2:humble-cuda-dev
# CUDA support, Gazebo, and GUIs
# FROM althack/ros2:humble-cuda-full

# Uncomment to add your own additional packages
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get update \
#   && apt-get -y install --no-install-recommends <your-package> \
#   # Clean up
#   && apt-get autoremove -y \
#   && apt-get clean -y \
#   && rm -rf /var/lib/apt/lists/*
# ENV DEBIAN_FRONTEND=dialog

# Last build steps
# Set up auto-source of workspace for ros user
ARG WORKSPACE
RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/ros/.bashrc
