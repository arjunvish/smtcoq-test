#!/bin/bash
echo "Filename, Result-Old, Proof-Old, Result-New, Proof-New" > output.csv
for f in $(find ./ -name '*.smt_in')
do
  echo "Filename: $f"
  #run veriT-old with 12s timeout
  veritOld=$(veriT-old --max-time=12 $f)
    #if unsat
    if [[ "$veritOld" == *"unsat"* ]]
    then
      echo "old-unsat"
      resold="unsat"
      pold=${f}"proofold"
      timeout 12s veriT-old --max-time=12 --proof=$pold $f
      if [ $? -eq 0 ]; then
      	echo "Success!"
        poldsuc="Success"
      else
        poldsuc="Failure"
        echo "Failure!"
      fi
    #if sat
    else if [[ "$veritOld" == *"sat"* ]]
    then
      #print old-sat
      echo "old-sat"
      resold="sat"
      poldsuc="Failure"
    #if timeout
    else if [[ "$veritOld" == *"Time"* ]]
    then
      echo "old-timeout"
      resold="timeout"
      poldsuc="Failure"
    #else
    else
      echo "old-unknown"
      resold="unknown"
      poldsuc="Failure"
    fi
    fi
    fi
  echo ""
  #run veriT-new with 12s timeout
  verit=$(veriT --max-time=12000 $f)
    #if unsat
    if [[ "$verit" == *"unsat"* ]]
    then
      #print new-unsat
      echo "new-unsat"
      resnew="unsat"
      #run veriT-old with proof file
      pnew=${f}"proofnew"
      timeout 12s veriT --max-time=12000 --proof=$pnew $f
      if [ $? -eq 0 ]; then
      	echo "Success!"
        pnewsuc="Success"
      else
        echo "Failure!"
        pnewsuc="Failure"
      fi
    #if sat
    else if [[ "$verit" == *"sat"* ]]
    then
      #print new-sat
      echo "new-sat"
      resnew="sat"
      pnewsuc="Failure"
    #if timeout
    else if [[ "$verit" == *"Time"* ]]
    then
      echo "new-timeout"
      resnew="timeout"
      pnewsuc="Failure"
    #else
    else
      echo "new-unknown"
      resnew="unknown"
      pnewsuc="Failure"
    fi
    fi
    fi
  echo ""
  echo "$f,$resold,$poldsuc,$resnew,$pnewsuc" >> output.csv
done
