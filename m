Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BE641E62B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 05:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351637AbhJADSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 23:18:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56258 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230283AbhJADSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 23:18:01 -0400
X-UUID: 9b0fd0e100fd4f95841f71e2c3d4db1a-20211001
X-UUID: 9b0fd0e100fd4f95841f71e2c3d4db1a-20211001
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2106213625; Fri, 01 Oct 2021 11:16:14 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 1 Oct 2021 11:16:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 1 Oct
 2021 11:16:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Oct 2021 11:16:06 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bicycle.tsai@mediatek.com>
Subject: [PATCH] ASoC: mediatek: mt8195: move of_node_put to remove function
Date:   Fri, 1 Oct 2021 11:16:01 +0800
Message-ID: <20211001031601.3953-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platforms->of_node and codes->of_node are assigned in probe function,
and of_node_put is called at the end of probe function, because of_node
seems to be not used after probe functon

In this patch, of_node_put is moved to platform remove function in case
of_node is used at any occasions after probe function in the future.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 69 +++++++++++--------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index cb15467e5fc5..95abaadcd842 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -26,6 +26,9 @@
 #define RT5682_DEV0_NAME	"rt5682.2-001a"
 
 struct mt8195_mt6359_rt1019_rt5682_priv {
+	struct device_node *platform_node;
+	struct device_node *hdmi_node;
+	struct device_node *dp_node;
 	struct snd_soc_jack headset_jack;
 	struct snd_soc_jack dp_jack;
 	struct snd_soc_jack hdmi_jack;
@@ -994,33 +997,36 @@ static struct snd_soc_card mt8195_mt6359_rt1019_rt5682_soc_card = {
 static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8195_mt6359_rt1019_rt5682_soc_card;
-	struct device_node *platform_node;
-	struct device_node *dp_node;
-	struct device_node *hdmi_node;
 	struct snd_soc_dai_link *dai_link;
-	struct mt8195_mt6359_rt1019_rt5682_priv *priv = NULL;
+	struct mt8195_mt6359_rt1019_rt5682_priv *priv;
 	int ret, i;
 
 	card->dev = &pdev->dev;
 
-	platform_node = of_parse_phandle(pdev->dev.of_node,
-					 "mediatek,platform", 0);
-	if (!platform_node) {
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->platform_node = of_parse_phandle(pdev->dev.of_node,
+					       "mediatek,platform", 0);
+	if (!priv->platform_node) {
 		dev_dbg(&pdev->dev, "Property 'platform' missing or invalid\n");
 		return -EINVAL;
 	}
 
 	for_each_card_prelinks(card, i, dai_link) {
 		if (!dai_link->platforms->name)
-			dai_link->platforms->of_node = platform_node;
+			dai_link->platforms->of_node = priv->platform_node;
 
 		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
-			dp_node = of_parse_phandle(pdev->dev.of_node,
-						   "mediatek,dptx-codec", 0);
-			if (!dp_node) {
+			priv->dp_node =
+				of_parse_phandle(pdev->dev.of_node,
+						 "mediatek,dptx-codec", 0);
+
+			if (!priv->dp_node) {
 				dev_dbg(&pdev->dev, "No property 'dptx-codec'\n");
 			} else {
-				dai_link->codecs->of_node = dp_node;
+				dai_link->codecs->of_node = priv->dp_node;
 				dai_link->codecs->name = NULL;
 				dai_link->codecs->dai_name = "i2s-hifi";
 				dai_link->init = mt8195_dptx_codec_init;
@@ -1028,12 +1034,13 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 		}
 
 		if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
-			hdmi_node = of_parse_phandle(pdev->dev.of_node,
-						     "mediatek,hdmi-codec", 0);
-			if (!hdmi_node) {
+			priv->hdmi_node =
+				of_parse_phandle(pdev->dev.of_node,
+						 "mediatek,hdmi-codec", 0);
+			if (!priv->hdmi_node) {
 				dev_dbg(&pdev->dev, "No property 'hdmi-codec'\n");
 			} else {
-				dai_link->codecs->of_node = hdmi_node;
+				dai_link->codecs->of_node = priv->hdmi_node;
 				dai_link->codecs->name = NULL;
 				dai_link->codecs->dai_name = "i2s-hifi";
 				dai_link->init = mt8195_hdmi_codec_init;
@@ -1041,26 +1048,33 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 		}
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
+		of_node_put(priv->hdmi_node);
+		of_node_put(priv->dp_node);
+		of_node_put(priv->platform_node);
+	}
 
-out:
-	of_node_put(hdmi_node);
-	of_node_put(dp_node);
-	of_node_put(platform_node);
 	return ret;
 }
 
+static int mt8195_mt6359_rt1019_rt5682_dev_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
+		snd_soc_card_get_drvdata(card);
+
+	of_node_put(priv->hdmi_node);
+	of_node_put(priv->dp_node);
+	of_node_put(priv->platform_node);
+
+	return 0;
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id mt8195_mt6359_rt1019_rt5682_dt_match[] = {
 	{.compatible = "mediatek,mt8195_mt6359_rt1019_rt5682",},
@@ -1082,6 +1096,7 @@ static struct platform_driver mt8195_mt6359_rt1019_rt5682_driver = {
 		.pm = &mt8195_mt6359_rt1019_rt5682_pm_ops,
 	},
 	.probe = mt8195_mt6359_rt1019_rt5682_dev_probe,
+	.remove = mt8195_mt6359_rt1019_rt5682_dev_remove,
 };
 
 module_platform_driver(mt8195_mt6359_rt1019_rt5682_driver);
-- 
2.18.0

