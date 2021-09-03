Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602413FFE6B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349171AbhICKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:53:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35082 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348288AbhICKxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:53:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 21C3F1A3028;
        Fri,  3 Sep 2021 12:52:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DE2561A301F;
        Fri,  3 Sep 2021 12:52:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 79548183AC89;
        Fri,  3 Sep 2021 18:52:43 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-5.15 1/5] ASoC: fsl_sai: register platform component before registering cpu dai
Date:   Fri,  3 Sep 2021 18:30:02 +0800
Message-Id: <1630665006-31437-2-git-send-email-shengjiu.wang@nxp.com>
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

Fixes: 435508214942 ("ASoC: Add SAI SoC Digital Audio Interface driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 223fcd15bfcc..38f6362099d5 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1152,11 +1152,10 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_pm_get_sync;
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
-					      &sai->cpu_dai_drv, 1);
-	if (ret)
-		goto err_pm_get_sync;
-
+	/*
+	 * Register platform component before registering cpu dai for there
+	 * is not defer probe for platform component in snd_soc_add_pcm_runtime().
+	 */
 	if (sai->soc_data->use_imx_pcm) {
 		ret = imx_pcm_dma_init(pdev, IMX_SAI_DMABUF_SIZE);
 		if (ret)
@@ -1167,6 +1166,11 @@ static int fsl_sai_probe(struct platform_device *pdev)
 			goto err_pm_get_sync;
 	}
 
+	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
+					      &sai->cpu_dai_drv, 1);
+	if (ret)
+		goto err_pm_get_sync;
+
 	return ret;
 
 err_pm_get_sync:
-- 
2.17.1

