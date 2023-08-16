%   this function generates a rectangular lattice from the following
%inputs: the x-direction lattice constant lcx, the y-direction lattice
%constant lcy, the angle that the lattice is to be rotated ccw by (angle),
%the x and y displacement amounts (disp_x and disp_y), and the mesh grid
%min and max constants (mesh_min and mesh_max)
function [P] = rect_grid(lcx, lcy, angle, disp_x, disp_y, mesh_min, mesh_max)

%define the basis vector
Vx = lcx*[cos(angle) -sin(angle); sin(angle) cos(angle)]*[1;0];
Vy = lcy*[cos(angle) -sin(angle); sin(angle) cos(angle)]*[0;1];
V=[Vx Vy];

%create the grid
[n1,n2] = meshgrid(mesh_min:mesh_max);
P = V * [ n1(:) n2(:) ].';

%don't forget to add on the displacement constants
P(1,:) = P(1,:) + disp_x;
P(2,:) = P(2,:) + disp_y;
