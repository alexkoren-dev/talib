from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

import numpy
import os
import sys

if sys.platform == "darwin":
    if os.path.exists("/opt/local/include/ta-lib"):
        include_talib_dir = "/opt/local/include"
        lib_talib_dir = "/opt/local/lib"
    else:
        include_talib_dir = "/usr/local/include/"
        lib_talib_dir = "/usr/local/lib/"

elif "linux" in sys.platform or "freebsd" in sys.platform:
    include_talib_dir = "/usr/local/include/"
    lib_talib_dir = "/usr/local/lib/"

elif sys.platform == "win32":
    include_talib_dir = r"c:\ta-lib\c\include"
    lib_talib_dir = r"c:\ta-lib\c\lib"

else:
    raise NotImplementedError(sys.platform)

lib_talib_name = 'ta_lib' if not sys.platform == 'win32' else 'ta_libc_cdr'

common_ext = Extension('talib.common', ['talib/common.pyx'],
    include_dirs=[numpy.get_include(), include_talib_dir],
    library_dirs=[lib_talib_dir],
    libraries=[lib_talib_name]
)

func_ext = Extension("talib.func", ["talib/func.pyx"],
    include_dirs=[numpy.get_include(), include_talib_dir],
    library_dirs=[lib_talib_dir],
    libraries=[lib_talib_name]
)

abstract_ext = Extension('talib.abstract', ['talib/abstract.pyx'],
    include_dirs=[numpy.get_include(), include_talib_dir],
    library_dirs=[lib_talib_dir],
    libraries=[lib_talib_name]
)

setup(
    name = 'TA-Lib',
    version = '0.4.5-git',
    description = 'Python wrapper for TA-Lib',
    author = 'John Benediktsson',
    author_email = 'mrjbq7@gmail.com',
    url = 'http://github.com/mrjbq7/ta-lib',
    download_url = 'https://github.com/mrjbq7/ta-lib/archive/TA_Lib-0.4.4.zip',
    classifiers = [
        "License :: OSI Approved :: BSD License",
        "Development Status :: 4 - Beta",
        "Operating System :: Unix",
        "Operating System :: POSIX",
        "Operating System :: MacOS :: MacOS X",
        "Operating System :: Microsoft :: Windows",
        "Programming Language :: Python",
        "Programming Language :: Python :: 2",
        "Programming Language :: Python :: 3",
        "Programming Language :: Cython",
        "Topic :: Office/Business :: Financial",
        "Topic :: Scientific/Engineering :: Mathematics",
        "Intended Audience :: Developers",
        "Intended Audience :: Science/Research",
        "Intended Audience :: Financial and Insurance Industry",
    ],
    packages=['talib'],
    ext_modules=[common_ext, func_ext, abstract_ext],
    cmdclass = {'build_ext': build_ext}
)
