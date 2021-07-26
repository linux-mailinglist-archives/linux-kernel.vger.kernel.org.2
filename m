Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED03D580E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhGZKSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:18:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34764 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233130AbhGZKRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:17:48 -0400
X-UUID: 22fd93c580854b1ba24a0eb65ac5b3e7-20210726
X-UUID: 22fd93c580854b1ba24a0eb65ac5b3e7-20210726
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 192668974; Mon, 26 Jul 2021 18:58:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Jul 2021 18:58:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Jul 2021 18:58:13 +0800
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
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v14 13/21] clk: mediatek: Add MT8192 imp i2c wrapper clock support
Date:   Mon, 26 Jul 2021 18:57:11 +0800
Message-ID: <20210726105719.15793-14-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210726105719.15793-1-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8192 imp i2c wrapper clock provider

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig                  |   6 +
 drivers/clk/mediatek/Makefile                 |   1 +
 .../clk/mediatek/clk-mt8192-imp_iic_wrap.c    | 119 ++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 38011dccfe47..5becf049d9fa 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -526,6 +526,12 @@ config COMMON_CLK_MT8192_IMGSYS
 	help
 	  This driver supports MediaTek MT8192 imgsys and imgsys2 clocks.
 
+config COMMON_CLK_MT8192_IMP_IIC_WRAP
+	bool "Clock driver for MediaTek MT8192 imp_iic_wrap"
+	depends on COMMON_CLK_MT8192
+	help
+	  This driver supports MediaTek MT8192 imp_iic_wrap clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 91392cb333fd..37981626b775 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -71,5 +71,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
 obj-$(CONFIG_COMMON_CLK_MT8192_IMGSYS) += clk-mt8192-img.o
+obj-$(CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP) += clk-mt8192-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
new file mode 100644
index 000000000000..700356ac6a58
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2021 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include <linux/clk-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt8192-clk.h>
+
+static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
+	.set_ofs = 0xe08,
+	.clr_ofs = 0xe04,
+	.sta_ofs = 0xe00,
+};
+
+#define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)			\
+	GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
+
+static const struct mtk_gate imp_iic_wrap_c_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C10, "imp_iic_wrap_c_i2c10", "infra_i2c0", 0),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C11, "imp_iic_wrap_c_i2c11", "infra_i2c0", 1),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C12, "imp_iic_wrap_c_i2c12", "infra_i2c0", 2),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C13, "imp_iic_wrap_c_i2c13", "infra_i2c0", 3),
+};
+
+static const struct mtk_gate imp_iic_wrap_e_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_E_I2C3, "imp_iic_wrap_e_i2c3", "infra_i2c0", 0),
+};
+
+static const struct mtk_gate imp_iic_wrap_n_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_N_I2C0, "imp_iic_wrap_n_i2c0", "infra_i2c0", 0),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_N_I2C6, "imp_iic_wrap_n_i2c6", "infra_i2c0", 1),
+};
+
+static const struct mtk_gate imp_iic_wrap_s_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_S_I2C7, "imp_iic_wrap_s_i2c7", "infra_i2c0", 0),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_S_I2C8, "imp_iic_wrap_s_i2c8", "infra_i2c0", 1),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_S_I2C9, "imp_iic_wrap_s_i2c9", "infra_i2c0", 2),
+};
+
+static const struct mtk_gate imp_iic_wrap_w_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C5, "imp_iic_wrap_w_i2c5", "infra_i2c0", 0),
+};
+
+static const struct mtk_gate imp_iic_wrap_ws_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_WS_I2C1, "imp_iic_wrap_ws_i2c1", "infra_i2c0", 0),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_WS_I2C2, "imp_iic_wrap_ws_i2c2", "infra_i2c0", 1),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_WS_I2C4, "imp_iic_wrap_ws_i2c4", "infra_i2c0", 2),
+};
+
+static const struct mtk_clk_desc imp_iic_wrap_c_desc = {
+	.clks = imp_iic_wrap_c_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_c_clks),
+};
+
+static const struct mtk_clk_desc imp_iic_wrap_e_desc = {
+	.clks = imp_iic_wrap_e_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_e_clks),
+};
+
+static const struct mtk_clk_desc imp_iic_wrap_n_desc = {
+	.clks = imp_iic_wrap_n_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_n_clks),
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
+static const struct mtk_clk_desc imp_iic_wrap_ws_desc = {
+	.clks = imp_iic_wrap_ws_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_ws_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8192_imp_iic_wrap[] = {
+	{
+		.compatible = "mediatek,mt8192-imp_iic_wrap_c",
+		.data = &imp_iic_wrap_c_desc,
+	}, {
+		.compatible = "mediatek,mt8192-imp_iic_wrap_e",
+		.data = &imp_iic_wrap_e_desc,
+	}, {
+		.compatible = "mediatek,mt8192-imp_iic_wrap_n",
+		.data = &imp_iic_wrap_n_desc,
+	}, {
+		.compatible = "mediatek,mt8192-imp_iic_wrap_s",
+		.data = &imp_iic_wrap_s_desc,
+	}, {
+		.compatible = "mediatek,mt8192-imp_iic_wrap_w",
+		.data = &imp_iic_wrap_w_desc,
+	}, {
+		.compatible = "mediatek,mt8192-imp_iic_wrap_ws",
+		.data = &imp_iic_wrap_ws_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8192_imp_iic_wrap_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8192-imp_iic_wrap",
+		.of_match_table = of_match_clk_mt8192_imp_iic_wrap,
+	},
+};
+
+builtin_platform_driver(clk_mt8192_imp_iic_wrap_drv);
-- 
2.18.0

