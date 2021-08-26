Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F163C3F8559
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbhHZKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241180AbhHZKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:31:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312ACC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:30:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so6276411pjw.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=R46KQaoRhoySr/QCZoVFBB2v3/jLI+gAMe2pWhrPiSU=;
        b=cuCWlSZB6CvjkcDVMpaAweDhB5A7DagH6QNyd3O7k5PiCS2t7qVowfDgGm6OLmDB5E
         +MTM4b3MA88D3lOSWzp3LokoEV7GiI8u/nuZazUYQZVHrfOSJVMQjZupuc9XL/1onI3k
         +zGQP1p4K5M31sn7Y+7NF/McVcdrpctPaa06hGNop0tBpk2u17mAf4BneIVvAm8vDA4r
         2ghtxQAk04VDBmclmPBUDETDyXd6BaJeDvf6yTKoFGe36o5El9MzSGLAh7dITuysWH7r
         j4kxwiZVHgelDsUlpzaPoVI2bOVReFz6eGT44C79c7jmEJx1XP7UYlWcOaH6E1gKYxXQ
         6yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R46KQaoRhoySr/QCZoVFBB2v3/jLI+gAMe2pWhrPiSU=;
        b=pQmEJxVKW4qcRH6McGaw7eyS0psdVmaYH2l5wNpOgV5kfBK2kU8mC59Lo26VmNVbHz
         AYARJuQh96bKKQJy8GUEPZk2fNFn5ZFsBZpzLz2PnPzOniiWL8HtIZuJ3I8htlMnAgb4
         UJz5yhgzcPSS1DIIjeBCQo37VAuY9qEXKEtuYZzRRqMWsNKgM+vQmXN5WGz5HHEwEBwR
         hEKgbDffxurwxiCVXt4gkjwHrp+Esjh8D7ymvEtIPzJ24MxkiPdyD3GJ6aShB/dOi+y1
         jaiHv3fD2RuOfgcVO3p2ZrL4UqUTUJL/ueNFB5VwKQqqXK2oap4UCy0Xf5X2skNKqjNK
         9b2Q==
X-Gm-Message-State: AOAM531+Gau29AvIODajYOH3jBTK8hC4OguKPjn0IU5lNuhD2ybmGMAG
        H0gqSmXuvaryXal/GkzhkaNvKw==
X-Google-Smtp-Source: ABdhPJzejGt/VwnBsE6JC2pLXmkgr6xhsI51Cwzy0M7Q9vko++e8QiLXGqW/wUvWypwKwINJ6xe3pA==
X-Received: by 2002:a17:90a:940d:: with SMTP id r13mr16396951pjo.124.1629973839710;
        Thu, 26 Aug 2021 03:30:39 -0700 (PDT)
Received: from localhost.localdomain (61-220-206-157.HINET-IP.hinet.net. [61.220.206.157])
        by smtp.gmail.com with ESMTPSA id u17sm2516360pfh.184.2021.08.26.03.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 03:30:39 -0700 (PDT)
From:   Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
To:     alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, mac.chiang@intel.com,
        lance.hou@intel.com, broonie@kernel.org, brent.lu@intel.com,
        bard.liao@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, mark_hsieh@wistron.com,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Subject: [PATCH] [v3] ASoC: Intel: sof_rt5682: Add support for max98390 speaker amp
Date:   Thu, 26 Aug 2021 18:30:32 +0800
Message-Id: <20210826103032.22262-1-mark_hsieh@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure adl_max98390_rt5682 to support the rt5682 headset codec
and max98390 speaker.

Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
---
 sound/soc/intel/boards/Kconfig                |  1 +
 sound/soc/intel/boards/sof_maxim_common.c     | 57 +++++++++++++++++++
 sound/soc/intel/boards/sof_maxim_common.h     | 12 ++++
 sound/soc/intel/boards/sof_rt5682.c           | 19 +++++++
 .../intel/common/soc-acpi-intel-adl-match.c   | 13 +++++
 5 files changed, 102 insertions(+)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 7e29b0d911e2..0017c08c5a62 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -470,6 +470,7 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
 	select SND_SOC_RT1015
 	select SND_SOC_RT1015P
 	select SND_SOC_RT5682_I2C
