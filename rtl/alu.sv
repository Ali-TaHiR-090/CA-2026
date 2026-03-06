// alu_control.v
// ALU control unit for RISC-V processor
// Generates 4-bit ALU operation code based on instruction fields

`include "opcode.vh"

module alu_control (
    input wire [6:0] opcode,   // 7-bit opcode
    input wire [2:0] funct3,   // funct3 field
    input wire [6:0] funct7,   // funct7 field (bits 31:25)
    output reg [3:0] alu_op     // ALU operation code
);

    // ALU operation codes (from table)
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

    always_comb 
    begin
        case (opcode)
            `OPC_ARI_RTYPE: begin      // R-type arithmetic
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
                    default:     alu_op = ALU_ADD;   // should not happen
                endcase
            end

            `OPC_ARI_ITYPE: begin      // I-type arithmetic (immediate)
                case (funct3)
                    `FNC_ADD_SUB: alu_op = ALU_ADD;   // addi
                    `FNC_SLT:     alu_op = ALU_SLT;   // slti
                    `FNC_SLTU:    alu_op = ALU_SLTU;  // sltiu
                    `FNC_XOR:     alu_op = ALU_XOR;   // xori
                    `FNC_OR:      alu_op = ALU_OR;    // ori
                    `FNC_AND:     alu_op = ALU_AND;   // andi
                    `FNC_SLL:     alu_op = ALU_SLL;   // slli
                    `FNC_SRL_SRA: begin                // srli / srai
                        if (funct7[5] == `FNC2_SRA)
                            alu_op = ALU_SRA;
                        else
                            alu_op = ALU_SRL;
                    end
                    default:      alu_op = ALU_ADD;
                endcase
            end

            `OPC_BRANCH: begin         // Branch instructions (compare using subtraction)
                alu_op = ALU_SUB;
            end

            `OPC_LOAD,
            `OPC_STORE,
            `OPC_JAL,
            `OPC_JALR,
            `OPC_LUI,
            `OPC_AUIPC: begin           // Address calculation, PC+4, or pass immediate
                alu_op = ALU_ADD;
            end

            default: begin               // Unsupported opcode (e.g., CSR)
                alu_op = ALU_ADD;
            end
        endcase
    end

endmodule