Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3242D2D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhJNGlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhJNGll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:41:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F9CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:39:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x8so3455934plv.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aIVKuzI3Dv4Fcy3CYcnfW1yxN1O0fSYPq2cnv41BVc=;
        b=OLjdXKseZ4gUQA2hQBRzUhGG3G+56UxGwcrZcGluEj/0YCeqmIVE0IBiFJRkHVWxSJ
         RNI37/6aOy4iP2yNZpdwj9CWW3/nkemdqltxSdkZy85G+L/VIzsWDIZwxYOLVd2S34vl
         tbUqQUoeoxTxMN9FQN9WbWnM4PyIeKaY7gZLK8CPiyv4QFSfM/DiZeUmbs2tGThaLi77
         lw/zojoxajtzaj9zPVnZostHmWW9O4x+G5gKQRuOggyB/ceSO68Te+s2Zr+1qmGf1j31
         jaSeXc52dLiyEGFAtBmZdc0HIrAaquU+ckB3PRA053ZOxWoPZCxluLqxPgCOIjwswDL5
         4Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aIVKuzI3Dv4Fcy3CYcnfW1yxN1O0fSYPq2cnv41BVc=;
        b=QXEaLOhhfDZG5WBxwMTQQxLRFFggtx9lYLuyTGQ8fuvIUu3BT2xmJkpTmw6ng+ns1r
         RXzETJ9O+yA/G3qOrObgagNSHiTHPrRed3ZwAkAv3ypnxXALe+cc8Kcz0IKv6bkpvMNs
         7GY4cxoKsNyKL2nEQICHSYV3eZVW3xnGbfSsSwOAS2K6jX+kIJpodK0kQ62btUhh+JSM
         CuHKcHqwmphVxJnYuMWlPaJNnqgCrM6BdG6jz0oT5kULO5myzno2Ee/v/FmdjZ52gzkC
         TYJettYhqYnnbDno7do24v65jHjzY4wEvyFqhBJCFMQ6NecOzdyDNfb4FRLqZVttB1Fv
         CYvA==
X-Gm-Message-State: AOAM530StZS1/C1F8ETKtG2brg5FH7Jr5VOtgDbMWAYzzpDlZ7kvhukn
        QwtbYJzMAEjY4PdOHhqSjKs+Fy1qBGWOUA==
X-Google-Smtp-Source: ABdhPJz3cyaTYA44BcyCgjvDwXXLh4LSF9kdIIliUC16vy216WP3a1lkOAgQDc0pAE++tC55yUrUGQ==
X-Received: by 2002:a17:90b:4c86:: with SMTP id my6mr4293450pjb.203.1634193576416;
        Wed, 13 Oct 2021 23:39:36 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id p2sm1412887pgd.84.2021.10.13.23.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 23:39:35 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com,
        zhangwen@yulong.com
Subject: [PATCH v2] erofs: remove the fast path of per-CPU buffer decompression
Date:   Thu, 14 Oct 2021 14:39:01 +0800
Message-Id: <20211014063901.1629-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

As Xiang mentioned, such path has no real impact to our current
decompression strategy, remove it directly. Also, update the return
value of z_erofs_lz4_decompress() to 0 if success to keep consistent
with LZMA which will return 0 for that case.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: just set ret = 0 in else branch and rearrange if statement into one line.

 fs/erofs/decompressor.c | 63 +++++++------------------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 88e33ad..f8a372e 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -243,6 +243,8 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);
 		ret = -EIO;
+	} else {
+		ret = 0;
 	}
 
 	if (maptype == 0) {
@@ -269,33 +271,6 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	},
 };
 
-static void copy_from_pcpubuf(struct page **out, const char *dst,
-			      unsigned short pageofs_out,
-			      unsigned int outputsize)
-{
-	const char *end = dst + outputsize;
-	const unsigned int righthalf = PAGE_SIZE - pageofs_out;
-	const char *cur = dst - pageofs_out;
-
-	while (cur < end) {
-		struct page *const page = *out++;
-
-		if (page) {
-			char *buf = kmap_atomic(page);
-
-			if (cur >= dst) {
-				memcpy(buf, cur, min_t(uint, PAGE_SIZE,
-						       end - cur));
-			} else {
-				memcpy(buf + pageofs_out, cur + pageofs_out,
-				       min_t(uint, righthalf, end - cur));
-			}
-			kunmap_atomic(buf);
-		}
-		cur += PAGE_SIZE;
-	}
-}
-
 static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 				      struct list_head *pagepool)
 {
@@ -306,34 +281,12 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	void *dst;
 	int ret;
 
-	/* two optimized fast paths only for non bigpcluster cases yet */
-	if (rq->inputsize <= PAGE_SIZE) {
-		if (nrpages_out == 1 && !rq->inplace_io) {
-			DBG_BUGON(!*rq->out);
-			dst = kmap_atomic(*rq->out);
-			dst_maptype = 0;
-			goto dstmap_out;
-		}
-
-		/*
-		 * For the case of small output size (especially much less
-		 * than PAGE_SIZE), memcpy the decompressed data rather than
-		 * compressed data is preferred.
-		 */
-		if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
-			dst = erofs_get_pcpubuf(1);
-			if (IS_ERR(dst))
-				return PTR_ERR(dst);
-
-			rq->inplace_io = false;
-			ret = alg->decompress(rq, dst);
-			if (!ret)
-				copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
-						  rq->outputsize);
-
-			erofs_put_pcpubuf(dst);
-			return ret;
-		}
+	/* one optimized fast paths only for non bigpcluster cases yet */
+	if (rq->inputsize <= PAGE_SIZE && nrpages_out == 1 && !rq->inplace_io) {
+		DBG_BUGON(!*rq->out);
+		dst = kmap_atomic(*rq->out);
+		dst_maptype = 0;
+		goto dstmap_out;
 	}
 
 	/* general decoding path which can be used for all cases */
-- 
1.9.1

