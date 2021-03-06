/* C code produced by gperf version 2.1p1 (K&R C version, modified by Pavel) */
/* Command-line: pgperf/pgperf -aCIptT -k1,3,$ keywords.gperf  */

#include "my-ctype.h"

	/* -*- C -*- */

/******************************************************************************
  Copyright (c) 1992, 1995, 1996 Xerox Corporation.  All rights reserved.
  Portions of this code were written by Stephen White, aka ghond.
  Use and copying of this software and preparation of derivative works based
  upon this software are permitted.  Any distribution of this software or
  derivative works must comply with all applicable United States export
  control laws.  This software is made available AS IS, and Xerox Corporation
  makes no warranty about the software, its performance or its conformity to
  any specification.  Any person obtaining a copy of this software is requested
  to send their name and post office or electronic mail address to:
    Pavel Curtis
    Xerox PARC
    3333 Coyote Hill Rd.
    Palo Alto, CA 94304
    Pavel@Xerox.Com
 *****************************************************************************/

#include "my-string.h"

#include "config.h"
#include "keywords.h"
#include "tokens.h"
#include "utils.h"


#define MIN_WORD_LENGTH 2
#define MAX_WORD_LENGTH 9
#define MIN_HASH_VALUE 3
#define MAX_HASH_VALUE 103
/*
   38 keywords
  101 is the maximum key range
*/

static int
hash (register const char *str, register int len)
{
  static const unsigned char hash_table[] =
    {
     103, 103, 103, 103, 103, 103, 103, 103, 103, 103,
     103, 103, 103, 103, 103, 103, 103, 103, 103, 103,
     103, 103, 103, 103, 103, 103, 103, 103, 103, 103,
     103, 103, 103, 103, 103, 103, 103, 103, 103, 103,
     103, 103, 103, 103, 103, 103, 103, 103, 103, 103,
     103, 103, 103, 103, 103, 103, 103, 103, 103, 103,
     103, 103, 103, 103, 103, 103, 103, 103, 103, 103,
     103, 103, 103, 103, 103, 103, 103, 103, 103, 103,
     103, 103, 103, 103, 103, 103, 103, 103, 103, 103,
     103, 103, 103, 103, 103, 103, 103,  10,   0,  45,
      20,   0,   0,  10, 103,  45, 103,  10, 103,  35,
      50, 103,   5,  10,   0,  25,  15, 103,  35,   5,
     103,  10, 103, 103, 103, 103, 103, 103,
    };
  register int hval = len;

  switch (hval)
    {
      default:
      case 3:
        hval += hash_table[tolower((unsigned char) str[2])];
      case 2:
      case 1:
        hval += hash_table[tolower((unsigned char) str[0])];
    }
  return hval + hash_table[tolower((unsigned char) str[len - 1])];
}

static int
case_strcmp (register const char *str, register const char *key)
{
  int ans = 0;

  while (!(ans = tolower(*str) - (int) *key) && *str)
    str++, key++;

  return ans;
}

