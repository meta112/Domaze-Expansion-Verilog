module domaze_fpga
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		KEY,							// On Board Keys
		SW,
        HEX2,
        HEX1,
        HEX0,
        LEDR,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,   						//	VGA Blue[9:0]
		
		PS2_CLK,
		PS2_DAT
	);
	
	inout PS2_CLK;
	inout PS2_DAT;

	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;					
	input [9:0] SW;
    output [6:0] HEX2, HEX1, HEX0;
    output [9:0] LEDR;
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [8:0] x;
	wire [7:0] y;
	wire writeEn;
	wire done;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "320x240";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	
	
	PS2_Controller p2(
	// Inputs
	.CLOCK_50(CLOCK_50),
	.reset(~KEY[0]),

	// Bidirectionals
	.PS2_CLK(PS2_CLK),					// PS2 Clock
 	.PS2_DAT(PS2_DAT),					// PS2 Data
	//PS2_CLK,PIN_D26
	//PS2_DAT,PIN_C24

	.received_data(received_data),
	.received_data_en(received_data_en)			// If 1 - new data has been received
);

	wire [7:0] received_data;
	wire received_data_en;
	
    wire [3:0] hundreds, tens, ones;
	 
	 
	 wire [14:0] address_over;
	 wire [2:0] q_over;
	 
	 wire [14:0] address_title_1;
	 wire [2:0] q_title_1;
	 
	 wire [14:0] address_title_2;
	 wire [2:0] q_title_2;
	 
	 wire [14:0] address_frame_1;
	 wire [2:0] q_frame_1;
	 
	 wire [14:0] address_frame_2;
	 wire [2:0] q_frame_2;
	 
	 wire [14:0] address_frame_3;
	 wire [2:0] q_frame_3;
	 
	 wire [14:0] address_frame_4;
	 wire [2:0] q_frame_4;
	 
	 wire [14:0] address_frame_5;
	 wire [2:0] q_frame_5;
	 
	 wire [14:0] address_frame_6;
	 wire [2:0] q_frame_6;
	 
	 wire [14:0] address_frame_7;
	 wire [2:0] q_frame_7;
	 
	 wire [14:0] address_frame_8;
	 wire [2:0] q_frame_8;
	 
	 wire [14:0] address_frame_9;
	 wire [2:0] q_frame_9;
	 
	 wire [14:0] address_frame_10;
	 wire [2:0] q_frame_10;
	 
	 wire [14:0] address_frame_11;
	 wire [2:0] q_frame_11;
	 
	 wire [14:0] address_frame_12;
	 wire [2:0] q_frame_12;
	 
	 wire [14:0] address_frame_13;
	 wire [2:0] q_frame_13;
	 
	 wire [14:0] address_frame_14;
	 wire [2:0] q_frame_14;
	 
	 wire [14:0] address_frame_15;
	 wire [2:0] q_frame_15;
	 
	 wire [14:0] address_frame_16;
	 wire [2:0] q_frame_16;
	 
	 wire [14:0] address_end;
	 wire [2:0] q_end;
	 
	 rom_game_over rgo(address_over, CLOCK_50, q_over);
	 rom_frame_end rfe(address_end, CLOCK_50, q_end);
	 rom_title_frame_1 rtf1(address_title_1, CLOCK_50, q_title_1);
	 rom_title_frame_2 rtf2(address_title_2, CLOCK_50, q_title_2);
	 
	 rom_frame_1 rf1(address_frame_1, CLOCK_50, q_frame_1);
	 rom_frame_2 rf2(address_frame_2, CLOCK_50, q_frame_2);
	 rom_frame_3 rf3(address_frame_3, CLOCK_50, q_frame_3);
	 rom_frame_4 rf4(address_frame_4, CLOCK_50, q_frame_4);
	 rom_frame_5 rf5(address_frame_5, CLOCK_50, q_frame_5);
	 rom_frame_6 rf6(address_frame_6, CLOCK_50, q_frame_6);
	 rom_frame_7 rf7(address_frame_7, CLOCK_50, q_frame_7);
	 rom_frame_8 rf8(address_frame_8, CLOCK_50, q_frame_8);
	 rom_frame_9 rf9(address_frame_9, CLOCK_50, q_frame_9);
	 rom_frame_10 rf10(address_frame_10, CLOCK_50, q_frame_10);
	 rom_frame_11 rf11(address_frame_11, CLOCK_50, q_frame_11);
	 rom_frame_12 rf12(address_frame_12, CLOCK_50, q_frame_12);
	 rom_frame_13 rf13(address_frame_13, CLOCK_50, q_frame_13);
	 rom_frame_14 rf14(address_frame_14, CLOCK_50, q_frame_14);
	 rom_frame_15 rf15(address_frame_15, CLOCK_50, q_frame_15);
	 rom_frame_16 rf16(address_frame_16, CLOCK_50, q_frame_16);
	 

    
    domaze_logic DL(.iResetn(~KEY[0]), .iClock(CLOCK_50), .start(SW[9]), .start_two(SW[6]), .switch_up_down(SW[0]), .skip_to_hardest(SW[3:2]),
                    .mv_left(~KEY[3]), .mv_vert(~KEY[2]), .mv_right(~KEY[1]), .start_3(SW[5]),
                     .oX(x), .oY(y), .oColour(colour), .oPlot(writeEn), .oDone(done),
                     .hundreds(hundreds), .tens(tens), .ones(ones), .percent(LEDR), 
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
							.address_end(address_end), .q_end(q_end),
							
							.key_data(received_data),
							.key_en(received_data_en)
							
							);

    hex_decoder h2(hundreds, HEX2);
    hex_decoder h1(tens, HEX1);
    hex_decoder h0(ones, HEX0);

