# -*- coding: utf-8 -*-

import sounddevice as sd
import numpy as np
from scipy.signal import butter, lfilter

sample_rate = 44100 # Will be changed to adjustable later
duration = 5 # Will be changed to adjustable later
channels = 1 # 1 = mono, 2 = stereo

beginprogram = input("Start? ")
if beginprogram == "Yes":
    audio_data = sd.rec(int(duration * sample_rate), samplerate = sample_rate, channels = channels, dtype = "int16")
    print(audio_data.shape) # Debug statement
    sd.wait()    
    
    pass_type = input(str("Pass type? (high/low) "))
    cutoff = float(input("Cutoff frequency? (1000 to 5000 for high/5000 to 10000 for low)"))
    order = int(input("Filter order? (1-10)"))
    
    def butterworth_pass(cutoff, sample_rate, order = 5):
        nyquist = 0.5 * sample_rate
        normal_cutoff = cutoff / nyquist
        b, a = butter(order, normal_cutoff, btype = pass_type, analog = False)
        return b, a
    
    b, a = butterworth_pass(cutoff, sample_rate, order)
    filtered_audio = lfilter(b, a, audio_data)
else: 
    print("Session ended")
    exit