Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0595030DCD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhBCOef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhBCOeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:34:31 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C5EC06178C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:33:13 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id v126so23463774qkd.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qH6pF/G1SFg+K0bTJv0NKKhaRdQW632kFeXNuGpnkfE=;
        b=aFhCdAPN/YL22McZM81VXUVWm6cZq+icW7D7mDIbkcCakVss0d3fBGjUiPMOZP5b/G
         1Ikg4/W7bCqt57vQncxOSgchloc7P/uIr+KMadW4jPQaylWz80EyIAgysn4KTB6wfqfJ
         X5HRK1chHI20yvfOlBqmlz05ztOV+9zVoBaRLu7KMGCP+gwk+nF4FFCne+4wBQh0omJn
         /dWnDpZABhLyo8WafKD9Egv7Fr44A0QR0nKT9rebhqogKSL9kNhs7HBBKRXZs0SIE7kt
         2GIwTHrcTpkeB6kiIJtO2tbLVWtBkrzpExUItfHG9i1RGmZ4R8zGJqYYZCXoO4HG1AoM
         IqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qH6pF/G1SFg+K0bTJv0NKKhaRdQW632kFeXNuGpnkfE=;
        b=FctgjeKDKu1BRoIJoYOXVhTeAldoA3a49+4KcMaAVpx1WCfr8dsAHDEz1CKUJLPVOE
         8Z1r8C5E8DngdTDz6iwpkWSlqcaqBPHh2whEc7uaqdAW1brX31tOyK8fkZPhIdN5HwrY
         VQ+DteCR2HCMlP97+G8BQ0n93+tIQnys3Ach+35q2ir1CkLCYOYqDGBCkGLfnVB0OA8T
         smo0CZfD2jX4celHnYmHeMYjNwOZMP9CpeMLnPq5i0o9AYYu6cPUXrOpTrOFHXHwgF2t
         WBXKgoF4VYP2uzGw5oimQqN5go5cOgdUX+HRMP42MSni/qJ+fsWZwbJ1n6AW5yrjRmL3
         i5lA==
X-Gm-Message-State: AOAM533PflxDCV/wySHYohSX+hvqCBNZCNPDvmAiDnCPxy50YKAQg6lX
        5Y5tZWxkSLk7OwJNqIHBhWhaCw==
X-Google-Smtp-Source: ABdhPJwfkoa5tq06Zg4d8bC0U+IpqJTN95QX2flL12jYm0dbE6JQWr2ZEOwA9hwvcDv/qW0NiFky6Q==
X-Received: by 2002:a37:2e87:: with SMTP id u129mr2754756qkh.344.1612362792387;
        Wed, 03 Feb 2021 06:33:12 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id v15sm1775433qkv.36.2021.02.03.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:33:11 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] crypto: qce: skcipher: Return unsupported if key1 and key 2 are same for AES XTS algorithm
Date:   Wed,  3 Feb 2021 09:32:59 -0500
Message-Id: <20210203143307.1351563-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203143307.1351563-1-thara.gopinath@linaro.org>
References: <20210203143307.1351563-1-thara.gopinath@linaro.org>
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

