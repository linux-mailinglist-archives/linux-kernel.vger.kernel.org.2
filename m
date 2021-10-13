Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B664242CDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhJMWRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:17:35 -0400
Received: from aposti.net ([89.234.176.197]:39994 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhJMWRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:17:33 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] clk: ingenic: Add MDMA and BDMA clocks
Date:   Wed, 13 Oct 2021 23:08:15 +0100
Message-Id: <20211013220815.38692-2-paul@crapouillou.net>
In-Reply-To: <20211013220815.38692-1-paul@crapouillou.net>
References: <20211013220815.38692-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ingenic JZ4760 and JZ4770 both have an extra DMA core named BDMA
dedicated to the NAND and BCH controller, but which can also do
memory-to-memory transfers. The JZ4760 additionally has a DMA core named
MDMA dedicated to memory-to-memory transfers. The programming manual for
the JZ4770 does have a bit for a MDMA clock, but does not seem to have
the hardware wired in.

Add the BDMA and MDMA clocks to the JZ4760 CGU code, and the BDMA clock
to the JZ4770 code, so that the BDMA and MDMA controllers can be used.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4760-cgu.c               | 10 ++++++++++
 drivers/clk/ingenic/jz4770-cgu.c               |  5 +++++
 include/dt-bindings/clock/ingenic,jz4760-cgu.h |  2 ++
 include/dt-bindings/clock/ingenic,jz4770-cgu.h |  1 +
 4 files changed, 18 insertions(+)

diff --git a/drivers/clk/ingenic/jz4760-cgu.c b/drivers/clk/ingenic/jz4760-cgu.c
index 080d492ac95c..8fdd383560fb 100644
--- a/drivers/clk/ingenic/jz4760-cgu.c
+++ b/drivers/clk/ingenic/jz4760-cgu.c
@@ -313,6 +313,16 @@ static const struct ingenic_cgu_clk_info jz4760_cgu_clocks[] = {
 		.parents = { JZ4760_CLK_H2CLK, },
 		.gate = { CGU_REG_CLKGR0, 21 },
 	},
+	[JZ4760_CLK_MDMA] = {
+		"mdma", CGU_CLK_GATE,
+		.parents = { JZ4760_CLK_HCLK, },
+		.gate = { CGU_REG_CLKGR0, 25 },
+	},
+	[JZ4760_CLK_BDMA] = {
+		"bdma", CGU_CLK_GATE,
+		.parents = { JZ4760_CLK_HCLK, },
+		.gate = { CGU_REG_CLKGR1, 0 },
+	},
 	[JZ4760_CLK_I2C0] = {
 		"i2c0", CGU_CLK_GATE,
 		.parents = { JZ4760_CLK_EXT, },
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 8c6c1208f462..7ef91257630e 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -329,6 +329,11 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 		.parents = { JZ4770_CLK_H2CLK, },
 		.gate = { CGU_REG_CLKGR0, 21 },
 	},
+	[JZ4770_CLK_BDMA] = {
+		"bdma", CGU_CLK_GATE,
+		.parents = { JZ4770_CLK_H2CLK, },
+		.gate = { CGU_REG_CLKGR1, 0 },
+	},
 	[JZ4770_CLK_I2C0] = {
 		"i2c0", CGU_CLK_GATE,
 		.parents = { JZ4770_CLK_EXT, },
diff --git a/include/dt-bindings/clock/ingenic,jz4760-cgu.h b/include/dt-bindings/clock/ingenic,jz4760-cgu.h
index 4bb2e19c4743..9fb04ebac6de 100644
--- a/include/dt-bindings/clock/ingenic,jz4760-cgu.h
+++ b/include/dt-bindings/clock/ingenic,jz4760-cgu.h
@@ -50,5 +50,7 @@
 #define JZ4760_CLK_LPCLK_DIV	41
 #define JZ4760_CLK_TVE		42
 #define JZ4760_CLK_LPCLK	43
+#define JZ4760_CLK_MDMA		44
+#define JZ4760_CLK_BDMA		45
 
 #endif /* __DT_BINDINGS_CLOCK_JZ4760_CGU_H__ */
diff --git a/include/dt-bindings/clock/ingenic,jz4770-cgu.h b/include/dt-bindings/clock/ingenic,jz4770-cgu.h
index d68a7695a1f8..0b475e8ae321 100644
--- a/include/dt-bindings/clock/ingenic,jz4770-cgu.h
+++ b/include/dt-bindings/clock/ingenic,jz4770-cgu.h
@@ -54,5 +54,6 @@
 #define JZ4770_CLK_OTG_PHY	45
 #define JZ4770_CLK_EXT512	46
 #define JZ4770_CLK_RTC		47
+#define JZ4770_CLK_BDMA		48
 
 #endif /* __DT_BINDINGS_CLOCK_JZ4770_CGU_H__ */
-- 
2.33.0

