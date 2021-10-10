Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FD04283D5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 23:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhJJVey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 17:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232920AbhJJVeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 17:34:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACDCE610A4;
        Sun, 10 Oct 2021 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633901571;
        bh=EdTe58Z93d8p2+g9qWxuiL0mLrdMImIRJz89rzGB5nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmPJVWO5fxg9eagNTae2c6AagTqrP0etuWyFdEakN0BmyBdrtrdVvtjQ3rtW/Vd0+
         G2+yud6TCclWNpu8YBhwsgQyVfF7pCTU1hUgLo1CUHz+U3TAI2aUC+E6DfEJ8CZC2W
         cfBgcFNwmPnlx7y00En5CG7JG0QIR3zP2KUF52qrE9mmSOMS8ThNrXVhqMW75xa4Ix
         soDi4RsCr95lkCNTq+KIyVoBeK84wcVm0AiFo8N0CgwdO1zQN+2zp0f8DQKPShkTka
         IZFTQcP9K4bz9ileL5mLR3nYBVjvS6FvLaYvLEExiTX01Co6/6AJO43yf4IMgQtdOd
         2I2e3c87VFbUA==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Lasse Collin <lasse.collin@tukaani.org>, Chao Yu <chao@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6/7] erofs: rename some generic methods in decompressor
Date:   Mon, 11 Oct 2021 05:31:44 +0800
Message-Id: <20211010213145.17462-7-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010213145.17462-1-xiang@kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Previously, some LZ4 methods were named with `generic'. However, while
evaluating the effective LZMA approach, it seems they aren't quite
generic at all (e.g. no need preparing dstpages for most LZMA cases.)

Avoid such naming instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 65 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index a5bc4b1b7813..bceaa2b06b17 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -17,13 +17,8 @@
 #endif
 
 struct z_erofs_decompressor {
-	/*
-	 * if destpages have sparsed pages, fill them with bounce pages.
-	 * it also check whether destpages indicate continuous physical memory.
-	 */
-	int (*prepare_destpages)(struct z_erofs_decompress_req *rq,
-				 struct list_head *pagepool);
-	int (*decompress)(struct z_erofs_decompress_req *rq, u8 *out);
+	int (*decompress)(struct z_erofs_decompress_req *rq,
+			  struct list_head *pagepool);
 	char *name;
 };
 
@@ -63,8 +58,12 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 	return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
 }
 
-static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
-					 struct list_head *pagepool)
+/*
+ * Fill all gaps with bounce pages if it's a sparse page list. Also check if
+ * all physical pages are consecutive, which can be seen for moderate CR.
+ */
+static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
+					struct list_head *pagepool)
 {
 	const unsigned int nr =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -119,7 +118,7 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 	return kaddr ? 1 : 0;
 }
 
-static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
+static void *z_erofs_lz4_handle_inplace_io(struct z_erofs_decompress_req *rq,
 			void *inpage, unsigned int *inputmargin, int *maptype,
 			bool support_0padding)
 {
@@ -189,7 +188,8 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 	return src;
 }
 
-static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
+static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
+				      u8 *out)
 {
 	unsigned int inputmargin;
 	u8 *headpage, *src;
@@ -216,8 +216,8 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	}
 
 	rq->inputsize -= inputmargin;
-	src = z_erofs_handle_inplace_io(rq, headpage, &inputmargin, &maptype,
-					support_0padding);
+	src = z_erofs_lz4_handle_inplace_io(rq, headpage, &inputmargin,
+					    &maptype, support_0padding);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
@@ -257,17 +257,6 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	return ret;
 }
 
-static struct z_erofs_decompressor decompressors[] = {
-	[Z_EROFS_COMPRESSION_SHIFTED] = {
-		.name = "shifted"
-	},
-	[Z_EROFS_COMPRESSION_LZ4] = {
-		.prepare_destpages = z_erofs_lz4_prepare_destpages,
-		.decompress = z_erofs_lz4_decompress,
-		.name = "lz4"
-	},
-};
-
 static void copy_from_pcpubuf(struct page **out, const char *dst,
 			      unsigned short pageofs_out,
 			      unsigned int outputsize)
@@ -295,12 +284,11 @@ static void copy_from_pcpubuf(struct page **out, const char *dst,
 	}
 }
 
-static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
-				      struct list_head *pagepool)
+static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
+				  struct list_head *pagepool)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const struct z_erofs_decompressor *alg = decompressors + rq->alg;
 	unsigned int dst_maptype;
 	void *dst;
 	int ret;
@@ -325,7 +313,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 				return PTR_ERR(dst);
 
 			rq->inplace_io = false;
-			ret = alg->decompress(rq, dst);
+			ret = z_erofs_lz4_decompress_mem(rq, dst);
 			if (!ret)
 				copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
 						  rq->outputsize);
@@ -336,7 +324,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	}
 
 	/* general decoding path which can be used for all cases */
-	ret = alg->prepare_destpages(rq, pagepool);
+	ret = z_erofs_lz4_prepare_dstpages(rq, pagepool);
 	if (ret < 0)
 		return ret;
 	if (ret) {
@@ -351,7 +339,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	dst_maptype = 2;
 
 dstmap_out:
-	ret = alg->decompress(rq, dst + rq->pageofs_out);
+	ret = z_erofs_lz4_decompress_mem(rq, dst + rq->pageofs_out);
 
 	if (!dst_maptype)
 		kunmap_atomic(dst);
@@ -360,7 +348,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	return ret;
 }
 
-static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq,
+static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 				     struct list_head *pagepool)
 {
 	const unsigned int nrpages_out =
@@ -399,10 +387,19 @@ static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
+static struct z_erofs_decompressor decompressors[] = {
+	[Z_EROFS_COMPRESSION_SHIFTED] = {
+		.decompress = z_erofs_shifted_transform,
+		.name = "shifted"
+	},
+	[Z_EROFS_COMPRESSION_LZ4] = {
+		.decompress = z_erofs_lz4_decompress,
+		.name = "lz4"
+	},
+};
+
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct list_head *pagepool)
 {
-	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
-		return z_erofs_shifted_transform(rq, pagepool);
-	return z_erofs_decompress_generic(rq, pagepool);
+	return decompressors[rq->alg].decompress(rq, pagepool);
 }
-- 
2.20.1

