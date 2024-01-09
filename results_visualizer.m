function results_visualizer(rods,joints,tensions,reactions,load)

axis off
axis equal
xlim auto
ylim auto
hold on
set(gcf,'color','w');
title("Results Visualizer","FontSize",15)

% Plotting the truss
h = [];
for i=1:size(rods,1)
    x = [];
    y = [];
    x(1) = joints(rods(i,2),2);
    x(2) = joints(rods(i,3),2);
    y(1) = joints(rods(i,2),3);
    y(2) = joints(rods(i,3),3);
    if abs(tensions(i))<0.000001
        tensions(i) = 0;
    end
    if tensions(i)>0
        h(1) = plot(x,y,"Color","r","LineWidth",1.3);
    elseif tensions(i)<0
        h(2) = plot(x,y,"Color","g","LineWidth",1.3);
    else
        h(3) = plot(x,y,"Color","k","LineWidth",1.3);
    end
end

% labelling
for i=1:size(joints,1)
    x = joints(i,2);
    y = joints(i,3);
    a = 0.1;
    if x<=y 
        a = a*-1;
    end
    text(x+a,y,num2str(joints(i,1)))
end

% Plotting the support reactions
for i=1:size(reactions,1)
    joint = reactions(i,1);
    x = joints(joint,2);
    y = joints(joint,3);
    lines(x,y,i,reactions,"b","R"+i)
end

% Plotting external loads
for i=1:size(load,1)
    joint = load(i,1);
    x = joints(joint,2);
    y = joints(joint,3);
    lines(x,y,i,load,"m","F"+i)
end
hold off

% Function to plot external lines
function lines(x,y,i,reactions,k,l)
    a = 0.2; b = 1;
    if reactions(i,2)>0
        if x==0
            a = -0.2; b = -1;
        end
        plot([x+a,x+b],[y,y],"Color",k,"LineWidth",1.5)
        text((x+b)-2*a,y-0.1,l+"x")
    end
    a = 0.2; b = 1;
    if reactions(i,3)>0
        if y==0
            a = -0.2; b = -1;
        end
        plot([x,x],[y+a,y+b],"Color",k,"LineWidth",1.5)
        text(x-0.3,(y+b)-2*a,l+"y")
    end