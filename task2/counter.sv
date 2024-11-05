module counter #(
    parameter WIDTH = 8
)(
    // interface signals
    input logic         clk,    // clock
    input logic         rst,    // reset
    input logic [WIDTH-1:0] incr, // increment value
    input logic         en,     // counter enable
    output logic [WIDTH-1:0] count  // count output
);

always_ff @ (posedge clk, posedge rst)
    if (rst) 
        count <= {WIDTH{1'b0}};  // 重置计数器
    else if (en) 
        count <= count + incr;   // 增量由 incr 决定
endmodule

