Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE542427B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbhJFQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:22:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:50900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhJFQWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:22:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="225926668"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="225926668"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:20:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="657046708"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
  by orsmga005.jf.intel.com with ESMTP; 06 Oct 2021 09:20:17 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        linux-kernel@vger.kernel.org, Rander Wang <rander.wang@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate rt5682s
Date:   Thu,  7 Oct 2021 00:18:05 +0800
Message-Id: <20211006161805.938950-4-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006161805.938950-1-brent.lu@intel.com>
References: <20211006161805.938950-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the id_alt field to enumerate rt5682s headphone codec and remove
redundant entries in tables.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c           | 30 -----------------
 .../intel/common/soc-acpi-intel-adl-match.c   |  8 +++++
 .../intel/common/soc-acpi-intel-byt-match.c   |  6 ++++
 .../intel/common/soc-acpi-intel-cht-match.c   |  6 ++++
 .../intel/common/soc-acpi-intel-cml-match.c   |  8 +++++
 .../intel/common/soc-acpi-intel-icl-match.c   |  6 ++++
 .../intel/common/soc-acpi-intel-jsl-match.c   | 32 +++++--------------
 .../intel/common/soc-acpi-intel-tgl-match.c   |  8 +++++
 8 files changed, 50 insertions(+), 54 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 9f1e5ef11b13..9819345cd84c 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -1050,36 +1050,6 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(2) |
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
-	{
-		.name = "jsl_rt5682s_rt1015",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_MCLK_24MHZ |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_RT5682S_HEADPHONE_CODEC_PRESENT |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_RT1015_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1)),
-	},
-	{
-		.name = "jsl_rt5682s_rt1015p",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_MCLK_24MHZ |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_RT5682S_HEADPHONE_CODEC_PRESENT |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_RT1015P_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1)),
-	},
-	{
-		.name = "jsl_rt5682s_mx98360",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_MCLK_24MHZ |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_RT5682S_HEADPHONE_CODEC_PRESENT |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1)),
-	},
 	{
 		.name = "adl_mx98360_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index f5b21a95d222..9478e35bed38 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -285,9 +285,15 @@ static const struct snd_soc_acpi_codecs adl_max98360a_amp = {
 	.codecs = {"MX98360A"}
 };
 
