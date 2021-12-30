# CDP-Julia-ML-Runtime
Custom ML runtimes for use with Cloudera Data Platform Machine Learning

Cloudera Machine Learning environments (CDSW, CML) utilize Docker images to provide compute enivronments. The base Docker images provided by Cloudera may be extended to better fit a given purpose. This example demonstrates how to add the Julia programming language for use with CDSW and CML.

- **Content**
    - Construct the Dockerfile
    - Build Docker image
    - Push Docker image to a repository
    - Add the custom ML runtime
    - Examples for usage

## Construct the Dockerfile
Create two Dockerfiles: one for a standard workbench, one for JupyterLab
- Standard Workbench ML runtime
    ```bash
    # Dockerfile
    # Specify an ML Runtime base image
    FROM docker.repository.cloudera.com/cdsw/ml-runtime-jupyterlab-python3.9-standard:2021.09.1-b5
    # Install Julian in the new image
    RUN apt-get update && apt-get install curl gzip
    # Upgrade packages in the base image
    RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*
    #Install Julia
    RUN export J_VERSION=$(curl -s "https://api.github.com/repos/JuliaLang/julia/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
    ENV JULIA_VERSION=$J_VERSION
    RUN export J_M_VERSION=$(echo $JULIA_VERSION | grep -Po "^[0-9]+.[0-9]+")
    ENV JULIA_MINOR_VERSION=$J_M_VERSION
    RUN curl -o julia.tar.gz "https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_MINOR_VERSION}/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" > julia.tar.gz
    RUN mkdir /opt/julia
    # before ADDing, make sure the file to be added is at the file path
    ADD julia.tar.gz /opt/julia
    RUN ln -s /opt/julia/julia-${JULIA_VERSION}/bin/* /usr/local/bin
    RUN rm -rf julia.tar.gz
    # Override Runtime label and environment variables metadata
    ENV ML_RUNTIME_EDITION="Julia Edition" ML_RUNTIME_SHORT_VERSION="1" ML_RUNTIME_MAINTENANCE_VERSION="2" ML_RUNTIME_FULL_VERSION="1.2" ML_RUNTIME_DESCRIPTION="This runtime includes Julia"
    LABEL com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION
    ```

- JupyterLab ML runtime
    ```bash
    # Dockerfile
    # Specify an ML Runtime base image
    FROM docker.repository.cloudera.com/cdsw/ml-runtime-workbench-python3.7-standard:2021.09.1-b5
    # Install ImageAI and dependenices in the new image
    RUN apt-get update && apt-get install curl gzip
    # Upgrade packages in the base image
    RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*
    #Install Julia
    RUN export J_VERSION=$(curl -s "https://api.github.com/repos/JuliaLang/julia/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
    ENV JULIA_VERSION=$J_VERSION
    RUN export J_M_VERSION=$(echo $JULIA_VERSION | grep -Po "^[0-9]+.[0-9]+")
    ENV JULIA_MINOR_VERSION=$J_M_VERSION
    RUN curl -o julia.tar.gz "https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_MINOR_VERSION}/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" > julia.tar.gz
    RUN mkdir /opt/julia
    ADD julia.tar.gz /opt/julia
    RUN ln -s /opt/julia/julia-${JULIA_VERSION}/bin/* /usr/local/bin
    RUN rm -rf julia.tar.gz
    # Override Runtime label and environment variables metadata
    ENV ML_RUNTIME_EDITION="Julia Edition" ML_RUNTIME_SHORT_VERSION="1" ML_RUNTIME_MAINTENANCE_VERSION="2" ML_RUNTIME_FULL_VERSION="1.2" ML_RUNTIME_DESCRIPTION="This runtime includes Julia"
    LABEL com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION
    ```


## Build Docker Image


## Push Docker Image to a Repository


## Add the Custom ML Runtime 


## Examples for Usage

