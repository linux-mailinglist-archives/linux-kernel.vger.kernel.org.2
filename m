Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4739CBFD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 03:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFFBDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 21:03:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:36539 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhFFBDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 21:03:16 -0400
IronPort-SDR: HC4km0np955Igp3pCazvq7Qm7NE524qbck1MPQkChiVLACLvQQsSAg6T8LZw+nEOx3LjFCZvmk
 qOguxhT/tFsA==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="191581122"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="191581122"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 18:01:27 -0700
IronPort-SDR: qCxbjzj00kvKamMklQ45s+KiN4Rps4R1WK9Exhuo/fMfLZ620izV+ASq4ynv9HqIFsyav+xrZD
 tA7fg5vqgztg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="412724649"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.32])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2021 18:01:23 -0700
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
Subject: [PATCH 2/4] ASoC: Intel: maxim-common: support max98360a
Date:   Sun,  6 Jun 2021 08:41:00 +0800
Message-Id: <20210606004102.26190-3-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606004102.26190-1-brent.lu@intel.com>
References: <20210606004102.26190-1-brent.lu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move max98360a code to this common module so it could be shared
between multiple SOF machine drivers. MAX98357A and MAX98360A are
sharing same codec driver so here we also share some function and
structures.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_maxim_common.c | 17 ++++++++++++++++-
 sound/soc/intel/boards/sof_maxim_common.h |  4 +++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_maxim_common.c b/sound/soc/intel/boards/sof_maxim_common.c
index e9c52f8b6428..e66dfe666915 100644
--- a/sound/soc/intel/boards/sof_maxim_common.c
+++ b/sound/soc/intel/boards/sof_maxim_common.c
@@ -134,7 +134,7 @@ void max_98373_set_codec_conf(struct snd_soc_card *card)
 EXPORT_SYMBOL_NS(max_98373_set_codec_conf, SND_SOC_INTEL_SOF_MAXIM_COMMON);
 
 /*
- * Maxim MAX98357A
+ * Maxim MAX98357A/MAX98360A
  */
 static const struct snd_kcontrol_new max_98357a_kcontrols[] = {
 	SOC_DAPM_PIN_SWITCH("Spk"),
@@ -156,6 +156,13 @@ static struct snd_soc_dai_link_component max_98357a_components[] = {
 	}
 };
 
+static struct snd_soc_dai_link_component max_98360a_components[] = {
+	{
+		.name = MAX_98360A_DEV0_NAME,
+		.dai_name = MAX_98357A_CODEC_DAI,
+	}
+};
+
 static int max_98357a_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -193,5 +200,13 @@ void max_98357a_dai_link(struct snd_soc_dai_link *link)
 }
 EXPORT_SYMBOL_NS(max_98357a_dai_link, SND_SOC_INTEL_SOF_MAXIM_COMMON);
 
+void max_98360a_dai_link(struct snd_soc_dai_link *link)
+{
+	link->codecs = max_98360a_components;
+	link->num_codecs = ARRAY_SIZE(max_98360a_components);
+	link->init = max_98357a_init;
+}
+EXPORT_SYMBOL_NS(max_98360a_dai_link, SND_SOC_INTEL_SOF_MAXIM_COMMON);
+
 MODULE_DESCRIPTION("ASoC Intel SOF Maxim helpers");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/intel/boards/sof_maxim_common.h b/sound/soc/intel/boards/sof_maxim_common.h
index 2674f1e373ef..3ff5e8fec4de 100644
--- a/sound/soc/intel/boards/sof_maxim_common.h
+++ b/sound/soc/intel/boards/sof_maxim_common.h
@@ -25,11 +25,13 @@ void max_98373_set_codec_conf(struct snd_soc_card *card);
 int max_98373_trigger(struct snd_pcm_substream *substream, int cmd);
 
 /*
- * Maxim MAX98357A
+ * Maxim MAX98357A/MAX98360A
  */
 #define MAX_98357A_CODEC_DAI	"HiFi"
 #define MAX_98357A_DEV0_NAME	"MX98357A:00"
+#define MAX_98360A_DEV0_NAME	"MX98360A:00"
 
 void max_98357a_dai_link(struct snd_soc_dai_link *link);
+void max_98360a_dai_link(struct snd_soc_dai_link *link);
 
 #endif /* __SOF_MAXIM_COMMON_H */
-- 
2.17.1

