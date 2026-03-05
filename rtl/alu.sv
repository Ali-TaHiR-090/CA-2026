`include "opcode.vh"

module alu_control (
    input wire [6:0] opcode,   
    input wire [2:0] funct3,   
    input wire [6:0] funct7,   
    output reg [3:0] alu_op     
);

    
    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_SLT  = 4'b0010;
    localparam ALU_SLTU = 4'b0011;
    localparam ALU_AND  = 4'b0100;
    localparam ALU_OR   = 4'b0101;
    localparam ALU_XOR  = 4'b0110;
    localparam ALU_SLL  = 4'b0111;
    localparam ALU_SRL  = 4'b1000;
    localparam ALU_SRA  = 4'b1001;

    always @(*) begin
        case (opcode)
            `OPC_ARI_RTYPE: begin      
                case (funct3)
                    `FNC_ADD_SUB: begin
                        if (funct7[5] == `FNC2_SUB)
                            alu_op = ALU_SUB;
                        else
                            alu_op = ALU_ADD;
                    end
                    `FNC_SLL:    alu_op = ALU_SLL;
                    `FNC_SLT:    alu_op = ALU_SLT;
                    `FNC_SLTU:   alu_op = ALU_SLTU;
                    `FNC_XOR:    alu_op = ALU_XOR;
                    `FNC_OR:     alu_op = ALU_OR;
                    `FNC_AND:    alu_op = ALU_AND;
                    `FNC_SRL_SRA: begin
                        if (funct7[5] == `FNC2_SRA)
                            alu_op = ALU_SRA;
                        else
                            alu_op = ALU_SRL;
                    end
                    default:     alu_op = ALU_ADD;   
                endcase
            end

            `OPC_ARI_ITYPE: begin      
                case (funct3)
                    `FNC_ADD_SUB: alu_op = ALU_ADD;   
                    `FNC_SLT:     alu_op = ALU_SLT;   
                    `FNC_SLTU:    alu_op = ALU_SLTU;  
                    `FNC_XOR:     alu_op = ALU_XOR;   
                    `FNC_OR:      alu_op = ALU_OR;    
                    `FNC_AND:     alu_op = ALU_AND;   
                    `FNC_SLL:     alu_op = ALU_SLL;   
                    `FNC_SRL_SRA: begin                
                        if (funct7[5] == `FNC2_SRA)
                            alu_op = ALU_SRA;
                        else
                            alu_op = ALU_SRL;
                    end
                    default:      alu_op = ALU_ADD;
                endcase
            end

            `OPC_BRANCH: begin         
                alu_op = ALU_SUB;
            end

            `OPC_LOAD,
            `OPC_STORE,
            `OPC_JAL,
            `OPC_JALR,
            `OPC_LUI,
            `OPC_AUIPC: begin           
                alu_op = ALU_ADD;
            end

            default: begin               
                alu_op = ALU_ADD;
            end
        endcase
    end

endmodule