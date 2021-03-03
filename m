Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D032BEEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386185AbhCCRrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbhCCOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:37:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A45C061A28
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:35:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e10so23685629wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=51h0lVd1c7+OEvoO2UQG6dIvRRvCEl0n5KWV8010Ypo=;
        b=GkxKVVq7IkiWjmYpMI1QVOgqWdbTVgDmPsYWZtIM68tQPUU+sP13OEYiyBs7aFTC2a
         zjmRxkMeM+VRRDJ9Q5Rh9pBjyAFKdijQa8mT2gzs9NvNFqiC2NEcVB/uDxFrokKlnXKk
         bUlxZ6zLSS/x4qjwXKMAAvEP35y0gRtmxAGxNehjhnbhkOQSNXsjL27K/rnVwnn1foky
         Kyliq/xAiJ2BM7u/vcf/HELPZf6g99B0srUDNT4+SGm3MDy4FO7gs9k1VkIPtuO/G01u
         7ysCOpvwI9sSB+zwadrwca55dMboDEOYQ8xBCqNCsZCMQMgDB5Uw0yfMXh3bS4Ffy7Gd
         OQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=51h0lVd1c7+OEvoO2UQG6dIvRRvCEl0n5KWV8010Ypo=;
        b=LBUOcUaSzu+TfgBc9UXq3JY2XWb2/l3WyeleQAxtIxBou61G4UAiBVFJXveHaViR4p
         7UxRStKkZqyiFN9ggSwr9r3TCVSet0jcwofdCbmaxzUB4ZGrRgLW4PknurTn0fud/9eD
         WvQbHNTCsYiOsbSF1rCXG4kvOZrrEKLa2yVT+Ijv8npEZEDdpLnCYbV5Y9s5FbI3hjag
         1395O7tQQqXHhxcZNgI0bvcKPQ4KLIMx5Tiv6vbkUIMbSPzvpmEQ0not7ED9wLBLMzWa
         iNMHdm9xAd4PZSPxbE+aOFgIjWWCv2mqniTX7+yEwWGgSeJDzxVE071fz+Vo6Uv/pgSM
         AnCQ==
X-Gm-Message-State: AOAM532mXjhON4HaFpMggFHnIvd8Ue6NTFPF/eZ5J34/proHpsePuVZ8
        JA2AnSNrtbojySpwI6RcCrUnb7m2PPwscg==
X-Google-Smtp-Source: ABdhPJy6p+2gqBDKWQdfVK+vUYUsxiwwW6yVEu3D+yA9Si/XotFwXicN4U/A30h6CcBslOXvHnZcyg==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr23880148wrq.143.1614782104546;
        Wed, 03 Mar 2021 06:35:04 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id f16sm31475923wrt.21.2021.03.03.06.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:35:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 07/10] crypto: caam: caampkc: Provide the name of the function and provide missing descriptions
Date:   Wed,  3 Mar 2021 14:34:46 +0000
Message-Id: <20210303143449.3170813-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303143449.3170813-1-lee.jones@linaro.org>
References: <20210303143449.3170813-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/caam/caampkc.c:199: warning: expecting prototype for from a given scatterlist(). Prototype was for caam_rsa_count_leading_zeros() instead
 drivers/crypto/caam/caamalg_qi2.c:87: warning: Function parameter or member 'xts_key_fallback' not described in 'caam_ctx'
 drivers/crypto/caam/caamalg_qi2.c:87: warning: Function parameter or member 'fallback' not described in 'caam_ctx'

Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/caam/caamalg_qi2.c | 2 ++
 drivers/crypto/caam/caampkc.c     | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index a780e627838ae..22e45c5bf2023 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -71,6 +71,8 @@ struct caam_skcipher_alg {
  * @adata: authentication algorithm details
  * @cdata: encryption algorithm details
  * @authsize: authentication tag (a.k.a. ICV / MAC) size
+ * @xts_key_fallback: whether to set the fallback key
+ * @fallback: the fallback key
  */
 struct caam_ctx {
 	struct caam_flc flc[NUM_OP];
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index dd5f101e43f83..e313233ec6de7 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -187,7 +187,8 @@ static void rsa_priv_f_done(struct device *dev, u32 *desc, u32 err,
 }
 
 /**
- * Count leading zeros, need it to strip, from a given scatterlist
+ * caam_rsa_count_leading_zeros - Count leading zeros, need it to strip,
+ *                                from a given scatterlist
  *
  * @sgl   : scatterlist to count zeros from
  * @nbytes: number of zeros, in bytes, to strip
-- 
2.27.0

