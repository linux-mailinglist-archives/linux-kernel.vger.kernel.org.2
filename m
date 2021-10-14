Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E422042D211
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 07:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhJNGBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhJNGBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:01:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C24C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 22:59:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so6162162pjw.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 22:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6RUPW2Adv9jzR1Z8rYigTRUGThIFrNbP7qQXF9NsjQ=;
        b=iahSOQo8wGJpY4BfssZefsKFFZ4KO0NEBdjjudsRBPj7m/h2Wi0JzcoFvfCVe+3mwt
         0whZicdiNv6tRb8uxKbE9YhW4L24L+gVTNXGZbNI3TQ6PpO+EY/xgHMWx+s9lwp+0W+/
         cmT4U23EPswcEAwwsjWfx/VuSjQYUssnwBbep4jhVazo1/zdmsw7j5J2xRiuG+DcLSph
         YQ3wkKianz+3BkvujbecXPg0OF0k+TLr+trlwyi17wOZvWkOflihvAtVtz2Yyrw9EvXa
         b6UhM8D79HsDh8omA4uzZJcqF98v63MymREUwMt8Pb+YQbKYptgfZeg8ptxABmDXACnI
         n+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6RUPW2Adv9jzR1Z8rYigTRUGThIFrNbP7qQXF9NsjQ=;
        b=Ur0/CAOdHjcBr75KsMZHSutJ9OUkzryTYFcSmF/rSJZq29/fKRGDVDPBwsZ6Lg7Ky+
         148VyfYYJrQ1S7nCdwqWTbZVyJd5cB/zkIXvD0EmtGPsruilw8NRw02NDAwngCRtBCV9
         Wm80+aWuyi+xnTCtr1hXSWWKFyfXFfeP8mW6jCwNCuE+wz21SPpQ0UuHe70rgWoRsgDN
         qoHfxYn9DZakGUVPTfXeOmgLHFiIEE9TZrYlIz5f8iabadl5PlVZnl3oRMuSHwyXoujd
         yn4osmwJbcqWLsoHtuk0XzFWAsehyWFxp0y93NDKbSNsRF/Z028uZsXKhnRgZLY6q389
         aDJg==
X-Gm-Message-State: AOAM532OgGzODVB5FuMBQRpPGtLsK5Dc2Dy2ztVaVyNBt4qtKo891fuR
        PPoNJ9RMcxsJuHiFoCEbJs0p975qpU2EQQ==
X-Google-Smtp-Source: ABdhPJxM3XnN87SlkVpWim8Pcgp2SWIuw+2iN4uRRup0PfoT4CVJcH6/4aItGkbeAFgkY7KKqbB1bA==
X-Received: by 2002:a17:902:ce86:b0:13f:16c5:c666 with SMTP id f6-20020a170902ce8600b0013f16c5c666mr3380738plg.88.1634191180056;
        Wed, 13 Oct 2021 22:59:40 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id v20sm1295670pff.171.2021.10.13.22.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 22:59:39 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com,
        zhangwen@yulong.com
Subject: [PATCH] erofs: remove the fast path of per-CPU buffer decompression
Date:   Thu, 14 Oct 2021 13:57:56 +0800
Message-Id: <20211014055756.1549-1-zbestahu@gmail.com>
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
with LZMA which will return 0 as well for that case.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/decompressor.c | 64 +++++++------------------------------------------
 1 file changed, 8 insertions(+), 56 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index a5bc4b1..9905551 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -254,7 +254,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		DBG_BUGON(1);
 		return -EFAULT;
 	}
-	return ret;
+	return ret > 0 ? 0 : ret;
 }
 
 static struct z_erofs_decompressor decompressors[] = {
@@ -268,33 +268,6 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
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
@@ -305,34 +278,13 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
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
+	/* one optimized fast path only for non bigpcluster cases yet */
+	if (rq->inputsize <= PAGE_SIZE &&
+	    nrpages_out == 1 && !rq->inplace_io) {
+		DBG_BUGON(!*rq->out);
+		dst = kmap_atomic(*rq->out);
+		dst_maptype = 0;
+		goto dstmap_out;
 	}
 
 	/* general decoding path which can be used for all cases */
-- 
1.9.1

