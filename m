Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C84E433064
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhJSIGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:06:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:60470 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234684AbhJSIGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="208550969"
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="208550969"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 01:03:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="493984698"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
  by orsmga008.jf.intel.com with ESMTP; 19 Oct 2021 01:03:05 -0700
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
Subject: [PATCH v3 4/6] ASoC: Intel: soc-acpi-byt: shrink tables using compatible IDs
Date:   Tue, 19 Oct 2021 15:59:39 +0800
Message-Id: <20211019075941.2037787-5-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019075941.2037787-1-brent.lu@intel.com>
References: <20211019075941.2037787-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We have multiple entries for the same codecs, use the new compatible
IDs to have a single entry.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-byt-match.c   | 68 +++++++------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index 510a5f38b7f1..142000991813 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -120,9 +120,29 @@ static struct snd_soc_acpi_mach *byt_quirk(void *arg)
 	}
 }
 
+static const struct snd_soc_acpi_codecs rt5640_comp_ids = {
+	.num_codecs = 3,
+	.codecs = { "10EC5640", "10EC5642", "INTCCFFD"},
+};
+
+static const struct snd_soc_acpi_codecs wm5102_comp_ids = {
+	.num_codecs = 2,
+	.codecs = { "WM510204", "WM510205"},
+};
+
+static const struct snd_soc_acpi_codecs da7213_comp_ids = {
+	.num_codecs = 2,
+	.codecs = { "DGLS7212", "DGLS7213"},
+};
+
+static const struct snd_soc_acpi_codecs rt5645_comp_ids = {
+	.num_codecs = 2,
+	.codecs = { "10EC5645", "10EC5648"},
+};
+
 struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 	{
-		.id = "10EC5640",
+		.comp_ids = &rt5640_comp_ids,
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
@@ -130,22 +150,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-rt5640.tplg",
 	},
-	{
-		.id = "10EC5642",
-		.drv_name = "bytcr_rt5640",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcr_rt5640",
-		.sof_fw_filename = "sof-byt.ri",
-		.sof_tplg_filename = "sof-byt-rt5640.tplg",
-	},
-	{
-		.id = "INTCCFFD",
-		.drv_name = "bytcr_rt5640",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcr_rt5640",
-		.sof_fw_filename = "sof-byt.ri",
-		.sof_tplg_filename = "sof-byt-rt5640.tplg",
-	},
 	{
 		.id = "10EC5651",
 		.drv_name = "bytcr_rt5651",
@@ -155,7 +159,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.sof_tplg_filename = "sof-byt-rt5651.tplg",
 	},
 	{
-		.id = "WM510204",
+		.comp_ids = &wm5102_comp_ids,
 		.drv_name = "bytcr_wm5102",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_wm5102",
@@ -163,23 +167,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.sof_tplg_filename = "sof-byt-wm5102.tplg",
 	},
 	{
-		.id = "WM510205",
-		.drv_name = "bytcr_wm5102",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcr_wm5102",
-		.sof_fw_filename = "sof-byt.ri",
-		.sof_tplg_filename = "sof-byt-wm5102.tplg",
-	},
-	{
-		.id = "DLGS7212",
-		.drv_name = "bytcht_da7213",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcht_da7213",
-		.sof_fw_filename = "sof-byt.ri",
-		.sof_tplg_filename = "sof-byt-da7213.tplg",
-	},
-	{
-		.id = "DLGS7213",
+		.comp_ids = &da7213_comp_ids,
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcht_da7213",
@@ -202,15 +190,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 	},
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
 	{
-		.id = "10EC5645",
-		.drv_name = "cht-bsw-rt5645",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "cht-bsw",
-		.sof_fw_filename = "sof-byt.ri",
-		.sof_tplg_filename = "sof-byt-rt5645.tplg",
-	},
-	{
-		.id = "10EC5648",
+		.comp_ids = &rt5645_comp_ids,
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
-- 
2.25.1

