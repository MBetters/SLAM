#!/bin/bash

rm -rf data

mkdir -p data/MIT_CSAIL
wget -P data/MIT_CSAIL http://www2.informatik.uni-freiburg.de/~stachnis/datasets/datasets/csail/csail-newcarmen.log.gz
wget -P data/MIT_CSAIL http://www2.informatik.uni-freiburg.de/~stachnis/datasets/datasets/csail/csail-oldcarmen.log.gz
wget -P data/MIT_CSAIL http://www2.informatik.uni-freiburg.de/~stachnis/datasets/datasets/csail/csail.corrected.log.gz
wget -P data/MIT_CSAIL http://www2.informatik.uni-freiburg.de/~stachnis/datasets/datasets/csail/csail.corrected.gfs.gz

gunzip -d data/MIT_CSAIL/*

mkdir -p data/Freiburg_Campus
wget -P data/Freiburg_Campus http://www2.informatik.uni-freiburg.de/~stachnis/datasets/datasets/freiburg-campus/fr-campus-20040714.carmen.log.gz
wget -P data/Freiburg_Campus http://www2.informatik.uni-freiburg.de/~stachnis/datasets/datasets/freiburg-campus/fr-campus-20040714.carmen.gfs.log.gz
wget -P data/Freiburg_Campus http://www2.informatik.uni-freiburg.de/~stachnis/datasets/datasets/freiburg-campus/fr-campus-20040714.carmen.gfs.gz

gunzip -d data/Freiburg_Campus/*

mkdir -p data/Intel_Research_Lab
wget -P data/Intel_Research_Lab http://www2.informatik.uni-freiburg.de/~stachnis/datasets/datasets/intel-lab/intel.log.gz
wget -P data/Intel_Research_Lab http://www2.informatik.uni-freiburg.de/~stachnis/datasets/datasets/intel-lab/intel.gfs.log.gz
wget -P data/Intel_Research_Lab http://www2.informatik.uni-freiburg.de/~stachnis/datasets/datasets/intel-lab/intel.gfs.gz

gunzip -d data/Intel_Research_Lab/*

