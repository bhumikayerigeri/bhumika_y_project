`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:25:39 11/28/2024 
// Design Name: 
// Module Name:    cpu_tb 
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
module cpu_tb();
reg clk,rst;
reg [18:0]instruction;
wire [18:0] result;

cpu19 c1(clk,rst,instruction,result);
	 
initial
 begin
  clk=0;
  rst=1;
  instruction=0;
  
  @(negedge clk) rst=0;
  
  //ADD
  @(negedge clk)
  instruction={5'b00000,4'd0,4'd1,4'd2};//r0=r1+r2
  register[1]=19'd2;
  register[2]=19'd12;
  
  //SUB
  @(negedge clk)
  instruction={5'b00001,4'd3,4'd4,4'd5};//r3=r4-r5
  register[4]=19'd10;
  register[5]=19'd2;
 
  
  //MUL
  @(negedge clk)
  instruction={5'b00010,4'd6,4'd7,4'd8};//r6=r7*r8
  register[7]=19'd3;
  register[8]=19'd8;
 
  
  //DIV
  @(negedge clk)
  instruction={5'b00011,4'd9,4'd10,4'd11};//r9=r10/r11
  register[10]=19'd10;
  register[11]=19'd2;
  
  //INC
  @(negedge clk)
  instruction={5'b00100,4'd12,4'd0,4'd0};//r12=r12+1
  register[12]=19'd10;
 
  
  //DEC
  @(negedge clk)
  instruction={5'b00101,4'd13,4'd0,4'd0};//r13=r13+1
  register[13]=19'd20;
  
  
   //AND
	@(negedge clk)
  instruction={5'b00110,4'd14,4'd15,4'd1};//r14=r15&r1
  register[15]=19'b10;
  register[1]=19'b100;

  
    //OR
	 @(negedge clk)
  instruction={5'b00111,4'd14,4'd15,4'd1};//r14=r15|r1
  register[15]=19'b10;
  register[1]=19'b100;
  
  
   //XOR
	@(negedge clk)
  instruction={5'b01000,4'd14,4'd15,4'd1};//r14=r15^r1
  register[15]=19'b10;
  register[1]=19'b100;
  
  
   //NOT
	@(negedge clk)
  instruction={5'b01001,4'd14,4'd0,4'd0};//r14=~r14
  register[14]=19'b100;
 
  
  //JUMP
  @(negedge clk)
  instruction={5'b01010,14'd18};//jump to 18
 
  
  //BEQ
  @(negedge clk)
  instruction={5'b01011,4'd1,4'd2};
  register[1]=19'd10;
  register[2]=19'd10;
 
  
  //BEQ
  @(negedge clk)
  instruction={5'b01100,4'd1,4'd2};
  register[1]=19'd11;
  register[2]=19'd10;
 
 
  //CALL
  @(negedge clk)
  instruction={5'b01101,14'd50};
 
  
  //CALL
  @(negedge clk)
  instruction={5'b01110,14'd0};
 
  
  //LD
  @(negedge clk)
  instruction={5'b01111,4'd2,14'd62};
 
  
   //ST
	@(negedge clk)
  instruction={5'b01111,4'd2,14'd62};
  
  
  //ENCRYPT
  @(negedge clk)
  instruction={5'b10000,4'd2,4'd3,4'd0};
 
  
  //DECRYPT
  @(negedge clk)
  instruction={5'b010001,4'd2,4'd3,4'd0};

  
  
  #100 $finish;
  
 end


initial
begin
clk<=0;
 forever #5 clk<=!clk;
end

endmodule
