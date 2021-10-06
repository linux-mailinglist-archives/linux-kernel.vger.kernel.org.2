Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCAE4240F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbhJFPNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:13:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:30673 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239124AbhJFPNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:13:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="223411116"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="223411116"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 08:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="484153985"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Oct 2021 08:04:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3751170; Wed,  6 Oct 2021 18:04:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] ASoC: Intel: bytcr_rt5640: Use temporary variable for struct device
Date:   Wed,  6 Oct 2021 18:04:40 +0300
Message-Id: <20211006150442.16503-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006150442.16503-1-andriy.shevchenko@linux.intel.com>
References: <20211006150442.16503-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 32 +++++++++++++--------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 43997048a825..0f609a0b3527 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1511,12 +1511,12 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	int aif;
 
 	is_bytcr = false;
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	/* register the soc card */
-	byt_rt5640_card.dev = &pdev->dev;
+	byt_rt5640_card.dev = dev;
 	snd_soc_card_set_drvdata(&byt_rt5640_card, priv);
 
 	/* fix index of codec dai */
@@ -1536,7 +1536,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		put_device(&adev->dev);
 		byt_rt5640_dais[dai_index].codecs->name = byt_rt5640_codec_name;
 	} else {
-		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
 		return -ENXIO;
 	}
 
@@ -1579,13 +1579,13 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 							       &pkg_ctx);
 		if (pkg_found) {
 			if (chan_package.aif_value == 1) {
-				dev_info(&pdev->dev, "BIOS Routing: AIF1 connected\n");
+				dev_info(dev, "BIOS Routing: AIF1 connected\n");
 				byt_rt5640_quirk |= BYT_RT5640_SSP0_AIF1;
 			} else  if (chan_package.aif_value == 2) {
-				dev_info(&pdev->dev, "BIOS Routing: AIF2 connected\n");
+				dev_info(dev, "BIOS Routing: AIF2 connected\n");
 				byt_rt5640_quirk |= BYT_RT5640_SSP0_AIF2;
 			} else {
-				dev_info(&pdev->dev, "BIOS Routing isn't valid, ignored\n");
+				dev_info(dev, "BIOS Routing isn't valid, ignored\n");
 				pkg_found = false;
 			}
 		}
@@ -1609,7 +1609,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	if (dmi_id)
 		byt_rt5640_quirk = (unsigned long)dmi_id->driver_data;
 	if (quirk_override != -1) {
-		dev_info(&pdev->dev, "Overriding quirk 0x%lx => 0x%x\n",
+		dev_info(dev, "Overriding quirk 0x%lx => 0x%x\n",
 			 byt_rt5640_quirk, quirk_override);
 		byt_rt5640_quirk = quirk_override;
 	}
@@ -1623,12 +1623,12 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		acpi_dev_add_driver_gpios(ACPI_COMPANION(priv->codec_dev),
 					  byt_rt5640_hp_elitepad_1000g2_gpios);
 
-		priv->hsmic_detect = devm_fwnode_gpiod_get(&pdev->dev, codec_dev->fwnode,
+		priv->hsmic_detect = devm_fwnode_gpiod_get(dev, codec_dev->fwnode,
 							   "headset-mic-detect", GPIOD_IN,
 							   "headset-mic-detect");
 		if (IS_ERR(priv->hsmic_detect)) {
 			ret_val = PTR_ERR(priv->hsmic_detect);
-			dev_err_probe(&pdev->dev, ret_val, "getting hsmic-detect GPIO\n");
+			dev_err_probe(dev, ret_val, "getting hsmic-detect GPIO\n");
 			goto err_device;
 		}
 	}
@@ -1638,7 +1638,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	if (ret_val)
 		goto err_remove_gpios;
 
-	log_quirks(&pdev->dev);
+	log_quirks(dev);
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
 	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
@@ -1653,11 +1653,11 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		byt_rt5640_dais[dai_index].cpus->dai_name = "ssp0-port";
 
 	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN) {
-		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+		priv->mclk = devm_clk_get(dev, "pmc_plt_clk_3");
 		if (IS_ERR(priv->mclk)) {
 			ret_val = PTR_ERR(priv->mclk);
 
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"Failed to get MCLK from pmc_plt_clk_3: %d\n",
 				ret_val);
 
@@ -1713,7 +1713,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	if (ret_val)
 		goto err;
 
-	sof_parent = snd_soc_acpi_sof_parent(&pdev->dev);
+	sof_parent = snd_soc_acpi_sof_parent(dev);
 
 	/* set card and driver name */
 	if (sof_parent) {
@@ -1728,11 +1728,9 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	if (sof_parent)
 		dev->driver->pm = &snd_soc_pm_ops;
 
-	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
-
+	ret_val = devm_snd_soc_register_card(dev, &byt_rt5640_card);
 	if (ret_val) {
-		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
-			ret_val);
+		dev_err(dev, "devm_snd_soc_register_card failed %d\n", ret_val);
 		goto err;
 	}
 	platform_set_drvdata(pdev, &byt_rt5640_card);
-- 
2.33.0

