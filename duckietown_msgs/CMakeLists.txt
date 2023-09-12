cmake_minimum_required(VERSION 2.8.3)
project(duckietown_msgs)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  message_generation
  std_msgs
  geometry_msgs
  sensor_msgs
)

add_message_files(
  FILES
  Twist2DStamped.msg
  WheelsCmd.msg
  WheelsCmdStamped.msg
  WheelEncoderStamped.msg
  BoolStamped.msg
  LEDPattern.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
  geometry_msgs
  sensor_msgs
)


catkin_package(
   CATKIN_DEPENDS
   geometry_msgs
   roscpp rospy
   sensor_msgs
   std_msgs
   message_runtime
)


include_directories(
  ${catkin_INCLUDE_DIRS}
)
