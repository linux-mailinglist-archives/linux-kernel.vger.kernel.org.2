Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1583FFA15
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbhICGCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:02:03 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:36574 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236348AbhICGCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:02:00 -0400
X-UUID: 45ec8858fcea4a23a0db6e31cc49a40a-20210903
X-UUID: 45ec8858fcea4a23a0db6e31cc49a40a-20210903
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1630697288; Fri, 03 Sep 2021 14:00:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 14:00:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Sep 2021 14:00:50 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: mt8195: correct the dts parsing logic about DPTX and HDMITX
Date:   Fri, 3 Sep 2021 14:00:49 +0800
Message-ID: <20210903060049.20764-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the description in dt-bindings, phandle assignment of
HDMI TX and DP TX are not required properties, but driver regards them
as required properties.
In real use case, it's expected that DP TX and HDMI TX are optional
features, so correct the behavior in driver.

Fixes: 40d605df0a7b ("ASoC: mediatek: mt8195: add machine driver with mt6359, rt1019 and rt5682")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index 5dc217f59bd6..c97ace7387b4 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -1018,13 +1018,12 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 				of_parse_phandle(pdev->dev.of_node,
 						 "mediatek,dptx-codec", 0);
 			if (!dai_link->codecs->of_node) {
-				dev_err(&pdev->dev, "Property 'dptx-codec' missing or invalid\n");
-				return -EINVAL;
+				dev_dbg(&pdev->dev, "No property 'dptx-codec'\n");
+			} else {
+				dai_link->codecs->name = NULL;
+				dai_link->codecs->dai_name = "i2s-hifi";
+				dai_link->init = mt8195_dptx_codec_init;
 			}
-
-			dai_link->codecs->name = NULL;
-			dai_link->codecs->dai_name = "i2s-hifi";
-			dai_link->init = mt8195_dptx_codec_init;
 		}
 
 		if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
@@ -1032,13 +1031,12 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 				of_parse_phandle(pdev->dev.of_node,
 						 "mediatek,hdmi-codec", 0);
 			if (!dai_link->codecs->of_node) {
-				dev_err(&pdev->dev, "Property 'hdmi-codec' missing or invalid\n");
-				return -EINVAL;
+				dev_dbg(&pdev->dev, "No property 'hdmi-codec'\n");
+			} else {
+				dai_link->codecs->name = NULL;
+				dai_link->codecs->dai_name = "i2s-hifi";
+				dai_link->init = mt8195_hdmi_codec_init;
 			}
-
-			dai_link->codecs->name = NULL;
-			dai_link->codecs->dai_name = "i2s-hifi";
-			dai_link->init = mt8195_hdmi_codec_init;
 		}
 	}
 
-- 
2.18.0

