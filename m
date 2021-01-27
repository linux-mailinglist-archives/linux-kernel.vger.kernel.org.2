Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA930620F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbhA0Rbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:31:55 -0500
Received: from foss.arm.com ([217.140.110.172]:57012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235791AbhA0R3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:29:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43DA814FF;
        Wed, 27 Jan 2021 09:26:29 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3893F66E;
        Wed, 27 Jan 2021 09:26:27 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 17/20] phy: sun4i-usb: Rework HCI PHY (aka. "pmu_unk1") handling
Date:   Wed, 27 Jan 2021 17:24:57 +0000
Message-Id: <20210127172500.13356-18-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210127172500.13356-1-andre.przywara@arm.com>
References: <20210127172500.13356-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Icenowy pointed out, newer manuals (starting with H6) actually
document the register block at offset 0x800 as "HCI controller and PHY
interface", also describe the bits in our "PMU_UNK1" register.
Let's put proper names to those "unknown" variables and symbols.

While we are at it, generalise the existing code by allowing a bitmap
of bits to clear, to cover newer SoCs: The A100 and H616 use a different
bit for the SIDDQ control.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 29 +++++++++++----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 788dd5cdbb7d..539209fe3468 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -43,7 +43,7 @@
 #define REG_PHYCTL_A33			0x10
 #define REG_PHY_OTGCTL			0x20
 
-#define REG_PMU_UNK1			0x10
+#define REG_HCI_PHY_CTL			0x10
 
 #define PHYCTL_DATA			BIT(7)
 
@@ -115,9 +115,9 @@ struct sun4i_usb_phy_cfg {
 	int hsic_index;
 	enum sun4i_usb_phy_type type;
 	u32 disc_thresh;
+	u32 hci_phy_ctl_siddq;
 	u8 phyctl_offset;
 	bool dedicated_clocks;
-	bool enable_pmu_unk1;
 	bool phy0_dual_route;
 	int missing_phys;
 };
@@ -288,6 +288,12 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		return ret;
 	}
 
+	if (phy->pmu && data->cfg->hci_phy_ctl_siddq) {
+		val = readl(phy->pmu + REG_HCI_PHY_CTL);
+		val &= ~data->cfg->hci_phy_ctl_siddq;
+		writel(val, phy->pmu + REG_HCI_PHY_CTL);
+	}
+
 	if (data->cfg->type == sun8i_a83t_phy ||
 	    data->cfg->type == sun50i_h6_phy) {
 		if (phy->index == 0) {
@@ -297,11 +303,6 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 			writel(val, data->base + data->cfg->phyctl_offset);
 		}
 	} else {
-		if (phy->pmu && data->cfg->enable_pmu_unk1) {
-			val = readl(phy->pmu + REG_PMU_UNK1);
-			writel(val & ~2, phy->pmu + REG_PMU_UNK1);
-		}
-
 		/* Enable USB 45 Ohm resistor calibration */
 		if (phy->index == 0)
 			sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
@@ -863,7 +864,6 @@ static const struct sun4i_usb_phy_cfg sun4i_a10_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
@@ -872,7 +872,6 @@ static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
 	.disc_thresh = 2,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
@@ -881,7 +880,6 @@ static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
@@ -890,7 +888,6 @@ static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
 	.disc_thresh = 2,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
@@ -899,7 +896,6 @@ static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
@@ -908,7 +904,6 @@ static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_a83t_cfg = {
@@ -925,7 +920,7 @@ static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = true,
+	.hci_phy_ctl_siddq = BIT(1),
 	.phy0_dual_route = true,
 };
 
@@ -935,7 +930,7 @@ static const struct sun4i_usb_phy_cfg sun8i_r40_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = true,
+	.hci_phy_ctl_siddq = BIT(1),
 	.phy0_dual_route = true,
 };
 
@@ -945,7 +940,7 @@ static const struct sun4i_usb_phy_cfg sun8i_v3s_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = true,
+	.hci_phy_ctl_siddq = BIT(1),
 	.phy0_dual_route = true,
 };
 
@@ -955,7 +950,7 @@ static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = true,
+	.hci_phy_ctl_siddq = BIT(1),
 	.phy0_dual_route = true,
 };
 
-- 
2.17.5

