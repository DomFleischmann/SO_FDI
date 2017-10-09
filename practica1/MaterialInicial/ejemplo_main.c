#include <stdio.h>
#include <stdlib.h>

#Para entender el paso de parametros C gnu-Linux

int main(int argc, char *argv[])
{
  int arg;
  for(arg = 0; arg < argc; arg++) {
    if(argv[arg][0] == '-')
      printf("option: %s\n", argv[arg]+1);
    else
      printf("argument %d: %s\n", arg, argv[arg]);
    }
exit(0);
}
