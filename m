Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394123F156A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhHSIoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:44:05 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38366 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232467AbhHSInu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:43:50 -0400
X-UUID: 54b9677d98e5400bbab0745f15d8145a-20210819
X-UUID: 54b9677d98e5400bbab0745f15d8145a-20210819
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 259116260; Thu, 19 Aug 2021 16:43:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Aug 2021 16:43:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Aug 2021 16:43:09 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <bicycle.tsai@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <cychiang@google.com>, <aaronyu@google.com>, <wenst@chromium.org>
Subject: [PATCH v5 09/11] ASoC: mediatek: mt8195: add DPTX audio support
Date:   Thu, 19 Aug 2021 16:41:42 +0800
Message-ID: <20210819084144.18483-10-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210819084144.18483-1-trevor.wu@mediatek.com>
References: <20210819084144.18483-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DPTX audio support on mt8195-mt6359-rt1019-rt5682 board.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/Kconfig                    |  1 +
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 88 +++++++++++++++++--
 2 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index bfee954d0c7c..cf567a89f421 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -202,6 +202,7 @@ config SND_SOC_MT8195_MT6359_RT1019_RT5682
 	select SND_SOC_RT1015P
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_DMIC
+	select SND_SOC_HDMI_CODEC
 	help
 	  This adds ASoC driver for Mediatek MT8195 boards
 	  with the MT6359 RT1019 RT5682 audio codec.
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index 39b33aecc1e9..d853bc445753 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -27,6 +27,7 @@
 
 struct mt8195_mt6359_rt1019_rt5682_priv {
 	struct snd_soc_jack headset_jack;
+	struct snd_soc_jack dp_jack;
 };
 
 static const struct snd_soc_dapm_widget
@@ -327,6 +328,52 @@ static int mt8195_etdm_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
+static int mt8195_hdmitx_dptx_startup(struct snd_pcm_substream *substream)
+{
+	static const unsigned int rates[] = {
+		48000
+	};
+	static const unsigned int channels[] = {
+		2, 4, 6, 8
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list  = rates,
+		.mask = 0,
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_channels = {
+		.count = ARRAY_SIZE(channels),
+		.list  = channels,
+		.mask = 0,
+	};
+
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_RATE,
+					 &constraints_rates);
+	if (ret < 0) {
+		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
+		return ret;
+	}
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_CHANNELS,
+					 &constraints_channels);
+	if (ret < 0) {
+		dev_err(rtd->dev, "hw_constraint_list channel failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_ops mt8195_hdmitx_dptx_playback_ops = {
+	.startup = mt8195_hdmitx_dptx_startup,
+};
+
 static int mt8195_dptx_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
 {
@@ -344,8 +391,25 @@ static struct snd_soc_ops mt8195_dptx_ops = {
 	.hw_params = mt8195_dptx_hw_params,
 };
 
-static int mt8195_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-				       struct snd_pcm_hw_params *params)
+static int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
+		snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+	int ret = 0;
+
+	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT,
+				    &priv->dp_jack, NULL, 0);
+	if (ret)
+		return ret;
+
+	return snd_soc_component_set_jack(cmpnt_codec, &priv->dp_jack, NULL);
+}
+
+static int mt8195_hdmitx_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+					      struct snd_pcm_hw_params *params)
+
 {
 	/* fix BE i2s format to 32bit, clean param mask first */
 	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
@@ -687,6 +751,7 @@ static struct snd_soc_dai_link mt8195_mt6359_rt1019_rt5682_dai_links[] = {
 		},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		.ops = &mt8195_hdmitx_dptx_playback_ops,
 		SND_SOC_DAILINK_REG(DL10_FE),
 	},
 	[DAI_LINK_DL11_FE] = {
@@ -820,7 +885,7 @@ static struct snd_soc_dai_link mt8195_mt6359_rt1019_rt5682_dai_links[] = {
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.ops = &mt8195_dptx_ops,
-		.be_hw_params_fixup = mt8195_dptx_hw_params_fixup,
+		.be_hw_params_fixup = mt8195_hdmitx_dptx_hw_params_fixup,
 		SND_SOC_DAILINK_REG(DPTX_BE),
 	},
 	[DAI_LINK_ETDM1_IN_BE] = {
@@ -915,7 +980,6 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 	struct device_node *platform_node;
 	struct snd_soc_dai_link *dai_link;
 	struct mt8195_mt6359_rt1019_rt5682_priv *priv = NULL;
-
 	int ret, i;
 
 	card->dev = &pdev->dev;
@@ -930,6 +994,20 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 	for_each_card_prelinks(card, i, dai_link) {
 		if (!dai_link->platforms->name)
 			dai_link->platforms->of_node = platform_node;
+
+		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
+			dai_link->codecs->of_node =
+				of_parse_phandle(pdev->dev.of_node,
+						 "mediatek,dptx-codec", 0);
+			if (!dai_link->codecs->of_node) {
+				dev_err(&pdev->dev, "Property 'dptx-codec' missing or invalid\n");
+				return -EINVAL;
+			}
+
+			dai_link->codecs->name = NULL;
+			dai_link->codecs->dai_name = "i2s-hifi";
+			dai_link->init = mt8195_dptx_codec_init;
+		}
 	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -940,7 +1018,7 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
-		dev_dbg(&pdev->dev, "%s snd_soc_register_card fail %d\n",
+		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
 	return ret;
 }
-- 
2.18.0

