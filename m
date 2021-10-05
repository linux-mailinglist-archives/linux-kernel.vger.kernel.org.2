Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8190C421BA8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhJEBTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhJEBTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:19:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A094C061760;
        Mon,  4 Oct 2021 18:17:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so728547pjb.1;
        Mon, 04 Oct 2021 18:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9PJ1l4RD9xAsl/BFZraLRjwAVSX3QsWPsP0erok0hD8=;
        b=ZwBvo2K3vcaXJl9kC/N1qp8VaylnD4Sbt0Nt/pnlDpvqy+1Y292e6L5XSxHfev3XCu
         Durq1tzr5ebzT+qCD5u456EnFa0Vl4Rr9WG+M45drAe7C7vc0Wrq/JskhuDtu8A0tF6s
         NjE1I9P34R+/DO/k07ZrWo8N7+pbiEJ2nkF8uPbtOJWeh26CdpQ8tzuLjVZlbggsoHW7
         FaRqGKrbPQ+2n7Hln8FpeSBADX6hnXF3DAR/BSda9/k4AhWZYa6LZLuIccw2RBVzHdmV
         MBMVIi0nWCg0v/I3+rDuj1IwPMEdug2TVtt4UCPskIsGPijYRUacuzg5SJUARJPENvar
         bpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9PJ1l4RD9xAsl/BFZraLRjwAVSX3QsWPsP0erok0hD8=;
        b=JHBnARfJL/k06lf8KOLvHMXf/k2sCdVn1q3fnA60zN1LsdZkadgDt4EmwOMKSI6gR+
         NMAD8K8WTuR8qcyU6FVd7O5CKhuf41WBSLMktPmM3L6uEqDkTRpuI0z8cbWZOVSJ2GRd
         0o/ichkUc2/ya6EGVfzdVpmyF6YOAYITTKT2V0sFe1foVUCWYfpDl+LxPp/eJoAXGsZd
         QsFuhDmg+DwKtMKcYzD3m9VQdepp2KSz7crq137zYSiBPNoZdHhKIVdIOjotlyw2oJYl
         mlFA/ax06398WW+9dBzk51roE6sV5Bzr5Y8jYgzsE+mY2ObCcZEXlgWK1NDo9cLIUO6d
         ZESQ==
X-Gm-Message-State: AOAM5339Yi0St80+8J+JEzGcRKEw+p8ZnEqU3PymiwrOx6z6R0JWXkWn
        syrcg7uoyDj4Mz3trv5kNkM=
X-Google-Smtp-Source: ABdhPJxHw1gycykrn7YD8VmPvME8fmp4f7EbftNuoCncgoDRRAWrrCO+asYfJWJB8xs9zm0FRZL/+Q==
X-Received: by 2002:a17:90a:191c:: with SMTP id 28mr350539pjg.121.1633396628880;
        Mon, 04 Oct 2021 18:17:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:578:6fac:e123:108:2f69:cff1])
        by smtp.gmail.com with ESMTPSA id j6sm15162454pgq.0.2021.10.04.18.17.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 18:17:08 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        allen_lin@richtek.com
Subject: [PATCH 2/2] ASoC: rt9120: Add rt9210 audio amplifier support
Date:   Tue,  5 Oct 2021 09:16:55 +0800
Message-Id: <1633396615-14043-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add rt9120 audio amplifier support.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/Kconfig  |  10 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/rt9120.c | 491 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 503 insertions(+)
 create mode 100644 sound/soc/codecs/rt9120.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 82ee233..155050d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -187,6 +187,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_RT715_SDCA_SDW
 	imply SND_SOC_RT1308_SDW
 	imply SND_SOC_RT1316_SDW
+	imply SND_SOC_RT9120
 	imply SND_SOC_SDW_MOCKUP
 	imply SND_SOC_SGTL5000
 	imply SND_SOC_SI476X
@@ -1288,6 +1289,15 @@ config SND_SOC_RT715_SDCA_SDW
 	select REGMAP_SOUNDWIRE
 	select REGMAP_SOUNDWIRE_MBQ
 
+config SND_SOC_RT9120
+	tristate "Richtek RT9120 Stereo Class-D Amplifier"
+	depends on I2C
+	select REGMAP_I2C
+	select GPIOLIB
+	help
+	  Enable support for Richtek RT9120 20W, stereo, inductor-less,
+	  high-efficiency Class-D audio amplifier.
+
 config SND_SOC_SDW_MOCKUP
 	tristate "SoundWire mockup codec"
 	depends on EXPERT
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 8dcea2c..5ba164d 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -203,6 +203,7 @@ snd-soc-rt711-objs := rt711.o rt711-sdw.o
 snd-soc-rt711-sdca-objs := rt711-sdca.o rt711-sdca-sdw.o
 snd-soc-rt715-objs := rt715.o rt715-sdw.o
 snd-soc-rt715-sdca-objs := rt715-sdca.o rt715-sdca-sdw.o
