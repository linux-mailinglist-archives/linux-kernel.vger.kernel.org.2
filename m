Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2340E30FFAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBDVu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhBDVpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:45:23 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E197C061797
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 13:44:05 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id k193so4919273qke.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 13:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JO1AHf4uhYw2ez6Ve3o7chTARaAb1KHfpJckn1suQ+U=;
        b=L5atl3u2FShWrNk0KPUgQBmlVFI8trZLK+DuEcZWP0P1LwPq9Kl5pxeU3pyfzKh6kN
         oD4oYBetvwTOIHy2Tnt+aBmJvlseHBkH6HctukpVUSZoH/MgiQ2PyT0r8aTx7/5FZrs/
         6LQUB2yFXjZ8IAIZGw2cScLTy1OwvS+k2kf0/zlttN00+XG22VEZJimpa4hbif8BFfzJ
         FDt2mY3WTUsmO7HeJ15MKySQOlocbwcsNxJDYoLbn7fnH9FdeNoFMoK1Pgt0KpU0OXGK
         ZJeVHEgjmCr5XIiJDlLQJ5i8V0AKbu98wSIUXpCOR6QvsdSTxY90F5JtaO9CjwQUGuzL
         ZCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JO1AHf4uhYw2ez6Ve3o7chTARaAb1KHfpJckn1suQ+U=;
        b=nW+ZDZ2gbhoY0GH+MYYtQ8y2KXj7MVNswTWt25MBdRRIsgcJXRKLZmjYGN7BcNy35z
         s0/9bZt9mEYsyavZzr3jeb5RXCahhWFqxlztHHCWoPZuD4hABRhtCOB+amiqX4llS+1g
         2Bp5ptk4KV2CHUGw6Jru5iaA21mrPF95H9feOZLXYq/2fD0kZU4criIYLrnzrPlw5x9M
         LmAPUCKX087T8y8orh7Po8hpRn0S5fD5ir0U0TQ+4o6Tzp6EvSNiTNBZFaP0XQgeo1DA
         CEca1HEPiDG/YUg4iEl4QKs0JYXvqGrgHEqE2KEARHE62O+KPz1zeqdZOIcpAz622UDF
         4jLg==
X-Gm-Message-State: AOAM5305A5NMb0kkY5j3IMf7PdbtpkdwH7BERHzjyT8cBQqQ7nZpvyQz
        x6Yic5PVctYWzJw+8gmkvia4iA==
X-Google-Smtp-Source: ABdhPJwIHZywZI303E3pWw3kSBlHV4QnzG54HsWGTIi0sA/+BDHynMZ0HB9vH0454zjtUuYMHsKhXg==
X-Received: by 2002:a37:8dc7:: with SMTP id p190mr1247597qkd.308.1612475044406;
        Thu, 04 Feb 2021 13:44:04 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h185sm6353858qkd.122.2021.02.04.13.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:44:03 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/11] crypto: qce: skcipher: Return unsupported if any three keys are same for DES3 algorithms
Date:   Thu,  4 Feb 2021 16:43:52 -0500
Message-Id: <20210204214359.1993065-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204214359.1993065-1-thara.gopinath@linaro.org>
References: <20210204214359.1993065-1-thara.gopinath@linaro.org>
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

