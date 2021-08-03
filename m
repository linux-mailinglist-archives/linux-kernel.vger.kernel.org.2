Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290433DE9A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhHCJVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhHCJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:21:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA3CC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 02:20:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so3842317pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/rFmcgcm4hQ2h0tl29kMkZadCPDH7bgmFtfdjJ9aePg=;
        b=pGtmmIDfokSjxryZ/p4CkTvr/sWJ7bYJrrkSQ2MWqW3bcnbBMpOysXDqtN7ag0auPk
         yJ8lLY732mHihfFe4wi74qMcGzD5eiOu7H19hUfisyW/HxSYNQq49T0RbmmrbKrFHX7I
         C9ga7GXRYrXqvEYM/MuSPMJsyapJFHypnwyLSjsJvTiDyHRTssSN9dKgQzlNb+OnQtMe
         sbmPXvU+Yy1Q9r1Q7Hq4sMz6wcJEi4CNgeF7nCHpuiPrpU2mv32iILZ0aOTT4QovJoCt
         BjWoPFrOqClhRHWY96bUKSkNMFfs7TY+FN+cJ6FgIqjP8z0R1HgQ4ueNetXYRmLMrSC1
         perA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/rFmcgcm4hQ2h0tl29kMkZadCPDH7bgmFtfdjJ9aePg=;
        b=cqN/+inTD3QSB0Tkdit4C1ajrkibmDFe0x3C+ajfT9q5LXcCN7uN+GxBrzF6EiIXOI
         zn9UDWRM0Mvox4RuDojGbH7EL6XmdAsBMiln4G9GW2zlRP08jzNyMbYwh9T5m7yBwiDs
         ixFBXn9b+aB4coZaO9QwVlVhkLPCWqsRuRPhd/pIqjTseq5FwmalyGy3nDycE1ES/apS
         3vu82i2Ti5281lOt8TmC0AAMvgYDHFBzYiHMvVojvClzKA2+Lw9OtjwdOyV6XCqPw89q
         FFXn/GWkL0HBQxwJVxxT2PTM++9HuI93x7dWZiIGz68qHu4rmi5xUqSdjQqULB6+N8y5
         kuFg==
X-Gm-Message-State: AOAM531fXAKQOSrePR1plU+CaitTmFTGcUBCRQouzTI/V0WT5cT12sdG
        TR1k74P4m9COCg5lJo4Zs57Nrw==
X-Google-Smtp-Source: ABdhPJximAivsC6Zmfv8exbTnPGtW+8XR6+ifjGidg15PTkVFlXRmV8Amsn0drbmAr0fkXdC6LpNGA==
X-Received: by 2002:a65:520b:: with SMTP id o11mr2522987pgp.406.1627982458836;
        Tue, 03 Aug 2021 02:20:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:4dd:3ed3:60f2:c71c:b30:a151])
        by smtp.gmail.com with ESMTPSA id y9sm16257616pgr.10.2021.08.03.02.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 02:20:58 -0700 (PDT)
From:   Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
To:     alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, mac.chiang@intel.com,
        lance.hou@intel.com, broonie@kernel.org, brent.lu@intel.com,
        bard.liao@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, mark_hsieh@wistron.com,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Subject: [PATCH] ASoC: Intel: sof_rt5682: Add max98390 echo reference support
Date:   Tue,  3 Aug 2021 17:20:13 +0800
Message-Id: <20210803092013.10749-1-mark_hsieh@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
---
 sound/soc/intel/boards/sof_maxim_common.c     | 126 ++++++++++++++++++
 sound/soc/intel/boards/sof_maxim_common.h     |  15 +++
 sound/soc/intel/boards/sof_rt5682.c           |  43 +++++-
 .../intel/common/soc-acpi-intel-adl-match.c   |  13 ++
 4 files changed, 196 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_maxim_common.c b/sound/soc/intel/boards/sof_maxim_common.c
index e9c52f8b6428..179f1d12e1b8 100644
--- a/sound/soc/intel/boards/sof_maxim_common.c
+++ b/sound/soc/intel/boards/sof_maxim_common.c
@@ -11,6 +11,7 @@
 #include "sof_maxim_common.h"
 
 #define MAX_98373_PIN_NAME 16
+#define MAX_98390_PIN_NAME 16
 
 const struct snd_soc_dapm_route max_98373_dapm_routes[] = {
 	/* speaker */
@@ -133,6 +134,131 @@ void max_98373_set_codec_conf(struct snd_soc_card *card)
 }
 EXPORT_SYMBOL_NS(max_98373_set_codec_conf, SND_SOC_INTEL_SOF_MAXIM_COMMON);
 
