all: joy ros1-bridge eloquent-msgs

joy: joy/Dockerfile
	docker build -f Dockerfile -t localhost:5000/deepracer:joy -t athackst/deepracer:joy joy/.

ros1_bridge: ros1_bridge/Dockerfile
	docker build -f Dockerfile -t localhost:5000/deepracer:ros1_bridge -t athackst/deepracer:ros1_bridge ros1_bridge/.

eloquent_msgs: eloquent_msgs/Dockerfile
	docker build -f Dockerfile -t localhost:5000/deepracer:eloquent_msgs -t athackst/deepracer:eloquent_msgs eloquent_msgs/.

clean:
	docker rmi localhost:5000/deepracer:joy athackst/deepracer:joy
	docker rmi localhost:5000/deepracer:ros1_bridge athackst/deepracer:ros1_bridge
	docker rmi localhost:5000/deepracer:eloquent_msgs athackst/deepracer:eloquent_msgs
	docker system prune -f
