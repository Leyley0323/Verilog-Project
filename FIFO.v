`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 08:54:00 PM
// Design Name: 
// Module Name: fifo
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


module fifo(
    input clk,
    input rst_n,
    input wr_en,
    input rd_en,
    input [31:0] data_in,
    output reg [31:0] data_out,
    output reg full,
    output reg empty,
    output reg almost_full,
    output reg almost_empty
    );
    
    //defining parameters
    parameter DEPTH = 32; //fifo stores up to 32 words
    parameter WIDTH = 32; // width of entry
    parameter ALMOST_FULL = DEPTH - 2;
    parameter ALMOST_EMPTY = 2;
    
    reg [31:0] mem [0:31];
    reg [5:0] count;
    reg [5:0] write_ptr;                     
    reg [5:0] read_ptr;  
    
    //write function                  
    always@(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
        begin
         write_ptr <= 0;
         end
         else if(wr_en && !full)
         begin
            mem[write_ptr] <= data_in;
            write_ptr <= (write_ptr + 1) % DEPTH;
            end
     end
     
     //read function
     always@(posedge clk or negedge rst_n) 
        begin
           if(!rst_n)
           begin
             read_ptr <= 0;
             data_out <= 0;
           end
           else if(rd_en && !empty)
           begin
               data_out <= mem[read_ptr];
               read_ptr <= (read_ptr + 1) % DEPTH;
           end
    end
    
    //counter
    always@(posedge clk or negedge rst_n) 
    begin
      if(!rst_n)
      begin
          count <= 0;
      end
      else begin
        if(wr_en && !full && !(rd_en && !empty)) begin
            count <= count +1;
        end
        else if (rd_en && !empty && (wr_en && !full)) begin
            count <= count -1;
        end
      end
    end
  
     //status signals
       always @(posedge clk or negedge rst_n)
        begin
          if (!rst_n) 
          begin
              full <= 0;
              empty <= 1;
              almost_full <= 0;
              almost_empty <= 1;
          end else begin
              full <= (count == DEPTH);                  
              empty <= (count == 0);                    
              almost_full <= (count >= ALMOST_FULL);  
              almost_empty <= (count <= ALMOST_EMPTY); 
      end
    end
endmodule
