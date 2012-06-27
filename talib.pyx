
from numpy import nan, int32, double, ascontiguousarray
from cython import boundscheck, wraparound
cimport numpy as np

ctypedef np.double_t double_t
ctypedef np.int32_t int32_t

ctypedef int TA_RetCode
ctypedef int TA_MAType

# TA_MAType enums
MA_SMA, MA_EMA, MA_WMA, MA_DEMA, MA_TEMA, MA_TRIMA, MA_KAMA, MA_MAMA, MA_T3 = range(9)

# TA_RetCode enums
RetCodes = {
    0: 'Success',
    1: 'Library Not Initialized',
    2: 'Bad Parameter',
    3: 'Allocation Error',
    4: 'Group Not Found',
    5: 'Function Not Found',
    6: 'Invalid Handle',
    7: 'Invalid Parameter Holder',
    8: 'Invalid Parameter Holder Type',
    9: 'Invalid Parameter Function',
   10: 'Input Not All Initialized',
   11: 'Output Not All Initialized',
   12: 'Out-of-Range Start Index',
   13: 'Out-of-Range End Index',
   14: 'Invalid List Type',
   15: 'Bad Object',
   16: 'Not Supported',
 5000: 'Internal Error',
65535: 'Unknown Error',
}

cdef extern from "math.h":
    bint isnan(double x)

cdef double NaN = nan

cdef extern from "numpy/arrayobject.h":
    object PyArray_EMPTY(int, np.npy_intp*, int, int)

np.import_array() # Initialize the NumPy C API

