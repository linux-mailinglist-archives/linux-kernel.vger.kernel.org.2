Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C833124CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBGOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBGOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:41:29 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EDEC06121E
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:39:56 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 2so5862993qvd.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYyfVG373bOpf6eoJSEUDGRo4VSC1owsiW4MHt1XZKU=;
        b=O3zpXEieJu8dijkZH819LMHZyBYAVRE+NoWQvj51zMmfUVeZXlEv+jr5AMevaUmQeS
         S+KcJhHtZh3AT78cURRekswY85PKUJqn6JsxPDubcd3I0rR3AB7zIM40FQTGqZ2lMUe3
         Y+1DU4arwyLiYDsAcdP1i0Mv9NIns1NefG1RK1qI2jyP2TMxvEpegwzUMqai0t+kSV6u
         fWgRV05gzK9jMK7wJahDjZQlooHi+A//yi/m0vX0DcO2rXtd05gJdnnirrkqp5Jza6FL
         iHMxn+S4i2GwdNHh86QuG/Thi2PRGHycm01oLUoz89BrUI+YEyp9qpZ9J/5wW/EHS0g2
         GQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYyfVG373bOpf6eoJSEUDGRo4VSC1owsiW4MHt1XZKU=;
        b=g34mePgm/Gq9AnBU0YLAEdpgneSFfnjsZZwuuOGmSsII5VABvw17iYns7ljnjyFjVG
         uZ2Hvfn67FpRRL/Hmj3YCeF13PT0JwEslVNfWKXBRH0E4W6nWOH3irv+WIewpb06w43q
         JsSsWMU+JlbEvsF+6pdiA5NagSnYkrgXShiAAaY8pmNH4yY5uOVDti0TiMAksrRuuVB0
         JVrBDXpj3YJctb/elJODXvdMblbL4cY+m9C7f5qY8YTEV3DvIBxLRhnRVhc8cugTfKru
         aB8IsPJUKo8Ed7OfZ34gENgb0JQ2+vlaeUz9aFq/bP21Ac/Cjf7EKYSbe9GOo4UApLmt
         M5Uw==
X-Gm-Message-State: AOAM532aVSV3kfKOIRShuyB/3b5DmWdpSwntoHRHf7hv3b+SwQ7bD28V
        +a5gdHJ42BiwUmAyBB+fLacdwQ==
X-Google-Smtp-Source: ABdhPJxLviqfQVDEJM157AAA3ddG+c2jzrFkLrTsy8bJjwx+E3o+5wskSsL97cd75A3wHzAUAjNb8w==
X-Received: by 2002:a05:6214:522:: with SMTP id x2mr12733825qvw.13.1612708795396;
        Sun, 07 Feb 2021 06:39:55 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c81sm13941493qkb.88.2021.02.07.06.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:39:54 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/11] crypto: qce: skcipher: Improve the conditions for requesting AES fallback cipher
Date:   Sun,  7 Feb 2021 09:39:43 -0500
Message-Id: <20210207143946.2099859-9-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207143946.2099859-1-thara.gopinath@linaro.org>
References: <20210207143946.2099859-1-thara.gopinath@linaro.org>
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
index 64f661d7335f..66a226d1205e 100644
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

