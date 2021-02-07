Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C853124D0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBGOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhBGOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:41:55 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3B1C061224
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:39:58 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id a12so11909013qkh.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S634bOI/l2hQTpgSJr3nVqoDwyDnHV1Gw6IbuFUoXuA=;
        b=EEeoLHA9p2j7vGSuG5F6ZMbLX6ECOyCXPLqBP18J1BbcKXAQZslEq0a/S0MfRmOJtn
         UySXexTVD2tdCjiyJztu+2cOw28gOa+eP7OvFqgtkDnDBFAWHyCE4ivLYEzGiKRaPhz9
         q9PGLP0fi0jJfU5FtvMRpyNjzoj26Ae/Zau0UwQAmF0F7N7d5+PgJ2ZU3691JQsFk4Xh
         8p5tHrRMIfUNvIHZvPtQKu1iaXnfllBTFstFvq7II7BT3/lUNxYnqbObie0vmXMNo5z9
         VRYoSFaytaOb5p7fjDbR3rx7Zuq7CFqVhFVPfnXiF82WCRVol68BKF8+RVigODJTeCqq
         8zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S634bOI/l2hQTpgSJr3nVqoDwyDnHV1Gw6IbuFUoXuA=;
        b=RaMyFTS8nNFpzclI1fm1B/3rBnUqeOM4OcWwb5nE5jlIuo7eCi+ZAWo4jqyUZiXHMH
         5ywlEuCkrLBrnhCyf8o+npFGng8Y5MmuyfDuiFdYpoxlnP2keeaMgLXrREj99mDVz5FO
         tQVca/by5Szk9+df1tzL+vN04odNcts7cJKc5VAhLAQKi3GmbWfr22PkP/jP208oiklS
         /K86RevPo8jgCxtsifL3YPTpaYbNvPxHeZBRgmpGASkyQJnyznofsHW92xIyeHM9wjCJ
         iQnGScs9c3t9OEzJ2puqss627zmCDHOeyWSDoTlrzFJl80ZKfoN3+O+SJGQnAFjIetrN
         kXNQ==
X-Gm-Message-State: AOAM530tHw3SA0KDE+V5r2d3xOHL2XKam5xOqbMIKZ6kBbhYGTNCwcSM
        NbXxIKhp0CAMQNz9JUxwVVm+kg==
X-Google-Smtp-Source: ABdhPJyK0ClMQhKQCWSJ5BalQAh7uLS0KFkLeo3RZdlHONGc5AxzYdn4Us0Tk/HGZKEphw0pnHe+Iw==
X-Received: by 2002:a37:aa4e:: with SMTP id t75mr12500918qke.343.1612708798033;
        Sun, 07 Feb 2021 06:39:58 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c81sm13941493qkb.88.2021.02.07.06.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:39:57 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/11] crypto: qce: Remove totallen and offset in qce_start
Date:   Sun,  7 Feb 2021 09:39:46 -0500
Message-Id: <20210207143946.2099859-12-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207143946.2099859-1-thara.gopinath@linaro.org>
References: <20210207143946.2099859-1-thara.gopinath@linaro.org>
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
index 2813c9a27a6e..8e6fcf2c21cc 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -113,7 +113,7 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 
 	qce_dma_issue_pending(&qce->dma);
 
-	ret = qce_start(async_req, tmpl->crypto_alg_type, 0, 0);
+	ret = qce_start(async_req, tmpl->crypto_alg_type);
 	if (ret)
 		goto error_terminate;
 
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 66a226d1205e..9fec5bdc29ec 100644
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

