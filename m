Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F219A3DEE65
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhHCM6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:58:04 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:38622 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235895AbhHCM6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:58:02 -0400
X-QQ-mid: bizesmtp37t1627995332t0z35aya
Received: from localhost.localdomain (unknown [125.69.40.136])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 03 Aug 2021 20:55:30 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: FsG0r2mBeltZwXHsnSFyQIVXmyMoeC5BD2c5iGCpiLDw2FB21T+BluHr2+WdJ
        oph6RdKQTsSFUCzmZUnpNtkvp7eRJJ7u4igpOBS3y1HdKXXsaVO7JQf5TGooeEoSctgHhA8
        OXl9EoQ04EBtRvwL3HqP+UCbpDMWLeVkuWP3fiXqES3NnB44Hyo5mQ1OoJemMhdsRwVPFxE
        Qn3LIQsc1dHzAB5VHQ7o+h4EE1wdh7/PGW+rcJmy8JOO3AagTdn8xhSW26L620rIClOA0LB
        JmUxJ0S/Cx2RsqipiQbq1yD67gbfWKBZTBJy0J4LL1wFz+stATLDWWpOxFfU/SGyz+ZJYmL
        k/6kLXzErmCrW71M+Y=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     herbert@gondor.apana.org.au
Cc:     clabbe.montjoie@gmail.com, davem@davemloft.net, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, wangborong@cdjrlc.com,
        mchehab+huawei@kernel.org, corbet@lwn.net, baijiaju1990@gmail.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: sun8i-ce - use kfree_sensitive to clear and free sensitive data
Date:   Tue,  3 Aug 2021 20:55:25 +0800
Message-Id: <20210803125525.72603-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kfree_sensitive is a kernel API to clear sensitive information
that should not be leaked to other future users of the same memory
objects and free the memory. Its function is the same as the
combination  of memzero_explicit and kfree. Thus, we can replace the
combination APIs with the single kfree_sensitive API.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 9 +++------
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c | 3 +--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
index cd1baee424a1..b3a9bbfb8831 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
@@ -26,8 +26,7 @@ void sun8i_ce_prng_exit(struct crypto_tfm *tfm)
 {
 	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	memzero_explicit(ctx->seed, ctx->slen);
-	kfree(ctx->seed);
+	kfree_sensitive(ctx->seed);
 	ctx->seed = NULL;
 	ctx->slen = 0;
 }
@@ -38,8 +37,7 @@ int sun8i_ce_prng_seed(struct crypto_rng *tfm, const u8 *seed,
 	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_rng_ctx(tfm);
 
 	if (ctx->seed && ctx->slen != slen) {
-		memzero_explicit(ctx->seed, ctx->slen);
-		kfree(ctx->seed);
+		kfree_sensitive(ctx->seed);
 		ctx->slen = 0;
 		ctx->seed = NULL;
 	}
@@ -157,9 +155,8 @@ int sun8i_ce_prng_generate(struct crypto_rng *tfm, const u8 *src,
 		memcpy(dst, d, dlen);
 		memcpy(ctx->seed, d + dlen, ctx->slen);
 	}
-	memzero_explicit(d, todo);
 err_iv:
-	kfree(d);
+	kfree_sensitive(d);
 err_mem:
 	return err;
 }
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
index 5b7af4498bd5..19cd2e52f89d 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
@@ -95,9 +95,8 @@ static int sun8i_ce_trng_read(struct hwrng *rng, void *data, size_t max, bool wa
 		memcpy(data, d, max);
 		err = max;
 	}
-	memzero_explicit(d, todo);
 err_dst:
-	kfree(d);
+	kfree_sensitive(d);
 	return err;
 }
 
-- 
2.32.0

