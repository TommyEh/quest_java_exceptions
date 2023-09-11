#!/usr/bin/env bash
clear
if [[ -n "$1" ]]; then
    classname="$1"
    classname="$(tr '[:lower:]' '[:upper:]' <<< ${classname:0:1})${classname:1}"

    javac -classpath "out;lib/junit-4.12.jar;lib/hamcrest-core-1.3.jar" src/main/${classname}.java -d out 2> logs/checkmethod_output.txt
    if [[ $(< logs/checkmethod_output.txt) != "" ]]; then
        cat logs/checkmethod_output.txt
    else
        javac -classpath "out;lib/junit-4.12.jar;lib/hamcrest-core-1.3.jar" src/test/${classname}Test.java -d out
        java -classpath "out;lib/junit-4.12.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore ${classname}Test
    fi
    read -p "Press any key to continue..."

else
    echo "Please specify the kata to test, e.g. : ./tester.sh OddSum"
fi
