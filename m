Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6161B441A6D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhKALE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:04:56 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:49925 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhKALEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:04:45 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1A1AceLl037904;
        Mon, 1 Nov 2021 18:38:40 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Nov 2021 19:01:24 +0800
From:   tommy-huang <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 3/4]     drm/aspeed: Update INTR_STS handling
Date:   Mon, 1 Nov 2021 19:01:06 +0800
Message-ID: <20211101110107.29010-4-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211101110107.29010-1-tommy_huang@aspeedtech.com>
References: <20211101110107.29010-1-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1A1AceLl037904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    The V-sync INTR_STS is differnet on AST2600.
    Change into general rule to handle it.

Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx.h     |  2 ++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 26 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
index 96501152bafa..5eed9275bce7 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
@@ -12,6 +12,8 @@ struct aspeed_gfx {
 	struct regmap			*scu;
 
 	u32				dac_reg;
+	u32				int_reg;
+	u32				int_clr_reg;
 	u32				vga_scratch_reg;
 	u32				throd_val;
 	u32				scan_line_max;
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index b53fee6f1c17..1092060cb59c 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -60,6 +60,8 @@
 
 struct aspeed_gfx_config {
 	u32 dac_reg;		/* DAC register in SCU */
+	u32 int_status_reg;	/* Interrupt status register */
+	u32 int_clear_reg;	/* Interrupt clear register */
 	u32 vga_scratch_reg;	/* VGA scratch register in SCU */
 	u32 throd_val;		/* Default Threshold Seting */
 	u32 scan_line_max;	/* Max memory size of one scan line */
@@ -67,6 +69,8 @@ struct aspeed_gfx_config {
 
 static const struct aspeed_gfx_config ast2400_config = {
 	.dac_reg = 0x2c,
+	.int_status_reg = 0x60,
+	.int_clear_reg = 0x60,
 	.vga_scratch_reg = 0x50,
 	.throd_val = CRT_THROD_LOW(0x1e) | CRT_THROD_HIGH(0x12),
 	.scan_line_max = 64,
@@ -74,14 +78,26 @@ static const struct aspeed_gfx_config ast2400_config = {
 
 static const struct aspeed_gfx_config ast2500_config = {
 	.dac_reg = 0x2c,
+	.int_status_reg = 0x60,
+	.int_clear_reg = 0x60,
 	.vga_scratch_reg = 0x50,
 	.throd_val = CRT_THROD_LOW(0x24) | CRT_THROD_HIGH(0x3c),
 	.scan_line_max = 128,
 };
 
+static const struct aspeed_gfx_config ast2600_config = {
+	.dac_reg = 0xc0,
+	.int_status_reg = 0x60,
+	.int_clear_reg = 0x68,
+	.vga_scratch_reg = 0x50,
+	.throd_val = CRT_THROD_LOW(0x50) | CRT_THROD_HIGH(0x70),
+	.scan_line_max = 128,
+};
+
 static const struct of_device_id aspeed_gfx_match[] = {
 	{ .compatible = "aspeed,ast2400-gfx", .data = &ast2400_config },
 	{ .compatible = "aspeed,ast2500-gfx", .data = &ast2500_config },
+	{ .compatible = "aspeed,ast2600-gfx", .data = &ast2600_config },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_gfx_match);
@@ -113,13 +129,15 @@ static irqreturn_t aspeed_gfx_irq_handler(int irq, void *data)
 {
 	struct drm_device *drm = data;
 	struct aspeed_gfx *priv = to_aspeed_gfx(drm);
-	u32 reg;
+	u32 reg, clr_reg;
 
-	reg = readl(priv->base + CRT_CTRL1);
+	reg = readl(priv->base + priv->int_reg);
 
 	if (reg & CRT_CTRL_VERTICAL_INTR_STS) {
 		drm_crtc_handle_vblank(&priv->pipe.crtc);
-		writel(reg, priv->base + CRT_CTRL1);
+		clr_reg = (readl(priv->base + priv->int_clr_reg) |
+			CRT_CTRL_VERTICAL_INTR_STS);
+		writel(clr_reg, priv->base + priv->int_clr_reg);
 		return IRQ_HANDLED;
 	}
 
@@ -147,6 +165,8 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	config = match->data;
 
 	priv->dac_reg = config->dac_reg;
+	priv->int_reg = config->int_status_reg;
+	priv->int_clr_reg = config->int_clear_reg;
 	priv->vga_scratch_reg = config->vga_scratch_reg;
 	priv->throd_val = config->throd_val;
 	priv->scan_line_max = config->scan_line_max;
-- 
2.17.1

