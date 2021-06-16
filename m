Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99673AA6E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhFPWv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:51:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51864 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234301AbhFPWv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:51:57 -0400
X-UUID: 68c839ba69d643d6b9c0d2838546b575-20210617
X-UUID: 68c839ba69d643d6b9c0d2838546b575-20210617
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2146771954; Thu, 17 Jun 2021 06:49:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:49:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:49:45 +0800
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
Subject: [PATCH 08/22] clk: mediatek: Add MT8195 ccusys clock support
Date:   Thu, 17 Jun 2021 06:47:29 +0800
Message-ID: <20210616224743.5109-9-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 ccusys clock provider

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |  6 ++++
 drivers/clk/mediatek/Makefile         |  1 +
 drivers/clk/mediatek/clk-mt8195-ccu.c | 52 +++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-ccu.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 515155f3d185..6a6e496d08a4 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -606,6 +606,12 @@ config COMMON_CLK_MT8195_CAMSYS
 	help
 	  This driver supports MediaTek MT8195 camsys clocks.
 
+config COMMON_CLK_MT8195_CCUSYS
+	bool "Clock driver for MediaTek MT8195 ccusys"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 ccusys clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 421064e7418c..bb8aac6f9185 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -84,5 +84,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195.o
 obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS) += clk-mt8195-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS_SRC) += clk-mt8195-aud_src.o
 obj-$(CONFIG_COMMON_CLK_MT8195_CAMSYS) += clk-mt8195-cam.o
+obj-$(CONFIG_COMMON_CLK_MT8195_CCUSYS) += clk-mt8195-ccu.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-ccu.c b/drivers/clk/mediatek/clk-mt8195-ccu.c
new file mode 100644
index 000000000000..6d8c657bedb3
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-ccu.c
@@ -0,0 +1,52 @@
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
+static const struct mtk_gate_regs ccu_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CCU(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &ccu_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate ccu_clks[] = {
+	GATE_CCU(CLK_CCU_LARB18, "ccu_larb18", "ccu_sel", 0),
+	GATE_CCU(CLK_CCU_AHB, "ccu_ahb", "ccu_sel", 1),
+	GATE_CCU(CLK_CCU_CCU0, "ccu_ccu0", "ccu_sel", 2),
+	GATE_CCU(CLK_CCU_CCU1, "ccu_ccu1", "ccu_sel", 3),
+};
+
+static const struct mtk_clk_desc ccu_desc = {
+	.clks = ccu_clks,
+	.num_clks = ARRAY_SIZE(ccu_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_ccu[] = {
+	{
+		.compatible = "mediatek,mt8195-ccusys",
+		.data = &ccu_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_ccu_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-ccu",
+		.of_match_table = of_match_clk_mt8195_ccu,
+	},
+};
+
+builtin_platform_driver(clk_mt8195_ccu_drv);
-- 
2.18.0

