Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF53062BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbhA0Ryr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:54:47 -0500
Received: from foss.arm.com ([217.140.110.172]:56888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343628AbhA0R1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:27:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A0B91424;
        Wed, 27 Jan 2021 09:26:07 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BA433F66E;
        Wed, 27 Jan 2021 09:26:04 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v5 08/20] soc: sunxi: sram: Add support for more than one EMAC clock
Date:   Wed, 27 Jan 2021 17:24:48 +0000
Message-Id: <20210127172500.13356-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210127172500.13356-1-andre.przywara@arm.com>
References: <20210127172500.13356-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H616 adds a second EMAC clock register at offset 0x34, for
controlling the second EMAC in this chip.

Allow to extend the regmap in this case, to cover more than the current
4 bytes exported.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index d4c7bd59429e..42833e33a96c 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -283,7 +283,7 @@ int sunxi_sram_release(struct device *dev)
 EXPORT_SYMBOL(sunxi_sram_release);
 
 struct sunxi_sramc_variant {
-	bool has_emac_clock;
+	int num_emac_clocks;
 };
 
 static const struct sunxi_sramc_variant sun4i_a10_sramc_variant = {
@@ -291,20 +291,31 @@ static const struct sunxi_sramc_variant sun4i_a10_sramc_variant = {
 };
 
 static const struct sunxi_sramc_variant sun8i_h3_sramc_variant = {
-	.has_emac_clock = true,
+	.num_emac_clocks = 1,
 };
 
 static const struct sunxi_sramc_variant sun50i_a64_sramc_variant = {
-	.has_emac_clock = true,
+	.num_emac_clocks = 1,
+};
+
+static const struct sunxi_sramc_variant sun50i_h616_sramc_variant = {
+	.num_emac_clocks = 2,
 };
 
 #define SUNXI_SRAM_EMAC_CLOCK_REG	0x30
 static bool sunxi_sram_regmap_accessible_reg(struct device *dev,
 					     unsigned int reg)
 {
-	if (reg == SUNXI_SRAM_EMAC_CLOCK_REG)
-		return true;
-	return false;
+	const struct sunxi_sramc_variant *variant;
+
+	variant = of_device_get_match_data(dev);
+
+	if (reg < SUNXI_SRAM_EMAC_CLOCK_REG)
+		return false;
+	if (reg > SUNXI_SRAM_EMAC_CLOCK_REG + variant->num_emac_clocks * 4)
+		return false;
+
+	return true;
 }
 
 static struct regmap_config sunxi_sram_emac_clock_regmap = {
@@ -312,7 +323,7 @@ static struct regmap_config sunxi_sram_emac_clock_regmap = {
 	.val_bits       = 32,
 	.reg_stride     = 4,
 	/* last defined register */
-	.max_register   = SUNXI_SRAM_EMAC_CLOCK_REG,
+	.max_register   = SUNXI_SRAM_EMAC_CLOCK_REG + 4,
 	/* other devices have no business accessing other registers */
 	.readable_reg	= sunxi_sram_regmap_accessible_reg,
 	.writeable_reg	= sunxi_sram_regmap_accessible_reg,
@@ -343,7 +354,7 @@ static int sunxi_sram_probe(struct platform_device *pdev)
 	if (!d)
 		return -ENOMEM;
 
-	if (variant->has_emac_clock) {
+	if (variant->num_emac_clocks > 0) {
 		emac_clock = devm_regmap_init_mmio(&pdev->dev, base,
 						   &sunxi_sram_emac_clock_regmap);
 
@@ -387,6 +398,10 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 		.compatible = "allwinner,sun50i-h5-system-control",
 		.data = &sun50i_a64_sramc_variant,
 	},
+	{
+		.compatible = "allwinner,sun50i-h616-system-control",
+		.data = &sun50i_h616_sramc_variant,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
-- 
2.17.5

