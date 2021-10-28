Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31143E2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhJ1OA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:00:26 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:60516 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231136AbhJ1OAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:00:12 -0400
X-UUID: 47edacad8bdf4540a05affccd46b70c8-20211028
X-UUID: 47edacad8bdf4540a05affccd46b70c8-20211028
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1922462049; Thu, 28 Oct 2021 21:57:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Oct 2021 21:57:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 28 Oct 2021 21:57:42 +0800
From:   YC Hung <yc.hung@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <yc.hung@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <daniel.baluta@nxp.com>, <trevor.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 1/2] ASoC: SOF: mediatek: Add mt8195 dsp clock support
Date:   Thu, 28 Oct 2021 21:57:36 +0800
Message-ID: <20211028135737.8625-2-yc.hung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211028135737.8625-1-yc.hung@mediatek.com>
References: <20211028135737.8625-1-yc.hung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add adsp clock on/off support on mt8195 platform.

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: YC Hung <yc.hung@mediatek.com>
---
 sound/soc/sof/mediatek/adsp_helper.h       |   2 +-
 sound/soc/sof/mediatek/mt8195/Makefile     |   2 +-
 sound/soc/sof/mediatek/mt8195/mt8195-clk.c | 158 +++++++++++++++++++++
 sound/soc/sof/mediatek/mt8195/mt8195-clk.h |  28 ++++
 sound/soc/sof/mediatek/mt8195/mt8195.c     |  22 ++-
 5 files changed, 208 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.c
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.h

diff --git a/sound/soc/sof/mediatek/adsp_helper.h b/sound/soc/sof/mediatek/adsp_helper.h
index 346953dd22db..6734e2c0c6b1 100644
--- a/sound/soc/sof/mediatek/adsp_helper.h
+++ b/sound/soc/sof/mediatek/adsp_helper.h
@@ -39,7 +39,7 @@ struct adsp_priv {
 	struct mbox_controller *adsp_mbox;
 
 	struct mtk_adsp_chip_info *adsp;
-
+	struct clk **clk;
 	u32 (*ap2adsp_addr)(u32 addr, void *data);
 	u32 (*adsp2ap_addr)(u32 addr, void *data);
 
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
index 000000000000..6bcb4b9b00fb
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8195/mt8195-clk.c
@@ -0,0 +1,158 @@
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
+#include "../adsp_helper.h"
+#include "../../sof-audio.h"
+
+static const char *adsp_clks[ADSP_CLK_MAX] = {
+	[CLK_TOP_ADSP] = "adsp_sel",
+	[CLK_TOP_CLK26M] = "clk26m_ck",
+	[CLK_TOP_AUDIO_LOCAL_BUS] = "audio_local_bus",
+	[CLK_TOP_MAINPLL_D7_D2] = "mainpll_d7_d2",
+	[CLK_SCP_ADSP_AUDIODSP] = "scp_adsp_audiodsp",
+	[CLK_TOP_AUDIO_H] = "audio_h",
+};
+
+int mt8195_adsp_init_clock(struct snd_sof_dev *sdev)
+{
+	struct device *dev = sdev->dev;
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+	int i;
+
+	priv->clk = devm_kcalloc(dev, ADSP_CLK_MAX, sizeof(*priv->clk), GFP_KERNEL);
+
+	if (!priv->clk)
+		return -ENOMEM;
+
+	for (i = 0; i < ADSP_CLK_MAX; i++) {
+		priv->clk[i] = devm_clk_get(dev, adsp_clks[i]);
+		if (IS_ERR(priv->clk[i]))
+			return PTR_ERR(priv->clk[i]);
+	}
+
+	return 0;
+}
+
+static int adsp_enable_all_clock(struct snd_sof_dev *sdev)
+{
+	struct device *dev = sdev->dev;
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_MAINPLL_D7_D2]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(mainpll_d7_d2) fail %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_ADSP]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(adsp_sel) fail %d\n",
+			__func__, ret);
+		goto disable_mainpll_d7_d2_clk;
+	}
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_AUDIO_LOCAL_BUS]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(audio_local_bus) fail %d\n",
+			__func__, ret);
+		goto disable_dsp_sel_clk;
+	}
+
+	ret = clk_prepare_enable(priv->clk[CLK_SCP_ADSP_AUDIODSP]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(scp_adsp_audiodsp) fail %d\n",
+			__func__, ret);
+		goto disable_audio_local_bus_clk;
+	}
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_AUDIO_H]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(audio_h) fail %d\n",
+			__func__, ret);
+		goto disable_scp_adsp_audiodsp_clk;
+	}
+
+	return 0;
+
+disable_scp_adsp_audiodsp_clk:
+	clk_disable_unprepare(priv->clk[CLK_SCP_ADSP_AUDIODSP]);
+disable_audio_local_bus_clk:
+	clk_disable_unprepare(priv->clk[CLK_TOP_AUDIO_LOCAL_BUS]);
+disable_dsp_sel_clk:
+	clk_disable_unprepare(priv->clk[CLK_TOP_ADSP]);
+disable_mainpll_d7_d2_clk:
+	clk_disable_unprepare(priv->clk[CLK_TOP_MAINPLL_D7_D2]);
+
+	return ret;
+}
+
+static void adsp_disable_all_clock(struct snd_sof_dev *sdev)
+{
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+
+	clk_disable_unprepare(priv->clk[CLK_TOP_AUDIO_H]);
+	clk_disable_unprepare(priv->clk[CLK_SCP_ADSP_AUDIODSP]);
+	clk_disable_unprepare(priv->clk[CLK_TOP_AUDIO_LOCAL_BUS]);
+	clk_disable_unprepare(priv->clk[CLK_TOP_ADSP]);
+	clk_disable_unprepare(priv->clk[CLK_TOP_MAINPLL_D7_D2]);
+}
+
+static int adsp_default_clk_init(struct snd_sof_dev *sdev, bool enable)
+{
+	struct device *dev = sdev->dev;
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+	int ret;
+
+	dev_dbg(dev, "%s: %s\n", __func__, enable ? "on" : "off");
+
+	if (enable) {
+		ret = clk_set_parent(priv->clk[CLK_TOP_ADSP],
+				     priv->clk[CLK_TOP_CLK26M]);
+		if (ret) {
+			dev_err(dev, "failed to set dsp_sel to clk26m: %d\n", ret);
+			return ret;
+		}
+
+		ret = clk_set_parent(priv->clk[CLK_TOP_AUDIO_LOCAL_BUS],
+				     priv->clk[CLK_TOP_MAINPLL_D7_D2]);
+		if (ret) {
+			dev_err(dev, "set audio_local_bus failed %d\n", ret);
+			return ret;
+		}
+
+		ret = adsp_enable_all_clock(sdev);
+		if (ret) {
+			dev_err(dev, "failed to adsp_enable_clock: %d\n", ret);
+			return ret;
+		}
+	} else {
+		adsp_disable_all_clock(sdev);
+	}
+
+	return 0;
+}
+
+int adsp_clock_on(struct snd_sof_dev *sdev)
+{
+	/* Open ADSP clock */
+	return adsp_default_clk_init(sdev, 1);
+}
+
+int adsp_clock_off(struct snd_sof_dev *sdev)
+{
+	/* Close ADSP clock */
+	return adsp_default_clk_init(sdev, 0);
+}
+
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195-clk.h b/sound/soc/sof/mediatek/mt8195/mt8195-clk.h
new file mode 100644
index 000000000000..9cc0573d5cd2
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8195/mt8195-clk.h
@@ -0,0 +1,28 @@
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
+struct snd_sof_dev;
+
+/*DSP clock*/
+enum adsp_clk_id {
+	CLK_TOP_ADSP,
+	CLK_TOP_CLK26M,
+	CLK_TOP_AUDIO_LOCAL_BUS,
+	CLK_TOP_MAINPLL_D7_D2,
+	CLK_SCP_ADSP_AUDIODSP,
+	CLK_TOP_AUDIO_H,
+	ADSP_CLK_MAX
+};
+
+int mt8195_adsp_init_clock(struct snd_sof_dev *sdev);
+int adsp_clock_on(struct snd_sof_dev *sdev);
+int adsp_clock_off(struct snd_sof_dev *sdev);
+#endif
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 99075598a35a..5bfae9379ac8 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -25,6 +25,7 @@
 #include "../adsp_helper.h"
 #include "../mediatek-ops.h"
 #include "mt8195.h"
