#include <stdio.h>
#include "sum.h"
#include "multiply.h"
#include "subtract.h"
#include "division.h"

int main() {
    printf("\nWelcome to Liam Powell's barebones C calculator!\n\n");
    
    int a, b;

    printf("Enter first value: ");
    scanf("%d", &a);

    printf("Enter second value: ");
    scanf("%d", &b);

    sum(a,b);
    multiply(a,b);
    subtract(a,b);
    division(a,b);

    return 0;
}