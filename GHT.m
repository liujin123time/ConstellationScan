function [BestScore]= GHT(input,template,current,total)
%{
Input:
input: Color image with the object to be found.
template: Template of the object to be found. The template is written as binary image with the boundary of the template marked 1(white) and all the rest of the pixels marked 0. 

Output
Ismarked: The image (Isresize) with the template marked upon it in the location of and size of the best match.
Iborders: Binary image of the borders of the template/object in its scale and located in the place of the best match on the image. 
Ybest Xbest: location on the image (in pixels) were the template were found to give the best score (location the top left pixel of the template Itm in the image).
ItmAng: The rotation angle of  the template in degrees that give the best match
BestScore: Score of the best match found in the scan (the score of the output).

Algorithm:
The function rotate the template Itm in various of angles and for each rotation search for the template in the image. 
The angle and location in the image that gave the best match for the template are chosen.


%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%initialize optiona paramters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
template=logical(template);% make sure Itm is boolean image
BestScore=-100000;
%%%%%%%%%%%%%%%%Some parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555555555
St=size(template);
Ss=size(input);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Main Scan  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for Ang=0:5:360 % rotate the template Itm 1 degree at the time and look for it in the image Is
  disp([num2str((((Ang)/3.6) + (current - 1)*100)/total) '% Scanned']);
  Itr=imrotate(template,Ang);
%----------------------------------------------------------------------------------------------------------------------------------------- 
 % the actuall recogniton step of the resize template Itm in the orginal image Is and return location of best match and its score can occur in one of three modes given in search_mode
             score = Generalized_hough_transform(input,Itr);% use generalized hough transform to find the template in the image
     %--------------------------if the correct match score is better then previous best match write the paramter of the match as the new best match------------------------------------------------------
     if (score>BestScore) % if item  result scored higher then the previous result
           BestScore=score;% remember best score
     end;
end;
end