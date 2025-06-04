`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: traffic_light
// Description: Realistic 4-way traffic light controller
//////////////////////////////////////////////////////////////////////////////////

module traffic_light(
    input clk,
    input rst,
    output reg [2:0] rd1, rd1c, rd2, rd2c, rd3, rd3c, rd4, rd4c,
    output reg [3:0] count
);

    reg [3:0] p_state;

    // State encoding
    parameter S1 = 4'd1;  // RD1 (→ ↑), RD1c (↓) Green
    parameter S2 = 4'd2;  // RD1 (→ ↑), RD1c (↓) Yellow
    parameter S3 = 4'd3;  // RD3 (↓), RD3c (↑) Green
    parameter S4 = 4'd4;  // RD3 (↓), RD3c (↑) Yellow
    parameter S5 = 4'd5;  // RD2 (→), RD2c (←) Green
    parameter S6 = 4'd6;  // RD2 (→), RD2c (←) Yellow
    parameter S7 = 4'd7;  // RD4 (←), RD4c (→) Green
    parameter S8 = 4'd8;  // RD4 (←), RD4c (→) Yellow

    // Timing parameters
    parameter GREEN_TIME = 4'd7;
    parameter YELLOW_TIME = 4'd2;

    // Light encoding: Green = 3'b001, Yellow = 3'b010, Red = 3'b100
    parameter RED = 3'b100, YELLOW = 3'b010, GREEN = 3'b001;

    // State and timing logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            p_state <= S1;
            count <= 4'd0;
        end else begin
            case (p_state)
                S1: 
                if (count == GREEN_TIME)
                    begin 
                        p_state <= S2; 
                        count <= 0; 
                    end 
                else 
                count <= count + 1;
                
                
                S2: 
                if (count == YELLOW_TIME) 
                    begin 
                        p_state <= S3; 
                        count <= 0; 
                    end 
                else 
                count <= count + 1;
                
                
                S3: 
                if (count == GREEN_TIME) 
                    begin 
                        p_state <= S4; 
                        count <= 0; 
                    end 
                else 
                count <= count + 1;
                S4: 
                if (count == YELLOW_TIME) 
                    begin 
                        p_state <= S5; 
                        count <= 0; 
                    end 
                else 
                count <= count + 1;
                
                
                S5: 
                if (count == GREEN_TIME)
                    begin 
                        p_state <= S6; 
                        count <= 0; 
                    end 
                else 
                count <= count + 1;
                
                
                S6: 
                if (count == YELLOW_TIME) 
                    begin 
                        p_state <= S7; 
                        count <= 0; 
                    end 
                else 
                count <= count + 1;
                
                
                S7: 
                if (count == GREEN_TIME) 
                    begin 
                        p_state <= S8; 
                        count <= 0; 
                    end 
                else 
                count <= count + 1;
                
                
                S8: 
                if (count == YELLOW_TIME) 
                    begin 
                        p_state <= S1;
                        count <= 0; 
                    end 
                else 
                count <= count + 1;
                
            endcase
        end
    end

    // Light control logic
    always @(*) begin
        // Default all red
        rd1 = RED; rd1c = RED;
        rd2 = RED; rd2c = RED;
        rd3 = RED; rd3c = RED;
        rd4 = RED; rd4c = RED;

        case (p_state)
            S1: 
                begin 
                    rd1 = GREEN; 
                    rd1c = GREEN; 
                end
            
            S2: 
                begin 
                    rd1 = YELLOW; 
                    rd1c = YELLOW; 
                end
            
            S3: 
                begin 
                    rd3 = GREEN; 
                    rd3c = GREEN; 
                end
            
            S4:     
                begin 
                    rd3 = YELLOW; 
                    rd3c = YELLOW; 
                end
            
            S5: 
                begin 
                    rd2 = GREEN; 
                    rd2c = GREEN; 
                end
            
            S6: 
                begin 
                    rd2 = YELLOW; 
                    rd2c = YELLOW; 
                end
                
            S7: 
                begin 
                    rd4 = GREEN; 
                    rd4c = GREEN; 
                end
                
            S8: 
                begin 
                    rd4 = YELLOW; 
                    rd4c = YELLOW; 
                end
        endcase
    end

endmodule
