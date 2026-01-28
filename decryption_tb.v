`timescale 1ns / 1ps

module decryption_tb;
	reg clk;
   reg rst;
   reg start;
   reg [63:0] key;
   reg [63:0] ciphertext;
	wire [63:0] decryptedtext;
	wire DECRYPT_DONE;
	 
 
	 
	 
	 
// decrypt module instantiation 
	decryption uut (
	`ifdef USE_POWER_PINS
	.vdda1(vdda1),	// User area 1 3.3V power
	.vdda2(vdda2),	// User area 2 3.3V power
	.vssa1(vssa1),	// User area 1 analog ground
	.vssa2(vssa2),	// User area 2 analog ground
	.vccd1(vccd1),	// User area 1 1.8V power
	.vccd2(vccd2),	// User area 2 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
	.vssd2(vssd2),	// User area 2 digital ground
	`endif
	 .clk(clk),
    .rst(rst),
    .start(start),	//1 for encrypt, 0 for decrypt	
    .key(key),
    .ciphertext(ciphertext),
	 .decryptedtext(decryptedtext),
	 .DECRYPT_DONE(DECRYPT_DONE)
	 );
	
	
	
	
	always #10 clk = ~clk; // 50 MHz clock

		initial begin
			$dumpfile("decryption_tb.vcd");
			$dumpvars(0, decryption_tb);
		end
		
    
	 initial begin 	 
	// Initialize signals
    	clk = 0;
    	rst = 1;
    	start = 0;
    	ciphertext = 64'h0;
    	key = 64'h0;
		#200 rst = 0;
		
		
		//test 
		ciphertext = 64'hb26ac5634255852a;
		key = 64'h0f1571c9ac4198de;	
		start = 1; #1000;
		start = 0;

   	 
    	// Finish simulation
    	#2000 $finish;

	 
	 end 
	 
	 initial begin
    	$monitor("Time=%0t clk=%b rst=%b start=%b ciphertext=%h",
             	$time, clk, rst, start, key, ciphertext,decryptedtext,DECRYPT_DONE);
	end

endmodule 