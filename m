Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C503124C5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBGOlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBGOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:41:11 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB4BC0617A7
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:39:53 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id l27so11898000qki.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ImO8jkC+DpvrTwFdTRomeqFeWgN9hrI9w+kY9c6b/Eg=;
        b=OCLgpZUE37foaDocZaEHBNJMw5JQFRlcV/GQrDUXCXyz99cMVjbMSB2FtH6tTfG2cx
         E40uoln4Rg3HMYsiCXRdjQ0iKjARyTtS7RBiPPm0LW+Hjo39/NnLxCUbYOsCpQplG8A0
         jSwNYwfQnLgYzxJp9qkMP/VzDat7T+ILOMsk+sfT+x4fCiE4BqmogoreyTZb8eeIJ6jr
         tiwjBcMC3loAKNeFr9gudpWumDus6vUZbpx21UM3C/t//pjbauNLsDDn00iE6YDh4wpR
         cgwC1mh6tEq3/fSAYF0DtOEtS2J/DF0xxfFjtK9b1M7W+okZls1HwwHYzPlzwV6D/5z4
         CpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ImO8jkC+DpvrTwFdTRomeqFeWgN9hrI9w+kY9c6b/Eg=;
        b=LA78UFyE7bZwm63qcjscTOVX7wVQ4/PHkDyUkm6d0kOWwZoBgIr2jR6eIzr7eIHcul
         Ofs6ui6K+5tkFap4bsvJ7AEZEbVpR88ENqEh9/DUOnM1bm3ZsauUU+CgaTeStLNP17RX
         kf6PkRdi0XlsQahXpDXK/JBqDAXN69i9dL4FkHLA1gMp/g62liiPj1/QgxVhuZcQey6Z
         asYzE4mPDuIQV+Y8oiR0R/dX7iTNz8T/+KBcAkJC34Q+rZkTcORwXVlYfY0UkNVgEN6p
         eAHpZ9jHBRl7U/QJRx7s8x3lIDoKmlB7tgSfIA4QklEDtGVKu5ykZyhL1OAdVR9BQ+aA
         e2ww==
X-Gm-Message-State: AOAM530ufYmGmvr6E3+Va5gS/1GdJ4Zw9JuCA2/DF1E5Nfo373/wrpTk
        qhzNeNQRxG0bCTXSrYhagIcZ+g==
X-Google-Smtp-Source: ABdhPJwsP/au8aPfn6AANj8C2f8SfkkfbtzTYwhiu7dp6lGVagiGs+lxB62wlWqsgsIHLsKI4Gk5Hg==
X-Received: by 2002:a05:620a:12d7:: with SMTP id e23mr12618290qkl.58.1612708792517;
        Sun, 07 Feb 2021 06:39:52 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c81sm13941493qkb.88.2021.02.07.06.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:39:52 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/11] crypto: qce: skcipher: Return error for zero length messages
Date:   Sun,  7 Feb 2021 09:39:40 -0500
Message-Id: <20210207143946.2099859-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207143946.2099859-1-thara.gopinath@linaro.org>
References: <20210207143946.2099859-1-thara.gopinath@linaro.org>
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
index de1f37ed4ee6..96af40c2c8f3 100644
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

