rods = [1 1 2; 2 2 4; 3 2 3; 4 1 3; 5 3 4; 6 4 6; 7 4 5; 8 3 5; 9 5 6; 10 6 8; 11 6 7; 12 5 7; 13 7 8; 14 8 9; 15 7 9];
joints = [1 0 0; 2 0.5 0; 3 0.5 0.5; 4 1 0.5; 5 1 1; 6 1.5 1; 7 1.5 1.5; 8 2 1.5; 9 2 2];
reactions = [1 1 1; 9 1 0];
load = [3 0 1; 4 10 0;8 20 0];


truss_plotter(rods,joints,reactions,load);
sol = truss_analyser(rods,joints,reactions,load);
results_visualizer(rods,joints,sol,reactions,load)
