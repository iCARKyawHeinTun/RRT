% the following program is the RRT sampling algorithm
% obstacles.csv file has to be in the same folder as the program

clear ;
clc ; 

obstacles           =   readmatrix('obstacles.csv','CommentStyle','#') ;
start.coord         =   [ -0.5 -0.5 ] ; 
goal.coord          =   [ 0.5 0.5 ] ; 
numNodes            =   300 ; 
EPS                 =   0.2 ; 
nodes               =   start ; 
nodes_matrix        =   [ 1 cell2mat(struct2cell(nodes)) 1.4142 ] ; 
count               =   1 ; 
edges               =   [  ] ; 
path                =   [ ] ; 
parent_node         =   0 ; 
a = 1 ; 
b = 1 ;

for i = 1:1:numNodes
    sz = size(nodes)  ;
    rand_node.coord = [ rand_gen() rand_gen() ]  ;
    % Break if goal node is already reached
        if dist(nodes(sz(1)).coord,goal.coord) < EPS % one of the nodes is inside the goal range
           break  ;
        end
    ndist               =   [ ] ; 
    for j = 1:1:length(nodes)
        n = nodes(j);
        tmp = dist(n.coord, rand_node.coord) ;
        ndist = [ndist tmp] ;
    end
    [val, idx] = min(ndist);
    near_node = nodes(idx)  ;
    if noCollision(rand_node.coord, near_node.coord, obstacles)
        new_node.coord = create_new_node(rand_node.coord, near_node.coord, val, EPS)  ;
        nodes = [ nodes ; new_node ] ;
        cost_to_go =    dist(rand_node.coord , goal.coord) ;
        count = count + 1 ; 
        nodes_matrix = [ nodes_matrix ; count cell2mat(struct2cell(new_node)) cost_to_go ] ; 
        ind     = find(nodes_matrix(:,2:3)==cell2mat(struct2cell(near_node))) ;
        edges = [ edges ; ind(1) height(nodes_matrix) dist(new_node.coord, near_node.coord)] ; 
    end
end

nodes_matrix    =   [ nodes_matrix ; count+1 cell2mat(struct2cell(goal)) 0 ] ; 
edges           =   [ edges ;edges(height(edges),2) edges(height(edges),2)+1 dist(nodes(sz(1)).coord,goal.coord) ] ;

% trace backword for the path
flag = sz(1) ; 
while parent_node ~= 1 
                index       =   find(edges(:,2)==flag) ;
                parent_node =   edges(index,1)  ;
                flag           =   parent_node ;
                path        =   [ path parent_node ] ;
end
path        =   [ nodes_matrix(height(nodes_matrix))  path ] ;
path        =   flip(path) ;

% write to csv file  
csvwrite('nodes.csv',nodes_matrix) ;
csvwrite('edges.csv',edges) ; 
csvwrite('path.csv',path) ; 