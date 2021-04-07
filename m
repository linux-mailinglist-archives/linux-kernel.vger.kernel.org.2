Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6611F35688A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350427AbhDGJ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346426AbhDGJ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:56:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94CBC061756;
        Wed,  7 Apr 2021 02:56:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso865035wmi.0;
        Wed, 07 Apr 2021 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XI8zjCWrHrG5RIk4b3Hbm5Q3Z+HRUCQWg5bfMzD9Jsw=;
        b=PFu66/SNVZwtKmaSFIdn/9ceMMmMfrg5wm0jZCzFUOkxp7UMTjNzv+rpxe0GGHZd2t
         OyUq7Wdpon8ac2O4cHKkqaff7q9WnGVUzBrPFeGiEbUVFvKU3kWjyer2a4ATgUMZDm9b
         0J+3qUscAHVFfQyzTikzaUaXOOBRcJpsZErg1MNFGMuYnF2lN6VKu3TiA75OUhjxYsNX
         +i2RPqiOvBGzHehsYWL1vZn/9M3gxc2B7kw4cXkDaED/e5vGrrRg2FJQhKOh1zPdOaL6
         tfxlWfOxCek89UCQERc0S+8OmZU2a/9n3S87Bzw6VAKoruJH54FsPLrqQkBgpdiqxosf
         u4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XI8zjCWrHrG5RIk4b3Hbm5Q3Z+HRUCQWg5bfMzD9Jsw=;
        b=q/fZF/Ch5A2Ala9pq02Z3pRAxvOcfFGP9jewAvkgElwlU3VAMSeS31xoFu/i1q7PeL
         TEusAmmfynEW0DqgwP6LS2DUOD7HQkWJ9mfptvS0NraI8YY56oTZHXfztbVR0jM1QyFc
         /4pDrwE5Qo7Rgj1yyIbQS5LMWBOsJbLbKuZ5duGsEYLNVcha6KTLtcwx1iSvHal77l7E
         oiMVjennAhf1ouWe1TTmL1BsgK8nzh8zDCuXzfJg4kAskqULSAFBwW6onKezJ96d72dE
         496uQiGn5lfLEVJ7RfqB5RLa/1J9qcX3pofXFNnBMocraoXw1YhDYsUiS1NANdqdyFWg
         YBPw==
X-Gm-Message-State: AOAM533xgA1legbLCl5WANRsmPsX8cllPzFPzCYymEXhckHgn/Rj3Eg8
        NPTu34bFgf/vUAz38ngdw+U=
X-Google-Smtp-Source: ABdhPJyFvIZgCudXxRH75W0b0/ObztMY9OZAeZr5OgyvwLXGLUX3a+7dZmd43PJqWcc67lcFZcMvMQ==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr2286646wmc.132.1617789402785;
        Wed, 07 Apr 2021 02:56:42 -0700 (PDT)
Received: from LEGION ([39.46.7.73])
        by smtp.gmail.com with ESMTPSA id u8sm39863959wrr.42.2021.04.07.02.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 02:56:42 -0700 (PDT)
Date:   Wed, 7 Apr 2021 14:56:34 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Cc:     musamaanjum@gmail.com, linqiheng@huawei.com,
        kernel-janitors@vger.kernel.org, dan.carpenter@oracle.com
Subject: [PATCH] ASoC: fsl: sunxi: remove redundant dev_err call
Message-ID: <20210407095634.GA1379642@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource() prints error message in itself. Remove the
dev_err call to avoid redundant error message.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 sound/soc/fsl/fsl_aud2htx.c   | 4 +---
 sound/soc/fsl/fsl_easrc.c     | 4 +---
 sound/soc/sunxi/sun4i-codec.c | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_aud2htx.c b/sound/soc/fsl/fsl_aud2htx.c
index d70d5e75a30c..a328697511f7 100644
--- a/sound/soc/fsl/fsl_aud2htx.c
+++ b/sound/soc/fsl/fsl_aud2htx.c
@@ -198,10 +198,8 @@ static int fsl_aud2htx_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(regs)) {
-		dev_err(&pdev->dev, "failed ioremap\n");
+	if (IS_ERR(regs))
 		return PTR_ERR(regs);
-	}
 
 	aud2htx->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
 						&fsl_aud2htx_regmap_config);
diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 5e33afe87c4a..b1765c7d3bcd 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1889,10 +1889,8 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(regs)) {
-		dev_err(&pdev->dev, "failed ioremap\n");
+	if (IS_ERR(regs))
 		return PTR_ERR(regs);
-	}
 
 	easrc->paddr = res->start;
 
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 2173991c13db..6f3d9148a185 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1711,10 +1711,8 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base)) {
-		dev_err(&pdev->dev, "Failed to map the registers\n");
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	quirks = of_device_get_match_data(&pdev->dev);
 	if (quirks == NULL) {
-- 
2.25.1

