Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76B63193FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBKUJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhBKUDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:03:05 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07BDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:35 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id w19so6064935qki.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1CgjtrleZBn361kEsQacHmwktwYHTlh2i7RhqRtwQhU=;
        b=ys1ClJjc89p3uIaKVv5nPzEGLGYSpyZfo96p7Ho137WBXWf4266h587cPDZnOwuDgt
         aj9XK0idolxShycDxNigx165a9CaAJz7AZW+C52i6odq7YLRiDEKU6e6O7MtmBPapKix
         Y54MCwi2HRFFi7xBAXFl8Z3Thxi+nH912l4cHaOv6Fk3oOJAwSIPsgDTyRq7pHa/h3NB
         Y22uTRSobrXNdkVbkr+7en8T0i5hUKwAUp8p7lkADan0vf7+k6D69BdrtfSIHGedJDzi
         4b94tnuvLhDGwwid/GRVCgNkkGNvrEwi95rjtZJ5HaU107Vm6WuW/WH47nGb8g3E+WTq
         XnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CgjtrleZBn361kEsQacHmwktwYHTlh2i7RhqRtwQhU=;
        b=qHO8G88tf8INX6v6ZqoHP3eWe81vXeFpZyvYrguJfeSGo1IowM3kXSlrtzAhXHd1He
         QSKe4U3kGpjAwd4iqleOFVLUbb5DXBDhjrXZMDAWm9T5y05kGM72D3iKYiEEOlGC1REp
         9FEqCHgpGtAO4FtNJCCOeBs94fom5S9+BEn12PI2V+ETHZ9KJDd57OSd8UtvaGXBchBW
         IzkLKO1WscaclIy+0EKDhVi8Az67EhIVHwrCkqWNomAFKJuUQNFnX6+PjD2IjIzFNlqc
         Is818WERLmCCBVPuOK6z0uVPXUZm/zMaCsVVciQOkWDcwVHUkoHzv/+mIsZRNJdYD123
         cVHw==
X-Gm-Message-State: AOAM5318X3cr+UXac3OfvHFaXFNm23BFYAElgfcfNmhpC4HWgTGT1DSG
        DxcYJnUcfXamyb4eE8gfIROloA==
X-Google-Smtp-Source: ABdhPJyTW/w6d2hG7OAGHIbsWO3Sa25NlI+GgMhqPovvFAnQ9Chp8NIopA6QUNMziTj+IL1soQo9Lw==
X-Received: by 2002:ae9:e883:: with SMTP id a125mr10206879qkg.431.1613073694918;
        Thu, 11 Feb 2021 12:01:34 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id 17sm4496243qtu.23.2021.02.11.12.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:01:34 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/11] crypto: qce: skcipher: Return error for zero length messages
Date:   Thu, 11 Feb 2021 15:01:22 -0500
Message-Id: <20210211200128.2886388-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211200128.2886388-1-thara.gopinath@linaro.org>
References: <20210211200128.2886388-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crypto engine BAM dma does not support 0 length data. Return unsupported
if zero length messages are passed for transformation.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v5->v6:
	- Return 0 for zero length messages instead of -EOPNOTSUPP in the
	  cipher algorithms as pointed out by Eric Biggers.

 drivers/crypto/qce/skcipher.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 8aeb741ca5a3..6b3dc3a9797c 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
+#include <linux/errno.h>
 #include <crypto/aes.h>
 #include <crypto/internal/des.h>
 #include <crypto/internal/skcipher.h>
@@ -260,6 +261,10 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
 	keylen = IS_XTS(rctx->flags) ? ctx->enc_keylen >> 1 : ctx->enc_keylen;
 
+	/* CE does not handle 0 length messages */
+	if (!req->cryptlen)
+		return 0;
+
 	/* qce is hanging when AES-XTS request len > QCE_SECTOR_SIZE and
 	 * is not a multiple of it; pass such requests to the fallback
 	 */
-- 
2.25.1

