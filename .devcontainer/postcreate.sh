setup rosdep and install workspace dependencies
sudo apt-get update
rosdep update
rosdep install --from-paths src -i -r -y
# Check rendering support
glxinfo | grep 'OpenGL render'