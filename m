Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46683A3C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFKGin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:38:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35502 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhFKGil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:38:41 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 40D111A08FB;
        Fri, 11 Jun 2021 08:36:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 40D111A08FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector3; t=1623393403;
        bh=x9r3mjo9myPoai+Ewzu7TLgGVipVL1jSKJszV5CRyXE=;
        h=From:To:Cc:Subject:Date:From;
        b=dV2As57fc9O82/cEtKmI6HJk0DPljB4jatogj/86XEAebYqRX/4RKpBOA9BePqIU5
         UIQgPE7SYQk9WQOueK2IzlTuiB7RxU0+8EEIRibVeDTKY3XU6MtbsBF04LVDA/otdn
         ihRvBSGAYbNbFYVGEfBtc6aFX5xeCLY/E3l5KyEaWFlq5ZOPJc+p+umtrWthrJK7Dv
         X4aKXtpPJNLGOrDWskniLL2Fp2Oxu4lpx1v69XtnAmLAihrFlHMNCgn+JIy3YOL3ik
         IZpRcSpHoaZiqjweEX1wi/MBJh//GC5T2rzSPlyotSY53hY+tdmuOX2VsjJ6awor90
         n/YZAd4UepYiQ==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1DD841A0903;
        Fri, 11 Jun 2021 08:36:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 1DD841A0903
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 48C2740130;
        Fri, 11 Jun 2021 14:36:33 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_spdif: Fix error handler with pm_runtime_enable
Date:   Fri, 11 Jun 2021 14:18:38 +0800
Message-Id: <1623392318-26304-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is error message when defer probe happens:

fsl-spdif-dai 2dab0000.spdif: Unbalanced pm_runtime_enable!

Fix the error handler with pm_runtime_enable and add
fsl_spdif_remove() for pm_runtime_disable.

Fixes: 9cb2b3796e08 ("ASoC: fsl_spdif: Add pm runtime function")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 2a76714eb8e6..76a7c9581333 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1441,16 +1441,29 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 					      &spdif_priv->cpu_dai_drv, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = imx_pcm_dma_init(pdev, IMX_SPDIF_DMABUF_SIZE);
-	if (ret && ret != -EPROBE_DEFER)
-		dev_err(&pdev->dev, "imx_pcm_dma_init failed: %d\n", ret);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "imx_pcm_dma_init failed\n");
+		goto err_pm_disable;
+	}
+
+	return ret;
 
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
+static int fsl_spdif_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int fsl_spdif_runtime_suspend(struct device *dev)
 {
@@ -1554,6 +1567,7 @@ static struct platform_driver fsl_spdif_driver = {
 		.pm = &fsl_spdif_pm,
 	},
 	.probe = fsl_spdif_probe,
+	.remove = fsl_spdif_remove,
 };
 
 module_platform_driver(fsl_spdif_driver);
-- 
2.27.0

