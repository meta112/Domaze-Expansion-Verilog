# Jujutsu Kaisen: Domaze Expansion
 
## Introduction

A maze game played on an FPGA, developed to work on the [De1-SoC Board](https://www.intel.com/content/www/us/en/partner/showcase/offering/a5b3b0000004cbaAAA/de1soc-board.html) using Verilog, that follows a Jujutsu Kaisen themed plot through cutscenes similar to a visual novel (though not on that scale). The story is fan-made and purely for entertainment purposes; we do not claim ownership over the characters or franchise, nor will we use this for commercial profit.

![Domaze Expansion Title Screen](/ReadmeImages/domaze_title.jpg)

## Gameplay

The game displays on a VGA screen, beginning with the title screen. Press key\[3\] on the FPGA to progress through the story, which involves 3 different scenes. After each scene, a maze is drawn on the screen. You (the player) are represented by the pink square, and the destination is the white square in the maze. 

To move, you can use key\[3\] and key\[1\] to move left and right respectively. Key\[2\] is used to move vertically; the switch SW\[0\] can be flicked up or down to determine which direction Key\[2\] moves. Key\[0\] is used as a reset. You can also connect the FPGA to a PS2 keyboard and use the WASD keys to control movement.

As you progress through the game, the mazes increase in complexity, but the alloted time increases as well. Time remaining is shown on the seven-segment displays, while the ten LEDs represent the percentage of time remaining (in multiples of 10).

![Domaze Expansion Cutscene](/ReadmeImages/domaze_scene.jpg)
![Domaze Expansion Maze](/ReadmeImages/maze.jpg)

### WILL ADD TO README:
- installation/running instructions