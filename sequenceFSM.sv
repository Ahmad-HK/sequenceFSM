module sequenceFSM(
		input logic clk,
		input logic reset,
		input logic stream,
		output logic detected
);

	typedef enum logic [2:0] { A, B, C, D, E, F } State;

	State currentState;
	State nextState;

	always_ff @(posedge clk)
	begin
		if(reset)
			currentState <= A;
		else
			currentState <= nextState;
	end

	always_comb
	begin
		case(currentState)

		A : if(stream)	nextState = B;
			else		nextState = A;
		B : if(stream)	nextState = B;
			else		nextState = C;
		C : if(stream)	nextState = D;
			else		nextState = A;
		D : if(stream)	nextState = E;
			else		nextState = C;
		E : if(stream)	nextState = B;
			else		nextState = F;
		F : if(stream)	nextState = D;
			else		nextState = A;

		endcase
	end

	assign detected = (currentState == F);




endmodule

