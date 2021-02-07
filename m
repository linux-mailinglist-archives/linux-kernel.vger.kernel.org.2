Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD53124C2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhBGOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBGOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:41:11 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466DC061793
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:39:51 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id s77so11944926qke.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qH6pF/G1SFg+K0bTJv0NKKhaRdQW632kFeXNuGpnkfE=;
        b=tK0RaRfltPOjC5dp1sHYm+mCxuY0YDjYZ6xk71WaUByyrhWJkhni3fjIOWgzPNwGIm
         Kjx+O+3rSilNy9OhM/DmTYZx/u7mkOwIkEVAyHkwTJzhH5xFJl53HXAdSEEMBZkfwQ9v
         8rIqDKCdRS9j0tQWc48BmXN7gNBa6kR45kc9VAgYxAE5LFbBFusbHC4x17PSGK2s/qnq
         ngy3VQX+dYuCZ/8MP15Wz64Q/1j5JA8hGpEGuHQiFh6Mk26Zo1kqp62YbhHKNVGln0gv
         XD/utxdmryUpjmMmIK1I143ah6L59XvFux7JN6BbNEJI35q0eyo3rO2LGv5KY0rfJBhR
         FJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qH6pF/G1SFg+K0bTJv0NKKhaRdQW632kFeXNuGpnkfE=;
        b=hkjcpNlIuNOvB9lmur37frH+jwdlhS8wZ72IitfRtpxKuv7ViyPpcDTCvRobblWlWv
         4E+hVtiW9cPnAFKmwLu3IKBno3Ebeake32HURuvcI5qqcgK+WhywUEwreYSTQWXkpgNu
         i/K236+JKH2scJuy7lSgS8JoDoA5DHrchxz7mxlRuAVSdDT74F0Ce93lZCWpwPXA0sTW
         HUj536XzqyF/Z2uiHd9picBDKPRu901LnjJbCoIZDEfHVTHv7kflgyjr9oCTwN9ny5xG
         nBckK0uJgdLHPV9VJowSrHf1Sw8vdqKxMYNOz9Ywf1F1tgRnVN9mo+gxwRnF1WXau4ZR
         oMDg==
X-Gm-Message-State: AOAM5316AsrPI4cchDFHrpEbGLerBKh5nHyZumFwGdRxChLlFTJpKAox
        L8j1zAgXIYS2fQ7jEjlXu/ukVg==
X-Google-Smtp-Source: ABdhPJwl9vATUkObTALS+x6PSdkPw23c/SOleeccMUyrb9QX0waDHOV8ZMGu5cZQSM+N4Ddn4U3O4w==
X-Received: by 2002:a37:418d:: with SMTP id o135mr12805811qka.426.1612708790818;
        Sun, 07 Feb 2021 06:39:50 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c81sm13941493qkb.88.2021.02.07.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:39:50 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/11] crypto: qce: skcipher: Return unsupported if key1 and key 2 are same for AES XTS algorithm
Date:   Sun,  7 Feb 2021 09:39:38 -0500
Message-Id: <20210207143946.2099859-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207143946.2099859-1-thara.gopinath@linaro.org>
References: <20210207143946.2099859-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crypto engine does not support key1 = key2 for AES XTS algorithm; the
operation hangs the engines.  Return -EINVAL in case key1 and key2 are the
same.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/skcipher.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index a2d3da0ad95f..12955dcd53dd 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -167,16 +167,33 @@ static int qce_skcipher_setkey(struct crypto_skcipher *ablk, const u8 *key,
 	struct crypto_tfm *tfm = crypto_skcipher_tfm(ablk);
 	struct qce_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
 	unsigned long flags = to_cipher_tmpl(ablk)->alg_flags;
+	unsigned int __keylen;
 	int ret;
 
 	if (!key || !keylen)
 		return -EINVAL;
 
-	switch (IS_XTS(flags) ? keylen >> 1 : keylen) {
+	/*
+	 * AES XTS key1 = key2 not supported by crypto engine.
+	 * Revisit to request a fallback cipher in this case.
+	 */
+	if (IS_XTS(flags)) {
+		__keylen = keylen >> 1;
+		if (!memcmp(key, key + __keylen, __keylen))
+			return -ENOKEY;
+	} else {
+		__keylen = keylen;
+	}
+
+	switch (__keylen) {
 	case AES_KEYSIZE_128:
 	case AES_KEYSIZE_256:
 		memcpy(ctx->enc_key, key, keylen);
 		break;
+	case AES_KEYSIZE_192:
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	ret = crypto_skcipher_setkey(ctx->fallback, key, keylen);
-- 
2.25.1

