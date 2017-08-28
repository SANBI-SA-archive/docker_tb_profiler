FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    python \
    python-setuptools \
    python-pip \
    git wget gcc
    #python-virtualenv

# install virtualenv 
RUN easy_install pip
RUN pip install virtualenv
RUN pip install virtualenvwrapper

SHELL ["/bin/bash", "-c"] 

#create the tb_profiler
#RUN export WORKON_HOME=~/envs
#RUN mkdir ~/envs
#RUN source /usr/local/bin/virtualenvwrapper.sh
#RUN source ~/.bashrc
#RUN mkvirtualenv tb_profiler

################## BEGIN INSTALLATION ######################
RUN git clone --recursive https://github.com/jodyphelan/TBProfiler.git
WORKDIR TBProfiler
RUN bash install_prerequisites.sh
RUN echo "export PATH=$PWD:$PATH" >> ~/.bashrc

#Donwload sample files
RUN wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR166/009/ERR1664619/ERR1664619_1.fastq.gz
RUN wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR166/009/ERR1664619/ERR1664619_2.fastq.gz

# Set default container command
CMD ["tb-profiler", "full", "-1", "ERR1664619_1.fastq.gz", "-2", "ERR1664619_2.fastq.gz", "-t", "4", "-p", "ERR1664619"]
