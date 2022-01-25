    #!/bin/bash

    cd ..
    R CMD INSTALL --no-multiarch --with-keep.source emulandice
    cd emulandice
    Rscript steer/steer.R

