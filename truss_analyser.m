function d = truss_analyser(rods,joints,reactions,load)

% Finding out which forces are acting on which joints
A = zeros(size(joints,1));
for i=1:size(joints,1)
    for j=1:size(rods,1)
        if rods(j,2) == i || rods(j,3) == i
            A(i,rods(j,1)) = 1;                           % Tensions in the rods
        end
    end
end
aa = size(A,2);
for i=1:size(reactions,1)                                 % Support reactions
    A(reactions(i,1),aa+i) = reactions(i,2);
    A(reactions(i,1),aa+2+i) = reactions(i,3);
end

% Forming co-efficient matrix
B = [];
for k=1:size(A,1)
    current = [joints(k,2),joints(k,3)];                  % Storing value of current joint
    for i=1:size(A,2)-4
        if A(k,i)==1
            x1 = joints(rods(i,2),2);
            y1 = joints(rods(i,2),3);
            x2 = joints(rods(i,3),2);
            y2 = joints(rods(i,3),3);
            if x1==current(1) && y1==current(2)           % Storing values of the joints associated with rod
                second = [x2,y2];
            else
                second = [x1,y1];
            end
            dist = sqrt((x1-x2)^2 + (y1-y2)^2);           % Calculating distance between two points
            B(k*2-1,i) = (second(1)-current(1))/dist;     % Calculating direction components
            B(k*2,i) = (second(2)-current(2))/dist;
        end
    end
    for i=size(A,2)-3:size(A,2)-2                         % Support reactions
        B(k*2-1,i) = A(k,i);
    end
    for i=size(A,2)-1:size(A,2)
        B(k*2,i) = A(k,i);
    end
end
disp(B)

% Forming result matrix
b = zeros(size(B,1),1);
for i=1:size(load,1)
    b(2*load(i,1)-1) = load(i,2);
    b(2*load(i,1)) = load(i,3);                           
end  

% Calculating tensions using Gauss Jordan Elimination method                 
[~,jmax] = size(B);                      
aug = B;
aug(:,jmax+1) = b(:,1);                                   % Forming augmented matrix
f2 = rref(aug);

d = f2(:,jmax+1);

% Printing
fprintf("\n Rod No.\tTension\n\n") 
unknowns = size(d,1)-3;
for i=1:unknowns
    if abs(d(i))<0.000001
        d(i)=0;
    end
    fprintf("  "+num2str(i)+"\t\t"+num2str(d(i))+"\n")
end

a = "x";
fprintf("\nSupport Reactons: \n\n")
for i=2:size(reactions,2)
    if i==3
        a = "y";
    end
    for j=1:size(reactions,1)
        if reactions(j,i)==1
            fprintf("R"+j+a+" = "+num2str(d(unknowns+1))+"\n")
            unknowns = unknowns+1;
        end
    end
end