+	select SND_SOC_MAX98390
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
 	select SND_SOC_INTEL_HDA_DSP_COMMON
diff --git a/sound/soc/intel/boards/sof_maxim_common.c b/sound/soc/intel/boards/sof_maxim_common.c
index e9c52f8b6428..a6fcf6e08996 100644
--- a/sound/soc/intel/boards/sof_maxim_common.c
+++ b/sound/soc/intel/boards/sof_maxim_common.c
@@ -133,6 +133,63 @@ void max_98373_set_codec_conf(struct snd_soc_card *card)
 }
 EXPORT_SYMBOL_NS(max_98373_set_codec_conf, SND_SOC_INTEL_SOF_MAXIM_COMMON);
 
+/*
+ * Maxim MAX98390
+ */
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
+		.name = MAX_98390_DEV0_NAME,
+		.dai_name = MAX_98390_CODEC_DAI,
+	},
+	{  /* For Left */
+		.name = MAX_98390_DEV1_NAME,
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
+	int i;
+
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		/* DEV0 tdm slot configuration */
+		if (!strcmp(codec_dai->component->name, MAX_98390_DEV0_NAME))
+			snd_soc_dai_set_tdm_slot(codec_dai, 0x03, 3, 2, 16);
+		/* DEV1 tdm slot configuration */
+		if (!strcmp(codec_dai->component->name, MAX_98390_DEV1_NAME))
+			snd_soc_dai_set_tdm_slot(codec_dai, 0x0C, 3, 2, 16);
+	}
+	return 0;
+}
+
+const struct snd_soc_ops max_98390_ops = {
+	.hw_params = max_98390_hw_params,
+};
+EXPORT_SYMBOL_NS(max_98390_ops, SND_SOC_INTEL_SOF_MAXIM_COMMON);
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
index 2674f1e373ef..bad7b5303280 100644
--- a/sound/soc/intel/boards/sof_maxim_common.h
+++ b/sound/soc/intel/boards/sof_maxim_common.h
@@ -24,6 +24,18 @@ int max_98373_spk_codec_init(struct snd_soc_pcm_runtime *rtd);
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
+extern const struct snd_soc_ops max_98390_ops;
+
+void max_98390_set_codec_conf(struct snd_soc_card *card);
+
 /*
  * Maxim MAX98357A
  */
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 39217223d50c..18b6ef311462 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -49,6 +49,7 @@
 #define SOF_RT1015P_SPEAKER_AMP_PRESENT		BIT(16)
 #define SOF_MAX98373_SPEAKER_AMP_PRESENT	BIT(17)
 #define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(18)
+#define SOF_MAX98390_SPEAKER_AMP_PRESENT	BIT(23)
 
 /* BT audio offload: reserve 3 bits for future */
 #define SOF_BT_OFFLOAD_SSP_SHIFT		19
@@ -781,6 +782,13 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 		} else if (sof_rt5682_quirk &
 				SOF_RT1011_SPEAKER_AMP_PRESENT) {
 			sof_rt1011_dai_link(&links[id]);
+		} else if (sof_rt5682_quirk &
+				SOF_MAX98390_SPEAKER_AMP_PRESENT) {
+			links[id].codecs = max_98390_components;
+			links[id].num_codecs = ARRAY_SIZE(max_98390_components);
+			links[id].init = max_98373_spk_codec_init;
+			links[id].ops = &max_98390_ops;
+			links[id].dpcm_capture = 1;
 		} else {
 			max_98357a_dai_link(&links[id]);
 		}
@@ -917,6 +925,8 @@ static int sof_audio_probe(struct platform_device *pdev)
 		sof_rt1011_codec_conf(&sof_audio_card_rt5682);
 	else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT)
 		sof_rt1015p_codec_conf(&sof_audio_card_rt5682);
+	else if (sof_rt5682_quirk & SOF_MAX98390_SPEAKER_AMP_PRESENT)
+		max_98390_set_codec_conf(&sof_audio_card_rt5682);
 
 	if (sof_rt5682_quirk & SOF_SSP_BT_OFFLOAD_PRESENT)
 		sof_audio_card_rt5682.num_links++;
@@ -1043,6 +1053,15 @@ static const struct platform_device_id board_ids[] = {
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
+					SOF_RT5682_NUM_HDMIDEV(4)),
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

