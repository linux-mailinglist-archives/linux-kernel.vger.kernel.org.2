Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0023124C4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBGOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhBGOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:41:11 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FC2C061797
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:39:52 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id t63so11973492qkc.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JO1AHf4uhYw2ez6Ve3o7chTARaAb1KHfpJckn1suQ+U=;
        b=lhxu4kBqKdBzeGuBV04S9k+Q7UatH4gOcWyETDNOIumzGqSrnfMDfX/2zGLr4o3YnB
         CY4JOFt0FUG8W6iCFTHLlPyF7WERXEuusCIixIwpUqGIsb2FjniEjtY+W1kwUz+/9n+k
         4RAuVvpb3tkwZBTe3F01MdSqMYo7PEU7bh5Xvo9/kJynW54s5ddAkkjysk4AKB1QyIdC
         PBHxOV5fTxE1BRfPEirROMf7jSp0Clj3tuma/TFEKVL5TdpSLWSZqQFwjfpIyD2/+Jef
         yfTk+UtrQEQEYeP97c9YBgKLNJCdfMPdl9N/ztIVnEbH9l28R3uXSCUV8niAHEYyhpd5
         eJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JO1AHf4uhYw2ez6Ve3o7chTARaAb1KHfpJckn1suQ+U=;
        b=cbw8E+trWo5z6YIICHciSgYVahQfGsjyUyn8aTuhog1hLKo/YzXt8jgUJLVZ/1ZOD/
         711RvNZvLzKsWhvehwMKL5g42dExnVIOmIVcp/zqv3Dn8Kv8SEjpdqIzDfC44gujckPT
         GdnJUFEHIciSJotaENPT/ier0ORgRyWolLA+3xLkpCyzOXqYVRcuedP1V+2YzdOITcR+
         5gZjCqFVrzipRGW92muRG1ormMYjjiiFcnReK9z0nTEhE6BgeglXifWL+HKuY8xGxDee
         vbPCkzJ3qXL6fF2witSva2KiDi6j6hUUy2w0SsYAtDsfHe/yqMN5J7KZXo/tnb1tLp//
         MKlQ==
X-Gm-Message-State: AOAM533o0jT9qtOd+1l+P70XhEphd3qCe76wwO4F4IZzlxatnYM693tk
        ZAfsoJ2ly4phw9aBnR3e6kzbog==
X-Google-Smtp-Source: ABdhPJx0PlS7z6FA62l+CkV47J/KLM3umlSEv4slMJ9qZwthbGUew4ek3GHajoMKsLOQrWXTluYafA==
X-Received: by 2002:a05:620a:e03:: with SMTP id y3mr13093718qkm.467.1612708791684;
        Sun, 07 Feb 2021 06:39:51 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c81sm13941493qkb.88.2021.02.07.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:39:51 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/11] crypto: qce: skcipher: Return unsupported if any three keys are same for DES3 algorithms
Date:   Sun,  7 Feb 2021 09:39:39 -0500
Message-Id: <20210207143946.2099859-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207143946.2099859-1-thara.gopinath@linaro.org>
References: <20210207143946.2099859-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return unsupported if any three keys are same for DES3 algorithms
since CE does not support this and the operation causes the engine to
hang.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/skcipher.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 12955dcd53dd..de1f37ed4ee6 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -221,12 +221,27 @@ static int qce_des3_setkey(struct crypto_skcipher *ablk, const u8 *key,
 			   unsigned int keylen)
 {
 	struct qce_cipher_ctx *ctx = crypto_skcipher_ctx(ablk);
+	u32 _key[6];
 	int err;
 
 	err = verify_skcipher_des3_key(ablk, key);
 	if (err)
 		return err;
 
+	/*
+	 * The crypto engine does not support any two keys
+	 * being the same for triple des algorithms. The
+	 * verify_skcipher_des3_key does not check for all the
+	 * below conditions. Return -ENOKEY in case any two keys
+	 * are the same. Revisit to see if a fallback cipher
+	 * is needed to handle this condition.
+	 */
+	memcpy(_key, key, DES3_EDE_KEY_SIZE);
+	if (!((_key[0] ^ _key[2]) | (_key[1] ^ _key[3])) |
+	    !((_key[2] ^ _key[4]) | (_key[3] ^ _key[5])) |
+	    !((_key[0] ^ _key[4]) | (_key[1] ^ _key[5])))
+		return -ENOKEY;
+
 	ctx->enc_keylen = keylen;
 	memcpy(ctx->enc_key, key, keylen);
 	return 0;
-- 
2.25.1

