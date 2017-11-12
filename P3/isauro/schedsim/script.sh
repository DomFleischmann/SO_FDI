#===========================================
#
#	Sistemas Operativos.
#	Grado de Ingeniereía informática.
#
#	Grupo: 		Los hijos de Stallman
#
#	Práctica 3. 
#	----------------------------------------
#
#===========================================
echo ""
echo "Iniciando script."
echo "-------------------------------------"
if [ -e "schedsim" ] && [ -x "schedsim" ]; then 
echo "Se ha encontrado el programa simulador (schedsim)."
else exit 1
fi
echo "-------------------------------------"

#===========================================
#
#	Una vez se ha comprobado que el programa 
#	existe y es ejecutable, borramos los
#	resultados de prueba de la ejecución anterior.
#---

if [ -d resultados ]; then rm -r resultados
fi

#===========================================
#
#	Preguntamos que archivo de prueba 
#	quiere ejecutar.
#---

cd examples

echo "Introduce el nombre del caso de pruebas:"
read fichero
while ! [ -e $fichero ] || ! [ -f $fichero ];
do
	if ! [ -e $fichero ]; then 
		echo "No se ha encontrado el caso de pruebas: $fichero." 
	fi

	if ! [ -f $fichero ]; then 
		echo "El fichero $fichero no es regular."		     
	fi

	echo ""
	echo "Introduce el nombre del caso de pruebas:"
	read fichero
done

cd ..
echo "Se ha encontrado el fichero de pruebas."

n=0
while [ $n -lt 1  ] || [ $n -gt 8 ]; 
do
	echo "Introduce en numero de CPUs que quieres utilizar ( <= 8):"
	read n
done

echo "El fichero $fichero se ejecutara usando $n CPUs"
echo "Iniciando ejecucion..."
make clean
make

mkdir resultados

#===========================================
#
#---

for nameSched in "RR" "SJF" "FCFS" "PRIO"
do

	echo ""
	echo "-------------------------------------"
	echo $nameSched
	echo "-------------------------------------"

	for (( cpus=1; cpus <= $n; ++cpus ))
	do	 
		./schedsim -i examples/$fichero -n $cpus -s $nameSched
		for (( i=0; i < $cpus; ++i ))
		do
 			mv CPU_$i.log resultados/$nameSched-CPU-$i.log
			cd ../gantt-gplot
			./generate_gantt_chart ../schedsim/resultados/$nameSched-CPU-$i.log
			cd ../schedsim
		done
	done
done
