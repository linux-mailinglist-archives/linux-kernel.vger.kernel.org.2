Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA57374955
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhEEU1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhEEU1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6914C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:26:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s8so3208282wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CgrHm6Q90zjDRy0KRwh+JENVRSFDVxbeIMRBWZ7YN/A=;
        b=rqDNGo7A6N3zbpzj1Qdw0DbYSYpZLOEglDtMw0CcUfdBTgjCF7erUBAvHYAnUXYifz
         3v63Kpgu/LyAGmtm2iKVY+nsDcZDABPADDqEpA6NgHKsAb+bSp5jGCxcT6tPkJ22ij5g
         0mCCRg20lonItxaM3F9XzdzacwL1MxO5RnKxTBlFdsIhL4BH4DPr2xt/RN4o7dvZiDat
         mZYz8WO2ztQSRhBZ1XqFTv8tKuxvqXz+NJT+XT5ze7II38KdOdj3HgMQPxSg8gySUg9Y
         a0QXivhHuatbgEOucqOA+rY8gAfDnEK0kM7ahJjN3FesaUJzudcsZL1DC2z+NSuewSsF
         G3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CgrHm6Q90zjDRy0KRwh+JENVRSFDVxbeIMRBWZ7YN/A=;
        b=ZJ4+Bn8pvrx19BbmSHwjbye+Uo2jHYfLbQ1knBVXxINjpNs7/RiUTYQXFrWLq4lzkY
         m960Z5leUhTHdA2AEv2T4ZgMQFJpgqOi/ZsWyfSumQyLb+I0aKsZgt6D0brt1bHJTgAF
         diZZiWsPW3CP4ymsjxEPxgE8zyYvkD1lUdMXL37BVXjv6KYAqecm3WQUVAZdmqPA/lXB
         7lyCOPndSdkqwJoEC9wiMcARs8kf00v/kBvjYoOWMNoq4OQGPPBT6GI02WFU1gKKcerG
         IoRpyxTLlRXf/TfRW2RTZBHpvfpz6mh3+zOR89c+abJv4FDk6jIYEPE70tZQ77ar0Bz9
         pTnA==
X-Gm-Message-State: AOAM531zIbh/1Q4CGgBwfvZqJqrXOlq8mEYieheyMnN5bHj1V4Y7vPNK
        Th19yfdLn+1L3B41itlWZzDJrA==
X-Google-Smtp-Source: ABdhPJyxRKuwmCU24zeemGcj/kmbc/ZFilTchkkJpzY6NwsyHgMGqngG8eTPbcoVfGqIDm62McaULQ==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr867886wre.183.1620246387606;
        Wed, 05 May 2021 13:26:27 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a15sm497245wrr.53.2021.05.05.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:26:27 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     chohnstaedt@innominate.com, davem@davemloft.net,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 03/11] crypto: ixp4xx: fallback when having more than one SG
Date:   Wed,  5 May 2021 20:26:10 +0000
Message-Id: <20210505202618.2663889-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505202618.2663889-1-clabbe@baylibre.com>
References: <20210505202618.2663889-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing ixp4xx_crypto lead to:
alg: skcipher: ecb(des)-ixp4xx encryption overran dst buffer on test vector 0, cfg="two even aligned splits"

The HW overwrites destination always when sg_nents() > 1.
The problem seems that the HW always write areq->cryptlen bytes on the
last SG.
A comment in driver's code seems to give a clue that multiple SG was not
planned "This was never tested by Intel for more than one dst buffer, I think".
So let's add a fallback for this situation.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/Kconfig         |  5 +++
 drivers/crypto/ixp4xx_crypto.c | 56 ++++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 11487ac526ff..9dbed5e2e8a5 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -344,6 +344,11 @@ config CRYPTO_DEV_TALITOS2
 config CRYPTO_DEV_IXP4XX
 	tristate "Driver for IXP4xx crypto hardware acceleration"
 	depends on ARCH_IXP4XX && IXP4XX_QMGR && IXP4XX_NPE
+	select CRYPTO_AES
+	select CRYPTO_DES
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	select CRYPTO_CTR
 	select CRYPTO_LIB_DES
 	select CRYPTO_AEAD
 	select CRYPTO_AUTHENC
diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/ixp4xx_crypto.c
index f577ee4afd06..8bbf2ead6e79 100644
--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -151,6 +151,7 @@ struct ablk_ctx {
 	struct buffer_desc *dst;
 	u8 iv[MAX_IVLEN];
 	bool encrypt;
+	struct skcipher_request fallback_req;   // keep at the end
 };
 
 struct aead_ctx {
@@ -186,6 +187,7 @@ struct ixp_ctx {
 	unsigned salted;
 	atomic_t configuring;
 	struct completion completion;
+	struct crypto_skcipher *fallback_tfm;
 };
 
 struct ixp_alg {
@@ -590,7 +592,23 @@ static int init_tfm(struct crypto_tfm *tfm)
 
 static int init_tfm_ablk(struct crypto_skcipher *tfm)
 {
-	crypto_skcipher_set_reqsize(tfm, sizeof(struct ablk_ctx));
+	struct crypto_tfm *ctfm = crypto_skcipher_tfm(tfm);
+	struct ixp_ctx *ctx = crypto_tfm_ctx(ctfm);
+	const char *name = crypto_tfm_alg_name(ctfm);
+
+	ctx->fallback_tfm = crypto_alloc_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->fallback_tfm)) {
+		pr_err("ERROR: Cannot allocate fallback for %s %ld\n",
+			name, PTR_ERR(ctx->fallback_tfm));
+		return PTR_ERR(ctx->fallback_tfm);
+	}
+
+	pr_info("Fallback for %s is %s\n",
+		 crypto_tfm_alg_driver_name(&tfm->base),
+		 crypto_tfm_alg_driver_name(crypto_skcipher_tfm(ctx->fallback_tfm))
+		 );
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct ablk_ctx) + crypto_skcipher_reqsize(ctx->fallback_tfm));
 	return init_tfm(crypto_skcipher_tfm(tfm));
 }
 
@@ -609,6 +627,10 @@ static void exit_tfm(struct crypto_tfm *tfm)
 
 static void exit_tfm_ablk(struct crypto_skcipher *tfm)
 {
+	struct crypto_tfm *ctfm = crypto_skcipher_tfm(tfm);
+	struct ixp_ctx *ctx = crypto_tfm_ctx(ctfm);
+
+	crypto_free_skcipher(ctx->fallback_tfm);
 	exit_tfm(crypto_skcipher_tfm(tfm));
 }
 
@@ -854,7 +876,12 @@ static int ablk_setkey(struct crypto_skcipher *tfm, const u8 *key,
 out:
 	if (!atomic_dec_and_test(&ctx->configuring))
 		wait_for_completion(&ctx->completion);
-	return ret;
+	if (ret)
+		return ret;
+	crypto_skcipher_clear_flags(ctx->fallback_tfm, CRYPTO_TFM_REQ_MASK);
+	crypto_skcipher_set_flags(ctx->fallback_tfm, tfm->base.crt_flags & CRYPTO_TFM_REQ_MASK);
+
+	return crypto_skcipher_setkey(ctx->fallback_tfm, key, key_len);
 }
 
 static int ablk_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
@@ -880,6 +907,25 @@ static int ablk_rfc3686_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	return ablk_setkey(tfm, key, key_len);
 }
 
+static int ixp4xx_cipher_fallback(struct skcipher_request *areq, int encrypt)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct ixp_ctx *op = crypto_skcipher_ctx(tfm);
+	struct ablk_ctx *rctx = skcipher_request_ctx(areq);
+	int err;
+
+	skcipher_request_set_tfm(&rctx->fallback_req, op->fallback_tfm);
+	skcipher_request_set_callback(&rctx->fallback_req, areq->base.flags,
+				      areq->base.complete, areq->base.data);
+	skcipher_request_set_crypt(&rctx->fallback_req, areq->src, areq->dst,
+				   areq->cryptlen, areq->iv);
+	if (encrypt)
+		err = crypto_skcipher_encrypt(&rctx->fallback_req);
+	else
+		err = crypto_skcipher_decrypt(&rctx->fallback_req);
+	return err;
+}
+
 static int ablk_perform(struct skcipher_request *req, int encrypt)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
@@ -896,6 +942,9 @@ static int ablk_perform(struct skcipher_request *req, int encrypt)
 	gfp_t flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
 				GFP_KERNEL : GFP_ATOMIC;
 
+	if (sg_nents(req->src) > 1 || sg_nents(req->dst) > 1)
+		return ixp4xx_cipher_fallback(req, encrypt);
+
 	if (qmgr_stat_full(SEND_QID))
 		return -EAGAIN;
 	if (atomic_read(&ctx->configuring))
@@ -1422,7 +1471,8 @@ static int __init ixp_module_init(void)
 		/* block ciphers */
 		cra->base.cra_flags = CRYPTO_ALG_KERN_DRIVER_ONLY |
 				      CRYPTO_ALG_ASYNC |
-				      CRYPTO_ALG_ALLOCATES_MEMORY;
+				      CRYPTO_ALG_ALLOCATES_MEMORY |
+				      CRYPTO_ALG_NEED_FALLBACK;
 		if (!cra->setkey)
 			cra->setkey = ablk_setkey;
 		if (!cra->encrypt)
-- 
2.26.3

