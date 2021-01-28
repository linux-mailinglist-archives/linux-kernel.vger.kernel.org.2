Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51577306FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhA1HiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhA1Hbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:31:33 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31C3C061794
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:28:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q20so3440336pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYjT5ToKNf0BcGsPTT/zXSzdcUW6skKls5id4x7Mx5A=;
        b=hfuFr/sbyn5zOHmWwbM7Y7na5bes06UqTrSckCh/+87Pnw9MXE33dYXfhRv1UMmbty
         1cCmncLzdy9O0F3XTr4NioufFpV/JrQO87tSkvtHmz8JKZCdOXa4jDghIAVMFda9iLCr
         qmTCzVzcyWYeblVBYyycVfHJm4pOsLUTgzTLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYjT5ToKNf0BcGsPTT/zXSzdcUW6skKls5id4x7Mx5A=;
        b=QZPi6T9EM58Owx2S+uOEvQKjJfah7WyH8WUasnzpdKvp+Qz3sVGMZwTIJx6WpHndpm
         /D13CPCJe8MbkbDVWGnWXwkwtqpkktKAyXIuF/Vp0Kj6liVoP2iFxiW/3QpB/WGsCen7
         qfC3layevW2HszGoYQv/LK5uHH2Urnnr1wgreKK1bCDBdIGuUY0LNuH9uUOAF04lbgES
         zElRJD4mp/f+DA+h2IwZrIdMW2nXP9+g49xiNxvq+g1xDOHc06aNTsGzROegpq6AA/F6
         gJekxLzYExqnn+uid2sN0eVmRA0AYFDIzkvHOWf4Tdz+SOuFn4LY2kTzwUJd+pOPV0MM
         DiOA==
X-Gm-Message-State: AOAM532NbdFsDNsYfYPo7lwAXytagg9b9aumNdpHapyABcL4TSHFg/lo
        E800MHBpcz2M3hgvLhg41h3WBw==
X-Google-Smtp-Source: ABdhPJwjWfWo1SdKefj5tFTz+Exst40AhseE8qxchyFUQKIoeYdouf+q3ljA5AOOi/RgekiXvKLvKw==
X-Received: by 2002:a05:6a00:15d2:b029:1b7:30c1:8495 with SMTP id o18-20020a056a0015d2b02901b730c18495mr14427050pfu.32.1611818903083;
        Wed, 27 Jan 2021 23:28:23 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id h2sm4800304pfk.4.2021.01.27.23.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 23:28:22 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v11 5/9] drm/mediatek: separate gamma module
Date:   Thu, 28 Jan 2021 15:27:58 +0800
Message-Id: <20210128072802.830971-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210128072802.830971-1-hsinyi@chromium.org>
References: <20210128072802.830971-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

mt8183 gamma module will different with mt8173
separate gamma for add private data

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/Makefile           |   1 +
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  10 ++
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c   | 189 ++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  71 ++------
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   4 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
 6 files changed, 215 insertions(+), 61 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_gamma.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index 01d06332f7679..b64674b944860 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 mediatek-drm-y := mtk_disp_color.o \
+		  mtk_disp_gamma.o \
 		  mtk_disp_ovl.o \
 		  mtk_disp_rdma.o \
 		  mtk_drm_crtc.o \
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index c50d5fc9fd349..c1e658b490b6c 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -27,6 +27,16 @@ void mtk_dpi_stop(struct device *dev);
 void mtk_dsi_ddp_start(struct device *dev);
 void mtk_dsi_ddp_stop(struct device *dev);
 
