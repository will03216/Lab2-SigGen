#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env){
    int i;
    int clk;
    int tick;

    Verilated::commandArgs(argc, argv);
    Vsinegen *top = new Vsinegen;

    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("sinegen.vcd");

    if (vbdOpen() != 1)
        return (-1);
    vbdHeader("Lab 2: Dual Sinusoids");

    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->incr = 5;

    for (i = 0; i < 1000000; i++) {
        

        for (tick = 0; tick < 2; tick++) {
            tfp->dump(2 * i + tick);
            top->clk = !top->clk;
            top->eval();
        }

        // 获取 vbdValue() 的值作为相位偏移
        int phase_offset = vbdValue();
        
        // 设置相位偏移
        top->phase_offset = phase_offset;
        
        // 显示两个正弦波
        vbdPlot(int(top->dout1), 0, 255);  // 显示第一个波形
        vbdPlot(int(top->dout2), 0, 255);  // 显示第二个波形
        
        vbdCycle(i);  // 每个周期更新

        // 检查仿真结束条件
        if ((Verilated::gotFinish()) || (vbdGetkey() == 'q'))
            exit(0);
    }

   

    vbdClose();   // 关闭 Vbuddy
    tfp->close(); // 关闭 VCD 文件
    exit(0);
}


