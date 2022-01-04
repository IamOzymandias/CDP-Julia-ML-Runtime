import Pkg
Pkg.update()

using Pkg
Pkg.add("IJulia")

using IJulia
installkernel("Julia")