CREATE OR REPLACE PACKAGE PKG_UTILS AS
  PROCEDURE LOG_MESSAGE(p_message VARCHAR2, p_level VARCHAR2 := 'INFO');
  FUNCTION  GET_SYSTEM_DATE RETURN DATE;
  FUNCTION  FORMAT_CURRENCY(p_amount NUMBER) RETURN VARCHAR2;
  PROCEDURE RAISE_ERROR(p_err_msg VARCHAR2);
  PROCEDURE VALIDATE_NON_NULL(p_value VARCHAR2, p_field_name VARCHAR2);
  PROCEDURE VALIDATE_POSITIVE_NUMBER(p_value NUMBER, p_field_name VARCHAR2);
END PKG_UTILS;
/
CREATE OR REPLACE PACKAGE BODY PKG_UTILS AS
  PROCEDURE LOG_MESSAGE(p_message VARCHAR2, p_level VARCHAR2 := 'INFO') IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('[' || p_level || '] ' || p_message);
  END LOG_MESSAGE;

  FUNCTION GET_SYSTEM_DATE RETURN DATE IS
  BEGIN
    RETURN SYSDATE;
  END GET_SYSTEM_DATE;

  FUNCTION FORMAT_CURRENCY(p_amount NUMBER) RETURN VARCHAR2 IS
  BEGIN
    RETURN TO_CHAR(p_amount, 'FM$999,999,999.99');
  END FORMAT_CURRENCY;

  PROCEDURE RAISE_ERROR(p_err_msg VARCHAR2) IS
  BEGIN
    LOG_MESSAGE('ERROR: ' || p_err_msg, 'ERROR');
    RAISE_APPLICATION_ERROR(-20000, p_err_msg);
  END RAISE_ERROR;

  PROCEDURE VALIDATE_NON_NULL(p_value VARCHAR2, p_field_name VARCHAR2) IS
  BEGIN
    IF p_value IS NULL THEN
      RAISE_ERROR('Field ' || p_field_name || ' cannot be null');
    END IF;
  END VALIDATE_NON_NULL;

  PROCEDURE VALIDATE_POSITIVE_NUMBER(p_value NUMBER, p_field_name VARCHAR2) IS
  BEGIN
    IF p_value IS NULL OR p_value <= 0 THEN
      RAISE_ERROR('Field ' || p_field_name || ' must be positive');
    END IF;
  END VALIDATE_POSITIVE_NUMBER;
END PKG_UTILS;
/