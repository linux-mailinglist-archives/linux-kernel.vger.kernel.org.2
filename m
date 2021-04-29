Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201CE36ED17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhD2PIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbhD2PID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:08:03 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6136CC06138E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:07:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y12so49353273qtx.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koWFXsRK9IOTnpHaJ55PNA1ty9M1SO3yZ97+vGTbhqk=;
        b=wJPcyxX5SqL6cfCTtyPGKo3PubcSSqRVCU4sVPaQP3KURaD64/KYq21QAXXgf3NwKS
         lPehlj8cuKL0rJ54YDMYePk+MifJ4ONoqboCR0nXX7Hh0bymQHGR4SUmUsp4QL3erdyL
         1tnKs+p32Xs6VT+ScQrQMhqMMzRLwdG4hh7pyga15tLRMl1tkMPzXpSBqGeHaWcUSwO4
         Xz9j4T3KATqJ4jCdzNa+UfHKSv22RucNm8R7TKtVCyFl0Cg4ZIddJ2j/wF/OfC1Eu/uk
         laNua71XGSCcg7S41xTDrElmMI1+mZSs1cj4cBwYU+EPV62X+r+CuqLN/CtnUB2+BSj/
         AFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koWFXsRK9IOTnpHaJ55PNA1ty9M1SO3yZ97+vGTbhqk=;
        b=HKovJX2zQOrE7EAzTbBY1oVqLiRnv9rzaEtlx7u28RAUXpfX5kZJM92cUmQtEOklHe
         xNJODECCpqxXQ7fy5BbDI0iyuQFChBqCXxk6zaOPg/D5hFgPKUfkjClQorYc+bkgcjYG
         1HbUg1ArHb1ZjVTUV8PFCT3drUyGUzptfXpYiCY7zi5Nt60w8gpKAIUcxFGR8CsnR/V3
         kLDUsJ7c/DU6pKTRqWx9XB4ke11pd+c1XoC7cZQkCoLmWWVEj/bTS0GWxurTd4IQxmOQ
         Wd+88GTxwP/jhwW6nrbwXK98sRJrd6G1HanEl37KW4CsADaLCo7QnlH8CV0lTDsiN+lP
         vf7A==
X-Gm-Message-State: AOAM531XiW4uiI+qzAhSH7l/m2+xi6j0stRWMxWmWmmzsKMk3wp0xHlK
        99ItBb87tCUdaavBWLgTybcXpg==
X-Google-Smtp-Source: ABdhPJz10w4OQRcQPzpTv7kUB192KtAjVTSZNxFU5btjoad9EBpjxUv+KLydOqvFMYM4mFK2y9L/uw==
X-Received: by 2002:ac8:5157:: with SMTP id h23mr19981611qtn.45.1619708835288;
        Thu, 29 Apr 2021 08:07:15 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id j191sm2223822qke.131.2021.04.29.08.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:07:14 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [Patch v4 6/7] crypto: qce: common: Add support for AEAD algorithms
Date:   Thu, 29 Apr 2021 11:07:06 -0400
Message-Id: <20210429150707.3168383-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429150707.3168383-1-thara.gopinath@linaro.org>
References: <20210429150707.3168383-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register programming sequence for enabling AEAD
algorithms on the Qualcomm crypto engine.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v3->v2: - Initialized auth_ivsize to 0 to avoid -Wsometimes-uninitialized warning as
	  reported by kernel test robot <lkp@intel.com>.
v2->v3:
	- Made qce_be32_to_cpu_array truly be32 to cpu endian by using be32_to_cpup
	  instead of cpu_to_be32p. Also remove the (u32 *) typcasting of arrays obtained
	  as output from qce_be32_to_cpu_array as per Bjorn's review comments.
	- Wrapped newly introduced std_iv_sha1, std_iv_sha256 and qce_be32_to_cpu_array
	  in CONFIG_CRYPTO_DEV_QCE_AEAD to prevent W1 warnings as reported by kernel
	  test robot <lkp@intel.com>.

v1->v2:
	- Minor fixes like removing not needed initializing of variables
	  and using bool values in lieu of 0 and 1 as pointed out by Bjorn.
	- Introduced qce_be32_to_cpu_array which converts the u8 string in big
	  endian order to array of u32 and returns back total number of words,
	  as per Bjorn's review comments. Presently this function is used only by
	  qce_setup_regs_aead to format keys, iv and nonce. cipher and hash 
	  algorithms can be made to use this function as a separate clean up patch.

 drivers/crypto/qce/common.c | 162 +++++++++++++++++++++++++++++++++++-
 drivers/crypto/qce/common.c | 162 +++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 7b3d6caec1b2..7c612ba5068f 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -15,6 +15,7 @@
 #include "core.h"
 #include "regs-v5.h"
 #include "sha.h"
+#include "aead.h"
 
 static inline u32 qce_read(struct qce_device *qce, u32 offset)
 {
@@ -96,7 +97,7 @@ static inline void qce_crypto_go(struct qce_device *qce, bool result_dump)
 		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT));
 }
 
