Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE63327C34
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhCAKbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:31:52 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54447 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234251AbhCAKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:31:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UPyvTva_1614594646;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPyvTva_1614594646)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Mar 2021 18:30:46 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     clabbe.montjoie@gmail.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] crypto: sun8i-ce: rename kfree() to kfree_sensitive()
Date:   Mon,  1 Mar 2021 18:30:41 +0800
Message-Id: <1614594641-35606-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename kfree() to kfree_sensitive() to  make the intention of the API
more explicit.

fixed the following coccicheck:
./drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c:30:16-17: WARNING
opportunity for kfree_sensitive/kvfree_sensitive (memset at line 29)
./drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c:42:16-17: WARNING
opportunity for kfree_sensitive/kvfree_sensitive (memset at line 41)
./drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c:161:8-9: WARNING
opportunity for kfree_sensitive/kvfree_sensitive (memset at line 109)

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
index cfde9ee..8259d52 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
@@ -27,7 +27,7 @@ void sun8i_ce_prng_exit(struct crypto_tfm *tfm)
 	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	memzero_explicit(ctx->seed, ctx->slen);
-	kfree(ctx->seed);
+	kfree_sensitive(ctx->seed);
 	ctx->seed = NULL;
 	ctx->slen = 0;
 }
@@ -39,7 +39,7 @@ int sun8i_ce_prng_seed(struct crypto_rng *tfm, const u8 *seed,
 
 	if (ctx->seed && ctx->slen != slen) {
 		memzero_explicit(ctx->seed, ctx->slen);
-		kfree(ctx->seed);
+		kfree_sensitive(ctx->seed);
 		ctx->slen = 0;
 		ctx->seed = NULL;
 	}
@@ -158,7 +158,7 @@ int sun8i_ce_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	}
 	memzero_explicit(d, todo);
 err_iv:
-	kfree(d);
+	kfree_sensitive(d);
 err_mem:
 	return err;
 }
-- 
1.8.3.1

