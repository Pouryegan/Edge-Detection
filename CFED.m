clear
clc
format long
%gereftan maghadire vorodi az karbar
promt={'lo','hi','w'};
default={'0','25','256'};
input1_txt=inputdlg(promt,'Competetive Fuzzy Edge Detection Inputs',1,default);
input1_num=str2num(char(input1_txt));
lo=input1_num(1)/256;
hi=input1_num(2)/256;
w=input1_num(3)/256;
%%%%%%%%%%%%
promt={' sensitivity thresholds for the Canny method','sigma as the standard deviation of the Gaussian filter'};
default={'0.04','0.6'};
input2_txt=inputdlg(promt,'Canny method inputs',1,default);
input2_num=str2num(char(input2_txt));
threshold=input2_num(1);
sigma=input2_num(2);
%%%%%%%%%%%%%5
imageRGB=imread('m1.jpg');
imageuint=rgb2gray(imageRGB);
image=im2double(imageuint);
image1=image;
%mohasebeye satr o sotone ax
r=size(image,1);
c=size(image,2);
%mohasebeye d1,d2,...baraye har pixel
c0=[lo,lo,lo,lo];
c1=[lo,hi,hi,hi];
c2=[hi,lo,hi,hi];
c3=[hi,hi,lo,hi];
c4=[hi,hi,hi,lo];
c5=[hi,hi,hi,hi];
miyo0=zeros(r,c);
miyo1=zeros(r,c);
miyo2=zeros(r,c);
miyo3=zeros(r,c);
miyo4=zeros(r,c);
miyo5=zeros(r,c);
for j=2:r-1
    for i=2:c-1
      d1(j,i)=(imabsdiff(image(j-1,i-1),image(j,i))+imabsdiff(image(j+1,i+1),image(j,i)));
      d2(j,i)=(imabsdiff(image(j-1,i),image(j,i))+imabsdiff(image(j+1,i),image(j,i)));
      d3(j,i)=(imabsdiff(image(j-1,i+1),image(j,i))+imabsdiff(image(j+1,i-1),image(j,i)));
      d4(j,i)=(imabsdiff(image(j,i+1),image(j,i))+imabsdiff(image(j,i-1),image(j,i)));
      miyo0(j,i)=max(0,(1-((d1(j,i)-c0(1))^2+(d2(j,i)-c0(2))^2+(d3(j,i)-c0(3))^2+(d4(j,i)-c0(4))^2))/w^2);    
      miyo1(j,i)=max(0,(1-((d1(j,i)-c1(1))^2+(d2(j,i)-c1(2))^2+(d3(j,i)-c1(3))^2+(d4(j,i)-c1(4))^2))/w^2);    
      miyo2(j,i)=max(0,(1-((d1(j,i)-c2(1))^2+(d2(j,i)-c2(2))^2+(d3(j,i)-c2(3))^2+(d4(j,i)-c2(4))^2))/w^2);   
      miyo3(j,i)=max(0,(1-((d1(j,i)-c3(1))^2+(d2(j,i)-c3(2))^2+(d3(j,i)-c3(3))^2+(d4(j,i)-c3(4))^2))/w^2);  
      miyo4(j,i)=max(0,(1-((d1(j,i)-c4(1))^2+(d2(j,i)-c4(2))^2+(d3(j,i)-c4(3))^2+(d4(j,i)-c4(4))^2))/w^2); 
      miyo5(j,i)=max(0,(1-((d1(j,i)-c5(1))^2+(d2(j,i)-c5(2))^2+(d3(j,i)-c5(3))^2+(d4(j,i)-c5(4))^2))/w^2); 
    end
end
max1=max(miyo0,miyo1);
max2=max(miyo2,miyo3);
max3=max(miyo4,miyo5);
max4=max(max1,max2);
miyomax=max(max4,max3);
for i=2:r-1
    for j=2:c-1
        if miyo0(i,j)==miyomax(i,j)
            class(i,j)=0;
        else
            if miyo1(i,j)==miyomax(i,j)
            class(i,j)=1;
            else
                if miyo2(i,j)==miyomax(i,j)
            class(i,j)=2;
                else
                    if miyo3(i,j)==miyomax(i,j)
                    class(i,j)=3;
                    else
                        if miyo4(i,j)==miyomax(i,j)
                    class(i,j)=4;
                        else
                            if miyo5(i,j)==miyomax(i,j)
                    class(i,j)=5;
                    else
                                class(i,j)=0;
                            end
                        end
                    end
                end
            end
        end
    end
