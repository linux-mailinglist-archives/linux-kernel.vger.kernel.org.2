Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75B43193FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhBKUJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhBKUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:02:59 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D8FC061794
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:34 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id x3so5098089qti.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N23pUSUU7iQvfUHxPcNVoEdixxNGRArc1osHV7Hwol4=;
        b=BR602T063Y8RPEJhaSQOgDGirNGVDhshaj5wcH3Ip3MZ4Dl0dW83XYly599Wf8K/Ch
         eHeXsDgpVBTukHj7p4U0AZPeyzPlpGTBvV39ct3vSn0af4fcoMjTy0ZvzQIjvZS0zOLt
         afb3oKaf/O4JoX/VaN8jCtxMHMFEQ7lVsBx1NOM7qa14CtxlTT/mT7LLNv7SY/cNASHI
         iaP+SH+vR1Eab6CRcfwtgX/RfIYU8QYOf7JHeEel1Yja+tuuP5GQ4ii0H5Q6JH9GTwTi
         pnVA8YTbV2RNsoMQuc6Jsz14rOmXu8HlgoRVSFxERNwfUXX6ljOrrAQva4ZtAPzn2PFk
         mJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N23pUSUU7iQvfUHxPcNVoEdixxNGRArc1osHV7Hwol4=;
        b=D0TBp8zKpnQeLNl8CFCLJxuc4vqWJve9sBJ/3LEr+l9AUfNGsT61fOytP3bNi/ZbKU
         cuaALUHbdtXBHMk60sOaaKHEI59s/DdeFmfvN1/qULzZFBj6B1jssqjKINPH8QdtF0Nz
         1YGlR3Klm6ekXCj18RbBoKPdm2tzt/mKCGCQaARHmc023vByR8qO9Skg8iS7dSKsGCWo
         HQepBZRD6tKZ+GJS2wv6ic0345Y861atfdShCEjxicGRr+C3R6IKHsyAnGS8NE/uG+z9
         v9Phnwn6fnErVqoWVi9eBbj+ryVbgIPZwP4/+6xGU8rVLKyUim9JkwqUuozK/1ccb593
         ZBLQ==
X-Gm-Message-State: AOAM532nMJLwObCZIrvB14QQmURHjnFZt+sc5Lmbzd3DtbQtO6tkpVNf
        S6mXToJCMXQEAXwtlGdFrMj5mQ==
X-Google-Smtp-Source: ABdhPJx3y1NOQILlCGcIBoYJHQ5uj76fh+dnUl6IyWPPVdBsK+6cQ0qT8hMS6MzDILdcP9NjV8vEUQ==
X-Received: by 2002:a05:622a:552:: with SMTP id m18mr9217830qtx.207.1613073693947;
        Thu, 11 Feb 2021 12:01:33 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id 17sm4496243qtu.23.2021.02.11.12.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:01:33 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/11] crypto: qce: skcipher: Return unsupported if any three keys are same for DES3 algorithms
Date:   Thu, 11 Feb 2021 15:01:21 -0500
Message-Id: <20210211200128.2886388-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211200128.2886388-1-thara.gopinath@linaro.org>
References: <20210211200128.2886388-1-thara.gopinath@linaro.org>
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

v6->v7:
	- Fixed sparse warning in patch 4 as pointed out by Herbert Xu.
	  This means the checking if any two keys are same for triple
	  des algorithms has been reverted back to using conditional OR
	  instead of using bitwise OR.

 drivers/crypto/qce/skcipher.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 12955dcd53dd..8aeb741ca5a3 100644
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
+	if (!((_key[0] ^ _key[2]) | (_key[1] ^ _key[3])) ||
+	    !((_key[2] ^ _key[4]) | (_key[3] ^ _key[5])) ||
+	    !((_key[0] ^ _key[4]) | (_key[1] ^ _key[5])))
+		return -ENOKEY;
+
 	ctx->enc_keylen = keylen;
 	memcpy(ctx->enc_key, key, keylen);
 	return 0;
-- 
2.25.1

