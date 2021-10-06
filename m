Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5D4240BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbhJFPGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:06:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:30929 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239160AbhJFPGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:06:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="286894749"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="286894749"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 08:04:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="524292567"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2021 08:04:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 02956291; Wed,  6 Oct 2021 18:04:31 +0300 (EEST)
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
Subject: [PATCH v1 4/4] ASoC: Intel: bytcht_es8316: Utilize dev_err_probe() to avoid log saturation
Date:   Wed,  6 Oct 2021 18:04:28 +0300
Message-Id: <20211006150428.16434-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
References: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() avoids printing into log when the deferred probe is invoked.
This is possible when clock provider is pending to appear.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index d8dcf63825a6..9d86fea51a7d 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -532,11 +532,8 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 	/* get the clock */
 	priv->mclk = devm_clk_get(dev, "pmc_plt_clk_3");
-	if (IS_ERR(priv->mclk)) {
-		ret = PTR_ERR(priv->mclk);
-		dev_err(dev, "clk_get pmc_plt_clk_3 failed: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->mclk))
+		return dev_err_probe(dev, PTR_ERR(priv->mclk), "clk_get pmc_plt_clk_3 failed\n");
 
 	/* get speaker enable GPIO */
 	codec_dev = acpi_get_first_physical_node(adev);
@@ -570,14 +567,9 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 				   /* see comment in byt_cht_es8316_resume() */
 				   GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(priv->speaker_en_gpio)) {
-		ret = PTR_ERR(priv->speaker_en_gpio);
-		switch (ret) {
-		default:
-			dev_err(dev, "get speaker GPIO failed: %d\n", ret);
-			fallthrough;
-		case -EPROBE_DEFER:
-			goto err_put_codec;
-		}
+		ret = dev_err_probe(dev, PTR_ERR(priv->speaker_en_gpio),
+				    "get speaker GPIO failed\n");
+		goto err_put_codec;
 	}
 
 	snprintf(components_string, sizeof(components_string),
-- 
2.33.0