+snd-soc-rt9120-objs := rt9120.o
 snd-soc-sdw-mockup-objs := sdw-mockup.o
 snd-soc-sgtl5000-objs := sgtl5000.o
 snd-soc-alc5623-objs := alc5623.o
@@ -531,6 +532,7 @@ obj-$(CONFIG_SND_SOC_RT711)     += snd-soc-rt711.o
 obj-$(CONFIG_SND_SOC_RT711_SDCA_SDW)     += snd-soc-rt711-sdca.o
 obj-$(CONFIG_SND_SOC_RT715)     += snd-soc-rt715.o
 obj-$(CONFIG_SND_SOC_RT715_SDCA_SDW)     += snd-soc-rt715-sdca.o
+obj-$(CONFIG_SND_SOC_RT9120)	+= snd-soc-rt9120.o
 obj-$(CONFIG_SND_SOC_SDW_MOCKUP)     += snd-soc-sdw-mockup.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
 obj-$(CONFIG_SND_SOC_SIGMADSP)	+= snd-soc-sigmadsp.o
diff --git a/sound/soc/codecs/rt9120.c b/sound/soc/codecs/rt9120.c
new file mode 100644
index 00000000..19a143b
--- /dev/null
+++ b/sound/soc/codecs/rt9120.c
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#define RT9120_REG_DEVID	0x00
+#define RT9120_REG_I2SFMT	0x02
+#define RT9120_REG_I2SWL	0x03
+#define RT9120_REG_SDIOSEL	0x04
+#define RT9120_REG_SYSCTL	0x05
+#define RT9120_REG_SPKGAIN	0x07
+#define RT9120_REG_VOLRAMP	0x0A
+#define RT9120_REG_ERRRPT	0x10
+#define RT9120_REG_MSVOL	0x20
+#define RT9120_REG_SWRESET	0x40
+#define RT9120_REG_INTERNAL0	0x65
+#define RT9120_REG_INTERNAL1	0x69
+#define RT9120_REG_UVPOPT	0x6C
+
+#define RT9120_VID_MASK		GENMASK(15,8)
+#define RT9120_SWRST_MASK	BIT(7)
+#define RT9120_MUTE_MASK	GENMASK(5, 4)
+#define RT9120_I2SFMT_MASK	GENMASK(4, 2)
+#define RT9120_I2SFMT_SHIFT	2
+#define RT9120_CFG_FMT_I2S	0
+#define RT9120_CFG_FMT_LEFTJ	1
+#define RT9120_CFG_FMT_RIGHTJ	2
+#define RT9120_CFG_FMT_DSPA	3
+#define RT9120_CFG_FMT_DSPB	7
+#define RT9120_AUDBIT_MASK	GENMASK(1, 0)
+#define RT9120_CFG_AUDBIT_16	0
+#define RT9120_CFG_AUDBIT_20	1
+#define RT9120_CFG_AUDBIT_24	2
+#define RT9120_AUDWL_MASK	GENMASK(5, 0)
+#define RT9120_CFG_WORDLEN_16	16
+#define RT9120_CFG_WORDLEN_24	24
+#define RT9120_CFG_WORDLEN_32	32
+#define RT9120_DVDD_UVSEL_MASK	GENMASK(5, 4)
+
+#define RT9120_VENDOR_ID	0x4200
+#define RT9120_RESET_WAITMS	20
+#define RT9120_CHIPON_WAITMS	20
+#define RT9120_AMPON_WAITMS	50
+#define RT9120_AMPOFF_WAITMS	100
+
+/* 8000 to 192000 supported , only 176400 not support */
+#define RT9120_RATES_MASK	(SNDRV_PCM_RATE_8000_192000 &\
+				 ~SNDRV_PCM_RATE_176400)
+#define RT9120_FMTS_MASK	(SNDRV_PCM_FMTBIT_S16_LE |\
+				 SNDRV_PCM_FMTBIT_S24_LE |\
+				 SNDRV_PCM_FMTBIT_S32_LE)
+struct rt9120_data {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+/* 11bit [min,max,step] = [-103.9375dB, 24dB, 0.0625dB] */
+static const DECLARE_TLV_DB_SCALE(digital_gain, -1039375, 625, -1039375);
+
+static const char * const sdo_select_text[] = {
+	"NONE", "INTF", "FINAL", "RMS Detect"
+};
+
+static const struct soc_enum sdo_select_enum =
+	SOC_ENUM_SINGLE(RT9120_REG_SDIOSEL, 4, ARRAY_SIZE(sdo_select_text),
+			sdo_select_text);
+
+static const struct snd_kcontrol_new rt9120_snd_controls[] = {
+	SOC_SINGLE_TLV("MS Volume", RT9120_REG_MSVOL, 0, 2047, 1, digital_gain),
+	SOC_SINGLE("SPK Gain", RT9120_REG_SPKGAIN, 0, 7, 0),
+	SOC_SINGLE("PBTL Switch", RT9120_REG_SYSCTL, 3, 1, 0),
+	SOC_ENUM("SDO Select", sdo_select_enum),
+};
+
+static int internal_power_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
+
+	if (event == SND_SOC_DAPM_PRE_PMU)
+		snd_soc_component_write(comp, RT9120_REG_ERRRPT, 0);
+	else if (event == SND_SOC_DAPM_POST_PMU)
+		msleep(RT9120_AMPON_WAITMS);
+	else if (event == SND_SOC_DAPM_POST_PMD)
+		msleep(RT9120_AMPOFF_WAITMS);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget rt9120_dapm_widgets[] = {
+	SND_SOC_DAPM_MIXER("DMIX", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_DAC("LDAC", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("RDAC", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("PWND", RT9120_REG_SYSCTL, 6, 1,
+			    internal_power_event, SND_SOC_DAPM_PRE_PMU |
+			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA("SPKL PA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("SPKR PA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("SPKL"),
+	SND_SOC_DAPM_OUTPUT("SPKR"),
+};
+
+static const struct snd_soc_dapm_route rt9120_dapm_routes[] = {
+	{ "DMIX", NULL, "AIF Playback" },
+	/* SPKL */
+	{ "LDAC", NULL, "PWND" },
+	{ "LDAC", NULL, "DMIX" },
+	{ "SPKL PA", NULL, "LDAC" },
+	{ "SPKL", NULL, "SPKL PA" },
+	/* SPKR */
+	{ "RDAC", NULL, "PWND" },
+	{ "RDAC", NULL, "DMIX" },
+	{ "SPKR PA", NULL, "RDAC" },
+	{ "SPKR", NULL, "SPKR PA" },
+	/* Cap */
+	{ "AIF Capture", NULL, "LDAC" },
+	{ "AIF Capture", NULL, "RDAC" },
+};
+
+static int rt9120_codec_probe(struct snd_soc_component *comp)
+{
+	struct rt9120_data *data = snd_soc_component_get_drvdata(comp);
+
+	snd_soc_component_init_regmap(comp, data->regmap);
+
+	/* Internal setting */
+	snd_soc_component_write(comp, RT9120_REG_INTERNAL1, 0x03);
+	snd_soc_component_write(comp, RT9120_REG_INTERNAL0, 0x69);
+	/* Default config volume to 0dB */
+	snd_soc_component_write(comp, RT9120_REG_MSVOL, 0x180);
+	/* Mute by default */
+	snd_soc_component_update_bits(comp, RT9120_REG_VOLRAMP,
+				      RT9120_MUTE_MASK, RT9120_MUTE_MASK);
+	return 0;
+}
+
+static const struct snd_soc_component_driver rt9120_component_driver = {
+	.probe = rt9120_codec_probe,
+	.controls = rt9120_snd_controls,
+	.num_controls = ARRAY_SIZE(rt9120_snd_controls),
+	.dapm_widgets = rt9120_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rt9120_dapm_widgets),
+	.dapm_routes = rt9120_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rt9120_dapm_routes),
+};
+
+static int rt9120_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *comp = dai->component;
+	unsigned int format;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		format = RT9120_CFG_FMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		format = RT9120_CFG_FMT_LEFTJ;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		format = RT9120_CFG_FMT_RIGHTJ;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		format = RT9120_CFG_FMT_DSPA;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		format = RT9120_CFG_FMT_DSPB;
+		break;
+	default:
+		dev_err(dai->dev, "Unknown dai format\n");
+		return -EINVAL;
+	}
+
+	snd_soc_component_update_bits(comp, RT9120_REG_I2SFMT,
+				      RT9120_I2SFMT_MASK,
+				      format << RT9120_I2SFMT_SHIFT);
+	return 0;
+}
+
+static int rt9120_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *param,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *comp = dai->component;
+	unsigned int param_width, param_slot_width;
+	int width;
+
+	switch (width = params_width(param)) {
+	case 16:
+		param_width = RT9120_CFG_AUDBIT_16;
+		break;
+	case 20:
+		param_width = RT9120_CFG_AUDBIT_20;
+		break;
+	case 24:
+	case 32:
+		param_width = RT9120_CFG_AUDBIT_24;
+		break;
+	default:
+		dev_err(dai->dev, "Unsupported data width [%d]\n", width);
+		return -EINVAL;
+	}
+
+	snd_soc_component_update_bits(comp, RT9120_REG_I2SFMT,
+				      RT9120_AUDBIT_MASK, param_width);
+
+	switch (width = params_physical_width(param)) {
+	case 16:
+		param_slot_width = RT9120_CFG_WORDLEN_16;
+		break;
+	case 24:
+		param_slot_width = RT9120_CFG_WORDLEN_24;
+		break;
+	case 32:
+		param_slot_width = RT9120_CFG_WORDLEN_32;
+		break;
+	default:
+		dev_err(dai->dev, "Unsupported slot width [%d]\n", width);
+		return -EINVAL;
+	}
+
+	snd_soc_component_update_bits(comp, RT9120_REG_I2SWL,
+				      RT9120_AUDWL_MASK, param_slot_width);
+	return 0;
+}
+
+
+static int rt9120_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_component *comp = dai->component;
+	unsigned int val = mute ? RT9120_MUTE_MASK : 0;
+
+	snd_soc_component_update_bits(comp, RT9120_REG_VOLRAMP,
+				      RT9120_MUTE_MASK, val);
+	return 0;
+}
+
+static const struct snd_soc_dai_ops rt9120_dai_ops = {
+	.set_fmt = rt9120_set_fmt,
+	.hw_params = rt9120_hw_params,
+	.mute_stream = rt9120_mute_stream,
+	.no_capture_mute = 1,
+};
+
+static struct snd_soc_dai_driver rt9120_dai = {
+	.name = "rt9120_aif",
+	.playback = {
+		.stream_name = "AIF Playback",
+		.rates = RT9120_RATES_MASK,
+		.formats = RT9120_FMTS_MASK,
+		.rate_max = 192000,
+		.rate_min = 8000,
+		.channels_min = 1,
+		.channels_max = 2,
+	},
+	.capture = {
+		.stream_name = "AIF Capture",
+		.rates = RT9120_RATES_MASK,
+		.formats = RT9120_FMTS_MASK,
+		.rate_max = 192000,
+		.rate_min = 8000,
+		.channels_min = 1,
+		.channels_max = 2,
+	},
+	.ops = &rt9120_dai_ops,
+	.symmetric_rate = 1,
+	.symmetric_sample_bits = 1,
+};
+
+static const struct regmap_range rt9120_rd_yes_ranges[] = {
+	regmap_reg_range(0x00, 0x0C),
+	regmap_reg_range(0x10, 0x15),
+	regmap_reg_range(0x20, 0x27),
+	regmap_reg_range(0x30, 0x38),
+	regmap_reg_range(0x3A, 0x40),
+	regmap_reg_range(0x65, 0x65),
+	regmap_reg_range(0x69, 0x69),
+	regmap_reg_range(0x6C, 0x6C)
+};
+
+static const struct regmap_access_table rt9120_rd_table = {
+	.yes_ranges = rt9120_rd_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(rt9120_rd_yes_ranges),
+};
+
+static const struct regmap_range rt9120_wr_yes_ranges[] = {
+	regmap_reg_range(0x00, 0x00),
+	regmap_reg_range(0x02, 0x0A),
+	regmap_reg_range(0x10, 0x15),
+	regmap_reg_range(0x20, 0x27),
+	regmap_reg_range(0x30, 0x38),
+	regmap_reg_range(0x3A, 0x3D),
+	regmap_reg_range(0x40, 0x40),
+	regmap_reg_range(0x65, 0x65),
+	regmap_reg_range(0x69, 0x69),
+	regmap_reg_range(0x6C, 0x6C)
+};
+
+static const struct regmap_access_table rt9120_wr_table = {
+	.yes_ranges = rt9120_wr_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(rt9120_wr_yes_ranges),
+};
+
+static int rt9120_get_reg_size(unsigned int reg)
+{
+	switch (reg) {
+	case 0x00:
+	case 0x09:
+	case 0x20 ... 0x27:
+		return 2;
+	case 0x30 ... 0x3D:
+		return 3;
+	case 0x3E ... 0x3F:
+		return 4;
+	default:
+		return 1;
+	}
+}
+
+static int rt9120_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct rt9120_data *data = context;
+	struct i2c_client *i2c = to_i2c_client(data->dev);
+	int size = rt9120_get_reg_size(reg);
+	u8 raw[4] = {0};
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(i2c, reg, size, raw);
+	if (ret < 0)
+		return ret;
+	else if (ret != size)
+		return -EIO;
+
+	switch (size) {
+	case 4:
+		*val = be32_to_cpup((__be32 *)raw);
+		break;
+	case 3:
+		*val = raw[0] << 16 | raw[1] << 8 | raw[0];
+		break;
+	case 2:
+		*val = be16_to_cpup((__be16 *)raw);
+		break;
+	default:
+		*val = raw[0];
+	}
+
+	return 0;
+}
+
+static int rt9120_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct rt9120_data *data = context;
+	struct i2c_client *i2c = to_i2c_client(data->dev);
+	int size = rt9120_get_reg_size(reg);
+	__be32 be32_val;
+	u8 *rawp = (u8 *)&be32_val;
+	int offs = 4 - size;
+
+	be32_val = cpu_to_be32(val);
+	return i2c_smbus_write_i2c_block_data(i2c, reg, size, rawp + offs);
+}
+
+static const struct regmap_config rt9120_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.max_register = RT9120_REG_UVPOPT,
+
+	.reg_read = rt9120_reg_read,
+	.reg_write = rt9120_reg_write,
+
+	.wr_table = &rt9120_wr_table,
+	.rd_table = &rt9120_rd_table,
+};
+
+static int rt9120_check_vendor_info(struct rt9120_data *data)
+{
+	unsigned int devid;
+	int ret;
+
+	ret = regmap_read(data->regmap, RT9120_REG_DEVID, &devid);
+	if (ret)
+		return ret;
+
+	if ((devid & RT9120_VID_MASK) != RT9120_VENDOR_ID) {
+		dev_err(data->dev, "DEVID not correct [0x%04x]\n", devid);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int rt9120_do_register_reset(struct rt9120_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, RT9120_REG_SWRESET,
+			   RT9120_SWRST_MASK);
+	if (ret)
+		return ret;
+
+	msleep(RT9120_RESET_WAITMS);
+	return 0;
+}
+
+static int rt9120_probe(struct i2c_client *i2c)
+{
+	struct rt9120_data *data;
+	struct gpio_desc *pwdnn_gpio;
+	bool dvdd_1p8v;
+	int ret;
+
+	data = devm_kzalloc(&i2c->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = &i2c->dev;
+	i2c_set_clientdata(i2c, data);
+
+	pwdnn_gpio = devm_gpiod_get_optional(&i2c->dev, "pwdnn",
+					     GPIOD_OUT_HIGH);
+	if (IS_ERR(pwdnn_gpio)) {
+		dev_err(&i2c->dev, "Failed to initialize 'pwdnn' gpio\n");
+		return PTR_ERR(pwdnn_gpio);
+	} else if (pwdnn_gpio) {
+		dev_dbg(&i2c->dev, "'pwdnn' from low to high, wait chip on\n");
+		msleep(RT9120_CHIPON_WAITMS);
+	}
+
+	data->regmap = devm_regmap_init(&i2c->dev, NULL, data,
+					&rt9120_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		ret = PTR_ERR(data->regmap);
+		dev_err(&i2c->dev, "Failed to init regmap [%d]\n", ret);
+		return ret;
+	}
+
+	ret = rt9120_check_vendor_info(data);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to check vendor info\n");
+		return ret;
+	}
+
+	ret = rt9120_do_register_reset(data);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to do register reset\n");
+		return ret;
+	}
+
+	dvdd_1p8v = device_property_present(&i2c->dev, "richtek,use-dvdd-1p8v");
+	if (dvdd_1p8v) {
+		ret = regmap_update_bits(data->regmap, RT9120_REG_UVPOPT,
+					 RT9120_DVDD_UVSEL_MASK, 0);
+		if (ret) {
+			dev_err(&i2c->dev, "Failed to config DVDD for 1P8V\n");
+			return ret;
+		}
+	}
+
+	return devm_snd_soc_register_component(&i2c->dev,
+					       &rt9120_component_driver,
+					       &rt9120_dai, 1);
+}
+
+static const struct of_device_id __maybe_unused rt9120_device_table[] = {
+	{ .compatible = "richtek,rt9120", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt9120_device_table);
+
+static struct i2c_driver rt9120_driver = {
+	.driver = {
+		.name = "rt9120",
+		.of_match_table = rt9120_device_table,
+	},
+	.probe_new = rt9120_probe,
+};
+module_i2c_driver(rt9120_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("RT9120 Audio Amplifier Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

