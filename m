Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463F539EF46
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFHHNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:13:40 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3784 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhFHHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:13:32 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fzh9z25l3zWnVd;
        Tue,  8 Jun 2021 15:06:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:37 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 3/5] lib/inflate.c: remove trailing spaces and tabs
Date:   Tue, 8 Jun 2021 15:11:15 +0800
Message-ID: <20210608071117.12634-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210608071117.12634-1-thunder.leizhen@huawei.com>
References: <20210608071117.12634-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run the following command to find and remove the trailing spaces and tabs:

sed -r -i 's/[ \t]+$//' lib/inflate.c

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/inflate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/inflate.c b/lib/inflate.c
index fbaf03c1748d..f23bd82db7ed 100644
--- a/lib/inflate.c
+++ b/lib/inflate.c
@@ -4,9 +4,9 @@
 /* inflate.c -- Not copyrighted 1992 by Mark Adler
    version c10p1, 10 January 1993 */
 
-/* 
+/*
  * Adapted for booting Linux by Hannu Savolainen 1993
- * based on gzip-1.0.3 
+ * based on gzip-1.0.3
  *
  * Nicolas Pitre <nico@fluxnic.net>, 1999/04/14 :
  *   Little mods for all variable to reside either into rodata or bss segments
@@ -51,7 +51,7 @@
    chunks), otherwise the dynamic method is used.  In the latter case, the
    codes are customized to the probabilities in the current block, and so
    can code it much better than the pre-determined fixed codes.
- 
+
    The Huffman codes themselves are decoded using a multi-level table
    lookup, in order to maximize the speed of decoding plus the speed of
    building the decoding tables.  See the comments below that precede the
@@ -126,7 +126,7 @@ static char rcsid[] = "#Id: inflate.c,v 0.14 1993/06/10 13:27:04 jloup Exp #";
 #ifndef INIT
 #define INIT
 #endif
-	
+
 #define slide window
 
 /* Huffman code lookup table entry--this entry is four bytes for machines
@@ -147,7 +147,7 @@ struct huft {
 
 
 /* Function prototypes */
-STATIC int INIT huft_build OF((unsigned *, unsigned, unsigned, 
+STATIC int INIT huft_build OF((unsigned *, unsigned, unsigned,
 		const ush *, const ush *, struct huft **, int *));
 STATIC int INIT huft_free OF((struct huft *));
 STATIC int INIT inflate_codes OF((struct huft *, struct huft *, int, int));
@@ -193,7 +193,7 @@ static const ush cpdext[] = {         /* Extra bits for distance codes */
 
 /* Macros for inflate() bit peeking and grabbing.
    The usage is:
-   
+
         NEEDBITS(j)
         x = b & mask_bits[j];
         DUMPBITS(j)
@@ -374,7 +374,7 @@ DEBG("huft1 ");
   memzero(stk->c, sizeof(stk->c));
   p = b;  i = n;
   do {
-    Tracecv(*p, (stderr, (n-i >= ' ' && n-i <= '~' ? "%c %d\n" : "0x%x %d\n"), 
+    Tracecv(*p, (stderr, (n-i >= ' ' && n-i <= '~' ? "%c %d\n" : "0x%x %d\n"),
 	    n-i, *p));
     c[*p]++;                    /* assume all entries <= BMAX */
     p++;                      /* Can't combine with above line (Solaris bug) */
@@ -581,7 +581,7 @@ STATIC int INIT huft_free(
     q = (--p)->v.t;
     free((char*)p);
     p = q;
-  } 
+  }
   return 0;
 }
 
@@ -1139,7 +1139,7 @@ static ulg crc;		/* initialized in makecrc() so it'll reside in bss */
 #define CRC_VALUE (crc ^ 0xffffffffUL)
 
 /*
- * Code to compute the CRC-32 table. Borrowed from 
+ * Code to compute the CRC-32 table. Borrowed from
  * gzip-1.0.3/makecrc.c.
  */
 
@@ -1247,7 +1247,7 @@ static int INIT gunzip(void)
     if ((flags & ORIG_NAME) != 0) {
 	    /* Discard the old name */
 	    while (NEXTBYTE() != 0) /* null */ ;
-    } 
+    }
 
     /* Discard file comment if any */
     if ((flags & COMMENT) != 0) {
@@ -1276,7 +1276,7 @@ static int INIT gunzip(void)
 	    }
 	    return -1;
     }
-	    
+
     /* Get the crc and original length */
     /* crc32  (see algorithm.doc)
      * uncompressed input size modulo 2^32
@@ -1285,12 +1285,12 @@ static int INIT gunzip(void)
     orig_crc |= (ulg) NEXTBYTE() << 8;
     orig_crc |= (ulg) NEXTBYTE() << 16;
     orig_crc |= (ulg) NEXTBYTE() << 24;
-    
+
     orig_len = (ulg) NEXTBYTE();
     orig_len |= (ulg) NEXTBYTE() << 8;
     orig_len |= (ulg) NEXTBYTE() << 16;
     orig_len |= (ulg) NEXTBYTE() << 24;
-    
+
     /* Validate decompression */
     if (orig_crc != CRC_VALUE) {
 	    error("crc error");
-- 
2.25.1


