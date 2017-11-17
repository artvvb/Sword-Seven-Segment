`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2017 09:31:07 AM
// Design Name: 
// Module Name: top
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


module top (clk_p, clk_n, ss_dout, ss_clk, ss_en);
    parameter DBG = "FALSE";
    input  wire clk_p, clk_n;
    output wire ss_dout, ss_clk, ss_en;
    wire clk;
    clk_wiz_0 wiz (.clk_in1_p(clk_p), .clk_in1_n(clk_n), .clk_out1(clk));
    sseg #(DBG) uut (clk, 32'h01234567, ss_dout, ss_clk, ss_en);
endmodule
