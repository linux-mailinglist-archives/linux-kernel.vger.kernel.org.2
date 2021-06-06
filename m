Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70B739CBFE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 03:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFFBDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 21:03:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:58055 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhFFBDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 21:03:21 -0400
IronPort-SDR: Wyca8048B5jUZZrHAWBUN8bqHq1+7oqsigTb4hlAZist5itGaFiM59tgPQKJDsW4DaUMol+AZa
 BpHt9C+TRbsw==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="184839576"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="184839576"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 18:01:32 -0700
IronPort-SDR: AZ3eSPObdmUe+44+03jvcZpaAfnWd9pGG2PZAyDB1Ol34l0UVaiF4IXwcAN+1cUkVHmw/wC4lw
 IulXnUiUANQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="412724660"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.32])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2021 18:01:28 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 3/4] ASoC: intel: sof_cs42l42: add support for jsl_cs4242_mx98360a
Date:   Sun,  6 Jun 2021 08:41:01 +0800
Message-Id: <20210606004102.26190-4-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606004102.26190-1-brent.lu@intel.com>
References: <20210606004102.26190-1-brent.lu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds driver data for jsl_cs4242_mx98360a which supports two
max98360a speaker amplifiers on SSP1 and cs42l42 headphone codec on
SSP0 running on JSL platform. DAI format is leveraged from sof_rt5682
machine driver to reuse the topology.

Also use module device table to replace module alias.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_cs42l42.c          | 22 +++++++++++++++----
 .../intel/common/soc-acpi-intel-jsl-match.c   |  8 +++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
index e3171242f612..d712cfb91fd1 100644
--- a/sound/soc/intel/boards/sof_cs42l42.c
+++ b/sound/soc/intel/boards/sof_cs42l42.c
@@ -36,7 +36,9 @@
 #define SOF_CS42L42_NUM_HDMIDEV_MASK		(GENMASK(9, 7))
 #define SOF_CS42L42_NUM_HDMIDEV(quirk)	\
 	(((quirk) << SOF_CS42L42_NUM_HDMIDEV_SHIFT) & SOF_CS42L42_NUM_HDMIDEV_MASK)
-#define SOF_MAX98357A_SPEAKER_AMP_PRESENT	BIT(10)
+#define SOF_CS42L42_BCLK_2400000		BIT(10)
+#define SOF_MAX98357A_SPEAKER_AMP_PRESENT	BIT(11)
+#define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(12)
 
 /* Default: SSP2 */
 static unsigned long sof_cs42l42_quirk = SOF_CS42L42_SSP_CODEC(2);
@@ -122,7 +124,10 @@ static int sof_cs42l42_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	int clk_freq, ret;
 
-	clk_freq = 3072000; /* BCLK freq */
+	if (sof_cs42l42_quirk & SOF_CS42L42_BCLK_2400000)
+		clk_freq = 2400000; /* BCLK freq */
+	else
+		clk_freq = 3072000; /* BCLK freq */
 
 	/* Configure sysclk for codec */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
@@ -281,6 +286,8 @@ static int create_spk_amp_dai_links(struct device *dev,
 
 	if (sof_cs42l42_quirk & SOF_MAX98357A_SPEAKER_AMP_PRESENT) {
 		max_98357a_dai_link(&links[*id]);
+	} else if (sof_cs42l42_quirk & SOF_MAX98360A_SPEAKER_AMP_PRESENT) {
+		max_98360a_dai_link(&links[*id]);
 	} else {
 		dev_err(dev, "no amp defined\n");
 		ret = -EINVAL;
@@ -584,8 +591,17 @@ static const struct platform_device_id board_ids[] = {
 					SOF_MAX98357A_SPEAKER_AMP_PRESENT |
 					SOF_CS42L42_SSP_AMP(1)),
 	},
+	{
+		.name = "jsl_cs4242_mx98360a",
+		.driver_data = (kernel_ulong_t)(SOF_CS42L42_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
+					SOF_CS42L42_SSP_AMP(1)) |
+					SOF_CS42L42_BCLK_2400000,
+	},
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, board_ids);
 
 static struct platform_driver sof_audio = {
 	.probe = sof_audio_probe,
@@ -601,7 +617,5 @@ module_platform_driver(sof_audio)
 MODULE_DESCRIPTION("SOF Audio Machine driver for CS42L42");
 MODULE_AUTHOR("Brent Lu <brent.lu@intel.com>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:sof_cs42l42");
-MODULE_ALIAS("platform:glk_cs4242_max98357a");
 MODULE_IMPORT_NS(SND_SOC_INTEL_HDA_DSP_COMMON);
 MODULE_IMPORT_NS(SND_SOC_INTEL_SOF_MAXIM_COMMON);
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
index 73fe4f89a82d..8e86476d48de 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -73,6 +73,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 		.quirk_data = &mx98360a_spk,
 		.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
 	},
+	{
+		.id = "10134242",
+		.drv_name = "jsl_cs4242_mx98360a",
+		.sof_fw_filename = "sof-jsl.ri",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &mx98360a_spk,
+		.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_jsl_machines);
-- 
2.17.1

