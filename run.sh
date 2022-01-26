    #!/bin/bash

    Rscript -e "install.packages('devtools',repos='https://cloud.r-project.org')"
    Rscript -e "devtools::install_deps('.')"
    R CMD INSTALL --no-multiarch --with-keep.source .
    Rscript steer/steer.R
    R CMD REMOVE emulandice

