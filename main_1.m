template=imread('Dataset/db.jpg');
candidate=imread('Dataset/0.jpg');
template_gray=rgb2gray(template);
candidate_gray=rgb2gray(candidate);
level_template= graythresh(template_gray);
bw_template= imbinarize(template_gray,level_template);
level_candidate= graythresh(candidate_gray);
bw_candidate= imbinarize(candidate_gray,level_candidate);
%bw_candidate
 x=0.0;y=0;z=0;c1=0;c2=0;col=1;j=1;
 %n_corr=[];
[rows1,cols1]=size(bw_template);
[rows,cols]=size(bw_candidate);
k = cols1/cols;
for i=1:k
 for c=(((i*30)+1)-30):(i*30)
    for r=1:rows
        x=x+(bw_candidate(r,col)*bw_template(r,c));
        c1=c1+(bw_candidate(r,col)^2);
        c2=c2+(bw_template(r,c)^2);
      
    end
            col=col+1;

 end
 col=1;
y=sqrt(c1*c2);
z=(x/y);
n_corr(j)=z;
c1=0;
c2=0;
x=0;
j=j+1;
end
a = length(n_corr);
max = 0;
for i=1:a
    if (n_corr(i) >= max)
        max = n_corr(i);
        loc = i;
    end
end
ypeak = 30;
xpeak = loc*30;
yoffSet = ypeak-size(bw_candidate,1);
xoffSet = xpeak-size(bw_candidate,2);
subplot(2,1,1),imshow(bw_candidate);
title("Input Image");
subplot(2,1,2),imshow(bw_template);
title("Template");
drawrectangle(gca,'Position',[xoffSet,yoffSet,size(bw_candidate,2),size(bw_candidate,1)], ...
    'FaceAlpha',0);
