Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99947433061
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhJSIFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:05:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:20591 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234649AbhJSIFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:05:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="227218248"
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="227218248"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 01:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="493984534"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
  by orsmga008.jf.intel.com with ESMTP; 19 Oct 2021 01:02:55 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Gongjun Song <gongjun.song@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 3/6] ASoC: Intel: sof_rt5682: use comp_ids to enumerate rt5682s
Date:   Tue, 19 Oct 2021 15:59:38 +0800
Message-Id: <20211019075941.2037787-4-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019075941.2037787-1-brent.lu@intel.com>
References: <20211019075941.2037787-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use comp_ids field to enumerate rt5682/rt5682s headphone codec for
JSL/TGL/ADL devices and remove redundant entries in tables.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c           | 30 ----------------
 .../intel/common/soc-acpi-intel-adl-match.c   | 11 ++++--
 .../intel/common/soc-acpi-intel-jsl-match.c   | 35 +++++--------------
 .../intel/common/soc-acpi-intel-tgl-match.c   | 11 ++++--
 4 files changed, 24 insertions(+), 63 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index c41c584379d9..c41f386b4138 100644
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
index f5b21a95d222..06f503452aa5 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -285,9 +285,14 @@ static const struct snd_soc_acpi_codecs adl_max98360a_amp = {
 	.codecs = {"MX98360A"}
 };
 
+static const struct snd_soc_acpi_codecs adl_rt5682_rt5682s_hp = {
+	.num_codecs = 2,
+	.codecs = {"10EC5682", "RTL5682"},
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	{
-		.id = "10EC5682",
+		.comp_ids = &adl_rt5682_rt5682s_hp,
 		.drv_name = "adl_mx98373_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98373_amp,
@@ -295,7 +300,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.sof_tplg_filename = "sof-adl-max98373-rt5682.tplg",
 	},
 	{
-		.id = "10EC5682",
+		.comp_ids = &adl_rt5682_rt5682s_hp,
 		.drv_name = "adl_mx98357_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98357a_amp,
@@ -303,7 +308,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.sof_tplg_filename = "sof-adl-max98357a-rt5682.tplg",
 	},
 	{
-		.id = "10EC5682",
+		.comp_ids = &adl_rt5682_rt5682s_hp,
 		.drv_name = "adl_mx98360_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98360a_amp,
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
index 20fd9dcc74af..46aa96bfbf14 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -29,6 +29,11 @@ static struct snd_soc_acpi_codecs mx98360a_spk = {
 	.codecs = {"MX98360A"}
 };
 
+static const struct snd_soc_acpi_codecs rt5682_rt5682s_hp = {
+	.num_codecs = 2,
+	.codecs = {"10EC5682", "RTL5682"},
+};
+
 /*
  * When adding new entry to the snd_soc_acpi_intel_jsl_machines array,
  * use .quirk_data member to distinguish different machine driver,
@@ -50,7 +55,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 		.sof_tplg_filename = "sof-jsl-da7219-mx98360a.tplg",
 	},
 	{
-		.id = "10EC5682",
+		.comp_ids = &rt5682_rt5682s_hp,
 		.drv_name = "jsl_rt5682_rt1015",
 		.sof_fw_filename = "sof-jsl.ri",
 		.machine_quirk = snd_soc_acpi_codec_list,
@@ -58,7 +63,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
 	},
 	{
-		.id = "10EC5682",
+		.comp_ids = &rt5682_rt5682s_hp,
 		.drv_name = "jsl_rt5682_rt1015p",
 		.sof_fw_filename = "sof-jsl.ri",
 		.machine_quirk = snd_soc_acpi_codec_list,
@@ -66,7 +71,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
 	},
 	{
-		.id = "10EC5682",
+		.comp_ids = &rt5682_rt5682s_hp,
 		.drv_name = "jsl_rt5682_mx98360",
 		.sof_fw_filename = "sof-jsl.ri",
 		.machine_quirk = snd_soc_acpi_codec_list,
@@ -81,30 +86,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
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
index 9d89f01d6b84..da31bb3cca17 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -358,9 +358,14 @@ static const struct snd_soc_acpi_codecs tgl_rt1011_amp = {
 	.codecs = {"10EC1011"}
 };
 
+static const struct snd_soc_acpi_codecs tgl_rt5682_rt5682s_hp = {
+	.num_codecs = 2,
+	.codecs = {"10EC5682", "RTL5682"},
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	{
-		.id = "10EC5682",
+		.comp_ids = &tgl_rt5682_rt5682s_hp,
 		.drv_name = "tgl_mx98357_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_codecs,
@@ -368,7 +373,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 		.sof_tplg_filename = "sof-tgl-max98357a-rt5682.tplg",
 	},
 	{
-		.id = "10EC5682",
+		.comp_ids = &tgl_rt5682_rt5682s_hp,
 		.drv_name = "tgl_mx98373_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_max98373_amp,
@@ -376,7 +381,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 		.sof_tplg_filename = "sof-tgl-max98373-rt5682.tplg",
 	},
 	{
-		.id = "10EC5682",
+		.comp_ids = &tgl_rt5682_rt5682s_hp,
 		.drv_name = "tgl_rt1011_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_rt1011_amp,
-- 
2.25.1

