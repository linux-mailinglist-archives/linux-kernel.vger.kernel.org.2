Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EBF4240F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbhJFPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:13:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:30699 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239000AbhJFPNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:13:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="223411168"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="223411168"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 08:04:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="545297465"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2021 08:04:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 629771C8; Wed,  6 Oct 2021 18:04:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] ASoC: Intel: bytcr_rt5651: use devm_clk_get_optional() for mclk
Date:   Wed,  6 Oct 2021 18:04:50 +0300
Message-Id: <20211006150451.16561-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006150451.16561-1-andriy.shevchenko@linux.intel.com>
References: <20211006150451.16561-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get_optional() helper returns NULL when devm_clk_get()
returns -ENOENT. This makes things slightly cleaner. The added benefit
is mostly cosmetic.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 69 ++++++++++++---------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 36f63516f0cb..28c561302e69 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -188,13 +188,10 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	}
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
-			ret = clk_prepare_enable(priv->mclk);
-			if (ret < 0) {
-				dev_err(card->dev,
-					"could not configure MCLK state");
-				return ret;
-			}
+		ret = clk_prepare_enable(priv->mclk);
+		if (ret < 0) {
+			dev_err(card->dev, "could not configure MCLK state");
+			return ret;
 		}
 		ret = byt_rt5651_prepare_and_enable_pll1(codec_dai, 48000, 50);
 	} else {
@@ -207,8 +204,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 					     48000 * 512,
 					     SND_SOC_CLOCK_IN);
 		if (!ret)
-			if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
-				clk_disable_unprepare(priv->mclk);
+			clk_disable_unprepare(priv->mclk);
 	}
 
 	if (ret < 0) {
@@ -629,29 +625,25 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
-		/*
-		 * The firmware might enable the clock at
-		 * boot (this information may or may not
-		 * be reflected in the enable clock register).
-		 * To change the rate we must disable the clock
-		 * first to cover these cases. Due to common
-		 * clock framework restrictions that do not allow
-		 * to disable a clock that has not been enabled,
-		 * we need to enable the clock first.
-		 */
-		ret = clk_prepare_enable(priv->mclk);
-		if (!ret)
-			clk_disable_unprepare(priv->mclk);
+	/*
+	 * The firmware might enable the clock at boot (this information
+	 * may or may not be reflected in the enable clock register).
+	 * To change the rate we must disable the clock first to cover
+	 * these cases. Due to common clock framework restrictions that
+	 * do not allow to disable a clock that has not been enabled,
+	 * we need to enable the clock first.
+	 */
+	ret = clk_prepare_enable(priv->mclk);
+	if (!ret)
+		clk_disable_unprepare(priv->mclk);
 
-		if (byt_rt5651_quirk & BYT_RT5651_MCLK_25MHZ)
-			ret = clk_set_rate(priv->mclk, 25000000);
-		else
-			ret = clk_set_rate(priv->mclk, 19200000);
+	if (byt_rt5651_quirk & BYT_RT5651_MCLK_25MHZ)
+		ret = clk_set_rate(priv->mclk, 25000000);
+	else
+		ret = clk_set_rate(priv->mclk, 19200000);
 
-		if (ret)
-			dev_err(card->dev, "unable to set MCLK rate\n");
-	}
+	if (ret)
+		dev_err(card->dev, "unable to set MCLK rate\n");
 
 	report = 0;
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk))
@@ -1064,21 +1056,20 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		byt_rt5651_dais[dai_index].cpus->dai_name = "ssp0-port";
 
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
-		priv->mclk = devm_clk_get(dev, "pmc_plt_clk_3");
+		priv->mclk = devm_clk_get_optional(dev, "pmc_plt_clk_3");
 		if (IS_ERR(priv->mclk)) {
 			ret_val = PTR_ERR(priv->mclk);
 			dev_err(dev,
 				"Failed to get MCLK from pmc_plt_clk_3: %d\n",
 				ret_val);
-			/*
-			 * Fall back to bit clock usage for -ENOENT (clock not
-			 * available likely due to missing dependencies), bail
-			 * for all other errors, including -EPROBE_DEFER
-			 */
-			if (ret_val != -ENOENT)
-				goto err;
-			byt_rt5651_quirk &= ~BYT_RT5651_MCLK_EN;
+			goto err;
 		}
+		/*
+		 * Fall back to bit clock usage when clock is not
+		 * available likely due to missing dependencies.
+		 */
+		if (!priv->mclk)
+			byt_rt5651_quirk &= ~BYT_RT5651_MCLK_EN;
 	}
 
 	snprintf(byt_rt5651_components, sizeof(byt_rt5651_components),
-- 
2.33.0

