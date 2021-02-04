Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69430FF90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBDVrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhBDVpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:45:24 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFDFC0617AB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 13:44:06 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id j4so2503607qvk.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 13:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Uh3JollLTG+dAe2nrFPwv+L2m02OQeUEuYSFXryNKA=;
        b=jWvRhrxq+HtoVbJ25dNRu4xY6VYR7oLRLfdcUcDb3o6gS7Y9vSJzF128Jsn+iZp069
         q2JeXO3v22fmSx2/3k3hUmSS9uqWtZwLlWmQVmLfe6JdRSmRjy3h38i9Zk6q+kO0nRS5
         Hx/cTtDxXQBa/I3Okgtk/xYpbKWtUwL5jMSnwp3SQUrCsMWo4e783xGbbaQiPZ9Z58VR
         AcCu0GNvHBOqpFb4xc4hHfccp2cedZY7CUcQFEv71eyKmRZE6TxfsRWRNkW2CPX+JZAm
         L7SyL/xhd8rnw8vZtBFhFObWhJ7+vFBI3lkgzBez1/X2pb0EpzKYr89Yoks7r5bB0xFK
         0sZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Uh3JollLTG+dAe2nrFPwv+L2m02OQeUEuYSFXryNKA=;
        b=mhzTTo6z/Usn7NwiodHE2TIcndkrMcDT46oQMV8pMdR+mDZPxtFPTidEJSXxAZAwqp
         YgQ6bYqg/cWYDgxvTqULOrDWv4dxlg+eDvCVgzmHnXfxcP7sPZR78XKoOUAMVXcKV+mj
         1oCi3hd5tiPik+3fHZDHJSuTAKLV1vWsKzKUNDgkV1WwPT4CWn+7CToJpf/ArqjUn+WL
         AmMN6vZug08kP6zg4BBxuDiPl1baTB3QrvjREr/uKFPGTi5qK9LtDLs1zGtjYDiEu5x9
         rLIzlkY8VQMTlYieJ5IssBjaQ300wMf5k2j0oBf15VW4309bYyrllcj1VtpmEqzO+tG2
         LllA==
X-Gm-Message-State: AOAM533im9Cv+k8svTyyFOtxKIvvvc3sBkO5w3i4AVbU3jdi0FOz6iJr
        tKllXWv+Drskl0ivh+p/7UWHOA==
X-Google-Smtp-Source: ABdhPJwFnleRuZpSk7iDPWk0gesGQ3eIaN0XEEIqiVUB9TX09uPEQ7gwk6c/AtTAFDksrbTF3k84UA==
X-Received: by 2002:a05:6214:324:: with SMTP id j4mr1547471qvu.53.1612475046183;
        Thu, 04 Feb 2021 13:44:06 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h185sm6353858qkd.122.2021.02.04.13.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:44:05 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/11] crypto: qce: skcipher: Return error for non-blocksize data(ECB/CBC algorithms)
Date:   Thu,  4 Feb 2021 16:43:54 -0500
Message-Id: <20210204214359.1993065-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204214359.1993065-1-thara.gopinath@linaro.org>
References: <20210204214359.1993065-1-thara.gopinath@linaro.org>
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

