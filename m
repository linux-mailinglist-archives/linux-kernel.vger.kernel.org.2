Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B333D1BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhGVCDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhGVCDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:03:44 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED27C06179B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:44:15 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so4064145otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bo1WH90B2Q6BpI8Vp15t4ugWjGrNTTsDZhz3C9CMTkc=;
        b=EM1kT5ybuQduKHIs+KTxthW8o24JaLpX36RVLazTaIPkm1XaeZ/O8x8O22//Jlmydt
         fdgef1G69braOKl4B6enqe4hvkNuy1tnBVJd13g1DQNz3TDC+lQEy5LHxbfMmgbiNoYn
         8DuBs8vtFhiSN1JAC+/tCPEKCIaiMo/mYOrI9elkGbIg1vy6wBKS1JvugJD1nUemzo3o
         6GzkiLRvrEKRdjB4QEv2nZDvEfXyeRy5TobfcejNfduQJrcvCRcnUKKroFCnpB61w9gZ
         //x4Y6sv+oZMMFhN4VAyk9WRvayUo57NvV8tnfHpxYfhz3t1s/LYUeSpuGyxXwPC5eWX
         hRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo1WH90B2Q6BpI8Vp15t4ugWjGrNTTsDZhz3C9CMTkc=;
        b=WWeOXUP3IwWbgUAnP9giOhE6jCwybc2IGrX+vTYCwiyav5AvsDsurbpH1gDFNEE7Sm
         gy8t8OKg2tViWcgD+vtPgLQG+JbMimzGSusQwc3yPYRC4IXwljZmQycY127VOj2Kgy2I
         DZMlrah7XvaIwC3kKNZakTs8xwzdLcjn5a97kjjrbjY/DEq20sfGD8Km05Ubl5oB20l9
         6m+fYAtLPUnHHFQJY/MtuyfFVv25x+SnTUHtxgsCbx9P5R1J6LWrCU4w7scpQtpe/Fp/
         bRCZ+6xIhCFtamVCo+Rsl23i9AHji7A607wOvhiRWLmpzAR4ThRwrQFu1Ce6lc9ZgeXD
         LaIQ==
X-Gm-Message-State: AOAM530V4falL6aCW/FBVISQmQyVNAT40cZUpT7uKeKkoxP0/8wLMmvO
        sDSPaU1JDXAAT7xrm1rEEFYlYQ==
X-Google-Smtp-Source: ABdhPJzpKmnLYeaIUULH5FIYC8+AYH50c7fi9r43R//UjwnpTmfrW+RpTd8Jtyn+Zm92VDWeOd3Ehg==
X-Received: by 2002:a9d:63c6:: with SMTP id e6mr27408331otl.295.1626921855164;
        Wed, 21 Jul 2021 19:44:15 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u18sm5346519oif.9.2021.07.21.19.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:44:14 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/msm/dp: Store each subblock in the io region
Date:   Wed, 21 Jul 2021 19:42:26 -0700
Message-Id: <20210722024227.3313096-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210722024227.3313096-1-bjorn.andersson@linaro.org>
References: <20210722024227.3313096-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all platforms has DP_P0 at offset 0x1000 from the beginning of the
DP block. So dss_io_data into representing each of the sub-regions, to
make it possible in the next patch to specify each of the sub-regions
individually.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 64 +++++++++--------------------
 drivers/gpu/drm/msm/dp/dp_parser.c  | 30 ++++++++++++--
 drivers/gpu/drm/msm/dp/dp_parser.h  | 10 ++++-
 3 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index ca96e3514790..23458b0ddc37 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -24,15 +24,6 @@
 #define DP_INTERRUPT_STATUS_ACK_SHIFT	1
 #define DP_INTERRUPT_STATUS_MASK_SHIFT	2
 
