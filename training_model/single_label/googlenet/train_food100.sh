#!/usr/bin/env sh

TOOLS=/home/iis/Downloads/caffe-master/build/tools

GLOG_logtostderr=1 $TOOLS/caffe train \
-solver /home/iis/Desktop/FoodClassifier-master/food100_train/single_label/solver.prototxt 2>&1 | tee log/log.txt
#-weights /home/iis/Desktop/FoodClassifier-master/food100_train/_iter_5000.caffemodel 2>&1 | tee log/log.txt
#-solver /home/iis/Downloads/henry/OWA_E2E/solver_NN.prototxt 2>&1 | tee log/log.txt

#-solver /home/iis/Downloads/KYChang/caffe-master/examples/AVA/SC_NN/solver.prototxt \
#-weights /home/iis/Downloads/KYChang/caffe-master/models/bvlc_googlenet/bvlc_googlenet.caffemodel 2>&1 | tee log/log.txt

#-solver imagenet_solver.prototxt \
#-weights imagenet_googlenet.caffemodel 2>&1 | tee log/log.txt
