Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FF73193FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhBKUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhBKUC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:02:57 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5B9C06121C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:38 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id p12so3172100qvv.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bL5tBDOEKgNdAp1Fa/CljitFahbwVqV1YSG/EkXQA0c=;
        b=koec8wpRvuhR5tv/Ao6J+GJABNrBwHe5+cC8LGvp6bbyx7drnjjNsbwMfn44UgLQt5
         x2FjR1ObKQbGaZz+ctKNvqNm2oL5ip9RGq1vlY2u4szlJsliW/IDaMZjeNVWDwu4ywrQ
         dxUYNRXR1KmZ2T4kLq/MDVvdzq3Pu/NG4q8XNIMYzFyVrqSGi6GMFx7iz094u0Wzv29n
         iXwsso+pdJyH5uxg2l3T/HD2YRpRkpbZv8AMaw7wCg9r4TYxfqRAmMg3hVNJloBhgy02
         W6Hi6WN+UHsGXE9OUQGvKLyTrT5LnQIXPh7qY1hCqHeYXe9o8yfaykUYyeeaj/c4D5xe
         vw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bL5tBDOEKgNdAp1Fa/CljitFahbwVqV1YSG/EkXQA0c=;
        b=HgVs9QIWDacxwnoNRs1QIKym3WJj4NZ6jip5r7mGgn4RWPHNW5hp6XZIzmRuW+oaH0
         ZUPe0T/+QzKkIvB74NDml0NPzxEcyKx3pSCDottk7McjXf2j7gCKwl7XVlc4mOsjQfmI
         qwICGxPzeK5cV6GzWIBIcN3I2YiTic/dOFSrPNjIURBJ6VGE5m03oBtStVSLKVpKBxNR
         HzNQnMKEIoUQp8kWHkbQyhqTrNdeiEB/SZq8CJeSanqhX244jMUNfAe6UwTU92tBMT5a
         P5HLLSOQaypkFWk8REEkMjeSBJho3tzaAw7W+VLFVsT74cIthfTZPI7zuKjMxkGf0tGC
         1X6w==
X-Gm-Message-State: AOAM531ahWpjfyCqagJ007Aokr+458dSrw0Fn0SPj0SEHc/AoF1jw9Kt
        FdVYBB4iQ3vxQNbvvDqVQOnr2Q==
X-Google-Smtp-Source: ABdhPJzIFZywKupBzn46fcDcEotLWw+/PeTcuH6mTBjOdsAXF1OWwlfLMf5u57ih8n23fpu+6P/83w==
X-Received: by 2002:a05:6214:11ab:: with SMTP id u11mr9210776qvv.17.1613073697388;
        Thu, 11 Feb 2021 12:01:37 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id 17sm4496243qtu.23.2021.02.11.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:01:36 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/11] crypto: qce: skcipher: Improve the conditions for requesting AES fallback cipher
Date:   Thu, 11 Feb 2021 15:01:25 -0500
Message-Id: <20210211200128.2886388-9-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211200128.2886388-1-thara.gopinath@linaro.org>
References: <20210211200128.2886388-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following are the conditions for requesting AES fallback cipher.
	-  AES-192
	- AES-XTS request with len <= 512 byte (Allow messages of length
	  less than 512 bytes for all other AES encryption algorithms other
	  than AES XTS)
	- AES-XTS request with len > QCE_SECTOR_SIZE and is not a multiple
	  of it

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/skcipher.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 11a2a30631af..2e6ab1d33a31 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -274,14 +274,19 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 		if (!IS_ALIGNED(req->cryptlen, blocksize))
 			return -EINVAL;
 
-	/* qce is hanging when AES-XTS request len > QCE_SECTOR_SIZE and
-	 * is not a multiple of it; pass such requests to the fallback
+	/*
+	 * Conditions for requesting a fallback cipher
+	 * AES-192 (not supported by crypto engine (CE))
+	 * AES-XTS request with len <= 512 byte (not recommended to use CE)
+	 * AES-XTS request with len > QCE_SECTOR_SIZE and
+	 * is not a multiple of it.(Revisit this condition to check if it is
+	 * needed in all versions of CE)
 	 */
 	if (IS_AES(rctx->flags) &&
-	    (((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256) ||
-	      req->cryptlen <= aes_sw_max_len) ||
-	     (IS_XTS(rctx->flags) && req->cryptlen > QCE_SECTOR_SIZE &&
-	      req->cryptlen % QCE_SECTOR_SIZE))) {
+	    ((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256) ||
+	    (IS_XTS(rctx->flags) && ((req->cryptlen <= aes_sw_max_len) ||
+	    (req->cryptlen > QCE_SECTOR_SIZE &&
+	    req->cryptlen % QCE_SECTOR_SIZE))))) {
 		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
 		skcipher_request_set_callback(&rctx->fallback_req,
 					      req->base.flags,
-- 
2.25.1

