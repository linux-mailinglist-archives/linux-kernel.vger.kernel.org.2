Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F44258C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbhJGRFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:05:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:1126 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241576AbhJGRFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:05:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="312503949"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="312503949"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:02:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="439609191"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2021 10:02:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 56A1C170; Thu,  7 Oct 2021 20:02:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/4] ASoC: Intel: bytcr_rt5651: Use temporary variable for struct device
Date:   Thu,  7 Oct 2021 20:02:48 +0300
Message-Id: <20211007170250.27997-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007170250.27997-1-andriy.shevchenko@linux.intel.com>
References: <20211007170250.27997-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 42 ++++++++++++---------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 2335cca17cc8..36f63516f0cb 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -907,12 +907,12 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	int dai_index = 0;
 	int i;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	/* register the soc card */
-	byt_rt5651_card.dev = &pdev->dev;
+	byt_rt5651_card.dev = dev;
 	snd_soc_card_set_drvdata(&byt_rt5651_card, priv);
 
 	/* fix index of codec dai */
@@ -932,7 +932,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		put_device(&adev->dev);
 		byt_rt5651_dais[dai_index].codecs->name = byt_rt5651_codec_name;
 	} else {
-		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
 		return -ENXIO;
 	}
 
@@ -980,13 +980,13 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 							       &pkg_ctx);
 		if (pkg_found) {
 			if (chan_package.aif_value == 1) {
-				dev_info(&pdev->dev, "BIOS Routing: AIF1 connected\n");
+				dev_info(dev, "BIOS Routing: AIF1 connected\n");
 				byt_rt5651_quirk |= BYT_RT5651_SSP0_AIF1;
 			} else  if (chan_package.aif_value == 2) {
-				dev_info(&pdev->dev, "BIOS Routing: AIF2 connected\n");
+				dev_info(dev, "BIOS Routing: AIF2 connected\n");
 				byt_rt5651_quirk |= BYT_RT5651_SSP0_AIF2;
 			} else {
-				dev_info(&pdev->dev, "BIOS Routing isn't valid, ignored\n");
+				dev_info(dev, "BIOS Routing isn't valid, ignored\n");
 				pkg_found = false;
 			}
 		}
@@ -1001,7 +1001,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	dmi_check_system(byt_rt5651_quirk_table);
 
 	if (quirk_override != -1) {
-		dev_info(&pdev->dev, "Overriding quirk 0x%lx => 0x%x\n",
+		dev_info(dev, "Overriding quirk 0x%lx => 0x%x\n",
 			 byt_rt5651_quirk, quirk_override);
 		byt_rt5651_quirk = quirk_override;
 	}
@@ -1017,8 +1017,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	if (byt_rt5651_gpios) {
 		devm_acpi_dev_add_driver_gpios(codec_dev, byt_rt5651_gpios);
-		priv->ext_amp_gpio = devm_fwnode_gpiod_get(&pdev->dev,
-							   codec_dev->fwnode,
+		priv->ext_amp_gpio = devm_fwnode_gpiod_get(dev, codec_dev->fwnode,
 							   "ext-amp-enable",
 							   GPIOD_OUT_LOW,
 							   "speaker-amp");
@@ -1029,15 +1028,13 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 				priv->ext_amp_gpio = NULL;
 				break;
 			default:
-				dev_err(&pdev->dev, "Failed to get ext-amp-enable GPIO: %d\n",
-					ret_val);
+				dev_err(dev, "Failed to get ext-amp-enable GPIO: %d\n", ret_val);
 				fallthrough;
 			case -EPROBE_DEFER:
 				goto err;
 			}
 		}
-		priv->hp_detect = devm_fwnode_gpiod_get(&pdev->dev,
-							codec_dev->fwnode,
+		priv->hp_detect = devm_fwnode_gpiod_get(dev, codec_dev->fwnode,
 							"hp-detect",
 							GPIOD_IN,
 							"hp-detect");
@@ -1048,8 +1045,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 				priv->hp_detect = NULL;
 				break;
 			default:
-				dev_err(&pdev->dev, "Failed to get hp-detect GPIO: %d\n",
-					ret_val);
+				dev_err(dev, "Failed to get hp-detect GPIO: %d\n", ret_val);
 				fallthrough;
 			case -EPROBE_DEFER:
 				goto err;
@@ -1057,7 +1053,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		}
 	}
 
-	log_quirks(&pdev->dev);
+	log_quirks(dev);
 
 	if ((byt_rt5651_quirk & BYT_RT5651_SSP2_AIF2) ||
 	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2))
@@ -1068,10 +1064,10 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		byt_rt5651_dais[dai_index].cpus->dai_name = "ssp0-port";
 
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
-		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+		priv->mclk = devm_clk_get(dev, "pmc_plt_clk_3");
 		if (IS_ERR(priv->mclk)) {
 			ret_val = PTR_ERR(priv->mclk);
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"Failed to get MCLK from pmc_plt_clk_3: %d\n",
 				ret_val);
 			/*
@@ -1111,7 +1107,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	if (ret_val)
 		goto err;
 
-	sof_parent = snd_soc_acpi_sof_parent(&pdev->dev);
+	sof_parent = snd_soc_acpi_sof_parent(dev);
 
 	/* set card and driver name */
 	if (sof_parent) {
@@ -1124,13 +1120,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* set pm ops */
 	if (sof_parent)
-		pdev->dev.driver->pm = &snd_soc_pm_ops;
-
-	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5651_card);
+		dev->driver->pm = &snd_soc_pm_ops;
 
+	ret_val = devm_snd_soc_register_card(dev, &byt_rt5651_card);
 	if (ret_val) {
-		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
-			ret_val);
+		dev_err(dev, "devm_snd_soc_register_card failed %d\n", ret_val);
 		goto err;
 	}
 	platform_set_drvdata(pdev, &byt_rt5651_card);
-- 
2.33.0

