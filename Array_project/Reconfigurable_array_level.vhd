library ieee;
use ieee.std_logic_1164.ALL;

entity Reconfigurable_Array_level is
  port (
    bitstream : in std_logic_vector(425 downto 0);
    clk : in std_logic;
    out0, out1, out2, out3, out4, out5, out6, out7, 
    out8, out9, out10, out11, out12, out13, out14, out15, 
    out16, out17, out18, out19, out20, out21, out22, out23, 
    out24, out25, out26, out27, out28, out29, out30, out31 : out std_logic_vector(31 downto 0)
  );
end Reconfigurable_Array_level;

architecture Reconfigurable_Array_level of Reconfigurable_Array_level is

  subtype data is std_logic_vector(31 downto 0);
  subtype operation is std_logic_vector(2 downto 0);
  subtype selector2 is std_logic_vector(1 downto 0);
  subtype selector5 is std_logic_vector(4 downto 0);
  subtype sel_stream is std_logic_vector(29 downto 0);
  subtype op_stream is std_logic_vector(8 downto 0);
  subtype line_sel_stream is std_logic_vector(63 downto 0);

  Component Register_Bank
    port(
  		in0, in1, in2, in3, in4, in5, in6, in7, 
      in8, in9, in10, in11, in12, in13, in14, in15, 
      in16, in17, in18, in19, in20, in21, in22, in23, 
      in24, in25, in26, in27, in28, in29, in30, in31 : data;
      clk: in std_logic;
      out0, out1, out2, out3, out4, out5, out6, out7, 
      out8, out9, out10, out11, out12, out13, out14, out15, 
      out16, out17, out18, out19, out20, out21, out22, out23, 
      out24, out25, out26, out27, out28, out29, out30, out31 : out data
  	);
  end Component;

  Component ALUs_line
    port(
    in0, in1, in2, in3, in4, in5, in6, in7, 
    in8, in9, in10, in11, in12, in13, in14, in15, 
    in16, in17, in18, in19, in20, in21, in22, in23, 
    in24, in25, in26, in27, in28, in29, in30, in31 : in data;
    sel_bitstream : in sel_stream;
    operation_bitstream : in op_stream;
    output_1, output_2, output_3 : out data
    );
  end component;

  Component Multiplier
    port(
      A, B : in  data;
      result: out data
    );
  end Component;

  Component Multiplexer_4
    port(
  		A,B,C,D	: in data;
  		sel	: in selector2;
  		result	: out data
  	);
  end Component;

  Component Multiplexer_32
    port(
          in0, in1, in2, in3, in4, in5, in6, in7, 
          in8, in9, in10, in11, in12, in13, in14, in15, 
          in16, in17, in18, in19, in20, in21, in22, in23, 
          in24, in25, in26, in27, in28, in29, in30, in31	: in data;
      sel	: in selector5;
      result	: out data
    );
  end Component;
  
  Component Multiplexer is
    port(
  		A,B	: in data;
  		sel	: in std_logic;
  		result	: out data
    );
  end Component;

  Component ram_access is
    port(
      Clk : in std_logic;
      address : in data;
      we : in std_logic;
      data_i : in data;
      data_o : out data
    );
  end Component;
  
 -- input muxes for the ALUs
  signal sel_stream_1 : sel_stream := bitstream(29 downto 0);
  signal sel_stream_2 : sel_stream := bitstream(59 downto 30);
  signal sel_stream_3 : sel_stream := bitstream(89 downto 60);

  --operations

  signal op_stream_1 : op_stream := bitstream(98 downto 90);
  signal op_stream_2 : op_stream := bitstream(107 downto 99);
  signal op_stream_3 : op_stream := bitstream(116 downto 108);
  
  -- first line output mux signalssignal line_1_mux_sel_0 : selector2 := bitstream(117 downto 116);
  signal line_1_mux_sel_stream : line_sel_stream := bitstream(180 downto 117);

  --first line of output signals
  signal output_1_1 : data;
  signal output_1_2 : data;
  signal output_1_3 : data;

  --first line of operations

  -- second line output mux signals
  signal line_2_mux_sel_stream : line_sel_stream := bitstream(244 downto 181);
  

  --second line of output signals
  signal output_2_1 : data;
  signal output_2_2 : data;
  signal output_2_3 : data;

  --second line of operations

  --------------------THIRD LINE--------------------------
  
  -- third line output mux signals
  signal line_3_mux_sel_stream : line_sel_stream := bitstream(308 downto 245);


  signal final_mux_sel_stream : line_sel_stream := bitstream(372 downto 309);
  

  signal output_mux_0 : data;
signal output_mux_1 : data;
signal output_mux_2 : data;
signal output_mux_3 : data;
signal output_mux_4 : data;
signal output_mux_5 : data;
signal output_mux_6 : data;
signal output_mux_7 : data;
signal output_mux_8 : data;
signal output_mux_9 : data;
signal output_mux_10 : data;
signal output_mux_11 : data;
signal output_mux_12 : data;
signal output_mux_13 : data;
signal output_mux_14 : data;
signal output_mux_15 : data;
signal output_mux_16 : data;
signal output_mux_17 : data;
signal output_mux_18 : data;
signal output_mux_19 : data;
signal output_mux_20 : data;
signal output_mux_21 : data;
signal output_mux_22 : data;
signal output_mux_23 : data;
signal output_mux_24 : data;
signal output_mux_25 : data;
signal output_mux_26 : data;
signal output_mux_27 : data;
signal output_mux_28 : data;
signal output_mux_29 : data;
signal output_mux_30 : data;
signal output_mux_31 : data;


  --third line of output signals
  signal output_3_1 : data;
  signal output_3_2 : data;
  signal output_3_3 : data;


  --------------------MULTIPLIER DATA--------------------------
  

  --Multiplier input muxes
  signal sel_mult_A : selector5 := bitstream(377 downto 373);
  signal sel_mult_B : selector5 := bitstream(382 downto 378);
  
  signal mult_in_A : data;
  signal mult_in_B : data;

  -- output of multiplier
  signal mult_output : data;

  -------------------MEMORY UNIT DATA---------------------------
  signal address :  selector5 := bitstream(387 downto 383);
  signal position : data := bitstream(419 downto 388)
  signal write_enabled :  std_logic := bitstream(420);
  signal memory_out : data;

  signal sel_memory :  selector5 := bitstream(425 downto 421);
  signal memory_mux_out :  data;

  --------------------REGISTER BANK--------------------------

  --inputs of registers
