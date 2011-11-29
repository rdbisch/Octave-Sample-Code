% Run the two k-means algorithms side by side
function kmeans_test

	rand("seed", 31415926);
	% observations
	m = 10000;
	% dimenson of x
	k = 10;
	% number of clusters
	p = 3;

	% Generate X
	X = rand(m, k);

	% Reset seed and run algorithm 1
	rand("seed", 31415927);
	clock_start = clock();
	[clusters1 mu1] = kmeans(X, p);
	clock_stop = clock();
	disp("Algorithm 1 finished in "), disp(etime(clock_stop, clock_start))

	% Reset seed and run algorithm 2
	rand("seed", 31415927);
	clock_start = clock();
	[clusters2 mu2] = kmeans2(X, p);
	clock_stop = clock();
	etime(clock_stop, clock_start)	
	disp("Algorithm 2 finished in "), disp(etime(clock_stop, clock_start))
	
	% Print differences in mu
	disp("The differences in clusters are "), disp(mu2 - mu1)

	% Print total difference in cluster assignment 
	disp("The sum of the squared error of cluster assignments is"),
		disp(sum(clusters2' - clusters1) .^ 2)

end
		
