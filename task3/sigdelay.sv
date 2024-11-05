module sigdelay #(
    parameter ADDRESS_WIDTH = 9,
              DATA_WIDTH = 8
)(
    input logic                     clk,
    input logic                     rst,
    input logic                     en,
    input logic                     wr,        

    input logic                     rd,        
    input logic [DATA_WIDTH-1:0]    mic_signal,
    input logic [ADDRESS_WIDTH-1:0] offset,
    output logic [DATA_WIDTH-1:0]   delayed_signal
);

    logic [ADDRESS_WIDTH-1:0] wr_addr, rd_addr;

    // 实例化写地址的计数器
    counter #(.WIDTH(ADDRESS_WIDTH)) write_counter (
        .clk(clk),
        .rst(rst),
        .en(1'b1),
        .incr(1'b1),
        .count(wr_addr)
    );

    assign rd_addr = wr_addr - offset;

    // 实例化双端口 RAM
    ram2ports #(.ADDRESS_WIDTH(ADDRESS_WIDTH), .DATA_WIDTH(DATA_WIDTH)) ram_inst (
        .clk(clk),
        .wr_en(wr),           
        .rd_en(rd),           
        .wr_addr(wr_addr),
        .rd_addr(rd_addr),
        .din(mic_signal),
        .dout(delayed_signal)
    );

endmodule
