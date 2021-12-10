GeneticAlgorithm := module ()
	description "Genetic algorithm";
	export GA;
	option package;
	local random_float, random_int, crossover, mutation, selection, get_costs;
	random_float := proc (n, a, b)
		return RandomTools:-Generate(('Vector')(float(range = a .. b), n))
	end proc;
	random_int := proc (n, a, b)
		return RandomTools:-Generate(('Vector')(integer(range = a .. b), n))
	end proc;
	crossover := proc (x, y)
		return (1/2)*x+(1/2)*y;
	end proc;
	mutation := proc (x)
		local t;
		t := random_float(numelems(x), -abs(floor(max(x))), abs(floor(max(x))));
		return x+t;
	end proc;
	selection := proc (population, k := 7)
		local costs, solution, indxs, pops, best;
		if k < 2 then
			print("k must be &ge; 2");
			return;
		end if;
		indxs := convert(random_int(k, 1, nops(population)), list);
		pops := population[indxs];
		best := get_costs(pops, true)[1];
		return [pops[best[1]], pops[best[2]]];
		end proc;
	get_costs := proc (population, sorted := false)
		local costs, solution, best;
		costs := [];
		for solution in population do
			costs := [op(costs), cost(solution)]
		end do;
		if sorted = true then
			best := sort(costs, output = permutation);
			return [best, costs[best[1]]]
		else
			return costs;
		end if
	end proc;

	GA := proc (cost, Dimension, bd_min, bd_max, Npop := 10, Nchildren := 5, mutation_prob := .6, epsilon := 0.1e-5, verbose := false)
		local i, history, population, iter, j, tmp, x, y, prob, child, best, c, global_best;
		population := [seq(random_float(Dimension, bd_min, bd_max), i = 1 .. Npop)];
		history := [];
		for iter to Niteration do
			for j to Nchildren do
				tmp := selection(population);
				x, y := tmp[1], tmp[2];
			 	tmp := crossover(x, y);
			 	prob := (rand(0 .. 1.0))();
			 	if mutation_prob < prob then
			 		child := mutation(tmp);
			 	end if;
				population := [op(population), child];
			end do;
			tmp := get_costs(population, true);
			best, c := tmp[1], tmp[2];
			history := [op(history), c];
			global_best := population[best[1]];
			population := population[best[1..Npop]];

			if 20 < iter and abs(history[iter]-history[iter-20]) < epsilon then
				if verbose = true then
			 		printf("iteratin %04d, cost=%.02e\n", iter, c);
			 	end if;
			 	break;
			end if;
			if verbose = true and (`mod`(iter, 20) = 0 or iter = 1 or iter = Niteration) then
				printf("iteratin %04d, cost=%.02e\n", iter, c);
			end if;
		end do;
		return global_best, history;
	end proc;
end module;
