#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

# If no arguments provided when running script
if [[ ! $1 ]]; then
    # Return error: Please provide an element as an argument.
    echo -e "Please provide an element as an argument."

else
    SEARCH_TERM=$1

    # Check if search term is a number
    if [[ $SEARCH_TERM =~ [0-9+] ]]; then
        # Search for element by num
        ELEMENT=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements AS e FULL JOIN properties AS p USING(atomic_number) FULL JOIN types AS t USING(type_id) WHERE e.atomic_number = $SEARCH_TERM")

        # If not found
        if [[ -z $ELEMENT ]]; then
            # Return error: I could not find that element in the database.
            echo "I could not find that element in the database."

        else
            echo "$ELEMENT" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE; do
                echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
            done

        fi

    else
        # Search for element by symbol or name
        ELEMENT=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements AS e FULL JOIN properties AS p USING(atomic_number) FULL JOIN types AS t USING(type_id) WHERE e.symbol = '$SEARCH_TERM' OR e.name = '$SEARCH_TERM'")

        # If not found
        if [[ -z $ELEMENT ]]; then
            # Return error: I could not find that element in the database.
            echo "I could not find that element in the database."

        else
            echo "$ELEMENT" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE; do
                echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
            done

        fi

    fi

fi
