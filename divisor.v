module divisor(x,y, A,MQ, clk, load)

 always @(posedge clk) //reseteo los vaalores de salida
  begin
    if(load == 1)   
       begin
           A=8'b00000000;
           B=7;
           Bcomp=-y;
           MQ= -x;
           q=1;
           cont=4'b0000;

       end

    else 
      begin
         if(cont[3]==0)
           begin
               if(cont[2]==0 && cont[1]==0 && cont[0]==0) // primer desplazamiento
                  begin
                     A= A << 1;
                     A[0]= MQ[7];
                     MQ= MQ << 3;

                  end
               if (q==1)
                  begin
                     A= A + Bcomp;
                  end
                else 
                  begin
                    A= A+ B;
                  end
               if( A[7] ==1) 
                  begin
                   q=0;
                  end 
               else  
                  begin
                   q=1;
                  end
               if( cont[2] !=1 && cont[1] !=1 && cont[0] !=1) 
                  begin
                      A= A << 1;
                      A[0]=MQ[7];
                      MQ= MQ << 1;
                      MQ[0]=Q;
                  end
           end
      end
  end
endmodule



/* 
########## TESTER Y TESTBENCH ##########

*/

module tester(clk, x, y, load);
    output [7:0]x;
    output [7:0]y;
    output clk, load;
    
    reg [7:0]x;
    reg [7:0]y;
    reg load;
    reg clk;

    initial
    begin

        $dumpfile("divisor.vcd");
        $dumpvars;
        
        clk=0;

        x = 27; y = 4; load = 1;
        #2 load = 0;
        
        #21 x= 32; y=8; load = 1;
        #2 load = 0;
        
        #21 x= 13; y = 3; load = 1;
        #2 load = 0;
        
        #21 x= 50; y = 10; load = 1;
        #2 load = 0;
        
        #21 x= 20; y = 11; load = 1;
        #2 load = 0;
        
        #21 x= 18; y = 9; load = 1;
        #2 load = 0;
        
        #20 $finish;
    end

    // Generar la señal de reloj periódica
    always
    begin
        #1 clk=!clk;
    end
endmodule


module testbench;
    wire [7:0]x; 
    wire [7:0]y; 
    wire [15:0]AMQ;
    wire clk, load;
    
	divisor divisor1(x, y, AMQ[15:8], AMQ[7:0], clk, load);
    tester t(clk, x, y, load);
endmodule