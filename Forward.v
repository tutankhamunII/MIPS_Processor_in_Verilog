module Forward(

	//MODULE INPUTS
	input [4:0] ID_EX_RegRs,
	input [4:0] ID_EX_RegRt,
	input [4:0] EX_MEM_RegRd,
	input [4:0] MEM_WB_RegRd,
	input 		EX_MEM_RegWrite,
	input 		MEM_WB_RegWrite,

	//MODULE OUTPUTS
	output [1:0] ForwardA,
	output [1:0] ForwardB
);


 reg [1:0] ForwardA_tmp;
 reg [1:0] ForwardB_tmp;

	always @(ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd, EX_MEM_RegWrite, MEM_WB_RegWrite) begin
		ForwardA_tmp = 2'b00;
		ForwardB_tmp = 2'b00;
	
		if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rs)) begin
			ForwardA_tmp = 2'b10;
		end else if((MEM_WB_RegWrite == 1'b1) && (MEM_WB_Rd != 5'b00000) && (MEM_WB_Rd == ID_EX_Rs)) begin
			ForwardA_tmp = 2'b01;
		end
		
		if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rt)) begin
			ForwardB_tmp = 2'b10;
		end else if((MEM_WB_RegWrite == 1'b1) && (MEM_WB_Rd != 5'b00000) && (MEM_WB_Rd == ID_EX_Rt)) begin
			ForwardB_tmp = 2'b01;
		end
	end

	assign ForwardA = ForwardA_tmp;
	assign ForwardB = ForwardB_tmp;
endmodule
