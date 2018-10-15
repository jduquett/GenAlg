import java.util.Comparator;
import java.util.Collections;

class Population{
  Dot[] population;
  
  float fitnessSum;
  int gen = 1;
  int bestDot = 0;
  int minStep = 1000;
  
  Population(int size){
    population = new Dot[size];
    for (int i = 0; i < size; i ++){
      population[i] = new Dot();
    }
  }
  
  void show(){
    for(int i = 1; i < population.length; i++){
      population[i].show();
    }
    population[0].show();
  }
  
  void update(){
    for(int i = 0; i < population.length; i++){
      if(population[i].brain.step > minStep){
        population[i].dead = true; 
      } else{
        population[i].update();
      }
    }
  }
  
  void calculateFitness(){
    for(int i = 0; i < population.length; i++){
      population[i].calculateFitness();
    }
  }
  
  boolean allDotsDead(){
    for(int i = 0; i < population.length; i++){
      if(!population[i].dead && !population[i].reachedGoal){
        return false;
      }
    }
    return true;
  }
  
  void naturalSelection(){
    Dot[] newPopulation = new Dot[population.length];
    setBestDot();
    calculateFitnessSum();
    
    newPopulation[0] = population[bestDot].reproduce();
    newPopulation[0].isBest = true;
    for(int i = 1; i < newPopulation.length; i++){
      if(i < newPopulation.length - 5){
        Dot parent = selectParent();
        newPopulation[i] = parent.reproduce();
      } else {
        newPopulation[i] = population[i];
      }
    }
    population = newPopulation.clone();
    gen++;
  }
  
  void calculateFitnessSum(){
    fitnessSum = 0;
    for(int i = 0; i < population.length; i++){
      fitnessSum += population[i].fitness;
    }
  }
  
  Dot selectParent(){
    float rand = random(fitnessSum);
    float runningSum = 0;
    
    for(int i = 0; i < population.length; i++){
      runningSum += population[i].fitness;
      if (runningSum > rand){
        return population[i];
      }
    }
    return null;
  }
  
  void mutate(){
    for(int i = 1; i < population.length; i++){
      population[i].brain.mutate();
    }
  }
  
  void setBestDot(){
    float max = 0;
    int maxIndex = 0;
    
    for(int i = 0; i < population.length; i++){
      if(population[i].fitness > max){
        max = population[i].fitness;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;
    
    if(population[bestDot].reachedGoal){
      minStep = population[bestDot].brain.step;
      println("step:", minStep);
    }
  } 
}
