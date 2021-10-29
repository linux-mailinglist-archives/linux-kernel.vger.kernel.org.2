Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C054E440112
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhJ2RTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:19:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:3618 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhJ2RTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:19:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="294170843"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="294170843"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 10:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="598276551"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.1])
  by orsmga004.jf.intel.com with ESMTP; 29 Oct 2021 10:16:12 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Gongjun Song <gongjun.song@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v5 4/6] ASoC: Intel: soc-acpi-byt: shrink tables using compatible IDs
Date:   Sat, 30 Oct 2021 01:14:07 +0800
Message-Id: <20211029171409.611600-5-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029171409.611600-1-brent.lu@intel.com>
References: <20211029171409.611600-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We have multiple entries for the same codecs, use the new compatible
IDs to have a single entry.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
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

