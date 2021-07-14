Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C073C7CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhGNDZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:25:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:9187 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237811AbhGNDZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:25:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210095744"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="210095744"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="459818155"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:31 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 04/10] ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests
Date:   Wed, 14 Jul 2021 11:22:03 +0800
Message-Id: <20210714032209.11284-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add support for SoundWire mockup devices. The configurations assume the
same topology as the CML SoundWire devices and can be used to test the
SOF firmware on a development board (RVP, UpExtreme) without any
hardware connected.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig   |  1 +
 sound/soc/intel/boards/sof_sdw.c | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 7e29b0d911e2..046955bf717c 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -602,6 +602,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
 	select SND_SOC_DMIC
 	select SND_SOC_INTEL_HDA_DSP_COMMON
 	select SND_SOC_INTEL_SOF_MAXIM_COMMON
+	select SND_SOC_SDW_MOCKUP
 	help
 	  Add support for Intel SoundWire-based platforms connected to
 	  MAX98373, RT700, RT711, RT1308 and RT715
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 1a867c73a48e..82d909ef7a97 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -328,6 +328,19 @@ static const struct snd_soc_ops sdw_ops = {
 	.shutdown = sdw_shutdown,
 };
 
+static int sof_sdw_mic_codec_mockup_init(const struct snd_soc_acpi_link_adr *link,
+					 struct snd_soc_dai_link *dai_links,
+					 struct sof_sdw_codec_info *info,
+					 bool playback)
+{
+	/*
+	 * force DAI link to use same ID as RT715 and DMIC
+	 * to reuse topologies
+	 */
+	dai_links->id = SDW_DMIC_DAI_ID;
+	return 0;
+}
+
 static struct sof_sdw_codec_info codec_info_list[] = {
 	{
 		.part_id = 0x700,
@@ -410,6 +423,34 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.dai_name = "rt5682-sdw",
 		.init = sof_sdw_rt5682_init,
 	},
+	{
+		.part_id = 0xaaaa, /* generic codec mockup */
+		.version_id = 0,
+		.direction = {true, true},
+		.dai_name = "sdw-mockup-aif1",
+		.init = NULL,
+	},
+	{
+		.part_id = 0xaa55, /* headset codec mockup */
+		.version_id = 0,
+		.direction = {true, true},
+		.dai_name = "sdw-mockup-aif1",
+		.init = NULL,
+	},
+	{
+		.part_id = 0x55aa, /* amplifier mockup */
+		.version_id = 0,
+		.direction = {true, false},
+		.dai_name = "sdw-mockup-aif1",
+		.init = NULL,
+	},
+	{
+		.part_id = 0x5555,
+		.version_id = 0,
+		.direction = {false, true},
+		.dai_name = "sdw-mockup-aif1",
+		.init = sof_sdw_mic_codec_mockup_init,
+	},
 };
 
 static inline int find_codec_info_part(u64 adr)
-- 
2.17.1