signal Register_0_input_1 : data := "00000000000000000000000000000001";
signal Register_1_input_1 : data := "00000000000000000000000000000001";
signal Register_2_input_1 : data := "00000000000000000000000000000001";
signal Register_3_input_1 : data := "00000000000000000000000000000001";
signal Register_4_input_1 : data := "00000000000000000000000000000001";
signal Register_5_input_1 : data := "00000000000000000000000000000001";
signal Register_6_input_1 : data := "00000000000000000000000000000001";
signal Register_7_input_1 : data := "00000000000000000000000000000001";
signal Register_8_input_1 : data := "00000000000000000000000000000001";
signal Register_9_input_1 : data := "00000000000000000000000000000001";
signal Register_10_input_1 : data := "00000000000000000000000000000001";
signal Register_11_input_1 : data := "00000000000000000000000000000001";
signal Register_12_input_1 : data := "00000000000000000000000000000001";
signal Register_13_input_1 : data := "00000000000000000000000000000001";
signal Register_14_input_1 : data := "00000000000000000000000000000001";
signal Register_15_input_1 : data := "00000000000000000000000000000001";
signal Register_16_input_1 : data := "00000000000000000000000000000001";
signal Register_17_input_1 : data := "00000000000000000000000000000001";
signal Register_18_input_1 : data := "00000000000000000000000000000001";
signal Register_19_input_1 : data := "00000000000000000000000000000001";
signal Register_20_input_1 : data := "00000000000000000000000000000001";
signal Register_21_input_1 : data := "00000000000000000000000000000001";
signal Register_22_input_1 : data := "00000000000000000000000000000001";
signal Register_23_input_1 : data := "00000000000000000000000000000001";
signal Register_24_input_1 : data := "00000000000000000000000000000001";
signal Register_25_input_1 : data := "00000000000000000000000000000001";
signal Register_26_input_1 : data := "00000000000000000000000000000001";
signal Register_27_input_1 : data := "00000000000000000000000000000001";
signal Register_28_input_1 : data := "00000000000000000000000000000001";
signal Register_29_input_1 : data := "00000000000000000000000000000001";
signal Register_30_input_1 : data := "00000000000000000000000000000001";
signal Register_31_input_1 : data := "00000000000000000000000000000001";

signal Register_0_input_2 : data;
signal Register_1_input_2 : data;
signal Register_2_input_2 : data;
signal Register_3_input_2 : data;
signal Register_4_input_2 : data;
signal Register_5_input_2 : data;
signal Register_6_input_2 : data;
signal Register_7_input_2 : data;
signal Register_8_input_2 : data;
signal Register_9_input_2 : data;
signal Register_10_input_2 : data;
signal Register_11_input_2 : data;
signal Register_12_input_2 : data;
signal Register_13_input_2 : data;
signal Register_14_input_2 : data;
signal Register_15_input_2 : data;
signal Register_16_input_2 : data;
signal Register_17_input_2 : data;
signal Register_18_input_2 : data;
signal Register_19_input_2 : data;
signal Register_20_input_2 : data;
signal Register_21_input_2 : data;
signal Register_22_input_2 : data;
signal Register_23_input_2 : data;
signal Register_24_input_2 : data;
signal Register_25_input_2 : data;
signal Register_26_input_2 : data;
signal Register_27_input_2 : data;
signal Register_28_input_2 : data;
signal Register_29_input_2 : data;
signal Register_30_input_2 : data;
signal Register_31_input_2 : data;

signal Register_0_input_3 : data;
signal Register_1_input_3 : data;
signal Register_2_input_3 : data;
signal Register_3_input_3 : data;
signal Register_4_input_3 : data;
signal Register_5_input_3 : data;
signal Register_6_input_3 : data;
signal Register_7_input_3 : data;
signal Register_8_input_3 : data;
signal Register_9_input_3 : data;
signal Register_10_input_3 : data;
signal Register_11_input_3 : data;
signal Register_12_input_3 : data;
signal Register_13_input_3 : data;
signal Register_14_input_3 : data;
signal Register_15_input_3 : data;
signal Register_16_input_3 : data;
signal Register_17_input_3 : data;
signal Register_18_input_3 : data;
signal Register_19_input_3 : data;
signal Register_20_input_3 : data;
signal Register_21_input_3 : data;
signal Register_22_input_3 : data;
signal Register_23_input_3 : data;
signal Register_24_input_3 : data;
signal Register_25_input_3 : data;
signal Register_26_input_3 : data;
signal Register_27_input_3 : data;
signal Register_28_input_3 : data;
signal Register_29_input_3 : data;
signal Register_30_input_3 : data;
signal Register_31_input_3 : data;

