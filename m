Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0FB30DCFA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhBCOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhBCOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:34:32 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13349C061797
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:33:15 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id e15so17617056qte.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbaPzVOJqVBKum7B5yoNy4q+qHm6B45n0RkRe3mNDrc=;
        b=QyusuCpErLb3kiwVr9cb7mMeO3uuL0Db7UqGjOizoeNDgOIiJ/M0RgYT9/2QInQ5sk
         mZz0zX/IAcLhwG1US9lLL6FTf4lcACEfU3cfMOTm6JGXT4yZhb+PGp0P4sq27nDVbXyF
         cUH2bcqdUbycPUSlX5ulcTlp3nHffPGdMMGiwqh+xPy8nObkayALUlIf74etHGX9oXsC
         eMzBlzkE8NPJeJ3dFNDZzridD/+2DB11X0HMuUlhsY8fFMH+mfJI5XDbBirpoOmmn7XF
         UF6sSQZJV60jlFHdYilEq9e94moDgIl2nebwBGdOjiG985jACp8OJt/+66cSwB8lrA80
         BV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbaPzVOJqVBKum7B5yoNy4q+qHm6B45n0RkRe3mNDrc=;
        b=RQGvPAwGMbNY6vVL32IjDKIzsu9vLlD06kaufBMY6NS1oMA6cGIFYqKC7BLTmO0jEE
         DgHtJti6cMtxuGg6nmQkYwXvd7JREOmLFGlmnlPv1/mWMYmxwJAXwzxY7vbV4/Blntdb
         UJnZl5TiZKzubDdGJ6UNfkH7keNvWlwQa5IgSoiln1+vahaT8xdCOrugiYH+Ro1PQdnG
         8TNsA0luyPS3Ng2N2hz1zf1cLkeY+xPNHv1WZ2+fq/0M2pyR//wqx6QG9kTh0/ef/X5j
         jqqLRZ4dQIvG1OZyPw4MX/udgwRaeDce41lnOjUY5HjmeB+JxMmohumCayTKC2q/SZ9m
         KhGw==
X-Gm-Message-State: AOAM5304+m279Mz964lGIq/ocXADEikGbIpKABQR08RxTOPc2Ggtz4ce
        SZLamqNznDXWdMnoghirE5JiJA==
X-Google-Smtp-Source: ABdhPJy87U7RkWORdEybOGyU//I8UblbcmqgkRyN/SeMQ9V0FLoJtCpwxFQFZ9yJLqHgGuq6/e2BEw==
X-Received: by 2002:ac8:71d0:: with SMTP id i16mr2581739qtp.349.1612362794339;
        Wed, 03 Feb 2021 06:33:14 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id v15sm1775433qkv.36.2021.02.03.06.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:33:13 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/11] crypto: qce: skcipher: Return error for zero length messages
Date:   Wed,  3 Feb 2021 09:33:01 -0500
Message-Id: <20210203143307.1351563-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203143307.1351563-1-thara.gopinath@linaro.org>
References: <20210203143307.1351563-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crypto engine BAM dma does not support 0 length data. Return unsupported
if zero length messages are passed for transformation.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/skcipher.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index de1f37ed4ee6..331b3c3a5b59 100644
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
+		return -EOPNOTSUPP;
+
 	/* qce is hanging when AES-XTS request len > QCE_SECTOR_SIZE and
 	 * is not a multiple of it; pass such requests to the fallback
 	 */
-- 
2.25.1

