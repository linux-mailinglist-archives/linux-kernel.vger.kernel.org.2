Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0483F7E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhHYWZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhHYWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:25:35 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46334C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:24:49 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id z3-20020a4a98430000b029025f4693434bso282999ooi.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbJDvJ7/k7vSzJlT/cQdUuPB8pNiUCSXkLRC0Zxkhq4=;
        b=gD03EoGJRGj4BRbukOLl8cZoetc99D+Enq6Yppjp8ecHdtNkI8QrjG013Dh9qaXtdu
         KmPSQOCoxm6RiTnv6K7fujJAV6mdQJshwEexaLCNpnFCd2lRyGJ9YCiivk/yv6hrBjZO
         G1feGS5iMsTmfI7WCwJXYBLtOeg7CxrGNJlGAmtMJHWiEdLjTD6AIq6TkQY5wIPRKCZu
         ZmgjTzZRhIFV+53QeE2AkyyGgV78H80DnIQe5Uhy79eUubUyrOZPEFNUdVeMnEJRqK/N
         fhCErSnOZj0XkLuDgDUvFN6Mgj1RDjV810N/5arbflfneFw9LQ60MleCGVIZhTpZ93GZ
         1o3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbJDvJ7/k7vSzJlT/cQdUuPB8pNiUCSXkLRC0Zxkhq4=;
        b=bakeQs8zz9wQBV4BaCnC19byqRQJ7khlpf1fHWARRJG1wxm0KFbqSeQA5z8rdyQ66M
         b+EIZH0TVhMDZ5Aw2dL1vkFzHJa9LJBq5Zs9GFtmdgf7zRVwaqUl6Q81z0iSHW3GCB3f
         BakMynZu0GSVOy629B4GAXMXxlz4P6TQFtol7B7tKCVzLfVnvbRECQj77Vlnalljxpdl
         R8uf6pbWoedrIqSpFt90uUWCnPfGDTNizzNYXLcJNwN+/PA6Zg5aSgPyGUIrEmzKonJv
         39zUEGOJzrqHI09MLXDd4hhDv8arNAC4PSP/qZYq6/m/vF4mKDwwYJxjg8c9+zVEdfWO
         cmSA==
X-Gm-Message-State: AOAM53138HzQuFMuSE4TYK1Kqaq8PzRm9QjsFhf4a2L9XHNgpkCWQsXk
        EdZtQWoWo1YT+PV3u2kaCjavaA==
X-Google-Smtp-Source: ABdhPJwgjKA3BuieDD2mKwhq21YAJpEeJfthYSVGxJKQZg5JxGyJjJDKdxpB8eDJmAGfKU9l8V4ePQ==
X-Received: by 2002:a4a:8c33:: with SMTP id u48mr457546ooj.63.1629930288601;
        Wed, 25 Aug 2021 15:24:48 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u19sm263721oiv.28.2021.08.25.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 15:24:48 -0700 (PDT)
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
Subject: [PATCH v2 4/5] drm/msm/dp: Store each subblock in the io region
Date:   Wed, 25 Aug 2021 15:25:56 -0700
Message-Id: <20210825222557.1499104-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210825222557.1499104-1-bjorn.andersson@linaro.org>
References: <20210825222557.1499104-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all platforms has DP_P0 at offset 0x1000 from the beginning of the
DP block. So split the dss_io_data memory region into a set of
sub-regions, to make it possible in the next patch to specify each of
the sub-regions individually.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Fixed nonsensical commit message
- Introduced dss_io_region to group base and len

 drivers/gpu/drm/msm/dp/dp_catalog.c | 64 +++++++++--------------------
 drivers/gpu/drm/msm/dp/dp_parser.c  | 28 +++++++++++--
 drivers/gpu/drm/msm/dp/dp_parser.h  | 11 ++++-
 3 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index cc2bb8295329..6ae9b29044b6 100644
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
+	msm_disp_snapshot_add_block(disp_state, dss->ahb.len, dss->ahb.base, "dp_ahb");
+	msm_disp_snapshot_add_block(disp_state, dss->aux.len, dss->aux.base, "dp_aux");
+	msm_disp_snapshot_add_block(disp_state, dss->link.len, dss->link.base, "dp_link");
+	msm_disp_snapshot_add_block(disp_state, dss->p0.len, dss->p0.base, "dp_p0");
 }
 
 static inline u32 dp_read_aux(struct dp_catalog_private *catalog, u32 offset)
 {
-	offset += MSM_DP_CONTROLLER_AUX_OFFSET;
-	return readl_relaxed(catalog->io->dp_controller.base + offset);
+	return readl_relaxed(catalog->io->dp_controller.aux.base + offset);
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
+	writel(data, catalog->io->dp_controller.aux.base + offset);
 }
 
 static inline u32 dp_read_ahb(struct dp_catalog_private *catalog, u32 offset)
 {
-	offset += MSM_DP_CONTROLLER_AHB_OFFSET;
-	return readl_relaxed(catalog->io->dp_controller.base + offset);
+	return readl_relaxed(catalog->io->dp_controller.ahb.base + offset);
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
+	writel(data, catalog->io->dp_controller.ahb.base + offset);
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
+	writel(data, catalog->io->dp_controller.p0.base + offset);
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
+	return readl_relaxed(catalog->io->dp_controller.p0.base + offset);
 }
 
 static inline u32 dp_read_link(struct dp_catalog_private *catalog, u32 offset)
 {
-	offset += MSM_DP_CONTROLLER_LINK_OFFSET;
-	return readl_relaxed(catalog->io->dp_controller.base + offset);
+	return readl_relaxed(catalog->io->dp_controller.link.base + offset);
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
+	writel(data, catalog->io->dp_controller.link.base + offset);
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
+	dump_regs(io->ahb.base, io->ahb.len);
 
 	pr_info("AUXCLK regs\n");
-	offset = MSM_DP_CONTROLLER_AUX_OFFSET;
-	len = MSM_DP_CONTROLLER_AUX_SIZE;
-	dump_regs(catalog->io->dp_controller.base + offset, len);
+	dump_regs(io->aux.base, io->aux.len);
 
 	pr_info("LCLK regs\n");
-	offset = MSM_DP_CONTROLLER_LINK_OFFSET;
-	len = MSM_DP_CONTROLLER_LINK_SIZE;
-	dump_regs(catalog->io->dp_controller.base + offset, len);
+	dump_regs(io->link.base, io->link.len);
 
 	pr_info("P0CLK regs\n");
-	offset = MSM_DP_CONTROLLER_P0_OFFSET;
-	len = MSM_DP_CONTROLLER_P0_SIZE;
-	dump_regs(catalog->io->dp_controller.base + offset, len);
+	dump_regs(io->p0.base, io->p0.len);
 }
 
 u32 dp_catalog_aux_get_irq(struct dp_catalog *dp_catalog)
