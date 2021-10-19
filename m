Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3A1433063
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhJSIGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:06:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:3802 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234132AbhJSIF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:05:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="225910631"
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="225910631"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 01:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="493984921"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
  by orsmga008.jf.intel.com with ESMTP; 19 Oct 2021 01:03:14 -0700
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
Subject: [PATCH v3 5/6]  ASoC: Intel: soc-acpi-cht: shrink tables using compatible IDs
Date:   Tue, 19 Oct 2021 15:59:40 +0800
Message-Id: <20211019075941.2037787-6-brent.lu@intel.com>
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
 .../intel/common/soc-acpi-intel-cht-match.c   | 69 +++++++------------
 1 file changed, 25 insertions(+), 44 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 227424236fd5..c60a5e8e7bc9 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -51,18 +51,31 @@ static struct snd_soc_acpi_mach *cht_quirk(void *arg)
 		return mach;
 }
 
+static const struct snd_soc_acpi_codecs rt5640_comp_ids = {
+	.num_codecs = 2,
+	.codecs = { "10EC5640", "10EC3276" },
+};
+
+static const struct snd_soc_acpi_codecs rt5670_comp_ids = {
+	.num_codecs = 2,
+	.codecs = { "10EC5670", "10EC5672" },
+};
+
+static const struct snd_soc_acpi_codecs rt5645_comp_ids = {
+	.num_codecs = 3,
+	.codecs = { "10EC5645", "10EC5650", "10EC3270" },
+};
+
+static const struct snd_soc_acpi_codecs da7213_comp_ids = {
+	.num_codecs = 2,
+	.codecs = { "DGLS7212", "DGLS7213"},
+
+};
+
 /* Cherryview-based platforms: CherryTrail and Braswell */
 struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 	{
-		.id = "10EC5670",
-		.drv_name = "cht-bsw-rt5672",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "cht-bsw",
-		.sof_fw_filename = "sof-cht.ri",
-		.sof_tplg_filename = "sof-cht-rt5670.tplg",
-	},
-	{
-		.id = "10EC5672",
+		.comp_ids = &rt5670_comp_ids,
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
@@ -70,23 +83,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.sof_tplg_filename = "sof-cht-rt5670.tplg",
 	},
 	{
-		.id = "10EC5645",
-		.drv_name = "cht-bsw-rt5645",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "cht-bsw",
-		.sof_fw_filename = "sof-cht.ri",
-		.sof_tplg_filename = "sof-cht-rt5645.tplg",
-	},
-	{
-		.id = "10EC5650",
-		.drv_name = "cht-bsw-rt5645",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "cht-bsw",
-		.sof_fw_filename = "sof-cht.ri",
-		.sof_tplg_filename = "sof-cht-rt5645.tplg",
-	},
-	{
-		.id = "10EC3270",
+		.comp_ids = &rt5645_comp_ids,
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
@@ -110,15 +107,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.sof_tplg_filename = "sof-cht-nau8824.tplg",
 	},
 	{
-		.id = "DLGS7212",
-		.drv_name = "bytcht_da7213",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "bytcht_da7213",
-		.sof_fw_filename = "sof-cht.ri",
-		.sof_tplg_filename = "sof-cht-da7213.tplg",
-	},
-	{
-		.id = "DLGS7213",
+		.comp_ids = &da7213_comp_ids,
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
@@ -135,7 +124,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 	},
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{
-		.id = "10EC5640",
+		.comp_ids = &rt5640_comp_ids,
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
@@ -143,14 +132,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5640.tplg",
 	},
-	{
-		.id = "10EC3276",
-		.drv_name = "bytcr_rt5640",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "bytcr_rt5640",
-		.sof_fw_filename = "sof-cht.ri",
-		.sof_tplg_filename = "sof-cht-rt5640.tplg",
-	},
 	{
 		.id = "10EC5682",
 		.drv_name = "sof_rt5682",
-- 
2.25.1

