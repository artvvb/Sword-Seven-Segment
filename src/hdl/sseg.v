`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2017 04:10:17 PM
// Design Name: 
// Module Name: sseg
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


module sseg(clk, din, ss_dout, ss_clk, ss_en);
    parameter DBG="FALSE";
    input clk;
    input [31:0] din;
    output wire ss_dout, ss_clk, ss_en;
    localparam COUNT_MAX = (DBG == "FALSE") ? 199999 : 19;
    localparam BIT_PERIOD = (DBG == "FALSE") ? 4 : 4;
    localparam BIT_PERIOD_HALF= (DBG == "FALSE") ? 2 : 2;
    reg [31:0] count = 0;
    reg [5:0] bit_count;
    reg idle = 1;
    assign ss_en = idle;
    always@(posedge clk)
        if (idle == 1) begin
            if (count == COUNT_MAX) begin
                bit_count <= 0;
                idle <= 0;
                count <= 0;
            end else
                count <= count + 1;
        end else begin
            if (count == BIT_PERIOD-1) begin
                count <= 0;
                if (bit_count == 6'h3F)
                    idle <= 1;
                else
                    bit_count <= bit_count + 1;
            end else begin
                count <= count + 1;
            end
        end
    assign ss_clk = (idle == 1 || count >= BIT_PERIOD_HALF) ? 1 : 0;
    reg [3:0] nibble;
    always@(*)
        nibble = 4'hF & (din >> {bit_count[5:3], 2'b0});
    reg [7:0] seg;
    always@(*) begin
        case (nibble)
        4'h0: seg = 8'b00111111;
        4'h1: seg = 8'b00000110;
        4'h2: seg = 8'b01011011;
        4'h3: seg = 8'b01001111;
        4'h4: seg = 8'b01100110;
        4'h5: seg = 8'b01101101;
        4'h6: seg = 8'b01111101;
        4'h7: seg = 8'b00000111;
        4'h8: seg = 8'b01111111;
        4'h9: seg = 8'b01101111;
        4'hA: seg = 8'b01110111;
        4'hb: seg = 8'b01111100;
        4'hC: seg = 8'b00111001;
        4'hd: seg = 8'b01011110;
        4'hE: seg = 8'b01111001;
        4'hF: seg = 8'b01110001;
        endcase
    end
    assign ss_dout = seg[~bit_count[2:0]];
endmodule
