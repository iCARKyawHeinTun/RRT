% to create new nodes according to defined EPS length
function newnode = create_new_node (qrand,qnear,val,EPS)
newnode = [ 0 0 ] ; 
% Steer towards qn with maximum step size of eps
% the following formula can be calculated using the similarity of triangles
if val >= EPS 
    qnew(1) = qnear(1) + ((qrand(1)-qnear(1))*EPS)/dist(qrand,qnear);
    qnew(2) = qnear(2) + ((qrand(2)-qnear(2))*EPS)/dist(qrand,qnear);
else
    qnew(1) = qrand(1);
    qnew(2) = qrand(2);
end
newnode = [qnew(1) qnew(2)];
end