-#define MSM_DP_CONTROLLER_AHB_OFFSET	0x0000
-#define MSM_DP_CONTROLLER_AHB_SIZE	0x0200
-#define MSM_DP_CONTROLLER_AUX_OFFSET	0x0200
-#define MSM_DP_CONTROLLER_AUX_SIZE	0x0200
-#define MSM_DP_CONTROLLER_LINK_OFFSET	0x0400
-#define MSM_DP_CONTROLLER_LINK_SIZE	0x0C00
-#define MSM_DP_CONTROLLER_P0_OFFSET	0x1000
-#define MSM_DP_CONTROLLER_P0_SIZE	0x0400
-
 #define DP_INTERRUPT_STATUS1 \
 	(DP_INTR_AUX_I2C_DONE| \
 	DP_INTR_WRONG_ADDR | DP_INTR_TIMEOUT | \
@@ -66,82 +57,77 @@ void dp_catalog_snapshot(struct dp_catalog *dp_catalog, struct msm_disp_state *d
 {
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 			struct dp_catalog_private, dp_catalog);
+	struct dss_io_data *dss = &catalog->io->dp_controller;
 
-	msm_disp_snapshot_add_block(disp_state, catalog->io->dp_controller.len,
-			catalog->io->dp_controller.base, "dp_ctrl");
+	msm_disp_snapshot_add_block(disp_state, dss->ahb_len, dss->ahb, "dp_ahb");
+	msm_disp_snapshot_add_block(disp_state, dss->aux_len, dss->aux, "dp_aux");
+	msm_disp_snapshot_add_block(disp_state, dss->link_len, dss->link, "dp_link");
+	msm_disp_snapshot_add_block(disp_state, dss->p0_len, dss->p0, "dp_p0");
 }
 
 static inline u32 dp_read_aux(struct dp_catalog_private *catalog, u32 offset)
 {
-	offset += MSM_DP_CONTROLLER_AUX_OFFSET;
-	return readl_relaxed(catalog->io->dp_controller.base + offset);
+	return readl_relaxed(catalog->io->dp_controller.aux + offset);
 }
 
 static inline void dp_write_aux(struct dp_catalog_private *catalog,
 			       u32 offset, u32 data)
 {
-	offset += MSM_DP_CONTROLLER_AUX_OFFSET;
 	/*
 	 * To make sure aux reg writes happens before any other operation,
 	 * this function uses writel() instread of writel_relaxed()
 	 */
-	writel(data, catalog->io->dp_controller.base + offset);
+	writel(data, catalog->io->dp_controller.aux + offset);
 }
 
 static inline u32 dp_read_ahb(struct dp_catalog_private *catalog, u32 offset)
 {
-	offset += MSM_DP_CONTROLLER_AHB_OFFSET;
-	return readl_relaxed(catalog->io->dp_controller.base + offset);
+	return readl_relaxed(catalog->io->dp_controller.ahb + offset);
 }
 
 static inline void dp_write_ahb(struct dp_catalog_private *catalog,
 			       u32 offset, u32 data)
 {
-	offset += MSM_DP_CONTROLLER_AHB_OFFSET;
 	/*
 	 * To make sure phy reg writes happens before any other operation,
 	 * this function uses writel() instread of writel_relaxed()
 	 */
-	writel(data, catalog->io->dp_controller.base + offset);
+	writel(data, catalog->io->dp_controller.ahb + offset);
 }
 
 static inline void dp_write_p0(struct dp_catalog_private *catalog,
 			       u32 offset, u32 data)
 {
-	offset += MSM_DP_CONTROLLER_P0_OFFSET;
 	/*
 	 * To make sure interface reg writes happens before any other operation,
 	 * this function uses writel() instread of writel_relaxed()
 	 */
-	writel(data, catalog->io->dp_controller.base + offset);
+	writel(data, catalog->io->dp_controller.p0 + offset);
 }
 
 static inline u32 dp_read_p0(struct dp_catalog_private *catalog,
 			       u32 offset)
 {
-	offset += MSM_DP_CONTROLLER_P0_OFFSET;
 	/*
 	 * To make sure interface reg writes happens before any other operation,
 	 * this function uses writel() instread of writel_relaxed()
 	 */
-	return readl_relaxed(catalog->io->dp_controller.base + offset);
+	return readl_relaxed(catalog->io->dp_controller.p0 + offset);
 }
 
 static inline u32 dp_read_link(struct dp_catalog_private *catalog, u32 offset)
 {
-	offset += MSM_DP_CONTROLLER_LINK_OFFSET;
-	return readl_relaxed(catalog->io->dp_controller.base + offset);
+	return readl_relaxed(catalog->io->dp_controller.link + offset);
 }
 
 static inline void dp_write_link(struct dp_catalog_private *catalog,
 			       u32 offset, u32 data)
 {
-	offset += MSM_DP_CONTROLLER_LINK_OFFSET;
 	/*
 	 * To make sure link reg writes happens before any other operation,
 	 * this function uses writel() instread of writel_relaxed()
 	 */
-	writel(data, catalog->io->dp_controller.base + offset);
+	writel(data, catalog->io->dp_controller.link + offset);
 }
 
 /* aux related catalog functions */
@@ -276,29 +262,21 @@ static void dump_regs(void __iomem *base, int len)
 
 void dp_catalog_dump_regs(struct dp_catalog *dp_catalog)
 {
-	u32 offset, len;
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 		struct dp_catalog_private, dp_catalog);
+	struct dss_io_data *io = &catalog->io->dp_controller;
 
 	pr_info("AHB regs\n");
-	offset = MSM_DP_CONTROLLER_AHB_OFFSET;
-	len = MSM_DP_CONTROLLER_AHB_SIZE;
-	dump_regs(catalog->io->dp_controller.base + offset, len);
+	dump_regs(io->ahb, io->ahb_len);
 
 	pr_info("AUXCLK regs\n");
-	offset = MSM_DP_CONTROLLER_AUX_OFFSET;
-	len = MSM_DP_CONTROLLER_AUX_SIZE;
-	dump_regs(catalog->io->dp_controller.base + offset, len);
+	dump_regs(io->aux, io->aux_len);
 
 	pr_info("LCLK regs\n");
-	offset = MSM_DP_CONTROLLER_LINK_OFFSET;
-	len = MSM_DP_CONTROLLER_LINK_SIZE;
-	dump_regs(catalog->io->dp_controller.base + offset, len);
+	dump_regs(io->link, io->link_len);
 
 	pr_info("P0CLK regs\n");
-	offset = MSM_DP_CONTROLLER_P0_OFFSET;
-	len = MSM_DP_CONTROLLER_P0_SIZE;
-	dump_regs(catalog->io->dp_controller.base + offset, len);
+	dump_regs(io->p0, io->p0_len);
 }
 
 u32 dp_catalog_aux_get_irq(struct dp_catalog *dp_catalog)