+static struct snd_soc_acpi_codecs adl_rt5682s_hp = {
+	.num_codecs = 1,
+	.codecs = {"RTL5682"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	{
 		.id = "10EC5682",
+		.id_alt = &adl_rt5682s_hp,
 		.drv_name = "adl_mx98373_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98373_amp,
@@ -296,6 +302,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &adl_rt5682s_hp,
 		.drv_name = "adl_mx98357_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98357a_amp,
@@ -304,6 +311,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &adl_rt5682s_hp,
 		.drv_name = "adl_mx98360_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98360a_amp,
diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index 510a5f38b7f1..8c66223d7401 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -120,6 +120,11 @@ static struct snd_soc_acpi_mach *byt_quirk(void *arg)
 	}
 }
 
+static struct snd_soc_acpi_codecs rt5682s_hp = {
+	.num_codecs = 1,
+	.codecs = {"RTL5682"}
+};
+
 struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 	{
 		.id = "10EC5640",
@@ -196,6 +201,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &rt5682s_hp,
 		.drv_name = "sof_rt5682",
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-rt5682.tplg",
diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 227424236fd5..6e52110897e9 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -51,6 +51,11 @@ static struct snd_soc_acpi_mach *cht_quirk(void *arg)
 		return mach;
 }
 
+static struct snd_soc_acpi_codecs rt5682s_hp = {
+	.num_codecs = 1,
+	.codecs = {"RTL5682"}
+};
+
 /* Cherryview-based platforms: CherryTrail and Braswell */
 struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 	{
@@ -153,6 +158,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &rt5682s_hp,
 		.drv_name = "sof_rt5682",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5682.tplg",
diff --git a/sound/soc/intel/common/soc-acpi-intel-cml-match.c b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
index b591c6fd13fd..ac93d77f47ff 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cml-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
@@ -29,6 +29,11 @@ static struct snd_soc_acpi_codecs max98390_spk_codecs = {
 	.codecs = {"MX98390"}
 };
 
+static struct snd_soc_acpi_codecs rt5682s_hp = {
+	.num_codecs = 1,
+	.codecs = {"RTL5682"}
+};
+
 /*
  * The order of the three entries with .id = "10EC5682" matters
  * here, because DSDT tables expose an ACPI HID for the MAX98357A
@@ -45,6 +50,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cml_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &rt5682s_hp,
 		.drv_name = "cml_rt1015_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &rt1015_spk_codecs,
@@ -53,6 +59,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cml_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &rt5682s_hp,
 		.drv_name = "sof_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &max98357a_spk_codecs,
@@ -61,6 +68,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cml_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &rt5682s_hp,
 		.drv_name = "sof_rt5682",
 		.sof_fw_filename = "sof-cml.ri",
 		.sof_tplg_filename = "sof-cml-rt5682.tplg",
diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
index 768ed538c4ea..14430b969e6c 100644
--- a/sound/soc/intel/common/soc-acpi-intel-icl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
@@ -14,6 +14,11 @@ static struct skl_machine_pdata icl_pdata = {
 	.use_tplg_pcm = true,
 };
 
+static struct snd_soc_acpi_codecs rt5682s_hp = {
+	.num_codecs = 1,
+	.codecs = {"RTL5682"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[] = {
 	{
 		.id = "INT34C2",
@@ -25,6 +30,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &rt5682s_hp,
 		.drv_name = "sof_rt5682",
 		.sof_fw_filename = "sof-icl.ri",
 		.sof_tplg_filename = "sof-icl-rt5682.tplg",
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
index 20fd9dcc74af..4ffd91fd6862 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -29,6 +29,11 @@ static struct snd_soc_acpi_codecs mx98360a_spk = {
 	.codecs = {"MX98360A"}
 };
 
+static struct snd_soc_acpi_codecs rt5682s_hp = {
+	.num_codecs = 1,
+	.codecs = {"RTL5682"}
+};
+
 /*
  * When adding new entry to the snd_soc_acpi_intel_jsl_machines array,
  * use .quirk_data member to distinguish different machine driver,
@@ -51,6 +56,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &rt5682s_hp,
 		.drv_name = "jsl_rt5682_rt1015",
 		.sof_fw_filename = "sof-jsl.ri",
 		.machine_quirk = snd_soc_acpi_codec_list,
@@ -59,6 +65,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &rt5682s_hp,
 		.drv_name = "jsl_rt5682_rt1015p",
 		.sof_fw_filename = "sof-jsl.ri",
 		.machine_quirk = snd_soc_acpi_codec_list,
@@ -67,6 +74,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &rt5682s_hp,
 		.drv_name = "jsl_rt5682_mx98360",
 		.sof_fw_filename = "sof-jsl.ri",
 		.machine_quirk = snd_soc_acpi_codec_list,
@@ -81,30 +89,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 		.quirk_data = &mx98360a_spk,
 		.sof_tplg_filename = "sof-jsl-cs42l42-mx98360a.tplg",
 	},
-	{
-		.id = "RTL5682",
-		.drv_name = "jsl_rt5682s_rt1015",
-		.sof_fw_filename = "sof-jsl.ri",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &rt1015_spk,
-		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
-	},
-	{
-		.id = "RTL5682",
-		.drv_name = "jsl_rt5682s_rt1015p",
-		.sof_fw_filename = "sof-jsl.ri",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &rt1015p_spk,
-		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
-	},
-	{
-		.id = "RTL5682",
-		.drv_name = "jsl_rt5682s_mx98360",
-		.sof_fw_filename = "sof-jsl.ri",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &mx98360a_spk,
-		.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
-	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_jsl_machines);
diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index 9d89f01d6b84..e65bd6db2850 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -358,9 +358,15 @@ static const struct snd_soc_acpi_codecs tgl_rt1011_amp = {
 	.codecs = {"10EC1011"}
 };
 
+static struct snd_soc_acpi_codecs tgl_rt5682s_hp = {
+	.num_codecs = 1,
+	.codecs = {"RTL5682"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	{
 		.id = "10EC5682",
+		.id_alt = &tgl_rt5682s_hp,
 		.drv_name = "tgl_mx98357_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_codecs,
@@ -369,6 +375,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &tgl_rt5682s_hp,
 		.drv_name = "tgl_mx98373_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_max98373_amp,
@@ -377,6 +384,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
+		.id_alt = &tgl_rt5682s_hp,
 		.drv_name = "tgl_rt1011_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_rt1011_amp,
-- 
2.25.1

