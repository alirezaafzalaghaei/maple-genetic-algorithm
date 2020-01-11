# Genetic algorithm 
This repository implements a very simple genetic algorithm for real valued optimization. The code is tested on Maple 18.

# Features
 - Mean crossover
 - Add small random vector for mutation
 - Tournament selection
 - Remove worst survivor selection 

# Usage
- Copy `GA` procedure to your worksheet
- Define **cost** function which gets a column vector and returns a simple float value.
- Define genetic algorithm parameters, e.g. population size, number of iterations, etc.
- Call `GA` function with parameters.
- The `GA` function return the best solution found and history of evolution.

# Arguments

The function arguments are defined as

    GA := proc(cost,Dimension,bd_min,bd_max, Npop:=10, Nchildren:=5,mutation_prob:=.6,epsilon:=1e-6,verbose:=false)

- `cost` : A function which computes the cost value.
- `Dimension` : The number of cost function arguments.
- `bd_min, bd_max` : The minimum and maximum values of each dimension.
- `Npop` : Size of the population.
- `Nchildren` : How many children should be generated at each iteration
- `mutation_prob` : The probability of mutation.
- `epsilon` : The threshold for early stopping. the evolution will stop after 20 epochs if the cost change is smaller than `epsilon` .
- `verbose` : whether to print the evolution or not.

# Example
The cost function:

    cost := proc (x)
        return add(i^2, i in x);
    end proc
The parameters

	minbd, maxbd := -5, 5;
	Dimension := 3;
	Npop := 10;
	Niteration := 10000;
	mutation_prob := .6;
	Nchildren := 5;
	verbose := true;
	epsilon := 0.1e-14;

Calling the `GA` optimizer

    result := GA(cost, Dimension, minbd, maxbd, Npop, Nchildren, mutation_prob, epsilon, verbose):
    best, hist := result[1], result[2]:

Result

    iteratin 0001, cost=6.62e+00
	iteratin 0020, cost=2.26e-02
	iteratin 0040, cost=6.72e-05
	iteratin 0060, cost=9.26e-11
	iteratin 0080, cost=2.00e-11
	iteratin 0100, cost=1.25e-11
	iteratin 0120, cost=1.25e-11
	iteratin 0140, cost=6.85e-12
	iteratin 0160, cost=1.12e-12
	iteratin 0180, cost=1.08e-14
	iteratin 0200, cost=2.67e-18
	iteratin 0207, cost=2.25e-18
