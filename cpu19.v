`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:59:48 11/28/2024 
// Design Name: 
// Module Name:    cpu19 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module cpu19(
    input clk,
    input rst,
    input [18:0] instruction,
    output  reg [18:0] result
    );
	 
	 integer i;
	 
	 reg [18:0] register [0:15];
	 reg [18:0] memory [0:524287];//2^19=524287 memory locations
	 reg [18:0] pc;
	 reg [18:0] stack[0:15];
	 reg [3:0] sp;
	 reg [18:0]encrypted_data;
	 reg [18:0]decrypted_data;
	 
	 wire [4:0]opcode;
	 wire [3:0] r1,r2,r3;
	 wire [13:0] immediate;
	 
	 assign opcode=instruction[18:14];
	 assign r1=instruction[13:10];
	 assign r2=instruction[9:6];
	 assign r3=instruction[5:2];
	 assign immediate=instruction[13:0];
	 
	 
	 always@(posedge clk or posedge rst)
	 begin
	 if(rst)
	   begin
	     pc<=0;
	     sp<=0;
	     result<=0;
	  
	     for(i=0;i<16;i=i+1)
		   begin
			  register[i]<=0;
			end
		end
		
	  else
	   begin
		  case(opcode)
		    //arithmatic operations
			 5'b00000: register[r1]<=register[r2]+register[r3];//ADD
			 5'b00001: register[r1]<=register[r2]-register[r3];//SUB
		    5'b00010: register[r1]<=register[r2]*register[r3];//MUL
			 5'b00011: register[r1]<=register[r2]/register[r3];//DIV
			 //increment and decrement
			 5'b00100: register[r1]<=register[r1]+1;//increament
			 5'b00101: register[r1]<=register[r1]-1;//decrement
			 //logical operation
			 5'b00110: register[r1]<=register[r2]&register[r3];//AND
			 5'b00111: register[r1]<=register[r2]|register[r3];//OR
			 5'b01000: register[r1]<=register[r2]^register[r3];//XOR
			 5'b01001: register[r1]<=~register[r2];//NOT
			 //control flow
			 5'b01010: pc<=immediate;//jump pc to some address
			 5'b01011: if(register[r1]==register[r2]) pc<=immediate;//BEQ
			 5'b01100: if(register[r1]!=register[r2]) pc<=immediate;//BNE
			 5'b01101: begin//CALL
			           stack[sp]<=pc+1;//save the incremented pc address as return address for pc to come back
						  sp<=sp-1;//decrement sp to new top
                    pc<=immediate;//jump to subroutine					  
			           end
			 5'b01110: begin//RETURN
			           sp=sp+1;//increment the sp now itself by using blocking assignment
						  pc<=stack[sp];//here incremented sp is used
			           end
			 //memory access
			 5'b01111: register[r1]<=memory[immediate];//load from memory into register
			 5'b10000: memory[immediate]<=register[r1];//store into memory from register
			 //specialised operation
			 5'b10001:begin
			           encrypted_data<=encrypt(register[r2]);//encrypt
						  register[r1]<=encrpted_data;
						  end
			 5'b10010:
			           begin
			           decrypted_data<=decrypt(register[r2]);//decrypt
						  register[r1]<=decrpted_data;
						  end
			 default: ;
			endcase
			 pc<=pc+1;
		 end
	end
	
	
	
		
	function [18:0] encrypt(input [18:0]in);
    begin
	   encrypt=in^19'b1010101010101010101;
    end
   endfunction	 
	 
	 function [18:0] decrypt(input [18:0]in);
    begin
	   decrypt=in^19'b1010101010101010101;
    end
	 endfunction
	 
	 
	 always@(posedge clk or posedge rst)
	  begin
	    if(rst)
		  begin
		  result<=0;
		  end
		 else
		  begin
		    result<=register[0];
		  end
	  end


endmodule
