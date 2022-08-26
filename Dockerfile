FROM arm64v8/ros:kinetic-perception-jessie

# LABEL about the custom image
LABEL maintainer="st173207@stud.uni-stuttart.de"
LABEL version="1.0"
LABEL description="This is custom Docker Image for \
SICK Visionary T in Linux."
# Environment variable will not prompt to install time zone etc when we use apt get install 
ENV DEBIAN_FRONTEND=noninteractive 


# source workspace
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc 

RUN bash -c "mkdir -p /home/catkin_ws/src"

WORKDIR /home/catkin_ws/src
RUN /bin/bash -c '. /opt/ros/kinetic/setup.bash; catkin_init_workspace'


#clone the driver repo
RUN git clone https://github.com/SICKAG/sick_visionary_t.git

WORKDIR ..
RUN /bin/bash -c '. /opt/ros/kinetic/setup.bash; rosdep install --from-paths src --ignore-src -r -y'
RUN /bin/bash -c '. /opt/ros/kinetic/setup.bash; catkin_make'
RUN echo "source devel/setup.bash" >> ~/.bashrc

# Source your environment:
#CMD "source /opt/ros/indigo/setup.bash"


