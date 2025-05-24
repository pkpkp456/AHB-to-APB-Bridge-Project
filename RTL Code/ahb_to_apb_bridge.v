module ahb_to_apb_bridge (
    input  wire        HCLK,
    input  wire        HRESETn,

    // AHB Inputs
    input  wire [31:0] HADDR,
    input  wire [1:0]  HTRANS,
    input  wire        HWRITE,
    input  wire [2:0]  HSIZE,
    input  wire        HSEL,
    input  wire        HREADY,
    input  wire [31:0] HWDATA,

    // AHB Outputs
    output reg  [31:0] HRDATA,
    output reg         HREADYOUT,
    output reg         HRESP,

    // APB Outputs
    output reg  [31:0] PADDR,
    output reg         PWRITE,
    output reg         PSEL,
    output reg         PENABLE,
    output reg  [31:0] PWDATA,

    // APB Inputs
    input  wire [31:0] PRDATA,
    input  wire        PREADY,
    input  wire        PSLVERR
);

    // FSM States
    parameter IDLE   = 2'b00;
    parameter SETUP  = 2'b01;
    parameter ACCESS = 2'b10;

    reg [1:0] state, next_state;

    // Internal registers
    reg [31:0] addr_reg;
    reg [31:0] wdata_reg;
    reg        write_reg;

    // FSM Sequential Logic
    always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn)
            state <= IDLE;
        else
            state <= next_state;
    end

    // FSM Combinational Logic
    always @(*) begin
        // Default outputs
        next_state = state;
        PSEL       = 1'b0;
        PENABLE    = 1'b0;
        PADDR      = addr_reg;
        PWRITE     = write_reg;
        PWDATA     = wdata_reg;
        HREADYOUT  = 1'b0;
        HRESP      = 1'b0;

        case (state)
            IDLE: begin
                HREADYOUT = 1'b1;
                if (HSEL && HREADY && HTRANS[1]) begin
                    next_state = SETUP;
                end
            end

            SETUP: begin
                PSEL       = 1'b1;
                PADDR      = addr_reg;
                PWRITE     = write_reg;
                PWDATA     = wdata_reg;
                next_state = ACCESS;
            end

            ACCESS: begin
                PSEL      = 1'b1;
                PENABLE   = 1'b1;
                HREADYOUT = PREADY;
                HRESP     = PSLVERR;
                if (PREADY) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Register AHB signals
    always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn) begin
            addr_reg  <= 32'b0;
            wdata_reg <= 32'b0;
            write_reg <= 1'b0;
            HRDATA    <= 32'b0;
        end else if (state == IDLE && HSEL && HREADY && HTRANS[1]) begin
            addr_reg  <= HADDR;
            wdata_reg <= HWDATA;
            write_reg <= HWRITE;
        end else if (state == ACCESS && !write_reg && PREADY) begin
            HRDATA <= PRDATA;
        end
    end

endmodule
