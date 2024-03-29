#
# Import ubuntu image from default dockerhub reposistory
# 
FROM 	ubuntu
#
# Label for this DOCKERFILE
# 
LABEL 	maintainer="Rajesh Prashanth Anandavadivel <rajeshprasanth@rediffmail.com>" version="1.0"
#
# Creating user qe-test
# 
RUN	useradd -m -d /home/qe-test qe-test
RUN	passwd -d qe-test
#
# Prepare for prerequisites
#
RUN	apt-get update
RUN	apt-get --yes install tar sed gawk gfortran gcc g++ make xz-utils
RUN	apt-get --yes install wget curl
RUN	apt-get autoremove -y
#
# Creating Quantum Espresso Directory
#
RUN	mkdir -p /opt/espresso/espresso-6.4.1/bin
#
RUN	cd /opt/espresso/espresso-6.4.1 \
	&& wget https://gitlab.com/QEF/q-e/-/archive/qe-6.4.1/q-e-qe-6.4.1.tar.gz \
	&& tar zxvf q-e-qe-6.4.1.tar.gz \
	&& cd q-e-qe-6.4.1 && ./configure && make pw pp \
	&& find . -name *.x|gawk {'print "cp",$1,"/opt/espresso/espresso-6.4.1/bin"'}|bash \
	&& rm -rf /opt/espresso/espresso-6.4.1/bin/q-e-qe-6.4.1 \
	&& echo "export PATH=$PATH:/opt/espresso/espresso-6.4.1/bin/" >> /.bashrc
#
RUN	su qe-test \
	&& echo "export PATH=$PATH:/opt/espresso/espresso-6.4.1/bin/" >> ~/.bashrc
#
# Create aflow Directory
#
RUN mkdir -p /opt/aflow/aflow.3.1.224/bin \
	&& cd /opt/aflow/aflow.3.1.224 \
	&& wget http://materials.duke.edu/AFLOW/aflow.3.1.224.tar.xz \
	&& tar Jxvf aflow.3.1.224.tar.xz \
	&& cd aflow.3.1.224 \ 
	&& make \
	&& cp aflow /opt/aflow/aflow.3.1.224/bin \
	&& rm -rf /opt/aflow/aflow.3.1.224/aflow.3.1.224
