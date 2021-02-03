Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871D830DCE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhBCOfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhBCOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:34:32 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EA3C0617A9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:33:16 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v3so17670192qtw.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Uh3JollLTG+dAe2nrFPwv+L2m02OQeUEuYSFXryNKA=;
        b=NfK/+uIgybzpmnDkFqO6IuK2o3JDCVPeFz4z0KcAKVxGfIjpB61ZVAIVCWTuHZMRDr
         YCCQQ6DGFGEC9iGjmUkhfUmgTDKwHPmyuduKipooERCIAhXU6xPPhe+T/Hme3wsVarLn
         NEkCy1LdJhl8/ZAyHMLbyTBxirDM2GM5y9PLMWJs7J3IrgPzXHbrO2vkJVLmb68KRS7N
         VThzzQTfRRfP4qyypdVCXGn/P10EzEvdLOUZkF+07StqP5DCdLZ+Xds243DskFNSg1iy
         cMBn415hgvVfhDai+fL5+R2dX7/zjFTNiXzGsveo70ZeKldXyp6KxwedmIDFSM0NOh6i
         WZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Uh3JollLTG+dAe2nrFPwv+L2m02OQeUEuYSFXryNKA=;
        b=Co2eQhQLPIr5roCXeL0NXoL0LyzL+bT0a+/tv+Cy/JhXm6APceUMawBPV+eRczYTxp
         NOwQeKUbgGXljuMI8lISAD1jyuPZ3d4pZIIuOr/WwkAsOerGMKLGKRVNa5wh1uFpd5Vt
         Nz9JVxrnsoHed6A/PlMYiJews+4XKQewJAWVk54BJ5zedTKmH86dA4PkBgo3p+R8m4P3
         8k1NNCdyAaR3k66OW6HHMYXgnwlQI92Sh9JvB3f3V+uW4ue6GaXGxArB28AY0xVHOyz9
         5Dkke/z9J0eWjApf1wx9bcB5WUomulZdleiwOUkh4GBP8ZlzzhMPb5N9qOFfIAkqP3c8
         LoFg==
X-Gm-Message-State: AOAM5330gHMqAOBpukpca4fR5jG1aPT5mRz8ifzEQC1a6BoSCM/VJGHB
        gzpgitQ6mPX0YSB7Wg31iDaZ8g==
X-Google-Smtp-Source: ABdhPJzrIovFBeflX6ADt7Xc5R3AuDqISgYl+Qcmm2lTalT4Q7puKBSceIfQIxP37OHEJNlL/Q0Hmg==
X-Received: by 2002:aed:204d:: with SMTP id 71mr2683694qta.318.1612362795500;
        Wed, 03 Feb 2021 06:33:15 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id v15sm1775433qkv.36.2021.02.03.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:33:14 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] crypto: qce: skcipher: Return error for non-blocksize data(ECB/CBC algorithms)
Date:   Wed,  3 Feb 2021 09:33:02 -0500
Message-Id: <20210203143307.1351563-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203143307.1351563-1-thara.gopinath@linaro.org>
References: <20210203143307.1351563-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECB/CBC encryption/decryption requires the data to be blocksize aligned.
Crypto engine hangs on non-block sized operations for these algorithms.
Return invalid data if data size is not blocksize aligned for these
algorithms.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/skcipher.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 331b3c3a5b59..28bea9584c33 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -254,6 +254,7 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	struct qce_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct qce_cipher_reqctx *rctx = skcipher_request_ctx(req);
 	struct qce_alg_template *tmpl = to_cipher_tmpl(tfm);
+	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
 	int keylen;
 	int ret;
 
@@ -265,6 +266,17 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	if (!req->cryptlen)
 		return -EOPNOTSUPP;
 
+	/*
+	 * ECB and CBC algorithms require message lengths to be
+	 * multiples of block size.
+	 * TODO: The spec says AES CBC mode for certain versions
+	 * of crypto engine can handle partial blocks as well.
+	 * Test and enable such messages.
+	 */
+	if (IS_ECB(rctx->flags) || IS_CBC(rctx->flags))
+		if (!IS_ALIGNED(req->cryptlen, blocksize))
+			return -EINVAL;
+
 	/* qce is hanging when AES-XTS request len > QCE_SECTOR_SIZE and
 	 * is not a multiple of it; pass such requests to the fallback
 	 */
-- 
2.25.1

