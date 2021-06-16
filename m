Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BD73AA708
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhFPWxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:53:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52353 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232134AbhFPWxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:53:02 -0400
X-UUID: 3c24d075f5574958b48fe6caaa9a7fe2-20210617
X-UUID: 3c24d075f5574958b48fe6caaa9a7fe2-20210617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 821707259; Thu, 17 Jun 2021 06:50:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:50:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:50:49 +0800
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
Subject: [PATCH 21/22] clk: mediatek: Add MT8195 imp i2c wrapper clock support
Date:   Thu, 17 Jun 2021 06:47:42 +0800
Message-ID: <20210616224743.5109-22-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 imp i2c wrapper clock providers

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig                  |  6 ++
 drivers/clk/mediatek/Makefile                 |  1 +
 .../clk/mediatek/clk-mt8195-imp_iic_wrap.c    | 68 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 5089bacdf0a5..ade85a52b7ed 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -684,6 +684,12 @@ config COMMON_CLK_MT8195_WPESYS
 	help
 	  This driver supports MediaTek MT8195 wpesys clocks.
 
+config COMMON_CLK_MT8195_IMP_IIC_WRAP
+	bool "Clock driver for MediaTek MT8195 imp_iic_wrap"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 imp_iic_wrap clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 32cfb0030d92..b10c6267ba98 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -97,5 +97,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS0) += clk-mt8195-vpp0.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS1) += clk-mt8195-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
+obj-$(CONFIG_COMMON_CLK_MT8195_IMP_IIC_WRAP) += clk-mt8195-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
new file mode 100644
index 000000000000..efb62f484bbe
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -0,0 +1,68 @@
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
+static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
+	.set_ofs = 0xe08,
+	.clr_ofs = 0xe04,
+	.sta_ofs = 0xe00,
+};
+
+#define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
+
+static const struct mtk_gate imp_iic_wrap_s_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_S_I2C5, "imp_iic_wrap_s_i2c5", "i2c_sel", 0),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_S_I2C6, "imp_iic_wrap_s_i2c6", "i2c_sel", 1),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_S_I2C7, "imp_iic_wrap_s_i2c7", "i2c_sel", 2),
+};
+
+static const struct mtk_gate imp_iic_wrap_w_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C0, "imp_iic_wrap_w_i2c0", "i2c_sel", 0),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C1, "imp_iic_wrap_w_i2c1", "i2c_sel", 1),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C2, "imp_iic_wrap_w_i2c2", "i2c_sel", 2),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C3, "imp_iic_wrap_w_i2c3", "i2c_sel", 3),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C4, "imp_iic_wrap_w_i2c4", "i2c_sel", 4),
+};
+
+static const struct mtk_clk_desc imp_iic_wrap_s_desc = {
+	.clks = imp_iic_wrap_s_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_s_clks),
+};
+
+static const struct mtk_clk_desc imp_iic_wrap_w_desc = {
+	.clks = imp_iic_wrap_w_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_w_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_imp_iic_wrap[] = {
+	{
+		.compatible = "mediatek,mt8195-imp_iic_wrap_s",
+		.data = &imp_iic_wrap_s_desc,
+	}, {
+		.compatible = "mediatek,mt8195-imp_iic_wrap_w",
+		.data = &imp_iic_wrap_w_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_imp_iic_wrap_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-imp_iic_wrap",
+		.of_match_table = of_match_clk_mt8195_imp_iic_wrap,
+	},
+};
+
+builtin_platform_driver(clk_mt8195_imp_iic_wrap_drv);
-- 
2.18.0

