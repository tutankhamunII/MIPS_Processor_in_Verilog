module Hazard(

	//MODULE INPUTS
	
		//CONTROL SIGNALS
		input	CLOCK,
		input 	RESET,
		input [4:0] Source1_ID, Source2_ID;
		input [4:0] WriteRegister_EXEMEM, WriteRegister_MEMWB;

		input MemRead_IDEXE;
		input WriteEnable_IDEXE;
		input WriteEnable_EXEMEM;
		wire forwardEN = SW[1];
		wire forward1fromexe, forward2fromexe, forward1frommem, forward2frommem;

	//MODULE OUTPUTS

		output 	STALL_IFID,
		output 	FLUSH_IFID,
	
		output 	STALL_IDEXE,
		output 	FLUSH_IDEXE,
	
		output 	STALL_EXEMEM,
		output 	FLUSH_EXEMEM,
	
		output 	STALL_MEMWB,
		output 	FLUSH_MEMWB;

);

	assign forward1fromexe = (Source1_ID == WriteRegister_EXEMEM) && (WriteEnable_EXEMEM) &| WriteRegister_EXEMEM;
	assign forward2fromexe = (Source2_ID == WriteRegister_EXEMEM) && (WriteEnable_EXEMEM) &| WriteRegister_EXEMEM;
	assign forward1frommem = (Source1_ID == WriteRegister_MEMWB) && (WriteEnable_MEMWB) &| WriteRegister_MEMWB;
	assign forward2frommem = (Source2_ID == WriteRegister_MEMWB) && (WriteEnable_MEMWB) &| WriteRegister_MEMWB;
	assign STALL_IFID = (forward1fromexe || forward2fromexe || forward1frommem || forward2frommem);






reg [4:0] MultiCycleRing;

assign FLUSH_MEMWB = 1'b0;
assign STALL_MEMWB = 1'b0;

assign FLUSH_EXEMEM = 1'b0;
assign STALL_EXEMEM = (FLUSH_MEMWB || STALL_MEMWB);

assign FLUSH_IDEXE = 1'b0;
assign STALL_IDEXE = (FLUSH_EXEMEM || STALL_EXEMEM);

assign FLUSH_IFID = !(MultiCycleRing[0]);
assign STALL_IFID = (FLUSH_IDEXE || STALL_IDEXE || FLUSH_IFID);

always @(posedge CLOCK or negedge RESET) begin

	if(!RESET) begin

		MultiCycleRing <= 5'b00001;

	end else if(CLOCK) begin
		temp

		$display("");
		$display("----- HAZARD UNIT -----");
		$display("Multicycle Ring: %b", MultiCycleRing);
		if (Opcode_IFID == 6'b000000) begin
			$display("Instruction: %b", Funcode_IFID);
		end else begin
			$display("Instruction: %b", Opcode_IFID);
		end

	
	end	

		MultiCycleRing <= {{MultiCycleRing[3:0],MultiCycleRing[4]}};


	end

end

endmodule