signal Register_final_input_0 : data;
signal Register_final_input_1 : data;
signal Register_final_input_2 : data;
signal Register_final_input_3 : data;
signal Register_final_input_4 : data;
signal Register_final_input_5 : data;
signal Register_final_input_6 : data;
signal Register_final_input_7 : data;
signal Register_final_input_8 : data;
signal Register_final_input_9 : data;
signal Register_final_input_10 : data;
signal Register_final_input_11 : data;
signal Register_final_input_12 : data;
signal Register_final_input_13 : data;
signal Register_final_input_14 : data;
signal Register_final_input_15 : data;
signal Register_final_input_16 : data;
signal Register_final_input_17 : data;
signal Register_final_input_18 : data;
signal Register_final_input_19 : data;
signal Register_final_input_20 : data;
signal Register_final_input_21 : data;
signal Register_final_input_22 : data;
signal Register_final_input_23 : data;
signal Register_final_input_24 : data;
signal Register_final_input_25 : data;
signal Register_final_input_26 : data;
signal Register_final_input_27 : data;
signal Register_final_input_28 : data;
signal Register_final_input_29 : data;
signal Register_final_input_30 : data;
signal Register_final_input_31 : data;
  
  --OUTPUTS of registers
signal Register_0_output : data;
signal Register_1_output : data;
signal Register_2_output : data;
signal Register_3_output : data;
signal Register_4_output : data;
signal Register_5_output : data;
signal Register_6_output : data;
signal Register_7_output : data;
signal Register_8_output : data;
signal Register_9_output : data;
signal Register_10_output : data;
signal Register_11_output : data;
signal Register_12_output : data;
signal Register_13_output : data;
signal Register_14_output : data;
signal Register_15_output : data;
signal Register_16_output : data;
signal Register_17_output : data;
signal Register_18_output : data;
signal Register_19_output : data;
signal Register_20_output : data;
signal Register_21_output : data;
signal Register_22_output : data;
signal Register_23_output : data;
signal Register_24_output : data;
signal Register_25_output : data;
signal Register_26_output : data;
signal Register_27_output : data;
signal Register_28_output : data;
signal Register_29_output : data;
signal Register_30_output : data;
signal Register_31_output : data;
begin
  --instantiate multiplier
  Mult_mux_A : Multiplexer_32
  port map (in0 => Register_0_input_1,
            in1 => Register_1_input_1,
            in2 => Register_2_input_1,
            in3 => Register_3_input_1,
            in4 => Register_4_input_1,
            in5 => Register_5_input_1,
            in6 => Register_6_input_1,
            in7 => Register_7_input_1,
            in8 => Register_8_input_1,
            in9 => Register_9_input_1,
            in10 => Register_10_input_1,
            in11 => Register_11_input_1,
            in12 => Register_12_input_1,
            in13 => Register_13_input_1,
            in14 => Register_14_input_1,
            in15 => Register_15_input_1,
            in16 => Register_16_input_1,
            in17 => Register_17_input_1,
            in18 => Register_18_input_1,
            in19 => Register_19_input_1,
            in20 => Register_20_input_1,
            in21 => Register_21_input_1,
            in22 => Register_22_input_1,
            in23 => Register_23_input_1,
            in24 => Register_24_input_1,
            in25 => Register_25_input_1,
            in26 => Register_26_input_1,
            in27 => Register_27_input_1,
            in28 => Register_28_input_1,
            in29 => Register_29_input_1,
            in30 => Register_30_input_1,
            in31 => Register_31_input_1,
            sel => sel_mult_A,
            result => mult_in_A);

  Mult_mux_B : Multiplexer_32
  port map (in0 => Register_0_input_1,
            in1 => Register_1_input_1,
            in2 => Register_2_input_1,
            in3 => Register_3_input_1,
            in4 => Register_4_input_1,
            in5 => Register_5_input_1,
            in6 => Register_6_input_1,
            in7 => Register_7_input_1,
            in8 => Register_8_input_1,
            in9 => Register_9_input_1,
            in10 => Register_10_input_1,
            in11 => Register_11_input_1,
            in12 => Register_12_input_1,
            in13 => Register_13_input_1,
            in14 => Register_14_input_1,
            in15 => Register_15_input_1,
            in16 => Register_16_input_1,
            in17 => Register_17_input_1,
            in18 => Register_18_input_1,
            in19 => Register_19_input_1,
            in20 => Register_20_input_1,
            in21 => Register_21_input_1,
            in22 => Register_22_input_1,
            in23 => Register_23_input_1,
            in24 => Register_24_input_1,
            in25 => Register_25_input_1,
            in26 => Register_26_input_1,
            in27 => Register_27_input_1,
            in28 => Register_28_input_1,
            in29 => Register_29_input_1,
            in30 => Register_30_input_1,
            in31 => Register_31_input_1,
            sel => sel_mult_B,
            result => mult_in_B);

  Mult : Multiplier
    Port Map (A => mult_in_A,
              B => mult_in_B,
              result => mult_output
              );

  --instantiate memory access unit

  RAM_mux : Multiplexer_32
  port map (in0 => Register_0_input_1,
            in1 => Register_1_input_1,
            in2 => Register_2_input_1,
            in3 => Register_3_input_1,
            in4 => Register_4_input_1,
            in5 => Register_5_input_1,
            in6 => Register_6_input_1,
            in7 => Register_7_input_1,
            in8 => Register_8_input_1,
            in9 => Register_9_input_1,
            in10 => Register_10_input_1,
            in11 => Register_11_input_1,
            in12 => Register_12_input_1,
            in13 => Register_13_input_1,
            in14 => Register_14_input_1,
            in15 => Register_15_input_1,
            in16 => Register_16_input_1,
            in17 => Register_17_input_1,
            in18 => Register_18_input_1,
            in19 => Register_19_input_1,
            in20 => Register_20_input_1,
            in21 => Register_21_input_1,
            in22 => Register_22_input_1,
            in23 => Register_23_input_1,
            in24 => Register_24_input_1,
            in25 => Register_25_input_1,
            in26 => Register_26_input_1,
            in27 => Register_27_input_1,
            in28 => Register_28_input_1,
            in29 => Register_29_input_1,
            in30 => Register_30_input_1,
            in31 => Register_31_input_1,
            sel => sel_memory,
            result => memory_mux_out);
  
    RAM : ram_access
    Port Map(Clk => clk,
            address =>address,
            we => write_enabled,
            data_i => memory_mux_out,
            data_o => memory_out

    );

  --------------------FIRST LINE--------------------------

  -- instantiate first line of ALUs
  line_1 : ALUs_line
    Port Map (in0 => Register_0_input_1,
              in1 => Register_1_input_1,
              in2 => Register_2_input_1,
              in3 => Register_3_input_1,
              in4 => Register_4_input_1,
              in5 => Register_5_input_1,
              in6 => Register_6_input_1,
              in7 => Register_7_input_1,
              in8 => Register_8_input_1,
              in9 => Register_9_input_1,
              in10 => Register_10_input_1,
              in11 => Register_11_input_1,
              in12 => Register_12_input_1,
              in13 => Register_13_input_1,
              in14 => Register_14_input_1,
              in15 => Register_15_input_1,
              in16 => Register_16_input_1,
              in17 => Register_17_input_1,
              in18 => Register_18_input_1,
              in19 => Register_19_input_1,
              in20 => Register_20_input_1,
              in21 => Register_21_input_1,
              in22 => Register_22_input_1,
              in23 => Register_23_input_1,
              in24 => Register_24_input_1,
              in25 => Register_25_input_1,
              in26 => Register_26_input_1,
              in27 => Register_27_input_1,
              in28 => Register_28_input_1,
              in29 => Register_29_input_1,
              in30 => Register_30_input_1,
              in31 => Register_31_input_1,
              sel_bitstream => sel_stream_1,
              operation_bitstream => op_stream_1,
              output_1 => output_1_1,
              output_2 => output_1_2,
              output_3 => output_1_3 );

  --instantiate first line multiplexers

  line_1_mux_0: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_0_input_1,
            sel => line_1_mux_sel_stream(1 downto 0),
            result => Register_0_input_2);
            
