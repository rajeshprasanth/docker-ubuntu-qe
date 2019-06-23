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
#
# Prepare for prerequisites
#
RUN	apt-get update
RUN	apt-get --yes install tar sed gawk gfortran gcc g++
RUN	apt-get --yes install wget curl
#
# Creating Quantum Espresso Directory
#
RUN	mkdir -p /home/qe-test/espresso/espresso-6.4.1/bin
#
RUN	su qe-test 
RUN	pwd