@@ -492,8 +470,7 @@ int dp_catalog_ctrl_set_pattern(struct dp_catalog *dp_catalog,
 	bit = BIT(pattern - 1) << DP_MAINLINK_READY_LINK_TRAINING_SHIFT;
 
 	/* Poll for mainlink ready status */
-	ret = readx_poll_timeout(readl, catalog->io->dp_controller.base +
-					MSM_DP_CONTROLLER_LINK_OFFSET +
+	ret = readx_poll_timeout(readl, catalog->io->dp_controller.link +
 					REG_DP_MAINLINK_READY,
 					data, data & bit,
 					POLLING_SLEEP_US, POLLING_TIMEOUT_US);
@@ -540,8 +517,7 @@ bool dp_catalog_ctrl_mainlink_ready(struct dp_catalog *dp_catalog)
 				struct dp_catalog_private, dp_catalog);
 
 	/* Poll for mainlink ready status */
-	ret = readl_poll_timeout(catalog->io->dp_controller.base +
-				MSM_DP_CONTROLLER_LINK_OFFSET +
+	ret = readl_poll_timeout(catalog->io->dp_controller.link +
 				REG_DP_MAINLINK_READY,
 				data, data & DP_MAINLINK_READY_FOR_VIDEO,
 				POLLING_SLEEP_US, POLLING_TIMEOUT_US);
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index e68dacef547c..1a10901ae574 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -11,6 +11,15 @@
 #include "dp_parser.h"
 #include "dp_reg.h"
 
+#define DP_DEFAULT_AHB_OFFSET	0x0000
+#define DP_DEFAULT_AHB_SIZE	0x0200
+#define DP_DEFAULT_AUX_OFFSET	0x0200
+#define DP_DEFAULT_AUX_SIZE	0x0200
+#define DP_DEFAULT_LINK_OFFSET	0x0400
+#define DP_DEFAULT_LINK_SIZE	0x0C00
+#define DP_DEFAULT_P0_OFFSET	0x1000
+#define DP_DEFAULT_P0_SIZE	0x0400
+
 static const struct dp_regulator_cfg sdm845_dp_reg_cfg = {
 	.num = 2,
 	.regs = {
@@ -48,12 +57,25 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
 	struct dp_io *io = &parser->io;
 	struct dss_io_data *dss = &io->dp_controller;
 
-	dss->base = dp_ioremap(pdev, 0, &dss->len);
-	if (IS_ERR(dss->base)) {
-		DRM_ERROR("unable to remap dp io region: %pe\n", dss->base);
-		return PTR_ERR(dss->base);
+	dss->ahb = dp_ioremap(pdev, 0, &dss->ahb_len);
+	if (IS_ERR(dss->ahb)) {
+		DRM_ERROR("unable to remap ahb region: %pe\n", dss->ahb);
+		return PTR_ERR(dss->ahb);
 	}
 
+	if (dss->ahb_len < DP_DEFAULT_P0_OFFSET + DP_DEFAULT_P0_SIZE) {
+		DRM_ERROR("legacy memory region not large enough\n");
+		return -EINVAL;
+	}
+
+	dss->ahb_len = DP_DEFAULT_AHB_SIZE;
+	dss->aux = dss->ahb + DP_DEFAULT_AUX_OFFSET;
+	dss->aux_len = DP_DEFAULT_AUX_SIZE;
+	dss->link = dss->ahb + DP_DEFAULT_LINK_OFFSET;
+	dss->link_len = DP_DEFAULT_LINK_SIZE;
+	dss->p0 = dss->ahb + DP_DEFAULT_P0_OFFSET;
+	dss->p0_len = DP_DEFAULT_P0_SIZE;
+
 	io->phy = devm_phy_get(&pdev->dev, "dp");
 	if (IS_ERR(io->phy))
 		return PTR_ERR(io->phy);
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
index dc62e70b1640..3266b529c090 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@ -26,8 +26,14 @@ enum dp_pm_type {
 };
 
 struct dss_io_data {
-	size_t len;
-	void __iomem *base;
+	void __iomem *ahb;
+	size_t ahb_len;
+	void __iomem *aux;
+	size_t aux_len;
+	void __iomem *link;
+	size_t link_len;
+	void __iomem *p0;
+	size_t p0_len;
 };
 
 static inline const char *dp_parser_pm_name(enum dp_pm_type module)
-- 
2.29.2

