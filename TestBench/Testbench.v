`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.05.2025 11:01:59
// Design Name: 
// Module Name: Testbench
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
`timescale 1ns / 1ps

module tb_ahb_to_apb_bridge;

    reg         HCLK = 0;
    reg         HRESETn;
    reg  [31:0] HADDR;
    reg  [1:0]  HTRANS;
    reg         HWRITE;
    reg  [2:0]  HSIZE;
    reg         HSEL;
    reg         HREADY;
    reg  [31:0] HWDATA;
    wire [31:0] HRDATA;
    wire        HREADYOUT;
    wire        HRESP;

    wire [31:0] PADDR;
    wire        PWRITE;
    wire        PSEL;
    wire        PENABLE;
    wire [31:0] PWDATA;
    reg  [31:0] PRDATA = 32'hA5A5A5A5;
    reg         PREADY = 1'b1;
    reg         PSLVERR = 1'b0;

    // Clock generation
    always #5 HCLK = ~HCLK;  // 100MHz

    // Instantiate DUT
    ahb_to_apb_bridge dut (
        .HCLK(HCLK), .HRESETn(HRESETn),
        .HADDR(HADDR), .HTRANS(HTRANS), .HWRITE(HWRITE), .HSIZE(HSIZE),
        .HSEL(HSEL), .HREADY(HREADY), .HWDATA(HWDATA),
        .HRDATA(HRDATA), .HREADYOUT(HREADYOUT), .HRESP(HRESP),
        .PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE),
        .PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .PSLVERR(PSLVERR)
    );

    initial begin
        // Initial values
        HRESETn = 0;
        HADDR   = 0;
        HTRANS  = 2'b00;
        HWRITE  = 0;
        HSIZE   = 3'b000;
        HSEL    = 0;
        HREADY  = 1;
        HWDATA  = 0;

        // Reset
        #20;
        HRESETn = 1;

        // Write Transaction
        @(posedge HCLK);
        HSEL    = 1;
        HTRANS  = 2'b10; // NONSEQ
        HWRITE  = 1;
        HADDR   = 32'h0000_1000;
        HWDATA  = 32'hDEAD_BEEF;

        @(posedge HCLK);
        HSEL    = 0;
        HTRANS  = 2'b00;

        #40;

        // Read Transaction
        @(posedge HCLK);
        HSEL    = 1;
        HTRANS  = 2'b10; // NONSEQ
        HWRITE  = 0;
        HADDR   = 32'h0000_1000;

        @(posedge HCLK);
        HSEL    = 0;
        HTRANS  = 2'b00;

        #40;

        $finish;
    end

endmodule