line_1_mux_1: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_1_input_1,
            sel => line_1_mux_sel_stream(3 downto 2),
            result => Register_1_input_2);
            
line_1_mux_2: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_2_input_1,
            sel => line_1_mux_sel_stream(5 downto 4),
            result => Register_2_input_2);
            
line_1_mux_3: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_3_input_1,
            sel => line_1_mux_sel_stream(7 downto 6),
            result => Register_3_input_2);
            
line_1_mux_4: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_4_input_1,
            sel => line_1_mux_sel_stream(9 downto 8),
            result => Register_4_input_2);
            
line_1_mux_5: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_5_input_1,
            sel => line_1_mux_sel_stream(11 downto 10),
            result => Register_5_input_2);
            
line_1_mux_6: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_6_input_1,
            sel => line_1_mux_sel_stream(13 downto 12),
            result => Register_6_input_2);
            
line_1_mux_7: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_7_input_1,
            sel => line_1_mux_sel_stream(15 downto 14),
            result => Register_7_input_2);
            
line_1_mux_8: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_8_input_1,
            sel => line_1_mux_sel_stream(17 downto 16),
            result => Register_8_input_2);
            
line_1_mux_9: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_9_input_1,
            sel => line_1_mux_sel_stream(19 downto 18),
            result => Register_9_input_2);
            
line_1_mux_10: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_10_input_1,
            sel => line_1_mux_sel_stream(21 downto 20),
            result => Register_10_input_2);
            
line_1_mux_11: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_11_input_1,
            sel => line_1_mux_sel_stream(23 downto 22),
            result => Register_11_input_2);
            
line_1_mux_12: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_12_input_1,
            sel => line_1_mux_sel_stream(25 downto 24),
            result => Register_12_input_2);
            
line_1_mux_13: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_13_input_1,
            sel => line_1_mux_sel_stream(27 downto 26),
            result => Register_13_input_2);
            
line_1_mux_14: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_14_input_1,
            sel => line_1_mux_sel_stream(29 downto 28),
            result => Register_14_input_2);
            
line_1_mux_15: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_15_input_1,
            sel => line_1_mux_sel_stream(31 downto 30),
            result => Register_15_input_2);
            
line_1_mux_16: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_16_input_1,
            sel => line_1_mux_sel_stream(33 downto 32),
            result => Register_16_input_2);
            
line_1_mux_17: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_17_input_1,
            sel => line_1_mux_sel_stream(35 downto 34),
            result => Register_17_input_2);
            
line_1_mux_18: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_18_input_1,
            sel => line_1_mux_sel_stream(37 downto 36),
            result => Register_18_input_2);
            
line_1_mux_19: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_19_input_1,
            sel => line_1_mux_sel_stream(39 downto 38),
            result => Register_19_input_2);
            
line_1_mux_20: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_20_input_1,
            sel => line_1_mux_sel_stream(41 downto 40),
            result => Register_20_input_2);
            
line_1_mux_21: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_21_input_1,
            sel => line_1_mux_sel_stream(43 downto 42),
            result => Register_21_input_2);
            
line_1_mux_22: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_22_input_1,
            sel => line_1_mux_sel_stream(45 downto 44),
            result => Register_22_input_2);
            
line_1_mux_23: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_23_input_1,
            sel => line_1_mux_sel_stream(47 downto 46),
            result => Register_23_input_2);
            
line_1_mux_24: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_24_input_1,
            sel => line_1_mux_sel_stream(49 downto 48),
            result => Register_24_input_2);
            
