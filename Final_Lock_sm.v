module Final_Lock_sm(clock, reset, program, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, correctLed, incorrectLed);

	input clock;
	input reset;
	input program;
	input b0, b1, b2, b3, b4, b5, b6, b7, b8, b9;
	output reg correctLed, incorrectLed;
	
	reg [4:0] state, next_state;
	reg [9:0] num1, num2, num3, num4;
	
	parameter S0 = 5'b00000,
				 C1 = 5'b00001,
				 C2 = 5'b00010,
				 C3 = 5'b00011,
				 CORRECT = 5'b00100,
				 X1 = 5'b00101,
				 X2 = 5'b00110,
				 X3 = 5'b00111,
				 INCORRECT = 5'b01000,
				 BC1 = 5'b01001,
				 BC2 = 5'b01010,
				 BC3 = 5'b01011,
				 BC4 = 5'b01100,
				 BX1 = 5'b01101,
				 BX2 = 5'b01110,
				 BX3 = 5'b01111,
				 BX4 = 5'b10000,
				 //Programming States
				 P1 = 5'b10001,
				 P2 = 5'b10010,
				 P3 = 5'b10011,
				 P4 = 5'b10100,
				 BP1 = 5'b10101,
				 BP2 = 5'b10110,
				 BP3 = 5'b10111,
				 BP4 = 5'b11000,
				 BP5 = 5'b11001;

	//Set the default code
	initial
	begin
		num1[9:0] = 10'b1000000000;
		num2[9:0] = 10'b0100000000;
		num3[9:0] = 10'b0010000000;
		num4[9:0] = 10'b0001000000;
	end
	
	//Asyncronous Reset
	always @ (posedge clock or posedge reset)
	begin
		if (reset == 1)
			state <= S0;
		else
			state <= next_state;
	end
	
	//State Control Function
	always @ (posedge clock)
	begin
		case(state)
			S0:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						begin
							if({b0,b1,b2,b3,b4,b5,b6,b7,b8,b9} == num1)
								next_state <= BC1;
							else
								next_state <= BX1;
						end
					else
						next_state <= S0;
				end
			C1:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						begin
							if({b0,b1,b2,b3,b4,b5,b6,b7,b8,b9} == num2)
								next_state <= BC2;
							else
								next_state <= BX2;
						end
					else
						next_state <= C1;
				end
			C2:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						begin
							if({b0,b1,b2,b3,b4,b5,b6,b7,b8,b9} == num3)
								next_state <= BC3;
							else
								next_state <= BX3;
						end
					else
						next_state <= C2;
				end
			C3:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						begin
							if({b0,b1,b2,b3,b4,b5,b6,b7,b8,b9} == num4)
								next_state <= BC4;
							else
								next_state <= BX4;
						end
					else
						next_state <= C3;
				end
			CORRECT: //If the program program button is pressed, go to programming mode
				begin
					if (program == 1)
						next_state <= BP1;
					else
						next_state <= CORRECT;
				end
			X1:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BX2;
					else
						next_state <= X1;
				end
			X2:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BX3;
					else
						next_state <= X2;
				end
			X3:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BX4;
					else
						next_state <= X3;
				end
			INCORRECT: ;
			BC1:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BC1;
					else
						next_state <= C1;
				end
			BC2:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BC2;
					else
						next_state <= C2;
				end
			BC3:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BC3;
					else
						next_state <= C3;
				end
			BC4:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BC4;
					else
						next_state <= CORRECT;
				end
			BX1:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BX1;
					else
						next_state <= X1;
				end
			BX2:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BX2;
					else
						next_state <= X2;
				end
			BX3:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BX3;
					else
						next_state <= X3;
				end
			BX4:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BX4;
					else
						next_state <= INCORRECT;
				end
			P1:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						begin
							num1 <= {b0,b1,b2,b3,b4,b5,b6,b7,b8,b9};
							next_state <= BP2;
						end
					else
						next_state <= P1;
				end
			P2:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						begin
							num2 <= {b0,b1,b2,b3,b4,b5,b6,b7,b8,b9};
							next_state <= BP3;
						end
					else
						next_state <= P2;
				end
			P3:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						begin
							num3 <= {b0,b1,b2,b3,b4,b5,b6,b7,b8,b9};
							next_state <= BP4;
						end
					else
						next_state <= P3;
				end
			P4:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						begin
							num4 <= {b0,b1,b2,b3,b4,b5,b6,b7,b8,b9};
							next_state <= BP5;
						end
					else
						next_state <= P4;
				end
			BP1:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BP1;
					else
						next_state <= P1;
				end
			BP2:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BP2;
					else
						next_state <= P2;
				end
			BP3:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BP3;
					else
						next_state <= P3;
				end
			BP4:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BP4;
					else
						next_state <= P4;
				end
			BP5:
				begin
					if ((b0|b1|b2|b3|b4|b5|b6|b7|b8|b9) == 1)
						next_state <= BP5;
					else
						next_state <= S0;
				end
			default: next_state <= S0;
		endcase
	end
	
	//State Output Function
	always @ (posedge clock)
	begin
		case(state)
			CORRECT: 
				begin
					correctLed <= 1;
					incorrectLed <= 0;
				end
			INCORRECT: 
				begin
					correctLed <= 0;
					incorrectLed <= 1;
				end
			default:
				begin
					correctLed <= 0;
					incorrectLed <= 0;
				end
		endcase
	end
endmodule