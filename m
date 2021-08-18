Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF73EFC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhHRG0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:26:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39040 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239622AbhHRG0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:26:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 629391A1481;
        Wed, 18 Aug 2021 08:25:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2AD7D1A146D;
        Wed, 18 Aug 2021 08:25:30 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BA890183AD27;
        Wed, 18 Aug 2021 14:25:28 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_rpmsg: Check -EPROBE_DEFER for getting clocks
Date:   Wed, 18 Aug 2021 14:03:34 +0800
Message-Id: <1629266614-6942-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get() may return -EPROBE_DEFER, then clocks
will be assigned to NULL wrongly. As the clocks are
optional so we can use devm_clk_get_optional() instead of
devm_clk_get().

Fixes: b73d9e6225e8 ("ASoC: fsl_rpmsg: Add CPU DAI driver for audio base on rpmsg")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_rpmsg.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_rpmsg.c b/sound/soc/fsl/fsl_rpmsg.c
index ea5c973e2e84..d60f4dac6c1b 100644
--- a/sound/soc/fsl/fsl_rpmsg.c
+++ b/sound/soc/fsl/fsl_rpmsg.c
@@ -165,25 +165,25 @@ static int fsl_rpmsg_probe(struct platform_device *pdev)
 	}
 
 	/* Get the optional clocks */
-	rpmsg->ipg = devm_clk_get(&pdev->dev, "ipg");
+	rpmsg->ipg = devm_clk_get_optional(&pdev->dev, "ipg");
 	if (IS_ERR(rpmsg->ipg))
-		rpmsg->ipg = NULL;
+		return PTR_ERR(rpmsg->ipg);
 
-	rpmsg->mclk = devm_clk_get(&pdev->dev, "mclk");
+	rpmsg->mclk = devm_clk_get_optional(&pdev->dev, "mclk");
 	if (IS_ERR(rpmsg->mclk))
-		rpmsg->mclk = NULL;
+		return PTR_ERR(rpmsg->mclk);
 
-	rpmsg->dma = devm_clk_get(&pdev->dev, "dma");
+	rpmsg->dma = devm_clk_get_optional(&pdev->dev, "dma");
 	if (IS_ERR(rpmsg->dma))
-		rpmsg->dma = NULL;
+		return PTR_ERR(rpmsg->dma);
 
-	rpmsg->pll8k = devm_clk_get(&pdev->dev, "pll8k");
+	rpmsg->pll8k = devm_clk_get_optional(&pdev->dev, "pll8k");
 	if (IS_ERR(rpmsg->pll8k))
-		rpmsg->pll8k = NULL;
+		return PTR_ERR(rpmsg->pll8k);
 
-	rpmsg->pll11k = devm_clk_get(&pdev->dev, "pll11k");
+	rpmsg->pll11k = devm_clk_get_optional(&pdev->dev, "pll11k");
 	if (IS_ERR(rpmsg->pll11k))
-		rpmsg->pll11k = NULL;
+		return PTR_ERR(rpmsg->pll11k);
 
 	platform_set_drvdata(pdev, rpmsg);
 	pm_runtime_enable(&pdev->dev);
-- 
2.27.0

