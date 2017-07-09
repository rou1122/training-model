import sys
caffe_root = '/home/iis/Downloads/caffe-master/'
sys.path.insert(0, caffe_root + 'python')
import caffe
import lmdb
from PIL import Image
from pdb import set_trace as bp
import numpy as np

images = []
labels = []
with open("/home/iis/Desktop/val1.txt") as f:
    for lines in f.readlines():
        label = []
        line = lines.strip().split('  ')
        for index in xrange(len(line)):
            if index == 0:                
                images.append(line[0])
            else:
                label.append(line[index])
        labels.append(label)

print "Done"

LMDB_PATH = '/home/iis/Desktop/val-image-lmdb'

in_db = lmdb.open(LMDB_PATH, map_size=int(1e12))
with in_db.begin(write=True) as in_txn:
    for in_idx, in_ in enumerate(images):
        image = Image.open("/home/iis/Desktop/UECFOOD100/"+ in_)
        image = image.resize((256,256),Image.BILINEAR)
        im = np.array(image) # or load whatever ndarray you need       
	im = im[:,:,::-1]
        im = im.transpose((2,0,1))
        im_dat = caffe.io.array_to_datum(im)
        in_txn.put('{:0>10d}'.format(in_idx), im_dat.SerializeToString())
in_db.close()

env = lmdb.open(LMDB_PATH, readonly=True, lock=False)

print(env.stat())


LMDB_PATH = '/home/iis/Desktop/val-label-lmdb'
in_db = lmdb.open(LMDB_PATH, map_size=int(1e12))
with in_db.begin(write=True) as in_txn:
    for in_idx, in_ in enumerate(labels):
        label_dat = caffe.io.array_to_datum(np.array(in_).astype(float).reshape(len(in_),1,1))
        in_txn.put('{:0>10d}'.format(in_idx), label_dat.SerializeToString())

in_db.close()


env = lmdb.open(LMDB_PATH, readonly=True, lock=False)

print(env.stat())
