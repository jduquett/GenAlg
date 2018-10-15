Population population;
PVector goal = new PVector(100, 100);
int gen = 0;

void setup(){
  size(800, 800);
  frameRate(100);
  population = new Population(1000);
}

void draw(){
  background(255);
  
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);
  fill(0, 0, 255);
  
  rect(0, 300, 600, 10);
  rect(300, 600, 600, 10);
  
  if(population.allDotsDead()){
    population.calculateFitness();
    population.naturalSelection();
    population.mutate();  
    gen++;
    System.out.println("Current Gen: " + gen);
  } else {
    population.update();
    population.show();
  }
}
