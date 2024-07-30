default: docker-all

.PHONY: docker-agent
docker-agent:
	@echo "Building agent container image"
	cd agent && podman build -f Dockerfile --platform linux/amd64 --build-arg GOARCH=amd64 --target base -t synheart-agent:dev-latest-no-plugins ..
	cd agent && podman build -f Dockerfile --platform linux/amd64 --build-arg GOARCH=amd64 --target base-with-go-plugins -t synheart-agent:dev-latest ..

.PHONY: docker-agent-py
docker-agent-py:
	@echo "Building python agent container image (Experimental)"
	cd agent && podman build -f Dockerfile --platform linux/amd64 --build-arg GOARCH=amd64 --target base-with-python-plugins -t synheart-agent:dev-latest-with-py ..

# ARM Agent images
.PHONY: docker-agent-arm
docker-agent-arm: 
	@echo "Building agent container image for ARM"
	cd agent && podman build -f Dockerfile --platform linux/arm64 --build-arg GOARCH=arm64 --target base -t synheart-agent:dev-latest-no-plugins-arm ..
	cd agent && podman build -f Dockerfile --platform linux/arm64 --build-arg GOARCH=arm64 --target base-with-go-plugins -t synheart-agent:dev-latest-arm ..


.PHONY: docker-restapi
docker-restapi:
	@echo "Building restapi container image"
	cd restapi && podman build -f Dockerfile --platform linux/amd64,linux/arm64 -t synheart-restapi:dev-latest ..

## Controller
.PHONY: docker-controller
docker-controller:
	@echo "Building controller container image"
	cd controller && podman build -f Dockerfile --platform linux/amd64,linux/arm64  -t synheart-controller:dev-latest ..


.PHONY : docker-all
docker-all: clean docker-agent docker-agent-py docker-restapi docker-controller docker-agent-arm docker-restapi-arm docker-controller-arm

.PHONY : clean
clean:
	rm -rf agent/bin
	rm -rf controller/bin
	rm -rf restapi/bin