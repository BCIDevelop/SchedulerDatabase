#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --no-align --tuples-only -c"
echo -e "\n~~~~~~ Welcome to the GOAT styled barber in this town ~~~~~~\n"

MAIN_MENU(){
  if [[ $1 ]]
  then
    if [[ $1 =~ 'I have put you down for a' ]]
    then
      echo -e "\n$1"
      exit 0
    else
      echo -e "\n$1"
    fi
  fi
  echo -e "\nPlease select a service"
  echo -e "\n1) haircut"
  echo -e "\n2) tattoo"
  echo -e "\n3) shave"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
  1) HAIRCUT_MENU ;;
  2) TATTO_MENU ;;
  3) SHAVE_MENU ;;
  *) MAIN_MENU "Please choose a valid service"
  esac
  
}
HAIRCUT_MENU(){
  echo -e "\nPlease enter you phone to make the appointment"
  read CUSTOMER_PHONE
  if [[ -z $CUSTOMER_PHONE ]]
  then
    MAIN_MENU "Please use a valid Phone"
  else
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_ID ]]
    then
      echo -e "You are new please provide us with you info"
      read CUSTOMER_NAME
      CUSTOMER_ADD=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    fi
    echo -e "\nProvide the time for the appointment"
    read SERVICE_TIME
    APPOINTMENT_ADD=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
    MAIN_MENU "I have put you down for a haircut at ${SERVICE_TIME}, ${CUSTOMER_NAME}."

  fi
}
TATOO_MENU(){
  echo -e "\nPlease enter you phone to make the appointment"
  read CUSTOMER_PHONE
  if [[ -z $CUSTOMER_PHONE ]]
  then
    MAIN_MENU "Please use a valid Phone"
  else
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_ID ]]
    then
      echo -e "You are new please provide us with you info"
      read CUSTOMER_NAME
      CUSTOMER_ADD=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    fi
    echo -e "\nProvide the time for the appointment"
    read SERVICE_TIME
    APPOINTMENT_ADD=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
    MAIN_MENU "I have put you down for a tattoo at ${SERVICE_TIME}, ${CUSTOMER_NAME}."

  fi
}
SHAVE_MENU(){
 echo -e "\nPlease enter you phone to make the appointment"
  read CUSTOMER_PHONE
  if [[ -z $CUSTOMER_PHONE ]]
  then
    MAIN_MENU "Please use a valid Phone"
  else
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_ID ]]
    then
      echo -e "You are new please provide us with you info"
      read CUSTOMER_NAME
      CUSTOMER_ADD=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    fi
    echo -e "\nProvide the time for the appointment"
    read SERVICE_TIME
    APPOINTMENT_ADD=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
    MAIN_MENU "I have put you down for a shave at ${SERVICE_TIME}, ${CUSTOMER_NAME}."

  fi
}

MAIN_MENU