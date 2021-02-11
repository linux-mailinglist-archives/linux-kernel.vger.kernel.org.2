Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C93193F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhBKUI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhBKUC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:02:57 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA0EC06178C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:33 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id u20so6518716qku.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qH6pF/G1SFg+K0bTJv0NKKhaRdQW632kFeXNuGpnkfE=;
        b=eINM6deGLuZE+Vv0pTKoDilO23CRE2BaIW+sdCGXsAVFR4bVV5/js80jZGOiWx6YNR
         L4tH8VIAvobrNDjnxCkYCVgvKxJn9Y2zfGYwUMGnaHyiCKNtr/SkFTaFKK9JoPah+0WU
         XN7Ygi8vgH5E/ivsjQjyKm6F9thX9FEUhJ/PVNOWLDxPY1fN1OUGiY4W0edLXuI3J8gP
         QH+wXjKzeLObSXvUT9HNTkNUrsLCsj3nlzv6yoVgwyIMw+8fofiaQE5My4ZF3IEY2iNw
         ggyHVLX43WBfRBv0E5SK5FEOT7tu0qsTE0N4fpRhis0giBWjuUf4M2Pslw0ixYa4zn2k
         BWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qH6pF/G1SFg+K0bTJv0NKKhaRdQW632kFeXNuGpnkfE=;
        b=hYZYftg1pvZLYYK8gs/dWhgMOiuKu7fmKT5OQtRXnmhWS54P/Al8yMysm9Fb6PwWj4
         DMqAtFJ+e4L/kPpcPDwQemTmXzOmrPyc9/prYWRNyi7lrrPYBbYUMAAtuKDHjjUeTbRh
         KhxSBRmalZtUqao2BWU+SXEBBLuOpkFBEE3BW9iGa4SaUXsq9zFKDwuhvAyUA7Mgtn+P
         Uu6P7DAiOL+TRuuTX3hOMUsjpMxcJtZ38iFSA8+2MkZYP/4fpDiA9SsHvcq67EtBzBPi
         XrdNOMEMGSbRiO44trK4qFVC7L/FhRhAvdRzbOD3j86mhxrZ7zX/hGYYghdaH+04JPTW
         vpAQ==
X-Gm-Message-State: AOAM530noVwrBeeWsd8isjOqc0JaXj+jZqhg58Cq6rl7Set16G4t98yI
        t2NLmqJHEWeB+klkvWPVYK/3/A==
X-Google-Smtp-Source: ABdhPJzKXHhcyrfFZRCJbcf+hO9Bh1Uw4B2SPvuPof409sfdYfzODvV4vEVf+40CFpc5ypKE1CDqZA==
X-Received: by 2002:a37:6503:: with SMTP id z3mr10104887qkb.330.1613073692581;
        Thu, 11 Feb 2021 12:01:32 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id 17sm4496243qtu.23.2021.02.11.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:01:31 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/11] crypto: qce: skcipher: Return unsupported if key1 and key 2 are same for AES XTS algorithm
Date:   Thu, 11 Feb 2021 15:01:20 -0500
Message-Id: <20210211200128.2886388-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211200128.2886388-1-thara.gopinath@linaro.org>
References: <20210211200128.2886388-1-thara.gopinath@linaro.org>
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

