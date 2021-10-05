Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A449F42280D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbhJENif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhJENie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:38:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14CC061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:36:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v25so26662643wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hifiberry-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HI3bSkrp3b1PdSFwtMxl1Mcd3MR3xcdLLc2dQS+n8dk=;
        b=YBQ1m7Qv51bnxcnFZm5MgymY0C7kLQF934bTkN4WJzhlz14IpC/a8/YjIWdE2hQpRz
         gkYAQfWib9gwtXm1WIzobGJouJWIY7gCtu+0PnFETVwMtVwRiMCVdkl8UIkFtRaFwAtB
         CASEtMnDmG4TvHdVX3j9YDM6P7IBYqngY4itkVIjahq6sefQ9t9ca1YOXGbFM+lAeAcR
         f/Tb67MnSQS5ZPU8jR5xIRfhKqCGlJKG5aZ2tCR4HcY3vdepKC9CNK+Yv+j5fLagZxc+
         hVLCqfvUFeVJ73kswQq1wa4cK48nIYQxcWq8Tzr9CAns30wkN0Zo8JmGl6oNQ9mVoVrN
         iSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HI3bSkrp3b1PdSFwtMxl1Mcd3MR3xcdLLc2dQS+n8dk=;
        b=n2Wi+QlwD4g9KwhnbHkovtaa2Gw0bYpmU4jsHQaMSS2Cpq8iiMSuScwO9eUx1Jq/mm
         D+8a5M7JRR6QNK920NhQ5nv5/ysK0NEx8GNnlyA1VxhhM8a0RCEl0uNRRpgquUnAVE8r
         YpFtvhrbLlI4Gd4jG/NrhXhLpldTzMd2n12x/Mpt7yDf0EY9BjcQJQYeWubPZV5eyfgb
         rn4AeLsL2v5qUO8wzeYBKp36yVRsFXKlurwIFeGhZPU6X43QY0GQLZxpvtGmOkKSWtf3
         KvhFJtbasR6ye37NFqNH5dc4xXqVS+NVioWNgv60kxdHUPgpzSXmB2feh/e7vW+wFDpy
         87HA==
X-Gm-Message-State: AOAM530V8sixHx13bIagRd/TENBN73QCA2yavq+e4dFuhGU2QbW3CMeH
        gh7D6alkhOhoTE7iA2nBiUjpJA==
X-Google-Smtp-Source: ABdhPJxe9IwfIXEQXmzYfsyqzD+CKn9wQPX+tg+Xa9V/zstuND3vB+/H1fqgp+p2QvU3Hx1od9MNPA==
X-Received: by 2002:adf:e604:: with SMTP id p4mr12703091wrm.79.1633441001729;
        Tue, 05 Oct 2021 06:36:41 -0700 (PDT)
Received: from ubuntu.fritz.box ([2a02:810d:1640:10d8:2c9f:4e22:c840:6401])
        by smtp.gmail.com with ESMTPSA id j6sm4054436wrh.76.2021.10.05.06.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:36:41 -0700 (PDT)
From:   Joerg Schambacher <joerg@hifiberry.com>
Cc:     joerg@hifiberry.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jack Yu <jack.yu@realtek.com>, Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Peter Robinson <pbrobinson@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Shuming Fan <shumingf@realtek.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org (open list),
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...)
Subject: [PATCH] sound/soc: adds TAS5754M digital input amplifier component driver
Date:   Tue,  5 Oct 2021 15:35:46 +0200
Message-Id: <20211005133558.5001-1-joerg@hifiberry.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a minimum component driver to run the amplifier in I2S master
mode only from standard audio clocks. Therefore, it only allows
44.1, 88.2, 176.4, 48, 96 and 192ksps with 16, 20, 24 and 32 bits
sample size. Digital volume control and the -6dB switch are supported.

Signed-off-by: Joerg Schambacher <joerg@hifiberry.com>
---
 sound/soc/codecs/Kconfig    |   8 +
 sound/soc/codecs/Makefile   |   2 +
 sound/soc/codecs/tas5754m.c | 547 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas5754m.h | 259 +++++++++++++++++
 4 files changed, 816 insertions(+)
 create mode 100644 sound/soc/codecs/tas5754m.c
 create mode 100644 sound/soc/codecs/tas5754m.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 82ee233a269d..cf0584948fcf 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -210,6 +210,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_TAS5086
 	imply SND_SOC_TAS571X
 	imply SND_SOC_TAS5720
+	imply SND_SOC_TAS5754M
 	imply SND_SOC_TAS6424
 	imply SND_SOC_TDA7419
 	imply SND_SOC_TFA9879
@@ -1419,6 +1420,13 @@ config SND_SOC_TAS5720
 	  Enable support for Texas Instruments TAS5720L/M high-efficiency mono
 	  Class-D audio power amplifiers.
 
+config SND_SOC_TAS5754M
+	tristate "Texas Instruments TAS5754M Digital Input Audio amplifier"
+	depends on I2C
+	help
+	  Enable support for Texas Instruments TAS5754M digital input
+	  Class-D audio power amplifiers.
+
 config SND_SOC_TAS6424
 	tristate "Texas Instruments TAS6424 Quad-Channel Audio amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 8dcea2c4604a..39984900258a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -227,6 +227,7 @@ snd-soc-sti-sas-objs := sti-sas.o
 snd-soc-tas5086-objs := tas5086.o
 snd-soc-tas571x-objs := tas571x.o
 snd-soc-tas5720-objs := tas5720.o
