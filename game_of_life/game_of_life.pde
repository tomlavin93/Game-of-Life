int[][] cells; 
int[][] cellsBuffer;

int start;
int m;
int timeInterval = 100;
int lastRecordedTime = 0;
int textFade = 0;

float initialLiveCellProbability = 20;

void setup(){
  size(500,500);
  
  
  cells = new int[width/10][height/10];
  cellsBuffer = new int[width/10][height/10];
  
  // initialisation of cells
  for (int x=0; x<width/10; x++) {
    for (int y=0; y<height/10; y++) {
      float state = random (100);
      if (state > initialLiveCellProbability) { 
        state = 0;
      }
      else {
        state = 1;
      }
      cells[x][y] = int(state); // saves state of each cell
    }
  }  
}

void draw(){
  
  m = millis();
  
  if (m-start > 20000){
      if(textFade < 255){
        textFade++;
      }
  }

//draw grid
  for(int x=0; x<50; x++){
    for(int y=0; y<50; y++){
      if(cells[x][y]==1){
        fill(0); 
      } else {
        fill(255);
      }
        drawCell(x*10, y*10);
      }
      if (m-lastRecordedTime>timeInterval) {
      iteration();
      lastRecordedTime = m;
      }

//draws text telling the user how to reset the game
      if (m-start > 20000){
          fill(0, 102, 153,textFade);
          textSize(16);
          textAlign(CENTER, CENTER);
          text("Press the space bar to reset",250,250);
        }
        println(textFade);   
  }

}

void iteration(){
  
  for (int x=0; x<width/10; x++) {
    for (int y=0; y<height/10; y++) {
      cellsBuffer[x][y] = cells[x][y]; //saves cells to the buffer
    }
  }
  
  
  //check surrounding cells
  for (int x=0; x<width/10; x++) {
     for (int y=0; y<width/10; y++) {
      int surroundingCells = 0;
        for (int a=x-1; a<=x+1;a++) {
          for (int b=y-1; b<=y+1;b++) {  
            if (((a>=0)&&(a<width/10))&&((b>=0)&&(b<height/10))) {
              if (!((a==x)&&(b==y))) { //checks against original cell
                if (cellsBuffer[a][b]==1){
                  surroundingCells++; //counts the number of alive surrounding cells
                }
              }
            }
          }
        }
        if (cellsBuffer[x][y]==1){ //if the cell is alive
          if (surroundingCells<2 || surroundingCells>3){
           cells[x][y] = 0; //kill it if it has 2 or 3 neighbours 
          }
        } else { // the cell is dead, make it live if it has 3 alive surrounding cells
          if (surroundingCells == 3 ) {
          cells[x][y] = 1;
        }
        }
     }
  }
  
  
  
}

void keyPressed(){
  
  //resets the game
  if (key==' '){
    for (int x=0; x<width/10; x++) {
      for (int y=0; y<height/10; y++) {
        float state = random (100);
        if (state > initialLiveCellProbability) {
          state = 0;
        }
        else {
          state = 1;
        }
        cells[x][y] = int(state); // Save state of each cell
      }
    }
    start = millis();
  }
}


void drawCell(int xPos, int yPos){
  
  //draws each cell
  stroke(200);
  rect(xPos,yPos, 10, 10);
  
}