-#ifdef CONFIG_CRYPTO_DEV_QCE_SHA
+#if defined(CONFIG_CRYPTO_DEV_QCE_SHA) || defined(CONFIG_CRYPTO_DEV_QCE_AEAD)
 static u32 qce_auth_cfg(unsigned long flags, u32 key_size, u32 auth_size)
 {
 	u32 cfg = 0;
@@ -139,7 +140,9 @@ static u32 qce_auth_cfg(unsigned long flags, u32 key_size, u32 auth_size)
 
 	return cfg;
 }
+#endif
 
+#ifdef CONFIG_CRYPTO_DEV_QCE_SHA
 static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 {
 	struct ahash_request *req = ahash_request_cast(async_req);
@@ -225,7 +228,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 }
 #endif
 
-#ifdef CONFIG_CRYPTO_DEV_QCE_SKCIPHER
+#if defined(CONFIG_CRYPTO_DEV_QCE_SKCIPHER) || defined(CONFIG_CRYPTO_DEV_QCE_AEAD)
 static u32 qce_encr_cfg(unsigned long flags, u32 aes_key_size)
 {
 	u32 cfg = 0;
@@ -271,7 +274,9 @@ static u32 qce_encr_cfg(unsigned long flags, u32 aes_key_size)
 
 	return cfg;
 }
+#endif
 
+#ifdef CONFIG_CRYPTO_DEV_QCE_SKCIPHER
 static void qce_xts_swapiv(__be32 *dst, const u8 *src, unsigned int ivsize)
 {
 	u8 swap[QCE_AES_IV_LENGTH];
@@ -386,6 +391,155 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 }
 #endif
 