+int mtk_gamma_clk_enable(struct device *dev);
+void mtk_gamma_clk_disable(struct device *dev);
+void mtk_gamma_config(struct device *dev, unsigned int w,
+                      unsigned int h, unsigned int vrefresh,
+                      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
+void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state);
+void mtk_gamma_set_common(void __iomem *regs, struct drm_crtc_state *state);
+void mtk_gamma_start(struct device *dev);
+void mtk_gamma_stop(struct device *dev);
+
 void mtk_ovl_bgclr_in_on(struct device *dev);
 void mtk_ovl_bgclr_in_off(struct device *dev);
 void mtk_ovl_bypass_shadow(struct device *dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
new file mode 100644
index 0000000000000..a7e2e326b2183
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -0,0 +1,189 @@
+/*
+ * SPDX-License-Identifier:
+ *
+ * Copyright (c) 2020 MediaTek Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
+
+#include "mtk_disp_drv.h"
+#include "mtk_drm_crtc.h"
+#include "mtk_drm_ddp_comp.h"
+
+#define DISP_GAMMA_EN				0x0000
+#define GAMMA_EN					BIT(0)
+#define DISP_GAMMA_CFG				0x0020
+#define GAMMA_LUT_EN					BIT(1)
+#define DISP_GAMMA_SIZE				0x0030
+#define DISP_GAMMA_LUT				0x0700
+
+#define LUT_10BIT_MASK				0x03ff
+
+struct mtk_disp_gamma_data {
+	u32 reserved;
+};
+
+/**
+ * struct mtk_disp_gamma - DISP_GAMMA driver structure
+ * @ddp_comp - structure containing type enum and hardware resources
+ * @crtc - associated crtc to report irq events to
+ */
+struct mtk_disp_gamma {
+	struct clk *clk;
+	void __iomem *regs;
+	struct cmdq_client_reg cmdq_reg;
+	const struct mtk_disp_gamma_data *data;
+};
+
+int mtk_gamma_clk_enable(struct device *dev)
+{
+	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(gamma->clk);
+}
+
+void mtk_gamma_clk_disable(struct device *dev)
+{
+	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(gamma->clk);
+}
+
+void mtk_gamma_set_common(void __iomem *regs, struct drm_crtc_state *state)
+{
+	unsigned int i, reg;
+	struct drm_color_lut *lut;
+	void __iomem *lut_base;
+	u32 word;
+
+	if (state->gamma_lut) {
+		reg = readl(regs + DISP_GAMMA_CFG);
+		reg = reg | GAMMA_LUT_EN;
+		writel(reg, regs + DISP_GAMMA_CFG);
+		lut_base = regs + DISP_GAMMA_LUT;
+		lut = (struct drm_color_lut *)state->gamma_lut->data;
+		for (i = 0; i < MTK_LUT_SIZE; i++) {
+			word = (((lut[i].red >> 6) & LUT_10BIT_MASK) << 20) +
+				(((lut[i].green >> 6) & LUT_10BIT_MASK) << 10) +
+				((lut[i].blue >> 6) & LUT_10BIT_MASK);
+			writel(word, (lut_base + i * 4));
+		}
+	}
+}
+
+void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state)
+{
+	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+
+	mtk_gamma_set_common(gamma->regs, state);
+}
+
+void mtk_gamma_config(struct device *dev, unsigned int w,
+		      unsigned int h, unsigned int vrefresh,
+		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
+{
+	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+
+	mtk_ddp_write(cmdq_pkt, h << 16 | w, &gamma->cmdq_reg, gamma->regs,
+		      DISP_GAMMA_SIZE);
+	mtk_dither_set_common(gamma->regs, &gamma->cmdq_reg, bpc, DISP_GAMMA_CFG, cmdq_pkt);
+}
+
+void mtk_gamma_start(struct device *dev)
+{
+	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+
+	writel(GAMMA_EN, gamma->regs + DISP_GAMMA_EN);
+}
+
+void mtk_gamma_stop(struct device *dev)
+{
+	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+
+	writel_relaxed(0x0, gamma->regs + DISP_GAMMA_EN);
+}
+
+static int mtk_disp_gamma_bind(struct device *dev, struct device *master,
+			       void *data)
+{
+	return 0;
+}
+
+static void mtk_disp_gamma_unbind(struct device *dev, struct device *master,
+				  void *data)
+{
+}
+
+static const struct component_ops mtk_disp_gamma_component_ops = {
+	.bind	= mtk_disp_gamma_bind,
+	.unbind = mtk_disp_gamma_unbind,
+};
+
+static int mtk_disp_gamma_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_disp_gamma *priv;
+	struct resource *res;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "failed to get gamma clk\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->regs)) {
+		dev_err(dev, "failed to ioremap gamma\n");
+		return PTR_ERR(priv->regs);
+	}
+
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	ret = cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
+	if (ret)
+		dev_dbg(dev, "get mediatek,gce-client-reg fail!\n");
+#endif
+
+	priv->data = of_device_get_match_data(dev);
+	platform_set_drvdata(pdev, priv);
+
+	ret = component_add(dev, &mtk_disp_gamma_component_ops);
+	if (ret)
+		dev_err(dev, "Failed to add component: %d\n", ret);
+
+	return ret;
+}
+
+static int mtk_disp_gamma_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &mtk_disp_gamma_component_ops);
+
+	return 0;
+}
+
+static const struct of_device_id mtk_disp_gamma_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt8173-disp-gamma"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_disp_gamma_driver_dt_match);
+
+struct platform_driver mtk_disp_gamma_driver = {
+	.probe		= mtk_disp_gamma_probe,
+	.remove		= mtk_disp_gamma_remove,
+	.driver		= {
+		.name	= "mediatek-disp-gamma",
+		.owner	= THIS_MODULE,
+		.of_match_table = mtk_disp_gamma_driver_dt_match,
+	},
+};
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 53d25823a37cc..8173f709272be 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -55,11 +55,6 @@
 #define DITHER_RELAY_MODE			BIT(0)
 #define DISP_DITHER_SIZE			0x0030
 
