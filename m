Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEFF3FFE6E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349189AbhICKx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:53:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35170 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348416AbhICKxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:53:48 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E6BCB1A3029;
        Fri,  3 Sep 2021 12:52:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AEB241A3022;
        Fri,  3 Sep 2021 12:52:47 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 49EE0183AD05;
        Fri,  3 Sep 2021 18:52:46 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-5.15 4/5] ASoC: fsl_spdif: register platform component before registering cpu dai
Date:   Fri,  3 Sep 2021 18:30:05 +0800
Message-Id: <1630665006-31437-5-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
References: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no defer probe when adding platform component to
snd_soc_pcm_runtime(rtd), the code is in snd_soc_add_pcm_runtime()

snd_soc_register_card()
  -> snd_soc_bind_card()
    -> snd_soc_add_pcm_runtime()
      -> adding cpu dai
      -> adding codec dai
      -> adding platform component.

So if the platform component is not ready at that time, then the
sound card still registered successfully, but platform component
is empty, the sound card can't be used.

As there is defer probe checking for cpu dai component, then register
platform component before cpu dai to avoid such issue.

Fixes: a2388a498ad2 ("ASoC: fsl: Add S/PDIF CPU DAI driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8ffb1a6048d6..1c53719bb61e 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1434,16 +1434,20 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	regcache_cache_only(spdif_priv->regmap, true);
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_spdif_component,
-					      &spdif_priv->cpu_dai_drv, 1);
+	/*
+	 * Register platform component before registering cpu dai for there
+	 * is not defer probe for platform component in snd_soc_add_pcm_runtime().
+	 */
+	ret = imx_pcm_dma_init(pdev, IMX_SPDIF_DMABUF_SIZE);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "imx_pcm_dma_init failed\n");
 		goto err_pm_disable;
 	}
 
-	ret = imx_pcm_dma_init(pdev, IMX_SPDIF_DMABUF_SIZE);
+	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_spdif_component,
+					      &spdif_priv->cpu_dai_drv, 1);
 	if (ret) {
-		dev_err_probe(&pdev->dev, ret, "imx_pcm_dma_init failed\n");
+		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
 		goto err_pm_disable;
 	}
 
-- 
2.17.1

