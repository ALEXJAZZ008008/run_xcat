#!/bin/bash

#Copyright University College London 2019
#Author: Alexander Whitehead, Institute of Nuclear Medicine, UCL
#For internal research only.

cd ../

echo -e '\n' ./run_xcat/run_all.sh ./run_xcat/run_xcat.sh ~/XCAT/dxcat2_linux_64bit ./run_xcat/run_lesion.sh /home/alex/Documents/SIRF-SuperBuild_install/bin/stir_math $1 '\n'

./run_xcat/run_all.sh ./run_xcat/run_xcat.sh ~/XCAT/dxcat2_linux_64bit ./run_xcat/run_lesion.sh /home/alex/Documents/SIRF-SuperBuild_install/bin/stir_math $1

cd ./run_xcat