-#define DISP_GAMMA_EN				0x0000
-#define DISP_GAMMA_CFG				0x0020
-#define DISP_GAMMA_SIZE				0x0030
-#define DISP_GAMMA_LUT				0x0700
-
 #define LUT_10BIT_MASK				0x03ff
 
 #define OD_RELAYMODE				BIT(0)
@@ -68,9 +63,6 @@
 
 #define AAL_EN					BIT(0)
 
-#define GAMMA_EN				BIT(0)
-#define GAMMA_LUT_EN				BIT(1)
-
 #define DISP_DITHERING				BIT(2)
 #define DITHER_LSB_ERR_SHIFT_R(x)		(((x) & 0x7) << 28)
 #define DITHER_OVFLW_BIT_R(x)			(((x) & 0x7) << 24)
@@ -151,7 +143,6 @@ static void mtk_ddp_clk_disable(struct device *dev)
 	clk_disable_unprepare(priv->clk);
 }
 
-
 void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
 			   unsigned int bpc, unsigned int CFG, struct cmdq_pkt *cmdq_pkt)
 {
@@ -219,6 +210,13 @@ static void mtk_aal_config(struct device *dev, unsigned int w,
 	mtk_ddp_write(cmdq_pkt, w << 16 | h, &priv->cmdq_reg, priv->regs, DISP_AAL_SIZE);
 }
 
+static void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state *state)
+{
+	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
+
+        mtk_gamma_set_common(priv->regs, state);
+}
+
 static void mtk_aal_start(struct device *dev)
 {
 	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
@@ -333,58 +331,10 @@ static void mtk_dither_stop(struct device *dev)
 	writel_relaxed(0x0, priv->regs + DISP_DITHER_EN);
 }
 
