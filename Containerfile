FROM    registry.access.redhat.com/ubi8/python-39:1
ARG     APP_ROOT="/opt/app-root/src"
CMD     python3.9 -m pip install --upgrade pip \
  && pip3 install awscli
