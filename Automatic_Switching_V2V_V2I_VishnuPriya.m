axis([0 500 500 1000]); %axis co-ordinates for plot

x1 = [164.5 175.9];
y1 = [573 781.5];
%[x1,y1] = ginput(2); %Vehicle 1 input from user
line(x1,y1,'color','black');      % draw the line (Road 1)
hold on ;

x2 = [185 216.4];
y2 = [575 767.5];
%[x2,y2] = ginput(2);              % Vehicle 2 input from user
line(x2,y2,'color','black');     % draw the line (Road 2)
hold on;

x3 = [277.2 279];
y3 = [573.6 772.2];
%[x3,y3] = ginput(2);              % Vehicle 3 input from user
line(x3,y3,'color','black');      % draw the line (Road 3)
hold on;

x4 = [308.5 144.3];
y4 = [732.5 732.4];
%[x4,y4] = ginput(2);              % Vehicle 4 (Emergency) input from user
line(x4,y4,'color','black');     % draw the line (Road 4)
hold on;

xcord1 = 233;
ycord1 = 588;
%[xcord1,ycord1]=ginput(1);        % Select a point for RSU 1
text(xcord1,ycord1,'RSU','HorizontalAlignment','right');

rnd_speed1=randi([10,20],1,1);
dist_first_line=sqrt((x1(2)-x1(1))^2+(y1(2)-y1(1))^2);     % Distance between 2 points is calculated
speed_new1=round(dist_first_line/rnd_speed1);               % This is the new speed for 1st vehicle
dist_second_line=sqrt((x2(2)-x2(1))^2+(y2(2)-y2(1))^2);     % Distance between 2 points is calculated
%speed_new2=round(dist_second_line/rnd_speed1);               %V2 speed
dist_third_line = sqrt((x3(2)-x3(1))^2+(y3(2)-y3(1))^2);
%speed_new3=round(dist_third_line/rnd_speed1);               %V3 speed
dist_fourth_line = sqrt((x4(2)-x4(1))^2+(y4(2)-y4(1))^2);
%speed_new4=round(dist_fourth_line/rnd_speed1);             %V4 speed (Emergency)

point1=linspace(x1(1),x1(2),speed_new1);  % Random speed is given by taking new speed number of points in a linspace
point2=linspace(y1(1),y1(2),speed_new1);
point3=linspace(x2(1),x2(2),speed_new1);
point4=linspace(y2(1),y2(2),speed_new1);
point5=linspace(x3(1),x3(2),speed_new1);  % Random speed is given by taking new speed number of points in a linspace
point6=linspace(y3(1),y3(2),speed_new1);
point7=linspace(x4(1),x4(2),speed_new1);
point8=linspace(y4(1),y4(2),speed_new1);

first_vehicle=plot(point1,point2,'s','MarkerFaceColor','red');   % Plot first vehicle on road 1
second_vehicle=plot(point3,point4,'o','MarkerFaceColor','blue'); % Plot second vehicle on road 2
third_vehicle=plot(point5,point6,'x','MarkerFaceColor','yellow');   % Plot first vehicle on road 1
fourth_vehicle=plot(point7,point8,'v','MarkerFaceColor','cyan'); % Plot second vehicle on road 2
plot(xcord1,ycord1,'o','MarkerFaceColor','magenta'); % RSU 1 plotted on the figure window
title('Automatic Switching from V2V to V2I simulation');                            % Title is given to the figure

flag_amb = 0;
count_dialog = 0;

