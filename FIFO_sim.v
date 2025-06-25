`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 09:56:23 PM
// Design Name: 
// Module Name: fifo_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_sim(

    );
    
reg clk_t;
reg rst_n_t;
reg wr_en_t;
reg rd_en_t;
reg [31:0] data_in_t;
wire [31:0] data_out_t;
wire full_t;
wire empty_t;
wire almost_full_t;
wire almost_empty_t; 
integer i;   
    
fifo UUT(
     .clk(clk_t),
     .rst_n(rst_n_t), 
     .wr_en(wr_en_t),
     .rd_en(rd_en_t),
     .data_in(data_in_t),
     .data_out(data_out_t),
     .full(full_t),
     .empty(empty_t),
     .almost_full(almost_full_t),
     .almost_empty(almost_empty_t)
 );
    
    always #5 clk_t = ~clk_t;
    
    //initialization
    initial begin
    clk_t = 0;
    rst_n_t = 0;
    wr_en_t = 0;
    rd_en_t = 0;
    data_in_t = 32'd0;
    #10 rst_n_t = 1;
   
   //write to fifo
   for(i = 0; i<32; i = i + 1) begin
    @(posedge clk_t);
    wr_en_t = 1;
    data_in_t = i + 1;
   end
   @(posedge clk_t);
       wr_en_t = 0;
       
   //read fifo
   for(i = 0; i < 32; i = i + 1) begin
     @(posedge clk_t);
     rd_en_t = 1;
   end
   @(posedge clk_t);
     rd_en_t = 0;
     
     //for almost full/empty
   #10;
   @(posedge clk_t);
   wr_en_t = 1;
   for(i = 0; i < 30; i = i + 1) begin
       @(posedge clk_t);
       data_in_t = i + 1;
    end
    wr_en_t = 0;
  end
endmodule