+/*
+ * Maxim MAX98390
+ */
+
+const struct snd_soc_dapm_route max_98390_dapm_routes[] = {
+	/* speaker */
+	{ "Left Spk", NULL, "Left BE_OUT" },
+	{ "Right Spk", NULL, "Right BE_OUT" },
+};
+EXPORT_SYMBOL_NS(max_98390_dapm_routes, SND_SOC_INTEL_SOF_MAXIM_COMMON);
+
+static struct snd_soc_codec_conf max_98390_codec_conf[] = {
+	{
+		.dlc = COMP_CODEC_CONF(MAX_98390_DEV0_NAME),
+		.name_prefix = "Right",
+	},
+	{
+		.dlc = COMP_CODEC_CONF(MAX_98390_DEV1_NAME),
+		.name_prefix = "Left",
+	},
+};
+
+struct snd_soc_dai_link_component max_98390_components[] = {
+	{  /* For Right */
+		.name = MAX_98373_DEV0_NAME,
+		.dai_name = MAX_98390_CODEC_DAI,
+	},
+	{  /* For Left */
+		.name = MAX_98373_DEV1_NAME,
+		.dai_name = MAX_98390_CODEC_DAI,
+	},
+};
+EXPORT_SYMBOL_NS(max_98390_components, SND_SOC_INTEL_SOF_MAXIM_COMMON);
+
+static int max_98390_hw_params(struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *codec_dai;
+	int j;
+
+	for_each_rtd_codec_dais(rtd, j, codec_dai) {
+		if (!strcmp(codec_dai->component->name, MAX_98390_DEV0_NAME)) {
+			/* DEV0 tdm slot configuration */
+			snd_soc_dai_set_tdm_slot(codec_dai, 0x03, 3, 8, 32);
+		}
+		if (!strcmp(codec_dai->component->name, MAX_98390_DEV1_NAME)) {
+			/* DEV1 tdm slot configuration */
+			snd_soc_dai_set_tdm_slot(codec_dai, 0x0C, 3, 8, 32);
+		}
+	}
+	return 0;
+}
+
+int max_98390_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai;
+	int j;
+	int ret = 0;
+
+	/* set spk pin by playback only */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		return 0;
+
+	cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	for_each_rtd_codec_dais(rtd, j, codec_dai) {
+		struct snd_soc_dapm_context *dapm =
+				snd_soc_component_get_dapm(cpu_dai->component);
+		char pin_name[MAX_98390_PIN_NAME];
+
+		snprintf(pin_name, ARRAY_SIZE(pin_name), "%s Spk",
+			 codec_dai->component->name_prefix);
+
+		switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+		case SNDRV_PCM_TRIGGER_RESUME:
+		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			ret = snd_soc_dapm_enable_pin(dapm, pin_name);
+			if (!ret)
+				snd_soc_dapm_sync(dapm);
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+		case SNDRV_PCM_TRIGGER_SUSPEND:
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			ret = snd_soc_dapm_disable_pin(dapm, pin_name);
+			if (!ret)
+				snd_soc_dapm_sync(dapm);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_NS(max_98390_trigger, SND_SOC_INTEL_SOF_MAXIM_COMMON);
+
+struct snd_soc_ops max_98390_ops = {
+	.hw_params = max_98390_hw_params,
+	.trigger = max_98390_trigger,
+};
+EXPORT_SYMBOL_NS(max_98390_ops, SND_SOC_INTEL_SOF_MAXIM_COMMON);
+
+int max_98390_spk_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	int ret;
+
+	ret = snd_soc_dapm_add_routes(&card->dapm, max_98390_dapm_routes,
+				      ARRAY_SIZE(max_98390_dapm_routes));
+	if (ret)
+		dev_err(rtd->dev, "Speaker map addition failed: %d\n", ret);
+	return ret;
+}
+EXPORT_SYMBOL_NS(max_98390_spk_codec_init, SND_SOC_INTEL_SOF_MAXIM_COMMON);
+
+void max_98390_set_codec_conf(struct snd_soc_card *card)
+{
+	card->codec_conf = max_98390_codec_conf;
+	card->num_configs = ARRAY_SIZE(max_98390_codec_conf);
+}
+EXPORT_SYMBOL_NS(max_98390_set_codec_conf, SND_SOC_INTEL_SOF_MAXIM_COMMON);
+
 /*
  * Maxim MAX98357A
  */
diff --git a/sound/soc/intel/boards/sof_maxim_common.h b/sound/soc/intel/boards/sof_maxim_common.h
index 2674f1e373ef..e1ad25dfb915 100644
--- a/sound/soc/intel/boards/sof_maxim_common.h
+++ b/sound/soc/intel/boards/sof_maxim_common.h
@@ -24,6 +24,21 @@ int max_98373_spk_codec_init(struct snd_soc_pcm_runtime *rtd);
 void max_98373_set_codec_conf(struct snd_soc_card *card);
 int max_98373_trigger(struct snd_pcm_substream *substream, int cmd);
 
