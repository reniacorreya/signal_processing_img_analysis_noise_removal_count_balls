% Function countBalls accepts image and image file name as parameters and
% count the total number of balls and number of each color of balls
% The function prints the result, saves the figures and return the counts
function [totalBallsCount, redBallsCount, blueBallsCount, yellowBallsCount, greenBallsCount] = countBalls(image, image_file_name)

figure, imshow(image);

% Set the radius range and sensitivity for each image file
if strcmp(image_file_name,'media_files/very_easy.jpg')
    file_prefix = 'Task_3n4_Output/very_easy';
    sensitivity = 0.96;
    minRadius = 30;
    maxRadius = 120;
end

if strcmp(image_file_name,'media_files/easy.jpg')
    file_prefix = 'Task_3n4_Output/easy';
    sensitivity = 0.955;
    minRadius = 40;
    maxRadius = 80;
end

if strcmp(image_file_name,'media_files/medium.jpg')
    file_prefix = 'Task_3n4_Output/medium';
    sensitivity = 0.97;
    minRadius = 45;
    maxRadius = 70;
end

if strcmp(image_file_name,'media_files/hard.jpg')
    file_prefix = 'Task_3n4_Output/hard';
    sensitivity = 0.964;
    minRadius = 60;
    maxRadius = 100;
end

if strcmp(image_file_name,'media_files/very_hard.jpg')
    file_prefix = 'Task_3n4_Output/very_hard';
    sensitivity = 0.95;
    minRadius = 15;
    maxRadius = 36;
end

if strcmp(image_file_name,'media_files/extreme.jpg')
    file_prefix = 'Task_3n4_Output/extreme';
    sensitivity = 0.976;
    minRadius = 45;
    maxRadius = 80;
end
   

% Separate the three color channels
[redChannel,greenChannel,blueChannel] = imsplit(image);

% Set threshold values for each color
redTh = 60;
blueTh = 15;
greenTh = 30;
yellowTh = 120;

% Measure the difference of color channels
redMinusGreen = redChannel - greenChannel;
redMinusBlue = redChannel - blueChannel;
blueMinusGreen = blueChannel - greenChannel;
blueMinusRed = blueChannel - redChannel;
greenMinusBlue = greenChannel - blueChannel;
greenMinusRed = greenChannel - redChannel;

% Get pixels with red color
redPixels = redMinusGreen  > redTh & redMinusBlue  > redTh;

% Get pixels with blue color
bluePixels = blueMinusGreen  > blueTh & blueMinusRed  > blueTh;

% Get pixels with green color
greenPixels = greenMinusBlue  > greenTh & greenMinusRed  > greenTh;

% Get pixels with yellow color
yellowPixels = greenMinusBlue  > yellowTh & redMinusBlue  > yellowTh;

%*********************Task 3 - Count the number of balls******************

