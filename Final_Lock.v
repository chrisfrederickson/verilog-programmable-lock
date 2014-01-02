module Final_Lock(CLOCK_50, SoftReset, Program, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, GREEN, RED);

	input CLOCK_50;
	input SoftReset, Program;
	input B0, B1, B2, B3, B4, B5, B6, B7, B8, B9;
	output GREEN, RED;
	
	wire clock;
	
	Final_Lock_sm State_Machine(clock, SoftReset, Program, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, GREEN, RED);
	Clock_Divider Clock_Divider_1(CLOCK_50, clock);
endmodule