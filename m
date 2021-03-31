Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6C34FAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhCaH7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:59:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59190 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234106AbhCaH6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:58:51 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D14442002AC;
        Wed, 31 Mar 2021 09:58:49 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 51CA92002C7;
        Wed, 31 Mar 2021 09:58:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D5FAF402F1;
        Wed, 31 Mar 2021 09:58:41 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: ak5558: Add support for ak5552
Date:   Wed, 31 Mar 2021 15:44:45 +0800
Message-Id: <1617176686-25528-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

AK5552 is a 32-bit 2ch ADC and has the same register
map as AK5558.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
- refine the control name.

 sound/soc/codecs/ak5558.c | 97 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 85bdd0534180..3ac62a281807 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -9,6 +9,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -23,6 +24,11 @@
 
 #include "ak5558.h"
 
+enum ak555x_type {
+	AK5558,
+	AK5552,
+};
+
 #define AK5558_NUM_SUPPLIES 2
 static const char *ak5558_supply_names[AK5558_NUM_SUPPLIES] = {
 	"DVDD",
@@ -59,6 +65,15 @@ static const struct soc_enum ak5558_mono_enum[] = {
 			ARRAY_SIZE(mono_texts), mono_texts),
 };
 
+static const char * const mono_5552_texts[] = {
+	"2 Slot", "1 Slot (Fixed)", "2 Slot", "1 Slot (Optimal)",
+};
+
+static const struct soc_enum ak5552_mono_enum[] = {
+	SOC_ENUM_SINGLE(AK5558_01_POWER_MANAGEMENT2, 1,
+			ARRAY_SIZE(mono_5552_texts), mono_5552_texts),
+};
+
 static const char * const digfil_texts[] = {
 	"Sharp Roll-Off", "Show Roll-Off",
 	"Short Delay Sharp Roll-Off", "Short Delay Show Roll-Off",
@@ -70,8 +85,13 @@ static const struct soc_enum ak5558_adcset_enum[] = {
 };
 
 static const struct snd_kcontrol_new ak5558_snd_controls[] = {
-	SOC_ENUM("AK5558 Monaural Mode", ak5558_mono_enum[0]),
-	SOC_ENUM("AK5558 Digital Filter", ak5558_adcset_enum[0]),
+	SOC_ENUM("Monaural Mode", ak5558_mono_enum[0]),
+	SOC_ENUM("Digital Filter", ak5558_adcset_enum[0]),
+};
+
+static const struct snd_kcontrol_new ak5552_snd_controls[] = {
+	SOC_ENUM("Monaural Mode", ak5552_mono_enum[0]),
+	SOC_ENUM("Digital Filter", ak5558_adcset_enum[0]),
 };
 
 static const struct snd_soc_dapm_widget ak5558_dapm_widgets[] = {
@@ -97,6 +117,17 @@ static const struct snd_soc_dapm_widget ak5558_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("SDTO", "Capture", 0, SND_SOC_NOPM, 0, 0),
 };
 
+static const struct snd_soc_dapm_widget ak5552_dapm_widgets[] = {
+	/* Analog Input */
+	SND_SOC_DAPM_INPUT("AIN1"),
+	SND_SOC_DAPM_INPUT("AIN2"),
+
+	SND_SOC_DAPM_ADC("ADC Ch1", NULL, AK5558_00_POWER_MANAGEMENT1, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Ch2", NULL, AK5558_00_POWER_MANAGEMENT1, 1, 0),
+
+	SND_SOC_DAPM_AIF_OUT("SDTO", "Capture", 0, SND_SOC_NOPM, 0, 0),
+};
+
 static const struct snd_soc_dapm_route ak5558_intercon[] = {
 	{"ADC Ch1", NULL, "AIN1"},
 	{"SDTO", NULL, "ADC Ch1"},
@@ -123,6 +154,14 @@ static const struct snd_soc_dapm_route ak5558_intercon[] = {
 	{"SDTO", NULL, "ADC Ch8"},
 };
 
+static const struct snd_soc_dapm_route ak5552_intercon[] = {
+	{"ADC Ch1", NULL, "AIN1"},
+	{"SDTO", NULL, "ADC Ch1"},
+
+	{"ADC Ch2", NULL, "AIN2"},
+	{"SDTO", NULL, "ADC Ch2"},
+};
+
 static int ak5558_set_mcki(struct snd_soc_component *component)
 {
 	return snd_soc_component_update_bits(component, AK5558_02_CONTROL1, AK5558_CKS,
@@ -267,6 +306,18 @@ static struct snd_soc_dai_driver ak5558_dai = {
 	.ops = &ak5558_dai_ops,
 };
 
+static struct snd_soc_dai_driver ak5552_dai = {
+	.name = "ak5558-aif",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_KNOT,
+		.formats = AK5558_FORMATS,
+	},
+	.ops = &ak5558_dai_ops,
+};
+
 static void ak5558_power_off(struct ak5558_priv *ak5558)
 {
 	if (!ak5558->reset_gpiod)
@@ -354,6 +405,21 @@ static const struct snd_soc_component_driver soc_codec_dev_ak5558 = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static const struct snd_soc_component_driver soc_codec_dev_ak5552 = {
+	.probe			= ak5558_probe,
+	.remove			= ak5558_remove,
+	.controls		= ak5552_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak5552_snd_controls),
+	.dapm_widgets		= ak5552_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ak5552_dapm_widgets),
+	.dapm_routes		= ak5552_intercon,
+	.num_dapm_routes	= ARRAY_SIZE(ak5552_intercon),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
 static const struct regmap_config ak5558_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -368,6 +434,7 @@ static int ak5558_i2c_probe(struct i2c_client *i2c)
 {
 	struct ak5558_priv *ak5558;
 	int ret = 0;
+	int dev_id;
 	int i;
 
 	ak5558 = devm_kzalloc(&i2c->dev, sizeof(*ak5558), GFP_KERNEL);
@@ -396,11 +463,26 @@ static int ak5558_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	ret = devm_snd_soc_register_component(&i2c->dev,
-				     &soc_codec_dev_ak5558,
-				     &ak5558_dai, 1);
-	if (ret)
+	dev_id = (uintptr_t)of_device_get_match_data(&i2c->dev);
+	switch (dev_id) {
+	case AK5552:
+		ret = devm_snd_soc_register_component(&i2c->dev,
+						      &soc_codec_dev_ak5552,
+						      &ak5552_dai, 1);
+		break;
+	case AK5558:
+		ret = devm_snd_soc_register_component(&i2c->dev,
+						      &soc_codec_dev_ak5558,
+						      &ak5558_dai, 1);
+		break;
+	default:
+		dev_err(&i2c->dev, "unexpected device type\n");
+		return -EINVAL;
+	}
+	if (ret < 0) {
+		dev_err(&i2c->dev, "failed to register component: %d\n", ret);
 		return ret;
+	}
 
 	pm_runtime_enable(&i2c->dev);
 	regcache_cache_only(ak5558->regmap, true);
@@ -416,7 +498,8 @@ static int ak5558_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct of_device_id ak5558_i2c_dt_ids[] __maybe_unused = {
-	{ .compatible = "asahi-kasei,ak5558"},
+	{ .compatible = "asahi-kasei,ak5558", .data = (void *) AK5558 },
+	{ .compatible = "asahi-kasei,ak5552", .data = (void *) AK5552 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ak5558_i2c_dt_ids);
-- 
2.27.0

