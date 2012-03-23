import numpy
import pylab

import talib

TEST_LEN = 100

r = numpy.arange(TEST_LEN)
idata = numpy.random.random((TEST_LEN))

(i, n, odata) = talib.MA(idata)

(i, n, upper, middle, lower) = talib.BBANDS(idata)

(i, n, kama) = talib.KAMA(idata)

length = min(len(odata), len(upper), len(kama))

# make them all the same length
r = r[-length:]
idata = idata[-length:]
odata = odata[-length:]
upper = upper[-length:]
middle = middle[-length:]
lower = lower[-length:]
kama = kama[-length:]

pylab.plot(r, idata, 'b-', label="original")
pylab.plot(r, odata, 'g-', label="MA")
pylab.plot(r, upper, 'r-', label="Upper")
pylab.plot(r, middle, 'r-', label="Middle")
pylab.plot(r, lower, 'r-', label="Lower")
pylab.plot(r, kama, 'g', label="KAMA")
pylab.legend()
pylab.show()

