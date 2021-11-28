Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141FF460641
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 13:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357448AbhK1Mzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 07:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbhK1Mxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 07:53:51 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C1AC061746;
        Sun, 28 Nov 2021 04:50:35 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id z26so17423172iod.10;
        Sun, 28 Nov 2021 04:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKZWF5gN/dipZUN6w+sfnbsbYZiCC0RMt8cpstFuDYk=;
        b=P21dv/dqm8upYHm/bOCW7i6n/1K0A7zXWbdZZ3uJ2FWQVg1hjVrtmYxZ4/WT/s+JMq
         /0zsAF/6HVeHDOqTZv4bOW/KqGpEcTY3LdXrvTn2UdzF9JvLB9WbSkWElQm9qsBNu/w9
         +9eD3DZSMMGnkHLSEXPPs7TusKLvgbiG8o7o18YnTp2Bx43Fsm+xWZYiJIMndx2OYXV2
         Y0cG0L8ElSWrethSdB9nnjFZvpVXANhVSBgKPbJLcBYQtBRd9QDHlera/6OcrGiUB8hC
         PEQz58AElQwP40bGTk6rLLjrYXtFG0Ilx61j5Iu41uU+3bPVGJcI/yLD/PevDq3AGqj8
         KGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKZWF5gN/dipZUN6w+sfnbsbYZiCC0RMt8cpstFuDYk=;
        b=LZkx/jzpBGoE7BwBV9qm0vh/+V4Aqvo8o5ucm2BdVumYKvU3p8AmLOiT+YFVdssNWH
         mgTtMEzyrvVwlIq3BfYHIEX3g2VDXFPiSDdq8kw6RGbeiJ/XAmm5wcXXfgJgHpC5MxOc
         AZA/OlKdNNn6sWy2rSm4DjrtLgL4H66U02BFpwVWa+wdaLEmUauBfGn4SiBHztXwYB7S
         nEYTM+qAO+RkNAnVPN9QEzCO+cGwhUozJTKS8amjNGTea5uq8PzxkPuB51Bo8D7SCkae
         y+IX8yTFIw/f1wUvMkf7YD16TxTQXCgynzFjSuP+0WXhMa0FrPYzRMHuVomQRy8HIFDx
         W+3w==
X-Gm-Message-State: AOAM533k6HhwgUoYDyJDB0H2r2Fw3DW3LyqtHEOSr6Cg8Hur3NDS87fQ
        8I07+Bxsip1jyV1+RC2pwF4=
X-Google-Smtp-Source: ABdhPJyAx9Vhmg4ISue/Uqrz2MHWmExfKbzYQAv9cBQDO+gkW/TaliXI8WH2WGwashQEaqWWaX/Bhw==
X-Received: by 2002:a6b:7306:: with SMTP id e6mr50335014ioh.25.1638103834952;
        Sun, 28 Nov 2021 04:50:34 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id j21sm6545240ila.6.2021.11.28.04.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 04:50:34 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, tharvey@gateworks.com,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/5] soc: imx: imx8m-blk-ctrl: Fix imx8mm mipi reset
Date:   Sun, 28 Nov 2021 06:50:07 -0600
Message-Id: <20211128125011.12817-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the blk-ctrl reset bits are found in one register, however
there are two bits in offset 8 for pulling the MIPI DPHY out of reset
and one of them needs to be set when IMX8MM_DISPBLK_PD_MIPI_CSI is brought
out of reset or the MIPI_CSI hangs.

Since MIPI_DSI is impacted, add the additional one for MIPI_DSI too.

Fixes: 926e57c065df ("soc: imx: imx8m-blk-ctrl: add DISP blk-ctrl")
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
V3:  Split the  mipi_phy_rst_mask for CSI and DSI into their respective domains.

V2:  Make a note that the extra register is only for Mini/Nano DISPLAY_BLK_CTRL
     Rename the new register to mipi_phy_rst_mask
     Encapsulate the edits to this register with an if-statement
     
 drivers/soc/imx/imx8m-blk-ctrl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 519b3651d1d9..c2f076b56e24 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -17,6 +17,7 @@
 
 #define BLK_SFT_RSTN	0x0
 #define BLK_CLK_EN	0x4
+#define BLK_MIPI_RESET_DIV	0x8 /* Mini/Nano DISPLAY_BLK_CTRL only */
 
 struct imx8m_blk_ctrl_domain;
 
@@ -36,6 +37,15 @@ struct imx8m_blk_ctrl_domain_data {
 	const char *gpc_name;
 	u32 rst_mask;
 	u32 clk_mask;
+
+	/*
+	 * i.MX8M Mini and Nano have a third DISPLAY_BLK_CTRL register
+	 * which is used to control the reset for the MIPI Phy.
+	 * Since it's only present in certain circumstances,
+	 * an if-statement should be used before setting and clearing this
+	 * register.
+	 */
+	u32 mipi_phy_rst_mask;
 };
 
 #define DOMAIN_MAX_CLKS 3
@@ -78,6 +88,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 
 	/* put devices into reset */
 	regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
+	if (data->mipi_phy_rst_mask)
+		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
 
 	/* enable upstream and blk-ctrl clocks to allow reset to propagate */
 	ret = clk_bulk_prepare_enable(data->num_clks, domain->clks);
@@ -99,6 +111,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 
 	/* release reset */
 	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
+	if (data->mipi_phy_rst_mask)
+		regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
 
 	/* disable upstream clocks */
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
@@ -120,6 +134,9 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	struct imx8m_blk_ctrl *bc = domain->bc;
 
 	/* put devices into reset and disable clocks */
+	if (data->mipi_phy_rst_mask)
+		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
+
 	regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
 	regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
 
@@ -480,6 +497,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[]
 		.gpc_name = "mipi-dsi",
 		.rst_mask = BIT(5),
 		.clk_mask = BIT(8) | BIT(9),
+		.mipi_phy_rst_mask = BIT(17),
 	},
 	[IMX8MM_DISPBLK_PD_MIPI_CSI] = {
 		.name = "dispblk-mipi-csi",
@@ -488,6 +506,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[]
 		.gpc_name = "mipi-csi",
 		.rst_mask = BIT(3) | BIT(4),
 		.clk_mask = BIT(10) | BIT(11),
+		.mipi_phy_rst_mask = BIT(16),
 	},
 };
 
-- 
2.32.0

