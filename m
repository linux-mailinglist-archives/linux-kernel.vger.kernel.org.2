Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C620D41A903
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 08:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbhI1GhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 02:37:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35140 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234207AbhI1GhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:37:07 -0400
X-UUID: 3e7385b025ac48c2bcc2c3cc11792b34-20210928
X-UUID: 3e7385b025ac48c2bcc2c3cc11792b34-20210928
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 407077680; Tue, 28 Sep 2021 14:35:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 28 Sep 2021 14:35:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Sep 2021 14:35:21 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <cuibixuan@huawei.com>,
        <bicycle.tsai@mediatek.com>
Subject: [PATCH] ASoC: mediatek: mt8195: add missing of_node_put in probe
Date:   Tue, 28 Sep 2021 14:35:20 +0800
Message-ID: <20210928063520.23927-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dp node and hdmi node are retrieved from of_parse_phandle(), so using
of_node_put() on them before return.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index a3fa8efc8f81..cb15467e5fc5 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -995,6 +995,8 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8195_mt6359_rt1019_rt5682_soc_card;
 	struct device_node *platform_node;
+	struct device_node *dp_node;
+	struct device_node *hdmi_node;
 	struct snd_soc_dai_link *dai_link;
 	struct mt8195_mt6359_rt1019_rt5682_priv *priv = NULL;
 	int ret, i;
@@ -1013,12 +1015,12 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 			dai_link->platforms->of_node = platform_node;
 
 		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
-			dai_link->codecs->of_node =
-				of_parse_phandle(pdev->dev.of_node,
-						 "mediatek,dptx-codec", 0);
-			if (!dai_link->codecs->of_node) {
+			dp_node = of_parse_phandle(pdev->dev.of_node,
+						   "mediatek,dptx-codec", 0);
+			if (!dp_node) {
 				dev_dbg(&pdev->dev, "No property 'dptx-codec'\n");
 			} else {
+				dai_link->codecs->of_node = dp_node;
 				dai_link->codecs->name = NULL;
 				dai_link->codecs->dai_name = "i2s-hifi";
 				dai_link->init = mt8195_dptx_codec_init;
@@ -1026,12 +1028,12 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 		}
 
 		if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
-			dai_link->codecs->of_node =
-				of_parse_phandle(pdev->dev.of_node,
-						 "mediatek,hdmi-codec", 0);
-			if (!dai_link->codecs->of_node) {
+			hdmi_node = of_parse_phandle(pdev->dev.of_node,
+						     "mediatek,hdmi-codec", 0);
+			if (!hdmi_node) {
 				dev_dbg(&pdev->dev, "No property 'hdmi-codec'\n");
 			} else {
+				dai_link->codecs->of_node = hdmi_node;
 				dai_link->codecs->name = NULL;
 				dai_link->codecs->dai_name = "i2s-hifi";
 				dai_link->init = mt8195_hdmi_codec_init;
@@ -1041,8 +1043,8 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
-		of_node_put(platform_node);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	snd_soc_card_set_drvdata(card, priv);
@@ -1052,6 +1054,9 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
 
+out:
+	of_node_put(hdmi_node);
+	of_node_put(dp_node);
 	of_node_put(platform_node);
 	return ret;
 }
-- 
2.18.0

