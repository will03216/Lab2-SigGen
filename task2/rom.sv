module rom #(
    parameter  ADDRESS_WIDTH = 8,
               DATA_WIDTH = 8
)(
    input logic                     clk,
    input logic [ADDRESS_WIDTH-1:0] addr1,  // 第一个地址
    output logic [DATA_WIDTH-1:0]    dout1, // 第一个数据输出
    input logic [ADDRESS_WIDTH-1:0] addr2,  // 第二个地址
    output logic [DATA_WIDTH-1:0]    dout2  // 第二个数据输出
);

logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];  // ROM 存储器

initial begin
    $display("Loading the rom.");
    $readmemh("sinerom.mem", rom_array);  // 从文件加载正弦波数据
end

// 同步输出，时钟上升沿时，输出两个地址对应的 ROM 数据
always_ff @(posedge clk) begin
    dout1 <= rom_array[addr1];
    dout2 <= rom_array[addr2];
end

endmodule