for k = 1:speed_new1                   % for all the values in linspace
    
    if flag_amb == 0
        first_vehicle.XData = point1(k);  %first vehicle's x co-ordinate
        first_vehicle.YData = point2(k);  %first vehicle's y co-ordinate
        second_vehicle.XData = point3(k); %second vehicle's x co-ordinate
        second_vehicle.YData = point4(k); %second vehicle's y co-ordinate
        third_vehicle.XData = point5(k);  %first vehicle's x co-ordinate
        third_vehicle.YData = point6(k);  %first vehicle's y co-ordinate
        fourth_vehicle.XData = point7(k); %second vehicle's x co-ordinate
        fourth_vehicle.YData = point8(k); %second vehicle's y co-ordinate
        plot(point1(k),point2(k),point3(k),point4(k),point5(k),point6(k),point7(k),point8(k));
        
        vehicle_dist12=[point1(k),point2(k);point3(k),point4(k)]; % Dist V12
        vehicle_dist13=[point1(k),point2(k);point5(k),point6(k)]; % Dist V13
        vehicle_dist14=[point1(k),point2(k);point7(k),point8(k)]; % Dist V14
        vehicle_dist23=[point3(k),point4(k);point5(k),point6(k)]; % Dist V23
        vehicle_dist24=[point3(k),point4(k);point7(k),point8(k)]; % Dist V24
        vehicle_dist34=[point5(k),point6(k);point7(k),point8(k)]; % Dist V23
        distance12 = pdist(vehicle_dist12,'euclidean');
        distance13 = pdist(vehicle_dist13,'euclidean');
        distance14 = pdist(vehicle_dist14,'euclidean');
        distance23 = pdist(vehicle_dist23,'euclidean');
        distance24 = pdist(vehicle_dist24,'euclidean');
        distance34 = pdist(vehicle_dist34,'euclidean');
        
        vehicle_RSU_dist1R=[point1(k),point2(k);xcord1,ycord1]; % Dist V1R
        vehicle_RSU_dist2R=[point3(k),point4(k);xcord1,ycord1]; % Dist V2R
        vehicle_RSU_dist3R=[point5(k),point6(k);xcord1,ycord1]; % Dist V3R
        vehicle_RSU_dist4R=[point7(k),point8(k);xcord1,ycord1]; % Dist V4R
        distance1R = pdist(vehicle_RSU_dist1R,'euclidean');
        distance2R = pdist(vehicle_RSU_dist2R,'euclidean');
        distance3R = pdist(vehicle_RSU_dist3R,'euclidean');
        distance4R = pdist(vehicle_RSU_dist4R,'euclidean');
        
        
        if distance12<=100                % If the distance is within 200 m
            line1=plot([point1(k),point3(k)],[point2(k),point4(k)],'--','color','green');  % Show connectivity between two vehicles
            pause(1);                  % Delay of 0.45
            set(line1,'Visible','off');     % Visibility property of line is set to 'off'
        end
        
        if distance13<=100                % If the distance is within 200 m
            line1=plot([point1(k),point5(k)],[point2(k),point6(k)],'--','color','green');  % Show connectivity between two vehicles
            pause(1);                  % Delay of 0.45
            set(line1,'Visible','off');     % Visibility property of line is set to 'off'
        end
        
        if distance14<=100                % If the distance is within 200 m
            line1=plot([point1(k),point7(k)],[point2(k),point8(k)],'--','color','green');  % Show connectivity between two vehicles
            pause(1);                  % Delay of 0.45
            set(line1,'Visible','off');     % Visibility property of line is set to 'off'
        end
        
        if distance23<=100                % If the distance is within 200 m
            line1=plot([point3(k),point5(k)],[point4(k),point6(k)],'--','color','green');  % Show connectivity between two vehicles
            pause(1);                  % Delay of 0.45
            set(line1,'Visible','off');     % Visibility property of line is set to 'off'
            %             txt = text(300,900,'V2V communication');
            %             delete(txt);
        end
        
        if distance24<=100                % If the distance is within 200 m
            line1=plot([point3(k),point7(k)],[point4(k),point8(k)],'--','color','green');  % Show connectivity between two vehicles
            pause(1);                  % Delay of 0.45
            %delete(txt);    % Visibility property of line is set to 'off'
        end
        
        if distance34<=100                % If the distance is within 200 m
            line1=plot([point5(k),point7(k)],[point6(k),point8(k)],'--','color','green');  % Show connectivity between two vehicles
            pause(1);                  % Delay of 0.45
            set(line1,'Visible','off');     % Visibility property of line is set to 'off'
        end
        
        text(140,600,'V2V','HorizontalAlignment','right','color','green');
    else
        fourth_vehicle.XData = point7(k); %second vehicle's x co-ordinate
        fourth_vehicle.YData = point8(k); %second vehicle's y co-ordinate
        plot(point7(k),point8(k));
        pause(0.5);
    end
    
    
    
    if distance34 <=100 && distance14 > 100 && distance24 > 100
        flag_amb = 1;
        if count_dialog < 1
            txt = {'Ambulance found in V2V','Switching to V2I to inform RSU'};
            text(300,900,txt)
            %if distance3R<=150                % If the distance is within 200 m
            %line1=plot([point5(k),xcord1],[point6(k),ycord1],'--','color','red');  % Show connectivity between V3 and RSU
            plot([point5(k),xcord1],[point6(k),ycord1],'--','color','red');
            text(350,650,'V2R','HorizontalAlignment','right','color','red');
            pause(2);                  % Delay of 0.45
            
            f = msgbox('Message transmitted to RSU');
            pause(3)
            %pause(0.8)
            f = msgbox('RSU now informs V1, V2 using V2I to stop and give way to ambulance');
            pause(3)
            line1=plot([point1(k),xcord1],[point2(k),ycord1],'--','color','red');  % Show connectivity between two vehicles
            pause(0.3);                  % Delay of 0.45
            %set(line1,'Visible','off');
            line1=plot([point3(k),xcord1],[point4(k),ycord1],'--','color','red');  % Show connectivity between two vehicles
            pause(0.3);
            txt = {'Communication shifted to V2R'};
            pause(4);
            text(300,850,txt,'color','red')
            count_dialog = count_dialog + 1;
            text(300,820,'Only Ambulance moves now','color','red')
        end
    end
    
end




