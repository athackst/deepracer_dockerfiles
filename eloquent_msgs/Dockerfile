#
# Build the ros2 messages
# ------------------------
FROM althack/ros2:eloquent-dev AS ros2_builder

WORKDIR /workspaces/ros2/src

RUN git clone --branch eloquent https://github.com/athackst/aws_deepracer_msgs.git \
  && cd ../ \
  && colcon build --merge-install --install-base /opt/ros/eloquent

#
# Make the ros2 deepracer image
# ------------------------
FROM althack/ros2:eloquent-base AS ros2

# Get the ros2 messages
COPY --from=ros2_builder /opt/ros/eloquent/ /opt/ros/eloquent

CMD ["bash"]