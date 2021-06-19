
/*
#################################################################################################
#################################################################################################
                                Hernandez Mariana
                                LU: 114956
#################################################################################################
#################################################################################################                                
*/




module sumador(x,y,s)

endmodule



module ripple_Carry_adder(i0,in1,out,cout);
   input[3:0] in0;
   input[3:0]  ini;
   output[3:0] out;
   output cout;

   wire c1,c2, c3;
   full_adder fa0(in0[0],in[0],0,out[0],c1)

endmodule
module CLAA_1( x,y,Cin,s,Cout,Gij, Pij);
    input [3:0] x;
    input [3:0] y;
    input Cin;
    output Cout;
    output  Gij,Pij;
    output [3:0] s;

    wire [3:0] G,P,C;
 
    assign G = x & y; //Generado
    assign P = x ^ y; //Propagado
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) |   (P[2] & P[1] & P[0] & C[0]);
    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) |(P[3] & P[2] & P[1] & P[0] & C[0]);
    assign s = P ^ C;
    
    assign Pij = P[3] & P[2] & P[1] & P[0];
    assign Gij = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
endmodule


module multiplicador(x,y, A, MQ, clk, load)

