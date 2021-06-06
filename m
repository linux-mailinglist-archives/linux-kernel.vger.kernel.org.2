Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8525639CBFF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 03:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFFBD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 21:03:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:63706 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhFFBD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 21:03:26 -0400
IronPort-SDR: fuBRhO6f7CCgA4WWgbR+Pttnk5ouIs7+EeBDq7MGNZBWR0hYXINDUMUPaSlqvKx0sypftWB1o0
 nruLx0zCa8FA==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="204283895"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="204283895"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 18:01:37 -0700
IronPort-SDR: N0nuN/A298sqmvJi2BrB0/rNdxzhhGMIMscwyuRGynCC0D9R1JUtqW3nyQDuRrXt1tsEvtysJl
 G14KaxTJPzyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="412724682"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.32])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2021 18:01:33 -0700
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
Subject: [PATCH 4/4] ASoC: Intel: sof_rt5682: code refactor for max98360a
Date:   Sun,  6 Jun 2021 08:41:02 +0800
Message-Id: <20210606004102.26190-5-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606004102.26190-1-brent.lu@intel.com>
References: <20210606004102.26190-1-brent.lu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the machine driver by using the common code in maxim-common
module to support max98360a.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 52 +----------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 3e69feaf052b..910c054b0b42 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -456,10 +456,6 @@ static const struct snd_kcontrol_new sof_controls[] = {
 
 };
 
-static const struct snd_kcontrol_new speaker_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Spk"),
-};
-
 static const struct snd_soc_dapm_widget sof_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -467,10 +463,6 @@ static const struct snd_soc_dapm_widget sof_widgets[] = {
 	SND_SOC_DAPM_SPK("Right Spk", NULL),
 };
 
-static const struct snd_soc_dapm_widget speaker_widgets[] = {
-	SND_SOC_DAPM_SPK("Spk", NULL),
-};
-
 static const struct snd_soc_dapm_widget dmic_widgets[] = {
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
 };
@@ -484,11 +476,6 @@ static const struct snd_soc_dapm_route sof_map[] = {
 	{ "IN1P", NULL, "Headset Mic" },
 };
 
-static const struct snd_soc_dapm_route speaker_map[] = {
-	/* speaker */
-	{ "Spk", NULL, "Speaker" },
-};
-
 static const struct snd_soc_dapm_route speaker_map_lr[] = {
 	{ "Left Spk", NULL, "Left SPO" },
 	{ "Right Spk", NULL, "Right SPO" },
@@ -505,34 +492,6 @@ static int speaker_codec_init_lr(struct snd_soc_pcm_runtime *rtd)
 				       ARRAY_SIZE(speaker_map_lr));
 }
 
-static int speaker_codec_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_card *card = rtd->card;
-	int ret;
-
-	ret = snd_soc_dapm_new_controls(&card->dapm, speaker_widgets,
-					ARRAY_SIZE(speaker_widgets));
-	if (ret) {
-		dev_err(rtd->dev, "unable to add dapm controls, ret %d\n", ret);
-		/* Don't need to add routes if widget addition failed */
-		return ret;
-	}
-
-	ret = snd_soc_add_card_controls(card, speaker_controls,
-					ARRAY_SIZE(speaker_controls));
-	if (ret) {
-		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
-		return ret;
-	}
-
-	ret = snd_soc_dapm_add_routes(&card->dapm, speaker_map,
-				      ARRAY_SIZE(speaker_map));
-
-	if (ret)
-		dev_err(rtd->dev, "Speaker map addition failed: %d\n", ret);
-	return ret;
-}
-
 static int dmic_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -594,13 +553,6 @@ static struct snd_soc_dai_link_component dmic_component[] = {
 	}
 };
 
-static struct snd_soc_dai_link_component max98360a_component[] = {
-	{
-		.name = "MX98360A:00",
-		.dai_name = "HiFi",
-	}
-};
-
 static struct snd_soc_dai_link_component rt1015_components[] = {
 	{
 		.name = "i2c-10EC1015:00",
@@ -775,9 +727,7 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 			links[id].dpcm_capture = 1;
 		} else if (sof_rt5682_quirk &
 				SOF_MAX98360A_SPEAKER_AMP_PRESENT) {
-			links[id].codecs = max98360a_component;
-			links[id].num_codecs = ARRAY_SIZE(max98360a_component);
-			links[id].init = speaker_codec_init;
+			max_98360a_dai_link(&links[id]);
 		} else if (sof_rt5682_quirk &
 				SOF_RT1011_SPEAKER_AMP_PRESENT) {
 			sof_rt1011_dai_link(&links[id]);
-- 
2.17.1

