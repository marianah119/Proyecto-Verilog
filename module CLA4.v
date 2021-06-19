module CLA4(
    input  [3:0] iG,
    input  [3:0] iP,
    input  iC,
    output oG,
    output oP,
    output [4:0] oC
);

    assign oC[0] = iC;
    assign oC[1] = iG[0] | (iP[0] & oC[0]);
    assign oC[2] = iG[1] | (iP[1] & iG[0]) | (iP[1] & iP[0] & oC[0]);
    assign oC[3] = iG[2] | (iP[2] & iG[1]) | (iP[2] & iP[1] & iG[0]) | (iP[2] & iP[1] & iP[0] & oC[0]);

    assign oG = iG[3] | (iP[3] & iG[2]) | (iP[3] & iP[2] & iG[1]) | (iP[3] & iP[2] & iP[1] & iG[0]);
    assign oP = iP[3] & iP[2] & iP[1] & iP[0];

    assign oC[4] = oG | (oP & oC[0]);

endmodule

/**
 * @brief 4位超前进位加法器
 */
module Adder4(
    input  [3:0] iA,
    input  [3:0] iB,
    input  iC,
    output [3:0] oS,
    output oG,
    output oP,
    output oC
);
    wire [3:0] G = iA & iB;     // 进位产生信号
    wire [3:0] P = iA | iB;     // 进位传递信号
    wire [3:0] C;

    CLA4 cla(.iG(G), .iP(P), .iC(iC), .oG(oG), .oP(oP), .oC({oC, C}));

    assign oS = iA ^ iB ^ C;

endmodule