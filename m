Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7AC3F5EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhHXNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhHXNWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:22:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6567C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 06:21:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y23so19741952pgi.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=MUvv2mp0uTHfXISXAC47FViwGrFbVVgYK+natZk5Dzc=;
        b=cgcCu5mZTNZFytmDj/6Lcegslsy0Jo+cEI0bHg2MO1XAYemLvBPlBMXUf0EMFsHcjE
         86URDK0/IKK/TFWZfzfn2CMZ5MSRwXuMW1KhlgmcEJgM+x7GoMTqZlrlHFX8fN3StLCS
         n43CASSoz472WnzwVfucXhDM+09e57mGkpny1xnpzPCppJVuB2Kc72nHTAd706uvV7h3
         h1zNlPaIDC87A9t0RevN+r5RW0hqxUbshW/hzLEQNNEZPGcJ3mnJYyGgriHSo98RFfbS
         5X/6ZtfrAu0uPpPFxUDMSelCwKjrTs3Jo81v05V9GG8QLgljLfmSl7MMdUYs8/S6z60u
         Cj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MUvv2mp0uTHfXISXAC47FViwGrFbVVgYK+natZk5Dzc=;
        b=Hl/kQu1KLLw/tjezIkrPuQ90jCskA749q8iEXoDSQWESvJRFtLfQEXDx77SoyKwKsP
         tns3DMKNn6uVoX6Bg740B7uBEg2wbyi/gj+iIeYkSPBBzlD6DLk52o8RlT46d6l3OebV
         3yV045B1VgpvP7QIlSzVG0ZL2o9OkySSqspmb1DAOTUe0m/3eoR6f+ZvhwD2p9fvQzbF
         9vJMOLglU4eE7G/mSKAFCTfalfftW3bvkWAwSFTiUDqtP7szMKn6HV19Ithm2sF0IqxQ
         hzk+6FVZqAfq83ipawHJrRxsJ1EBaxzL7TqU0JrBJB4dNznqCCA8BolS7OpimbcP5w4b
         yB+A==
X-Gm-Message-State: AOAM5332u5ScA93qbLbxApxx4gNmdkCOcEhq7zVKLSj7Dcz4tY7zGAuq
        UH3VjAjvc7loF1t3bvP1tZU5gwRaW8/llQ==
X-Google-Smtp-Source: ABdhPJz7YYIQVI+BsSWcMUk+3EXWizH8puqwfXCUNlP2edqj4Dc3Ykw+KlgPP8nYe0nLVjCD2BV4kw==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr36763054pgb.127.1629811277175;
        Tue, 24 Aug 2021 06:21:17 -0700 (PDT)
Received: from localhost.localdomain (60-251-182-145.HINET-IP.hinet.net. [60.251.182.145])
        by smtp.gmail.com with ESMTPSA id a25sm2664010pfo.200.2021.08.24.06.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 06:21:16 -0700 (PDT)
From:   Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
To:     alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, mac.chiang@intel.com,
        lance.hou@intel.com, broonie@kernel.org, brent.lu@intel.com,
        bard.liao@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, mark_hsieh@wistron.com,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Subject: [PATCH] [v2] ASoC: Intel: sof_rt5682: Add support for max98390 speaker amp
Date:   Tue, 24 Aug 2021 21:21:09 +0800
Message-Id: <20210824132109.1392-1-mark_hsieh@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure adl_max98390_rt5682 to support the rt5682 headset codec and max98390 speaker

BUG=b:191811888
TEST=emerge-brya chromeos-kernel-5_10

Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
---
 sound/soc/intel/boards/Kconfig                |  1 +
 sound/soc/intel/boards/sof_maxim_common.c     | 59 +++++++++++++++++++
 sound/soc/intel/boards/sof_maxim_common.h     | 12 ++++
 sound/soc/intel/boards/sof_rt5682.c           | 20 ++++++-
 .../intel/common/soc-acpi-intel-adl-match.c   | 13 ++++
 5 files changed, 104 insertions(+), 1 deletion(-)

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
index e9c52f8b6428..477883d571ab 100644
--- a/sound/soc/intel/boards/sof_maxim_common.c
+++ b/sound/soc/intel/boards/sof_maxim_common.c
@@ -133,6 +133,65 @@ void max_98373_set_codec_conf(struct snd_soc_card *card)
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
+	int j;
+
+	for_each_rtd_codec_dais(rtd, j, codec_dai) {
+		if (!strcmp(codec_dai->component->name, MAX_98390_DEV0_NAME)) {
+			/* DEV0 tdm slot configuration */
+			snd_soc_dai_set_tdm_slot(codec_dai, 0x03, 3, 2, 16);
+		}
+		if (!strcmp(codec_dai->component->name, MAX_98390_DEV1_NAME)) {
+			/* DEV1 tdm slot configuration */
+			snd_soc_dai_set_tdm_slot(codec_dai, 0x0C, 3, 2, 16);
+		}
+	}
+	return 0;
+}
+
+struct snd_soc_ops max_98390_ops = {
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
index 2674f1e373ef..2458758866f3 100644
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
+extern struct snd_soc_ops max_98390_ops;
+
+void max_98390_set_codec_conf(struct snd_soc_card *card);
+
 /*
  * Maxim MAX98357A
  */
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 39217223d50c..dc4966056b7d 100644
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
@@ -917,7 +925,8 @@ static int sof_audio_probe(struct platform_device *pdev)
 		sof_rt1011_codec_conf(&sof_audio_card_rt5682);
 	else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT)
 		sof_rt1015p_codec_conf(&sof_audio_card_rt5682);
-
+	else if (sof_rt5682_quirk & SOF_MAX98390_SPEAKER_AMP_PRESENT)
+		max_98390_set_codec_conf(&sof_audio_card_rt5682);
 	if (sof_rt5682_quirk & SOF_SSP_BT_OFFLOAD_PRESENT)
 		sof_audio_card_rt5682.num_links++;
 
@@ -1043,6 +1052,15 @@ static const struct platform_device_id board_ids[] = {
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

