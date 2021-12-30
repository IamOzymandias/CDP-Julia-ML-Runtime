# CDP-Julia-ML-Runtime
Custom ML runtimes for use with Cloudera Data Platform Machine Learning

Cloudera Machine Learning environments (CDSW, CML) utilize Docker images to provide compute enivronments. The base Docker images provided by Cloudera may be extended to better fit a given purpose. This example demonstrates how to add the Julia programming language for use with CDSW and CML.

- **Content**
    - Construct the Dockerfile
    - Build Docker image
    - Push Docker image to a repository
    - Add the custom ML runtime
    - Examples for usage