endmodule


module hex_decoder(c, display);
    input wire [3:0] c;
    output [6:0] display;

    assign display[0] = !((~c[0] | c[1] | c[2] | c[3]) & (c[0] | c[1] | ~c[2] | c[3]) & (~c[0] | ~c[1] | c[2] | ~c[3]) & (~c[0] | c[1] | ~c[2] | ~c[3]));
    assign display[1] = !((~c[0] | ~c[1] | c[2] | ~c[3]) & (c[0] | c[1] | ~c[2] | ~c[3]) & (c[0] | ~c[1] | ~c[2] | ~c[3]) & (~c[0] | ~c[1] | ~c[2] | ~c[3]) & (~c[0] | c[1] | ~c[2] | c[3]) & (c[0] | ~c[1] | ~c[2] | c[3]));
    assign display[2] = !((c[0] | ~c[1] | c[2] | c[3]) & (c[0] | c[1] | ~c[2] | ~c[3]) & (c[0] | ~c[1] | ~c[2] | ~c[3]) & (~c[0] | ~c[1] | ~c[2] | ~c[3]));
    assign display[3] = !((~c[0] | c[1] | c[2] | c[3]) & (c[0] | c[1] | ~c[2] | c[3]) & (~c[0] | ~c[1] | ~c[2] | c[3]) & (c[0] | ~c[1] | c[2] | ~c[3]) & (~c[0] | ~c[1] | ~c[2] | ~c[3]));
    assign display[4] = !((~c[0] | c[1] | c[2] | c[3]) & (~c[0] | ~c[1] | c[2] | c[3]) & (c[0] | c[1] | ~c[2] | c[3]) & (~c[0] | c[1] | ~c[2] | c[3]) & (~c[0] | ~c[1] | ~c[2] | c[3]) & (~c[0] | c[1] | c[2] | ~c[3]));
    assign display[5] = !((~c[0] | c[1] | c[2] | c[3]) & (c[0] | ~c[1] | c[2] | c[3]) & (~c[0] | ~c[1] | c[2] | c[3]) & (~c[0] | ~c[1] | ~c[2] | c[3]) & (~c[0] | c[1] | ~c[2] | ~c[3]));
    assign display[6] = !((c[0] | c[1] | c[2] | c[3]) & (~c[0] | c[1] | c[2] | c[3]) & (~c[0] | ~c[1] | ~c[2] | c[3]) & (c[0] | c[1] | ~c[2] | ~c[3]));

endmodule