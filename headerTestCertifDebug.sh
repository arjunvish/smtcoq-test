#!/bin/bash
#./testCertif.sh n
echo "Section Checker_SmtEx$1Debug."
echo "  Parse_certif_verit t_i$1 t_func$1 t_atom$1 t_form$1 root$1 used_roots$1 trace$1"
echo "  \"/home/arjun/Desktop/smtcoq/arjunvish-smtcoq-veritparser/smtcoq/examples/test$1.smt2\""
echo "  \"/home/arjun/Desktop/smtcoq/arjunvish-smtcoq-veritparser/smtcoq/examples/test$1.vtlog\"."

echo "  Definition nclauses$1 := Eval vm_compute in (match trace$1 with Certif a _ _ => a end)."
echo "  Definition c$1 := Eval vm_compute in (match trace$1 with Certif _ a _ => a end). (* Certificate *)"
echo "  Definition conf$1 := Eval vm_compute in (match trace$1 with Certif _ _ a => a end). (* Look here in the state for the empty clause*)"

echo "  Eval vm_compute in (Form.check_form t_form$1 && Atom.check_atom t_atom$1 && Atom.wt t_i$1 t_func$1 t_atom$1)."
echo "  Eval vm_compute in List.length (fst c$1). Print conf$1."
