Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEC347590
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhCXKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:13:20 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36556 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhCXKNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:13:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B0EA520273F;
        Wed, 24 Mar 2021 11:13:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6FC7420273E;
        Wed, 24 Mar 2021 11:12:59 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CF5844033C;
        Wed, 24 Mar 2021 11:12:32 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ASoC: fsl_asrc: Don't use devm_regmap_init_mmio_clk
Date:   Wed, 24 Mar 2021 17:58:45 +0800
Message-Id: <1616579928-22428-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616579928-22428-1-git-send-email-shengjiu.wang@nxp.com>
References: <1616579928-22428-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is power domain bind with mem clock,

The call flow:
devm_regmap_init_mmio_clk
   - clk_prepare()
       - clk_pm_runtime_get()

cause the power domain of clock always be enabled after
regmap_init(). which impact the power consumption.

So use devm_regmap_init_mmio instead of
devm_regmap_init_mmio_clk,but explicitly enable
clock when it is used.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 57 +++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 63d236ef5c4d..0e1ad8efebd3 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1008,6 +1008,9 @@ static int fsl_asrc_get_fifo_addr(u8 dir, enum asrc_pair_index index)
 	return REG_ASRDx(dir, index);
 }
 
+static int fsl_asrc_runtime_resume(struct device *dev);
+static int fsl_asrc_runtime_suspend(struct device *dev);
+
 static int fsl_asrc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1039,8 +1042,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 	asrc->paddr = res->start;
 
-	asrc->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "mem", regs,
-						 &fsl_asrc_regmap_config);
+	asrc->regmap = devm_regmap_init_mmio(&pdev->dev, regs, &fsl_asrc_regmap_config);
 	if (IS_ERR(asrc->regmap)) {
 		dev_err(&pdev->dev, "failed to init regmap\n");
 		return PTR_ERR(asrc->regmap);
@@ -1117,12 +1119,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = fsl_asrc_init(asrc);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to init asrc %d\n", ret);
-		return ret;
-	}
-
 	asrc->channel_avail = 10;
 
 	ret = of_property_read_u32(np, "fsl,asrc-rate",
@@ -1161,21 +1157,56 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, asrc);
-	pm_runtime_enable(&pdev->dev);
 	spin_lock_init(&asrc->lock);
-	regcache_cache_only(asrc->regmap, true);
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = fsl_asrc_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		goto err_pm_get_sync;
+	}
+
+	ret = fsl_asrc_init(asrc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to init asrc %d\n", ret);
+		goto err_pm_get_sync;
+	}
+
+	ret = pm_runtime_put_sync(&pdev->dev);
+	if (ret < 0)
+		goto err_pm_get_sync;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
 					      &fsl_asrc_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
-		return ret;
+		goto err_pm_get_sync;
 	}
 
 	return 0;
+
+err_pm_get_sync:
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		fsl_asrc_runtime_suspend(&pdev->dev);
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
+static int fsl_asrc_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		fsl_asrc_runtime_suspend(&pdev->dev);
+
+	return 0;
 }
 
-#ifdef CONFIG_PM
 static int fsl_asrc_runtime_resume(struct device *dev)
 {
 	struct fsl_asrc *asrc = dev_get_drvdata(dev);
@@ -1252,7 +1283,6 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops fsl_asrc_pm = {
 	SET_RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
@@ -1291,6 +1321,7 @@ MODULE_DEVICE_TABLE(of, fsl_asrc_ids);
 
 static struct platform_driver fsl_asrc_driver = {
 	.probe = fsl_asrc_probe,
+	.remove = fsl_asrc_remove,
 	.driver = {
 		.name = "fsl-asrc",
 		.of_match_table = fsl_asrc_ids,
-- 
2.27.0

