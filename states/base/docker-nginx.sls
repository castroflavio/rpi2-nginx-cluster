
docker.io:
  pkg.installed

docker-py:
  pkg.installed:
    - name: python-pip
  pip.installed:
    - require:
      - pkg: python-pip

docker_nginx_image:
  docker.pulled:
    - name: castroflavio/rpi2-arch-nginx
    - force: True
    - order: 100

docker_nginx_container:
  docker.installed:
    - name: simple_nginx
    - image: castroflavio/rpi2-arch-nginx
    - ports:
      - "80/tcp"
    - require:
      - docker: docker_nginx_image
    - order: 120

docker_nginx_running:
  docker.running:
    - container: simple_nginx
    - port_bindings:
        "80/tcp":
            HostIp: "0.0.0.0"
            HostPort: "80"
    - require:
      - docker: docker_nginx_container
    - order: 121
