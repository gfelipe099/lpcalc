#!/bin/sh

srcdir="src/"

cd ${srcdir}

if [ ! -d ../bin ]; then
    mkdir -pv ../bin
fi

usage() {
    cat << EOF
==> Valid arguments: build, install, uninstall, clear
EOF
}

if [ -z ${1} ]; then
    usage
elif [ ${1} = "build" ]; then
    if [ -f sum.c ] || [ -f subtract.c ] || [ -f multiply.c ] || [ -f division.c ]; then
        gcc -Wall -c sum.c subtract.c multiply.c division.c
    fi

    if [ -f main.c ]; then
        gcc -Wall -c main.c
    fi

    if [ -f main.o ] || [ -f sum.o ] || [ -f subtract.o ] ||[ -f multiply.o ] || [ -f division.o ]; then
        gcc -o ../bin/lpcalc main.o subtract.o sum.o multiply.o division.o
    fi

    if [ -f ../bin/lpcalc ]; then
        echo "Compilation done successfully"
        else
            echo "ERROR: ${1}: Could not compile the program"
    fi

elif [ ${1} = "clear" ]; then
    if [ -f main.o ] || [ -f sum.o ] || [ -f subtract.o ] ||[ -f multiply.o ] || [ -f division.o ]; then
        for obj_file in *.o; do
            echo "==> Found object file: ${obj_file}"
            echo "    -> Removing file: ${obj_file}..."
            rm ${obj_file}
        done
        else
            echo "==> No leftovers left"
    fi
    if [ -f ../bin/lpcalc ]; then
        for bin_file in ../bin/*; do
            echo "==> Found binary file: ${bin_file}"
            echo "    -> Removing binary file: ${bin_file}..."
            rm ${bin_file}
        echo "==> Removal done"
        done
        else
            echo "==> No binary files left"
    fi
elif [ ${1} = "install" ]; then
    if [ -f ../bin/lpcalc ]; then
        if [ ! -f /usr/local/bin/lpcalc ]; then
            if [ -f /usr/bin/sudo ]; then
                echo "==> Installing to: /usr/local/bin/lpcalc..."
                sudo install -Dm655 ../bin/lpcalc /usr/local/bin/lpcalc
                echo "==> Installed successfully"
            fi
            else
                echo "==> Already installed or not installed yet"
        fi
        else
            echo "==> The calculator is not compiled yet"
    fi
elif [ ${1} = "uninstall" ]; then
    if [ -f /usr/local/bin/lpcalc ]; then
        if [ -f /usr/bin/sudo ]; then
            echo "==> Uninstalling from: /usr/local/bin/lpcalc..."
            sudo rm /usr/local/bin/lpcalc
            echo "==> Uninstalled successfully"
        fi
        else
            echo "==> Already uninstalled or not uninstalled yet"
    fi
    else
        usage
fi