% Change red, green, blue, yellow pixels to white (in effective the
% balls will be masked with white color
redChannel(redPixels) = 255;
greenChannel(redPixels) = 255;
blueChannel(redPixels) = 255;

redChannel(bluePixels) = 255;
greenChannel(bluePixels) = 255;
blueChannel(bluePixels) = 255;

redChannel(greenPixels) = 255;
greenChannel(greenPixels) = 255;
blueChannel(greenPixels) = 255;

redChannel(yellowPixels) = 255;
greenChannel(yellowPixels) = 255;
blueChannel(yellowPixels) = 255;

background = redChannel <255 & greenChannel <255 & blueChannel <255;
redChannel(background) = 0;
greenChannel(background) = 0;
blueChannel(background) = 0;

% Combine the channels to get the image with balls masked with white color 
ballsImage = cat(3,redChannel,greenChannel,blueChannel);

% find circles
[centers,radii] = imfindcircles(ballsImage,[minRadius maxRadius],'ObjectPolarity','bright', ...
    'Sensitivity',sensitivity,'Method','twostage');

% display masked image
figure, imshow(ballsImage);

% draw circle around the detected balls
viscircles(centers,radii);
title('Count Balls : Step 1');
fileName = strcat(file_prefix,'_count_step1.jpg');
saveas(gcf,fileName);

% Save and display original image with detected circles
figure, imshow(image);
viscircles(centers,radii);
title('Balls Detected');
fileName = strcat(file_prefix,'_balls_detected.jpg');
saveas(gcf,fileName);

% get total balls count
totalBallsCount = length(radii);

% Create black channel
allBlack = zeros(size(image,1,2),class(image));

%********Detect red balls***********

% Set redchannel of all pixels without intense red color value to 0
redChannel(~redPixels) = 0;

% Combine the channels to get image with red balls in black background 
redBallsImage = cat(3,redChannel,allBlack,allBlack);

% Find the red balls in the image
[centers,radii] = imfindcircles(redBallsImage,[minRadius maxRadius],'ObjectPolarity','bright', ...
    'Sensitivity',sensitivity,'Method','twostage');

% display masked image
figure, imshow(redBallsImage);

% Circle the detected balls in the figure
viscircles(centers,radii);

% Save the figure
title('Count Red Balls : Step 1');
fileName = strcat(file_prefix,'_count_red_step1.jpg');
saveas(gcf,fileName);

% Save and display original image with detected circles
figure, imshow(image);
viscircles(centers,radii);
title('Red Balls Detected');
fileName = strcat(file_prefix,'_red_balls_detected.jpg');
saveas(gcf,fileName);

% Get the count of detected red balls
redBallsCount = length(radii);


%********Detect blue balls***********


% Set redchannel of all pixels without intense red color value to 0
blueChannel(~bluePixels) = 0;

% Combine the channels to get image with blue balls in black background 
blueBallsImage = cat(3,allBlack,allBlack,blueChannel);

% Find the circles in the image
[centers,radii] = imfindcircles(blueBallsImage,[minRadius maxRadius],'ObjectPolarity','bright', ...
    'Sensitivity',sensitivity,'Method','twostage');

figure, imshow(blueBallsImage);
% Circle the detected balls in the figure
viscircles(centers,radii);

% Save the figure
title('Count Blue Balls : Step 1');
fileName = strcat(file_prefix,'_count_blue_step1.jpg');
saveas(gcf,fileName);

% Save and display original image with detected circles
figure, imshow(image);
viscircles(centers,radii);
title('Blue Balls Detected');
fileName = strcat(file_prefix,'_blue_balls_detected.jpg');
saveas(gcf,fileName);

% Get the count of detected balls
blueBallsCount = length(radii);

%********Detect yellow balls**********

% Set all other pixel value to 0 for red and green channels
greenChannel(yellowPixels) = 255;
redChannel(yellowPixels) = 255;
greenChannel(~yellowPixels) = 0;
redChannel(~yellowPixels) = 0;

% Combine the channels to get image with blue balls in black background 
yellowBallsImage = cat(3,redChannel,greenChannel,allBlack);

% Find the circles in the image
[centers,radii] = imfindcircles(yellowBallsImage,[minRadius maxRadius],'ObjectPolarity','bright', ...
    'Sensitivity',sensitivity,'Method','twostage');

figure, imshow(yellowBallsImage);
% Circle the detected balls in the figure
viscircles(centers,radii);

% Save the figure
title('Count Yellow Balls : Step 1');
fileName = strcat(file_prefix,'_count_yellow_step1.jpg');
saveas(gcf,fileName);

% Save and display original image with detected circles
figure, imshow(image);
viscircles(centers,radii);
title('Yellow Balls Detected');
fileName = strcat(file_prefix,'_yellow_balls_detected.jpg');
saveas(gcf,fileName);

% Get the count of detected balls
yellowBallsCount = length(radii);


%********Detect green balls***********

greenChannel(greenPixels) = 255;
greenChannel(~greenPixels) = 0;

% Combine the channels to get image with blue balls in black background 
greenBallsImage = cat(3,allBlack,greenChannel,allBlack);

% Find the circles in the image
[centers,radii] = imfindcircles(greenBallsImage,[minRadius maxRadius],'ObjectPolarity','bright', ...
    'Sensitivity',sensitivity,'Method','twostage');

figure, imshow(greenBallsImage);
% Circle the detected balls in the figure
viscircles(centers,radii);

% Save the figure
title('Count Green Balls : Step 1');
fileName = strcat(file_prefix,'_count_green_step1.jpg');
saveas(gcf,fileName);

% Save and display original image with detected circles
figure, imshow(image);
viscircles(centers,radii);
title('Green Balls Detected');
fileName = strcat(file_prefix,'_green_balls_detected.jpg');
saveas(gcf,fileName);

% Get the count of detected balls
greenBallsCount = length(radii);

% Print the result
fprintf('\n\n*******************************************\n');
fprintf('File Name: %s\n',image_file_name);
fprintf('Total number of balls: %d\n',totalBallsCount);
fprintf('Number of red balls: %d\n',redBallsCount);
fprintf('Number of green balls: %d\n',greenBallsCount);
fprintf('Number of blue balls: %d\n',blueBallsCount);
fprintf('Number of yellow balls: %d',yellowBallsCount);

end