end
for i=2:r-1
    for j=2:c-1
        if class(i,j)==0
            image(i,j)=1;
        else
            if class(i,j)==5
              image(i,j)=0;
                                
               end
        end;end;end
image2=image;
for i=2:r-2
    for j=2:c-2   
            %%%%%%%%%%%%%%%%%
                   if class(i,j)==1
                m1=max(d3(i-1,j+1),d3(i+1,j-1));pixelmax=max(m1,d3(i,j));
                if d3(i,j)==pixelmax
                    image(i,j)=0;                                 
               % else
                %    if (class(i-1,j+1)==0) & (class(i+1,j-1)==0)
                 %    image(i,j)=0;
                    else
                        image(i,j)=1;
              %  end   
                end  
            %%%%%%%%%%%%%
            else
                if class(i,j)==2
                 m1=max(d4(i,j+1),d4(i,j-1));
                 pixelmax=max(m1,d4(i,j));
                 if d4(i,j)==pixelmax
                    image(i,j)=0;
                     
                 %else
                        % if (class(i,j+1)==0) & (class(i,j-1)==0)
                    % image(i,j)=0;
                          else
                        image(i,j)=1;
              %  end
                          end
                %%%%%%%%%%%
            else
                if class(i,j)==3
                 m1=max(d1(i+1,j+1),d1(i-1,j-1));pixelmax=max(m1,d1(i,j));
                 if d1(i,j)==pixelmax
                  image(i,j)=0;
                 % else
                       % if (class(i+1,j+1)==0) &(class(i-1,j-1)==0)
                 %  image(i,j)=0;
                        else
                            image(i,j)=1;
               % end
                          end                 
                end
            %%%%%%%%%%%%%%%
                            if class(i,j)==4
                 m1=max(d2(i+1,j),d2(i-1,j));pixelmax=max(m1,d2(i,j));
                 if d2(i,j)==pixelmax
                    image(i,j)=0;
               %  else
                       % if (class(i-1,j)==0) & (class(i+1,j)==0)
                    % image(i,j)=0;
                                         else
                        image(i,j)=1;
               % end
                 end 
                            
                  end
                end
            end
        end
          end
           count2=zeros(r,c);
           for sara=1:2
    for s=3:r-2
    for m=3:c-2
 count2(s,m)=image(s-1,m-1)+image(s-1,m)+image(s-1,m+1)+image(s,m-1)+image(s,m+1)+image(s+1,m-1)+image(s+1,m)+image(s+1,m+1)+image(s,m)+image(s,m-2)+image(s,m+2)+image(s-1,m-2)+image(s-1,m+2)+image(s-2,m-2)+image(s-2,m-1)+image(s-2,m)+image(s-2,m+1)+image(s-2,m+2)+image(s+1,m-2)+image(s+1,m+2)+image(s+2,m-2)+image(s+2,m-1)+image(s+2,m)+image(s+2,m+1)+image(s+2,m+2);
    end
    end
          for i=2:r-1
           for j=2:c-1
             count1(i,j)=image(i-1,j-1)+image(i-1,j)+image(i-1,j+1)+image(i,j-1)+image(i,j+1)+image(i+1,j-1)+image(i+1,j)+image(i+1,j+1)+image(i,j);
             if image(i,j)==0 &( count1(i,j)==8)
                 image(i,j)=1;
             else
                 if image(i,j)==0 &( count1(i,j)==7)&(count2(i,j)==23 )
    image(i,j)=1;   
                 end
end
end
          end
           end
           
 figure(1)
imshow(imageRGB); 
title('RGB image')
figure(2)
ax(2)=subplot(1,2,2);
imshow(image);
title('CFED method ')
ax(1)=subplot(1,2,1);
BW2 = edge(imageuint,'canny',threshold,sigma);
 imshow(1-BW2)
% imshow(image2)
title('Canny method ')