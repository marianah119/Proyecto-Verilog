/*
#################################################################################################
#################################################################################################
                                Hernandez Mariana
                                LU: 114956
#################################################################################################
#################################################################################################                                
*/


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




// Tester cátedra
module tester(s, cout, Gij, Pij, x, y, cin);
    input [3:0]s;
    input cout, Gij, Pij;
    output [3:0]x;
    output [3:0]y;
    output cin;
    reg [3:0]x;
    reg [3:0]y;
    reg cin;
    integer i,j;

    initial
    begin
        $dumpfile("claa_1.vcd");
        $dumpvars;

        cin = 0;
        for(i = 0; i < 16; i = i + 1) begin
            for(j = 0; j < 16; j = j + 1) begin
                x = i;
                y = j;
                #10;
            end  
        end

        cin = 1; 
        for(i = 0; i < 16; i = i + 1) begin
            for(j = 0; j < 16; j = j + 1) begin
                x = i;
                y = j;
                #10;
            end  
        end 

        #10 $finish;
    end

endmodule

module testbench;
    wire [3:0]x; 
    wire [3:0]y; 
    wire [3:0]s;
    wire cin, cout, Gij, Pij;
    CLAA_1 claa(x, y, cin, s, cout, Gij, Pij);
    tester t(s, cout, Gij, Pij, x, y, cin);
endmodule