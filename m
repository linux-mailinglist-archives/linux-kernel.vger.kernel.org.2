Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B9E39B562
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhFDI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:59:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3428 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhFDI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:59:04 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FxGls2F9Rz6vG1;
        Fri,  4 Jun 2021 16:54:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 16:57:10 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 16:57:09 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jiri Kosina <jkosina@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] lib/decompressors: Fix spelling mistakes
Date:   Fri, 4 Jun 2021 16:56:56 +0800
Message-ID: <20210604085656.12257-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some spelling mistakes in comments:
sentinal ==> sentinel
compresed ==> compressed
dependeny ==> dependency
immediatelly ==> immediately
dervied ==> derived
splitted ==> split
nore ==> not
independed ==> independent
asumed ==> assumed

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/decompress_bunzip2.c   | 4 ++--
 lib/decompress_unxz.c      | 2 +-
 lib/decompress_unzstd.c    | 4 ++--
 lib/xz/xz_dec_bcj.c        | 2 +-
 lib/xz/xz_dec_lzma2.c      | 8 ++++----
 lib/zlib_inflate/inffast.c | 2 +-
 lib/zstd/huf.h             | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/decompress_bunzip2.c b/lib/decompress_bunzip2.c
index 0d619cc129dd..3518e7394eca 100644
--- a/lib/decompress_bunzip2.c
+++ b/lib/decompress_bunzip2.c
@@ -80,7 +80,7 @@
 
 /* This is what we know about each Huffman coding group */
 struct group_data {
-	/* We have an extra slot at the end of limit[] for a sentinal value. */
+	/* We have an extra slot at the end of limit[] for a sentinel value. */
 	int limit[MAX_HUFCODE_BITS+1];
 	int base[MAX_HUFCODE_BITS];
 	int permute[MAX_SYMBOLS];
@@ -337,7 +337,7 @@ static int INIT get_next_block(struct bunzip_data *bd)
 			pp <<= 1;
 			base[i+1] = pp-(t += temp[i]);
 		}
-		limit[maxLen+1] = INT_MAX; /* Sentinal value for
+		limit[maxLen+1] = INT_MAX; /* Sentinel value for
 					    * reading next sym. */
 		limit[maxLen] = pp+temp[maxLen]-1;
 		base[minLen] = 0;
diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 25d59a95bd66..a2f38e23004a 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -23,7 +23,7 @@
  * uncompressible. Thus, we must look for worst-case expansion when the
  * compressor is encoding uncompressible data.
  *
- * The structure of the .xz file in case of a compresed kernel is as follows.
+ * The structure of the .xz file in case of a compressed kernel is as follows.
  * Sizes (as bytes) of the fields are in parenthesis.
  *
  *    Stream Header (12)
diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index 790abc472f5b..6b629ab31c1e 100644
--- a/lib/decompress_unzstd.c
+++ b/lib/decompress_unzstd.c
@@ -16,7 +16,7 @@
  * uncompressible. Thus, we must look for worst-case expansion when the
  * compressor is encoding uncompressible data.
  *
- * The structure of the .zst file in case of a compresed kernel is as follows.
+ * The structure of the .zst file in case of a compressed kernel is as follows.
  * Maximum sizes (as bytes) of the fields are in parenthesis.
  *
  *    Frame Header: (18)
@@ -56,7 +56,7 @@
 /*
  * Preboot environments #include "path/to/decompress_unzstd.c".
  * All of the source files we depend on must be #included.
- * zstd's only source dependeny is xxhash, which has no source
+ * zstd's only source dependency is xxhash, which has no source
  * dependencies.
  *
  * When UNZSTD_PREBOOT is defined we declare __decompress(), which is
diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
index 72ddac6ef2ec..ef449e97d1a1 100644
--- a/lib/xz/xz_dec_bcj.c
+++ b/lib/xz/xz_dec_bcj.c
@@ -422,7 +422,7 @@ XZ_EXTERN enum xz_ret xz_dec_bcj_run(struct xz_dec_bcj *s,
 
 	/*
 	 * Flush pending already filtered data to the output buffer. Return
-	 * immediatelly if we couldn't flush everything, or if the next
+	 * immediately if we couldn't flush everything, or if the next
 	 * filter in the chain had already returned XZ_STREAM_END.
 	 */
 	if (s->temp.filtered > 0) {
diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index ca2603abee08..7a6781e3f47b 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -147,8 +147,8 @@ struct lzma_dec {
 
 	/*
 	 * LZMA properties or related bit masks (number of literal
-	 * context bits, a mask dervied from the number of literal
-	 * position bits, and a mask dervied from the number
+	 * context bits, a mask derived from the number of literal
+	 * position bits, and a mask derived from the number
 	 * position bits)
 	 */
 	uint32_t lc;
@@ -484,7 +484,7 @@ static __always_inline void rc_normalize(struct rc_dec *rc)
 }
 
 /*
- * Decode one bit. In some versions, this function has been splitted in three
+ * Decode one bit. In some versions, this function has been split in three
  * functions so that the compiler is supposed to be able to more easily avoid
  * an extra branch. In this particular version of the LZMA decoder, this
  * doesn't seem to be a good idea (tested with GCC 3.3.6, 3.4.6, and 4.3.3
@@ -761,7 +761,7 @@ static bool lzma_main(struct xz_dec_lzma2 *s)
 }
 
 /*
- * Reset the LZMA decoder and range decoder state. Dictionary is nore reset
+ * Reset the LZMA decoder and range decoder state. Dictionary is not reset
  * here, because LZMA state may be reset without resetting the dictionary.
  */
 static void lzma_reset(struct xz_dec_lzma2 *s)
diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index ed1f3df27260..f19c4fbe1be7 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -15,7 +15,7 @@ union uu {
 	unsigned char b[2];
 };
 
-/* Endian independed version */
+/* Endian independent version */
 static inline unsigned short
 get_unaligned16(const unsigned short *p)
 {
diff --git a/lib/zstd/huf.h b/lib/zstd/huf.h
index 2143da28d952..923218d12e28 100644
--- a/lib/zstd/huf.h
+++ b/lib/zstd/huf.h
@@ -134,7 +134,7 @@ typedef enum {
 	HUF_repeat_none,  /**< Cannot use the previous table */
 	HUF_repeat_check, /**< Can use the previous table but it must be checked. Note : The previous table must have been constructed by HUF_compress{1,
 			     4}X_repeat */
-	HUF_repeat_valid  /**< Can use the previous table and it is asumed to be valid */
+	HUF_repeat_valid  /**< Can use the previous table and it is assumed to be valid */
 } HUF_repeat;
 /** HUF_compress4X_repeat() :
 *   Same as HUF_compress4X_wksp(), but considers using hufTable if *repeat != HUF_repeat_none.
-- 
2.25.1


