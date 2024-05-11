# Good minimal starting point from Allison Thackston, which includes dev tools like curl, cmake, git, ros-dev-tools, ...
# FROM althack/ros2:humble-dev 
# If you need rqt GUIs & RViz 
FROM althack/ros2:humble-full
# If you need CUDA use
# FROM althack/ros2:humble-cuda-dev
# CUDA support, Gazebo, and GUIs
# FROM althack/ros2:humble-cuda-full

# Add your own additional packages
ENV DEBIAN_FRONTEND=noninteractive

# Use latest Mesa drivers for best WSL support
RUN add-apt-repository ppa:oibaf/graphics-drivers \
  && apt-get update \
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

# Gazebo Garden required for WSL support, Fortress throws OpenGL errors
RUN wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null \
  && apt-get update \
  && apt-get install -y ros-$ROS_DISTRO-ros-gzgarden \
  # Clean up
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=dialog

# Last build steps
# Set up auto-source of workspace for ros user
ARG WORKSPACE
RUN echo "if [ -f /workspace/install/setup.bash ]; then source /workspace/install/setup.bash; fi" >> /home/ros/.bashrc
