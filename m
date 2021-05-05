Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F223737495C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhEEU1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbhEEU12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787E1C061763
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:26:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y124-20020a1c32820000b029010c93864955so4111047wmy.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPi3GWFf6k778V89ksbErMgoKxDVX/Ki9ZfOEswj8Wc=;
        b=mu8aSZVBwYaPSF8UH/aaPLDoKDGLMm2P7jX1e+72RGxjGqhiquhRbvpngx8ak/j5JG
         vppOayT09Wvbpx3gDY9pVeF60+Qa9BqLJlhCVJCf2uEti+6fChf2+llFon20P2Gy7Bsl
         kV6b32k5xN+MNkKW3ZM1HoWaThc8OSRxs3NdAnoHc9r5J+iJiVkCfEB9qJfaProaEAr/
         eybmzMqRBW12ZoIV5eoouA6UBvlwWJMI0kmjDNkKwJjj/mrVOY7CRUcgmbtZPvF7kF+o
         6feH6cLmdZVe01D8FLQFl5iTOMZgJuf237zVIXD7IHpdPNlh6YB222wxs7UT7EMKrPQO
         sqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPi3GWFf6k778V89ksbErMgoKxDVX/Ki9ZfOEswj8Wc=;
        b=m1BATK9BAPOwILpy25YUweA7AkhymsMhDUac9gJnYOij+inqTRArZzS7GPaoAouvtE
         x5xBTXP8utpP/OeovMRSAYkwp01pQISzYg1sgKJ3n2+n7VdyUao77y15HChBruEysXaU
         49qlvrd7ccrkxsNNGCHAkJ5xUqn8wkaZuMA6fwK2XyTtxtO1xYrPX8QOUiFHeylfpIWe
         eDVGziM8BGs2c+sq6TSWTE0DBTEYqCd5gwOa8FWt3Gq618MCuayy5fVBMTvCKDfX/aRn
         84X9/BXL/I/Gm7kCCCJz1P8twckoh3kaOahv238huTMYrNc3/XFW1o1W5u86tBmTmzQR
         /laQ==
X-Gm-Message-State: AOAM530aQM6NBb3YAugwnQpAYqc09axzq4OE5zm8y8ujUDYVccB4BmGN
        lAahifj4+7vvSmybFBOeqZj4LQ==
X-Google-Smtp-Source: ABdhPJwKq/kRYVK1eC9epDFRwCi1he4uYcedqIqwnaRlTJ+gR4PxjYAyPW6kePP1pp+RxJJxyZZBQg==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr11586488wmi.19.1620246389196;
        Wed, 05 May 2021 13:26:29 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a15sm497245wrr.53.2021.05.05.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:26:28 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     chohnstaedt@innominate.com, davem@davemloft.net,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 05/11] crypto: ixp4xx: convert all printk to dev_xxx
Date:   Wed,  5 May 2021 20:26:12 +0000
Message-Id: <20210505202618.2663889-6-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505202618.2663889-1-clabbe@baylibre.com>
References: <20210505202618.2663889-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all old printk to dev_xxx.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/ixp4xx_crypto.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/ixp4xx_crypto.c
index 17de9e60adad..486a388c909f 100644
--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -452,7 +452,7 @@ static int init_ixp_crypto(struct device *dev)
 
 	if (! ( ~(*IXP4XX_EXP_CFG2) & (IXP4XX_FEATURE_HASH |
 				IXP4XX_FEATURE_AES | IXP4XX_FEATURE_DES))) {
-		printk(KERN_ERR "ixp_crypto: No HW crypto available\n");
+		dev_err(dev, "ixp_crypto: No HW crypto available\n");
 		return ret;
 	}
 	npe_c = npe_request(NPE_ID);
@@ -475,8 +475,7 @@ static int init_ixp_crypto(struct device *dev)
 
 	switch ((msg[1]>>16) & 0xff) {
 	case 3:
-		printk(KERN_WARNING "Firmware of %s lacks AES support\n",
-				npe_name(npe_c));
+		dev_warn(dev, "Firmware of %s lacks AES support\n", npe_name(npe_c));
 		support_aes = 0;
 		break;
 	case 4:
@@ -484,8 +483,7 @@ static int init_ixp_crypto(struct device *dev)
 		support_aes = 1;
 		break;
 	default:
-		printk(KERN_ERR "Firmware of %s lacks crypto support\n",
-			npe_name(npe_c));
+		dev_err(dev, "Firmware of %s lacks crypto support\n", npe_name(npe_c));
 		ret = -ENODEV;
 		goto npe_release;
 	}
@@ -521,7 +519,7 @@ static int init_ixp_crypto(struct device *dev)
 	return 0;
 
 npe_error:
-	printk(KERN_ERR "%s not responding\n", npe_name(npe_c));
+	dev_err(dev, "%s not responding\n", npe_name(npe_c));
 	ret = -EIO;
 err:
 	dma_pool_destroy(ctx_pool);
@@ -1487,7 +1485,7 @@ static int __init ixp_module_init(void)
 		cra->base.cra_alignmask = 3;
 		cra->base.cra_priority = 300;
 		if (crypto_register_skcipher(cra))
-			printk(KERN_ERR "Failed to register '%s'\n",
+			dev_err(&pdev->dev, "Failed to register '%s'\n",
 				cra->base.cra_name);
 		else
 			ixp4xx_algos[i].registered = 1;
@@ -1520,7 +1518,7 @@ static int __init ixp_module_init(void)
 		cra->base.cra_priority = 300;
 
 		if (crypto_register_aead(cra))
-			printk(KERN_ERR "Failed to register '%s'\n",
+			dev_err(&pdev->dev, "Failed to register '%s'\n",
 				cra->base.cra_driver_name);
 		else
 			ixp4xx_aeads[i].registered = 1;
-- 
2.26.3

