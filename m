Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9122374957
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhEEU1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbhEEU11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D2C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:26:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d4so3211310wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qNHcmRakO4ShV9Tx/kw4hZ3DZlWxxa2CciC+xe4iDkw=;
        b=ZGHzV3C0LweoW7LZFx17Cue7cb1oRbtXcybhex81gLaPOYS/x3q8xHNV0ndBEBh+u6
         6T+rhqzodln3fzWoMJCk5sbQdTEgJhJFvG+vh4JAJCFTHsD1NJkvFTBjjZyAChFNL+ry
         tFw6uJb65nh9atC93vEo6A3SXrJv/3xoeUIqetLTsuwEipPxLzLTwrU8qYRABT8DomCu
         7T+WUVGDJbkj/wsaXIu/LK/hyRdIvaS8i54dN+2ARwlIPjTH4M+kVINXl0YApaBDF1w0
         VhXRwq8+sNUQeulqSExfio9FKyhu87k6oAn41DRHYf9qkI7qrct2oZsXIMLhI/WPTJA7
         AW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNHcmRakO4ShV9Tx/kw4hZ3DZlWxxa2CciC+xe4iDkw=;
        b=jz8RsLadfW/zjj0yhWxz6QtBdFLQmMZx6mYE+NtdFAxYEP7XMl9PgRZcELqLiCxF88
         mG7XGq64N7+Af6Uye8LSTYqLuH+M5oyDF8X78HuSSLw1yVpgD2M4qCOeQK4t0mr+PgON
         Yg4NCsnVj5oqp5xoXiggaVJBFMANjBbJZ16Lh4XBb18eEHRSUQLce6FUGWBKl0dQksa9
         gkW0w9G//VdY1sS7DSS/oBOCvuN1wErq3P+TnmBtF+1Ia2k+4SCpFO+Q4AQLd2+pafJi
         f4I3KU2MJk7ovzctkfTNf2KOFcVtApR02AAamSePO2hoCjUYL1JT9be2mv1KPl5sZ2M3
         C57w==
X-Gm-Message-State: AOAM5301+7t2yJgknqXAC/IfSXsqwdI2c9oTjpdW+86bLkDGskA+uOWf
        ADdlRxrrWMnUxiyuhbpkkB2vCg==
X-Google-Smtp-Source: ABdhPJx3HAtoecZ3LrqPdXeOVl4Y6DnFRP713ydPKXezA4AaHQl/5MlcA4VJMRR2hH6IWyu1opcTTg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr903183wrt.220.1620246388414;
        Wed, 05 May 2021 13:26:28 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a15sm497245wrr.53.2021.05.05.13.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:26:28 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     chohnstaedt@innominate.com, davem@davemloft.net,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 04/11] crypto: ixp4xx: convert unsigned to unsigned int
Date:   Wed,  5 May 2021 20:26:11 +0000
Message-Id: <20210505202618.2663889-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505202618.2663889-1-clabbe@baylibre.com>
References: <20210505202618.2663889-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes all issues reported by checkpatch about "unsigned", lets convert
them to unsigned int.
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/ixp4xx_crypto.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/ixp4xx_crypto.c
index 8bbf2ead6e79..17de9e60adad 100644
--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -136,7 +136,7 @@ struct crypt_ctl {
 	u32 crypto_ctx;		/* NPE Crypto Param structure address */
 
 	/* Used by Host: 4*4 bytes*/
-	unsigned ctl_flags;
+	unsigned int ctl_flags;
 	union {
 		struct skcipher_request *ablk_req;
 		struct aead_request *aead_req;
@@ -184,7 +184,7 @@ struct ixp_ctx {
 	u8 enckey[MAX_KEYLEN];
 	u8 salt[MAX_IVLEN];
 	u8 nonce[CTR_RFC3686_NONCE_SIZE];
-	unsigned salted;
+	unsigned int salted;
 	atomic_t configuring;
 	struct completion completion;
 	struct crypto_skcipher *fallback_tfm;
@@ -695,8 +695,8 @@ static int register_chain_var(struct crypto_tfm *tfm, u8 xpad, u32 target,
 	return 0;
 }
 
-static int setup_auth(struct crypto_tfm *tfm, int encrypt, unsigned authsize,
-		const u8 *key, int key_len, unsigned digest_len)
+static int setup_auth(struct crypto_tfm *tfm, int encrypt, unsigned int authsize,
+		      const u8 *key, int key_len, unsigned int digest_len)
 {
 	u32 itarget, otarget, npe_ctx_addr;
 	unsigned char *cinfo;
@@ -823,12 +823,12 @@ static int setup_cipher(struct crypto_tfm *tfm, int encrypt,
 }
 
 static struct buffer_desc *chainup_buffers(struct device *dev,
-		struct scatterlist *sg,	unsigned nbytes,
+		struct scatterlist *sg,	unsigned int nbytes,
 		struct buffer_desc *buf, gfp_t flags,
 		enum dma_data_direction dir)
 {
 	for (; nbytes > 0; sg = sg_next(sg)) {
-		unsigned len = min(nbytes, sg->length);
+		unsigned int len = min(nbytes, sg->length);
 		struct buffer_desc *next_buf;
 		dma_addr_t next_buf_phys;
 		void *ptr;
@@ -930,7 +930,7 @@ static int ablk_perform(struct skcipher_request *req, int encrypt)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct ixp_ctx *ctx = crypto_skcipher_ctx(tfm);
-	unsigned ivsize = crypto_skcipher_ivsize(tfm);
+	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
 	struct ix_sa_dir *dir;
 	struct crypt_ctl *crypt;
 	unsigned int nbytes = req->cryptlen;
@@ -1045,8 +1045,8 @@ static int aead_perform(struct aead_request *req, int encrypt,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct ixp_ctx *ctx = crypto_aead_ctx(tfm);
-	unsigned ivsize = crypto_aead_ivsize(tfm);
-	unsigned authsize = crypto_aead_authsize(tfm);
+	unsigned int ivsize = crypto_aead_ivsize(tfm);
+	unsigned int authsize = crypto_aead_authsize(tfm);
 	struct ix_sa_dir *dir;
 	struct crypt_ctl *crypt;
 	unsigned int cryptlen;
@@ -1157,7 +1157,7 @@ static int aead_perform(struct aead_request *req, int encrypt,
 static int aead_setup(struct crypto_aead *tfm, unsigned int authsize)
 {
 	struct ixp_ctx *ctx = crypto_aead_ctx(tfm);
-	unsigned digest_len = crypto_aead_maxauthsize(tfm);
+	unsigned int digest_len = crypto_aead_maxauthsize(tfm);
 	int ret;
 
 	if (!ctx->enckey_len && !ctx->authkey_len)
-- 
2.26.3

