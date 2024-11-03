dev.new()

install.packages("reticulate", dependencies = TRUE)
install.packages("tuneR", dependencies = TRUE)
install.packages("seewave", dependencies = TRUE)
library(tuneR)
library(seewave)
library(reticulate)
py_install("numpy")
py_install("scipy")
use_python("C:/Users/annaw/AppData/Local/Programs/Python/Python312/python.exe", required = TRUE) # nolint: line_length_linter.
py_config()

np <- import("numpy")
sd <- import("sounddevice")
source_python("C:/Users/annaw/Desktop/Light Symphony/sounddetection.py") # nolint: line_length_linter.

audio_signal <- as.numeric(filtered_audio)

print(head(audio_signal)) # Debug statement
print(length(audio_signal)) # Debug statement

sample_rate <- 44100
wave_obj <- Wave(left = audio_signal, samp.rate = sample_rate, bit = 16)

print(wave_obj) # Debug statement

plot(wave_obj, main = "Waveform") # Waveform
oscillo(wave_obj, title = "Waveform") # Visuallization of waveform
spectro(wave_obj, film = c(0, duration), collevels = seq(-40, 0, 1)) # Spectrogram # nolint: line_length_linter.
spec(wave_obj, f = sample_rate, plot = TRUE) # Power spectrum
mel(wave_obj, f = sample_rate) # Mel-spectrogram