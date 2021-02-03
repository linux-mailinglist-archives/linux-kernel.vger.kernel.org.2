Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E631730DCF3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhBCOhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbhBCOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:35:14 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC74C06121C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:33:22 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id l11so34516qvt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9ityeqdgyZLKc/rh27ogHO9y0MwsQMpPeavkRLsNvQ=;
        b=mdHhx5CMghbS4mbIJhuv/jCQRTCD6rsp4Tu+mdekLjrwDJVgs98SNFcZihdRaRWxHu
         mySPOHRRNt6SHjC4nplIMJ3ZrNmk5BnoIZEJfyedrkc5cDtZckkFMKVKpYW22QTTITSS
         ChfjOHBjB47tnVfVNTA3Zorether7ASYW09kx5UC0994BQZ69/sIFmKg05Y3wg2tTyYv
         VMxV9ZV3eBW5bwiejboxbMrY9rRx6P4lVTIx5uRGafSq0LtF+0WFPhWpVuZAjPJpGlMR
         w5PmrnMqs2AUhhYNpzDHmSmRDd+tlfMT3svs9g3cwZzdpBZUPD6nlv4Q8jWR9wRTSdha
         oenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9ityeqdgyZLKc/rh27ogHO9y0MwsQMpPeavkRLsNvQ=;
        b=ujcaDZKPEVqsaY6d77MROkiuc1Nrh0TxyB2YzKnOTT1swTtFhw+iu59K6oby9e/OIO
         /xVuR6ZknIvGOzeAJuanjFxiXXR5HOd+jeBUJMnxqFuoxICO4NKiPEYpjSA0fxoY4YWH
         UCr4yD3C9/XhAWzP0RUU/vDEKMw/EcJOsbcoEXXPVLgALZb/m/cEHFyel8Kc5HrBQiDS
         vty66eJH6hb171yerhJ/JmlptKSTXlBTjBSnuMPiDk8+yOs/oKD03nxuFsbI4DzNHXAo
         TS2Wzs2JJNNTomw4N8HAcVAJdP1hJGFdhfWEw1tC3DT2b7VluOaEpwaBn+Ww9ID7xzE4
         786g==
X-Gm-Message-State: AOAM531S75O/xwzRUbyvf5jvm4ch5RQ58sseAix3vQsEsuM2A8eYBucG
        ooUx5A12sc6OgE7M9eZzmLbKGQ==
X-Google-Smtp-Source: ABdhPJwCApDuzB07oMeOnvS5JveGPjVBIT2hcCTCZ1fPbv6dlsLl7u+Pag5/gJo6wAUpBzltuiM7XA==
X-Received: by 2002:a0c:a99e:: with SMTP id a30mr2823309qvb.38.1612362800823;
        Wed, 03 Feb 2021 06:33:20 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id v15sm1775433qkv.36.2021.02.03.06.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:33:20 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/11] crypto: qce: Remove totallen and offset in qce_start
Date:   Wed,  3 Feb 2021 09:33:07 -0500
Message-Id: <20210203143307.1351563-12-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203143307.1351563-1-thara.gopinath@linaro.org>
References: <20210203143307.1351563-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

totallen is used to get the size of the data to be transformed.
This is also available via nbytes or cryptlen in the qce_sha_reqctx
and qce_cipher_ctx. Similarly offset convey nothing for the supported
encryption and authentication transformations and is always 0.
Remove these two redundant parameters in qce_start.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/common.c   | 17 +++++++----------
 drivers/crypto/qce/common.h   |  3 +--
 drivers/crypto/qce/sha.c      |  2 +-
 drivers/crypto/qce/skcipher.c |  2 +-
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index f7bc701a4aa2..dceb9579d87a 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -140,8 +140,7 @@ static u32 qce_auth_cfg(unsigned long flags, u32 key_size)
 	return cfg;
 }
 
