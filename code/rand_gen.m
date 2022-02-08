% to generate random numbers between the axis limit range
function sample = rand_gen() 
axis_min = -0.5 ; % x and y axis limits
axis_max = 0.5 ; 
sample = (axis_max - axis_min).*rand(1) + axis_min ;
end