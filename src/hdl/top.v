`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent
// Engineer: Arthur Brown
// 
// Create Date: 11/17/2017 09:31:07 AM
// Module Name: top
// Project Name: Sword Seven Segment
// Target Devices: Sword Board
// Tool Versions: Vivado 2016.4
// Description: wraps simple seven segment controller for the seven segment circuitry of the sword board
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top (clk_p, clk_n, ss_sdo, ss_clk, ss_en);
    parameter DBG = "FALSE"; // set to TRUE to use in simulator, significantly reduces wait periods
    input wire clk_p, clk_n; // 200MHz differential input clock
    output wire ss_sdo, ss_clk, ss_en; // seven segment display control pins
    wire clk; // 200MHz single ended clock
    clk_wiz_0 get_clk (
        .clk_in1_p(clk_p),
        .clk_in1_n(clk_n),
        .clk_out1(clk)
    );
    sseg #(
        .DBG(DBG)
    ) uut (
        .clk(clk),
        .din(32'h01234567), // constantly display code 01234567
        .ss_sdo(ss_sdo),
        .ss_clk(ss_clk),
        .ss_en(ss_en)
    );
endmodule
