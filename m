Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB6C323097
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhBWSWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:22:13 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58288 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbhBWSVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614104501; x=1645640501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WlBdW8OkU8Utbs2mLu/IxW8JRhVqazuXQqNYXkntaGY=;
  b=URWDCdDfTEcDkFbG7NAYEe6OmPOLD2ddrZ4QfAlm1Bil41aVTvyAbV60
   8HznY/hJ09l5DZ4XAN3P9vZh43vYgfVx5kget7i/PwOMABHb2oM1rAwL/
   /UHIV1y8m5Su4dineOujv3RgPnTqD1MYEJsTHHz+q4OxmhkjXX5LFY4Z3
   vGonwFHOXrHrQy7rVJF7FYr1HooNVa6WZEnXnm6FYfOgXZg/+iskce8Vf
   n1WvXYP1KPAB/6dnjJec26Y6MPmC9J9GbPSW4rNUT3Z5DH4YOW7R7y3cL
   WhC7/V1semx5Xd+qCMlZDEJItYFAcrzBB1h2UDfOPDCMxDjDe5yhUo6NP
   A==;
IronPort-SDR: 8O1ZYUc+JQjPeK3aOdhFfc75OIfeAA5i5qFIfe/ODKq0Wvgn0q9tFlHIXjPlS7VrRlQS4fV5fx
 yFIVpsUlduDl7wyKyqiQgEh/J3sutE0Qh7c87LDtLeEJGTZtfhcCf9OnWH/NeWmSpib8q5rBhk
 b6a/P02BVengUaDdavee9drTrWabK6Svo4gfy/H1HV0ry9/azsI8up7UuTAs6HrlSTsBtZpO6j
 MOkuofglmUZov3e4DIj+Odzng0oDDf4pREroQ0rnKvUFMjo2s71Vx0wX1sKLuyE0aPAoSvnlkO
 1zA=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; 
   d="scan'208";a="107691077"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2021 11:20:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:20:11 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 23 Feb 2021 11:20:08 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 4/7] ASoC: mchp-i2s-mcc: Add multi-channel support for I2S and LEFT_J formats
Date:   Tue, 23 Feb 2021 20:19:26 +0200
Message-ID: <20210223181929.444640-5-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest I2S-MCC available in SAMA7G5 supports multi-channel for I2S and
Left-Justified formats. For this, the new version uses 8 (4 * 2) input and
output pins, with each pin being responsible for 2 channels. This sums up
to a total of 8 channels for synchronous capture and playback.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 0ee01383e307..52d3f43148dc 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
 #include <linux/lcm.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -225,6 +226,10 @@ static const struct regmap_config mchp_i2s_mcc_regmap_config = {
 	.max_register = MCHP_I2SMCC_VERSION,
 };
 
+struct mchp_i2s_mcc_soc_data {
+	unsigned int	data_pin_pair_num;
+};
+
 struct mchp_i2s_mcc_dev {
 	struct wait_queue_head			wq_txrdy;
 	struct wait_queue_head			wq_rxrdy;
@@ -232,6 +237,7 @@ struct mchp_i2s_mcc_dev {
 	struct regmap				*regmap;
 	struct clk				*pclk;
 	struct clk				*gclk;
+	const struct mchp_i2s_mcc_soc_data	*soc;
 	struct snd_dmaengine_dai_dma_data	playback;
 	struct snd_dmaengine_dai_dma_data	capture;
 	unsigned int				fmt;
@@ -549,6 +555,17 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (dev->fmt & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
+		/* for I2S and LEFT_J one pin is needed for every 2 channels */
+		if (channels > dev->soc->data_pin_pair_num * 2) {
+			dev_err(dev->dev,
+				"unsupported number of audio channels: %d\n",
+				channels);
+			return -EINVAL;
+		}
+
+		/* enable for interleaved format */
+		mrb |= MCHP_I2SMCC_MRB_CRAMODE_REGULAR;
+
 		switch (channels) {
 		case 1:
 			if (is_playback)
@@ -558,6 +575,12 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 			break;
 		case 2:
 			break;
+		case 4:
+			mra |= MCHP_I2SMCC_MRA_WIRECFG_I2S_2_TDM_1;
+			break;
+		case 8:
+			mra |= MCHP_I2SMCC_MRA_WIRECFG_I2S_4_TDM_2;
+			break;
 		default:
 			dev_err(dev->dev, "unsupported number of audio channels\n");
 			return -EINVAL;
@@ -869,12 +892,22 @@ static const struct snd_soc_component_driver mchp_i2s_mcc_component = {
 };
 
 #ifdef CONFIG_OF
+static struct mchp_i2s_mcc_soc_data mchp_i2s_mcc_sam9x60 = {
+	.data_pin_pair_num = 1,
+};
+
+static struct mchp_i2s_mcc_soc_data mchp_i2s_mcc_sama7g5 = {
+	.data_pin_pair_num = 4,
+};
+
 static const struct of_device_id mchp_i2s_mcc_dt_ids[] = {
 	{
 		.compatible = "microchip,sam9x60-i2smcc",
+		.data = &mchp_i2s_mcc_sam9x60,
 	},
 	{
 		.compatible = "microchip,sama7g5-i2smcc",
+		.data = &mchp_i2s_mcc_sama7g5,
 	},
 	{ /* sentinel */ }
 };
@@ -932,6 +965,11 @@ static int mchp_i2s_mcc_probe(struct platform_device *pdev)
 		dev->gclk = NULL;
 	}
 
+	dev->soc = of_device_get_match_data(&pdev->dev);
+	if (!dev->soc) {
+		dev_err(&pdev->dev, "failed to get soc data\n");
+		return -ENODEV;
+	}
 	dev->dev = &pdev->dev;
 	dev->regmap = regmap;
 	platform_set_drvdata(pdev, dev);
-- 
2.27.0

