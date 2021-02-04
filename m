Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6769130F1D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhBDLPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbhBDLMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:12:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466B1C061222
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a16so5715326wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyplMPucg3iOrY2nniY7G/Evy8Npfc2vFaJnW0PI2LM=;
        b=ekSQxHuxk0xtv21ZbQcl2ycKHt8Ml1KkajwaP+MZ+rkIEOSQZN9fbTd68tzTYsXJQ9
         +rQ0llJvLZ8qiSdH/lZPKwZNHsU3cdD+iyEO0eNGKU4JOpzZwnGJJaZ+DDtr5MH6ZZX/
         S8d31UtxU4seUHnrcDhWzqwl0aZcR6YZVZV7M+IvYbDsaRwSgiB987TrWAqzH7pmJVfA
         MfI8emBtsqNE+bdcIo9IVdA0IRz3IANyq3P5wIJHyCQdfz35SGGo6ttWiPDa2cQ7EV8x
         iiYDsDd5ifoCTI86AVcyAe31nuMsbq60tYKq9eTidpAbJ0pDdOS207XZUJ6SjA36ko+4
         eg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyplMPucg3iOrY2nniY7G/Evy8Npfc2vFaJnW0PI2LM=;
        b=ChC56btFqVUh237BXTP/IQvOQ/FKBVV41xsx9Bv23cbJ8+yKPw9IiwJEcdrIVuuc5E
         uUzoSbhjXhnkXKs0fhkyXkkBGS9xiFmKfeFDvpVwdUWuqEhbdcM4oZlaQyxOI0RwszXW
         ZepBW4RFxGrMi5zS0B2zxR6NWDIbpHUuuTHlGV+k41CNQQx4AeI8ShRVoe3myNVAp9cY
         CYmzNnwh+iz36tQi5ycx6Lv8/89DpmAYlN/LDvUL3sxbghPGzI+HD7m63aXbjapvzKiH
         EDptfUNjzCwWlMoQ265x4h2uRUHMbav436WUWh9H0ZYvGWQVW5n7Sg+ku1B/uTDuC3DM
         Mihg==
X-Gm-Message-State: AOAM533bL4B2HisAaTPBMPB2kNHM0LUZi6QI9UpzvfUPX8x3mrHXfifS
        wFCRkdtLELaoWjdn0U5d9YAbyQ==
X-Google-Smtp-Source: ABdhPJy1JNJu3m4t+MVtGxQYZO5Rm/NID114zcurjbrW+Yzs0lZ8GlMJ8K6ULDLLoxf2mMqmiHtcWQ==
X-Received: by 2002:a1c:720d:: with SMTP id n13mr6860166wmc.103.1612437019961;
        Thu, 04 Feb 2021 03:10:19 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 14/20] crypto: caam: caampkc: Provide the name of the function
Date:   Thu,  4 Feb 2021 11:09:54 +0000
Message-Id: <20210204111000.2800436-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/caam/caampkc.c:199: warning: expecting prototype for from a given scatterlist(). Prototype was for caam_rsa_count_leading_zeros() instead

Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/caam/caampkc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
2.25.1

