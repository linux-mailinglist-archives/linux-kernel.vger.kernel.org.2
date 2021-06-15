Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7899B3A7CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFOLKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:10:22 -0400
Received: from foss.arm.com ([217.140.110.172]:60548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhFOLJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:09:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D2581476;
        Tue, 15 Jun 2021 04:07:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 469393F719;
        Tue, 15 Jun 2021 04:07:31 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v7 14/19] phy: sun4i-usb: Introduce port2 SIDDQ quirk
Date:   Tue, 15 Jun 2021 12:06:31 +0100
Message-Id: <20210615110636.23403-15-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210615110636.23403-1-andre.przywara@arm.com>
References: <20210615110636.23403-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least the Allwinner H616 SoC requires a weird quirk to make most
USB PHYs work: Only port2 works out of the box, but all other ports
need some help from this port2 to work correctly: The CLK_BUS_PHY2 and
RST_USB_PHY2 clock and reset need to be enabled, and the SIDDQ bit in
the PMU PHY control register needs to be cleared. For this register to
be accessible, CLK_BUS_ECHI2 needs to be ungated. Don't ask ....

Instead of disguising this as some generic feature, do exactly that
in our PHY init:
If the quirk bit is set, and we initialise a PHY other than PHY2, ungate
this one special clock, and clear the SIDDQ bit. We can pull in the
other required clocks via the DT.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 126ef74d013c..316ef5fca831 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -120,6 +120,7 @@ struct sun4i_usb_phy_cfg {
 	u8 phyctl_offset;
 	bool dedicated_clocks;
 	bool phy0_dual_route;
+	bool needs_phy2_siddq;
 	int missing_phys;
 };
 
@@ -289,6 +290,50 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		return ret;
 	}
 
+	/* Some PHYs on some SoCs need the help of PHY2 to work. */
+	if (data->cfg->needs_phy2_siddq && phy->index != 2) {
+		struct sun4i_usb_phy *phy2 = &data->phys[2];
+
+		ret = clk_prepare_enable(phy2->clk);
+		if (ret) {
+			reset_control_assert(phy->reset);
+			clk_disable_unprepare(phy->clk2);
+			clk_disable_unprepare(phy->clk);
+			return ret;
+		}
+
+		ret = reset_control_deassert(phy2->reset);
+		if (ret) {
+			clk_disable_unprepare(phy2->clk);
+			reset_control_assert(phy->reset);
+			clk_disable_unprepare(phy->clk2);
+			clk_disable_unprepare(phy->clk);
+			return ret;
+		}
+
+		/*
+		 * This extra clock is just needed to access the
+		 * REG_HCI_PHY_CTL PMU register for PHY2.
+		 */
+		ret = clk_prepare_enable(phy2->clk2);
+		if (ret) {
+			reset_control_assert(phy2->reset);
+			clk_disable_unprepare(phy2->clk);
+			reset_control_assert(phy->reset);
+			clk_disable_unprepare(phy->clk2);
+			clk_disable_unprepare(phy->clk);
+			return ret;
+		}
+
+		if (phy2->pmu && data->cfg->hci_phy_ctl_clear) {
+			val = readl(phy2->pmu + REG_HCI_PHY_CTL);
+			val &= ~data->cfg->hci_phy_ctl_clear;
+			writel(val, phy2->pmu + REG_HCI_PHY_CTL);
+		}
+
+		clk_disable_unprepare(phy->clk2);
+	}
+
 	if (phy->pmu && data->cfg->hci_phy_ctl_clear) {
 		val = readl(phy->pmu + REG_HCI_PHY_CTL);
 		val &= ~data->cfg->hci_phy_ctl_clear;
@@ -354,6 +399,13 @@ static int sun4i_usb_phy_exit(struct phy *_phy)
 		data->phy0_init = false;
 	}
 
+	if (data->cfg->needs_phy2_siddq && phy->index != 2) {
+		struct sun4i_usb_phy *phy2 = &data->phys[2];
+
+		clk_disable_unprepare(phy2->clk);
+		reset_control_assert(phy2->reset);
+	}
+
 	sun4i_usb_phy_passby(phy, 0);
 	reset_control_assert(phy->reset);
 	clk_disable_unprepare(phy->clk2);
@@ -785,6 +837,13 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 				dev_err(dev, "failed to get clock %s\n", name);
 				return PTR_ERR(phy->clk2);
 			}
+		} else {
+			snprintf(name, sizeof(name), "pmu%d_clk", i);
+			phy->clk2 = devm_clk_get_optional(dev, name);
+			if (IS_ERR(phy->clk2)) {
+				dev_err(dev, "failed to get clock %s\n", name);
+				return PTR_ERR(phy->clk2);
+			}
 		}
 
 		snprintf(name, sizeof(name), "usb%d_reset", i);
-- 
2.17.5

