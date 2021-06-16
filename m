Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE5E3AA70C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhFPWxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:53:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33980 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234407AbhFPWxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:53:06 -0400
X-UUID: db5004e2cc154c4b9b8db8fa1c6c1a80-20210617
X-UUID: db5004e2cc154c4b9b8db8fa1c6c1a80-20210617
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 55597283; Thu, 17 Jun 2021 06:50:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:50:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:50:55 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH 22/22] clk: mediatek: Add MT8195 apusys clock support
Date:   Thu, 17 Jun 2021 06:47:43 +0800
Message-ID: <20210616224743.5109-23-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 apusys clock provider

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig                 |  6 ++
 drivers/clk/mediatek/Makefile                |  1 +
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 84 ++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-apusys_pll.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index ade85a52b7ed..9bd1ebff61f2 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -690,6 +690,12 @@ config COMMON_CLK_MT8195_IMP_IIC_WRAP
 	help
 	  This driver supports MediaTek MT8195 imp_iic_wrap clocks.
 
+config COMMON_CLK_MT8195_APUSYS_PLL
+	bool "Clock driver for MediaTek MT8195 apusys_pll"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 apusys_pll clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index b10c6267ba98..676ed7d665b7 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -98,5 +98,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS0) += clk-mt8195-vpp0.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS1) += clk-mt8195-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8195_IMP_IIC_WRAP) += clk-mt8195-imp_iic_wrap.o
+obj-$(CONFIG_COMMON_CLK_MT8195_APUSYS_PLL) += clk-mt8195-apusys_pll.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
new file mode 100644
index 000000000000..d9b49cf71281
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2021 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt8195-clk.h>
+
+#define MT8195_PLL_FMAX		(3800UL * MHZ)
+#define MT8195_PLL_FMIN		(1500UL * MHZ)
+#define MT8195_INTEGER_BITS	8
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
+			_rst_bar_mask, _pcwbits, _pd_reg, _pd_shift,	\
+			_tuner_reg, _tuner_en_reg, _tuner_en_bit,	\
+			_pcw_reg, _pcw_shift, _pcw_chg_reg,				\
+			_en_reg, _pll_en_bit) {					\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.rst_bar_mask = _rst_bar_mask,				\
+		.fmax = MT8195_PLL_FMAX,				\
+		.fmin = MT8195_PLL_FMIN,				\
+		.pcwbits = _pcwbits,					\
+		.pcwibits = MT8195_INTEGER_BITS,			\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.tuner_en_reg = _tuner_en_reg,				\
+		.tuner_en_bit = _tuner_en_bit,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.pcw_chg_reg = _pcw_chg_reg,				\
+		.en_reg = _en_reg,					\
+		.pll_en_bit = _pll_en_bit,				\
+	}
+
+static const struct mtk_pll_data apusys_plls[] = {
+	PLL(CLK_APUSYS_PLL_APUPLL, "apusys_pll_apupll", 0x008, 0x014, 0,
+		0, 0, 22, 0x00c, 24, 0, 0, 0, 0x00c, 0, 0, 0, 0),
+	PLL(CLK_APUSYS_PLL_NPUPLL, "apusys_pll_npupll", 0x018, 0x024, 0,
+		0, 0, 22, 0x01c, 24, 0, 0, 0, 0x01c, 0, 0, 0, 0),
+	PLL(CLK_APUSYS_PLL_APUPLL1, "apusys_pll_apupll1", 0x028, 0x034, 0,
+		0, 0, 22, 0x02c, 24, 0, 0, 0, 0x02c, 0, 0, 0, 0),
+	PLL(CLK_APUSYS_PLL_APUPLL2, "apusys_pll_apupll2", 0x038, 0x044, 0,
+		0, 0, 22, 0x03c, 24, 0, 0, 0, 0x03c, 0, 0, 0, 0),
+};
+
+static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_APUSYS_PLL_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	mtk_clk_register_plls(node, apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
+	{ .compatible = "mediatek,mt8195-apusys_pll", },
+	{}
+};
+
+static struct platform_driver clk_mt8195_apusys_pll_drv = {
+	.probe = clk_mt8195_apusys_pll_probe,
+	.driver = {
+		.name = "clk-mt8195-apusys_pll",
+		.of_match_table = of_match_clk_mt8195_apusys_pll,
+	},
+};
+
+builtin_platform_driver(clk_mt8195_apusys_pll_drv);
-- 
2.18.0

