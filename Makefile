help:##show this help
	@fgrep '##' $(MAKEFILE_LIST) | grep -v "@fgrep" | sed s/##/' '/g

image: ##create a docker image
	@docker image build --tag="docker101:latest" .

run: ##run the latest docker image
	@docker container ls | grep 101 ; if [ $$? -eq 0 ]; then docker stop docker101; fi
	@docker run --name docker101 --rm --detach -it -P docker101

clean: ##clean dangling images
	@docker container ls | grep 101 ; if [ $$? -eq 0 ]; then docker stop docker101; fi
	@docker images docker101 | grep 101 ; if [ $$? -eq 0 ]; then docker rmi $$(docker images docker101 -q); fi
	@docker images -f "dangling=true" | grep "<none>" ; if [ $$? -eq 0 ]; then @docker rmi $$(docker images -f "dangling=true" -q); fi
