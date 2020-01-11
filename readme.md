
# Genetic algorithm 
This repository implements a very simple genetic algorithm for real valued optimization. The code is tested on Maple 18.

# Features
 - Mean crossover
 - Add small random vector for mutation
 - Tournament selection
 - Remove worst survivor selection 


# Arguments

The function arguments are defined as

    GA := proc(cost, Dimension, bd_min, bd_max, Npop:=10,  Nchildren:=5, mutation_prob:=.6, epsilon:=1e-6, verbose:=false)

- `cost` : A function which computes the cost value.
- `Dimension` : The number of cost function arguments.
- `bd_min, bd_max` : The minimum and maximum values of each dimension.
- `Npop` : Size of the population.
- `Nchildren` : How many children should be generated at each iteration
- `mutation_prob` : The probability of mutation.
- `epsilon` : The threshold for early stopping. the evolution will stop after 20 epochs if the cost change is smaller than `epsilon` .
- `verbose` : whether to print the evolution or not.

# Usage
 - Copy `GeneticAlgorithm.mpl` file beside your script.
 - Copy this to the first line of your script, possibly after `restart;` statement. This code tested on Linux operating system and Maple 18, may need some change on Windows operating system and older Maple versions.
 
       read sprintf("%s/%s", interface(worksheetdir), "GeneticAlgorithm.mpl");

- Now you can import the `GeneticAlgorithm` package using
    
      with(GeneticAlgorithm);
      
- Define the cost function:

      cost := proc (x)
          return add(i^2, i in x);
      end proc
      
- The parameters

      minbd, maxbd := -5, 5;
      Dimension := 5;
      Npop := 30;
      Niteration := 1000;
      mutation_prob := 0.09;
      Nchildren := 15;
      epsilon := 1e-15;
      verbose := true;


- Call the `GA` optimizer

      result := GA(cost, Dimension, minbd, maxbd, Npop, Nchildren, mutation_prob, epsilon, verbose):
      best, hist := result[1], result[2]:

- Result

      iteratin 0001, cost=8.82e-01
      iteratin 0020, cost=8.67e-06
      iteratin 0040, cost=5.71e-07
      iteratin 0060, cost=1.81e-07
      iteratin 0080, cost=9.39e-09
      iteratin 0100, cost=4.70e-10
      iteratin 0120, cost=1.30e-11
      iteratin 0140, cost=3.55e-15
      iteratin 0160, cost=2.80e-19
      iteratin 0162, cost=1.35e-19

