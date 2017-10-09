#===========================
#
#	Sistemas Operativos.
#	Grado de Ingeniereía informática.
#
#	Group name: Los hijos de Stallman.
#
#	Práctica 1. 
#===========================
#
#	We check that mytar exists and has x permission.
#---

echo ""
echo "Executing..."
if [ -s "mytar" ] && [ -x "mytar" ]; then
echo "Found."
else 
echo "E404: mytar not found"
exit 1
fi

#===========================
#
#	We erase tmp files.
#---

echo "Cleaning previous tmp files..."
if [ -d tmp ]; then rm -r tmp
fi
#===========================
#
#	New tmp files.
#---

echo "Making tmp files..."
mkdir tmp
cd tmp

> file1.txt
echo "Hola Mundo!" > file1.txt
> file2.txt
head -10 /etc/passwd > file2.txt
> file3.dat
head -c 1024 /dev/urandom > file3.dat

#===========================
#
#	We compress the tmp files. 
#---

echo "Compressing..."
.././mytar -cf filetar.mtar file1.txt file2.txt file3.dat

mkdir out
mv filetar.mtar out/filetar.mtar

#===========================
#
#	We decomress the tar file.
#---

echo "-------------------------------------"
echo "Decompressing..."
cd out
../.././mytar -xf filetar.mtar

#===========================
#
#	We check that compressed files are equal to originals.
#---

echo "Checking..."
diff file1.txt ../file1.txt
BF1=$?
diff file2.txt ../file2.txt
BF2=$?
diff file3.dat ../file3.dat
BF3=$?

cd ../..
if [ $BF1 -eq 0 ] && [ $BF2 -eq 0 ] && [ $BF3 -eq 0 ]; then 
echo "Correct"
else echo "Error"
exit 1
fi
