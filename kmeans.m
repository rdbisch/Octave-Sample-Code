% Run kmeans on X with n cluster centers.
function [clusters, mu] = kmeans(X, n)
	m = rows(X);
	% Randomly initialize cluster centers
	mu = rand(n, columns(X));

	% 100 is arbitrary maximum number of iterations
	for i = 1:100

		% Loop through the data row by row, computing the distance
		%  to cluster centers and ultimately assigning a new cluster
		%  center
		clusters = zeros(m, 1);
		for j = 1:m
			d = sum((repmat(X(j, :), n, 1) - mu) .^ 2, 2);
			[minv clusters(j)] = min(d);	
		end

		% update cluster means
		mu_next = zeros(n, columns(X));
		for j = 1:n
			mu_next(j,:) = mean(X(clusters==j,:));
		end	

		% check convergence
		conv = sum(sum( (mu_next - mu) .^2 ))
		mu = mu_next;

		% arbitrary breaking point
		if (conv < 1e-4) break;
	end
end