@@ -493,8 +471,7 @@ int dp_catalog_ctrl_set_pattern(struct dp_catalog *dp_catalog,
 	bit = BIT(pattern - 1) << DP_MAINLINK_READY_LINK_TRAINING_SHIFT;
 
 	/* Poll for mainlink ready status */
-	ret = readx_poll_timeout(readl, catalog->io->dp_controller.base +
-					MSM_DP_CONTROLLER_LINK_OFFSET +
+	ret = readx_poll_timeout(readl, catalog->io->dp_controller.link.base +
 					REG_DP_MAINLINK_READY,
 					data, data & bit,
 					POLLING_SLEEP_US, POLLING_TIMEOUT_US);
@@ -541,8 +518,7 @@ bool dp_catalog_ctrl_mainlink_ready(struct dp_catalog *dp_catalog)
 				struct dp_catalog_private, dp_catalog);
 
 	/* Poll for mainlink ready status */
-	ret = readl_poll_timeout(catalog->io->dp_controller.base +
-				MSM_DP_CONTROLLER_LINK_OFFSET +
+	ret = readl_poll_timeout(catalog->io->dp_controller.link.base +
 				REG_DP_MAINLINK_READY,
 				data, data & DP_MAINLINK_READY_FOR_VIDEO,
 				POLLING_SLEEP_US, POLLING_TIMEOUT_US);
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index 215065336268..4a7dad86159f 100644
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
@@ -40,9 +49,22 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
 	struct dp_io *io = &parser->io;
 	struct dss_io_data *dss = &io->dp_controller;
 
-	dss->base = dp_ioremap(pdev, 0, &dss->len);
-	if (IS_ERR(dss->base))
-		return PTR_ERR(dss->base);
+	dss->ahb.base = dp_ioremap(pdev, 0, &dss->ahb.len);
+	if (IS_ERR(dss->ahb.base))
+		return PTR_ERR(dss->ahb.base);
+
+	if (dss->ahb.len < DP_DEFAULT_P0_OFFSET + DP_DEFAULT_P0_SIZE) {
+		DRM_ERROR("legacy memory region not large enough\n");
+		return -EINVAL;
+	}
+
+	dss->ahb.len = DP_DEFAULT_AHB_SIZE;
+	dss->aux.base = dss->ahb.base + DP_DEFAULT_AUX_OFFSET;
+	dss->aux.len = DP_DEFAULT_AUX_SIZE;
+	dss->link.base = dss->ahb.base + DP_DEFAULT_LINK_OFFSET;
+	dss->link.len = DP_DEFAULT_LINK_SIZE;
+	dss->p0.base = dss->ahb.base + DP_DEFAULT_P0_OFFSET;
+	dss->p0.len = DP_DEFAULT_P0_SIZE;
 
 	io->phy = devm_phy_get(&pdev->dev, "dp");
 	if (IS_ERR(io->phy))
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
index dc62e70b1640..a95b05dbb11c 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@ -25,9 +25,16 @@ enum dp_pm_type {
 	DP_MAX_PM
 };
 
-struct dss_io_data {
-	size_t len;
+struct dss_io_region {
 	void __iomem *base;
+	size_t len;
+};
+
+struct dss_io_data {
+	struct dss_io_region ahb;
+	struct dss_io_region aux;
+	struct dss_io_region link;
+	struct dss_io_region p0;
 };
 
 static inline const char *dp_parser_pm_name(enum dp_pm_type module)
-- 
2.29.2

