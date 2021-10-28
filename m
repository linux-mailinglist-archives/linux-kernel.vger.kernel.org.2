Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93743DAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhJ1GGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:06:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:36156 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhJ1GGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:06:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="293791411"
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="293791411"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 23:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="537873255"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.1])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2021 23:03:43 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Julian Braha <julianbraha@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rander Wang <rander.wang@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoc: Intel: glk_rt5682_max98357a: support ALC5682I-VS codec
Date:   Thu, 28 Oct 2021 14:02:03 +0800
Message-Id: <20211028060203.446093-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect the codec variant in probe function and update DAI link
accordingly. Also add an new entry in enumeration table for machine
driver enumeration.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/Kconfig                |  1 +
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 53 +++++++++++++++----
 .../intel/common/soc-acpi-intel-glk-match.c   |  9 ++++
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index f693383eb6e3..2dd5ff7e35ce 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -427,6 +427,7 @@ config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
 	depends on SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC
 	select SND_SOC_RT5682_I2C
+	select SND_SOC_RT5682S
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index 9d75beec09d1..058aa7cb899a 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -18,14 +18,18 @@
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
 #include "../../codecs/rt5682.h"
+#include "../../codecs/rt5682s.h"
 #include "../../codecs/hdac_hdmi.h"
 #include "hda_dsp_common.h"
 
 /* The platform clock outputs 19.2Mhz clock to codec as I2S MCLK */
 #define GLK_PLAT_CLK_FREQ 19200000
 #define RT5682_PLL_FREQ (48000 * 512)
-#define GLK_REALTEK_CODEC_DAI "rt5682-aif1"
+#define RT5682_DAI_NAME "rt5682-aif1"
+#define RT5682S_DAI_NAME "rt5682s-aif1"
 #define GLK_MAXIM_CODEC_DAI "HiFi"
+#define RT5682_DEV0_NAME "i2c-10EC5682:00"
+#define RT5682S_DEV0_NAME "i2c-RTL5682:00"
 #define MAXIM_DEV0_NAME "MX98357A:00"
 #define DUAL_CHANNEL 2
 #define QUAD_CHANNEL 4
@@ -43,6 +47,7 @@ struct glk_card_private {
 	struct snd_soc_jack geminilake_headset;
 	struct list_head hdmi_pcm_list;
 	bool common_hdmi_codec_drv;
+	int is_rt5682s;
 };
 
 enum {
@@ -139,9 +144,19 @@ static int geminilake_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct snd_soc_jack *jack;
-	int ret;
+	int pll_id, pll_source, clk_id, ret;
+
+	if (ctx->is_rt5682s) {
+		pll_id = RT5682S_PLL2;
+		pll_source = RT5682S_PLL_S_MCLK;
+		clk_id = RT5682S_SCLK_S_PLL2;
+	} else {
+		pll_id = RT5682_PLL1;
+		pll_source = RT5682_PLL1_S_MCLK;
+		clk_id = RT5682_SCLK_S_PLL1;
+	}
 
-	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5682_PLL1_S_MCLK,
+	ret = snd_soc_dai_set_pll(codec_dai, pll_id, pll_source,
 					GLK_PLAT_CLK_FREQ, RT5682_PLL_FREQ);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
@@ -149,7 +164,7 @@ static int geminilake_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Configure sysclk for codec */
-	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
+	ret = snd_soc_dai_set_sysclk(codec_dai, clk_id,
 					RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
@@ -344,9 +359,12 @@ SND_SOC_DAILINK_DEF(ssp1_codec,
 
 SND_SOC_DAILINK_DEF(ssp2_pin,
 	DAILINK_COMP_ARRAY(COMP_CPU("SSP2 Pin")));
-SND_SOC_DAILINK_DEF(ssp2_codec,
-	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC5682:00",
-				      GLK_REALTEK_CODEC_DAI)));
+SND_SOC_DAILINK_DEF(ssp2_codec_5682,
+	DAILINK_COMP_ARRAY(COMP_CODEC(RT5682_DEV0_NAME,
+				      RT5682_DAI_NAME)));
+SND_SOC_DAILINK_DEF(ssp2_codec_5682s,
+	DAILINK_COMP_ARRAY(COMP_CODEC(RT5682S_DEV0_NAME,
+				      RT5682S_DAI_NAME)));
 
 SND_SOC_DAILINK_DEF(dmic_pin,
 	DAILINK_COMP_ARRAY(COMP_CPU("DMIC01 Pin")));
@@ -492,7 +510,7 @@ static struct snd_soc_dai_link geminilake_dais[] = {
 		.ops = &geminilake_rt5682_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
-		SND_SOC_DAILINK_REG(ssp2_pin, ssp2_codec, platform),
+		SND_SOC_DAILINK_REG(ssp2_pin, ssp2_codec_5682, platform),
 	},
 	{
 		.name = "dmic01",
@@ -592,12 +610,29 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
 	struct snd_soc_card *card;
-	int ret;
+	int ret, i;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
+	/* Detect the headset codec variant */
+	if (acpi_dev_present("RTL5682", NULL, -1)) {
+		/* ALC5682I-VS is detected */
+		ctx->is_rt5682s = 1;
+
+		for (i = 0; i < glk_audio_card_rt5682_m98357a.num_links; i++) {
+			if (strcmp(geminilake_dais[i].name, "SSP2-Codec"))
+				continue;
+
+			/* update the dai link to use rt5682s codec */
+			geminilake_dais[i].codecs = ssp2_codec_5682s;
+			geminilake_dais[i].num_codecs = ARRAY_SIZE(ssp2_codec_5682s);
+			break;
+		}
+	} else
+		ctx->is_rt5682s = 0;
+
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
 	card = &glk_audio_card_rt5682_m98357a;
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 32fff9389eb3..4de4add74443 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -40,6 +40,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 		.sof_fw_filename = "sof-glk.ri",
 		.sof_tplg_filename = "sof-glk-rt5682.tplg",
 	},
+	{
+		.id = "RTL5682",
+		.drv_name = "glk_rt5682_max98357a",
+		.fw_filename = "intel/dsp_fw_glk.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &glk_codecs,
+		.sof_fw_filename = "sof-glk.ri",
+		.sof_tplg_filename = "sof-glk-rt5682.tplg",
+	},
 	{
 		.id = "10134242",
 		.drv_name = "glk_cs4242_mx98357a",
-- 
2.25.1

