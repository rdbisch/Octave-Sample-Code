% Run kmeans on X with n cluster centers.
function [clusters, mu] = kmeans2(X, n)

	% This is needed for the distance step
	%  but there is no need to recompute it every loop.
	xx = sum(X .* X, 2)';

	m = rows(X);
	% Randomly initialize cluster centers
	mu = rand(n, columns(X));

	% 100 is arbitrary maximum number of iterations
	for i = 1:100
		% Distance calculation temporaries
		mumu = sum(mu .* mu, 2)';
		Xmu  = X*mu';

		% Compute the distance and assign the cluster in one swoop
		[minv clusters] = min(
			(sqrt(repmat(xx',[1 size(mumu, 2)])
			+ repmat(mumu, [size(xx, 2) 1])
			- 2*Xmu))'
		);

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
