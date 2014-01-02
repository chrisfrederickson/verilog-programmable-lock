module Clock_Divider(clock_in, clock_out);
	input clock_in;
	output reg clock_out;
	reg [14:0] count;
	
	always @ (posedge clock_in)
	begin
		count <= count + 1;
		if (count >= 25000)
			begin
				count <= 0;
				clock_out <= ~clock_out;
			end
	end
endmodule