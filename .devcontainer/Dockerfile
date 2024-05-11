# Good minimal starting point from Allison Thackston, which includes dev tools like curl, cmake, git, ros-dev-tools, ...
# FROM althack/ros2:humble-dev 
# If you need rqt GUIs & RViz use -full suffix
# Addtionally, Gazebo is included with the suffix -gazebo  
FROM althack/ros2:humble-gazebo
# If you need CUDA use
# FROM althack/ros2:humble-cuda-dev
# CUDA support, Gazebo, and GUIs
# FROM althack/ros2:humble-cuda-full

# Add your own additional packages
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y \
  # Check if GUI and 3D acceleration works
  mesa-utils x11-apps \
  # Nice plots for debugging
  ros-$ROS_DISTRO-plotjuggler-ros \
  && apt-get upgrade -y \
  # Clean up
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=dialog

# Last build steps
# Set up auto-source of workspace for ros user
RUN echo "if [ -f /workspace/install/setup.bash ]; then source /workspace/install/setup.bash; fi" >> /home/ros/.bashrc
