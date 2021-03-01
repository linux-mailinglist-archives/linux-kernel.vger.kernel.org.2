Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0838329373
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbhCAVTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:19:20 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49811 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbhCARPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614618944; x=1646154944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qxIVc6oSv0cMcN+IvnHsmgb2hZt7rxob4UbuRztljGQ=;
  b=WX/wAhn6o6B0Xlu/TQ9nnLpblG9m2y3pH5nPgDMGb9BPyXh3ouaaMJnT
   m/OxUM6ePED6j/da9O/o3aHIBM27Fhb/NW5Agy+lZlV3w+m5GeF8cg97w
   azGtvyTSikWctq+fvf9hW1NAp4LA00Rh22BoY9Wzf6tYYQhTfGrneqUWM
   oC/e1d5yeWhzy7cyU1sNxyxFmaM0YTfZpU5XvqkM/dkLZBGK4uetol75a
   ooglOH7xJme8w9JAO1Rxaa5wnNtDIJo35FVYIMfHclns36S49Svi94OOZ
   BcVuLSMHaG2g4M6F3uJgNa4iiqkEnoayldBIoqn8F9wB8EYFxXzRyd40V
   A==;
IronPort-SDR: ouQp64EpkoFzkGEpe9Edckk9eZxqBHwSFOkVsrV/mS/Eenz4yoe6ULQlNFpZBzIcd5p6RxuBK+
 KXozG9SfEaMGX4mgAEW8eY5HZGhD7f4D4wfjRA8BNKXAClp73rmRKBiR+CHEsVNLkotilokq10
 1LofJU0NNl55iaH+HKYZgkA2jbgHoKARwilvugl8Q7TjijwRV3qIFTrSNl1pVc/l82wUXUQjAG
 s6MuSYhDdT98yBBbFPAO7CYn2ZYk9OmcWCdKsO75cgeBVZkIFBEybQa/7x3pYXAWxuUELo7P78
 fMI=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="111511733"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 10:09:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 10:09:53 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 10:09:50 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 5/7] ASoC: mchp-i2s-mcc: Add support to select TDM pins
Date:   Mon, 1 Mar 2021 19:09:03 +0200
Message-ID: <20210301170905.835091-6-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5's I2S-MCC has 4 pairs of DIN/DOUT pins. Since TDM only uses a
single pair of pins for synchronous capture and playback, the controller
needs to be told which of the pair is connected. This can be mentioned
using the "microchip,tdm-data-pair" property from DT. The property is
optional, useful only if TDM is used. If it's missing, DIN/DOUT 0 pins
will be used by default.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
- none

 sound/soc/atmel/mchp-i2s-mcc.c | 52 +++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 52d3f43148dc..515ba3634fdd 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -100,6 +100,8 @@
 #define MCHP_I2SMCC_MRA_DATALENGTH_8_BITS_COMPACT	(7 << 1)
 
 #define MCHP_I2SMCC_MRA_WIRECFG_MASK		GENMASK(5, 4)
+#define MCHP_I2SMCC_MRA_WIRECFG_TDM(pin)	(((pin) << 4) & \
+						 MCHP_I2SMCC_MRA_WIRECFG_MASK)
 #define MCHP_I2SMCC_MRA_WIRECFG_I2S_1_TDM_0	(0 << 4)
 #define MCHP_I2SMCC_MRA_WIRECFG_I2S_2_TDM_1	(1 << 4)
 #define MCHP_I2SMCC_MRA_WIRECFG_I2S_4_TDM_2	(2 << 4)
@@ -245,6 +247,7 @@ struct mchp_i2s_mcc_dev {
 	unsigned int				frame_length;
 	int					tdm_slots;
 	int					channels;
+	u8					tdm_data_pair;
 	unsigned int				gclk_use:1;
 	unsigned int				gclk_running:1;
 	unsigned int				tx_rdy:1;
@@ -589,6 +592,8 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 		if (!frame_length)
 			frame_length = 2 * params_physical_width(params);
 	} else if (dev->fmt & SND_SOC_DAIFMT_DSP_A) {
+		mra |= MCHP_I2SMCC_MRA_WIRECFG_TDM(dev->tdm_data_pair);
+
 		if (dev->tdm_slots) {
 			if (channels % 2 && channels * 2 <= dev->tdm_slots) {
 				/*
@@ -914,6 +919,45 @@ static const struct of_device_id mchp_i2s_mcc_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, mchp_i2s_mcc_dt_ids);
 #endif
 
+static int mchp_i2s_mcc_soc_data_parse(struct platform_device *pdev,
+				       struct mchp_i2s_mcc_dev *dev)
+{
+	int err;
+
+	if (!dev->soc) {
+		dev_err(&pdev->dev, "failed to get soc data\n");
+		return -ENODEV;
+	}
+
+	if (dev->soc->data_pin_pair_num == 1)
+		return 0;
+
+	err = of_property_read_u8(pdev->dev.of_node, "microchip,tdm-data-pair",
+				  &dev->tdm_data_pair);
+	if (err < 0 && err != -EINVAL) {
+		dev_err(&pdev->dev,
+			"bad property data for 'microchip,tdm-data-pair': %d",
+			err);
+		return err;
+	}
+	if (err == -EINVAL) {
+		dev_info(&pdev->dev,
+			 "'microchip,tdm-data-pair' not found; assuming DIN/DOUT 0 for TDM\n");
+		dev->tdm_data_pair = 0;
+	} else {
+		if (dev->tdm_data_pair > dev->soc->data_pin_pair_num - 1) {
+			dev_err(&pdev->dev,
+				"invalid value for 'microchip,tdm-data-pair': %d\n",
+				dev->tdm_data_pair);
+			return -EINVAL;
+		}
+		dev_dbg(&pdev->dev, "TMD format on DIN/DOUT %d pins\n",
+			dev->tdm_data_pair);
+	}
+
+	return 0;
+}
+
 static int mchp_i2s_mcc_probe(struct platform_device *pdev)
 {
 	struct mchp_i2s_mcc_dev *dev;
@@ -966,10 +1010,10 @@ static int mchp_i2s_mcc_probe(struct platform_device *pdev)
 	}
 
 	dev->soc = of_device_get_match_data(&pdev->dev);
-	if (!dev->soc) {
-		dev_err(&pdev->dev, "failed to get soc data\n");
-		return -ENODEV;
-	}
+	err = mchp_i2s_mcc_soc_data_parse(pdev, dev);
+	if (err < 0)
+		return err;
+
 	dev->dev = &pdev->dev;
 	dev->regmap = regmap;
 	platform_set_drvdata(pdev, dev);
-- 
2.27.0