+#include "mt8195-clk.h"
 
 static int platform_parse_resource(struct platform_device *pdev, void *data)
 {
@@ -231,10 +232,22 @@ static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
 	if (ret)
 		return ret;
 
+	ret = mt8195_adsp_init_clock(sdev);
+	if (ret) {
+		dev_err(sdev->dev, "mt8195_adsp_init_clock failed\n");
+		return -EINVAL;
+	}
+
+	ret = adsp_clock_on(sdev);
+	if (ret) {
+		dev_err(sdev->dev, "adsp_clock_on fail!\n");
+		return -EINVAL;
+	}
+
 	ret = adsp_sram_power_on(sdev->dev, true);
 	if (ret) {
 		dev_err(sdev->dev, "adsp_sram_power_on fail!\n");
-		return ret;
+		goto exit_clk_disable;
 	}
 
 	ret = adsp_memory_remap_init(&pdev->dev, priv->adsp);
@@ -282,6 +295,8 @@ static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
 
 err_adsp_sram_power_off:
 	adsp_sram_power_on(&pdev->dev, false);
+exit_clk_disable:
+	adsp_clock_off(sdev);
 
 	return ret;
 }
@@ -290,7 +305,10 @@ static int mt8195_dsp_remove(struct snd_sof_dev *sdev)
 {
 	struct platform_device *pdev = container_of(sdev->dev, struct platform_device, dev);
 
-	return adsp_sram_power_on(&pdev->dev, false);
+	adsp_sram_power_on(&pdev->dev, false);
+	adsp_clock_off(sdev);
+
+	return 0;
 }
 
 /* on mt8195 there is 1 to 1 match between type and BAR idx */
-- 
2.18.0

