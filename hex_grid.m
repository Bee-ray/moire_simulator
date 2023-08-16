%   this function generates a regular hexagonal lattice from the following
%inputs: the lattice constant of the equilateral triangular matrix that is
%used to generate the hex lattice (lc), the angle that the hex lattice is
%to be rotated by (angle, ccw w.r.t. the x-axis), and the two arguments
%passed to meshgrid (mesh_min and mesh_max).
function [P] = hex_grid(lc, angle, disp_x, disp_y, mesh_min, mesh_max)

%this line generates the 2x2 basis matrix V from the normal, non-orthogonal
%basis vectors v1=x_hat, v2=(1/2)x_hat + (sqrt(3)/2)y_hat; these vectors
%are scaled by a factor of a1, and rotated (together) by x radians ccw
%w.r.t. the x-axis.
Vx = lc*[cos(angle) -sin(angle); sin(angle) cos(angle)]*[1;0];
Vy = lc*[cos(angle) -sin(angle); sin(angle) cos(angle)]*[0.5;sqrt(3)/2];
V=[Vx Vy];
%[1 0.5;0 sqrt(3)/2]

%the next two lines generate the coordinates for each virtual dot in the
%triangular grid, from which the real dots in the hex grid will be
%generated (see plot_dots.m to see how this line works)
[n1,n2] = meshgrid(mesh_min:mesh_max);
P_0 = V * [ n1(:) n2(:) ].';

%Note: in order for this program to work for rotated hex grids, you
%must rotate the "y vector" that puts one real dot 'above' and
%another 'below' each virtual dot. disp_vector tells you where to put the
%real dots wrt the virtual ones. it takes the displacement vector for a
%non-rotated, non-scaled triangular lattice (i.e., the vector 0 x_hat +
%(sqrt(3)/6) y_hat) and rotates it by x and scales it by lc.
disp_vector=lc*[cos(angle) -sin(angle); sin(angle) cos(angle)]*[0;sqrt(3)/6];

%the following loop generates the matrix of coordinates P; for every point
%in P_0, two points get added to P: one at the virtual point minus
%disp_vector, and one at the virtual point plus disp_vector. the loop does
%this addition and subtraction component-wise.
P=zeros(2,2*length(P_0));
for i=1:2:2*length(P_0)
    P(1,i)=P_0(1,(i+1)/2) - disp_vector(1);
    P(1,i+1)=P_0(1,(i+1)/2) + disp_vector(1);
    P(2,i)=P_0(2,(i+1)/2) - disp_vector(2);
    P(2,i+1)=P_0(2,(i+1)/2) + disp_vector(2);
end

%the following two lines add a constant x and y displacement to the grid,
%which can be zero
P(1,:) = P(1,:) + disp_x;
P(2,:) = P(2,:) + disp_y;

%i don't think the bit commented out here is necessary, but i'm keeping it
%for now in case i'm wrong:
%if mod(length(P_0),2)==0
%    i=length(P_0);
%    P(1,i)=P_0(1,(i+1)/2);
%    P(1,i+1)=P_0(1,(i+1)/2);
%    P(2,i)=P_0(2,(i+1)/2) - a1*sqrt(3)/6;
%    P(2,i+1)=P_0(2,(i+1)/2) + a1*sqrt(3)/6;
%end
