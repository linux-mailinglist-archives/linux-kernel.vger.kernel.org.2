Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B901543599F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 05:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhJUEBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 00:01:12 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:36112 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229452AbhJUEBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 00:01:09 -0400
X-UUID: 17635c8a5dea4b709101c8e7c4bf3356-20211021
X-UUID: 17635c8a5dea4b709101c8e7c4bf3356-20211021
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 841908625; Thu, 21 Oct 2021 11:58:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Oct 2021 11:58:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Oct 2021 11:58:47 +0800
From:   YC Hung <yc.hung@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <yc.hung@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <daniel.baluta@nxp.com>, <trevor.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 1/2] ASoC: SOF: mediatek: Add mt8195 dsp clock support
Date:   Thu, 21 Oct 2021 11:58:40 +0800
Message-ID: <20211021035841.2365-2-yc.hung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211021035841.2365-1-yc.hung@mediatek.com>
References: <20211021035841.2365-1-yc.hung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add adsp clock on/off support on mt8195 platform.

Signed-off-by: YC Hung <yc.hung@mediatek.com>
---
 sound/soc/sof/mediatek/mt8195/Makefile     |   2 +-
 sound/soc/sof/mediatek/mt8195/mt8195-clk.c | 164 +++++++++++++++++++++
 sound/soc/sof/mediatek/mt8195/mt8195-clk.h |  29 ++++
 sound/soc/sof/mediatek/mt8195/mt8195.c     |  23 ++-
 4 files changed, 215 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.c
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.h

