function [Sp,freq,t] = EPSD(x,fs,Nfreq,varargin)
% [Sp,freq] = EPSD(H,T,NFFT,N,x,tmax,scale) compute the  Evolutaionary
% Power Spectral Density (EPSD) of a vector x based on the study of Priestley [1]
%
%% Input
% x: vector [1 x N] or [N x 1]:  time series of a random process
% fs : scalar: sampling frequency
% Nfreq: scalar: number of frequency step.
% 
% Varargin: contains additional optaional parameters:
%	'H': scalar : wirghting function
%	'T': scalar: window length
%	'scale': string: 'lin' or 'log' to define the frequency vector with
%	linspace or logspace respectively.
% 
%% Output:
% Sp: matrix [N x Nfreq] : EPSD of the signal x. 
% freq: vector [1 x Nfreq]:  frequency vector
% t: vector [1 x N]:  time vector
%
%%  Syntax:
% [Sp,freq,t] = EPSD(x,fs,Nfreq)
% [Sp,freq,t] = EPSD(x,fs,Nfreq,'H',1,'T',10,'scale','lin')
% [Sp,freq,t] = EPSD(x,fs,Nfreq,'scale','log')
% [Sp,freq,t] = EPSD(x,fs,Nfreq,'dataPlot',0)
% 
%% Example
% t = 0:0.001:2;
% dt = median(diff(t));
% fs=1/dt;
% x = chirp(t,100,1,200,'quadratic');
% [Sp,freq,t] = EPSD(x,fs,Nfreq,'scale','lin','H',50*dt,'T',1.01*dt );
% caxis([-50,-20])
% ylim([0,500])
% xlim([0.1,1.9])
% title('EPSD')

%% Author info
% E. Cheynet, UiB, norway.
% last modified 20-10-2020
% 
%% References
% [1] Priestley, M. B. (1965). Evolutionary spectra and non-stationary 
% processes. Journal of the Royal Statistical Society. 
% Series B (Methodological), 204-237.
% 
% see also spectrogram


%% Inputparser
p = inputParser();
p.CaseSensitive = false;
p.addOptional('H',10./fs);
p.addOptional('T',10./fs);
p.addOptional('scale','log');
p.addOptional('dataPlot',1);
p.parse(varargin{:});
% shorten the variables name
H =  p.Results.H ;
T =  p.Results.T ;
scale = p.Results.scale ;
dataPlot = p.Results.dataPlot;
%%
N=numel(x);
x = x(:)';
tmax = N/fs;
t0 = linspace(-tmax/2,tmax/2,N);
t = linspace(0,tmax,N);
dt = median(diff(t0));
fs = 1/dt;
fmin = 1/(2*H);


if strcmpi(scale,'log')
    freq=logspace(log10(fmin),log10(fs/2),Nfreq);
elseif strcmpi(scale,'lin')
    freq=linspace(fmin,fs/2,Nfreq);
else
    error(' ''scale'' must be ''lin'' or ''log'' ');
end

% window and weigthing function
g = zeros(1,N);
h = zeros(1,N);
g(abs(t0)<=H)  = 1/(2*sqrt(H.*pi));
h(abs(t0)<=T/2) =  1/T;


Sp = nan(Nfreq,N);
for ii=1:Nfreq
    U0 = conv(g,x.*exp(-1i*2*pi.*freq(ii)*t0),'same');
    Sp(ii,:) = conv(h,abs(U0).^2,'same').*2*(dt).^3;
end


if dataPlot==1
    imagesc(t,freq,pow2db(Sp));
    axis('xy')
    axis tight
    xlabel('time (s)')
    ylabel('frequency (Hz)')
    c=colorbar('Eastoutside');
    ylabel(c,'Power/frequency (dB/Hz)')    
end




end