# extract the needed part of ta_libc.h that I will use in the interface
cdef extern from "ta_libc.h":
    enum: TA_SUCCESS
    TA_RetCode TA_Initialize()
    TA_RetCode TA_Shutdown()
    char *TA_GetVersionString()
    TA_RetCode TA_ACOS( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ACOS_Lookback(  )
    TA_RetCode TA_AD( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[],  double inVolume[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_AD_Lookback(  )
    TA_RetCode TA_ADD( int startIdx, int endIdx,  double inReal0[],  double inReal1[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ADD_Lookback(  )
    TA_RetCode TA_ADOSC( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[],  double inVolume[], int optInFastPeriod, int optInSlowPeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ADOSC_Lookback( int optInFastPeriod, int optInSlowPeriod )
    TA_RetCode TA_ADX( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ADX_Lookback( int optInTimePeriod )
    TA_RetCode TA_ADXR( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ADXR_Lookback( int optInTimePeriod )
    TA_RetCode TA_APO( int startIdx, int endIdx,  double inReal[], int optInFastPeriod, int optInSlowPeriod, TA_MAType optInMAType, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_APO_Lookback( int optInFastPeriod, int optInSlowPeriod, TA_MAType optInMAType )
    TA_RetCode TA_AROON( int startIdx, int endIdx,  double inHigh[],  double inLow[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outAroonDown[], double outAroonUp[] )
    int TA_AROON_Lookback( int optInTimePeriod )
    TA_RetCode TA_AROONOSC( int startIdx, int endIdx,  double inHigh[],  double inLow[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_AROONOSC_Lookback( int optInTimePeriod )
    TA_RetCode TA_ASIN( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ASIN_Lookback(  )
    TA_RetCode TA_ATAN( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ATAN_Lookback(  )
    TA_RetCode TA_ATR( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ATR_Lookback( int optInTimePeriod )
    TA_RetCode TA_AVGPRICE( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_AVGPRICE_Lookback(  )
    TA_RetCode TA_BBANDS( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, double optInNbDevUp, double optInNbDevDn, TA_MAType optInMAType, int *outBegIdx, int *outNBElement, double outRealUpperBand[], double outRealMiddleBand[], double outRealLowerBand[] )
    int TA_BBANDS_Lookback( int optInTimePeriod, double optInNbDevUp, double optInNbDevDn, TA_MAType optInMAType )
    TA_RetCode TA_BETA( int startIdx, int endIdx,  double inReal0[],  double inReal1[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_BETA_Lookback( int optInTimePeriod )
    TA_RetCode TA_BOP( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_BOP_Lookback(  )
    TA_RetCode TA_CCI( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_CCI_Lookback( int optInTimePeriod )
    TA_RetCode TA_CDL2CROWS( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDL2CROWS_Lookback(  )
    TA_RetCode TA_CDL3BLACKCROWS( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDL3BLACKCROWS_Lookback(  )
    TA_RetCode TA_CDL3INSIDE( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDL3INSIDE_Lookback(  )
    TA_RetCode TA_CDL3LINESTRIKE( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDL3LINESTRIKE_Lookback(  )
    TA_RetCode TA_CDL3OUTSIDE( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDL3OUTSIDE_Lookback(  )
    TA_RetCode TA_CDL3STARSINSOUTH( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDL3STARSINSOUTH_Lookback(  )
    TA_RetCode TA_CDL3WHITESOLDIERS( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDL3WHITESOLDIERS_Lookback(  )
    TA_RetCode TA_CDLABANDONEDBABY( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], double optInPenetration, int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLABANDONEDBABY_Lookback( double optInPenetration )
    TA_RetCode TA_CDLADVANCEBLOCK( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLADVANCEBLOCK_Lookback(  )
    TA_RetCode TA_CDLBELTHOLD( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLBELTHOLD_Lookback(  )
    TA_RetCode TA_CDLBREAKAWAY( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLBREAKAWAY_Lookback(  )
    TA_RetCode TA_CDLCLOSINGMARUBOZU( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLCLOSINGMARUBOZU_Lookback(  )
    TA_RetCode TA_CDLCONCEALBABYSWALL( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLCONCEALBABYSWALL_Lookback(  )
    TA_RetCode TA_CDLCOUNTERATTACK( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLCOUNTERATTACK_Lookback(  )
    TA_RetCode TA_CDLDARKCLOUDCOVER( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], double optInPenetration, int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLDARKCLOUDCOVER_Lookback( double optInPenetration )
    TA_RetCode TA_CDLDOJI( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLDOJI_Lookback(  )
    TA_RetCode TA_CDLDOJISTAR( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLDOJISTAR_Lookback(  )
    TA_RetCode TA_CDLDRAGONFLYDOJI( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLDRAGONFLYDOJI_Lookback(  )
    TA_RetCode TA_CDLENGULFING( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLENGULFING_Lookback(  )
    TA_RetCode TA_CDLEVENINGDOJISTAR( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], double optInPenetration, int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLEVENINGDOJISTAR_Lookback( double optInPenetration )
    TA_RetCode TA_CDLEVENINGSTAR( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], double optInPenetration, int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLEVENINGSTAR_Lookback( double optInPenetration )
    TA_RetCode TA_CDLGAPSIDESIDEWHITE( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLGAPSIDESIDEWHITE_Lookback(  )
    TA_RetCode TA_CDLGRAVESTONEDOJI( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLGRAVESTONEDOJI_Lookback(  )
    TA_RetCode TA_CDLHAMMER( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLHAMMER_Lookback(  )
    TA_RetCode TA_CDLHANGINGMAN( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLHANGINGMAN_Lookback(  )
    TA_RetCode TA_CDLHARAMI( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLHARAMI_Lookback(  )
    TA_RetCode TA_CDLHARAMICROSS( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLHARAMICROSS_Lookback(  )
    TA_RetCode TA_CDLHIGHWAVE( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLHIGHWAVE_Lookback(  )
    TA_RetCode TA_CDLHIKKAKE( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLHIKKAKE_Lookback(  )
    TA_RetCode TA_CDLHIKKAKEMOD( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLHIKKAKEMOD_Lookback(  )
    TA_RetCode TA_CDLHOMINGPIGEON( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLHOMINGPIGEON_Lookback(  )
    TA_RetCode TA_CDLIDENTICAL3CROWS( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLIDENTICAL3CROWS_Lookback(  )
    TA_RetCode TA_CDLINNECK( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLINNECK_Lookback(  )
    TA_RetCode TA_CDLINVERTEDHAMMER( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLINVERTEDHAMMER_Lookback(  )
    TA_RetCode TA_CDLKICKING( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLKICKING_Lookback(  )
    TA_RetCode TA_CDLKICKINGBYLENGTH( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLKICKINGBYLENGTH_Lookback(  )
    TA_RetCode TA_CDLLADDERBOTTOM( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLLADDERBOTTOM_Lookback(  )
    TA_RetCode TA_CDLLONGLEGGEDDOJI( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLLONGLEGGEDDOJI_Lookback(  )
    TA_RetCode TA_CDLLONGLINE( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLLONGLINE_Lookback(  )
    TA_RetCode TA_CDLMARUBOZU( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLMARUBOZU_Lookback(  )
    TA_RetCode TA_CDLMATCHINGLOW( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLMATCHINGLOW_Lookback(  )
    TA_RetCode TA_CDLMATHOLD( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], double optInPenetration, int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLMATHOLD_Lookback( double optInPenetration )
    TA_RetCode TA_CDLMORNINGDOJISTAR( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], double optInPenetration, int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLMORNINGDOJISTAR_Lookback( double optInPenetration )
    TA_RetCode TA_CDLMORNINGSTAR( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], double optInPenetration, int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLMORNINGSTAR_Lookback( double optInPenetration )
    TA_RetCode TA_CDLONNECK( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLONNECK_Lookback(  )
    TA_RetCode TA_CDLPIERCING( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLPIERCING_Lookback(  )
    TA_RetCode TA_CDLRICKSHAWMAN( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLRICKSHAWMAN_Lookback(  )
    TA_RetCode TA_CDLRISEFALL3METHODS( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLRISEFALL3METHODS_Lookback(  )
    TA_RetCode TA_CDLSEPARATINGLINES( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLSEPARATINGLINES_Lookback(  )
    TA_RetCode TA_CDLSHOOTINGSTAR( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLSHOOTINGSTAR_Lookback(  )
    TA_RetCode TA_CDLSHORTLINE( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLSHORTLINE_Lookback(  )
    TA_RetCode TA_CDLSPINNINGTOP( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLSPINNINGTOP_Lookback(  )
    TA_RetCode TA_CDLSTALLEDPATTERN( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLSTALLEDPATTERN_Lookback(  )
    TA_RetCode TA_CDLSTICKSANDWICH( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLSTICKSANDWICH_Lookback(  )
    TA_RetCode TA_CDLTAKURI( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLTAKURI_Lookback(  )
    TA_RetCode TA_CDLTASUKIGAP( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLTASUKIGAP_Lookback(  )
    TA_RetCode TA_CDLTHRUSTING( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLTHRUSTING_Lookback(  )
    TA_RetCode TA_CDLTRISTAR( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLTRISTAR_Lookback(  )
    TA_RetCode TA_CDLUNIQUE3RIVER( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLUNIQUE3RIVER_Lookback(  )
    TA_RetCode TA_CDLUPSIDEGAP2CROWS( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLUPSIDEGAP2CROWS_Lookback(  )
    TA_RetCode TA_CDLXSIDEGAP3METHODS( int startIdx, int endIdx,  double inOpen[],  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_CDLXSIDEGAP3METHODS_Lookback(  )
    TA_RetCode TA_CEIL( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_CEIL_Lookback(  )
    TA_RetCode TA_CMO( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_CMO_Lookback( int optInTimePeriod )
    TA_RetCode TA_CORREL( int startIdx, int endIdx,  double inReal0[],  double inReal1[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_CORREL_Lookback( int optInTimePeriod )
    TA_RetCode TA_COS( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_COS_Lookback(  )
    TA_RetCode TA_COSH( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_COSH_Lookback(  )
    TA_RetCode TA_DEMA( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_DEMA_Lookback( int optInTimePeriod )
    TA_RetCode TA_DIV( int startIdx, int endIdx,  double inReal0[],  double inReal1[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_DIV_Lookback(  )
    TA_RetCode TA_DX( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_DX_Lookback( int optInTimePeriod )
    TA_RetCode TA_EMA( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_EMA_Lookback( int optInTimePeriod )
    TA_RetCode TA_EXP( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_EXP_Lookback(  )
    TA_RetCode TA_FLOOR( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_FLOOR_Lookback(  )
    TA_RetCode TA_HT_DCPERIOD( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_HT_DCPERIOD_Lookback(  )
    TA_RetCode TA_HT_DCPHASE( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_HT_DCPHASE_Lookback(  )
    TA_RetCode TA_HT_PHASOR( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outInPhase[], double outQuadrature[] )
    int TA_HT_PHASOR_Lookback(  )
    TA_RetCode TA_HT_SINE( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outSine[], double outLeadSine[] )
    int TA_HT_SINE_Lookback(  )
    TA_RetCode TA_HT_TRENDLINE( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_HT_TRENDLINE_Lookback(  )
    TA_RetCode TA_HT_TRENDMODE( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_HT_TRENDMODE_Lookback(  )
    TA_RetCode TA_KAMA( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_KAMA_Lookback( int optInTimePeriod )
    TA_RetCode TA_LINEARREG( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_LINEARREG_Lookback( int optInTimePeriod )
    TA_RetCode TA_LINEARREG_ANGLE( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_LINEARREG_ANGLE_Lookback( int optInTimePeriod )
    TA_RetCode TA_LINEARREG_INTERCEPT( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_LINEARREG_INTERCEPT_Lookback( int optInTimePeriod )
    TA_RetCode TA_LINEARREG_SLOPE( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_LINEARREG_SLOPE_Lookback( int optInTimePeriod )
    TA_RetCode TA_LN( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_LN_Lookback(  )
    TA_RetCode TA_LOG10( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_LOG10_Lookback(  )
    TA_RetCode TA_MA( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, TA_MAType optInMAType, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MA_Lookback( int optInTimePeriod, TA_MAType optInMAType )
    TA_RetCode TA_MACD( int startIdx, int endIdx,  double inReal[], int optInFastPeriod, int optInSlowPeriod, int optInSignalPeriod, int *outBegIdx, int *outNBElement, double outMACD[], double outMACDSignal[], double outMACDHist[] )
    int TA_MACD_Lookback( int optInFastPeriod, int optInSlowPeriod, int optInSignalPeriod )
    TA_RetCode TA_MACDEXT( int startIdx, int endIdx,  double inReal[], int optInFastPeriod, TA_MAType optInFastMAType, int optInSlowPeriod, TA_MAType optInSlowMAType, int optInSignalPeriod, TA_MAType optInSignalMAType, int *outBegIdx, int *outNBElement, double outMACD[], double outMACDSignal[], double outMACDHist[] )
    int TA_MACDEXT_Lookback( int optInFastPeriod, TA_MAType optInFastMAType, int optInSlowPeriod, TA_MAType optInSlowMAType, int optInSignalPeriod, TA_MAType optInSignalMAType )
    TA_RetCode TA_MACDFIX( int startIdx, int endIdx,  double inReal[], int optInSignalPeriod, int *outBegIdx, int *outNBElement, double outMACD[], double outMACDSignal[], double outMACDHist[] )
    int TA_MACDFIX_Lookback( int optInSignalPeriod )
    TA_RetCode TA_MAMA( int startIdx, int endIdx,  double inReal[], double optInFastLimit, double optInSlowLimit, int *outBegIdx, int *outNBElement, double outMAMA[], double outFAMA[] )
    int TA_MAMA_Lookback( double optInFastLimit, double optInSlowLimit )
    TA_RetCode TA_MAVP( int startIdx, int endIdx,  double inReal[],  double inPeriods[], int optInMinPeriod, int optInMaxPeriod, TA_MAType optInMAType, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MAVP_Lookback( int optInMinPeriod, int optInMaxPeriod, TA_MAType optInMAType )
    TA_RetCode TA_MAX( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MAX_Lookback( int optInTimePeriod )
    TA_RetCode TA_MAXINDEX( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_MAXINDEX_Lookback( int optInTimePeriod )
    TA_RetCode TA_MEDPRICE( int startIdx, int endIdx,  double inHigh[],  double inLow[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MEDPRICE_Lookback(  )
    TA_RetCode TA_MFI( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[],  double inVolume[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MFI_Lookback( int optInTimePeriod )
    TA_RetCode TA_MIDPOINT( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MIDPOINT_Lookback( int optInTimePeriod )
    TA_RetCode TA_MIDPRICE( int startIdx, int endIdx,  double inHigh[],  double inLow[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MIDPRICE_Lookback( int optInTimePeriod )
    TA_RetCode TA_MIN( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MIN_Lookback( int optInTimePeriod )
    TA_RetCode TA_MININDEX( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, int outInteger[] )
    int TA_MININDEX_Lookback( int optInTimePeriod )
    TA_RetCode TA_MINMAX( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outMin[], double outMax[] )
    int TA_MINMAX_Lookback( int optInTimePeriod )
    TA_RetCode TA_MINMAXINDEX( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, int outMinIdx[], int outMaxIdx[] )
    int TA_MINMAXINDEX_Lookback( int optInTimePeriod )
    TA_RetCode TA_MINUS_DI( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MINUS_DI_Lookback( int optInTimePeriod )
    TA_RetCode TA_MINUS_DM( int startIdx, int endIdx,  double inHigh[],  double inLow[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MINUS_DM_Lookback( int optInTimePeriod )
    TA_RetCode TA_MOM( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MOM_Lookback( int optInTimePeriod )
    TA_RetCode TA_MULT( int startIdx, int endIdx,  double inReal0[],  double inReal1[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_MULT_Lookback(  )
    TA_RetCode TA_NATR( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_NATR_Lookback( int optInTimePeriod )
    TA_RetCode TA_OBV( int startIdx, int endIdx,  double inReal[],  double inVolume[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_OBV_Lookback(  )
    TA_RetCode TA_PLUS_DI( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_PLUS_DI_Lookback( int optInTimePeriod )
    TA_RetCode TA_PLUS_DM( int startIdx, int endIdx,  double inHigh[],  double inLow[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_PLUS_DM_Lookback( int optInTimePeriod )
    TA_RetCode TA_PPO( int startIdx, int endIdx,  double inReal[], int optInFastPeriod, int optInSlowPeriod, TA_MAType optInMAType, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_PPO_Lookback( int optInFastPeriod, int optInSlowPeriod, TA_MAType optInMAType )
    TA_RetCode TA_ROC( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ROC_Lookback( int optInTimePeriod )
    TA_RetCode TA_ROCP( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ROCP_Lookback( int optInTimePeriod )
    TA_RetCode TA_ROCR( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ROCR_Lookback( int optInTimePeriod )
    TA_RetCode TA_ROCR100( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ROCR100_Lookback( int optInTimePeriod )
    TA_RetCode TA_RSI( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_RSI_Lookback( int optInTimePeriod )
    TA_RetCode TA_SAR( int startIdx, int endIdx,  double inHigh[],  double inLow[], double optInAcceleration, double optInMaximum, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_SAR_Lookback( double optInAcceleration, double optInMaximum )
    TA_RetCode TA_SAREXT( int startIdx, int endIdx,  double inHigh[],  double inLow[], double optInStartValue, double optInOffsetOnReverse, double optInAccelerationInitLong, double optInAccelerationLong, double optInAccelerationMaxLong, double optInAccelerationInitShort, double optInAccelerationShort, double optInAccelerationMaxShort, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_SAREXT_Lookback( double optInStartValue, double optInOffsetOnReverse, double optInAccelerationInitLong, double optInAccelerationLong, double optInAccelerationMaxLong, double optInAccelerationInitShort, double optInAccelerationShort, double optInAccelerationMaxShort )
    TA_RetCode TA_SIN( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_SIN_Lookback(  )
    TA_RetCode TA_SINH( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_SINH_Lookback(  )
    TA_RetCode TA_SMA( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_SMA_Lookback( int optInTimePeriod )
    TA_RetCode TA_SQRT( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_SQRT_Lookback(  )
    TA_RetCode TA_STDDEV( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, double optInNbDev, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_STDDEV_Lookback( int optInTimePeriod, double optInNbDev )
    TA_RetCode TA_STOCH( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInFastK_Period, int optInSlowK_Period, TA_MAType optInSlowK_MAType, int optInSlowD_Period, TA_MAType optInSlowD_MAType, int *outBegIdx, int *outNBElement, double outSlowK[], double outSlowD[] )
    int TA_STOCH_Lookback( int optInFastK_Period, int optInSlowK_Period, TA_MAType optInSlowK_MAType, int optInSlowD_Period, TA_MAType optInSlowD_MAType )
    TA_RetCode TA_STOCHF( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInFastK_Period, int optInFastD_Period, TA_MAType optInFastD_MAType, int *outBegIdx, int *outNBElement, double outFastK[], double outFastD[] )
    int TA_STOCHF_Lookback( int optInFastK_Period, int optInFastD_Period, TA_MAType optInFastD_MAType )
    TA_RetCode TA_STOCHRSI( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int optInFastK_Period, int optInFastD_Period, TA_MAType optInFastD_MAType, int *outBegIdx, int *outNBElement, double outFastK[], double outFastD[] )
    int TA_STOCHRSI_Lookback( int optInTimePeriod, int optInFastK_Period, int optInFastD_Period, TA_MAType optInFastD_MAType )
    TA_RetCode TA_SUB( int startIdx, int endIdx,  double inReal0[],  double inReal1[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_SUB_Lookback(  )
    TA_RetCode TA_SUM( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_SUM_Lookback( int optInTimePeriod )
    TA_RetCode TA_T3( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, double optInVFactor, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_T3_Lookback( int optInTimePeriod, double optInVFactor )
    TA_RetCode TA_TAN( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_TAN_Lookback(  )
    TA_RetCode TA_TANH( int startIdx, int endIdx,  double inReal[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_TANH_Lookback(  )
    TA_RetCode TA_TEMA( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_TEMA_Lookback( int optInTimePeriod )
    TA_RetCode TA_TRANGE( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_TRANGE_Lookback(  )
    TA_RetCode TA_TRIMA( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_TRIMA_Lookback( int optInTimePeriod )
    TA_RetCode TA_TRIX( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_TRIX_Lookback( int optInTimePeriod )
    TA_RetCode TA_TSF( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_TSF_Lookback( int optInTimePeriod )
    TA_RetCode TA_TYPPRICE( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_TYPPRICE_Lookback(  )
    TA_RetCode TA_ULTOSC( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInTimePeriod1, int optInTimePeriod2, int optInTimePeriod3, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_ULTOSC_Lookback( int optInTimePeriod1, int optInTimePeriod2, int optInTimePeriod3 )
    TA_RetCode TA_VAR( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, double optInNbDev, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_VAR_Lookback( int optInTimePeriod, double optInNbDev )
    TA_RetCode TA_WCLPRICE( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_WCLPRICE_Lookback(  )
    TA_RetCode TA_WILLR( int startIdx, int endIdx,  double inHigh[],  double inLow[],  double inClose[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_WILLR_Lookback( int optInTimePeriod )
    TA_RetCode TA_WMA( int startIdx, int endIdx,  double inReal[], int optInTimePeriod, int *outBegIdx, int *outNBElement, double outReal[] )
    int TA_WMA_Lookback( int optInTimePeriod )


__version__ = TA_GetVersionString()

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ACOS( np.ndarray[double_t, ndim=1] real not None ):
    """ACOS(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ACOS_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ACOS( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def AD( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , np.ndarray[double_t, ndim=1] volume not None ):
    """AD(high, low, close, volume)

    Chaikin A/D Line"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    if not volume.flags["C_CONTIGUOUS"]:
        volume = ascontiguousarray(volume, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_AD_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_AD( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , <double *>volume.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ADD( np.ndarray[double_t, ndim=1] real0 not None , np.ndarray[double_t, ndim=1] real1 not None ):
    """ADD(real0, real1)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real0.flags["C_CONTIGUOUS"]:
        real0 = ascontiguousarray(real0, dtype=double)
    if not real1.flags["C_CONTIGUOUS"]:
        real1 = ascontiguousarray(real1, dtype=double)
    length = real0.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real0[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ADD_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ADD( 0 , endidx , <double *>real0.data+begidx , <double *>real1.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ADOSC( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , np.ndarray[double_t, ndim=1] volume not None , int fastperiod=-2**31 , int slowperiod=-2**31 ):
    """ADOSC(high, low, close, volume[, fastperiod=?, slowperiod=?])

    Chaikin A/D Oscillator"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    if not volume.flags["C_CONTIGUOUS"]:
        volume = ascontiguousarray(volume, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ADOSC_Lookback( fastperiod , slowperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ADOSC( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , <double *>volume.data+begidx , fastperiod , slowperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ADX( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int timeperiod=-2**31 ):
    """ADX(high, low, close[, timeperiod=?])

    Average Directional Movement Index"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ADX_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ADX( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ADXR( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int timeperiod=-2**31 ):
    """ADXR(high, low, close[, timeperiod=?])

    Average Directional Movement Index Rating"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ADXR_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ADXR( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def APO( np.ndarray[double_t, ndim=1] real not None , int fastperiod=-2**31 , int slowperiod=-2**31 , int matype=0 ):
    """APO(real[, fastperiod=?, slowperiod=?, matype=?])

    Absolute Price Oscillator"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_APO_Lookback( fastperiod , slowperiod , matype )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_APO( 0 , endidx , <double *>real.data+begidx , fastperiod , slowperiod , matype , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def AROON( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , int timeperiod=-2**31 ):
    """AROON(high, low[, timeperiod=?])

    Aroon"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outaroondown
        np.ndarray[double_t, ndim=1] outaroonup
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_AROON_Lookback( timeperiod )
    outaroondown = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outaroondown[i] = NaN
    outaroonup = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outaroonup[i] = NaN
    retCode = TA_AROON( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outaroondown.data+lookback , <double *>outaroonup.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outaroondown , outaroonup

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def AROONOSC( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , int timeperiod=-2**31 ):
    """AROONOSC(high, low[, timeperiod=?])

    Aroon Oscillator"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_AROONOSC_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_AROONOSC( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ASIN( np.ndarray[double_t, ndim=1] real not None ):
    """ASIN(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ASIN_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ASIN( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ATAN( np.ndarray[double_t, ndim=1] real not None ):
    """ATAN(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ATAN_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ATAN( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ATR( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int timeperiod=-2**31 ):
    """ATR(high, low, close[, timeperiod=?])

    Average True Range"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ATR_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ATR( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def AVGPRICE( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """AVGPRICE(open, high, low, close)

    Average Price"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_AVGPRICE_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_AVGPRICE( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def BBANDS( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 , double nbdevup=-4e37 , double nbdevdn=-4e37 , int matype=0 ):
    """BBANDS(real[, timeperiod=?, nbdevup=?, nbdevdn=?, matype=?])

    Bollinger Bands"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outrealupperband
        np.ndarray[double_t, ndim=1] outrealmiddleband
        np.ndarray[double_t, ndim=1] outreallowerband
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_BBANDS_Lookback( timeperiod , nbdevup , nbdevdn , matype )
    outrealupperband = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outrealupperband[i] = NaN
    outrealmiddleband = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outrealmiddleband[i] = NaN
    outreallowerband = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreallowerband[i] = NaN
    retCode = TA_BBANDS( 0 , endidx , <double *>real.data+begidx , timeperiod , nbdevup , nbdevdn , matype , &outbegidx , &outnbelement , <double *>outrealupperband.data+lookback , <double *>outrealmiddleband.data+lookback , <double *>outreallowerband.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outrealupperband , outrealmiddleband , outreallowerband

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def BETA( np.ndarray[double_t, ndim=1] real0 not None , np.ndarray[double_t, ndim=1] real1 not None , int timeperiod=-2**31 ):
    """BETA(real0, real1[, timeperiod=?])

    Beta"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real0.flags["C_CONTIGUOUS"]:
        real0 = ascontiguousarray(real0, dtype=double)
    if not real1.flags["C_CONTIGUOUS"]:
        real1 = ascontiguousarray(real1, dtype=double)
    length = real0.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real0[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_BETA_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_BETA( 0 , endidx , <double *>real0.data+begidx , <double *>real1.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def BOP( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """BOP(open, high, low, close)

    Balance Of Power"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_BOP_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_BOP( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CCI( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int timeperiod=-2**31 ):
    """CCI(high, low, close[, timeperiod=?])

    Commodity Channel Index"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CCI_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_CCI( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDL2CROWS( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDL2CROWS(open, high, low, close)

    Two Crows"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDL2CROWS_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDL2CROWS( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDL3BLACKCROWS( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDL3BLACKCROWS(open, high, low, close)

    Three Black Crows"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDL3BLACKCROWS_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDL3BLACKCROWS( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDL3INSIDE( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDL3INSIDE(open, high, low, close)

    Three Inside Up/Down"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDL3INSIDE_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDL3INSIDE( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDL3LINESTRIKE( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDL3LINESTRIKE(open, high, low, close)

    Three-Line Strike """
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDL3LINESTRIKE_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDL3LINESTRIKE( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDL3OUTSIDE( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDL3OUTSIDE(open, high, low, close)

    Three Outside Up/Down"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDL3OUTSIDE_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDL3OUTSIDE( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDL3STARSINSOUTH( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDL3STARSINSOUTH(open, high, low, close)

    Three Stars In The South"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDL3STARSINSOUTH_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDL3STARSINSOUTH( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDL3WHITESOLDIERS( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDL3WHITESOLDIERS(open, high, low, close)

    Three Advancing White Soldiers"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDL3WHITESOLDIERS_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDL3WHITESOLDIERS( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLABANDONEDBABY( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , double penetration=-4e37 ):
    """CDLABANDONEDBABY(open, high, low, close[, penetration=?])

    Abandoned Baby"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLABANDONEDBABY_Lookback( penetration )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLABANDONEDBABY( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , penetration , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLADVANCEBLOCK( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLADVANCEBLOCK(open, high, low, close)

    Advance Block"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLADVANCEBLOCK_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLADVANCEBLOCK( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLBELTHOLD( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLBELTHOLD(open, high, low, close)

    Belt-hold"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLBELTHOLD_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLBELTHOLD( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLBREAKAWAY( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLBREAKAWAY(open, high, low, close)

    Breakaway"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLBREAKAWAY_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLBREAKAWAY( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLCLOSINGMARUBOZU( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLCLOSINGMARUBOZU(open, high, low, close)

    Closing Marubozu"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLCLOSINGMARUBOZU_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLCLOSINGMARUBOZU( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLCONCEALBABYSWALL( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLCONCEALBABYSWALL(open, high, low, close)

    Concealing Baby Swallow"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLCONCEALBABYSWALL_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLCONCEALBABYSWALL( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLCOUNTERATTACK( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLCOUNTERATTACK(open, high, low, close)

    Counterattack"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLCOUNTERATTACK_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLCOUNTERATTACK( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLDARKCLOUDCOVER( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , double penetration=-4e37 ):
    """CDLDARKCLOUDCOVER(open, high, low, close[, penetration=?])

    Dark Cloud Cover"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLDARKCLOUDCOVER_Lookback( penetration )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLDARKCLOUDCOVER( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , penetration , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLDOJI( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLDOJI(open, high, low, close)

    Doji"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLDOJI_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLDOJI( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLDOJISTAR( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLDOJISTAR(open, high, low, close)

    Doji Star"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLDOJISTAR_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLDOJISTAR( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLDRAGONFLYDOJI( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLDRAGONFLYDOJI(open, high, low, close)

    Dragonfly Doji"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLDRAGONFLYDOJI_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLDRAGONFLYDOJI( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLENGULFING( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLENGULFING(open, high, low, close)

    Engulfing Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLENGULFING_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLENGULFING( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLEVENINGDOJISTAR( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , double penetration=-4e37 ):
    """CDLEVENINGDOJISTAR(open, high, low, close[, penetration=?])

    Evening Doji Star"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLEVENINGDOJISTAR_Lookback( penetration )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLEVENINGDOJISTAR( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , penetration , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLEVENINGSTAR( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , double penetration=-4e37 ):
    """CDLEVENINGSTAR(open, high, low, close[, penetration=?])

    Evening Star"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLEVENINGSTAR_Lookback( penetration )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLEVENINGSTAR( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , penetration , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLGAPSIDESIDEWHITE( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLGAPSIDESIDEWHITE(open, high, low, close)

    Up/Down-gap side-by-side white lines"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLGAPSIDESIDEWHITE_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLGAPSIDESIDEWHITE( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLGRAVESTONEDOJI( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLGRAVESTONEDOJI(open, high, low, close)

    Gravestone Doji"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLGRAVESTONEDOJI_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLGRAVESTONEDOJI( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLHAMMER( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLHAMMER(open, high, low, close)

    Hammer"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLHAMMER_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLHAMMER( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLHANGINGMAN( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLHANGINGMAN(open, high, low, close)

    Hanging Man"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLHANGINGMAN_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLHANGINGMAN( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLHARAMI( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLHARAMI(open, high, low, close)

    Harami Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLHARAMI_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLHARAMI( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLHARAMICROSS( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLHARAMICROSS(open, high, low, close)

    Harami Cross Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLHARAMICROSS_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLHARAMICROSS( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLHIGHWAVE( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLHIGHWAVE(open, high, low, close)

    High-Wave Candle"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLHIGHWAVE_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLHIGHWAVE( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLHIKKAKE( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLHIKKAKE(open, high, low, close)

    Hikkake Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLHIKKAKE_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLHIKKAKE( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLHIKKAKEMOD( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLHIKKAKEMOD(open, high, low, close)

    Modified Hikkake Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLHIKKAKEMOD_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLHIKKAKEMOD( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLHOMINGPIGEON( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLHOMINGPIGEON(open, high, low, close)

    Homing Pigeon"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLHOMINGPIGEON_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLHOMINGPIGEON( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLIDENTICAL3CROWS( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLIDENTICAL3CROWS(open, high, low, close)

    Identical Three Crows"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLIDENTICAL3CROWS_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLIDENTICAL3CROWS( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLINNECK( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLINNECK(open, high, low, close)

    In-Neck Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLINNECK_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLINNECK( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLINVERTEDHAMMER( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLINVERTEDHAMMER(open, high, low, close)

    Inverted Hammer"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLINVERTEDHAMMER_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLINVERTEDHAMMER( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLKICKING( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLKICKING(open, high, low, close)

    Kicking"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLKICKING_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLKICKING( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLKICKINGBYLENGTH( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLKICKINGBYLENGTH(open, high, low, close)

    Kicking - bull/bear determined by the longer marubozu"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLKICKINGBYLENGTH_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLKICKINGBYLENGTH( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLLADDERBOTTOM( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLLADDERBOTTOM(open, high, low, close)

    Ladder Bottom"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLLADDERBOTTOM_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLLADDERBOTTOM( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLLONGLEGGEDDOJI( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLLONGLEGGEDDOJI(open, high, low, close)

    Long Legged Doji"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLLONGLEGGEDDOJI_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLLONGLEGGEDDOJI( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLLONGLINE( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLLONGLINE(open, high, low, close)

    Long Line Candle"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLLONGLINE_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLLONGLINE( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLMARUBOZU( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLMARUBOZU(open, high, low, close)

    Marubozu"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLMARUBOZU_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLMARUBOZU( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLMATCHINGLOW( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLMATCHINGLOW(open, high, low, close)

    Matching Low"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLMATCHINGLOW_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLMATCHINGLOW( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLMATHOLD( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , double penetration=-4e37 ):
    """CDLMATHOLD(open, high, low, close[, penetration=?])

    Mat Hold"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLMATHOLD_Lookback( penetration )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLMATHOLD( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , penetration , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLMORNINGDOJISTAR( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , double penetration=-4e37 ):
    """CDLMORNINGDOJISTAR(open, high, low, close[, penetration=?])

    Morning Doji Star"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLMORNINGDOJISTAR_Lookback( penetration )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLMORNINGDOJISTAR( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , penetration , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLMORNINGSTAR( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , double penetration=-4e37 ):
    """CDLMORNINGSTAR(open, high, low, close[, penetration=?])

    Morning Star"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLMORNINGSTAR_Lookback( penetration )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLMORNINGSTAR( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , penetration , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLONNECK( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLONNECK(open, high, low, close)

    On-Neck Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLONNECK_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLONNECK( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLPIERCING( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLPIERCING(open, high, low, close)

    Piercing Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLPIERCING_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLPIERCING( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLRICKSHAWMAN( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLRICKSHAWMAN(open, high, low, close)

    Rickshaw Man"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLRICKSHAWMAN_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLRICKSHAWMAN( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLRISEFALL3METHODS( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLRISEFALL3METHODS(open, high, low, close)

    Rising/Falling Three Methods"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLRISEFALL3METHODS_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLRISEFALL3METHODS( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLSEPARATINGLINES( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLSEPARATINGLINES(open, high, low, close)

    Separating Lines"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLSEPARATINGLINES_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLSEPARATINGLINES( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLSHOOTINGSTAR( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLSHOOTINGSTAR(open, high, low, close)

    Shooting Star"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLSHOOTINGSTAR_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLSHOOTINGSTAR( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLSHORTLINE( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLSHORTLINE(open, high, low, close)

    Short Line Candle"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLSHORTLINE_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLSHORTLINE( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLSPINNINGTOP( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLSPINNINGTOP(open, high, low, close)

    Spinning Top"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLSPINNINGTOP_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLSPINNINGTOP( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLSTALLEDPATTERN( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLSTALLEDPATTERN(open, high, low, close)

    Stalled Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLSTALLEDPATTERN_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLSTALLEDPATTERN( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLSTICKSANDWICH( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLSTICKSANDWICH(open, high, low, close)

    Stick Sandwich"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLSTICKSANDWICH_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLSTICKSANDWICH( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLTAKURI( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLTAKURI(open, high, low, close)

    Takuri (Dragonfly Doji with very long lower shadow)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLTAKURI_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLTAKURI( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLTASUKIGAP( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLTASUKIGAP(open, high, low, close)

    Tasuki Gap"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLTASUKIGAP_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLTASUKIGAP( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLTHRUSTING( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLTHRUSTING(open, high, low, close)

    Thrusting Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLTHRUSTING_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLTHRUSTING( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLTRISTAR( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLTRISTAR(open, high, low, close)

    Tristar Pattern"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLTRISTAR_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLTRISTAR( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLUNIQUE3RIVER( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLUNIQUE3RIVER(open, high, low, close)

    Unique 3 River"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLUNIQUE3RIVER_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLUNIQUE3RIVER( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLUPSIDEGAP2CROWS( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLUPSIDEGAP2CROWS(open, high, low, close)

    Upside Gap Two Crows"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLUPSIDEGAP2CROWS_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLUPSIDEGAP2CROWS( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CDLXSIDEGAP3METHODS( np.ndarray[double_t, ndim=1] open not None , np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """CDLXSIDEGAP3METHODS(open, high, low, close)

    Upside/Downside Gap Three Methods"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not open.flags["C_CONTIGUOUS"]:
        open = ascontiguousarray(open, dtype=double)
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CDLXSIDEGAP3METHODS_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_CDLXSIDEGAP3METHODS( 0 , endidx , <double *>open.data+begidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CEIL( np.ndarray[double_t, ndim=1] real not None ):
    """CEIL(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CEIL_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_CEIL( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CMO( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """CMO(real[, timeperiod=?])

    Chande Momentum Oscillator"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CMO_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_CMO( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def CORREL( np.ndarray[double_t, ndim=1] real0 not None , np.ndarray[double_t, ndim=1] real1 not None , int timeperiod=-2**31 ):
    """CORREL(real0, real1[, timeperiod=?])

    Pearson's Correlation Coefficient (r)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real0.flags["C_CONTIGUOUS"]:
        real0 = ascontiguousarray(real0, dtype=double)
    if not real1.flags["C_CONTIGUOUS"]:
        real1 = ascontiguousarray(real1, dtype=double)
    length = real0.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real0[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_CORREL_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_CORREL( 0 , endidx , <double *>real0.data+begidx , <double *>real1.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def COS( np.ndarray[double_t, ndim=1] real not None ):
    """COS(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_COS_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_COS( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def COSH( np.ndarray[double_t, ndim=1] real not None ):
    """COSH(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_COSH_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_COSH( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def DEMA( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """DEMA(real[, timeperiod=?])

    Double Exponential Moving Average"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_DEMA_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_DEMA( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def DIV( np.ndarray[double_t, ndim=1] real0 not None , np.ndarray[double_t, ndim=1] real1 not None ):
    """DIV(real0, real1)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real0.flags["C_CONTIGUOUS"]:
        real0 = ascontiguousarray(real0, dtype=double)
    if not real1.flags["C_CONTIGUOUS"]:
        real1 = ascontiguousarray(real1, dtype=double)
    length = real0.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real0[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_DIV_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_DIV( 0 , endidx , <double *>real0.data+begidx , <double *>real1.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def DX( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int timeperiod=-2**31 ):
    """DX(high, low, close[, timeperiod=?])

    Directional Movement Index"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_DX_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_DX( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def EMA( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """EMA(real[, timeperiod=?])

    Exponential Moving Average"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_EMA_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_EMA( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def EXP( np.ndarray[double_t, ndim=1] real not None ):
    """EXP(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_EXP_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_EXP( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def FLOOR( np.ndarray[double_t, ndim=1] real not None ):
    """FLOOR(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_FLOOR_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_FLOOR( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def HT_DCPERIOD( np.ndarray[double_t, ndim=1] real not None ):
    """HT_DCPERIOD(real)

    Hilbert Transform - Dominant Cycle Period"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_HT_DCPERIOD_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_HT_DCPERIOD( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def HT_DCPHASE( np.ndarray[double_t, ndim=1] real not None ):
    """HT_DCPHASE(real)

    Hilbert Transform - Dominant Cycle Phase"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_HT_DCPHASE_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_HT_DCPHASE( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def HT_PHASOR( np.ndarray[double_t, ndim=1] real not None ):
    """HT_PHASOR(real)

    Hilbert Transform - Phasor Components"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outinphase
        np.ndarray[double_t, ndim=1] outquadrature
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_HT_PHASOR_Lookback( )
    outinphase = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinphase[i] = NaN
    outquadrature = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outquadrature[i] = NaN
    retCode = TA_HT_PHASOR( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outinphase.data+lookback , <double *>outquadrature.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinphase , outquadrature

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def HT_SINE( np.ndarray[double_t, ndim=1] real not None ):
    """HT_SINE(real)

    Hilbert Transform - SineWave"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outsine
        np.ndarray[double_t, ndim=1] outleadsine
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_HT_SINE_Lookback( )
    outsine = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outsine[i] = NaN
    outleadsine = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outleadsine[i] = NaN
    retCode = TA_HT_SINE( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outsine.data+lookback , <double *>outleadsine.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outsine , outleadsine

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def HT_TRENDLINE( np.ndarray[double_t, ndim=1] real not None ):
    """HT_TRENDLINE(real)

    Hilbert Transform - Instantaneous Trendline"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_HT_TRENDLINE_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_HT_TRENDLINE( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def HT_TRENDMODE( np.ndarray[double_t, ndim=1] real not None ):
    """HT_TRENDMODE(real)

    Hilbert Transform - Trend vs Cycle Mode"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_HT_TRENDMODE_Lookback( )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_HT_TRENDMODE( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def KAMA( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """KAMA(real[, timeperiod=?])

    Kaufman Adaptive Moving Average"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_KAMA_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_KAMA( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def LINEARREG( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """LINEARREG(real[, timeperiod=?])

    Linear Regression"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_LINEARREG_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_LINEARREG( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def LINEARREG_ANGLE( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """LINEARREG_ANGLE(real[, timeperiod=?])

    Linear Regression Angle"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_LINEARREG_ANGLE_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_LINEARREG_ANGLE( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def LINEARREG_INTERCEPT( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """LINEARREG_INTERCEPT(real[, timeperiod=?])

    Linear Regression Intercept"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_LINEARREG_INTERCEPT_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_LINEARREG_INTERCEPT( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def LINEARREG_SLOPE( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """LINEARREG_SLOPE(real[, timeperiod=?])

    Linear Regression Slope"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_LINEARREG_SLOPE_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_LINEARREG_SLOPE( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def LN( np.ndarray[double_t, ndim=1] real not None ):
    """LN(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_LN_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_LN( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def LOG10( np.ndarray[double_t, ndim=1] real not None ):
    """LOG10(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_LOG10_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_LOG10( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MA( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 , int matype=0 ):
    """MA(real[, timeperiod=?, matype=?])

    All Moving Average"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MA_Lookback( timeperiod , matype )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MA( 0 , endidx , <double *>real.data+begidx , timeperiod , matype , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MACD( np.ndarray[double_t, ndim=1] real not None , int fastperiod=-2**31 , int slowperiod=-2**31 , int signalperiod=-2**31 ):
    """MACD(real[, fastperiod=?, slowperiod=?, signalperiod=?])

    Moving Average Convergence/Divergence"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outmacd
        np.ndarray[double_t, ndim=1] outmacdsignal
        np.ndarray[double_t, ndim=1] outmacdhist
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MACD_Lookback( fastperiod , slowperiod , signalperiod )
    outmacd = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmacd[i] = NaN
    outmacdsignal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmacdsignal[i] = NaN
    outmacdhist = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmacdhist[i] = NaN
    retCode = TA_MACD( 0 , endidx , <double *>real.data+begidx , fastperiod , slowperiod , signalperiod , &outbegidx , &outnbelement , <double *>outmacd.data+lookback , <double *>outmacdsignal.data+lookback , <double *>outmacdhist.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outmacd , outmacdsignal , outmacdhist

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MACDEXT( np.ndarray[double_t, ndim=1] real not None , int fastperiod=-2**31 , int fastmatype=0 , int slowperiod=-2**31 , int slowmatype=0 , int signalperiod=-2**31 , int signalmatype=0 ):
    """MACDEXT(real[, fastperiod=?, fastmatype=?, slowperiod=?, slowmatype=?, signalperiod=?, signalmatype=?])

    MACD with controllable MA type"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outmacd
        np.ndarray[double_t, ndim=1] outmacdsignal
        np.ndarray[double_t, ndim=1] outmacdhist
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MACDEXT_Lookback( fastperiod , fastmatype , slowperiod , slowmatype , signalperiod , signalmatype )
    outmacd = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmacd[i] = NaN
    outmacdsignal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmacdsignal[i] = NaN
    outmacdhist = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmacdhist[i] = NaN
    retCode = TA_MACDEXT( 0 , endidx , <double *>real.data+begidx , fastperiod , fastmatype , slowperiod , slowmatype , signalperiod , signalmatype , &outbegidx , &outnbelement , <double *>outmacd.data+lookback , <double *>outmacdsignal.data+lookback , <double *>outmacdhist.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outmacd , outmacdsignal , outmacdhist

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MACDFIX( np.ndarray[double_t, ndim=1] real not None , int signalperiod=-2**31 ):
    """MACDFIX(real[, signalperiod=?])

    Moving Average Convergence/Divergence Fix 12/26"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outmacd
        np.ndarray[double_t, ndim=1] outmacdsignal
        np.ndarray[double_t, ndim=1] outmacdhist
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MACDFIX_Lookback( signalperiod )
    outmacd = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmacd[i] = NaN
    outmacdsignal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmacdsignal[i] = NaN
    outmacdhist = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmacdhist[i] = NaN
    retCode = TA_MACDFIX( 0 , endidx , <double *>real.data+begidx , signalperiod , &outbegidx , &outnbelement , <double *>outmacd.data+lookback , <double *>outmacdsignal.data+lookback , <double *>outmacdhist.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outmacd , outmacdsignal , outmacdhist

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MAMA( np.ndarray[double_t, ndim=1] real not None , double fastlimit=-4e37 , double slowlimit=-4e37 ):
    """MAMA(real[, fastlimit=?, slowlimit=?])

    MESA Adaptive Moving Average"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outmama
        np.ndarray[double_t, ndim=1] outfama
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MAMA_Lookback( fastlimit , slowlimit )
    outmama = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmama[i] = NaN
    outfama = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outfama[i] = NaN
    retCode = TA_MAMA( 0 , endidx , <double *>real.data+begidx , fastlimit , slowlimit , &outbegidx , &outnbelement , <double *>outmama.data+lookback , <double *>outfama.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outmama , outfama

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MAVP( np.ndarray[double_t, ndim=1] real not None , np.ndarray[double_t, ndim=1] periods not None , int minperiod=-2**31 , int maxperiod=-2**31 , int matype=0 ):
    """MAVP(real, periods[, minperiod=?, maxperiod=?, matype=?])"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    if not periods.flags["C_CONTIGUOUS"]:
        periods = ascontiguousarray(periods, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MAVP_Lookback( minperiod , maxperiod , matype )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MAVP( 0 , endidx , <double *>real.data+begidx , <double *>periods.data+begidx , minperiod , maxperiod , matype , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MAX( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """MAX(real[, timeperiod=?])

    Highest value over a specified period"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MAX_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MAX( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MAXINDEX( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """MAXINDEX(real[, timeperiod=?])

    Index of highest value over a specified period"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MAXINDEX_Lookback( timeperiod )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_MAXINDEX( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MEDPRICE( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None ):
    """MEDPRICE(high, low)

    Median Price"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MEDPRICE_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MEDPRICE( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MFI( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , np.ndarray[double_t, ndim=1] volume not None , int timeperiod=-2**31 ):
    """MFI(high, low, close, volume[, timeperiod=?])

    Money Flow Index"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    if not volume.flags["C_CONTIGUOUS"]:
        volume = ascontiguousarray(volume, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MFI_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MFI( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , <double *>volume.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MIDPOINT( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """MIDPOINT(real[, timeperiod=?])

    MidPoint over period"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MIDPOINT_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MIDPOINT( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MIDPRICE( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , int timeperiod=-2**31 ):
    """MIDPRICE(high, low[, timeperiod=?])

    Midpoint Price over period"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MIDPRICE_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MIDPRICE( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MIN( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """MIN(real[, timeperiod=?])

    Lowest value over a specified period"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MIN_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MIN( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MININDEX( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """MININDEX(real[, timeperiod=?])

    Index of lowest value over a specified period"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outinteger
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MININDEX_Lookback( timeperiod )
    outinteger = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outinteger[i] = 0
    retCode = TA_MININDEX( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <int *>outinteger.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outinteger

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MINMAX( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """MINMAX(real[, timeperiod=?])

    Lowest and highest values over a specified period"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outmin
        np.ndarray[double_t, ndim=1] outmax
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MINMAX_Lookback( timeperiod )
    outmin = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmin[i] = NaN
    outmax = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmax[i] = NaN
    retCode = TA_MINMAX( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outmin.data+lookback , <double *>outmax.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outmin , outmax

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MINMAXINDEX( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """MINMAXINDEX(real[, timeperiod=?])

    Indexes of lowest and highest values over a specified period"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[int32_t, ndim=1] outminidx
        np.ndarray[int32_t, ndim=1] outmaxidx
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MINMAXINDEX_Lookback( timeperiod )
    outminidx = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outminidx[i] = 0
    outmaxidx = PyArray_EMPTY(1, &length, np.NPY_INT32, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outmaxidx[i] = 0
    retCode = TA_MINMAXINDEX( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <int *>outminidx.data+lookback , <int *>outmaxidx.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outminidx , outmaxidx

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MINUS_DI( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int timeperiod=-2**31 ):
    """MINUS_DI(high, low, close[, timeperiod=?])

    Minus Directional Indicator"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MINUS_DI_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MINUS_DI( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MINUS_DM( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , int timeperiod=-2**31 ):
    """MINUS_DM(high, low[, timeperiod=?])

    Minus Directional Movement"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MINUS_DM_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MINUS_DM( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MOM( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """MOM(real[, timeperiod=?])

    Momentum"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MOM_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MOM( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def MULT( np.ndarray[double_t, ndim=1] real0 not None , np.ndarray[double_t, ndim=1] real1 not None ):
    """MULT(real0, real1)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real0.flags["C_CONTIGUOUS"]:
        real0 = ascontiguousarray(real0, dtype=double)
    if not real1.flags["C_CONTIGUOUS"]:
        real1 = ascontiguousarray(real1, dtype=double)
    length = real0.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real0[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_MULT_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_MULT( 0 , endidx , <double *>real0.data+begidx , <double *>real1.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def NATR( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int timeperiod=-2**31 ):
    """NATR(high, low, close[, timeperiod=?])

    Normalized Average True Range"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_NATR_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_NATR( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def OBV( np.ndarray[double_t, ndim=1] real not None , np.ndarray[double_t, ndim=1] volume not None ):
    """OBV(real, volume)

    On Balance Volume"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    if not volume.flags["C_CONTIGUOUS"]:
        volume = ascontiguousarray(volume, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_OBV_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_OBV( 0 , endidx , <double *>real.data+begidx , <double *>volume.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def PLUS_DI( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int timeperiod=-2**31 ):
    """PLUS_DI(high, low, close[, timeperiod=?])

    Plus Directional Indicator"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_PLUS_DI_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_PLUS_DI( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def PLUS_DM( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , int timeperiod=-2**31 ):
    """PLUS_DM(high, low[, timeperiod=?])

    Plus Directional Movement"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_PLUS_DM_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_PLUS_DM( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def PPO( np.ndarray[double_t, ndim=1] real not None , int fastperiod=-2**31 , int slowperiod=-2**31 , int matype=0 ):
    """PPO(real[, fastperiod=?, slowperiod=?, matype=?])

    Percentage Price Oscillator"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_PPO_Lookback( fastperiod , slowperiod , matype )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_PPO( 0 , endidx , <double *>real.data+begidx , fastperiod , slowperiod , matype , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ROC( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """ROC(real[, timeperiod=?])

    Rate of change : ((price/prevPrice)-1)*100"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ROC_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ROC( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ROCP( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """ROCP(real[, timeperiod=?])

    Rate of change Percentage: (price-prevPrice)/prevPrice"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ROCP_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ROCP( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ROCR( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """ROCR(real[, timeperiod=?])

    Rate of change ratio: (price/prevPrice)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ROCR_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ROCR( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ROCR100( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """ROCR100(real[, timeperiod=?])

    Rate of change ratio 100 scale: (price/prevPrice)*100"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ROCR100_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ROCR100( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def RSI( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """RSI(real[, timeperiod=?])

    Relative Strength Index"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_RSI_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_RSI( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def SAR( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , double acceleration=-4e37 , double maximum=-4e37 ):
    """SAR(high, low[, acceleration=?, maximum=?])

    Parabolic SAR"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_SAR_Lookback( acceleration , maximum )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_SAR( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , acceleration , maximum , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def SAREXT( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , double startvalue=-4e37 , double offsetonreverse=-4e37 , double accelerationinitlong=-4e37 , double accelerationlong=-4e37 , double accelerationmaxlong=-4e37 , double accelerationinitshort=-4e37 , double accelerationshort=-4e37 , double accelerationmaxshort=-4e37 ):
    """SAREXT(high, low[, startvalue=?, offsetonreverse=?, accelerationinitlong=?, accelerationlong=?, accelerationmaxlong=?, accelerationinitshort=?, accelerationshort=?, accelerationmaxshort=?])

    Parabolic SAR - Extended"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_SAREXT_Lookback( startvalue , offsetonreverse , accelerationinitlong , accelerationlong , accelerationmaxlong , accelerationinitshort , accelerationshort , accelerationmaxshort )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_SAREXT( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , startvalue , offsetonreverse , accelerationinitlong , accelerationlong , accelerationmaxlong , accelerationinitshort , accelerationshort , accelerationmaxshort , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def SIN( np.ndarray[double_t, ndim=1] real not None ):
    """SIN(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_SIN_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_SIN( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def SINH( np.ndarray[double_t, ndim=1] real not None ):
    """SINH(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_SINH_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_SINH( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def SMA( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """SMA(real[, timeperiod=?])

    Simple Moving Average"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_SMA_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_SMA( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def SQRT( np.ndarray[double_t, ndim=1] real not None ):
    """SQRT(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_SQRT_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_SQRT( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def STDDEV( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 , double nbdev=-4e37 ):
    """STDDEV(real[, timeperiod=?, nbdev=?])

    Standard Deviation"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_STDDEV_Lookback( timeperiod , nbdev )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_STDDEV( 0 , endidx , <double *>real.data+begidx , timeperiod , nbdev , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def STOCH( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int fastk_period=-2**31 , int slowk_period=-2**31 , int slowk_matype=0 , int slowd_period=-2**31 , int slowd_matype=0 ):
    """STOCH(high, low, close[, fastk_period=?, slowk_period=?, slowk_matype=?, slowd_period=?, slowd_matype=?])

    Stochastic"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outslowk
        np.ndarray[double_t, ndim=1] outslowd
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_STOCH_Lookback( fastk_period , slowk_period , slowk_matype , slowd_period , slowd_matype )
    outslowk = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outslowk[i] = NaN
    outslowd = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outslowd[i] = NaN
    retCode = TA_STOCH( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , fastk_period , slowk_period , slowk_matype , slowd_period , slowd_matype , &outbegidx , &outnbelement , <double *>outslowk.data+lookback , <double *>outslowd.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outslowk , outslowd

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def STOCHF( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int fastk_period=-2**31 , int fastd_period=-2**31 , int fastd_matype=0 ):
    """STOCHF(high, low, close[, fastk_period=?, fastd_period=?, fastd_matype=?])

    Stochastic Fast"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outfastk
        np.ndarray[double_t, ndim=1] outfastd
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_STOCHF_Lookback( fastk_period , fastd_period , fastd_matype )
    outfastk = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outfastk[i] = NaN
    outfastd = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outfastd[i] = NaN
    retCode = TA_STOCHF( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , fastk_period , fastd_period , fastd_matype , &outbegidx , &outnbelement , <double *>outfastk.data+lookback , <double *>outfastd.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outfastk , outfastd

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def STOCHRSI( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 , int fastk_period=-2**31 , int fastd_period=-2**31 , int fastd_matype=0 ):
    """STOCHRSI(real[, timeperiod=?, fastk_period=?, fastd_period=?, fastd_matype=?])

    Stochastic Relative Strength Index"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outfastk
        np.ndarray[double_t, ndim=1] outfastd
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_STOCHRSI_Lookback( timeperiod , fastk_period , fastd_period , fastd_matype )
    outfastk = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outfastk[i] = NaN
    outfastd = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outfastd[i] = NaN
    retCode = TA_STOCHRSI( 0 , endidx , <double *>real.data+begidx , timeperiod , fastk_period , fastd_period , fastd_matype , &outbegidx , &outnbelement , <double *>outfastk.data+lookback , <double *>outfastd.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outfastk , outfastd

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def SUB( np.ndarray[double_t, ndim=1] real0 not None , np.ndarray[double_t, ndim=1] real1 not None ):
    """SUB(real0, real1)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real0.flags["C_CONTIGUOUS"]:
        real0 = ascontiguousarray(real0, dtype=double)
    if not real1.flags["C_CONTIGUOUS"]:
        real1 = ascontiguousarray(real1, dtype=double)
    length = real0.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real0[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_SUB_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_SUB( 0 , endidx , <double *>real0.data+begidx , <double *>real1.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def SUM( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """SUM(real[, timeperiod=?])

    Summation"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_SUM_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_SUM( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def T3( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 , double vfactor=-4e37 ):
    """T3(real[, timeperiod=?, vfactor=?])

    Triple Exponential Moving Average (T3)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_T3_Lookback( timeperiod , vfactor )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_T3( 0 , endidx , <double *>real.data+begidx , timeperiod , vfactor , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def TAN( np.ndarray[double_t, ndim=1] real not None ):
    """TAN(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_TAN_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_TAN( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def TANH( np.ndarray[double_t, ndim=1] real not None ):
    """TANH(real)"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_TANH_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_TANH( 0 , endidx , <double *>real.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def TEMA( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """TEMA(real[, timeperiod=?])

    Triple Exponential Moving Average"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_TEMA_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_TEMA( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def TRANGE( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """TRANGE(high, low, close)

    True Range"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_TRANGE_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_TRANGE( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def TRIMA( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """TRIMA(real[, timeperiod=?])

    Triangular Moving Average"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_TRIMA_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_TRIMA( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def TRIX( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """TRIX(real[, timeperiod=?])

    1-day Rate-Of-Change (ROC) of a Triple Smooth EMA"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_TRIX_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_TRIX( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def TSF( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """TSF(real[, timeperiod=?])

    Time Series Forecast"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_TSF_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_TSF( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def TYPPRICE( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """TYPPRICE(high, low, close)

    Typical Price"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_TYPPRICE_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_TYPPRICE( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def ULTOSC( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int timeperiod1=-2**31 , int timeperiod2=-2**31 , int timeperiod3=-2**31 ):
    """ULTOSC(high, low, close[, timeperiod1=?, timeperiod2=?, timeperiod3=?])

    Ultimate Oscillator"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_ULTOSC_Lookback( timeperiod1 , timeperiod2 , timeperiod3 )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_ULTOSC( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , timeperiod1 , timeperiod2 , timeperiod3 , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def VAR( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 , double nbdev=-4e37 ):
    """VAR(real[, timeperiod=?, nbdev=?])

    Variance"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_VAR_Lookback( timeperiod , nbdev )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_VAR( 0 , endidx , <double *>real.data+begidx , timeperiod , nbdev , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def WCLPRICE( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None ):
    """WCLPRICE(high, low, close)

    Weighted Close Price"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_WCLPRICE_Lookback( )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_WCLPRICE( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def WILLR( np.ndarray[double_t, ndim=1] high not None , np.ndarray[double_t, ndim=1] low not None , np.ndarray[double_t, ndim=1] close not None , int timeperiod=-2**31 ):
    """WILLR(high, low, close[, timeperiod=?])

    Williams' %R"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not high.flags["C_CONTIGUOUS"]:
        high = ascontiguousarray(high, dtype=double)
    if not low.flags["C_CONTIGUOUS"]:
        low = ascontiguousarray(low, dtype=double)
    if not close.flags["C_CONTIGUOUS"]:
        close = ascontiguousarray(close, dtype=double)
    length = high.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(high[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_WILLR_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_WILLR( 0 , endidx , <double *>high.data+begidx , <double *>low.data+begidx , <double *>close.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

@wraparound(False)  # turn off relative indexing from end of lists
@boundscheck(False) # turn off bounds-checking for entire function
def WMA( np.ndarray[double_t, ndim=1] real not None , int timeperiod=-2**31 ):
    """WMA(real[, timeperiod=?])

    Weighted Moving Average"""
    cdef:
        np.npy_intp length
        int begidx, endidx, lookback
        int outbegidx
        int outnbelement
        np.ndarray[double_t, ndim=1] outreal
    if not real.flags["C_CONTIGUOUS"]:
        real = ascontiguousarray(real, dtype=double)
    length = real.shape[0]
    begidx = 0
    for i from 0 <= i < length:
        if not isnan(real[i]):
            begidx = i
            break
    else:
        raise Exception("inputs are all NaN")
    endidx = length - begidx - 1
    TA_Initialize()
    lookback = begidx + TA_WMA_Lookback( timeperiod )
    outreal = PyArray_EMPTY(1, &length, np.NPY_DOUBLE, np.NPY_DEFAULT)
    for i from 0 <= i < min(lookback, length):
        outreal[i] = NaN
    retCode = TA_WMA( 0 , endidx , <double *>real.data+begidx , timeperiod , &outbegidx , &outnbelement , <double *>outreal.data+lookback )
    TA_Shutdown()
    if retCode != TA_SUCCESS:
        raise Exception("%d: %s" % (retCode, RetCodes.get(retCode, "Unknown")))
    return outreal

__all__ = ["ACOS","AD","ADD","ADOSC","ADX","ADXR","APO","AROON","AROONOSC","ASIN","ATAN","ATR","AVGPRICE","BBANDS","BETA","BOP","CCI","CDL2CROWS","CDL3BLACKCROWS","CDL3INSIDE","CDL3LINESTRIKE","CDL3OUTSIDE","CDL3STARSINSOUTH","CDL3WHITESOLDIERS","CDLABANDONEDBABY","CDLADVANCEBLOCK","CDLBELTHOLD","CDLBREAKAWAY","CDLCLOSINGMARUBOZU","CDLCONCEALBABYSWALL","CDLCOUNTERATTACK","CDLDARKCLOUDCOVER","CDLDOJI","CDLDOJISTAR","CDLDRAGONFLYDOJI","CDLENGULFING","CDLEVENINGDOJISTAR","CDLEVENINGSTAR","CDLGAPSIDESIDEWHITE","CDLGRAVESTONEDOJI","CDLHAMMER","CDLHANGINGMAN","CDLHARAMI","CDLHARAMICROSS","CDLHIGHWAVE","CDLHIKKAKE","CDLHIKKAKEMOD","CDLHOMINGPIGEON","CDLIDENTICAL3CROWS","CDLINNECK","CDLINVERTEDHAMMER","CDLKICKING","CDLKICKINGBYLENGTH","CDLLADDERBOTTOM","CDLLONGLEGGEDDOJI","CDLLONGLINE","CDLMARUBOZU","CDLMATCHINGLOW","CDLMATHOLD","CDLMORNINGDOJISTAR","CDLMORNINGSTAR","CDLONNECK","CDLPIERCING","CDLRICKSHAWMAN","CDLRISEFALL3METHODS","CDLSEPARATINGLINES","CDLSHOOTINGSTAR","CDLSHORTLINE","CDLSPINNINGTOP","CDLSTALLEDPATTERN","CDLSTICKSANDWICH","CDLTAKURI","CDLTASUKIGAP","CDLTHRUSTING","CDLTRISTAR","CDLUNIQUE3RIVER","CDLUPSIDEGAP2CROWS","CDLXSIDEGAP3METHODS","CEIL","CMO","CORREL","COS","COSH","DEMA","DIV","DX","EMA","EXP","FLOOR","HT_DCPERIOD","HT_DCPHASE","HT_PHASOR","HT_SINE","HT_TRENDLINE","HT_TRENDMODE","KAMA","LINEARREG","LINEARREG_ANGLE","LINEARREG_INTERCEPT","LINEARREG_SLOPE","LN","LOG10","MA","MACD","MACDEXT","MACDFIX","MAMA","MAVP","MAX","MAXINDEX","MEDPRICE","MFI","MIDPOINT","MIDPRICE","MIN","MININDEX","MINMAX","MINMAXINDEX","MINUS_DI","MINUS_DM","MOM","MULT","NATR","OBV","PLUS_DI","PLUS_DM","PPO","ROC","ROCP","ROCR","ROCR100","RSI","SAR","SAREXT","SIN","SINH","SMA","SQRT","STDDEV","STOCH","STOCHF","STOCHRSI","SUB","SUM","T3","TAN","TANH","TEMA","TRANGE","TRIMA","TRIX","TSF","TYPPRICE","ULTOSC","VAR","WCLPRICE","WILLR","WMA"]