line_1_mux_25: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_25_input_1,
            sel => line_1_mux_sel_stream(51 downto 50),
            result => Register_25_input_2);
            
line_1_mux_26: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_26_input_1,
            sel => line_1_mux_sel_stream(53 downto 52),
            result => Register_26_input_2);
            
line_1_mux_27: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_27_input_1,
            sel => line_1_mux_sel_stream(55 downto 54),
            result => Register_27_input_2);
            
line_1_mux_28: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_28_input_1,
            sel => line_1_mux_sel_stream(57 downto 56),
            result => Register_28_input_2);
            
line_1_mux_29: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_29_input_1,
            sel => line_1_mux_sel_stream(59 downto 58),
            result => Register_29_input_2);
            
line_1_mux_30: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_30_input_1,
            sel => line_1_mux_sel_stream(61 downto 60),
            result => Register_30_input_2);
            
line_1_mux_31: Multiplexer_4
  Port Map (A => output_1_1,
            B => output_1_2,
            C => output_1_3,
            D => Register_31_input_1,
            sel => line_1_mux_sel_stream(63 downto 62),
            result => Register_31_input_2);
            

                        


  --------------------SECOND LINE--------------------------

  --instantiate second line of ALUs
  line_2 : ALUs_line
  Port Map (in0 => Register_0_input_2,
            in1 => Register_1_input_2,
            in2 => Register_2_input_2,
            in3 => Register_3_input_2,
            in4 => Register_4_input_2,
            in5 => Register_5_input_2,
            in6 => Register_6_input_2,
            in7 => Register_7_input_2,
            in8 => Register_8_input_2,
            in9 => Register_9_input_2,
            in10 => Register_10_input_2,
            in11 => Register_11_input_2,
            in12 => Register_12_input_2,
            in13 => Register_13_input_2,
            in14 => Register_14_input_2,
            in15 => Register_15_input_2,
            in16 => Register_16_input_2,
            in17 => Register_17_input_2,
            in18 => Register_18_input_2,
            in19 => Register_19_input_2,
            in20 => Register_20_input_2,
            in21 => Register_21_input_2,
            in22 => Register_22_input_2,
            in23 => Register_23_input_2,
            in24 => Register_24_input_2,
            in25 => Register_25_input_2,
            in26 => Register_26_input_2,
            in27 => Register_27_input_2,
            in28 => Register_28_input_2,
            in29 => Register_29_input_2,
            in30 => Register_30_input_2,
            in31 => Register_31_input_2,
            sel_bitstream => sel_stream_2,
            operation_bitstream => op_stream_2,
            output_1 => output_2_1,
            output_2 => output_2_2,
            output_3 => output_2_3 );

  --instantiate second line multiplexer

  line_2_mux_0: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_0_input_2,
              sel => line_2_mux_sel_stream(1 downto 0),
              result => Register_0_input_3);
              
line_2_mux_1: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_1_input_2,
              sel => line_2_mux_sel_stream(3 downto 2),
              result => Register_1_input_3);
              
line_2_mux_2: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_2_input_2,
              sel => line_2_mux_sel_stream(5 downto 4),
              result => Register_2_input_3);
              
line_2_mux_3: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_3_input_2,
              sel => line_2_mux_sel_stream(7 downto 6),
              result => Register_3_input_3);
              
line_2_mux_4: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_4_input_2,
              sel => line_2_mux_sel_stream(9 downto 8),
              result => Register_4_input_3);
              
line_2_mux_5: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_5_input_2,
              sel => line_2_mux_sel_stream(11 downto 10),
              result => Register_5_input_3);
              
line_2_mux_6: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_6_input_2,
              sel => line_2_mux_sel_stream(13 downto 12),
              result => Register_6_input_3);
              
line_2_mux_7: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_7_input_2,
              sel => line_2_mux_sel_stream(15 downto 14),
              result => Register_7_input_3);
              
line_2_mux_8: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_8_input_2,
              sel => line_2_mux_sel_stream(17 downto 16),
              result => Register_8_input_3);
              
line_2_mux_9: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_9_input_2,
              sel => line_2_mux_sel_stream(19 downto 18),
              result => Register_9_input_3);
              
line_2_mux_10: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_10_input_2,
              sel => line_2_mux_sel_stream(21 downto 20),
              result => Register_10_input_3);
              
line_2_mux_11: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_11_input_2,
              sel => line_2_mux_sel_stream(23 downto 22),
              result => Register_11_input_3);
              
line_2_mux_12: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_12_input_2,
              sel => line_2_mux_sel_stream(25 downto 24),
              result => Register_12_input_3);
              
line_2_mux_13: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_13_input_2,
              sel => line_2_mux_sel_stream(27 downto 26),
              result => Register_13_input_3);
              
line_2_mux_14: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_14_input_2,
              sel => line_2_mux_sel_stream(29 downto 28),
              result => Register_14_input_3);
              
line_2_mux_15: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_15_input_2,
              sel => line_2_mux_sel_stream(31 downto 30),
              result => Register_15_input_3);
              
line_2_mux_16: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_16_input_2,
              sel => line_2_mux_sel_stream(33 downto 32),
              result => Register_16_input_3);
              
line_2_mux_17: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_17_input_2,
              sel => line_2_mux_sel_stream(35 downto 34),
              result => Register_17_input_3);
              
line_2_mux_18: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_18_input_2,
              sel => line_2_mux_sel_stream(37 downto 36),
              result => Register_18_input_3);
              
line_2_mux_19: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_19_input_2,
              sel => line_2_mux_sel_stream(39 downto 38),
              result => Register_19_input_3);
              
line_2_mux_20: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_20_input_2,
              sel => line_2_mux_sel_stream(41 downto 40),
              result => Register_20_input_3);
              
line_2_mux_21: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_21_input_2,
              sel => line_2_mux_sel_stream(43 downto 42),
              result => Register_21_input_3);
              
line_2_mux_22: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_22_input_2,
              sel => line_2_mux_sel_stream(45 downto 44),
              result => Register_22_input_3);
              
line_2_mux_23: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_23_input_2,
              sel => line_2_mux_sel_stream(47 downto 46),
              result => Register_23_input_3);
              
line_2_mux_24: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_24_input_2,
              sel => line_2_mux_sel_stream(49 downto 48),
              result => Register_24_input_3);
              
line_2_mux_25: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_25_input_2,
              sel => line_2_mux_sel_stream(51 downto 50),
              result => Register_25_input_3);
              
line_2_mux_26: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_26_input_2,
              sel => line_2_mux_sel_stream(53 downto 52),
              result => Register_26_input_3);
              
line_2_mux_27: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_27_input_2,
              sel => line_2_mux_sel_stream(55 downto 54),
              result => Register_27_input_3);
              
line_2_mux_28: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_28_input_2,
              sel => line_2_mux_sel_stream(57 downto 56),
              result => Register_28_input_3);
              
line_2_mux_29: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_29_input_2,
              sel => line_2_mux_sel_stream(59 downto 58),
              result => Register_29_input_3);
              
line_2_mux_30: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_30_input_2,
              sel => line_2_mux_sel_stream(61 downto 60),
              result => Register_30_input_3);
              
line_2_mux_31: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_31_input_2,
              sel => line_2_mux_sel_stream(63 downto 62),
              result => Register_31_input_3);
              




  --------------------THIRD LINE--------------------------

  --instantiate third line of ALUs
  line_3 : ALUs_line
  Port Map (in0 => Register_0_input_3,
            in1 => Register_1_input_3,
            in2 => Register_2_input_3,
            in3 => Register_3_input_3,
            in4 => Register_4_input_3,
            in5 => Register_5_input_3,
            in6 => Register_6_input_3,
            in7 => Register_7_input_3,
            in8 => Register_8_input_3,
            in9 => Register_9_input_3,
            in10 => Register_10_input_3,
            in11 => Register_11_input_3,
            in12 => Register_12_input_3,
            in13 => Register_13_input_3,
            in14 => Register_14_input_3,
            in15 => Register_15_input_3,
            in16 => Register_16_input_3,
            in17 => Register_17_input_3,
            in18 => Register_18_input_3,
            in19 => Register_19_input_3,
            in20 => Register_20_input_3,
            in21 => Register_21_input_3,
            in22 => Register_22_input_3,
            in23 => Register_23_input_3,
            in24 => Register_24_input_3,
            in25 => Register_25_input_3,
            in26 => Register_26_input_3,
            in27 => Register_27_input_3,
            in28 => Register_28_input_3,
            in29 => Register_29_input_3,
            in30 => Register_30_input_3,
            in31 => Register_31_input_3,
            sel_bitstream => sel_stream_3,
            operation_bitstream => op_stream_3,
            output_1 => output_3_1,
            output_2 => output_3_2,
            output_3 => output_3_3 );
  --instantiate third line multiplexer
  line_3_mux_0: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_0_input_3,
              sel => line_3_mux_sel_stream(1 downto 0),
              result => output_mux_0);
              
line_3_mux_1: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_1_input_3,
              sel => line_3_mux_sel_stream(3 downto 2),
              result => output_mux_1);
              
line_3_mux_2: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_2_input_3,
              sel => line_3_mux_sel_stream(5 downto 4),
              result => output_mux_2);
              
line_3_mux_3: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_3_input_3,
              sel => line_3_mux_sel_stream(7 downto 6),
              result => output_mux_3);
              
line_3_mux_4: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_4_input_3,
              sel => line_3_mux_sel_stream(9 downto 8),
              result => output_mux_4);
              
line_3_mux_5: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_5_input_3,
              sel => line_3_mux_sel_stream(11 downto 10),
              result => output_mux_5);
              
line_3_mux_6: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_6_input_3,
              sel => line_3_mux_sel_stream(13 downto 12),
              result => output_mux_6);
              
line_3_mux_7: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_7_input_3,
              sel => line_3_mux_sel_stream(15 downto 14),
              result => output_mux_7);
              
line_3_mux_8: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_8_input_3,
              sel => line_3_mux_sel_stream(17 downto 16),
              result => output_mux_8);
              
line_3_mux_9: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_9_input_3,
              sel => line_3_mux_sel_stream(19 downto 18),
              result => output_mux_9);
              
line_3_mux_10: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_10_input_3,
              sel => line_3_mux_sel_stream(21 downto 20),
              result => output_mux_10);
              
line_3_mux_11: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_11_input_3,
              sel => line_3_mux_sel_stream(23 downto 22),
              result => output_mux_11);
              
line_3_mux_12: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_12_input_3,
              sel => line_3_mux_sel_stream(25 downto 24),
              result => output_mux_12);
              
line_3_mux_13: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_13_input_3,
              sel => line_3_mux_sel_stream(27 downto 26),
              result => output_mux_13);
              
line_3_mux_14: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_14_input_3,
              sel => line_3_mux_sel_stream(29 downto 28),
              result => output_mux_14);
              
line_3_mux_15: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_15_input_3,
              sel => line_3_mux_sel_stream(31 downto 30),
              result => output_mux_15);
              
line_3_mux_16: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_16_input_3,
              sel => line_3_mux_sel_stream(33 downto 32),
              result => output_mux_16);
              
line_3_mux_17: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_17_input_3,
              sel => line_3_mux_sel_stream(35 downto 34),
              result => output_mux_17);
              
line_3_mux_18: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_18_input_3,
              sel => line_3_mux_sel_stream(37 downto 36),
              result => output_mux_18);
              
line_3_mux_19: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_19_input_3,
              sel => line_3_mux_sel_stream(39 downto 38),
              result => output_mux_19);
              
line_3_mux_20: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_20_input_3,
              sel => line_3_mux_sel_stream(41 downto 40),
              result => output_mux_20);
              
line_3_mux_21: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_21_input_3,
              sel => line_3_mux_sel_stream(43 downto 42),
              result => output_mux_21);
              
line_3_mux_22: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_22_input_3,
              sel => line_3_mux_sel_stream(45 downto 44),
              result => output_mux_22);
              
line_3_mux_23: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_23_input_3,
              sel => line_3_mux_sel_stream(47 downto 46),
              result => output_mux_23);
              
line_3_mux_24: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_24_input_3,
              sel => line_3_mux_sel_stream(49 downto 48),
              result => output_mux_24);
              
line_3_mux_25: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_25_input_3,
              sel => line_3_mux_sel_stream(51 downto 50),
              result => output_mux_25);
              
line_3_mux_26: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_26_input_3,
              sel => line_3_mux_sel_stream(53 downto 52),
              result => output_mux_26);
              
line_3_mux_27: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_27_input_3,
              sel => line_3_mux_sel_stream(55 downto 54),
              result => output_mux_27);
              
line_3_mux_28: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_28_input_3,
              sel => line_3_mux_sel_stream(57 downto 56),
              result => output_mux_28);
              
line_3_mux_29: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_29_input_3,
              sel => line_3_mux_sel_stream(59 downto 58),
              result => output_mux_29);
              
line_3_mux_30: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_30_input_3,
              sel => line_3_mux_sel_stream(61 downto 60),
              result => output_mux_30);
              
line_3_mux_31: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_31_input_3,
              sel => line_3_mux_sel_stream(63 downto 62),
              result => output_mux_31);
              



            -----------------------------------------------------------------------------------------------------------------------
            mult_ALU_mux_0: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_0,
                      D => Register_0_input_3,
                      sel => final_mux_sel_stream(1 downto 0),
                      result => Register_final_input_0);
                      
        mult_ALU_mux_1: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_1,
                      D => Register_1_input_3,
                      sel => final_mux_sel_stream(3 downto 2),
                      result => Register_final_input_1);
                      
        mult_ALU_mux_2: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_2,
                      D => Register_2_input_3,
                      sel => final_mux_sel_stream(5 downto 4),
                      result => Register_final_input_2);
                      
        mult_ALU_mux_3: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_3,
                      D => Register_3_input_3,
                      sel => final_mux_sel_stream(7 downto 6),
                      result => Register_final_input_3);
                      
        mult_ALU_mux_4: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_4,
                      D => Register_4_input_3,
                      sel => final_mux_sel_stream(9 downto 8),
                      result => Register_final_input_4);
                      
        mult_ALU_mux_5: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_5,
                      D => Register_5_input_3,
                      sel => final_mux_sel_stream(11 downto 10),
                      result => Register_final_input_5);
                      
        mult_ALU_mux_6: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_6,
                      D => Register_6_input_3,
                      sel => final_mux_sel_stream(13 downto 12),
                      result => Register_final_input_6);
                      
        mult_ALU_mux_7: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_7,
                      D => Register_7_input_3,
                      sel => final_mux_sel_stream(15 downto 14),
                      result => Register_final_input_7);
                      
        mult_ALU_mux_8: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_8,
                      D => Register_8_input_3,
                      sel => final_mux_sel_stream(17 downto 16),
                      result => Register_final_input_8);
                      
        mult_ALU_mux_9: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_9,
                      D => Register_9_input_3,
                      sel => final_mux_sel_stream(19 downto 18),
                      result => Register_final_input_9);
                      
        mult_ALU_mux_10: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_10,
                      D => Register_10_input_3,
                      sel => final_mux_sel_stream(21 downto 20),
                      result => Register_final_input_10);
                      
        mult_ALU_mux_11: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_11,
                      D => Register_11_input_3,
                      sel => final_mux_sel_stream(23 downto 22),
                      result => Register_final_input_11);
                      
        mult_ALU_mux_12: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_12,
                      D => Register_12_input_3,
                      sel => final_mux_sel_stream(25 downto 24),
                      result => Register_final_input_12);
                      
        mult_ALU_mux_13: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_13,
                      D => Register_13_input_3,
                      sel => final_mux_sel_stream(27 downto 26),
                      result => Register_final_input_13);
                      
        mult_ALU_mux_14: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_14,
                      D => Register_14_input_3,
                      sel => final_mux_sel_stream(29 downto 28),
                      result => Register_final_input_14);
                      
        mult_ALU_mux_15: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_15,
                      D => Register_15_input_3,
                      sel => final_mux_sel_stream(31 downto 30),
                      result => Register_final_input_15);
                      
        mult_ALU_mux_16: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_16,
                      D => Register_16_input_3,
                      sel => final_mux_sel_stream(33 downto 32),
                      result => Register_final_input_16);
                      
        mult_ALU_mux_17: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_17,
                      D => Register_17_input_3,
                      sel => final_mux_sel_stream(35 downto 34),
                      result => Register_final_input_17);
                      
        mult_ALU_mux_18: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_18,
                      D => Register_18_input_3,
                      sel => final_mux_sel_stream(37 downto 36),
                      result => Register_final_input_18);
                      
        mult_ALU_mux_19: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_19,
                      D => Register_19_input_3,
                      sel => final_mux_sel_stream(39 downto 38),
                      result => Register_final_input_19);
                      
        mult_ALU_mux_20: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_20,
                      D => Register_20_input_3,
                      sel => final_mux_sel_stream(41 downto 40),
                      result => Register_final_input_20);
                      
        mult_ALU_mux_21: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_21,
                      D => Register_21_input_3,
                      sel => final_mux_sel_stream(43 downto 42),
                      result => Register_final_input_21);
                      
        mult_ALU_mux_22: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_22,
                      D => Register_22_input_3,
                      sel => final_mux_sel_stream(45 downto 44),
                      result => Register_final_input_22);
                      
        mult_ALU_mux_23: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_23,
                      D => Register_23_input_3,
                      sel => final_mux_sel_stream(47 downto 46),
                      result => Register_final_input_23);
                      
        mult_ALU_mux_24: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_24,
                      D => Register_24_input_3,
                      sel => final_mux_sel_stream(49 downto 48),
                      result => Register_final_input_24);
                      
        mult_ALU_mux_25: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_25,
                      D => Register_25_input_3,
                      sel => final_mux_sel_stream(51 downto 50),
                      result => Register_final_input_25);
                      
        mult_ALU_mux_26: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_26,
                      D => Register_26_input_3,
                      sel => final_mux_sel_stream(53 downto 52),
                      result => Register_final_input_26);
                      
        mult_ALU_mux_27: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_27,
                      D => Register_27_input_3,
                      sel => final_mux_sel_stream(55 downto 54),
                      result => Register_final_input_27);
                      
        mult_ALU_mux_28: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_28,
                      D => Register_28_input_3,
                      sel => final_mux_sel_stream(57 downto 56),
                      result => Register_final_input_28);
                      
        mult_ALU_mux_29: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_29,
                      D => Register_29_input_3,
                      sel => final_mux_sel_stream(59 downto 58),
                      result => Register_final_input_29);
                      
        mult_ALU_mux_30: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_30,
                      D => Register_30_input_3,
                      sel => final_mux_sel_stream(61 downto 60),
                      result => Register_final_input_30);
                      
        mult_ALU_mux_31: Multiplexer_4
            Port Map (A => mult_output,
                      B => memory_out,
                      C => output_mux_31,
                      D => Register_31_input_3,
                      sel => final_mux_sel_stream(63 downto 62),
                      result => Register_final_input_31);
                      
        
              


  
--------------------REGISTER BANK--------------------------

  BANK : Register_Bank
  Port Map( in0 => Register_final_input_0,
            in1 => Register_final_input_1,
            in2 => Register_final_input_2,
            in3 => Register_final_input_3,
            in4 => Register_final_input_4,
            in5 => Register_final_input_5,
            in6 => Register_final_input_6,
            in7 => Register_final_input_7,
            in8 => Register_final_input_8,
            in9 => Register_final_input_9,
            in10 => Register_final_input_10,
            in11 => Register_final_input_11,
            in12 => Register_final_input_12,
            in13 => Register_final_input_13,
            in14 => Register_final_input_14,
            in15 => Register_final_input_15,
            in16 => Register_final_input_16,
            in17 => Register_final_input_17,
            in18 => Register_final_input_18,
            in19 => Register_final_input_19,
            in20 => Register_final_input_20,
            in21 => Register_final_input_21,
            in22 => Register_final_input_22,
            in23 => Register_final_input_23,
            in24 => Register_final_input_24,
            in25 => Register_final_input_25,
            in26 => Register_final_input_26,
            in27 => Register_final_input_27,
            in28 => Register_final_input_28,
            in29 => Register_final_input_29,
            in30 => Register_final_input_30,
            in31 => Register_final_input_31,
            clk => clk,out0 => Register_0_output,
            out1 => Register_1_output,
            out2 => Register_2_output,
            out3 => Register_3_output,
            out4 => Register_4_output,
            out5 => Register_5_output,
            out6 => Register_6_output,
            out7 => Register_7_output,
            out8 => Register_8_output,
            out9 => Register_9_output,
            out10 => Register_10_output,
            out11 => Register_11_output,
            out12 => Register_12_output,
            out13 => Register_13_output,
            out14 => Register_14_output,
            out15 => Register_15_output,
            out16 => Register_16_output,
            out17 => Register_17_output,
            out18 => Register_18_output,
            out19 => Register_19_output,
            out20 => Register_20_output,
            out21 => Register_21_output,
            out22 => Register_22_output,
            out23 => Register_23_output,
            out24 => Register_24_output,
            out25 => Register_25_output,
            out26 => Register_26_output,
            out27 => Register_27_output,
            out28 => Register_28_output,
            out29 => Register_29_output,
            out30 => Register_30_output,
            out31 => Register_31_output            
          );

out0 <= Register_0_output;
out1 <= Register_1_output;
out2 <= Register_2_output;
out3 <= Register_3_output;
out4 <= Register_4_output;
out5 <= Register_5_output;
out6 <= Register_6_output;
out7 <= Register_7_output;
out8 <= Register_8_output;
out9 <= Register_9_output;
out10 <= Register_10_output;
out11 <= Register_11_output;
out12 <= Register_12_output;
out13 <= Register_13_output;
out14 <= Register_14_output;
out15 <= Register_15_output;
out16 <= Register_16_output;
out17 <= Register_17_output;
out18 <= Register_18_output;
out19 <= Register_19_output;
out20 <= Register_20_output;
out21 <= Register_21_output;
out22 <= Register_22_output;
out23 <= Register_23_output;
out24 <= Register_24_output;
out25 <= Register_25_output;
out26 <= Register_26_output;
out27 <= Register_27_output;
out28 <= Register_28_output;
out29 <= Register_29_output;
out30 <= Register_30_output;
out31 <= Register_31_output;
          
end architecture;