-static int qce_setup_regs_ahash(struct crypto_async_request *async_req,
-				u32 totallen, u32 offset)
+static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 {
 	struct ahash_request *req = ahash_request_cast(async_req);
 	struct crypto_ahash *ahash = __crypto_ahash_cast(async_req->tfm);
@@ -306,8 +305,7 @@ static void qce_xtskey(struct qce_device *qce, const u8 *enckey,
 	qce_write(qce, REG_ENCR_XTS_DU_SIZE, cryptlen);
 }
 
-static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
-				     u32 totallen, u32 offset)
+static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 {
 	struct skcipher_request *req = skcipher_request_cast(async_req);
 	struct qce_cipher_reqctx *rctx = skcipher_request_ctx(req);
@@ -367,7 +365,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
 
 	qce_write(qce, REG_ENCR_SEG_CFG, encr_cfg);
 	qce_write(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen);
-	qce_write(qce, REG_ENCR_SEG_START, offset & 0xffff);
+	qce_write(qce, REG_ENCR_SEG_START, 0);
 
 	if (IS_CTR(flags)) {
 		qce_write(qce, REG_CNTR_MASK, ~0);
@@ -376,7 +374,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
 		qce_write(qce, REG_CNTR_MASK2, ~0);
 	}
 
-	qce_write(qce, REG_SEG_SIZE, totallen);
+	qce_write(qce, REG_SEG_SIZE, rctx->cryptlen);
 
 	/* get little endianness */
 	config = qce_config_reg(qce, 1);
@@ -388,17 +386,16 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
 }
 #endif
 
-int qce_start(struct crypto_async_request *async_req, u32 type, u32 totallen,
-	      u32 offset)
+int qce_start(struct crypto_async_request *async_req, u32 type)
 {
 	switch (type) {
 #ifdef CONFIG_CRYPTO_DEV_QCE_SKCIPHER
 	case CRYPTO_ALG_TYPE_SKCIPHER:
-		return qce_setup_regs_skcipher(async_req, totallen, offset);
+		return qce_setup_regs_skcipher(async_req);
 #endif
 #ifdef CONFIG_CRYPTO_DEV_QCE_SHA
 	case CRYPTO_ALG_TYPE_AHASH:
-		return qce_setup_regs_ahash(async_req, totallen, offset);
+		return qce_setup_regs_ahash(async_req);
 #endif
 	default:
 		return -EINVAL;
diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
index 85ba16418a04..3bc244bcca2d 100644
--- a/drivers/crypto/qce/common.h
+++ b/drivers/crypto/qce/common.h
@@ -94,7 +94,6 @@ struct qce_alg_template {
 void qce_cpu_to_be32p_array(__be32 *dst, const u8 *src, unsigned int len);
 int qce_check_status(struct qce_device *qce, u32 *status);
 void qce_get_version(struct qce_device *qce, u32 *major, u32 *minor, u32 *step);
-int qce_start(struct crypto_async_request *async_req, u32 type, u32 totallen,
-	      u32 offset);
+int qce_start(struct crypto_async_request *async_req, u32 type);
 
 #endif /* _COMMON_H_ */
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index c8bfa9db07b8..f6c6275272fc 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -113,7 +113,7 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 
 	qce_dma_issue_pending(&qce->dma);
 
-	ret = qce_start(async_req, tmpl->crypto_alg_type, 0, 0);
+	ret = qce_start(async_req, tmpl->crypto_alg_type);
 	if (ret)
 		goto error_terminate;
 
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 8599250946b7..3fc0b263d498 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -144,7 +144,7 @@ qce_skcipher_async_req_handle(struct crypto_async_request *async_req)
 
 	qce_dma_issue_pending(&qce->dma);
 
-	ret = qce_start(async_req, tmpl->crypto_alg_type, req->cryptlen, 0);
+	ret = qce_start(async_req, tmpl->crypto_alg_type);
 	if (ret)
 		goto error_terminate;
 
-- 
2.25.1

