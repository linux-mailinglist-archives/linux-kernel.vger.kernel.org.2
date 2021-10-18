Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FFE43130D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhJRJRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:17:12 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16906 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJRJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634548483; x=1666084483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+GOBKGZE8qV030U5WlyM99ORTXZIFIqw7hbODktZ6b4=;
  b=Ro57GLv7L4mUQKs1cTKdiwBRY7vEEA53PEtSYXor0bKkxTJ08M5qg9R7
   qZHCixjmRO10rHTen+ccR3bIYSbD2k++3ycg6Bw7dFhk+OPgm4B11hFdi
   oofF4jr/RZpoY3kPsN3nWHwCcONMTG/WXQiVghmDEcnKOeAC/W7v8hLZn
   CsGJgfWnz6BQlv29x/KLQyYniZoqqb/vCYOD+8WGOGConDceqvJe1Ljwe
   7V5DEwjJyDCV0g2360XnN/EELCC/B7o9lAjHO29l8ey9fsI/z1cQ43hCg
   X4fqsoEK3hWZ28JNAGP0jfaPk8fUMDo4nMwN868MFmnI85NZBxlVE3sNZ
   g==;
IronPort-SDR: JqDL+hl7PNWSAe1qF7MA55FkX+1IvFQ5Tz2mDf89jfsEIERx6uVpRIwBVeP4rWCECyUF+D3OKk
 NGEYwzXyWdqu3dZ86RxWkDMX99kDYwV1U4MgEoYFCIkERoKH6wa5cghOmIAQaaOTvOHgoOEn9S
 7D1sUEKcuyKL67w91MCj1Po4JvXPDrxBgQ+7VAApu0XAjem0lG+l4tob1lpk8SfwDDfHE2RVbf
 yfPGkE9yFKLw1FB5XoiIKXg05Jjuy1Fnj+xWo/acd7hI4plalhqQUVectVaqy2Nkji1qAcfViC
 yVwQkL12XXUrilyf3cxqDfqq
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="133411118"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2021 02:14:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 02:14:42 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 18 Oct 2021 02:14:40 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 2/2] reset: mchp: sparx5: Extend support for lan966x
Date:   Mon, 18 Oct 2021 11:15:22 +0200
Message-ID: <20211018091522.1113510-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018091522.1113510-1-horatiu.vultur@microchip.com>
References: <20211018091522.1113510-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends sparx5 driver to support also the lan966x. The
process to reset the switch is the same only it has different offsets.
Therefore make the driver more generic and add support for lan966x.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/reset/Kconfig                  |  2 +-
 drivers/reset/reset-microchip-sparx5.c | 40 ++++++++++++++++++++------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index be799a5abf8a..36ce6c8bcf1e 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -116,7 +116,7 @@ config RESET_LPC18XX
 
 config RESET_MCHP_SPARX5
 	bool "Microchip Sparx5 reset driver"
-	depends on ARCH_SPARX5 || COMPILE_TEST
+	depends on ARCH_SPARX5 || SOC_LAN966 || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
 	help
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index f01e7db8e83b..00b612a0effa 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -13,15 +13,18 @@
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
-#define PROTECT_REG    0x84
-#define PROTECT_BIT    BIT(10)
-#define SOFT_RESET_REG 0x00
-#define SOFT_RESET_BIT BIT(1)
+struct reset_props {
+	u32 protect_reg;
+	u32 protect_bit;
+	u32 reset_reg;
+	u32 reset_bit;
+};
 
 struct mchp_reset_context {
 	struct regmap *cpu_ctrl;
 	struct regmap *gcb_ctrl;
 	struct reset_controller_dev rcdev;
+	const struct reset_props *props;
 };
 
 static struct regmap_config sparx5_reset_regmap_config = {
@@ -38,14 +41,16 @@ static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
 	u32 val;
 
 	/* Make sure the core is PROTECTED from reset */
-	regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT, PROTECT_BIT);
+	regmap_update_bits(ctx->cpu_ctrl, ctx->props->protect_reg,
+			   ctx->props->protect_bit, ctx->props->protect_bit);
 
 	/* Start soft reset */
-	regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
+	regmap_write(ctx->gcb_ctrl, ctx->props->reset_reg,
+		     ctx->props->reset_bit);
 
 	/* Wait for soft reset done */
-	return regmap_read_poll_timeout(ctx->gcb_ctrl, SOFT_RESET_REG, val,
-					(val & SOFT_RESET_BIT) == 0,
+	return regmap_read_poll_timeout(ctx->gcb_ctrl, ctx->props->reset_reg, val,
+					(val & ctx->props->reset_bit) == 0,
 					1, 100);
 }
 
@@ -115,13 +120,32 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
 	ctx->rcdev.nr_resets = 1;
 	ctx->rcdev.ops = &sparx5_reset_ops;
 	ctx->rcdev.of_node = dn;
+	ctx->props = device_get_match_data(&pdev->dev);
 
 	return devm_reset_controller_register(&pdev->dev, &ctx->rcdev);
 }
 
+static const struct reset_props reset_props_sparx5 = {
+	.protect_reg    = 0x84,
+	.protect_bit    = BIT(10),
+	.reset_reg      = 0x0,
+	.reset_bit      = BIT(1),
+};
+
+static const struct reset_props reset_props_lan966x = {
+	.protect_reg    = 0x88,
+	.protect_bit    = BIT(5),
+	.reset_reg      = 0x0,
+	.reset_bit      = BIT(1),
+};
+
 static const struct of_device_id mchp_sparx5_reset_of_match[] = {
 	{
 		.compatible = "microchip,sparx5-switch-reset",
+		.data = &reset_props_sparx5,
+	}, {
+		.compatible = "microchip,lan966x-switch-reset",
+		.data = &reset_props_lan966x,
 	},
 	{ }
 };
-- 
2.33.0

