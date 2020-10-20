# Evolutionary Power Spectral Density (EPSD)

[![View Evolutionary Power Spectral Density (EPSD) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://se.mathworks.com/matlabcentral/fileexchange/60959-evolutionary-power-spectral-density-epsd)


## Summary

The Evolutionary Power Spectral Density (EPSD) [1] is compared to the well-known spectrogram implemented in Matlab. The EPSD produces a smoother signal, especially if the amount of data point is low. In the following, I am using the example from [2] where the spectrogram applies well. For other application, e.g. civil engineering, the spectrogram method may provide a too low frequency or time resolution. The use of the EPSD is therefore more common in this field, see e.g. [3] for an application of the EPSD to compute the bridge response to non-stationary wind load.

Any comment, question or suggestion to improve the submission is warmly welcomed. Shiyu Zhao is gratefully acknowledged for the suggestion regarding the definition of the lower-boundary of the frequency vector.

## Content 

The submission contains:

 - An example file
 - The function EPSD.m

## References

[1] Priestley, M. B. (1965). Evolutionary spectra and non-stationary processes. Journal of the Royal Statistical Society. Series B (Methodological), 204-237.
[2] http://www.mathworks.com/help/signal/ref/spectrogram.html
[3] Hu, L., Xu, Y. L., & Huang, W. F. (2013). Typhoon-induced non-stationary buffeting response of long-span bridges in complex terrain. Engineering Structures, 57, 406-415.

