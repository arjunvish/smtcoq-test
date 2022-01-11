#!/bin/bash
#./testCertif.sh n nsteps
echo "  Definition s0_$1 := Eval vm_compute in (add_roots (S.make nclauses$1) root$1 used_roots$1)."
echo "  Print s0_$1."
for (( i=1; i<=$2; i++ ))
do
  j=`expr $i - 1`
  echo "  Definition s${i}_$1 := Eval vm_compute in (step_checker s${j}_$1 (List.nth $j (fst c$1) (CTrue t_func$1 t_atom$1 t_form$1 0)))."
  echo "  Eval vm_compute in (List.nth $j (fst c$1)). Print s${i}_$1."
done
echo "  (* If the main_checker returns true, SMTCoq has successfully managed to check the proof *)"
echo "  Eval vm_compute in (euf_checker C.is_false (add_roots (S.make nclauses$1) root$1 used_roots$1) c$1 conf$1)."
echo "End Checker_SmtEx$1Debug."