diff --git a/sound/soc/sof/mediatek/mt8195/Makefile b/sound/soc/sof/mediatek/mt8195/Makefile
index 60fca24c068a..650f4bce99b2 100644
--- a/sound/soc/sof/mediatek/mt8195/Makefile
+++ b/sound/soc/sof/mediatek/mt8195/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
-snd-sof-mt8195-objs := mt8195.o mt8195-loader.o
+snd-sof-mt8195-objs := mt8195.o mt8195-clk.o mt8195-loader.o
 obj-$(CONFIG_SND_SOC_SOF_MT8195) += snd-sof-mt8195.o
 
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195-clk.c b/sound/soc/sof/mediatek/mt8195/mt8195-clk.c
new file mode 100644
index 000000000000..1988421f7f7b
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8195/mt8195-clk.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// Copyright(c) 2021 Mediatek Corporation. All rights reserved.
+//
+// Author: YC Hung <yc.hung@mediatek.com>
+//
+// Hardware interface for mt8195 DSP clock
+
+#include <linux/clk.h>
+#include <linux/pm_runtime.h>
+#include <linux/io.h>
+#include "mt8195.h"
+#include "mt8195-clk.h"
+
+struct clk *clk_handle[ADSP_CLK_NUM];
+
+int platform_parse_clock(struct device *dev)
+{
+	clk_handle[CLK_TOP_ADSP] = devm_clk_get(dev, "adsp_sel");
+	if (IS_ERR(clk_handle[CLK_TOP_ADSP])) {
+		dev_err(dev, "clk_get(\"adsp_sel\") failed\n");
+		return PTR_ERR(clk_handle[CLK_TOP_ADSP]);
+	}
+
+	clk_handle[CLK_TOP_CLK26M] = devm_clk_get(dev, "clk26m_ck");
+	if (IS_ERR(clk_handle[CLK_TOP_CLK26M])) {
+		dev_err(dev, "clk_get(\"clk26m_ck\") failed\n");
+		return PTR_ERR(clk_handle[CLK_TOP_CLK26M]);
+	}
+
+	clk_handle[CLK_TOP_AUDIO_LOCAL_BUS] = devm_clk_get(dev, "audio_local_bus");
+	if (IS_ERR(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS])) {
+		dev_err(dev, "clk_get(\"audio_local_bus\") failed\n");
+		return PTR_ERR(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS]);
+	}
+
+	clk_handle[CLK_TOP_MAINPLL_D7_D2] = devm_clk_get(dev, "mainpll_d7_d2");
+	if (IS_ERR(clk_handle[CLK_TOP_MAINPLL_D7_D2])) {
+		dev_err(dev, "clk_get(\"mainpll_d7_d2\") failed\n");
+		return PTR_ERR(clk_handle[CLK_TOP_MAINPLL_D7_D2]);
+	}
+
+	clk_handle[CLK_SCP_ADSP_AUDIODSP] = devm_clk_get(dev, "scp_adsp_audiodsp");
+	if (IS_ERR(clk_handle[CLK_SCP_ADSP_AUDIODSP])) {
+		dev_err(dev, "clk_get(\"scp_adsp_audiodsp\") failed\n");
+		return PTR_ERR(clk_handle[CLK_SCP_ADSP_AUDIODSP]);
+	}
+
+	clk_handle[CLK_TOP_AUDIO_H] = devm_clk_get(dev, "audio_h");
+	if (IS_ERR(clk_handle[CLK_TOP_AUDIO_H])) {
+		dev_err(dev, "clk_get(\"audio_h_sel\") failed\n");
+		return PTR_ERR(clk_handle[CLK_TOP_AUDIO_H]);
+	}
+
+	return 0;
+}
+
+int adsp_enable_clock(struct device *dev)
+{
+	int ret;
+
+	ret = clk_prepare_enable(clk_handle[CLK_TOP_MAINPLL_D7_D2]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(mainpll_d7_d2) fail %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(clk_handle[CLK_TOP_ADSP]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(adsp_sel) fail %d\n",
+			__func__, ret);
+		goto disable_mainpll_d7_d2_clk;
+	}
+
+	ret = clk_prepare_enable(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(audio_local_bus) fail %d\n",
+			__func__, ret);
+		goto disable_dsp_sel_clk;
+	}
+
+	ret = clk_prepare_enable(clk_handle[CLK_SCP_ADSP_AUDIODSP]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(scp_adsp_audiodsp) fail %d\n",
+			__func__, ret);
+		goto disable_audio_local_bus_clk;
+	}
+
+	ret = clk_prepare_enable(clk_handle[CLK_TOP_AUDIO_H]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(audio_h) fail %d\n",
+			__func__, ret);
+		goto disable_scp_adsp_audiodsp_clk;
+	}
+
+	return 0;
+
+disable_scp_adsp_audiodsp_clk:
+	clk_disable_unprepare(clk_handle[CLK_SCP_ADSP_AUDIODSP]);
+disable_audio_local_bus_clk:
+	clk_disable_unprepare(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS]);
+disable_dsp_sel_clk:
+	clk_disable_unprepare(clk_handle[CLK_TOP_ADSP]);
+disable_mainpll_d7_d2_clk:
+	clk_disable_unprepare(clk_handle[CLK_TOP_MAINPLL_D7_D2]);
+
+	return ret;
+}
+
+void adsp_disable_clock(struct device *dev)
+{
+	clk_disable_unprepare(clk_handle[CLK_TOP_AUDIO_H]);
+	clk_disable_unprepare(clk_handle[CLK_SCP_ADSP_AUDIODSP]);
+	clk_disable_unprepare(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS]);
+	clk_disable_unprepare(clk_handle[CLK_TOP_ADSP]);
+	clk_disable_unprepare(clk_handle[CLK_TOP_MAINPLL_D7_D2]);
+}
+
+int adsp_default_clk_init(struct device *dev, int enable)
+{
+	int ret = 0;
+
+	dev_dbg(dev, "%s: %s\n", __func__, enable ? "on" : "off");
+
+	if (enable) {
+		ret = clk_set_parent(clk_handle[CLK_TOP_ADSP],
+				     clk_handle[CLK_TOP_CLK26M]);
+		if (ret) {
+			dev_err(dev, "failed to set dsp_sel to clk26m: %d\n", ret);
+			return ret;
+		}
+
+		ret = clk_set_parent(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS],
+				     clk_handle[CLK_TOP_MAINPLL_D7_D2]);
+		if (ret) {
+			dev_err(dev, "set audio_local_bus failed %d\n", ret);
+			return ret;
+		}
+
+		ret = adsp_enable_clock(dev);
+		if (ret)
+			dev_err(dev, "failed to adsp_enable_clock: %d\n", ret);
+
+		return ret;
+	}
+
+	adsp_disable_clock(dev);
+
+	return ret;
+}
+
+int adsp_clock_on(struct device *dev)
+{
+	/* Open ADSP clock */
+	return adsp_default_clk_init(dev, 1);
+}
+
+int adsp_clock_off(struct device *dev)
+{
+	/* Close ADSP clock */
+	return adsp_default_clk_init(dev, 0);
+}
+
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195-clk.h b/sound/soc/sof/mediatek/mt8195/mt8195-clk.h
new file mode 100644
index 000000000000..f985d141552a
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8195/mt8195-clk.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2021 MediaTek Corporation. All rights reserved.
+ *
+ *  Header file for the mt8195 DSP clock  definition
+ */
+
+#ifndef __MT8195_CLK_H
+#define __MT8195_CLK_H
+
+/*DSP clock*/
+enum ADSP_CLK_ID {
+	CLK_TOP_ADSP,
+	CLK_TOP_CLK26M,
+	CLK_TOP_AUDIO_LOCAL_BUS,
+	CLK_TOP_MAINPLL_D7_D2,
+	CLK_SCP_ADSP_AUDIODSP,
+	CLK_TOP_AUDIO_H,
+	ADSP_CLK_NUM
+};
+
+int platform_parse_clock(struct device *dev);
+int adsp_default_clk_init(struct device *dev, int enable);
+int adsp_enable_clock(struct device *dev);
+void adsp_disable_clock(struct device *dev);
+int adsp_clock_on(struct device *dev);
+int adsp_clock_off(struct device *dev);
+#endif
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 99075598a35a..f323da58057b 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -25,6 +25,7 @@
 #include "../adsp_helper.h"
 #include "../mediatek-ops.h"
 #include "mt8195.h"
