import de.voidplus.leapmotion.*;
import development.*;

import processing.opengl.*;

LeapMotion leap;

// Variables for object data
float y = 0.05;
float x = 0.05;
float z = 0.05;

// Variables for hand data
PVector prev_leftHandPos = new PVector(0,0,0);
PVector prev_rightHandPos  = new PVector(0,0,0);
PVector current_leftHandPos = new PVector(0,0,0);
PVector current_rightHandPos  = new PVector(0,0,0);
float past_dist_between_hands, current_dist_between_hands;

// Keep track of frames for gestures
int motion_framecount;
int MAX_motion_framecount = 20;

void setup(){
  size(800,600,P3D);
  smooth();
  leap = new LeapMotion(this);
}

void draw(){
  // Count number of hands detected
  int number_of_hands = leap.getHands().size();
  
  // Draw cube
  //drawObject();
  
  // DEBUG : Draw hands
  background(255);
  for( Hand hand : leap.getHands() ) hand.draw();
  
  // Set motion framecounts
  startMotionFramecount();
  //else motion_framecount = 0;
  
  if( motion_framecount == 0 ) get_hand_position("prev");
  else if( motion_framecount == MAX_motion_framecount - 5 ) get_hand_position("current");
  
  if( past_dist_between_hands < 100 && current_dist_between_hands > 100 ) motion_grow();
  else ;
  //println(past_dist_between_hands, current_dist_between_hands, past_dist_between_hands - current_dist_between_hands );
  for( Hand hand : leap.getHands() ){ 
    for( Finger finger : hand.getFingers() ){
      if( finger.getType() == 1 ) ;
      println( finger.getType(), finger.getStabilizedPosition() );
    }
  }
}

void get_hand_position(String s){
  if( s == "prev" ){
    for(Hand hand : leap.getHands()){
      for( Finger finger : hand.getFingers() ){
        if( hand.isLeft() ){ 
          prev_leftHandPos  =  hand.getStabilizedPosition();
        }
        else if( hand.isRight() ){ 
          prev_rightHandPos =  hand.getStabilizedPosition();
        }
      }
    }
      
      // Calculate distance between hands
      past_dist_between_hands = PVector.dist( prev_leftHandPos, prev_rightHandPos );
    }
  
  else if( s == "current" ){
    for(Hand hand : leap.getHands()){
      if( hand.isLeft() ) current_leftHandPos  =  hand.getStabilizedPosition();
      else if( hand.isRight() ) current_rightHandPos =  hand.getStabilizedPosition();
      
      // Calculate distance between hands
      current_dist_between_hands = PVector.dist( current_leftHandPos, current_rightHandPos );
    }
  }
}

/* Increase motion framecounts 
 * Gestures occur within a certain number of frames
 */
void startMotionFramecount(){
  if( motion_framecount < MAX_motion_framecount ) motion_framecount ++;
  else motion_framecount = 0;
}
