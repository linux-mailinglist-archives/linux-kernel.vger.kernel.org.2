Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB50842D31C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhJNHAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhJNHAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:00:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67D5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:58:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d23so4629075pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90F5GgkLIzukAhvTUV+3ZzegFo7c/yVw23FmmmyLKiI=;
        b=VU9jibIQXVcmVaH2SOhkP9l3k7zUgV40ftobar8AZgoRHL4i3UJXHNLih5Y0wEX3La
         lYS8avExv0xbWA5SrMeAETDEr1/hPMajlBL7GHqb9f1sx0f42q1OhnPKGjP080R4jPVW
         GVoiZOrRy6joTosLhQiGMdmmWo5ZCE8xbcnerORU7GCtgWCwz9YXm5Z54txP03fOe27x
         GZ+MXyhFOc2U5Cy2PoptgW/LTLeVjVOXBz64/o2Q6HnOH+1maFMn2kuMMcuNgymcSjA+
         OVc4PQ8C5Vcr9OYSq/2gZwZgNO7RLsd9SPvvPD+rvkx/C1ChUkW1QBOuaJOTyoFFCk0O
         91Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90F5GgkLIzukAhvTUV+3ZzegFo7c/yVw23FmmmyLKiI=;
        b=n1HkY5ec5U+twMvedF+b2tS/chbkeVJ346jIMzuWa2BN2zM9WEHuI8wAbfvX/1byF4
         wsvrDGQMV1ysSEIalbsetOSFxG4ohiGv7fD5+6WlXJ0EX/C5+929oIYqa65XUtr6CBMi
         akxVS4pp/a0EtaQGv4aKFtuDrY4J0b197DiRkco7x43g+qTNG0erPd8m6PhoAFdVCM9S
         zTTuOXcRedjkFUcWHGfKujFebXH2+RSGC6NvhyxoMdUDFnXzRtqWRtdtJu+pWk/fuV/j
         5WiBh2eehLukO7vH7MjMaK2cGNSeoh1p/FgTsgCSnLcUPO5oARyPmPg9VB0H6WcGA0w0
         PIJQ==
X-Gm-Message-State: AOAM530y9T1wbNspx+bnEYpENlUHidlQ4wYaFPF4xpUiaF3DEs2xzR0p
        JnHSgvyDh27qAE2OV7484Mg=
X-Google-Smtp-Source: ABdhPJz4a95eMFhV5Mp4XkSq67jFVy4DJT0e8XpQWvj/20b+JQrbT4+Tu7tKhWRnxNmdNhhpgcb8Aw==
X-Received: by 2002:a65:6398:: with SMTP id h24mr2919614pgv.367.1634194691474;
        Wed, 13 Oct 2021 23:58:11 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id p9sm1670864pfh.162.2021.10.13.23.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 23:58:10 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com,
        zhangwen@yulong.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3] erofs: remove the fast path of per-CPU buffer decompression
Date:   Thu, 14 Oct 2021 14:57:44 +0800
Message-Id: <20211014065744.1787-1-zbestahu@gmail.com>
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

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: just set ret = 0 in else branch and rearrange if statement into one line.
v3: "paths" -> "path", recover missing message words in v2.

 fs/erofs/decompressor.c | 63 +++++++------------------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 88e33ad..a8a4e3d 100644
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
+	/* one optimized fast path only for non bigpcluster cases yet */
+	if (rq->inputsize <= PAGE_SIZE && nrpages_out == 1 && !rq->inplace_io) {
+		DBG_BUGON(!*rq->out);
+		dst = kmap_atomic(*rq->out);
+		dst_maptype = 0;
+		goto dstmap_out;
 	}
 
 	/* general decoding path which can be used for all cases */
-- 
1.9.1

