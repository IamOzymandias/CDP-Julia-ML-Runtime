#Dockerfile
#Specify an ML Runtime base image
FROM docker.repository.cloudera.com/cdsw/ml-runtime-jupyterlab-python3.9-standard:2021.09.1-b5
# Install ImageAI and dependenices in the new image
RUN apt-get update && apt-get install curl gzip
# Upgrade packages in the base image
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*
# Install Julia
RUN export J_VERSION=$(curl -s "https://api.github.com/repos/JuliaLang/julia/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
ENV JULIA_VERSION=$J_VERSION
RUN export J_M_VERSION=$(echo $JULIA_VERSION | grep -Po "^[0-9]+.[0-9]+")
ENV JULIA_MINOR_VERSION=$J_M_VERSION
RUN curl -o julia.tar.gz "https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_MINOR_VERSION}/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" > julia.tar.gz
RUN mkdir /opt/julia
# before ADDing, make sure the file to be added is at the file path
ADD julia.tar.gz /opt/julia
RUN ln -s /opt/julia/julia-1.7.1/bin/* /usr/local/bin
RUN rm -rf julia.tar.gz
RUN pip3 install sklearn
# Override Runtime label and environment variables metadata
ENV ML_RUNTIME_EDITION="Julia with JupyterLab Edition" ML_RUNTIME_SHORT_VERSION="1" ML_RUNTIME_MAINTENANCE_VERSION="8" ML_RUNTIME_FULL_VERSION="1.8" ML_RUNTIME_DESCRIPTION="This runtime includes Julia"
LABEL com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION