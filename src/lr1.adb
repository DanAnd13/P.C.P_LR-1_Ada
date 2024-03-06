with Ada.Text_IO;
use Ada.Text_IO;
procedure Lab1 is
   can_stop : boolean := false;
   id : Integer := 0;
   step : Long_Float := 1.0;
   count_of_thread : Integer := 6;
   pragma Atomic(can_stop);
   task type break_thread;
   task type main_thread is
      entry Start(count:Integer; step:Long_Float);
     end main_thread;

   procedure Sequence(step : Long_Float) is
   sum : Long_Float := 0.0;
      current_value : Long_Float := 0.0;
      count : Long_Integer :=0;
   begin
      loop
         sum := sum + current_value;
            count := count + 1;
            current_value := current_value + step;
         exit when can_stop;
      end loop;
      delay 2.0;
      id := id + 1;
      Put_Line("Thread " & id'Img & " sum of " & count'Img & " elements equals " & sum'Img);
   end Sequence;

   task body break_thread is
   begin
      delay 5.0;
      can_stop := true;
   end break_thread;

   task body main_thread is

   begin
      accept Start(count:Integer; step:Long_Float);
         Sequence(step);
   end main_thread;

   break : break_thread;
   thread1 : array(1..count_of_thread) of main_thread;
begin
   for i in 1..count_of_thread loop
      thread1(i).Start(i,step);
      end loop;
end Lab1;
