#
# Build stage
# ------------------------
FROM athackst/ros:kinetic-dev as builder

WORKDIR /workspaces/deepracer_ws/src
RUN git clone https://github.com/athackst/deepracer_joy.git \
  && git clone https://github.com/athackst/aws_deepracer_msgs.git \
  # Get all of the dependent packages.
  # This ensures that the base image will have all dependencies.
  && apt-get update && rosdep update \
  && rosdep keys --from-path . --ignore-src | xargs rosdep resolve | grep -v "#" > /packages.txt \
  && cat /packages.txt | xargs sudo apt-get install -y --no-install-recommends \ 
  && rm -rf /var/lib/apt/lists/* \ 
  # Install the packages into the opt directory.
  && cd ../ \
  && catkin_make -DCMAKE_INSTALL_PREFIX=/opt/deepracer_ws install
#
# Deployment stage
# ------------------------
FROM athackst/ros:kinetic-base

# Get the installation artifacts from the builder image
COPY --from=builder /opt/deepracer_ws/ /opt/deepracer_ws/
COPY --from=builder /packages.txt /packages.txt

# Install all dependent packages.
RUN apt-get update \
  && cat /packages.txt | xargs sudo apt-get install -y --no-install-recommends \ 
  && rm -rf /var/lib/apt/lists/*

# Set up environment.
ENV ROS_PACKAGE_PATH=/opt/deepracer_ws/share:$ROS_PACKAGE_PATH
ENV LD_LIBRARY_PATH=/opt/deepracer_ws/lib:$LD_LIBRARY_PATH
ENV ROSLISP_PACKAGE_DIRECTORIES=
ENV PYTHONPATH=/opt/deepracer_ws/lib/python2.7/dist-packages:$PYTHONPATH
ENV PKG_CONFIG_PATH=/opt/deepracer_ws/lib/pkgconfig:$PKG_CONFIG_PATH

CMD ["roslaunch", "deepracer_joy", "deepracer_joy.launch"]