+snd-soc-tas5754m-objs := tas5754m.o
 snd-soc-tas6424-objs := tas6424.o
 snd-soc-tda7419-objs := tda7419.o
 snd-soc-tas2770-objs := tas2770.o
@@ -555,6 +556,7 @@ obj-$(CONFIG_SND_SOC_TAS2764)	+= snd-soc-tas2764.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
 obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
+obj-$(CONFIG_SND_SOC_TAS5754M)	+= snd-soc-tas5754m.o
 obj-$(CONFIG_SND_SOC_TAS6424)	+= snd-soc-tas6424.o
 obj-$(CONFIG_SND_SOC_TDA7419)	+= snd-soc-tda7419.o
 obj-$(CONFIG_SND_SOC_TAS2770) += snd-soc-tas2770.o
diff --git a/sound/soc/codecs/tas5754m.c b/sound/soc/codecs/tas5754m.c
new file mode 100644
index 000000000000..19b16a2c4817
--- /dev/null
+++ b/sound/soc/codecs/tas5754m.c
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the TAS5754M Audio Amplifier in Master mode (only)
+ * supports only standard audio frequencies 44.1 to 192 ksps
+ *
+ * Author: Joerg Schambacher <joerg@hifiberry.com>
+ * with fragments from Andy Liu <andy-liu@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+
+#include <sound/tlv.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+
+#include "tas5754m.h"
+
+#define TAS5754M_RATES		(SNDRV_PCM_RATE_48000  |	\
+				 SNDRV_PCM_RATE_96000  |	\
+				 SNDRV_PCM_RATE_192000 |	\
+				 SNDRV_PCM_RATE_44100  |	\
+				 SNDRV_PCM_RATE_88200  |	\
+				 SNDRV_PCM_RATE_176400)
+#define TAS5754M_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE  | \
+				 SNDRV_PCM_FMTBIT_S20_LE  | \
+				 SNDRV_PCM_FMTBIT_S24_LE  | \
+				 SNDRV_PCM_FMTBIT_S32_LE)
+
+
+static const struct reg_sequence tas5754m_init_sequence[] = {
+	{ TAS5754M_RESET,		0x00 },
+	{ TAS5754M_MUTE,		0x11 },
+	{ TAS5754M_POWER,		0x00 },
+	{ TAS5754M_PLL_EN,		0x00 },
+	{ TAS5754M_RESET,		0x00 },
+	{ TAS5754M_GPIO_OUTPUT_3,	0x02 },
+	{ TAS5754M_GPIO_OUTPUT_4,	0x02 },
+	{ TAS5754M_GPIO_OUTPUT_6,	0x02 },
+	{ TAS5754M_GPIO_EN,		0x2c },
+	{ TAS5754M_GPIO_CONTROL_1,	0x04 },
+	{ TAS5754M_BCLK_LRCLK_CFG,	0x11 },
+	{ TAS5754M_MASTER_MODE,		0x7c },
+	{ TAS5754M_ERROR_DETECT,	0x77 },
+	{ TAS5754M_PLL_EN,		0x01 },
+	{ TAS5754M_PLL_REF,		0x00 },
+	{ TAS5754M_PLL_COEFF_0,		0x03 },
+	{ TAS5754M_PLL_COEFF_1,		0x0c },
+	{ TAS5754M_PLL_COEFF_2,		0x00 },
+	{ TAS5754M_PLL_COEFF_3,		0x00 },
+	{ TAS5754M_PLL_COEFF_4,		0x00 },
+	{ TAS5754M_DAC_REF,		0x30 },
+	{ TAS5754M_DSP_CLKDIV,		0x01 },
+	{ TAS5754M_DAC_CLKDIV,		0x0f },
+	{ TAS5754M_NCP_CLKDIV,		0x03 },
+	{ TAS5754M_OSR_CLKDIV,		0x00 },
+	{ TAS5754M_FS_SPEED_MODE,	0x00 },
+	{ TAS5754M_MASTER_CLKDIV_1,	0x0f },
+	{ TAS5754M_MASTER_CLKDIV_2,	0x1f },
+	{ TAS5754M_I2S_1,		0x00 },
+	{ TAS5754M_I2S_2,		0x01 },
+	{ TAS5754M_PLL_EN,		0x01 },
+	{ TAS5754M_MASTER_MODE,		0x7f },
+	{ TAS5754M_MUTE,		0x11 },
+};
+
+static const struct reg_default tas5754m_reg_defaults[] = {
+	{ TAS5754M_RESET,             0x00 },
+	{ TAS5754M_POWER,             0x00 },
+	{ TAS5754M_MUTE,              0x00 },
+	{ TAS5754M_DSP,               0x00 },
+	{ TAS5754M_PLL_REF,           0x00 },
+	{ TAS5754M_DAC_REF,           0x00 },
+	{ TAS5754M_DAC_ROUTING,       0x11 },
+	{ TAS5754M_DSP_PROGRAM,       0x01 },
+	{ TAS5754M_CLKDET,            0x00 },
+	{ TAS5754M_AUTO_MUTE,         0x00 },
+	{ TAS5754M_ERROR_DETECT,      0x00 },
+	{ TAS5754M_DIGITAL_VOLUME_1,  0x00 },
+	{ TAS5754M_DIGITAL_VOLUME_2,  0x30 },
+	{ TAS5754M_DIGITAL_VOLUME_3,  0x30 },
+	{ TAS5754M_DIGITAL_MUTE_1,    0x22 },
+	{ TAS5754M_DIGITAL_MUTE_2,    0x00 },
+	{ TAS5754M_DIGITAL_MUTE_3,    0x07 },
+	{ TAS5754M_OUTPUT_AMPLITUDE,  0x00 },
+	{ TAS5754M_ANALOG_GAIN_CTRL,  0x00 },
+	{ TAS5754M_UNDERVOLTAGE_PROT, 0x00 },
+	{ TAS5754M_ANALOG_MUTE_CTRL,  0x00 },
+	{ TAS5754M_ANALOG_GAIN_BOOST, 0x00 },
+	{ TAS5754M_VCOM_CTRL_1,       0x00 },
+	{ TAS5754M_VCOM_CTRL_2,       0x01 },
+	{ TAS5754M_BCLK_LRCLK_CFG,    0x00 },
+	{ TAS5754M_MASTER_MODE,       0x7c },
+	{ TAS5754M_GPIO_DACIN,        0x00 },
+	{ TAS5754M_GPIO_PLLIN,        0x00 },
+	{ TAS5754M_SYNCHRONIZE,       0x10 },
+	{ TAS5754M_PLL_COEFF_0,       0x00 },
+	{ TAS5754M_PLL_COEFF_1,       0x00 },
+	{ TAS5754M_PLL_COEFF_2,       0x00 },
+	{ TAS5754M_PLL_COEFF_3,       0x00 },
+	{ TAS5754M_PLL_COEFF_4,       0x00 },
+	{ TAS5754M_DSP_CLKDIV,        0x00 },
+	{ TAS5754M_DAC_CLKDIV,        0x00 },
+	{ TAS5754M_NCP_CLKDIV,        0x00 },
+	{ TAS5754M_OSR_CLKDIV,        0x00 },
+	{ TAS5754M_MASTER_CLKDIV_1,   0x00 },
+	{ TAS5754M_MASTER_CLKDIV_2,   0x00 },
+	{ TAS5754M_FS_SPEED_MODE,     0x00 },
+	{ TAS5754M_IDAC_1,            0x01 },
+	{ TAS5754M_IDAC_2,            0x00 },
+};
+
+static bool tas5754m_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TAS5754M_RESET:
+	case TAS5754M_POWER:
+	case TAS5754M_MUTE:
+	case TAS5754M_PLL_EN:
+	case TAS5754M_SPI_MISO_FUNCTION:
+	case TAS5754M_DSP:
+	case TAS5754M_GPIO_EN:
+	case TAS5754M_BCLK_LRCLK_CFG:
+	case TAS5754M_DSP_GPIO_INPUT:
+	case TAS5754M_MASTER_MODE:
+	case TAS5754M_PLL_REF:
+	case TAS5754M_DAC_REF:
+	case TAS5754M_GPIO_DACIN:
+	case TAS5754M_GPIO_PLLIN:
+	case TAS5754M_SYNCHRONIZE:
+	case TAS5754M_PLL_COEFF_0:
+	case TAS5754M_PLL_COEFF_1:
+	case TAS5754M_PLL_COEFF_2:
+	case TAS5754M_PLL_COEFF_3:
+	case TAS5754M_PLL_COEFF_4:
+	case TAS5754M_DSP_CLKDIV:
+	case TAS5754M_DAC_CLKDIV:
+	case TAS5754M_NCP_CLKDIV:
+	case TAS5754M_OSR_CLKDIV:
+	case TAS5754M_MASTER_CLKDIV_1:
+	case TAS5754M_MASTER_CLKDIV_2:
+	case TAS5754M_FS_SPEED_MODE:
+	case TAS5754M_IDAC_1:
+	case TAS5754M_IDAC_2:
+	case TAS5754M_ERROR_DETECT:
+	case TAS5754M_I2S_1:
+	case TAS5754M_I2S_2:
+	case TAS5754M_DAC_ROUTING:
+	case TAS5754M_DSP_PROGRAM:
+	case TAS5754M_CLKDET:
+	case TAS5754M_AUTO_MUTE:
+	case TAS5754M_DIGITAL_VOLUME_1:
+	case TAS5754M_DIGITAL_VOLUME_2:
+	case TAS5754M_DIGITAL_VOLUME_3:
+	case TAS5754M_DIGITAL_MUTE_1:
+	case TAS5754M_DIGITAL_MUTE_2:
+	case TAS5754M_DIGITAL_MUTE_3:
+	case TAS5754M_GPIO_OUTPUT_1:
+	case TAS5754M_GPIO_OUTPUT_2:
+	case TAS5754M_GPIO_OUTPUT_3:
+	case TAS5754M_GPIO_OUTPUT_4:
+	case TAS5754M_GPIO_OUTPUT_5:
+	case TAS5754M_GPIO_OUTPUT_6:
+	case TAS5754M_GPIO_CONTROL_1:
+	case TAS5754M_GPIO_CONTROL_2:
+	case TAS5754M_OVERFLOW:
+	case TAS5754M_RATE_DET_1:
+	case TAS5754M_RATE_DET_2:
+	case TAS5754M_RATE_DET_3:
+	case TAS5754M_RATE_DET_4:
+	case TAS5754M_CLOCK_STATUS:
+	case TAS5754M_ANALOG_MUTE_DET:
+	case TAS5754M_GPIN:
+	case TAS5754M_DIGITAL_MUTE_DET:
+	case TAS5754M_OUTPUT_AMPLITUDE:
+	case TAS5754M_ANALOG_GAIN_CTRL:
+	case TAS5754M_UNDERVOLTAGE_PROT:
+	case TAS5754M_ANALOG_MUTE_CTRL:
+	case TAS5754M_ANALOG_GAIN_BOOST:
+	case TAS5754M_VCOM_CTRL_1:
+	case TAS5754M_VCOM_CTRL_2:
+	case TAS5754M_CRAM_CTRL:
+	case TAS5754M_FLEX_A:
+	case TAS5754M_FLEX_B:
+		return true;
+	default:
+		return reg < 0x7f;
+	}
+}
+
+static bool tas5754m_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TAS5754M_PLL_EN:
+	case TAS5754M_OVERFLOW:
+	case TAS5754M_RATE_DET_1:
+	case TAS5754M_RATE_DET_2:
+	case TAS5754M_RATE_DET_3:
+	case TAS5754M_RATE_DET_4:
+	case TAS5754M_CLOCK_STATUS:
+	case TAS5754M_ANALOG_MUTE_DET:
+	case TAS5754M_GPIN:
+	case TAS5754M_DIGITAL_MUTE_DET:
+	case TAS5754M_CRAM_CTRL:
+		return true;
+	default:
+		return reg < 0x7f;
+	}
+}
+
+struct tas5754m_priv {
+	struct regmap *regmap;
+	struct clk *sclk;
+};
+
+static const struct regmap_range_cfg tas5754m_range = {
+	.name = "Pages",
+	.range_min = TAS5754M_VIRT_BASE,
+	.range_max = TAS5754M_MAX_REGISTER,
+	.selector_reg = TAS5754M_PAGE,
+	.selector_mask = 0x7f,
+	.window_start = 0,
+	.window_len = 128,
+};
+
+const struct regmap_config tas5754m_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.ranges = &tas5754m_range,
+	.num_ranges = 1,
+	.max_register = TAS5754M_MAX_REGISTER,
+
+	.reg_defaults = tas5754m_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(tas5754m_reg_defaults),
+	.readable_reg = tas5754m_readable,
+	.volatile_reg = tas5754m_volatile,
+
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_GPL(tas5754m_regmap);
+
+static const DECLARE_TLV_DB_SCALE(digital_tlv, -10350, 50, 1);
+static const DECLARE_TLV_DB_SCALE(analog_tlv, -600, 600, 0);
+
+static const struct snd_kcontrol_new tas5754m_controls[] = {
+SOC_DOUBLE_R_TLV("Digital Playback Volume", TAS5754M_DIGITAL_VOLUME_2,
+		 TAS5754M_DIGITAL_VOLUME_3, 0, 255, 1, digital_tlv),
+SOC_DOUBLE_TLV("Analog Playback Volume", TAS5754M_ANALOG_GAIN_CTRL,
+	     TAS5754M_LAGN_SHIFT, TAS5754M_RAGN_SHIFT, 1, 1, analog_tlv),
+};
+
+static int tas5754m_set_bias_level(struct snd_soc_component *component,
+					enum snd_soc_bias_level level)
+{
+	struct tas5754m_priv *tas5754m =
+				snd_soc_component_get_drvdata(component);
+	int ret;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		ret = regmap_update_bits(tas5754m->regmap,
+				TAS5754M_POWER, TAS5754M_RQST, 0);
+		if (ret != 0) {
+			dev_err(component->dev,
+				"Failed to remove standby: %d\n", ret);
+			return ret;
+		}
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		ret = regmap_update_bits(tas5754m->regmap,
+				TAS5754M_POWER, TAS5754M_RQST, TAS5754M_RQST);
+		if (ret != 0) {
+			dev_err(component->dev,
+				"Failed to request standby: %d\n", ret);
+			return ret;
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static int tas5754m_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tas5754m_priv *tas5754m =
+			snd_soc_component_get_drvdata(component);
+	unsigned long bclk;
+	unsigned long mclk;
+	int sample_len;
+	int bclk_div;
+	int lrclk_div;
+	int alen;
+	int ret;
+
+	switch (params_width(params)) {
+	case 16:
+		sample_len = 16;
+		alen = TAS5754M_ALEN_16;
+		break;
+	case 20:
+		sample_len = 32;
+		alen = TAS5754M_ALEN_20;
+		break;
+	case 24:
+		sample_len = 32;
+		alen = TAS5754M_ALEN_24;
+		break;
+	case 32:
+		sample_len = 32;
+		alen = TAS5754M_ALEN_32;
+		break;
+	default:
+		dev_err(component->dev, "Unsupported sample size: %d\n",
+			params_width(params));
+		return -EINVAL;
+	}
+	ret = regmap_update_bits(tas5754m->regmap, TAS5754M_I2S_1, alen, alen);
+	if (ret != 0) {
+		dev_err(component->dev,
+			"Cannot set sample size: %d\n", ret);
+		return ret;
+	}
+
+	switch (params_rate(params)) {
+	case 44100:
+	case 48000:
+		ret = regmap_write(tas5754m->regmap,
+			TAS5754M_FS_SPEED_MODE, TAS5754M_FSSP_48KHZ);
+		break;
+	case 88200:
+	case 96000:
+		ret = regmap_write(tas5754m->regmap,
+			TAS5754M_FS_SPEED_MODE, TAS5754M_FSSP_96KHZ);
+		break;
+	case 176400:
+	case 192000:
+		ret = regmap_write(tas5754m->regmap,
+			TAS5754M_FS_SPEED_MODE, TAS5754M_FSSP_192KHZ);
+		break;
+	default:
+		dev_err(component->dev, "Sample rate not supported: %d\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+	if (ret != 0) {
+		dev_err(component->dev, "Failed to config PLL\n");
+		return ret;
+	}
+
+
+	mclk = clk_get_rate(tas5754m->sclk);
+	bclk = sample_len * 2 * params_rate(params);
+	bclk_div = mclk / bclk;
+	lrclk_div = sample_len * 2;
+
+	// stop LR / SCLK clocks
+	ret = regmap_write(tas5754m->regmap, TAS5754M_MASTER_MODE, 0x7c);
+
+	// set SCLK divider
+	ret |= regmap_write(tas5754m->regmap, TAS5754M_MASTER_CLKDIV_1,
+								bclk_div - 1);
+
+	// set LRCLK divider
+	ret |= regmap_write(tas5754m->regmap, TAS5754M_MASTER_CLKDIV_2,
+								lrclk_div - 1);
+
+	// restart LR / SCLK clocks
+	ret |= regmap_write(tas5754m->regmap, TAS5754M_MASTER_MODE, 0x7f);
+	if (ret != 0) {
+		dev_err(component->dev, "Failed to config PLL\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver tas5754m_soc_component = {
+	.set_bias_level = tas5754m_set_bias_level,
+	.idle_bias_on = true,
+	.controls = tas5754m_controls,
+	.num_controls = ARRAY_SIZE(tas5754m_controls),
+};
+
+static int tas5754m_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_component *component = dai->component;
+
+	if (mute) {
+		snd_soc_component_write(component, TAS5754M_MUTE, 0x11);
+	} else {
+		usleep_range(1000, 2000);
+		snd_soc_component_write(component, TAS5754M_MUTE, 0x00);
+	}
+	return 0;
+}
+
+static const struct snd_soc_dai_ops tas5754m_dai_ops = {
+	.mute_stream = tas5754m_mute,
+	.hw_params = tas5754m_hw_params,
+};
+
+static struct snd_soc_dai_driver tas5754m_dai = {
+	.name		= "tas5754m-amplifier",
+	.playback	= {
+		.stream_name	= "Playback",
+		.channels_min	= 2,
+		.channels_max	= 2,
+		.rates		= TAS5754M_RATES,
+		.formats	= TAS5754M_FORMATS,
+	},
+	.ops = &tas5754m_dai_ops,
+};
+
+static int tas5754m_probe(struct device *dev, struct regmap *regmap)
+{
+	struct tas5754m_priv *tas5754m;
+	int ret;
+
+	tas5754m = devm_kzalloc(dev, sizeof(struct tas5754m_priv), GFP_KERNEL);
+	if (!tas5754m)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, tas5754m);
+	tas5754m->regmap = regmap;
+
+	ret = regmap_multi_reg_write(regmap, tas5754m_init_sequence,
+					ARRAY_SIZE(tas5754m_init_sequence));
+
+	if (ret != 0) {
+		dev_err(dev, "Failed to initialize TAS5754M: %d\n", ret);
+		goto err;
+	}
+
+	tas5754m->sclk = devm_clk_get(dev, NULL);
+	if (PTR_ERR(tas5754m->sclk) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err;
+	}
+	if (!IS_ERR(tas5754m->sclk)) {
+		ret = clk_prepare_enable(tas5754m->sclk);
+		if (ret != 0) {
+			dev_err(dev, "Failed to enable SCLK: %d\n", ret);
+			goto err;
+		}
+	}
+
+	ret = snd_soc_register_component(dev,
+			&tas5754m_soc_component, &tas5754m_dai, 1);
+	if (ret != 0) {
+		dev_err(dev, "Failed to register CODEC: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	return ret;
+
+}
+
+static int tas5754m_i2c_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	struct regmap_config config = tas5754m_regmap;
+
+	/* enable auto-increment mode */
+	config.read_flag_mask = 0x80;
+	config.write_flag_mask = 0x80;
+
+	regmap = devm_regmap_init_i2c(i2c, &config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return tas5754m_probe(&i2c->dev, regmap);
+}
+
+static int tas5754m_remove(struct device *dev)
+{
+	snd_soc_unregister_component(dev);
+
+	return 0;
+}
+
+static int tas5754m_i2c_remove(struct i2c_client *i2c)
+{
+	tas5754m_remove(&i2c->dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id tas5754m_i2c_id[] = {
+	{ "tas5754m", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tas5754m_i2c_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id tas5754m_of_match[] = {
+	{ .compatible = "ti,tas5754m", },
+	{ .compatible = "ti,tas5756m", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tas5754m_of_match);
+#endif
+
+static struct i2c_driver tas5754m_i2c_driver = {
+	.probe		= tas5754m_i2c_probe,
+	.remove		= tas5754m_i2c_remove,
+	.id_table	= tas5754m_i2c_id,
+	.driver		= {
+		.name	= "tas5754m",
+		.of_match_table = tas5754m_of_match,
+	},
+};
+
+module_i2c_driver(tas5754m_i2c_driver);
+
+MODULE_AUTHOR("Joerg Schambacher <joerg@hifiberry.com>");
+MODULE_DESCRIPTION("TAS5754M Audio Amplifier Driver - Master mode only");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tas5754m.h b/sound/soc/codecs/tas5754m.h
new file mode 100644
index 000000000000..492b8abede6c
--- /dev/null
+++ b/sound/soc/codecs/tas5754m.h
@@ -0,0 +1,259 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Driver for the TAS5754M DAC+amplifier combo devices
+ *
+ * Author:	(copied from pcm512x.h)
+ *		Mark Brown <broonie@kernel.org>
+ *		Copyright 2014 Linaro Ltd
+ */
+
+#ifndef _SND_SOC_TAS5754M
+#define _SND_SOC_TAS5754M
+
+#include <linux/pm.h>
+#include <linux/regmap.h>
+
+#define TAS5754M_VIRT_BASE 0x000
+#define TAS5754M_PAGE_LEN  0x80
+#define TAS5754M_PAGE_BASE(n)  (TAS5754M_VIRT_BASE + (TAS5754M_PAGE_LEN * n))
+
+#define TAS5754M_PAGE              0
+
+#define TAS5754M_RESET             (TAS5754M_PAGE_BASE(0) +   1)
+#define TAS5754M_POWER             (TAS5754M_PAGE_BASE(0) +   2)
+#define TAS5754M_MUTE              (TAS5754M_PAGE_BASE(0) +   3)
+#define TAS5754M_PLL_EN            (TAS5754M_PAGE_BASE(0) +   4)
+#define TAS5754M_SPI_MISO_FUNCTION (TAS5754M_PAGE_BASE(0) +   6)
+#define TAS5754M_DSP               (TAS5754M_PAGE_BASE(0) +   7)
+#define TAS5754M_GPIO_EN           (TAS5754M_PAGE_BASE(0) +   8)
+#define TAS5754M_BCLK_LRCLK_CFG    (TAS5754M_PAGE_BASE(0) +   9)
+#define TAS5754M_DSP_GPIO_INPUT    (TAS5754M_PAGE_BASE(0) +  10)
+#define TAS5754M_MASTER_MODE       (TAS5754M_PAGE_BASE(0) +  12)
+#define TAS5754M_PLL_REF           (TAS5754M_PAGE_BASE(0) +  13)
+#define TAS5754M_DAC_REF           (TAS5754M_PAGE_BASE(0) +  14)
+#define TAS5754M_GPIO_DACIN        (TAS5754M_PAGE_BASE(0) +  16)
+#define TAS5754M_GPIO_PLLIN        (TAS5754M_PAGE_BASE(0) +  18)
+#define TAS5754M_SYNCHRONIZE       (TAS5754M_PAGE_BASE(0) +  19)
+#define TAS5754M_PLL_COEFF_0       (TAS5754M_PAGE_BASE(0) +  20)
+#define TAS5754M_PLL_COEFF_1       (TAS5754M_PAGE_BASE(0) +  21)
+#define TAS5754M_PLL_COEFF_2       (TAS5754M_PAGE_BASE(0) +  22)
+#define TAS5754M_PLL_COEFF_3       (TAS5754M_PAGE_BASE(0) +  23)
+#define TAS5754M_PLL_COEFF_4       (TAS5754M_PAGE_BASE(0) +  24)
+#define TAS5754M_DSP_CLKDIV        (TAS5754M_PAGE_BASE(0) +  27)
+#define TAS5754M_DAC_CLKDIV        (TAS5754M_PAGE_BASE(0) +  28)
+#define TAS5754M_NCP_CLKDIV        (TAS5754M_PAGE_BASE(0) +  29)
+#define TAS5754M_OSR_CLKDIV        (TAS5754M_PAGE_BASE(0) +  30)
+#define TAS5754M_MASTER_CLKDIV_1   (TAS5754M_PAGE_BASE(0) +  32)
+#define TAS5754M_MASTER_CLKDIV_2   (TAS5754M_PAGE_BASE(0) +  33)
+#define TAS5754M_FS_SPEED_MODE     (TAS5754M_PAGE_BASE(0) +  34)
+#define TAS5754M_IDAC_1            (TAS5754M_PAGE_BASE(0) +  35)
+#define TAS5754M_IDAC_2            (TAS5754M_PAGE_BASE(0) +  36)
+#define TAS5754M_ERROR_DETECT      (TAS5754M_PAGE_BASE(0) +  37)
+#define TAS5754M_I2S_1             (TAS5754M_PAGE_BASE(0) +  40)
+#define TAS5754M_I2S_2             (TAS5754M_PAGE_BASE(0) +  41)
+#define TAS5754M_DAC_ROUTING       (TAS5754M_PAGE_BASE(0) +  42)
+#define TAS5754M_DSP_PROGRAM       (TAS5754M_PAGE_BASE(0) +  43)
+#define TAS5754M_CLKDET            (TAS5754M_PAGE_BASE(0) +  44)
+#define TAS5754M_AUTO_MUTE         (TAS5754M_PAGE_BASE(0) +  59)
+#define TAS5754M_DIGITAL_VOLUME_1  (TAS5754M_PAGE_BASE(0) +  60)
+#define TAS5754M_DIGITAL_VOLUME_2  (TAS5754M_PAGE_BASE(0) +  61)
+#define TAS5754M_DIGITAL_VOLUME_3  (TAS5754M_PAGE_BASE(0) +  62)
+#define TAS5754M_DIGITAL_MUTE_1    (TAS5754M_PAGE_BASE(0) +  63)
+#define TAS5754M_DIGITAL_MUTE_2    (TAS5754M_PAGE_BASE(0) +  64)
+#define TAS5754M_DIGITAL_MUTE_3    (TAS5754M_PAGE_BASE(0) +  65)
+#define TAS5754M_GPIO_OUTPUT_1     (TAS5754M_PAGE_BASE(0) +  80)
+#define TAS5754M_GPIO_OUTPUT_2     (TAS5754M_PAGE_BASE(0) +  81)
+#define TAS5754M_GPIO_OUTPUT_3     (TAS5754M_PAGE_BASE(0) +  82)
+#define TAS5754M_GPIO_OUTPUT_4     (TAS5754M_PAGE_BASE(0) +  83)
+#define TAS5754M_GPIO_OUTPUT_5     (TAS5754M_PAGE_BASE(0) +  84)
+#define TAS5754M_GPIO_OUTPUT_6     (TAS5754M_PAGE_BASE(0) +  85)
+#define TAS5754M_GPIO_CONTROL_1    (TAS5754M_PAGE_BASE(0) +  86)
+#define TAS5754M_GPIO_CONTROL_2    (TAS5754M_PAGE_BASE(0) +  87)
+#define TAS5754M_OVERFLOW          (TAS5754M_PAGE_BASE(0) +  90)
+#define TAS5754M_RATE_DET_1        (TAS5754M_PAGE_BASE(0) +  91)
+#define TAS5754M_RATE_DET_2        (TAS5754M_PAGE_BASE(0) +  92)
+#define TAS5754M_RATE_DET_3        (TAS5754M_PAGE_BASE(0) +  93)
+#define TAS5754M_RATE_DET_4        (TAS5754M_PAGE_BASE(0) +  94)
+#define TAS5754M_CLOCK_STATUS      (TAS5754M_PAGE_BASE(0) +  95)
+#define TAS5754M_ANALOG_MUTE_DET   (TAS5754M_PAGE_BASE(0) + 108)
+#define TAS5754M_GPIN              (TAS5754M_PAGE_BASE(0) + 119)
+#define TAS5754M_DIGITAL_MUTE_DET  (TAS5754M_PAGE_BASE(0) + 120)
+
+#define TAS5754M_OUTPUT_AMPLITUDE  (TAS5754M_PAGE_BASE(1) +   1)
+#define TAS5754M_ANALOG_GAIN_CTRL  (TAS5754M_PAGE_BASE(1) +   2)
+#define TAS5754M_UNDERVOLTAGE_PROT (TAS5754M_PAGE_BASE(1) +   5)
+#define TAS5754M_ANALOG_MUTE_CTRL  (TAS5754M_PAGE_BASE(1) +   6)
+#define TAS5754M_ANALOG_GAIN_BOOST (TAS5754M_PAGE_BASE(1) +   7)
+#define TAS5754M_VCOM_CTRL_1       (TAS5754M_PAGE_BASE(1) +   8)
+#define TAS5754M_VCOM_CTRL_2       (TAS5754M_PAGE_BASE(1) +   9)
+
+#define TAS5754M_CRAM_CTRL         (TAS5754M_PAGE_BASE(44) +  1)
+
+#define TAS5754M_FLEX_A            (TAS5754M_PAGE_BASE(253) + 63)
+#define TAS5754M_FLEX_B            (TAS5754M_PAGE_BASE(253) + 64)
+
+#define TAS5754M_MAX_REGISTER      (TAS5754M_PAGE_BASE(253) + 64)
+
+/* Page 0, Register 1 - reset */
+#define TAS5754M_RSTR (1 << 0)
+#define TAS5754M_RSTM (1 << 4)
+
+/* Page 0, Register 2 - power */
+#define TAS5754M_RQPD       (1 << 0)
+#define TAS5754M_RQPD_SHIFT 0
+#define TAS5754M_RQST       (1 << 4)
+#define TAS5754M_RQST_SHIFT 4
+
+/* Page 0, Register 3 - mute */
+#define TAS5754M_RQMR (1 << 0)
+#define TAS5754M_RQMR_SHIFT 0
+#define TAS5754M_RQML (1 << 4)
+#define TAS5754M_RQML_SHIFT 4
+
+/* Page 0, Register 4 - PLL */
+#define TAS5754M_PLLE       (1 << 0)
+#define TAS5754M_PLLE_SHIFT 0
+#define TAS5754M_PLCK       (1 << 4)
+#define TAS5754M_PLCK_SHIFT 4
+
+/* Page 0, Register 7 - DSP */
+#define TAS5754M_SDSL       (1 << 0)
+#define TAS5754M_SDSL_SHIFT 0
+#define TAS5754M_DEMP       (1 << 4)
+#define TAS5754M_DEMP_SHIFT 4
+
+/* Page 0, Register 8 - GPIO output enable */
+#define TAS5754M_G1OE       (1 << 0)
+#define TAS5754M_G2OE       (1 << 1)
+#define TAS5754M_G3OE       (1 << 2)
+#define TAS5754M_G4OE       (1 << 3)
+#define TAS5754M_G5OE       (1 << 4)
+#define TAS5754M_G6OE       (1 << 5)
+
+/* Page 0, Register 9 - BCK, LRCLK configuration */
+#define TAS5754M_LRKO       (1 << 0)
+#define TAS5754M_LRKO_SHIFT 0
+#define TAS5754M_BCKO       (1 << 4)
+#define TAS5754M_BCKO_SHIFT 4
+#define TAS5754M_BCKP       (1 << 5)
+#define TAS5754M_BCKP_SHIFT 5
+
+/* Page 0, Register 12 - Master mode BCK, LRCLK reset */
+#define TAS5754M_RLRK       (1 << 0)
+#define TAS5754M_RLRK_SHIFT 0
+#define TAS5754M_RBCK       (1 << 1)
+#define TAS5754M_RBCK_SHIFT 1
+
+/* Page 0, Register 13 - PLL reference */
+#define TAS5754M_SREF        (7 << 4)
+#define TAS5754M_SREF_SHIFT  4
+#define TAS5754M_SREF_SCK    (0 << 4)
+#define TAS5754M_SREF_BCK    (1 << 4)
+#define TAS5754M_SREF_GPIO   (3 << 4)
+
+/* Page 0, Register 14 - DAC reference */
+#define TAS5754M_SDAC        (7 << 4)
+#define TAS5754M_SDAC_SHIFT  4
+#define TAS5754M_SDAC_MCK    (0 << 4)
+#define TAS5754M_SDAC_PLL    (1 << 4)
+#define TAS5754M_SDAC_SCK    (3 << 4)
+#define TAS5754M_SDAC_BCK    (4 << 4)
+#define TAS5754M_SDAC_GPIO   (5 << 4)
+
+/* Page 0, Register 16, 18 - GPIO source for DAC, PLL */
+#define TAS5754M_GREF        (7 << 0)
+#define TAS5754M_GREF_SHIFT  0
+#define TAS5754M_GREF_GPIO1  (0 << 0)
+#define TAS5754M_GREF_GPIO2  (1 << 0)
+#define TAS5754M_GREF_GPIO3  (2 << 0)
+#define TAS5754M_GREF_GPIO4  (3 << 0)
+#define TAS5754M_GREF_GPIO5  (4 << 0)
+#define TAS5754M_GREF_GPIO6  (5 << 0)
+
+/* Page 0, Register 19 - synchronize */
+#define TAS5754M_RQSY        (1 << 0)
+#define TAS5754M_RQSY_RESUME (0 << 0)
+#define TAS5754M_RQSY_HALT   (1 << 0)
+
+/* Page 0, Register 34 - fs speed mode */
+#define TAS5754M_FSSP        (3 << 0)
+#define TAS5754M_FSSP_SHIFT  0
+#define TAS5754M_FSSP_48KHZ  (0 << 0)
+#define TAS5754M_FSSP_96KHZ  (1 << 0)
+#define TAS5754M_FSSP_192KHZ (2 << 0)
+#define TAS5754M_FSSP_384KHZ (3 << 0)
+
+/* Page 0, Register 37 - Error detection */
+#define TAS5754M_IPLK (1 << 0)
+#define TAS5754M_DCAS (1 << 1)
+#define TAS5754M_IDCM (1 << 2)
+#define TAS5754M_IDCH (1 << 3)
+#define TAS5754M_IDSK (1 << 4)
+#define TAS5754M_IDBK (1 << 5)
+#define TAS5754M_IDFS (1 << 6)
+
+/* Page 0, Register 40 - I2S configuration */
+#define TAS5754M_ALEN       (3 << 0)
+#define TAS5754M_ALEN_SHIFT 0
+#define TAS5754M_ALEN_16    (0 << 0)
+#define TAS5754M_ALEN_20    (1 << 0)
+#define TAS5754M_ALEN_24    (2 << 0)
+#define TAS5754M_ALEN_32    (3 << 0)
+#define TAS5754M_AFMT       (3 << 4)
+#define TAS5754M_AFMT_SHIFT 4
+#define TAS5754M_AFMT_I2S   (0 << 4)
+#define TAS5754M_AFMT_DSP   (1 << 4)
+#define TAS5754M_AFMT_RTJ   (2 << 4)
+#define TAS5754M_AFMT_LTJ   (3 << 4)
+
+/* Page 0, Register 42 - DAC routing */
+#define TAS5754M_AUPR_SHIFT 0
+#define TAS5754M_AUPL_SHIFT 4
+
+/* Page 0, Register 59 - auto mute */
+#define TAS5754M_ATMR_SHIFT 0
+#define TAS5754M_ATML_SHIFT 4
+
+/* Page 0, Register 63 - ramp rates */
+#define TAS5754M_VNDF_SHIFT 6
+#define TAS5754M_VNDS_SHIFT 4
+#define TAS5754M_VNUF_SHIFT 2
+#define TAS5754M_VNUS_SHIFT 0
+
+/* Page 0, Register 64 - emergency ramp rates */
+#define TAS5754M_VEDF_SHIFT 6
+#define TAS5754M_VEDS_SHIFT 4
+
+/* Page 0, Register 65 - Digital mute enables */
+#define TAS5754M_ACTL_SHIFT 2
+#define TAS5754M_AMLE_SHIFT 1
+#define TAS5754M_AMRE_SHIFT 0
+
+/* Page 0, Register 80-85, GPIO output selection */
+#define TAS5754M_GxSL       (31 << 0)
+#define TAS5754M_GxSL_SHIFT 0
+#define TAS5754M_GxSL_OFF   (0 << 0)
+#define TAS5754M_GxSL_DSP   (1 << 0)
+#define TAS5754M_GxSL_REG   (2 << 0)
+#define TAS5754M_GxSL_AMUTB (3 << 0)
+#define TAS5754M_GxSL_AMUTL (4 << 0)
+#define TAS5754M_GxSL_AMUTR (5 << 0)
+#define TAS5754M_GxSL_CLKI  (6 << 0)
+#define TAS5754M_GxSL_SDOUT (7 << 0)
+#define TAS5754M_GxSL_ANMUL (8 << 0)
+#define TAS5754M_GxSL_ANMUR (9 << 0)
+#define TAS5754M_GxSL_PLLLK (10 << 0)
+#define TAS5754M_GxSL_CPCLK (11 << 0)
+#define TAS5754M_GxSL_UV0_7 (14 << 0)
+#define TAS5754M_GxSL_UV0_3 (15 << 0)
+#define TAS5754M_GxSL_PLLCK (16 << 0)
+
+/* Page 1, Register 2 - analog volume control */
+#define TAS5754M_RAGN_SHIFT 0
+#define TAS5754M_LAGN_SHIFT 4
+
+/* Page 1, Register 7 - analog boost control */
+#define TAS5754M_AGBR_SHIFT 0
+#define TAS5754M_AGBL_SHIFT 4
+
+#endif
-- 
2.17.1

