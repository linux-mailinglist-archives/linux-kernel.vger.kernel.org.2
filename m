Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5173839EF44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFHHNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:13:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8074 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFHHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:13:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzhDJ0SnBzYrdD;
        Tue,  8 Jun 2021 15:08:48 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:37 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:36 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/5] lib/zlib: remove trailing spaces and tabs
Date:   Tue, 8 Jun 2021 15:11:13 +0800
Message-ID: <20210608071117.12634-2-thunder.leizhen@huawei.com>
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

find lib/zlib*/ -type f | xargs sed -r -i 's/[ \t]+$//'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/zlib_deflate/deflate.c      | 10 +++++-----
 lib/zlib_deflate/deftree.c      |  4 ++--
 lib/zlib_deflate/defutil.h      | 10 +++++-----
 lib/zlib_inflate/inflate_syms.c |  2 +-
 lib/zlib_inflate/infutil.h      |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/zlib_deflate/deflate.c b/lib/zlib_deflate/deflate.c
index 3fa66fc7fbd7..d7397366edea 100644
--- a/lib/zlib_deflate/deflate.c
+++ b/lib/zlib_deflate/deflate.c
@@ -1,7 +1,7 @@
 /* +++ deflate.c */
 /* deflate.c -- compress data using the deflation algorithm
  * Copyright (C) 1995-1996 Jean-loup Gailly.
- * For conditions of distribution and use, see copyright notice in zlib.h 
+ * For conditions of distribution and use, see copyright notice in zlib.h
  */
 
 /*
@@ -284,7 +284,7 @@ int zlib_deflateReset(
 )
 {
     deflate_state *s;
-    
+
     if (strm == NULL || strm->state == NULL)
         return Z_STREAM_ERROR;
 
@@ -323,7 +323,7 @@ static void putShortMSB(
 {
     put_byte(s, (Byte)(b >> 8));
     put_byte(s, (Byte)(b & 0xff));
-}   
+}
 
 /* ========================================================================= */
 int zlib_deflate(
@@ -976,7 +976,7 @@ static block_state deflate_fast(
                      * always MIN_MATCH bytes ahead.
                      */
                 } while (--s->match_length != 0);
-                s->strstart++; 
+                s->strstart++;
             } else {
                 s->strstart += s->match_length;
                 s->match_length = 0;
@@ -994,7 +994,7 @@ static block_state deflate_fast(
             Tracevv((stderr,"%c", s->window[s->strstart]));
             bflush = zlib_tr_tally (s, 0, s->window[s->strstart]);
             s->lookahead--;
-            s->strstart++; 
+            s->strstart++;
         }
         if (bflush) FLUSH_BLOCK(s, 0);
     }
diff --git a/lib/zlib_deflate/deftree.c b/lib/zlib_deflate/deftree.c
index a4a34da512fe..31b18220fef7 100644
--- a/lib/zlib_deflate/deftree.c
+++ b/lib/zlib_deflate/deftree.c
@@ -1,7 +1,7 @@
 /* +++ trees.c */
 /* trees.c -- output deflated data using Huffman coding
  * Copyright (C) 1995-1996 Jean-loup Gailly
- * For conditions of distribution and use, see copyright notice in zlib.h 
+ * For conditions of distribution and use, see copyright notice in zlib.h
  */
 
 /*
@@ -1043,7 +1043,7 @@ static void copy_block(
     s->last_eob_len = 8; /* enough lookahead for inflate */
 
     if (header) {
-        put_short(s, (ush)len);   
+        put_short(s, (ush)len);
         put_short(s, (ush)~len);
 #ifdef DEBUG_ZLIB
         s->bits_sent += 2*16;
diff --git a/lib/zlib_deflate/defutil.h b/lib/zlib_deflate/defutil.h
index 385333b22ec6..c33cec1b38db 100644
--- a/lib/zlib_deflate/defutil.h
+++ b/lib/zlib_deflate/defutil.h
@@ -3,11 +3,11 @@
 
 #include <linux/zutil.h>
 
-#define Assert(err, str) 
-#define Trace(dummy) 
-#define Tracev(dummy) 
-#define Tracecv(err, dummy) 
-#define Tracevv(dummy) 
+#define Assert(err, str)
+#define Trace(dummy)
+#define Tracev(dummy)
+#define Tracecv(err, dummy)
+#define Tracevv(dummy)
 
 
 
diff --git a/lib/zlib_inflate/inflate_syms.c b/lib/zlib_inflate/inflate_syms.c
index 9720114c0672..31b435f28b73 100644
--- a/lib/zlib_inflate/inflate_syms.c
+++ b/lib/zlib_inflate/inflate_syms.c
@@ -16,6 +16,6 @@ EXPORT_SYMBOL(zlib_inflate);
 EXPORT_SYMBOL(zlib_inflateInit2);
 EXPORT_SYMBOL(zlib_inflateEnd);
 EXPORT_SYMBOL(zlib_inflateReset);
-EXPORT_SYMBOL(zlib_inflateIncomp); 
+EXPORT_SYMBOL(zlib_inflateIncomp);
 EXPORT_SYMBOL(zlib_inflate_blob);
 MODULE_LICENSE("GPL");
diff --git a/lib/zlib_inflate/infutil.h b/lib/zlib_inflate/infutil.h
index 784ab33b7842..22b927c4122d 100644
--- a/lib/zlib_inflate/infutil.h
+++ b/lib/zlib_inflate/infutil.h
@@ -1,6 +1,6 @@
 /* infutil.h -- types and macros common to blocks and codes
  * Copyright (C) 1995-1998 Mark Adler
- * For conditions of distribution and use, see copyright notice in zlib.h 
+ * For conditions of distribution and use, see copyright notice in zlib.h
  */
 
 /* WARNING: this file should *not* be used by applications. It is
-- 
2.25.1


