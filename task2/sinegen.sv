module sinegen #(
    parameter A_WIDTH = 8,
    parameter D_WIDTH = 8
)(
    input logic clk,
    input logic rst,
    input logic en,
    input logic [D_WIDTH-1:0] incr,
    input logic [A_WIDTH-1:0] phase_offset, // 添加相位偏移输入
    output logic [D_WIDTH-1:0] dout1, // 输出第一个正弦波数据
    output logic [D_WIDTH-1:0] dout2  // 输出第二个相位偏移后的正弦波数据
);

    logic [A_WIDTH-1:0] address1; // 第一个地址
    logic [A_WIDTH-1:0] address2; // 第二个相位偏移后的地址

    // 实例化计数器模块 addrCounter
    counter addrCounter (
        .clk (clk),
        .rst (rst),
        .en (en),
        .incr (incr),
        .count (address1)
    );

    // 第二个地址通过相位偏移计算得到
    assign address2 = address1 + phase_offset;

    // 实例化ROM模块 sineRom，双端口
    rom sineRom (
        .clk (clk),
        .addr1 (address1),    // 第一个地址
        .dout1 (dout1),       // 第一个输出
        .addr2 (address2),    // 第二个地址
        .dout2 (dout2)        // 第二个输出
    );

endmodule

