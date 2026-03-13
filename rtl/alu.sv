`include "opcode.vh"

module alu_control (
<<<<<<< HEAD
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
=======
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic [3:0] alu_op
);

    // ALU operation type
    typedef enum logic [3:0] {
        ALU_ADD,
        ALU_SUB,
        ALU_SLT,
        ALU_SLTU,
        ALU_AND,
        ALU_OR,
        ALU_XOR,
        ALU_SLL,
        ALU_SRL,
        ALU_SRA
    } alu_op_t;


    always_comb begin
        case (opcode)

            `OPC_ARI_RTYPE: begin
                case (funct3)

>>>>>>> 1d18d8b8dd9ff87e9f1a794033c6d1bb7d5f1628
                    `FNC_ADD_SUB: begin
                        if (funct7[5] == `FNC2_SUB)
                            alu_op = ALU_SUB;
                        else
                            alu_op = ALU_ADD;
                    end
<<<<<<< HEAD
                    `FNC_SLL:    alu_op = ALU_SLL;
                    `FNC_SLT:    alu_op = ALU_SLT;
                    `FNC_SLTU:   alu_op = ALU_SLTU;
                    `FNC_XOR:    alu_op = ALU_XOR;
                    `FNC_OR:     alu_op = ALU_OR;
                    `FNC_AND:    alu_op = ALU_AND;
=======

                    `FNC_SLL:     alu_op = ALU_SLL;
                    `FNC_SLT:     alu_op = ALU_SLT;
                    `FNC_SLTU:    alu_op = ALU_SLTU;
                    `FNC_XOR:     alu_op = ALU_XOR;
                    `FNC_OR:      alu_op = ALU_OR;
                    `FNC_AND:     alu_op = ALU_AND;

>>>>>>> 1d18d8b8dd9ff87e9f1a794033c6d1bb7d5f1628
                    `FNC_SRL_SRA: begin
                        if (funct7[5] == `FNC2_SRA)
                            alu_op = ALU_SRA;
                        else
                            alu_op = ALU_SRL;
                    end
<<<<<<< HEAD
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
=======

                    default: alu_op = ALU_ADD;

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
>>>>>>> 1d18d8b8dd9ff87e9f1a794033c6d1bb7d5f1628
                        if (funct7[5] == `FNC2_SRA)
                            alu_op = ALU_SRA;
                        else
                            alu_op = ALU_SRL;
                    end
<<<<<<< HEAD
                    default:      alu_op = ALU_ADD;
                endcase
            end

            `OPC_BRANCH: begin         
                alu_op = ALU_SUB;
            end

=======

                    default: alu_op = ALU_ADD;

                endcase
            end


            `OPC_BRANCH: begin
                alu_op = ALU_SUB;
            end


>>>>>>> 1d18d8b8dd9ff87e9f1a794033c6d1bb7d5f1628
            `OPC_LOAD,
            `OPC_STORE,
            `OPC_JAL,
            `OPC_JALR,
            `OPC_LUI,
<<<<<<< HEAD
            `OPC_AUIPC: begin           
                alu_op = ALU_ADD;
            end

            default: begin               
                alu_op = ALU_ADD;
            end
        endcase
    end

endmodule
=======
            `OPC_AUIPC: begin
                alu_op = ALU_ADD;
            end


            default: begin
                alu_op = ALU_ADD;
            end

        endcase
    end

endmodule

//Note : Manual asked for 2 controllers however we basically combine both at one .and its working alright ,have added sim pic on doc/ as well
//However if need 2 separate controllers , can separate in future THANKS !
>>>>>>> 1d18d8b8dd9ff87e9f1a794033c6d1bb7d5f1628
