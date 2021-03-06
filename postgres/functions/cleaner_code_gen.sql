/*
* @Author: toan.nguyen
* @Date:   2016-08-09 16:34:30
* @Last Modified by:   toan.nguyen
* @Last Modified time: 2016-08-17 17:01:11
*/

-- Create Sequence for generating booking code

CREATE SEQUENCE hc.cleaner_code_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: trip_code_generator(); Type: FUNCTION; Schema: public; Owner: eateruser
--

CREATE OR REPLACE FUNCTION hc.cleaner_code_generator(OUT result text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- the id of this DB shard, must be set for each
    -- schema shard you have - you could pass this as a parameter too
    seq_id bigint;
    prefix text := 'NV1';
BEGIN
    SELECT nextval('hc.cleaner_code_sequence') INTO seq_id;

    IF seq_id < 10000 THEN
        result := prefix || LPAD(seq_id::text, 4, '0');
        ELSE
        result := prefix || seq_id::text;
        END IF;
END;
$$;

