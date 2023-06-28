%************************************** TASK 1 and TASK 2 **************************************

% Create directory for output files for task1 and 2
mkdir Task_1n2_Output;

%*********************Processing audio_in_noise1.wav********************

% Read the audio file
[y1,fs1] = audioread("media_files/audio_in_noise1.wav");

% Plot the original sound wave in time domain
t1=(1:length(y1))/fs1;
figure, plot(t1,y1);
title('audio in noise1 in Time domain')
xlabel('Time(s)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/audio_in_noise1_plot.jpg');

% Plot the original sound wave in frequency domain and determine the
% frequency of noice 
n = 1024; % Number of data points
f1 = linspace(0, fs1, n);
Y1 = abs(fft(y1,n));
figure, plot(f1(1:n/2),Y1(1:n/2)); % n/2 to avoid mirroring
title('audio in noise1 in Frequency domain')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/audio_in_noise1_fftplot.jpg');

% Frequency of noise is approx 516.129 Hz

% Remove the noise using frequency filter
y1_filtered = bandstop(y1,[400 600],fs1); 

% Play the filtered audio
%sound(y1_filtered,fs1);

% Plot the filtered audio in frequency domain
Y1_filtered = abs(fft(y1_filtered,n));
figure, plot(f1(1:n/2),Y1_filtered(1:n/2));
title('noise removed1 in Frequency domain')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/noise_removed1_fftplot.jpg');

% Plot the filtered audio in time domain
ft1=(1:length(y1_filtered))/fs1;
figure, plot(ft1,y1_filtered);
title('noise removed1 in Time domain')
xlabel('Time(s)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/noise_removed1_plot.jpg');

% save the filtered audio to a file
audiowrite('Task_1n2_Output/noise_removed1.wav',y1_filtered,fs1);


%*********************Processing audio_in_noise2.wav********************

% Read the audio file
[y2,fs2] = audioread("media_files/audio_in_noise2.wav");

% Plot the original sound wave in time domain
t2=(1:length(y2))/fs2;
figure, plot(t2,y2);
title('audio in noise2 in Time domain')
xlabel('Time(s)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/audio_in_noise2_plot.jpg');

% Plot the original sound wave in frequency domain and determine the
% frequency of noice 
f2 = linspace(0, fs2, n);
Y2 = abs(fft(y2,n));
figure, plot(f2(1:n/2),Y2(1:n/2));
title('audio in noise2 in Frequency domain')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/audio_in_noise2_fftplot.jpg');

% Frequency of noise is approx 234.604Hz

% Remove the noise using frequency filter
y2_filtered = bandstop(y2,[185 290],fs2); 

% Play the filtered audio
%sound(y2_filtered,fs2);

% Plot the filtered audio in frequency domain
Y2_filtered = abs(fft(y2_filtered,n));
figure, plot(f2(1:n/2),Y2_filtered(1:n/2));
title('noise removed2 in Frequency domain')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/noise_removed2_fftplot.jpg');

% Plot the filtered audio in time domain
ft2=(1:length(y2_filtered))/fs2;
figure, plot(ft2,y2_filtered);
title('noise removed2 in Time domain')
xlabel('Time(s)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/noise_removed2_plot.jpg');

% save the filtered audio to a file
audiowrite('Task_1n2_Output/noise_removed2.wav',y2_filtered,fs2);


%*********************Processing audio_in_noise3.wav********************

% Read the audio file
[y3,fs3] = audioread("media_files/audio_in_noise3.wav");

% Plot the original sound wave in time domain
t3=(1:length(y3))/fs3;
figure, plot(t3,y3);
title('audio in noise3 in Time domain')
xlabel('Time(s)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/audio_in_noise3_plot.jpg');

% Plot the original sound wave in frequency domain and determine the
% frequency of noice 
f3 = linspace(0, fs3, n);
Y3 = abs(fft(y3,n));
figure, plot(f3(1:n/2),Y3(1:n/2));
title('audio in noise3 in Frequency domain')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/audio_in_noise3_fftplot.jpg');

% There are two noise frequencies which are approx 797.654Hz and approx 187.683Hz

% Remove the noise using frequency filter
y3_filtered = bandstop(y3,[620 1000],fs3); % filtering noise with frequency approx 797.654Hz
y4_filtered = bandstop(y3_filtered,[100 300],fs3); % filtering noise with frequency approx 187.683Hz

% Play the filtered audio
%sound(y4_filtered,fs3);

% Plot the filtered audio in frequency domain
Y4_filtered_fft = abs(fft(y4_filtered,n));
figure, plot(f3(1:n/2),Y4_filtered_fft(1:n/2));
title('noise removed3 in Frequency domain')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/noise_removed3_fftplot.jpg');

% Plot the filtered audio in time domain
ft3=(1:length(y4_filtered))/fs3;
figure, plot(ft3,y4_filtered);
title('noise removed3 in Time domain')
xlabel('Time(s)');
ylabel('Amplitude');
saveas(gcf,'Task_1n2_Output/noise_removed3_plot.jpg');

audiowrite('Task_1n2_Output/noise_removed3.wav',y4_filtered,fs3);


%************************************** TASK 3 and TASK 4 **************************************

% Create directory for output files for task 3 and 4
mkdir Task_3n4_Output;

%*********************Processing very_easy.jpg********************
% Read the image
image_file_name = 'media_files/very_easy.jpg'; 
image = imread(image_file_name);

% Invoke method to count the balls by passing the image and image name
[totalBallsCountVE, redBallsCountVE, blueBallsCountVE, yellowBallsCountVE, greenBallsCountVE] = countBalls(image, image_file_name);

%*********************Processing easy.jpg********************
% Read the image
image_file_name = 'media_files/easy.jpg';
image = imread(image_file_name);

[totalBallsCountE, redBallsCountE, blueBallsCountE, yellowBallsCountE, greenBallsCountE] = countBalls(image, image_file_name);

%*********************Processing medium.jpg********************
% Read the image
image_file_name = 'media_files/medium.jpg';
image = imread(image_file_name);

[totalBallsCountM, redBallsCountM, blueBallsCountM, yellowBallsCountM, greenBallsCountM] = countBalls(image, image_file_name);

%*********************Processing hard.jpg********************
% Read the image
image_file_name = 'media_files/hard.jpg';
image = imread(image_file_name);

[totalBallsCountH, redBallsCountH, blueBallsCountH, yellowBallsCountH, greenBallsCountH] = countBalls(image, image_file_name);

%*********************Processing very_hard.jpg********************
% Read the image
image_file_name = 'media_files/very_hard.jpg';
image = imread(image_file_name);

[totalBallsCountVH, redBallsCountVH, blueBallsCountVH, yellowBallsCountVH, greenBallsCountVH] = countBalls(image, image_file_name);

%*********************Processing extreme.jpg********************
% Read the image
image_file_name = 'media_files/extreme.jpg';
image = imread(image_file_name);

[totalBallsCountEx, redBallsCountEx, blueBallsCountEx, yellowBallsCountEx, greenBallsCountEx] = countBalls(image, image_file_name);