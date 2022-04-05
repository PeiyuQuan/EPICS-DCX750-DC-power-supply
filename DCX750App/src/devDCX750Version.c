/* devDCX750Version.c */
/* Example device support for the lsi (long string input) record
 * providing the module version string as the value
 */

#include <stddef.h>
#include <stdio.h>
#include <string.h>

#include "devSup.h"
#include "lsiRecord.h"

#include "DCX750Version.h"

/* must be last include */
#include "epicsExport.h"

const char version[] = DCX750VERSION;

static long read_string(lsiRecord *prec)
{
    size_t N = sizeof version;
    char *buf = prec->val;

    if (N > prec->sizv)
        N = prec->sizv;
    prec->len = N;

    memcpy(buf, version, N);
    buf[N - 1] = '\0';

    return 0;
}

static lsidset devDCX750Version = {
    5, NULL, NULL, NULL, NULL, read_string
};
epicsExportAddress(dset,devDCX750Version);
