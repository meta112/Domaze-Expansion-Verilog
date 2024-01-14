//

`timescale 1ns/1ns

module domaze_logic(iResetn, iClock, start, start_two, switch_up_down, skip_to_hardest,
                    mv_left, mv_vert, mv_right,
						  start_3,
                    oX,oY,oColour,oPlot,oDone,
                    hundreds, tens, ones, percent,
						  address_title_1, q_title_1,
						  address_title_2, q_title_2,
						  address_frame_1, q_frame_1,
						  address_frame_2, q_frame_2,
						  address_frame_3, q_frame_3,
						  address_frame_4, q_frame_4,
						  address_frame_5, q_frame_5,
						  address_frame_6, q_frame_6,
						  address_frame_7, q_frame_7,
						  address_frame_8, q_frame_8,
						  address_frame_9, q_frame_9,
						  address_frame_10, q_frame_10,
						  address_frame_11, q_frame_11,
						  address_frame_12, q_frame_12,
						  address_frame_13, q_frame_13,
						  address_frame_14, q_frame_14,
						  address_frame_15, q_frame_15,
						  address_frame_16, q_frame_16,
						  address_over, q_over,
						  address_end, q_end,
						  
						  key_data, key_en
						  );
   parameter X_SCREEN_PIXELS = 9'd320;
   parameter Y_SCREEN_PIXELS = 8'd240;
   parameter SIZE_UNIT_EASY = 64;
   parameter SIZE_UNIT_HARD = 16;
   parameter CLOCK_FREQUENCY = 50000000;

   input wire iResetn; 
   input wire 	    iClock;
	input wire start, start_two, switch_up_down, mv_left, mv_vert, mv_right;
	
	input wire start_3;
	
	input wire [2:0] q_title_1;
	input wire [2:0] q_title_2;
	input wire [2:0] q_frame_1;
	input wire [2:0] q_frame_2;
	input wire [2:0] q_frame_3;
	input wire [2:0] q_frame_4;
	input wire [2:0] q_frame_5;
	input wire [2:0] q_frame_6;
	input wire [2:0] q_frame_7;
	input wire [2:0] q_frame_8;
	input wire [2:0] q_frame_9;
	input wire [2:0] q_frame_10;
	input wire [2:0] q_frame_11;
	input wire [2:0] q_frame_12;
	input wire [2:0] q_frame_13;
	input wire [2:0] q_frame_14;
	input wire [2:0] q_frame_15;
	input wire [2:0] q_frame_16;
	input wire [2:0] q_over;
	input wire [2:0] q_end;
	
	
	input wire [7:0] key_data;
	input wire key_en;
	
	
    input wire [1:0] skip_to_hardest;
   output wire [8:0] oX;         // VGA pixel coordinates
   output wire [7:0] oY;

   output wire [2:0] oColour;     // VGA pixel colour (0-7)
   output wire 	     oPlot;       // Pixel draw enable
   output wire       oDone;       // goes high when finished drawing frame
    output wire [3:0] hundreds, tens, ones;
    output wire [9:0] percent;
	 
	 
	 output wire [14:0] address_title_1;
	 output wire [14:0] address_title_2;
	 output wire [14:0] address_frame_1;
	 output wire [14:0] address_frame_2;
	 output wire [14:0] address_frame_3;
	 output wire [14:0] address_frame_4;
	 output wire [14:0] address_frame_5;
	 output wire [14:0] address_frame_6;
	 output wire [14:0] address_frame_7;
	 output wire [14:0] address_frame_8;
	 output wire [14:0] address_frame_9;
	 output wire [14:0] address_frame_10;
	 output wire [14:0] address_frame_11;
	 output wire [14:0] address_frame_12;
	 output wire [14:0] address_frame_13;
	 output wire [14:0] address_frame_14;
	 output wire [14:0] address_frame_15;
	 output wire [14:0] address_frame_16;
	 output wire [14:0] address_over;
	 output wire [14:0] address_end;
	

	
	wire draw_title_1_enable;
	wire draw_title_2_enable;
	wire draw_frame_1_enable;
	wire draw_frame_2_enable;
	wire draw_frame_3_enable;
	wire draw_frame_4_enable;
	wire draw_frame_5_enable;
	wire draw_frame_6_enable;
	wire draw_frame_7_enable;
	wire draw_frame_8_enable;
	wire draw_frame_9_enable;
	wire draw_frame_10_enable;
	wire draw_frame_11_enable;
	wire draw_frame_12_enable;
	wire draw_frame_13_enable;
	wire draw_frame_14_enable;
	wire draw_frame_15_enable;
	wire draw_frame_16_enable;
	wire draw_frame_over_enable;
	wire draw_frame_end_enable;

   wire increment_LEFT, increment_UP, increment_RIGHT, increment_DOWN;
   wire clear_en_1, check_position, draw_maze_enable_1;
   wire draw_destination_enable_1, draw_character_enable_1;
   wire clear_en_2, check_position_2, draw_maze_enable_2;
   wire draw_destination_enable_2, draw_character_enable_2;
   wire clear_en_3, check_position_3, draw_maze_enable_3; 
   wire draw_destination_enable_3, draw_character_enable_3; 
   wire draw_victory_enable, draw_lose_enable;
    wire victory;
    wire victory_first;
    wire [1:0] level;
    wire enable_timer;
    wire timeout;
    wire [1:0] olevel; 


   control #(.X_SCREEN_PIXELS(X_SCREEN_PIXELS), .Y_SCREEN_PIXELS(Y_SCREEN_PIXELS), .SIZE_UNIT_EASY(SIZE_UNIT_EASY),
                .SIZE_UNIT_HARD(SIZE_UNIT_HARD), .CLOCK_FREQUENCY(CLOCK_FREQUENCY)) c0(
      .iResetn(iResetn),
      .iClock(iClock),
		.start(start), 
        .start_two(start_two),
		  .start_3(start_3), 
        .switch_up_down(switch_up_down),
        .skip_to_hardest(skip_to_hardest),
        .victory(victory),
        .mv_left(mv_left),
        .mv_vert(mv_vert),
        .mv_right(mv_right),
        .timeout(timeout),
        .olevel(olevel),
        .increment_LEFT(increment_LEFT),
        .increment_UP(increment_UP),
        .increment_RIGHT(increment_RIGHT),
        .increment_DOWN(increment_DOWN),
        .check_position(check_position),
        .check_position_2(check_position_2),
        .check_position_3(check_position_3), 

      .oPlot(oPlot),
      .victory_first(victory_first),
      .clear_en_1(clear_en_1),
      .clear_en_2(clear_en_2),
      .clear_en_3(clear_en_3),
      .draw_maze_enable_1(draw_maze_enable_1),
      .draw_maze_enable_2(draw_maze_enable_2),
      .draw_maze_enable_3(draw_maze_enable_3),
      .draw_destination_enable_1(draw_destination_enable_1),
      .draw_destination_enable_2(draw_destination_enable_2),
      .draw_destination_enable_3(draw_destination_enable_3),
      .draw_character_enable_1(draw_character_enable_1),
      .draw_character_enable_2(draw_character_enable_2),
      .draw_character_enable_3(draw_character_enable_3),
      .draw_victory_enable(draw_victory_enable),
      .draw_lose_enable(draw_lose_enable),
      .enable_timer(enable_timer),
      .level(level),
		
		.draw_title_1_enable(draw_title_1_enable),
		.draw_title_2_enable(draw_title_2_enable),
		.draw_frame_1_enable(draw_frame_1_enable),
		.draw_frame_2_enable(draw_frame_2_enable),
		.draw_frame_3_enable(draw_frame_3_enable),
		.draw_frame_4_enable(draw_frame_4_enable),
		.draw_frame_5_enable(draw_frame_5_enable),
		.draw_frame_6_enable(draw_frame_6_enable),
		.draw_frame_7_enable(draw_frame_7_enable),
		.draw_frame_8_enable(draw_frame_8_enable),
		.draw_frame_9_enable(draw_frame_9_enable),
		.draw_frame_10_enable(draw_frame_10_enable),
		.draw_frame_11_enable(draw_frame_11_enable),
		.draw_frame_12_enable(draw_frame_12_enable),
		.draw_frame_13_enable(draw_frame_13_enable),
		.draw_frame_14_enable(draw_frame_14_enable),
		.draw_frame_15_enable(draw_frame_15_enable),
		.draw_frame_16_enable(draw_frame_16_enable),
		.draw_frame_over_enable(draw_frame_over_enable),
		.draw_frame_end_enable(draw_frame_end_enable),
		
		.key_data(key_data),
		.key_en(key_en)

		
   );

   datapath #(.X_SCREEN_PIXELS(X_SCREEN_PIXELS), .Y_SCREEN_PIXELS(Y_SCREEN_PIXELS)) d0(
      .iResetn(iResetn),
      .iClock(iClock),
      .level(level),
      .increment_LEFT(increment_LEFT),
      .increment_UP(increment_UP),
      .increment_RIGHT(increment_RIGHT),
      .increment_DOWN(increment_DOWN),
      .check_position(check_position),
      .clear_en_1(clear_en_1),
      .draw_maze_enable_1(draw_maze_enable_1),
      .draw_destination_enable_1(draw_destination_enable_1),
      .draw_character_enable_1(draw_character_enable_1),
      .check_position_2(check_position_2),
      .clear_en_2(clear_en_2),
      .draw_maze_enable_2(draw_maze_enable_2),
      .draw_destination_enable_2(draw_destination_enable_2),
      .draw_character_enable_2(draw_character_enable_2),
      .check_position_3(check_position_3), 
      .clear_en_3(clear_en_3), 
      .draw_maze_enable_3(draw_maze_enable_3),
      .draw_destination_enable_3(draw_destination_enable_3),
      .draw_character_enable_3(draw_character_enable_3),
      .draw_victory_enable(draw_victory_enable),
      .draw_lose_enable(draw_lose_enable),
      .enable_timer(enable_timer),
      .oX(oX),
      .oY(oY),
      .oColour(oColour),
      .victory(victory),
      .timeout(timeout),
      .hundreds(hundreds),
      .tens(tens),
      .ones(ones),
      .olevel(olevel),
      .percent(percent),
		
		
		.draw_title_1_enable(draw_title_1_enable),
		.draw_title_2_enable(draw_title_2_enable),
		.draw_frame_1_enable(draw_frame_1_enable),
		.draw_frame_2_enable(draw_frame_2_enable),
		.draw_frame_3_enable(draw_frame_3_enable),
		.draw_frame_4_enable(draw_frame_4_enable),
		.draw_frame_5_enable(draw_frame_5_enable),
		.draw_frame_6_enable(draw_frame_6_enable),
		.draw_frame_7_enable(draw_frame_7_enable),
		.draw_frame_8_enable(draw_frame_8_enable),
		.draw_frame_9_enable(draw_frame_9_enable),
		.draw_frame_10_enable(draw_frame_10_enable),
		.draw_frame_11_enable(draw_frame_11_enable),
		.draw_frame_12_enable(draw_frame_12_enable),
		.draw_frame_13_enable(draw_frame_13_enable),
		.draw_frame_14_enable(draw_frame_14_enable),
		.draw_frame_15_enable(draw_frame_15_enable),
		.draw_frame_16_enable(draw_frame_16_enable),
		.draw_frame_over_enable(draw_frame_over_enable),
		.draw_frame_end_enable(draw_frame_end_enable),
		
		.address_title_1(address_title_1), .q_title_1(q_title_1),
		.address_title_2(address_title_2), .q_title_2(q_title_2),
		.address_frame_1(address_frame_1), .q_frame_1(q_frame_1),
		.address_frame_2(address_frame_2), .q_frame_2(q_frame_2),
		.address_frame_3(address_frame_3), .q_frame_3(q_frame_3),
		.address_frame_4(address_frame_4), .q_frame_4(q_frame_4),
		.address_frame_5(address_frame_5), .q_frame_5(q_frame_5),
		.address_frame_6(address_frame_6), .q_frame_6(q_frame_6),
		.address_frame_7(address_frame_7), .q_frame_7(q_frame_7),
		.address_frame_8(address_frame_8), .q_frame_8(q_frame_8),
		.address_frame_9(address_frame_9), .q_frame_9(q_frame_9),
		.address_frame_10(address_frame_10), .q_frame_10(q_frame_10),
		.address_frame_11(address_frame_11), .q_frame_11(q_frame_11),
		.address_frame_12(address_frame_12), .q_frame_12(q_frame_12),
		.address_frame_13(address_frame_13), .q_frame_13(q_frame_13),
		.address_frame_14(address_frame_14), .q_frame_14(q_frame_14),
		.address_frame_15(address_frame_15), .q_frame_15(q_frame_15),
		.address_frame_16(address_frame_16), .q_frame_16(q_frame_16),
		.address_over(address_over), .q_over(q_over),
		.address_end(address_end), .q_end(q_end)
		
   );

endmodule 

module grid2coords_old(input [2:0] x, input [4:0] bigxindex, input [2:0] y, input [7:0] shifthor, input [6:0] shiftver, input [2:0] scale, output [8:0] cx, output [7:0] cy);
    assign cx = scale * (bigxindex - x) + shifthor;
    assign cy = scale * y + shiftver;
endmodule

module grid2coords_m(input [5:0] x, input [5:0] bigxindex, input [5:0] y, input [3:0] scale, output [8:0] cx, output [7:0] cy);
    wire [7:0] shifthor;
    wire [6:0] shiftver;
    //formula: assign shifthor = (8'd320 - (scale * bigxindex) - scale ) / 2; 
    //formula: assign shiftver = (7'd240 - (scale * bigxindex) - scale ) / 2;
    assign shifthor = 8'd60;
    assign shiftver = 7'd20;
    assign cx = scale * (bigxindex - x) + shifthor;
    assign cy = scale * y + shiftver;
endmodule

module grid2coords_m2(input [5:0] x, input [5:0] bigxindex, input [5:0] y, input [3:0] scale, output [8:0] cx, output [7:0] cy);
    wire [7:0] shifthor;
    wire [6:0] shiftver;
    //formula: assign shifthor = (8'd320 - (scale * bigxindex) - scale ) / 2; 
    //formula: assign shiftver = (7'd240 - (scale * bigxindex) - scale ) / 2;
    assign shifthor = 8'd86;
    assign shiftver = 7'd46;
    assign cx = scale * (bigxindex - x) + shifthor;
    assign cy = scale * y + shiftver;
endmodule

module grid2coords_m3(input [5:0] x, input [5:0] bigxindex, input [5:0] y, input [3:0] scale, output [8:0] cx, output [7:0] cy);
    wire [7:0] shifthor;
    wire [6:0] shiftver;
    //formula: assign shifthor = (8'd320 - (scale * bigxindex) - scale ) / 2; 
    //formula: assign shiftver = (7'd240 - (scale * bigxindex) - scale ) / 2;
    assign shifthor = 8'd62;
    assign shiftver = 7'd22;
    assign cx = scale * (bigxindex - x) + shifthor;
    assign cy = scale * y + shiftver;
endmodule

module grid2coords(input [5:0] x, input [5:0] y, input [3:0] scale, output [8:0] cx, output [7:0] cy);
    wire [7:0] shifthor;
    wire [6:0] shiftver;
    //formula: assign shifthor = (8'd320 - (scale * bigxindex) - scale ) / 2; 
    //formula: assign shiftver = (7'd240 - (scale * bigxindex) - scale ) / 2;
    assign shifthor = 8'd60;
    assign shiftver = 7'd20;
    assign cx = scale * x + shifthor;
    assign cy = scale * y + shiftver;
endmodule

module grid2coords2(input [5:0] x, input [5:0] y, input [3:0] scale, output [8:0] cx, output [7:0] cy);
    wire [7:0] shifthor;
    wire [6:0] shiftver;
    //formula: assign shifthor = (8'd320 - (scale * bigxindex) - scale ) / 2; 
    //formula: assign shiftver = (7'd240 - (scale * bigxindex) - scale ) / 2;
    assign shifthor = 8'd86;
    assign shiftver = 7'd46;
    assign cx = scale * x + shifthor;
    assign cy = scale * y + shiftver;
endmodule

module grid2coords3(input [5:0] x, input [5:0] y, input [3:0] scale, output [8:0] cx, output [7:0] cy);
    wire [7:0] shifthor;
    wire [6:0] shiftver;
    //formula: assign shifthor = (8'd320 - (scale * bigxindex) - scale ) / 2; 
    //formula: assign shiftver = (7'd240 - (scale * bigxindex) - scale ) / 2;
    assign shifthor = 8'd62;
    assign shiftver = 7'd22;
    assign cx = scale * x + shifthor;
    assign cy = scale * y + shiftver;
endmodule


module datapath #(parameter X_SCREEN_PIXELS = 320, Y_SCREEN_PIXELS = 240) (
   input iResetn, iClock,
   input [1:0] level,
   input wire increment_LEFT, increment_UP, increment_RIGHT, increment_DOWN,
   input wire check_position, clear_en_1, draw_maze_enable_1, draw_destination_enable_1,
   input wire draw_character_enable_1, draw_victory_enable, draw_lose_enable, enable_timer,
   input wire check_position_2, clear_en_2, draw_maze_enable_2, draw_destination_enable_2, draw_character_enable_2,
   input wire check_position_3, clear_en_3, draw_maze_enable_3, draw_destination_enable_3, draw_character_enable_3,
	
	input wire draw_title_1_enable,
	input wire draw_title_2_enable,
	input wire draw_frame_1_enable,
	input wire draw_frame_2_enable,
	input wire draw_frame_3_enable,
	input wire draw_frame_4_enable,
	input wire draw_frame_5_enable,
	input wire draw_frame_6_enable,
	input wire draw_frame_7_enable,
	input wire draw_frame_8_enable,
	input wire draw_frame_9_enable,
	input wire draw_frame_10_enable,
	input wire draw_frame_11_enable,
	input wire draw_frame_12_enable,
	input wire draw_frame_13_enable,
	input wire draw_frame_14_enable,
	input wire draw_frame_15_enable,
	input wire draw_frame_16_enable,
	input wire draw_frame_over_enable,
	inout wire draw_frame_end_enable,
	
	input wire [2:0] q_title_1, 
	input wire [2:0] q_title_2,
	input wire [2:0] q_frame_1,
	input wire [2:0] q_frame_2,
	input wire [2:0] q_frame_3,
	input wire [2:0] q_frame_4,
	input wire [2:0] q_frame_5,
	input wire [2:0] q_frame_6,
	input wire [2:0] q_frame_7,
	input wire [2:0] q_frame_8,
	input wire [2:0] q_frame_9,
	input wire [2:0] q_frame_10,
	input wire [2:0] q_frame_11,
	input wire [2:0] q_frame_12,
	input wire [2:0] q_frame_13,
	input wire [2:0] q_frame_14,
	input wire [2:0] q_frame_15,
	input wire [2:0] q_frame_16,
	input wire [2:0] q_over,
	input wire [2:0] q_end,
	
   output reg [8:0] oX,
   output reg [7:0] oY,
   output reg [2:0] oColour,
   output wire victory, timeout,
   output wire [3:0] hundreds, tens, ones,
   output reg [1:0] olevel,
   output wire [9:0] percent,
	
	output reg [14:0] address_title_1,
	output reg [14:0] address_title_2,
	output reg [14:0] address_frame_1,
	output reg [14:0] address_frame_2,
	output reg [14:0] address_frame_3,
	output reg [14:0] address_frame_4,
	output reg [14:0] address_frame_5,
	output reg [14:0] address_frame_6,
	output reg [14:0] address_frame_7,
	output reg [14:0] address_frame_8,
	output reg [14:0] address_frame_9,
	output reg [14:0] address_frame_10,
	output reg [14:0] address_frame_11,
	output reg [14:0] address_frame_12,
	output reg [14:0] address_frame_13,
	output reg [14:0] address_frame_14,
	output reg [14:0] address_frame_15,
	output reg [14:0] address_frame_16,
	output reg [14:0] address_over,
	output reg [14:0] address_end
);


   reg [5:0] mazex;
   reg [5:0] mazey;
   reg [5:0] destx;
   reg [5:0] desty;
   reg [5:0] charx;
   reg [5:0] chary;
   reg [5:0] newcharx;
   reg [5:0] newchary;

   reg [5:0] countunit; //6 bits - 3 for x and y, 0-7 for each
   reg [3:0] countunit2; //4 bits - 2 for x and y, 0-3 for each
   reg [7:0] count8bit;
   reg [8:0] count9bit;
   wire [8:0] cxm1;
   wire [7:0] cym1;
   wire [8:0] cxd1;
   wire [7:0] cyd1;
   wire [8:0] cxc1;
   wire [7:0] cyc1;

   wire [8:0] cxm2;
   wire [7:0] cym2;
   wire [8:0] cxd2;
   wire [7:0] cyd2;
   wire [8:0] cxc2;
   wire [7:0] cyc2;
   
   wire [8:0] cxm3;
   wire [7:0] cym3;
   wire [8:0] cxd3;
   wire [7:0] cyd3;
   wire [8:0] cxc3;
   wire [7:0] cyc3;
   
    reg [24:0] row0;
    reg [24:0] row1;
    reg [24:0] row2;
    reg [24:0] row3;
    reg [24:0] row4;
    reg [24:0] row5;
    reg [24:0] row6;
    reg [24:0] row7;
    reg [24:0] row8;
    reg [24:0] row9;
    reg [24:0] row10;
    reg [24:0] row11;
    reg [24:0] row12;
    reg [24:0] row13;
    reg [24:0] row14;
    reg [24:0] row15;
    reg [24:0] row16;
    reg [24:0] row17;
    reg [24:0] row18;
    reg [24:0] row19;
    reg [24:0] row20;
    reg [24:0] row21;
    reg [24:0] row22;
    reg [24:0] row23;
    reg [24:0] row24;

    reg [36:0] row0_2;
    reg [36:0] row1_2;
    reg [36:0] row2_2;
    reg [36:0] row3_2;
    reg [36:0] row4_2;
    reg [36:0] row5_2;
    reg [36:0] row6_2;
    reg [36:0] row7_2;
    reg [36:0] row8_2;
    reg [36:0] row9_2;
    reg [36:0] row10_2;
    reg [36:0] row11_2;
    reg [36:0] row12_2;
    reg [36:0] row13_2;
    reg [36:0] row14_2;
    reg [36:0] row15_2;
    reg [36:0] row16_2;
    reg [36:0] row17_2;
    reg [36:0] row18_2;
    reg [36:0] row19_2;
    reg [36:0] row20_2;
    reg [36:0] row21_2;
    reg [36:0] row22_2;
    reg [36:0] row23_2;
    reg [36:0] row24_2;
    reg [36:0] row25_2;
    reg [36:0] row26_2;
    reg [36:0] row27_2;
    reg [36:0] row28_2;
    reg [36:0] row29_2;
    reg [36:0] row30_2;
    reg [36:0] row31_2;
    reg [36:0] row32_2;
    reg [36:0] row33_2;
    reg [36:0] row34_2;
    reg [36:0] row35_2;
    reg [36:0] row36_2;

    reg [48:0] row0_3;
    reg [48:0] row1_3;
    reg [48:0] row2_3;
    reg [48:0] row3_3;
    reg [48:0] row4_3;
    reg [48:0] row5_3;
    reg [48:0] row6_3;
    reg [48:0] row7_3;
    reg [48:0] row8_3;
    reg [48:0] row9_3;
    reg [48:0] row10_3;
    reg [48:0] row11_3;
    reg [48:0] row12_3;
    reg [48:0] row13_3;
    reg [48:0] row14_3;
    reg [48:0] row15_3;
    reg [48:0] row16_3;
    reg [48:0] row17_3;
    reg [48:0] row18_3;
    reg [48:0] row19_3;
    reg [48:0] row20_3;
    reg [48:0] row21_3;
    reg [48:0] row22_3;
    reg [48:0] row23_3;
    reg [48:0] row24_3;
    reg [48:0] row25_3;
    reg [48:0] row26_3;
    reg [48:0] row27_3;
    reg [48:0] row28_3;
    reg [48:0] row29_3;
    reg [48:0] row30_3;
    reg [48:0] row31_3;
    reg [48:0] row32_3;
    reg [48:0] row33_3;
    reg [48:0] row34_3;
    reg [48:0] row35_3;
    reg [48:0] row36_3;
    reg [48:0] row37_3;
    reg [48:0] row38_3;
    reg [48:0] row39_3;
    reg [48:0] row40_3;
    reg [48:0] row41_3;
    reg [48:0] row42_3;
    reg [48:0] row43_3;
    reg [48:0] row44_3;
    reg [48:0] row45_3;
    reg [48:0] row46_3;
    reg [48:0] row47_3;
    reg [48:0] row48_3;

   grid2coords_m g2c_m1(.x(mazex), .bigxindex(6'd24), .y(mazey), .scale(4'd8), .cx(cxm1), .cy(cym1));
   grid2coords g2c_d1(.x(destx), .y(desty), .scale(4'd8), .cx(cxd1), .cy(cyd1));
   grid2coords g2c_c1(.x(charx), .y(chary), .scale(4'd8), .cx(cxc1), .cy(cyc1));

   grid2coords_m2 g2c_m2(.x(mazex), .bigxindex(6'd36), .y(mazey), .scale(3'd4), .cx(cxm2), .cy(cym2));
   grid2coords2 g2c_d2(.x(destx), .y(desty), .scale(3'd4), .cx(cxd2), .cy(cyd2));
   grid2coords2 g2c_c2(.x(charx), .y(chary), .scale(3'd4), .cx(cxc2), .cy(cyc2));

   grid2coords_m3 g2c_m3(.x(mazex), .bigxindex(6'd48), .y(mazey), .scale(3'd4), .cx(cxm3), .cy(cym3));
   grid2coords3 g2c_d3(.x(destx), .y(desty), .scale(3'd4), .cx(cxd3), .cy(cyd3));
   grid2coords3 g2c_c3(.x(charx), .y(chary), .scale(3'd4), .cx(cxc3), .cy(cyc3));

    timer t0(.Reset(iResetn), .clock(iClock), .level(level), .enable_timer(enable_timer),
            .hundreds(hundreds), .tens(tens), .ones(ones), .timeout(timeout), .percent(percent));

    assign victory = (charx == destx) & (chary == desty);
    
//input
   always @(posedge iClock) begin
    if (iResetn)begin
        countunit <= 6'b0;
        countunit2 <= 4'b0;
        row0 <= 25'b1111111111111111111111111;
        row1 <= 25'b1000000000100000100000001;
        row2 <= 25'b1010111110101110101111101;
        row3 <= 25'b1010001010101000101000101;
        row4 <= 25'b1011101010101011101110101;
        row5 <= 25'b1000101000101000001000101;
        row6 <= 25'b1110101110101111111011101;
        row7 <= 25'b1000100010001000100000101;
        row8 <= 25'b1011111010111010111010101;
        row9 <= 25'b1010001010100010001010001;
        row10 <= 25'b1010111010101111101011111;
        row11 <= 25'b1000100010101010001000101;
        row12 <= 25'b1110101110101010111110101;
        row13 <= 25'b1010101000101010000010001;
        row14 <= 25'b1010101111101011111011111;
        row15 <= 25'b1010101000100000001010001;
        row16 <= 25'b1010101010111111101011101;
        row17 <= 25'b1000101010000000101010001;
        row18 <= 25'b1011101011111011101010111;
        row19 <= 25'b1000101010001000101000101;
        row20 <= 25'b1011101010101110101111101;
        row21 <= 25'b1010001010100010001000001;
        row22 <= 25'b1010111010111011111110101;
        row23 <= 25'b1010000000100000000000100;
        row24 <= 25'b1111111111111111111111111;

        row0_2 <= 37'b1111111111111111111111111111111111111;
        row1_2 <= 37'b1000100010000000001000000010000000001;
        row2_2 <= 37'b1011101010111110111011111010111111101;
        row3_2 <= 37'b1000101010000010100010001000001000101;
        row4_2 <= 37'b1110101011101110101110101111101110101;
        row5_2 <= 37'b1000101000001000101010100000100000101;
        row6_2 <= 37'b1011101111111011101010111110111111101;
        row7_2 <= 37'b1010000000001010001010100000000000101;
        row8_2 <= 37'b1010111111101010111010111111111110101;
        row9_2 <= 37'b1000001000101000000010000010000010001;
        row10_2 <= 37'b1011111010111111111111111011111011101;
        row11_2 <= 37'b1010000010001000000000001000001000001;
        row12_2 <= 37'b1010111111101011111111101111101011111;
        row13_2 <= 37'b1010100000000010000010100000001000001;
        row14_2 <= 37'b1010111011111010111010111011111111111;
        row15_2 <= 37'b1010001010001010101010000010001000001;
        row16_2 <= 37'b1011101110101110101011111110101011101;
        row17_2 <= 37'b1010100010100000101000100000101010101;
        row18_2 <= 37'b1010111010111111101110101111101010101;
        row19_2 <= 37'b1010001000100000001000101000001000101;
        row20_2 <= 37'b1010101111111110101011101011111110101;
        row21_2 <= 37'b1000101000000000101000101010000000101;
        row22_2 <= 37'b1111101011111011111110101010111111101;
        row23_2 <= 37'b1000100010100010000010001010000000101;
        row24_2 <= 37'b1011111110101110111011111010111111101;
        row25_2 <= 37'b1000000000101010101000000010100010001;
        row26_2 <= 37'b1110111010101010101111101110101010101;
        row27_2 <= 37'b1010100010100010101000001000101000101;
        row28_2 <= 37'b1011101110111010101011111011101111101;
        row29_2 <= 37'b1000100010001010100010001000100000101;
        row30_2 <= 37'b1110111011111010111110101011111110101;
        row31_2 <= 37'b1000100010000010000000101010000000101;
        row32_2 <= 37'b1011101110111111111111101010111111101;
        row33_2 <= 37'b1000100000000000100000100010100000101;
        row34_2 <= 37'b1110111111111111101110111110101111101;
        row35_2 <= 37'b1000000000000000001000000000100000000;
        row36_2 <= 37'b1111111111111111111111111111111111111;

        row0_3 <= 49'b1111111111111111111111111111111111111111111111111;
        row1_3 <= 49'b1000100000000000001000000010000010000000000000001;
        row2_3 <= 49'b1011101011111111101010111110111010111011101111101;
        row3_3 <= 49'b1000001000100000101010000010001000001000101000101;
        row4_3 <= 49'b1011111110101110101011111011101111111010101010101;
        row5_3 <= 49'b1010000010100010101010001010001010001010101010101;
        row6_3 <= 49'b1010111010111010101010101010111010101010101010111;
        row7_3 <= 49'b1010100000100010001010101010001010101010101010001;
        row8_3 <= 49'b1010111111101111101010101011101010101010101011101;
        row9_3 <= 49'b1010000010001000101010101000100010101010101010001;
        row10_3 <= 49'b1011111011111010101010111011111010101110111010101;
        row11_3 <= 49'b1000100010000010101010001000000010100010000010101;
        row12_3 <= 49'b1111101010111110111011101111111110111011111010101;
        row13_3 <= 49'b1000001010100010000000000010000010101000001010101;
        row14_3 <= 49'b1011111110111011111111111010101110101111101110111;
        row15_3 <= 49'b1010000010001010001000001000101000100000100010001;
        row16_3 <= 49'b1010111011101010101111101011111011101110111011101;
        row17_3 <= 49'b1000001000000010100000100010000010001000001000101;
        row18_3 <= 49'b1011111111111110111110111010111110111111111110101;
        row19_3 <= 49'b1000100010000000100010001010101000000000000010001;
        row20_3 <= 49'b1111101010111111101111101110101011111111101111101;
        row21_3 <= 49'b1000001000100000001000001000100000000000101000001;
        row22_3 <= 49'b1011111011111110111011111011111111111011101011111;
        row23_3 <= 49'b1010100010000010001010000010000000101010001000001;
        row24_3 <= 49'b1010101110111011101010101010111110101010111111101;
        row25_3 <= 49'b1010000010101010001010101010100000101010000000101;
        row26_3 <= 49'b1011111110101010111011101110101111101011111110101;
        row27_3 <= 49'b1010000000101010001010001000100000100010000010001;
        row28_3 <= 49'b1010111111101011101010101011111110111011101011111;
        row29_3 <= 49'b1010001000001000100010101010000010101000101000001;
        row30_3 <= 49'b1011101010111110111010111010111010101110101111101;
        row31_3 <= 49'b1000101010000010001000100010001010001010001000001;
        row32_3 <= 49'b1110101111111011101111101111101011111011111011111;
        row33_3 <= 49'b1010001000100010100000001000001010001000001010001;
        row34_3 <= 49'b1011111010101010111111111110111010101110111010101;
        row35_3 <= 49'b1000000010001000100000100000100000100000100010101;
        row36_3 <= 49'b1011101111111110111010101011111111111110101110101;
        row37_3 <= 49'b1010001000100010000010001010001000000000100010101;
        row38_3 <= 49'b1011111010101011111111111010101111101111111011101;
        row39_3 <= 49'b1010000010101010001000001010100000100010001010001;
        row40_3 <= 49'b1010111110101010101110111010111110111010101010111;
        row41_3 <= 49'b1010100010001000100010000010001010001010101010001;
        row42_3 <= 49'b1010101011111111111011111011101011101010101010101;
        row43_3 <= 49'b1010001010000000000010001010001000101010101010101;
        row44_3 <= 49'b1011111010111011111110101110111110101110101010101;
        row45_3 <= 49'b1010000010001010000000100010000010100000101010101;
        row46_3 <= 49'b1010111111101110111111111011111010111111101011101;
        row47_3 <= 49'b1000000000100000000000001000000000000000100000000;
        row48_3 <= 49'b1111111111111111111111111111111111111111111111111;

    end
	 else begin
		 if (draw_maze_enable_1 | draw_destination_enable_1 | draw_character_enable_1) countunit <= countunit + 1;
         if (draw_maze_enable_2 | draw_destination_enable_2 | draw_character_enable_2 | draw_maze_enable_3 | draw_destination_enable_3 | draw_character_enable_3) countunit2 <= countunit2 + 1;
		end
   end

   //output logic
   always @(posedge iClock) begin
      if (iResetn | (level == 2'b01))begin
        mazex <= 6'd24;
        mazey <= 6'b0;
        destx <= 6'd24;
        desty <= 6'd23;
        charx <= 6'd1;
        chary <= 6'd1;
        newcharx <= 6'd1;
        newchary <= 6'd1;
         oX <= 9'b0;
         oY <= 8'b0;
         oColour <= 3'b0;
         count8bit <= 8'b0;
         count9bit <= 9'b0;
         olevel <= 2'b01; 
			
			address_title_1 <= 15'd0;
			address_title_2 <= 15'd0;
			address_frame_1 <= 15'd0;
			address_frame_2 <= 15'd0;
			address_frame_3 <= 15'd0;
			address_frame_4 <= 15'd0;
			address_frame_5 <= 15'd0;
			address_frame_6 <= 15'd0;
			address_frame_7 <= 15'd0;
			address_frame_8 <= 15'd0;
			address_frame_9 <= 15'd0;
			address_frame_10 <= 15'd0;
			address_frame_11 <= 15'd0;
			address_frame_12 <= 15'd0;
			address_frame_13 <= 15'd0;
			address_frame_14 <= 15'd0;
			address_frame_15 <= 15'd0;
			address_frame_16 <= 15'd0;
			address_end <= 15'd0;
			address_over <= 15'd0;
			
			
      end
      else if (level == 2'b10)begin
        mazex <= 6'd36;
        mazey <= 6'b0;
        destx <= 6'd36;
        desty <= 6'd35;
        charx <= 6'd1;
        chary <= 6'd1;
        newcharx <= 6'd1;
        newchary <= 6'd1;
         oX <= 9'b0;
         oY <= 8'b0;
         oColour <= 3'b0;
         count8bit <= 8'b0;
         count9bit <= 9'b0;
         olevel <= 2'b10;
      end
      else if (level == 2'b11)begin
        mazex <= 6'd48;
        mazey <= 6'b0;
        destx <= 6'd48;
        desty <= 6'd47;
        charx <= 6'd1;
        chary <= 6'd1;
        newcharx <= 6'd1;
        newchary <= 6'd1;
         oX <= 9'b0;
         oY <= 8'b0;
         oColour <= 3'b0;
         count8bit <= 8'b0;
         count9bit <= 9'b0;
         olevel <= 2'b11;
      end
	/////////////////////////////////////////////////////////////////	
		

		
		else if(draw_title_1_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_title_1 <= address_title_1 + 1;
					else address_title_1 = address_title_1 - 159; // THIS WAS A = INSTEAD OF A <= !!! BE AWARE OF THIS FOR FUTURE
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_title_1 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_title_1 <= address_title_1 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_title_1;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_title_2_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_title_2 <= address_title_2 + 1;
					else address_title_2 = address_title_2 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_title_2 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_title_2 <= address_title_2 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_title_2;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_1_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_1 <= address_frame_1 + 1;
					else address_frame_1 = address_frame_1 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_1 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_1 <= address_frame_1 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_1;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_2_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_2 <= address_frame_2 + 1;
					else address_frame_2 = address_frame_2 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_2 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_2 <= address_frame_2 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_2;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_3_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_3 <= address_frame_3 + 1;
					else address_frame_3 = address_frame_3 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_3 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_3 <= address_frame_3 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_3;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_4_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_4 <= address_frame_4 + 1;
					else address_frame_4 = address_frame_4 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_4 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_4 <= address_frame_4 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_4;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_5_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_5 <= address_frame_5 + 1;
					else address_frame_5 = address_frame_5 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_5 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_5 <= address_frame_5 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_5;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_6_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_6 <= address_frame_6 + 1;
					else address_frame_6 = address_frame_6 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_6 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_6 <= address_frame_6 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_6;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_7_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_7 <= address_frame_7 + 1;
					else address_frame_7 = address_frame_7 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_7 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_7 <= address_frame_7 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_7;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_8_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_8 <= address_frame_8 + 1;
					else address_frame_8 = address_frame_8 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_8 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_8 <= address_frame_8 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_8;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_9_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_9 <= address_frame_9 + 1;
					else address_frame_9 = address_frame_9 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_9 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_9 <= address_frame_9 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_9;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_10_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_10 <= address_frame_10 + 1;
					else address_frame_10 = address_frame_10 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_10 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_10 <= address_frame_10 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_10;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_11_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_11 <= address_frame_11 + 1;
					else address_frame_11 = address_frame_11 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_11 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_11 <= address_frame_11 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_11;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_12_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_12 <= address_frame_12 + 1;
					else address_frame_12 = address_frame_12 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_12 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_12 <= address_frame_12 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_12;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_13_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_13 <= address_frame_13 + 1;
					else address_frame_13 = address_frame_13 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_13 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_13 <= address_frame_13 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_13;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_14_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_14 <= address_frame_14 + 1;
					else address_frame_14 = address_frame_14 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_14 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_14 <= address_frame_14 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_14;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_15_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_15 <= address_frame_15 + 1;
					else address_frame_15 = address_frame_15 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_15 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_15 <= address_frame_15 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_15;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_16_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_frame_16 <= address_frame_16 + 1;
					else address_frame_16 = address_frame_16 - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_frame_16 <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_frame_16 <= address_frame_16 + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_frame_16;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_over_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_over <= address_over + 1;
					else address_over = address_over - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_over <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_over <= address_over + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_over;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
		else if(draw_frame_end_enable) begin
		
			if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 != Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= count8bit + 1;
					if(count8bit % 2 != 0) address_end <= address_end + 1;
					else address_end = address_end - 159;
				end
				else if (count9bit + 1 == X_SCREEN_PIXELS && count8bit + 1 == Y_SCREEN_PIXELS) begin
					count9bit <= 0;
					count8bit <= 0;
					address_end <= 0;
				end
				else if(count9bit % 2 != 0) begin 
					address_end <= address_end + 1;
					count9bit <= count9bit + 1;
				end
				else count9bit <= count9bit + 1;
				oColour <= q_end;
				
				oX <= count9bit;
				oY <= count8bit;

		end
		
	/////////////////////////////////////////////////////////////////	
		
      else if(draw_maze_enable_1) begin
        count8bit <= 8'b0;
        count9bit <= 9'b0;
         oX <= cxm1 + countunit[2:0];
         oY <= cym1 + countunit[5:3]; 
         if (countunit == 6'd63) begin 
				if (mazex == 6'd0)begin
					if (mazey == 6'd24)begin
						 mazex <= 6'd24;
						 mazey <= 6'd0;
					end
					else begin
						 mazex <= 6'd24;
						 mazey <= mazey + 1;
					end
				end
				else mazex <= mazex - 1;
			end
         case (mazey)
            0: oColour = row0[mazex] ? 3'b100 : 3'b110;
            1: oColour = row1[mazex] ? 3'b100 : 3'b110;
            2: oColour = row2[mazex] ? 3'b100 : 3'b110;
            3: oColour = row3[mazex] ? 3'b100 : 3'b110;
            4: oColour = row4[mazex] ? 3'b100 : 3'b110;
            5: oColour = row5[mazex] ? 3'b100 : 3'b110;
            6: oColour = row6[mazex] ? 3'b100 : 3'b110;
            7: oColour = row7[mazex] ? 3'b100 : 3'b110;
            8: oColour = row8[mazex] ? 3'b100 : 3'b110;
            9: oColour = row9[mazex] ? 3'b100 : 3'b110;
            10: oColour = row10[mazex] ? 3'b100 : 3'b110;
            11: oColour = row11[mazex] ? 3'b100 : 3'b110;
            12: oColour = row12[mazex] ? 3'b100 : 3'b110;
            13: oColour = row13[mazex] ? 3'b100 : 3'b110;
            14: oColour = row14[mazex] ? 3'b100 : 3'b110;
            15: oColour = row15[mazex] ? 3'b100 : 3'b110;
            16: oColour = row16[mazex] ? 3'b100 : 3'b110;
            17: oColour = row17[mazex] ? 3'b100 : 3'b110;
            18: oColour = row18[mazex] ? 3'b100 : 3'b110;
            19: oColour = row19[mazex] ? 3'b100 : 3'b110;
            20: oColour = row20[mazex] ? 3'b100 : 3'b110;
            21: oColour = row21[mazex] ? 3'b100 : 3'b110;
            22: oColour = row22[mazex] ? 3'b100 : 3'b110;
            23: oColour = row23[mazex] ? 3'b100 : 3'b110;
            24: oColour = row24[mazex] ? 3'b100 : 3'b110;
            
        endcase
      end
      else if (draw_destination_enable_1) begin
        count8bit <= 8'b0;
        count9bit <= 9'b0;
         oX <= cxd1 + countunit[2:0];
         oY <= cyd1 + countunit[5:3]; 
         oColour <= 3'b111;
      end
      else if (draw_character_enable_1) begin
        count8bit <= 8'b0;
        count9bit <= 9'b0;
         oX <= cxc1 + countunit[2:0];
         oY <= cyc1 + countunit[5:3]; 
         oColour <= 3'b101;
      end
      else if(clear_en_1) begin
        if (count9bit == X_SCREEN_PIXELS && count8bit != Y_SCREEN_PIXELS) begin
            count9bit <= 0;
            count8bit <= count8bit + 1;
         end
			else if (count9bit == X_SCREEN_PIXELS && count8bit == Y_SCREEN_PIXELS) begin
				count9bit <= 0;
				count8bit <= 0;
			end
         else count9bit <= count9bit + 1;
         oColour <= 3'b011;
         oX <= count9bit;
         oY <= count8bit;
      end
/////////////////////
    else if(draw_maze_enable_2) begin
        count8bit <= 8'b0;
        count9bit <= 9'b0;
         oX <= cxm2 + countunit2[1:0];
         oY <= cym2 + countunit2[3:2]; 
         if (countunit2 == 4'd15) begin 
				if (mazex == 6'd0)begin
					if (mazey == 6'd36)begin
						 mazex <= 6'd36;
						 mazey <= 6'd0;
					end
					else begin
						 mazex <= 6'd36;
						 mazey <= mazey + 1;
					end
				end
				else mazex <= mazex - 1;
			end
         case (mazey)
            0: oColour = row0_2[mazex] ? 3'b001 : 3'b011;
            1: oColour = row1_2[mazex] ? 3'b001 : 3'b011;
            2: oColour = row2_2[mazex] ? 3'b001 : 3'b011;
            3: oColour = row3_2[mazex] ? 3'b001 : 3'b011;
            4: oColour = row4_2[mazex] ? 3'b001 : 3'b011;
            5: oColour = row5_2[mazex] ? 3'b001 : 3'b011;
            6: oColour = row6_2[mazex] ? 3'b001 : 3'b011;
            7: oColour = row7_2[mazex] ? 3'b001 : 3'b011;
            8: oColour = row8_2[mazex] ? 3'b001 : 3'b011;
            9: oColour = row9_2[mazex] ? 3'b001 : 3'b011;
            10: oColour = row10_2[mazex] ? 3'b001 : 3'b011;
            11: oColour = row11_2[mazex] ? 3'b001 : 3'b011;
            12: oColour = row12_2[mazex] ? 3'b001 : 3'b011;
            13: oColour = row13_2[mazex] ? 3'b001 : 3'b011;
            14: oColour = row14_2[mazex] ? 3'b001 : 3'b011;
            15: oColour = row15_2[mazex] ? 3'b001 : 3'b011;
            16: oColour = row16_2[mazex] ? 3'b001 : 3'b011;
            17: oColour = row17_2[mazex] ? 3'b001 : 3'b011;
            18: oColour = row18_2[mazex] ? 3'b001 : 3'b011;
            19: oColour = row19_2[mazex] ? 3'b001 : 3'b011;
            20: oColour = row20_2[mazex] ? 3'b001 : 3'b011;
            21: oColour = row21_2[mazex] ? 3'b001 : 3'b011;
            22: oColour = row22_2[mazex] ? 3'b001 : 3'b011;
            23: oColour = row23_2[mazex] ? 3'b001 : 3'b011;
            24: oColour = row24_2[mazex] ? 3'b001 : 3'b011;
            25: oColour = row25_2[mazex] ? 3'b001 : 3'b011;
            26: oColour = row26_2[mazex] ? 3'b001 : 3'b011;
            27: oColour = row27_2[mazex] ? 3'b001 : 3'b011;
            28: oColour = row28_2[mazex] ? 3'b001 : 3'b011;
            29: oColour = row29_2[mazex] ? 3'b001 : 3'b011;
            30: oColour = row30_2[mazex] ? 3'b001 : 3'b011;
            31: oColour = row31_2[mazex] ? 3'b001 : 3'b011;
            32: oColour = row32_2[mazex] ? 3'b001 : 3'b011;
            33: oColour = row33_2[mazex] ? 3'b001 : 3'b011;
            34: oColour = row34_2[mazex] ? 3'b001 : 3'b011;
            35: oColour = row35_2[mazex] ? 3'b001 : 3'b011;
            36: oColour = row36_2[mazex] ? 3'b001 : 3'b011;
            
        endcase
      end
      else if (draw_destination_enable_2) begin
        count8bit <= 8'b0;
        count9bit <= 9'b0;
         oX <= cxd2 + countunit2[1:0];
         oY <= cyd2 + countunit2[3:2]; 
         oColour <= 3'b111;
      end
      else if (draw_character_enable_2) begin
        count8bit <= 8'b0;
        count9bit <= 9'b0;
         oX <= cxc2 + countunit2[1:0];
         oY <= cyc2 + countunit2[3:2]; 
         oColour <= 3'b101;
      end
      else if(clear_en_2) begin
        if (count9bit == X_SCREEN_PIXELS && count8bit != Y_SCREEN_PIXELS) begin
            count9bit <= 0;
            count8bit <= count8bit + 1;
         end
			else if (count9bit == X_SCREEN_PIXELS && count8bit == Y_SCREEN_PIXELS) begin
				count9bit <= 0;
				count8bit <= 0;
			end
         else count9bit <= count9bit + 1;
         oColour <= 3'b100;
         oX <= count9bit;
         oY <= count8bit;
      end
///////////////////////

    else if(draw_maze_enable_3) begin
        count8bit <= 8'b0;
        count9bit <= 9'b0;
         oX <= cxm3 + countunit2[1:0];
         oY <= cym3 + countunit2[3:2]; 
         if (countunit2 == 4'd15) begin 
				if (mazex == 6'd0)begin
					if (mazey == 6'd48)begin
						 mazex <= 6'd48;
						 mazey <= 6'd0;
					end
					else begin
						 mazex <= 6'd48;
						 mazey <= mazey + 1;
					end
				end
				else mazex <= mazex - 1;
			end
         case (mazey)
            0: oColour = row0_3[mazex] ? 3'b000 : 3'b100;
            1: oColour = row1_3[mazex] ? 3'b000 : 3'b100;
            2: oColour = row2_3[mazex] ? 3'b000 : 3'b100;
            3: oColour = row3_3[mazex] ? 3'b000 : 3'b100;
            4: oColour = row4_3[mazex] ? 3'b000 : 3'b100;
            5: oColour = row5_3[mazex] ? 3'b000 : 3'b100;
            6: oColour = row6_3[mazex] ? 3'b000 : 3'b100;
            7: oColour = row7_3[mazex] ? 3'b000 : 3'b100;
            8: oColour = row8_3[mazex] ? 3'b000 : 3'b100;
            9: oColour = row9_3[mazex] ? 3'b000 : 3'b100;
            10: oColour = row10_3[mazex] ? 3'b000 : 3'b100;
            11: oColour = row11_3[mazex] ? 3'b000 : 3'b100;
            12: oColour = row12_3[mazex] ? 3'b000 : 3'b100;
            13: oColour = row13_3[mazex] ? 3'b000 : 3'b100;
            14: oColour = row14_3[mazex] ? 3'b000 : 3'b100;
            15: oColour = row15_3[mazex] ? 3'b000 : 3'b100;
            16: oColour = row16_3[mazex] ? 3'b000 : 3'b100;
            17: oColour = row17_3[mazex] ? 3'b000 : 3'b100;
            18: oColour = row18_3[mazex] ? 3'b000 : 3'b100;
            19: oColour = row19_3[mazex] ? 3'b000 : 3'b100;
            20: oColour = row20_3[mazex] ? 3'b000 : 3'b100;
            21: oColour = row21_3[mazex] ? 3'b000 : 3'b100;
            22: oColour = row22_3[mazex] ? 3'b000 : 3'b100;
            23: oColour = row23_3[mazex] ? 3'b000 : 3'b100;
            24: oColour = row24_3[mazex] ? 3'b000 : 3'b100;
            25: oColour = row25_3[mazex] ? 3'b000 : 3'b100;
            26: oColour = row26_3[mazex] ? 3'b000 : 3'b100;
            27: oColour = row27_3[mazex] ? 3'b000 : 3'b100;
            28: oColour = row28_3[mazex] ? 3'b000 : 3'b100;
            29: oColour = row29_3[mazex] ? 3'b000 : 3'b100;
            30: oColour = row30_3[mazex] ? 3'b000 : 3'b100;
            31: oColour = row31_3[mazex] ? 3'b000 : 3'b100;
            32: oColour = row32_3[mazex] ? 3'b000 : 3'b100;
            33: oColour = row33_3[mazex] ? 3'b000 : 3'b100;
            34: oColour = row34_3[mazex] ? 3'b000 : 3'b100;
            35: oColour = row35_3[mazex] ? 3'b000 : 3'b100;
            36: oColour = row36_3[mazex] ? 3'b000 : 3'b100;
            37: oColour = row37_3[mazex] ? 3'b000 : 3'b100;
            38: oColour = row38_3[mazex] ? 3'b000 : 3'b100;
            39: oColour = row39_3[mazex] ? 3'b000 : 3'b100;
            40: oColour = row40_3[mazex] ? 3'b000 : 3'b100;
            41: oColour = row41_3[mazex] ? 3'b000 : 3'b100;
            42: oColour = row42_3[mazex] ? 3'b000 : 3'b100;
            43: oColour = row43_3[mazex] ? 3'b000 : 3'b100;
            44: oColour = row44_3[mazex] ? 3'b000 : 3'b100;
            45: oColour = row45_3[mazex] ? 3'b000 : 3'b100;
            46: oColour = row46_3[mazex] ? 3'b000 : 3'b100;
            47: oColour = row47_3[mazex] ? 3'b000 : 3'b100;
            48: oColour = row48_3[mazex] ? 3'b000 : 3'b100;
            
        endcase
      end
      else if (draw_destination_enable_3) begin
        count8bit <= 8'b0;
        count9bit <= 9'b0;
         oX <= cxd3 + countunit2[1:0];
         oY <= cyd3 + countunit2[3:2]; 
         oColour <= 3'b111;
      end
      else if (draw_character_enable_3) begin
        count8bit <= 8'b0;
        count9bit <= 9'b0;
         oX <= cxc3 + countunit2[1:0];
         oY <= cyc3 + countunit2[3:2]; 
         oColour <= 3'b101;
      end
      else if(clear_en_3) begin
        if (count9bit == X_SCREEN_PIXELS && count8bit != Y_SCREEN_PIXELS) begin
            count9bit <= 0;
            count8bit <= count8bit + 1;
         end
			else if (count9bit == X_SCREEN_PIXELS && count8bit == Y_SCREEN_PIXELS) begin
				count9bit <= 0;
				count8bit <= 0;
			end
         else count9bit <= count9bit + 1;
         oColour <= 3'b001;
         oX <= count9bit;
         oY <= count8bit;
      end

//////////////////////
      else if(draw_victory_enable) begin
        if (count9bit == X_SCREEN_PIXELS && count8bit != Y_SCREEN_PIXELS) begin
            count9bit <= 0;
            count8bit <= count8bit + 1;
         end
			else if (count9bit == X_SCREEN_PIXELS && count8bit == Y_SCREEN_PIXELS) begin
				count9bit <= 0;
				count8bit <= 0;
			end
         else count9bit <= count9bit + 1;
         oColour <= 3'b010;
         oX <= count9bit;
         oY <= count8bit;
      end
      else if(draw_lose_enable) begin
        if (count9bit == X_SCREEN_PIXELS && count8bit != Y_SCREEN_PIXELS) begin
            count9bit <= 0;
            count8bit <= count8bit + 1;
         end
			else if (count9bit == X_SCREEN_PIXELS && count8bit == Y_SCREEN_PIXELS) begin
				count9bit <= 0;
				count8bit <= 0;
			end
         else count9bit <= count9bit + 1;
         oColour <= 3'b100;
         oX <= count9bit;
         oY <= count8bit;
      end
      else if(increment_LEFT) begin
        newcharx <= charx - 1;
        newchary <= chary;
      end
      else if(increment_UP) begin
        newcharx <= charx;
        newchary <= chary - 1;
      end
      else if(increment_RIGHT) begin
        newcharx <= charx + 1;
        newchary <= chary;
      end
      else if(increment_DOWN) begin
        newcharx <= charx;
        newchary <= chary + 1;
      end
      else if(check_position) begin
        case (newchary)
            0: begin
                if (row0[6'd24 - newcharx]) begin //note that "x position" of character increases to the right, but bit number increases to the left
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            1: begin
                if (row1[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            2: begin
                if (row2[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            3: begin
                if (row3[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            4: begin
                if (row4[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            5: begin
                if (row5[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            6: begin
                if (row6[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            7: begin
                if (row7[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            8: begin
                if (row8[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            9: begin
                if (row9[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            10: begin
                if (row10[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            11: begin
                if (row11[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            12: begin
                if (row12[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            13: begin
                if (row13[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            14: begin
                if (row14[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            15: begin
                if (row15[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            16: begin
                if (row16[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            17: begin
                if (row17[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            18: begin
                if (row18[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            19: begin
                if (row19[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            20: begin
                if (row20[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            21: begin
                if (row21[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            22: begin
                if (row22[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            23: begin
                if (row23[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            24: begin
                if (row24[6'd24 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
        endcase
      end

        else if(check_position_2) begin
        case (newchary)
            0: begin
                if (row0_2[6'd36 - newcharx]) begin 
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            1: begin
                if (row1_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            2: begin
                if (row2_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            3: begin
                if (row3_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            4: begin
                if (row4_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            5: begin
                if (row5_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            6: begin
                if (row6_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            7: begin
                if (row7_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            8: begin
                if (row8_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            9: begin
                if (row9_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            10: begin
                if (row10_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            11: begin
                if (row11_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            12: begin
                if (row12_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            13: begin
                if (row13_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            14: begin
                if (row14_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            15: begin
                if (row15_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            16: begin
                if (row16_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            17: begin
                if (row17_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            18: begin
                if (row18_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            19: begin
                if (row19_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            20: begin
                if (row20_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            21: begin
                if (row21_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            22: begin
                if (row22_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            23: begin
                if (row23_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            24: begin
                if (row24_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            25: begin
                if (row25_2[6'd36 - newcharx]) begin 
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            26: begin
                if (row26_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            27: begin
                if (row27_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            28: begin
                if (row28_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            29: begin
                if (row29_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            30: begin
                if (row30_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            31: begin
                if (row31_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            32: begin
                if (row32_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            33: begin
                if (row33_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            34: begin
                if (row34_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            35: begin
                if (row35_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            36: begin
                if (row36_2[6'd36 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
        endcase
      end

      else if(check_position_3) begin
        case (newchary)
            0: begin
                if (row0_3[6'd48 - newcharx]) begin 
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            1: begin
                if (row1_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            2: begin
                if (row2_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            3: begin
                if (row3_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            4: begin
                if (row4_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            5: begin
                if (row5_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            6: begin
                if (row6_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            7: begin
                if (row7_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            8: begin
                if (row8_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            9: begin
                if (row9_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            10: begin
                if (row10_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            11: begin
                if (row11_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            12: begin
                if (row12_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            13: begin
                if (row13_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            14: begin
                if (row14_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            15: begin
                if (row15_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            16: begin
                if (row16_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            17: begin
                if (row17_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            18: begin
                if (row18_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            19: begin
                if (row19_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            20: begin
                if (row20_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            21: begin
                if (row21_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            22: begin
                if (row22_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            23: begin
                if (row23_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            24: begin
                if (row24_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            25: begin
                if (row25_3[6'd48 - newcharx]) begin 
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            26: begin
                if (row26_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            27: begin
                if (row27_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            28: begin
                if (row28_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            29: begin
                if (row29_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            30: begin
                if (row30_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            31: begin
                if (row31_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            32: begin
                if (row32_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            33: begin
                if (row33_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            34: begin
                if (row34_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            35: begin
                if (row35_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            36: begin
                if (row36_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            37: begin
                if (row37_3[6'd48 - newcharx]) begin 
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            38: begin
                if (row38_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            39: begin
                if (row39_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            40: begin
                if (row40_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            41: begin
                if (row41_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            42: begin
                if (row42_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            43: begin
                if (row43_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            44: begin
                if (row44_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            45: begin
                if (row45_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            46: begin
                if (row46_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            47: begin
                if (row47_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
            48: begin
                if (row48_3[6'd48 - newcharx]) begin
                    newcharx <= charx;
                    newchary <= chary;
                end 
                else begin
                    charx <= newcharx;
                    chary <= newchary;
                end
            end
        endcase
      end

   end

   

endmodule

module control #(parameter X_SCREEN_PIXELS = 320, Y_SCREEN_PIXELS = 240, SIZE_UNIT_EASY = 64, SIZE_UNIT_HARD = 16, CLOCK_FREQUENCY = 50000000)(
    input iResetn, iClock,

    input start,        
    input start_two,    
	 
	 input start_3, // for passing frames
	 
    input switch_up_down,
    input victory,       

    input mv_left,       // KEY 3
    input mv_vert,       // KEY 2
    input mv_right,      // KEY 1

    input timeout,       // output of the timer module within datapath

    input [1:0] olevel,

    input [1:0] skip_to_hardest, // -----------------------------
	 
	 input [7:0] key_data,
	 input key_en,

    output reg increment_LEFT,
    output reg increment_UP,
    output reg increment_RIGHT,
    output reg increment_DOWN,

    output reg check_position,
    output reg check_position_2,
    output reg check_position_3,
    
    output reg oPlot,
    output reg victory_first,

    output reg clear_en_1,
    output reg clear_en_2,
    output reg clear_en_3, 
    
    output reg draw_maze_enable_1,
    output reg draw_maze_enable_2,
    output reg draw_maze_enable_3,

    output reg draw_destination_enable_1,
    output reg draw_destination_enable_2,
    output reg draw_destination_enable_3,

    output reg draw_character_enable_1,
    output reg draw_character_enable_2,
    output reg draw_character_enable_3,

    output reg draw_victory_enable,

    output reg draw_lose_enable,
    output reg enable_timer,
	 
	 output reg draw_title_1_enable,
	 output reg draw_title_2_enable,
	 output reg draw_frame_1_enable,
	 output reg draw_frame_2_enable,
	 output reg draw_frame_3_enable,
	 output reg draw_frame_4_enable,
	 output reg draw_frame_5_enable,
	 output reg draw_frame_6_enable,
	 output reg draw_frame_7_enable,
	 output reg draw_frame_8_enable,
	 output reg draw_frame_9_enable,
	 output reg draw_frame_10_enable,
	 output reg draw_frame_11_enable,
	 output reg draw_frame_12_enable,
	 output reg draw_frame_13_enable,
	 output reg draw_frame_14_enable,
	 output reg draw_frame_15_enable,
	 output reg draw_frame_16_enable,
	 output reg draw_frame_over_enable,
	 output reg draw_frame_end_enable,

    output reg [1:0] level

);

   reg [6:0] current_state, next_state;
   reg [16:0] draw_count;
   reg [16:0] clear_count;
   reg victory_wait_pre; // ---------- new, added for 50M cycles counter for S_VICTORY_WAIT
   reg victory_wait_post;
   reg [25:0] victory_timer;
	
	reg [15:0] key_data_2; // NEW-------------------------


   localparam

	    S_INITIAL = 7'd0,
        S_START = 7'd1,
         
        S_CLEAR_1 = 7'd2,
        S_DRAW_WAIT_1 = 7'd3,

        S_DRAW_MAZE_1 = 7'd4,
        S_DRAW_DESTINATION_1 = 7'd5,
        S_DRAW_CHARACTER_1 = 7'd6,

        // ----------------- FIRST MAZE -------------------------

        S_INPUT_WAIT = 7'd7,

        S_LEFT_WAIT = 7'd8,
        S_UP_WAIT = 7'd9,
        S_RIGHT_WAIT = 7'd10,
        S_DOWN_WAIT = 7'd11,

        S_MOVE_LEFT = 7'd12,
        S_MOVE_UP = 7'd13,
        S_MOVE_RIGHT = 7'd14,
        S_MOVE_DOWN = 7'd15,

        // ------------- CHECKERS ------------------------

        S_CHECKER_1 = 7'd16,
        S_CHECKER_2 = 7'd17,
        S_CHECKER_3 = 7'd18,

        // ---------- VICTORY STATES ---------------------------

        S_VICTORY_WAIT_PRE = 7'd19,
        S_VICTORY_WAIT_POST_1 = 7'd20,
        S_VICTORY_WAIT_POST_2 = 7'd21,
        S_VICTORY_WAIT_POST_3 = 7'd22,

        S_VICTORY_DRAW = 7'd23,

        // ----------- SECOND MAZE ----------------------------

        S_CLEAR_2 = 7'd24,
        S_DRAW_WAIT_2 = 7'd25,
        S_DRAW_MAZE_2 = 7'd26,
        S_DRAW_DESTINATION_2 = 7'd27,
        S_DRAW_CHARACTER_2 = 7'd28,

        // ----------- THIRD MAZE -----------------------------

        S_CLEAR_3 = 7'd29,
        S_DRAW_WAIT_3 = 7'd30,
        S_DRAW_MAZE_3 = 7'd31,
        S_DRAW_DESTINATION_3 = 7'd32,
        S_DRAW_CHARACTER_3 = 7'd33,
		  
		  // ------------- MEMORY IMAGES -------------------------
		  
		  S_FRAME_1 = 7'd37,
		  S_FRAME_1_POST = 7'd38,
		  S_FRAME_2 = 7'd39,
		  S_FRAME_2_POST = 7'd40,
		  S_FRAME_3 = 7'd41,
		  S_FRAME_3_POST = 7'd42,
		  S_FRAME_4 = 7'd43,
		  S_FRAME_4_POST = 7'd44,
		  S_FRAME_5 = 7'd45,
		  S_FRAME_5_POST = 7'd46,
		  S_FRAME_6 = 7'd47,
		  S_FRAME_6_POST = 7'd48,
		  S_FRAME_7 = 7'd49,
		  S_FRAME_7_POST = 7'd50,
		  S_FRAME_8 = 7'd51,
		  S_FRAME_8_POST = 7'd52,
		  S_FRAME_9 = 7'd53,
		  S_FRAME_9_POST = 7'd54,
		  S_FRAME_10 = 7'd55,
		  S_FRAME_10_POST = 7'd56,
		  S_FRAME_11 = 7'd57,
		  S_FRAME_11_POST = 7'd58,
		  S_FRAME_12 = 7'd59,
		  S_FRAME_12_POST = 7'd60,
		  S_FRAME_13 = 7'd61,
		  S_FRAME_13_POST = 7'd62,
		  S_FRAME_14 = 7'd63,
		  S_FRAME_14_POST = 7'd64,
		  S_FRAME_15 = 7'd65,
		  S_FRAME_15_POST = 7'd66,
		  S_FRAME_16 = 7'd67,
		  S_FRAME_16_POST = 7'd68,
		  
		  S_TITLE_1 = 7'd69,
		  S_TITLE_POST = 7'd71,
		  
		  S_FRAME_END = 7'd72,
		  
		  // ------------ GAME OVER -----------------------------

        S_GAME_OVER = 7'd34,

        // ------------ LAST STATE FOR TESTING PURPOSES ------------

        S_SKIP_TO_HARDEST = 7'd36; //turn either SW[2] or SW[3] high at reset


    always @(*) 
    begin: state_table
        case (current_state)
         
		
		S_TITLE_1: next_state <= mv_left ? S_TITLE_POST : S_TITLE_1;
		
		S_TITLE_POST: next_state <= mv_left ? S_TITLE_POST : S_FRAME_1;
		 
		S_FRAME_1: next_state <= mv_left ? S_FRAME_1_POST : S_FRAME_1;
		S_FRAME_1_POST: next_state  <= mv_left ? S_FRAME_1_POST : S_FRAME_2;
		S_FRAME_2: next_state  <= mv_left ? S_FRAME_2_POST : S_FRAME_2;
		S_FRAME_2_POST: next_state  <= mv_left ? S_FRAME_2_POST : S_FRAME_3;
		S_FRAME_3: next_state <= mv_left ? S_FRAME_3_POST : S_FRAME_3;
		S_FRAME_3_POST: next_state  <= mv_left ? S_FRAME_3_POST : S_FRAME_4;
		S_FRAME_4: next_state <= mv_left ? S_FRAME_4_POST : S_FRAME_4;
		S_FRAME_4_POST: next_state  <= mv_left ? S_FRAME_4_POST : S_FRAME_5;
		S_FRAME_5: next_state <= mv_left ? S_FRAME_5_POST : S_FRAME_5;
		S_FRAME_5_POST: next_state  <= mv_left ? S_FRAME_5_POST : S_DRAW_WAIT_1;
		
		
		S_FRAME_6: next_state <= mv_left ? S_FRAME_6_POST : S_FRAME_6;
		S_FRAME_6_POST: next_state  <= mv_left ? S_FRAME_6_POST : S_FRAME_7;
		S_FRAME_7: next_state <= mv_left ? S_FRAME_7_POST : S_FRAME_7;
		S_FRAME_7_POST: next_state  <= mv_left ? S_FRAME_7_POST : S_FRAME_8;
		S_FRAME_8: next_state <= mv_left ? S_FRAME_8_POST : S_FRAME_8;
		S_FRAME_8_POST: next_state  <= mv_left ? S_FRAME_8_POST : S_FRAME_9;
		S_FRAME_9: next_state <= mv_left ? S_FRAME_9_POST : S_FRAME_9;
		S_FRAME_9_POST: next_state  <= mv_left ? S_FRAME_9_POST : S_FRAME_10;
		S_FRAME_10: next_state <= mv_left ? S_FRAME_10_POST : S_FRAME_10;
		S_FRAME_10_POST: next_state  <= mv_left ? S_FRAME_10_POST : S_DRAW_WAIT_2;
		
		
		S_FRAME_11: next_state <= mv_left ? S_FRAME_11_POST : S_FRAME_11;
		S_FRAME_11_POST: next_state  <= mv_left ? S_FRAME_11_POST : S_FRAME_12;
		S_FRAME_12: next_state <= mv_left ? S_FRAME_12_POST : S_FRAME_12;
		S_FRAME_12_POST: next_state  <= mv_left ? S_FRAME_12_POST : S_FRAME_13;
		S_FRAME_13: next_state <= mv_left ? S_FRAME_13_POST : S_FRAME_13;
		S_FRAME_13_POST: next_state  <= mv_left ? S_FRAME_13_POST : S_FRAME_14;
		S_FRAME_14: next_state <= mv_left ? S_FRAME_14_POST : S_FRAME_14;
		S_FRAME_14_POST: next_state  <= mv_left ? S_FRAME_14_POST : S_FRAME_15;
		S_FRAME_15: next_state <= mv_left ? S_FRAME_15_POST : S_FRAME_15;
		S_FRAME_15_POST: next_state  <= mv_left ? S_FRAME_15_POST : S_FRAME_16;
		S_FRAME_16: next_state <= mv_left ? S_FRAME_16_POST : S_FRAME_16;
		S_FRAME_16_POST: next_state  <= mv_left ? S_FRAME_16_POST : S_DRAW_WAIT_3;
		
		  
		S_FRAME_END: next_state <= S_FRAME_END;
		 
		 
		 S_CLEAR_1: next_state <= S_DRAW_MAZE_1;

        S_DRAW_WAIT_1: next_state <= S_CLEAR_1;
	    S_DRAW_MAZE_1: next_state <= S_DRAW_DESTINATION_1;
        S_DRAW_DESTINATION_1: next_state <= S_DRAW_CHARACTER_1;
        S_DRAW_CHARACTER_1: next_state <= victory ? S_VICTORY_WAIT_PRE : S_INPUT_WAIT;

        S_CLEAR_2: next_state <= S_DRAW_MAZE_2;

        S_DRAW_WAIT_2: next_state <= S_CLEAR_2;
	    S_DRAW_MAZE_2: next_state <= S_DRAW_DESTINATION_2;
        S_DRAW_DESTINATION_2: next_state <= S_DRAW_CHARACTER_2;
        S_DRAW_CHARACTER_2: next_state <= victory ? S_VICTORY_WAIT_PRE : S_INPUT_WAIT;

        S_CLEAR_3: next_state <= S_DRAW_MAZE_3;

        S_DRAW_WAIT_3: next_state <= S_CLEAR_3;
	    S_DRAW_MAZE_3: next_state <= S_DRAW_DESTINATION_3;
        S_DRAW_DESTINATION_3: next_state <= S_DRAW_CHARACTER_3;
        S_DRAW_CHARACTER_3: next_state <= victory ? S_VICTORY_WAIT_PRE : S_INPUT_WAIT;

        
// -----------------------------------
        S_INPUT_WAIT: begin
            if(timeout) next_state <= S_GAME_OVER;
            else if (mv_left | (key_data == 8'h1C && key_en == 1'b1)) next_state <= S_LEFT_WAIT;
            else if (mv_vert) begin
            if (switch_up_down) next_state <= S_UP_WAIT;
            else next_state <= S_DOWN_WAIT;
            end
				else if (key_data == 8'h1D && key_en == 1'b1) next_state <= S_UP_WAIT;
				else if (key_data == 8'h1B && key_en == 1'b1) next_state <= S_DOWN_WAIT;
            else if (mv_right | (key_data == 8'h23 && key_en == 1'b1)) next_state <= S_RIGHT_WAIT;
            else next_state <= S_INPUT_WAIT;
        end
      
        S_LEFT_WAIT: next_state <= (mv_left | (key_data == 8'h1C && key_en == 1'b0)) ? S_LEFT_WAIT : S_MOVE_LEFT;
        S_UP_WAIT: next_state <= (mv_vert | | (key_data == 8'h1D && key_en == 1'b0)) ? S_UP_WAIT : S_MOVE_UP;
        S_RIGHT_WAIT: next_state <= (mv_right | (key_data == 8'h1B && key_en == 1'b0)) ? S_RIGHT_WAIT : S_MOVE_RIGHT;
        S_DOWN_WAIT: next_state <= (mv_vert | (key_data == 8'h23 && key_en == 1'b0)) ? S_DOWN_WAIT : S_MOVE_DOWN;

        S_MOVE_LEFT: begin 
            if (olevel == 2'd1) next_state <= S_CHECKER_1;
            else if (olevel == 2'd2) next_state <= S_CHECKER_2;
            else if (olevel == 2'd3) next_state <= S_CHECKER_3;
            else next_state <= S_GAME_OVER; //prevent inferred latch caused by potentially undefined behaviour

        end
        S_MOVE_UP: begin
            if (olevel == 2'd1) next_state <= S_CHECKER_1;
            else if (olevel == 2'd2) next_state <= S_CHECKER_2;
            else if (olevel == 2'd3) next_state <= S_CHECKER_3;
            else next_state <= S_GAME_OVER;
        end
        S_MOVE_RIGHT: begin
            if (olevel == 2'd1) next_state <= S_CHECKER_1;
            else if (olevel == 2'd2) next_state <= S_CHECKER_2;
            else if (olevel == 2'd3) next_state <= S_CHECKER_3;
            else next_state <= S_GAME_OVER;
        end
        S_MOVE_DOWN: begin
            if (olevel == 2'd1) next_state <= S_CHECKER_1;
            else if (olevel == 2'd2) next_state <= S_CHECKER_2;
            else if (olevel == 2'd3) next_state <= S_CHECKER_3;
            else next_state <= S_GAME_OVER;
        end

        S_CHECKER_1: next_state <= S_DRAW_MAZE_1;
        S_CHECKER_2: next_state <= S_DRAW_MAZE_2;
        S_CHECKER_3: next_state <= S_DRAW_MAZE_3;


        S_VICTORY_WAIT_PRE: next_state <= S_VICTORY_DRAW;

        S_VICTORY_WAIT_POST_1: next_state <= S_FRAME_6;
        S_VICTORY_WAIT_POST_2: next_state <= S_FRAME_11;
        S_VICTORY_WAIT_POST_3: next_state <= S_FRAME_END;

        S_VICTORY_DRAW: begin
            if (olevel == 2'd1) next_state <= S_VICTORY_WAIT_POST_1;
            else if (olevel == 2'd2) next_state <= S_VICTORY_WAIT_POST_2;
            else if (olevel == 2'd3) next_state <= S_VICTORY_WAIT_POST_3;
            else next_state <= S_FRAME_END;
        end


        S_GAME_OVER: next_state <= S_GAME_OVER;

        S_SKIP_TO_HARDEST: begin 
            if (skip_to_hardest == 2'd1) next_state <= S_VICTORY_WAIT_POST_1;
            else if (skip_to_hardest == 2'd2) next_state <= S_VICTORY_WAIT_POST_2;
            else next_state <= S_GAME_OVER;

        end

        endcase
    end

    always @(*)
        begin: enable_signals
        //start by setting all signals to 0

        draw_maze_enable_1 = 1'b0;
        draw_maze_enable_2 = 1'b0;
        draw_maze_enable_3 = 1'b0;

        draw_destination_enable_1 = 1'b0;
        draw_destination_enable_2 = 1'b0;
        draw_destination_enable_3 = 1'b0;

        draw_character_enable_1 = 1'b0;
        draw_character_enable_2 = 1'b0;
        draw_character_enable_3 = 1'b0;

        clear_en_1 = 1'b0;
        clear_en_2 = 1'b0;
        clear_en_3 = 1'b0;

        oPlot = 1'b0;

        enable_timer = 1'b0;

        increment_LEFT = 1'b0;
        increment_UP = 1'b0;
        increment_RIGHT = 1'b0;
        increment_DOWN = 1'b0;

        check_position = 1'b0;
        check_position_2 = 1'b0;
        check_position_3 = 1'b0;
        victory_wait_pre = 1'b0;
        victory_wait_post = 1'b0;
        victory_first = 1'b0;
        draw_victory_enable = 1'b0;

        draw_lose_enable = 1'b0;

        level = 2'd0;
		  
		  draw_title_1_enable = 1'b0;
		  draw_title_2_enable = 1'b0;
		  draw_frame_1_enable = 1'b0;
		  draw_frame_2_enable = 1'b0;
		  draw_frame_3_enable = 1'b0;
		  draw_frame_4_enable = 1'b0;
		  draw_frame_5_enable = 1'b0;
		  draw_frame_6_enable = 1'b0;
		  draw_frame_7_enable = 1'b0;
		  draw_frame_8_enable = 1'b0;
		  draw_frame_9_enable = 1'b0;
		  draw_frame_10_enable = 1'b0;
		  draw_frame_11_enable = 1'b0;
		  draw_frame_12_enable = 1'b0;
		  draw_frame_13_enable = 1'b0;
		  draw_frame_14_enable = 1'b0;
		  draw_frame_15_enable = 1'b0;
		  draw_frame_16_enable = 1'b0;
		  draw_frame_over_enable = 1'b0;
		  draw_frame_end_enable = 1'b0;
		  

        case(current_state)
            S_CLEAR_1: begin
                clear_en_1 <= 1'b1;
                oPlot <= 1'b1;
            end
            S_CLEAR_2: begin
                clear_en_2 <= 1'b1;
                oPlot <= 1'b1;
            end
            S_CLEAR_3: begin
                clear_en_3 <= 1'b1;
                oPlot <= 1'b1;
            end
            S_DRAW_WAIT_1: begin
                level <= 2'd1;
            end
            S_DRAW_WAIT_2: begin
                level <= 2'd2;
            end
            S_DRAW_WAIT_3: begin
                level <= 2'd3;
            end
            S_DRAW_MAZE_1: begin
            oPlot <= 1'b1;
            draw_maze_enable_1 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_DRAW_MAZE_2: begin
            oPlot <= 1'b1;
            draw_maze_enable_2 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_DRAW_MAZE_3: begin
            oPlot <= 1'b1;
            draw_maze_enable_3 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_DRAW_DESTINATION_1: begin
            oPlot <= 1'b1;
            draw_destination_enable_1 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_DRAW_DESTINATION_2: begin
            oPlot <= 1'b1;
            draw_destination_enable_2 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_DRAW_DESTINATION_3: begin
            oPlot <= 1'b1;
            draw_destination_enable_3 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_DRAW_CHARACTER_1: begin
            oPlot <= 1'b1;
            draw_character_enable_1 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_DRAW_CHARACTER_2: begin
            oPlot <= 1'b1;
            draw_character_enable_2 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_DRAW_CHARACTER_3: begin
            oPlot <= 1'b1;
            draw_character_enable_3 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_INPUT_WAIT: begin
            enable_timer <= 1'b1;
            end
            S_CHECKER_1: begin
            check_position <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_CHECKER_2: begin
            check_position_2 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_CHECKER_3: begin
            check_position_3 <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_MOVE_LEFT: begin
            increment_LEFT <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_MOVE_UP: begin
            increment_UP <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_MOVE_RIGHT: begin
            increment_RIGHT <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_MOVE_DOWN: begin
            increment_DOWN <= 1'b1;
            enable_timer <= 1'b1;
            end
            S_LEFT_WAIT: begin
            enable_timer <= 1'b1;
            end
            S_UP_WAIT: begin
            enable_timer <= 1'b1;
            end
            S_RIGHT_WAIT: begin
            enable_timer <= 1'b1;
            end
            S_DOWN_WAIT: begin
            enable_timer <= 1'b1;
            end
            S_VICTORY_WAIT_PRE: begin
            victory_wait_pre = 1'b1;
            end
            S_VICTORY_WAIT_POST_1: begin
            victory_wait_post = 1'b1;
            end
            S_VICTORY_WAIT_POST_2: begin
            victory_wait_post = 1'b1;
            end
            S_VICTORY_WAIT_POST_3: begin
            victory_wait_post = 1'b1;
            end
            S_VICTORY_DRAW: begin
            oPlot <= 1'b1;
            draw_victory_enable <= 1'b1;
            end
            
				
				S_TITLE_1: begin
				draw_title_1_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_1: begin
				draw_frame_1_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_2: begin
				draw_frame_2_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_3: begin
				draw_frame_3_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_4: begin
				draw_frame_4_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_5: begin
				draw_frame_5_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_6: begin
				draw_frame_6_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_7: begin
				draw_frame_7_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_8: begin
				draw_frame_8_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_9: begin
				draw_frame_9_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_10: begin
				draw_frame_10_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_11: begin
				draw_frame_11_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_12: begin
				draw_frame_12_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_13: begin
				draw_frame_13_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_14: begin
				draw_frame_14_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_15: begin
				draw_frame_15_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				S_FRAME_16: begin
				draw_frame_16_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				
				S_FRAME_END: begin
				draw_frame_end_enable <= 1'b1;
				oPlot <= 1'b1;
				end
				
				
            S_GAME_OVER: begin
            oPlot <= 1'b1;
            draw_frame_over_enable <= 1'b1;
            end         
        endcase
    end

    always @(posedge iClock) begin: state_FFs
        if (iResetn) begin
            if (skip_to_hardest == 2'd1 | skip_to_hardest == 2'd2) current_state <= S_SKIP_TO_HARDEST;
            else current_state <= S_TITLE_1;
            draw_count <= 17'b0;
            clear_count <= 17'b0;
            victory_timer <= 26'b0;
        end
        else if(draw_lose_enable) begin
            if (draw_count == X_SCREEN_PIXELS * Y_SCREEN_PIXELS) begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (draw_maze_enable_1)begin
            if (draw_count == SIZE_UNIT_EASY * 10'd625)begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (draw_maze_enable_2)begin
            if (draw_count == SIZE_UNIT_HARD * 11'd1369)begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (draw_maze_enable_3)begin
            if (draw_count == SIZE_UNIT_HARD * 12'd2401)begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (draw_destination_enable_1)begin
            if (draw_count == SIZE_UNIT_EASY) begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (draw_destination_enable_2)begin
            if (draw_count == SIZE_UNIT_HARD) begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (draw_destination_enable_3)begin
            if (draw_count == SIZE_UNIT_HARD) begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (draw_character_enable_1)begin
            if (draw_count == SIZE_UNIT_EASY) begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (draw_character_enable_2)begin
            if (draw_count == SIZE_UNIT_HARD) begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (draw_character_enable_3)begin
            if (draw_count == SIZE_UNIT_HARD) begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (victory_wait_pre) begin
            if (victory_timer == CLOCK_FREQUENCY) begin
                victory_timer <= 26'b0; 
                current_state <= next_state;
            end
            else victory_timer <= victory_timer + 1;
        end
        else if (victory_wait_post) begin
            if (victory_timer == CLOCK_FREQUENCY) begin
                victory_timer <= 26'b0; 
                current_state <= next_state;
            end
            else victory_timer <= victory_timer + 1;
        end
        else if (draw_victory_enable)begin
            if (draw_count == X_SCREEN_PIXELS * Y_SCREEN_PIXELS) begin
                draw_count <= 17'b0;
                current_state <= next_state;
            end
            else draw_count <= draw_count + 1;
        end
        else if (clear_en_1)begin
            if (clear_count == X_SCREEN_PIXELS * Y_SCREEN_PIXELS) begin
                clear_count <= 17'b0;
                current_state <= next_state;
            end
            else clear_count <= clear_count + 1;
        end
        else if (clear_en_2)begin
            if (clear_count == X_SCREEN_PIXELS * Y_SCREEN_PIXELS) begin
                clear_count <= 17'b0;
                current_state <= next_state;
            end
            else clear_count <= clear_count + 1;
        end
        else if (clear_en_3)begin
            if (clear_count == X_SCREEN_PIXELS * Y_SCREEN_PIXELS) begin
                clear_count <= 17'b0;
                current_state <= next_state;
            end
            else clear_count <= clear_count + 1;
        end
        else current_state <= next_state;
    end

endmodule


module timer
    #(parameter CLOCK_FREQUENCY = 50000000)
    (input Reset, clock, input [1:0] level, input enable_timer,
    output reg [3:0] hundreds, tens, ones, output timeout,
    output reg [9:0] percent);

    reg [27:0] count;
    reg [1:0] rlevel;

    always@(posedge clock)
    begin
        if (Reset)
        begin
            count <= CLOCK_FREQUENCY - 1;
            hundreds <= 4'b0;
            tens <= 4'b0;
            ones <= 4'b0;
            percent <= 10'b0;
            rlevel <= 2'b0;
        end
        else if (level == 2'b01)
        begin
            count <= CLOCK_FREQUENCY - 1;
            hundreds <= 4'd0;
            tens <= 4'd7;
            ones <= 4'd0;
            percent <= {10{1'b1}};
            rlevel <= 2'b01;
        end
        else if (level == 2'b10)
        begin
            count <= CLOCK_FREQUENCY - 1;
            hundreds <= 4'd3;
            tens <= 4'd6;
            ones <= 4'd0;
            percent <= {10{1'b1}};
            rlevel <= 2'b10;
        end
        else if (level == 2'b11)
        begin
            count <= CLOCK_FREQUENCY - 1;
            hundreds <= 4'd5;
            tens <= 4'd0;
            ones <= 4'd0;
            percent <= {10{1'b1}};
            rlevel <= 2'b11;
        end
        else if (enable_timer)
        begin
            if (count == 'b0)
            begin
                count <= CLOCK_FREQUENCY - 1;
                if (ones != 'b0)
                begin
                    ones <= ones - 1;
                end
                else
                begin
                    if (tens != 'b0)
                    begin
                        tens <= tens - 1;
                        ones <= 4'd9;
                    end
                    else
                    begin
                        if (hundreds != 'b0)
                        begin
                            hundreds <= hundreds - 1;
                            tens <= 4'd9;
                            ones <= 4'd9;
                        end
                        else
                        begin
                            hundreds <= 4'd0;
                            tens <= 4'd0;
                            ones <= 4'd0;
                        end
                    end
                end
            end
            else
            begin
                count <= count - 1;
            end
            if (rlevel == 2'b01)
            begin
                if (tens == 4'd6 & ones == 4'd3) percent[9] <= 1'b0;
                else if (tens == 4'd5 & ones == 4'd6) percent[8] <= 1'b0;
                else if (tens == 4'd4 & ones == 4'd9) percent[7] <= 1'b0;
                else if (tens == 4'd4 & ones == 4'd2) percent[6] <= 1'b0;
                else if (tens == 4'd3 & ones == 4'd5) percent[5] <= 1'b0;
                else if (tens == 4'd2 & ones == 4'd8) percent[4] <= 1'b0;
                else if (tens == 4'd2 & ones == 4'd1) percent[3] <= 1'b0;
                else if (tens == 4'd1 & ones == 4'd4) percent[2] <= 1'b0;
                else if (tens == 4'd0 & ones == 4'd7) percent[1] <= 1'b0;
                else if (tens == 4'd0 & ones == 4'd0) percent[0] <= 1'b0;
            end
            if (rlevel == 2'b10)
            begin
                if (hundreds == 4'd3 & tens == 4'd2 & ones == 4'd4) percent[9] <= 1'b0;
                else if (hundreds == 4'd2 & tens == 4'd8 & ones == 4'd8) percent[8] <= 1'b0;
                else if (hundreds == 4'd2 & tens == 4'd5 & ones == 4'd2) percent[7] <= 1'b0;
                else if (hundreds == 4'd2 & tens == 4'd1 & ones == 4'd6) percent[6] <= 1'b0;
                else if (hundreds == 4'd1 & tens == 4'd8 & ones == 4'd0) percent[5] <= 1'b0;
                else if (hundreds == 4'd1 & tens == 4'd4 & ones == 4'd4) percent[4] <= 1'b0;
                else if (hundreds == 4'd1 & tens == 4'd0 & ones == 4'd8) percent[3] <= 1'b0;
                else if (hundreds == 4'd0 & tens == 4'd7 & ones == 4'd2) percent[2] <= 1'b0;
                else if (hundreds == 4'd0 & tens == 4'd3 & ones == 4'd6) percent[1] <= 1'b0;
                else if (hundreds == 4'd0 & tens == 4'd0 & ones == 4'd0) percent[0] <= 1'b0;
            end
            if (rlevel == 2'b11)
            begin
                if (hundreds == 4'd4 & tens == 4'd5 & ones == 4'd0) percent[9] <= 1'b0;
                else if (hundreds == 4'd4 & tens == 4'd0 & ones == 4'd0) percent[8] <= 1'b0;
                else if (hundreds == 4'd3 & tens == 4'd5 & ones == 4'd0) percent[7] <= 1'b0;
                else if (hundreds == 4'd3 & tens == 4'd0 & ones == 4'd0) percent[6] <= 1'b0;
                else if (hundreds == 4'd2 & tens == 4'd5 & ones == 4'd0) percent[5] <= 1'b0;
                else if (hundreds == 4'd2 & tens == 4'd0 & ones == 4'd0) percent[4] <= 1'b0;
                else if (hundreds == 4'd1 & tens == 4'd5 & ones == 4'd0) percent[3] <= 1'b0;
                else if (hundreds == 4'd1 & tens == 4'd0 & ones == 4'd0) percent[2] <= 1'b0;
                else if (hundreds == 4'd0 & tens == 4'd5 & ones == 4'd0) percent[1] <= 1'b0;
                else if (hundreds == 4'd0 & tens == 4'd0 & ones == 4'd0) percent[0] <= 1'b0;
            end
        end
    end

    assign timeout = (hundreds == 'b0 & tens == 'b0 & ones == 'b0);

endmodule