+#include "mt8195-clk.h"
 
 static int platform_parse_resource(struct platform_device *pdev, void *data)
 {
@@ -231,10 +232,23 @@ static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
 	if (ret)
 		return ret;
 
+	ret = platform_parse_clock(&pdev->dev);
+	if (ret) {
+		dev_err(sdev->dev, "platform_parse_clock failed\n");
+		return -EINVAL;
+	}
+
+	ret = adsp_clock_on(&pdev->dev);
+	if (ret) {
+		dev_err(sdev->dev, "adsp_clock_on fail!\n");
+		return -EINVAL;
+	}
+
 	ret = adsp_sram_power_on(sdev->dev, true);
 	if (ret) {
 		dev_err(sdev->dev, "adsp_sram_power_on fail!\n");
-		return ret;
+		ret = -EINVAL;
+		goto exit_clk_disable;
 	}
 
 	ret = adsp_memory_remap_init(&pdev->dev, priv->adsp);
@@ -282,6 +296,8 @@ static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
 
 err_adsp_sram_power_off:
 	adsp_sram_power_on(&pdev->dev, false);
+exit_clk_disable:
+	adsp_clock_off(&pdev->dev);
 
 	return ret;
 }
@@ -290,7 +306,10 @@ static int mt8195_dsp_remove(struct snd_sof_dev *sdev)
 {
 	struct platform_device *pdev = container_of(sdev->dev, struct platform_device, dev);
 
-	return adsp_sram_power_on(&pdev->dev, false);
+	adsp_sram_power_on(&pdev->dev, false);
+	adsp_clock_off(&pdev->dev);
+
+	return 0;
 }
 
 /* on mt8195 there is 1 to 1 match between type and BAR idx */
-- 
2.18.0