+#ifdef CONFIG_CRYPTO_DEV_QCE_AEAD
+static const u32 std_iv_sha1[SHA256_DIGEST_SIZE / sizeof(u32)] = {
+	SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4, 0, 0, 0
+};
+
+static const u32 std_iv_sha256[SHA256_DIGEST_SIZE / sizeof(u32)] = {
+	SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
+	SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7
+};
+
+static unsigned int qce_be32_to_cpu_array(u32 *dst, const u8 *src, unsigned int len)
+{
+	u32 *d = dst;
+	const u8 *s = src;
+	unsigned int n;
+
+	n = len / sizeof(u32);
+	for (; n > 0; n--) {
+		*d = be32_to_cpup((const __be32 *)s);
+		s += sizeof(u32);
+		d++;
+	}
+	return DIV_ROUND_UP(len, sizeof(u32));
+}
+
+static int qce_setup_regs_aead(struct crypto_async_request *async_req)
+{
+	struct aead_request *req = aead_request_cast(async_req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_ctx *ctx = crypto_tfm_ctx(async_req->tfm);
+	struct qce_alg_template *tmpl = to_aead_tmpl(crypto_aead_reqtfm(req));
+	struct qce_device *qce = tmpl->qce;
+	u32 enckey[QCE_MAX_CIPHER_KEY_SIZE / sizeof(u32)] = {0};
+	u32 enciv[QCE_MAX_IV_SIZE / sizeof(u32)] = {0};
+	u32 authkey[QCE_SHA_HMAC_KEY_SIZE / sizeof(u32)] = {0};
+	u32 authiv[SHA256_DIGEST_SIZE / sizeof(u32)] = {0};
+	u32 authnonce[QCE_MAX_NONCE / sizeof(u32)] = {0};
+	unsigned int enc_keylen = ctx->enc_keylen;
+	unsigned int auth_keylen = ctx->auth_keylen;
+	unsigned int enc_ivsize = rctx->ivsize;
+	unsigned int auth_ivsize = 0;
+	unsigned int enckey_words, enciv_words;
+	unsigned int authkey_words, authiv_words, authnonce_words;
+	unsigned long flags = rctx->flags;
+	u32 encr_cfg, auth_cfg, config, totallen;
+	u32 iv_last_word;
+
+	qce_setup_config(qce);
+
+	/* Write encryption key */
+	enckey_words = qce_be32_to_cpu_array(enckey, ctx->enc_key, enc_keylen);
+	qce_write_array(qce, REG_ENCR_KEY0, enckey, enckey_words);
+
+	/* Write encryption iv */
+	enciv_words = qce_be32_to_cpu_array(enciv, rctx->iv, enc_ivsize);
+	qce_write_array(qce, REG_CNTR0_IV0, enciv, enciv_words);
+
+	if (IS_CCM(rctx->flags)) {
+		iv_last_word = enciv[enciv_words - 1];
+		qce_write(qce, REG_CNTR3_IV3, iv_last_word + 1);
+		qce_write_array(qce, REG_ENCR_CCM_INT_CNTR0, (u32 *)enciv, enciv_words);
+		qce_write(qce, REG_CNTR_MASK, ~0);
+		qce_write(qce, REG_CNTR_MASK0, ~0);
+		qce_write(qce, REG_CNTR_MASK1, ~0);
+		qce_write(qce, REG_CNTR_MASK2, ~0);
+	}
+
+	/* Clear authentication IV and KEY registers of previous values */
+	qce_clear_array(qce, REG_AUTH_IV0, 16);
+	qce_clear_array(qce, REG_AUTH_KEY0, 16);
+
+	/* Clear byte count */
+	qce_clear_array(qce, REG_AUTH_BYTECNT0, 4);
+
+	/* Write authentication key */
+	authkey_words = qce_be32_to_cpu_array(authkey, ctx->auth_key, auth_keylen);
+	qce_write_array(qce, REG_AUTH_KEY0, (u32 *)authkey, authkey_words);
+
+	/* Write initial authentication IV only for HMAC algorithms */
+	if (IS_SHA_HMAC(rctx->flags)) {
+		/* Write default authentication iv */
+		if (IS_SHA1_HMAC(rctx->flags)) {
+			auth_ivsize = SHA1_DIGEST_SIZE;
+			memcpy(authiv, std_iv_sha1, auth_ivsize);
+		} else if (IS_SHA256_HMAC(rctx->flags)) {
+			auth_ivsize = SHA256_DIGEST_SIZE;
+			memcpy(authiv, std_iv_sha256, auth_ivsize);
+		}
+		authiv_words = auth_ivsize / sizeof(u32);
+		qce_write_array(qce, REG_AUTH_IV0, (u32 *)authiv, authiv_words);
+	} else if (IS_CCM(rctx->flags)) {
+		/* Write nonce for CCM algorithms */
+		authnonce_words = qce_be32_to_cpu_array(authnonce, rctx->ccm_nonce, QCE_MAX_NONCE);
+		qce_write_array(qce, REG_AUTH_INFO_NONCE0, authnonce, authnonce_words);
+	}
+
+	/* Set up ENCR_SEG_CFG */
+	encr_cfg = qce_encr_cfg(flags, enc_keylen);
+	if (IS_ENCRYPT(flags))
+		encr_cfg |= BIT(ENCODE_SHIFT);
+	qce_write(qce, REG_ENCR_SEG_CFG, encr_cfg);
+
+	/* Set up AUTH_SEG_CFG */
+	auth_cfg = qce_auth_cfg(rctx->flags, auth_keylen, ctx->authsize);
+	auth_cfg |= BIT(AUTH_LAST_SHIFT);
+	auth_cfg |= BIT(AUTH_FIRST_SHIFT);
+	if (IS_ENCRYPT(flags)) {
+		if (IS_CCM(rctx->flags))
+			auth_cfg |= AUTH_POS_BEFORE << AUTH_POS_SHIFT;
+		else
+			auth_cfg |= AUTH_POS_AFTER << AUTH_POS_SHIFT;
+	} else {
+		if (IS_CCM(rctx->flags))
+			auth_cfg |= AUTH_POS_AFTER << AUTH_POS_SHIFT;
+		else
+			auth_cfg |= AUTH_POS_BEFORE << AUTH_POS_SHIFT;
+	}
+	qce_write(qce, REG_AUTH_SEG_CFG, auth_cfg);
+
+	totallen = rctx->cryptlen + rctx->assoclen;
+
+	/* Set the encryption size and start offset */
+	if (IS_CCM(rctx->flags) && IS_DECRYPT(rctx->flags))
+		qce_write(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen + ctx->authsize);
+	else
+		qce_write(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen);
+	qce_write(qce, REG_ENCR_SEG_START, rctx->assoclen & 0xffff);
+
+	/* Set the authentication size and start offset */
+	qce_write(qce, REG_AUTH_SEG_SIZE, totallen);
+	qce_write(qce, REG_AUTH_SEG_START, 0);
+
+	/* Write total length */
+	if (IS_CCM(rctx->flags) && IS_DECRYPT(rctx->flags))
+		qce_write(qce, REG_SEG_SIZE, totallen + ctx->authsize);
+	else
+		qce_write(qce, REG_SEG_SIZE, totallen);
+
+	/* get little endianness */
+	config = qce_config_reg(qce, 1);
+	qce_write(qce, REG_CONFIG, config);
+
+	/* Start the process */
+	qce_crypto_go(qce, !IS_CCM(flags));
+
+	return 0;
+}
+#endif
+
 int qce_start(struct crypto_async_request *async_req, u32 type)
 {
 	switch (type) {
@@ -396,6 +550,10 @@ int qce_start(struct crypto_async_request *async_req, u32 type)
 #ifdef CONFIG_CRYPTO_DEV_QCE_SHA
 	case CRYPTO_ALG_TYPE_AHASH:
 		return qce_setup_regs_ahash(async_req);
+#endif
+#ifdef CONFIG_CRYPTO_DEV_QCE_AEAD
+	case CRYPTO_ALG_TYPE_AEAD:
+		return qce_setup_regs_aead(async_req);
 #endif
 	default:
 		return -EINVAL;
-- 
2.25.1

