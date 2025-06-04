`timescale 1ns / 1ps

module traffic_light_tb;
    reg clk, rst;
    wire [2:0] rd1, rd1c, rd2, rd2c, rd3, rd3c, rd4, rd4c;
    wire [3:0] count;

    // Instantiate the DUT (Device Under Test)
    traffic_light uut (
        .clk(clk),
        .rst(rst),
        .rd1(rd1),
        .rd1c(rd1c),
        .rd2(rd2),
        .rd2c(rd2c),
        .rd3(rd3),
        .rd3c(rd3c),
        .rd4(rd4),
        .rd4c(rd4c),
        .count(count)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;

        // Apply reset
        #10;
        rst = 0;

        // Run simulation for enough time to cover all states
        #500;

        // Finish simulation
        $finish;
    end

    // Optional: display the outputs
    initial begin
        $monitor("Time: %0dns | State Count: %d | RD1: %b RD1C: %b | RD2: %b RD2C: %b | RD3: %b RD3C: %b | RD4: %b RD4C: %b",
                  $time, count, rd1, rd1c, rd2, rd2c, rd3, rd3c, rd4, rd4c);
    end
endmodule
