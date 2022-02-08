function nc = noCollision(p_new, p_near, obstacle)
o = obstacle  ;
p1 = p_new ; 
p2 = p_near ; 
for i = 1:1:length(o)
    C = [ o(i,1) o(i,2)] ; 
    R = o(i,3) / 2 ;
    d1c = norm( [(p1(1)-C(1)); (p1(2)-C(2))] ); % distance of P1 from the centre
    d2c = norm( [(p2(1)-C(1)); (p2(2)-C(2))] ); % distance of P2 from the centre
    if (d2c<R) && (d1c<R) % the line is inside the circle % not colliding but not useable
        flag_intersect = false ;
    elseif (d1c<R) && (d2c>R) % one of the points of the line is inside the circle
        flag_intersect = false;
    elseif (d2c<R) && (d1c>R) % one of the points of the line is inside the circle
        flag_intersect = false;
    else
        P12 = [(p2(1)-p1(1)) ; (p2(2)-p1(2))]; % line vector
        uP12 = P12/norm(P12); % normalize the line vector
        P1C = C - p1 ; % vector from one of the points to the center
        v = abs( uP12(1)*P1C(2) - uP12(2)*P1C(1) );
        flag_intersect = (v > R);
    end
    nc = flag_intersect ;
    if flag_intersect == 0 % the line is colliding with one of the circles(obstacles)
        break ;
    end
end
end