const struct keyword *
in_word_set (register const char *str, register int len)
{

  static const struct keyword  wordlist[] =
    {
      {"",}, {"",}, {"",}, 
      {"for", 		DBV_Prehistory, tFOR},
      {"",}, {"",}, 
      {"e_file", 		DBV_FileIO,	tERROR,	E_FILE},
      {"e_range", 	DBV_Prehistory, tERROR,	E_RANGE},
      {"",}, 
      {"e_recmove", 	DBV_Prehistory, tERROR,	E_RECMOVE},
      {"",}, {"",}, {"",}, 
      {"e_propnf", 	DBV_Prehistory, tERROR,	E_PROPNF},
      {"fork", 		DBV_Prehistory, tFORK},
      {"break", 		DBV_BreakCont, tBREAK},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"e_type", 		DBV_Prehistory, tERROR,	E_TYPE},
      {"e_float", 	DBV_Float,	tERROR,	E_FLOAT},
      {"",}, {"",}, 
      {"endif", 		DBV_Prehistory, tENDIF},
      {"endfor", 		DBV_Prehistory, tENDFOR},
      {"e_quota", 	DBV_Prehistory, tERROR,	E_QUOTA},
      {"endwhile", 	DBV_Prehistory, tENDWHILE},
      {"else", 		DBV_Prehistory, tELSE},
      {"",}, 
      {"elseif", 		DBV_Prehistory, tELSEIF},
      {"",}, 
      {"any", 		DBV_Exceptions, tANY},
      {"",}, {"",}, 
      {"endtry", 		DBV_Exceptions, tENDTRY},
      {"endfork", 	DBV_Prehistory, tENDFORK},
      {"try", 		DBV_Exceptions, tTRY},
      {"",}, {"",}, 
      {"e_args", 		DBV_Prehistory, tERROR,	E_ARGS},
      {"e_varnf", 	DBV_Prehistory, tERROR,	E_VARNF},
      {"e_verbnf", 	DBV_Prehistory, tERROR,	E_VERBNF},
      {"",}, {"",}, 
      {"e_perm", 		DBV_Prehistory, tERROR,	E_PERM},
      {"if", 		DBV_Prehistory, tIF},
      {"",}, {"",}, {"",}, 
      {"e_exec", 		DBV_Exec,	tERROR,	E_EXEC},
      {"",}, {"",}, {"",}, 
      {"while", 		DBV_Prehistory, tWHILE},
      {"e_none", 		DBV_Prehistory, tERROR,	E_NONE},
      {"",}, {"",}, {"",}, 
      {"e_div", 		DBV_Prehistory, tERROR,	E_DIV},
      {"",}, {"",}, 
      {"e_invarg", 	DBV_Prehistory, tERROR,	E_INVARG},
      {"",}, {"",}, 
      {"except", 		DBV_Exceptions, tEXCEPT},
      {"finally", 	DBV_Exceptions, tFINALLY},
      {"e_intrpt", 	DBV_Interrupt,	tERROR,	E_INTRPT},
      {"",}, {"",}, 
      {"return", 		DBV_Prehistory, tRETURN},
      {"",}, 
      {"e_invind", 	DBV_Prehistory, tERROR,	E_INVIND},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"e_maxrec", 	DBV_Prehistory, tERROR,	E_MAXREC},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"in", 		DBV_Prehistory, tIN},
      {"",}, {"",}, {"",}, 
      {"e_nacc", 		DBV_Prehistory, tERROR,	E_NACC},
      {"",}, 
      {"continue", 	DBV_BreakCont, tCONTINUE},
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register int key = hash (str, len);

      if (key <= MAX_HASH_VALUE && key >= MIN_HASH_VALUE)
        {
          register const char *s = wordlist[key].name;

          if (*s == tolower(*str) && !case_strcmp (str + 1, s + 1))
            return &wordlist[key];
        }
    }
  return 0;
}

const struct keyword *
find_keyword(const char *word)
{
    return in_word_set(word, strlen(word));
}

char rcsid_keywords[] = "$Id: keywords.gperf,v 1.1 1997/03/03 03:45:02 nop Exp $";

/* $Log: keywords.gperf,v $
/* Revision 1.1  1997/03/03 03:45:02  nop
/* Initial revision
/*
 * Revision 2.2  1996/02/08  06:33:21  pavel
 * Added `break', `continue', and E_FLOAT.  Updated copyright notice for 1996.
 * Release 1.8.0beta1.
 *
 * Revision 2.1  1995/12/11  08:15:42  pavel
 * Added #include "tokens.h" removed from keywords.h.  Release 1.8.0alpha2.
 *
 * Revision 2.0  1995/11/30  05:02:56  pavel
 * New baseline version, corresponding to release 1.8.0alpha1.
 *
 * Revision 1.1  1995/11/30  05:01:47  pavel
 * Initial revision
 */