-static void mtk_gamma_config(struct device *dev, unsigned int w,
-			     unsigned int h, unsigned int vrefresh,
-			     unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
-{
-	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
-
-	mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs, DISP_GAMMA_SIZE);
-	mtk_dither_set(dev, bpc, DISP_GAMMA_CFG, cmdq_pkt);
-}
-
-static void mtk_gamma_start(struct device *dev)
-{
-	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
-
-	writel(GAMMA_EN, priv->regs  + DISP_GAMMA_EN);
-}
-
-static void mtk_gamma_stop(struct device *dev)
-{
-	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
-
-	writel_relaxed(0x0, priv->regs  + DISP_GAMMA_EN);
-}
-
-static void mtk_gamma_set(struct device *dev,
-			  struct drm_crtc_state *state)
-{
-	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
-	unsigned int i, reg;
-	struct drm_color_lut *lut;
-	void __iomem *lut_base;
-	u32 word;
-
-	if (state->gamma_lut) {
-		reg = readl(priv->regs + DISP_GAMMA_CFG);
-		reg = reg | GAMMA_LUT_EN;
-		writel(reg, priv->regs + DISP_GAMMA_CFG);
-		lut_base = priv->regs + DISP_GAMMA_LUT;
-		lut = (struct drm_color_lut *)state->gamma_lut->data;
-		for (i = 0; i < MTK_LUT_SIZE; i++) {
-			word = (((lut[i].red >> 6) & LUT_10BIT_MASK) << 20) +
-				(((lut[i].green >> 6) & LUT_10BIT_MASK) << 10) +
-				((lut[i].blue >> 6) & LUT_10BIT_MASK);
-			writel(word, (lut_base + i * 4));
-		}
-	}
-}
-
 static const struct mtk_ddp_comp_funcs ddp_aal = {
 	.clk_enable = mtk_ddp_clk_enable,
 	.clk_disable = mtk_ddp_clk_disable,
-	.gamma_set = mtk_gamma_set,
+	.gamma_set = mtk_aal_gamma_set,
 	.config = mtk_aal_config,
 	.start = mtk_aal_start,
 	.stop = mtk_aal_stop,
@@ -425,8 +375,8 @@ static const struct mtk_ddp_comp_funcs ddp_dsi = {
 };
 
 static const struct mtk_ddp_comp_funcs ddp_gamma = {
-	.clk_enable = mtk_ddp_clk_enable,
-	.clk_disable = mtk_ddp_clk_disable,
+	.clk_enable = mtk_gamma_clk_enable,
+	.clk_disable = mtk_gamma_clk_disable,
 	.gamma_set = mtk_gamma_set,
 	.config = mtk_gamma_config,
 	.start = mtk_gamma_start,
@@ -642,6 +592,7 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 
 	if (type == MTK_DISP_BLS ||
 	    type == MTK_DISP_COLOR ||
+	    type == MTK_DISP_GAMMA ||
 	    type == MTK_DPI ||
 	    type == MTK_DSI ||
 	    type == MTK_DISP_OVL ||
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 5d39dd54255d1..279d3e6f11563 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -486,11 +486,12 @@ static int mtk_drm_probe(struct platform_device *pdev)
 		private->comp_node[comp_id] = of_node_get(node);
 
 		/*
-		 * Currently only the COLOR, OVL, RDMA, DSI, and DPI blocks have
+		 * Currently only the COLOR, GAMMA, OVL, RDMA, DSI, and DPI blocks have
 		 * separate component platform drivers and initialize their own
 		 * DDP component structure. The others are initialized here.
 		 */
 		if (comp_type == MTK_DISP_COLOR ||
+		    comp_type == MTK_DISP_GAMMA ||
 		    comp_type == MTK_DISP_OVL ||
 		    comp_type == MTK_DISP_OVL_2L ||
 		    comp_type == MTK_DISP_RDMA ||
@@ -589,6 +590,7 @@ static struct platform_driver mtk_drm_platform_driver = {
 
 static struct platform_driver * const mtk_drm_drivers[] = {
 	&mtk_disp_color_driver,
+	&mtk_disp_gamma_driver,
 	&mtk_disp_ovl_driver,
 	&mtk_disp_rdma_driver,
 	&mtk_dpi_driver,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index e8238fa4aa2ac..0e54e3d51014a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -47,6 +47,7 @@ struct mtk_drm_private {
 };
 
 extern struct platform_driver mtk_disp_color_driver;
+extern struct platform_driver mtk_disp_gamma_driver;
 extern struct platform_driver mtk_disp_ovl_driver;
 extern struct platform_driver mtk_disp_rdma_driver;
 extern struct platform_driver mtk_dpi_driver;
-- 
2.30.0.280.ga3ce27912f-goog