+/*
+ * Maxim MAX98390
+ */
+#define MAX_98390_CODEC_DAI	"max98390-aif1"
+#define MAX_98390_DEV0_NAME	"i2c-MX98390:00"
+#define MAX_98390_DEV1_NAME	"i2c-MX98390:01"
+
+extern struct snd_soc_dai_link_component max_98390_components[2];
+extern struct snd_soc_ops max_98390_ops;
+extern const struct snd_soc_dapm_route max_98390_dapm_routes[];
+
+int max_98390_spk_codec_init(struct snd_soc_pcm_runtime *rtd);
+void max_98390_set_codec_conf(struct snd_soc_card *card);
+int max_98390_trigger(struct snd_pcm_substream *substream, int cmd);
+
 /*
  * Maxim MAX98357A
  */
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 39217223d50c..ea4b8056db62 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -49,6 +49,7 @@
 #define SOF_RT1015P_SPEAKER_AMP_PRESENT		BIT(16)
 #define SOF_MAX98373_SPEAKER_AMP_PRESENT	BIT(17)
 #define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(18)
+#define SOF_MAX98390_SPEAKER_AMP_PRESENT	BIT(23)
 
 /* BT audio offload: reserve 3 bits for future */
 #define SOF_BT_OFFLOAD_SSP_SHIFT		19
@@ -162,6 +163,19 @@ static const struct dmi_system_id sof_rt5682_quirk_table[] = {
 					SOF_RT5682_SSP_AMP(2) |
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
+	{
+		.callback = sof_rt5682_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
+			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98390_ALC5682I_I2S"),
+		},
+		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_MAX98390_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(2) |
+					SOF_RT5682_NUM_HDMIDEV(4)),
+	},
 	{}
 };
 
@@ -445,6 +459,14 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 		if (err < 0)
 			return err;
 	}
+	if (sof_rt5682_quirk & SOF_MAX98390_SPEAKER_AMP_PRESENT) {
+		/* Disable Left and Right Spk pin after boot */
+		snd_soc_dapm_disable_pin(dapm, "Left Spk");
+		snd_soc_dapm_disable_pin(dapm, "Right Spk");
+		err = snd_soc_dapm_sync(dapm);
+		if (err < 0)
+			return err;
+	}
 	return hdac_hdmi_jack_port_init(component, &card->dapm);
 }
 
@@ -781,6 +803,13 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 		} else if (sof_rt5682_quirk &
 				SOF_RT1011_SPEAKER_AMP_PRESENT) {
 			sof_rt1011_dai_link(&links[id]);
+		} else if (sof_rt5682_quirk &
+				SOF_MAX98390_SPEAKER_AMP_PRESENT) {
+			links[id].codecs = max_98390_components;
+			links[id].num_codecs = ARRAY_SIZE(max_98390_components);
+			links[id].init = max_98390_spk_codec_init;
+			links[id].ops = &max_98390_ops;
+			links[id].dpcm_capture = 1;
 		} else {
 			max_98357a_dai_link(&links[id]);
 		}
@@ -917,7 +946,8 @@ static int sof_audio_probe(struct platform_device *pdev)
 		sof_rt1011_codec_conf(&sof_audio_card_rt5682);
 	else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT)
 		sof_rt1015p_codec_conf(&sof_audio_card_rt5682);
-
+	else if (sof_rt5682_quirk & SOF_MAX98390_SPEAKER_AMP_PRESENT)
+		max_98390_set_codec_conf(&sof_audio_card_rt5682);
 	if (sof_rt5682_quirk & SOF_SSP_BT_OFFLOAD_PRESENT)
 		sof_audio_card_rt5682.num_links++;
 
@@ -1043,6 +1073,17 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(2) |
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
+	{
+		.name = "adl_max98390_rt5682",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_MAX98390_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(2) |
+					SOF_RT5682_NUM_HDMIDEV(4) |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index a0f6a69c7038..2db152998e4a 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -280,6 +280,11 @@ static const struct snd_soc_acpi_codecs adl_max98357a_amp = {
 	.codecs = {"MX98357A"}
 };
 
+static const struct snd_soc_acpi_codecs adl_max98390_amp = {
+	.num_codecs = 1,
+	.codecs = {"MX98390"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	{
 		.id = "10EC5682",
@@ -297,6 +302,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.sof_fw_filename = "sof-adl.ri",
 		.sof_tplg_filename = "sof-adl-max98357a-rt5682.tplg",
 	},
+	{
+		.id = "10EC5682",
+		.drv_name = "adl_max98390_rt5682",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &adl_max98390_amp,
+		.sof_fw_filename = "sof-adl.ri",
+		.sof_tplg_filename = "sof-adl-max98390-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_adl_machines);
-- 
2.17.1

