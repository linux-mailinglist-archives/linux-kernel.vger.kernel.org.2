Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E813AA6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhFPWwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:52:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51927 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234323AbhFPWwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:52:06 -0400
X-UUID: d68062027c904beb959d769a2dda99bb-20210617
X-UUID: d68062027c904beb959d769a2dda99bb-20210617
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1614609257; Thu, 17 Jun 2021 06:49:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:49:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:49:54 +0800
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
Subject: [PATCH 10/22] clk: mediatek: Add MT8195 ipesys clock support
Date:   Thu, 17 Jun 2021 06:47:31 +0800
Message-ID: <20210616224743.5109-11-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 ipesys clock provider

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |  6 +++
 drivers/clk/mediatek/Makefile         |  1 +
 drivers/clk/mediatek/clk-mt8195-ipe.c | 53 +++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-ipe.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index f92d0b6b7eec..ef7d4b433eee 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -618,6 +618,12 @@ config COMMON_CLK_MT8195_IMGSYS
 	help
 	  This driver supports MediaTek MT8195 imgsys clocks.
 
+config COMMON_CLK_MT8195_IPESYS
+	bool "Clock driver for MediaTek MT8195 ipesys"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 ipesys clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 1768eda917c2..991a9be7ac46 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -86,5 +86,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS_SRC) += clk-mt8195-aud_src.o
 obj-$(CONFIG_COMMON_CLK_MT8195_CAMSYS) += clk-mt8195-cam.o
 obj-$(CONFIG_COMMON_CLK_MT8195_CCUSYS) += clk-mt8195-ccu.o
 obj-$(CONFIG_COMMON_CLK_MT8195_IMGSYS) += clk-mt8195-img.o
+obj-$(CONFIG_COMMON_CLK_MT8195_IPESYS) += clk-mt8195-ipe.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-ipe.c b/drivers/clk/mediatek/clk-mt8195-ipe.c
new file mode 100644
index 000000000000..d63d7448591a
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-ipe.c
@@ -0,0 +1,53 @@
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
+static const struct mtk_gate_regs ipe_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IPE(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &ipe_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate ipe_clks[] = {
+	GATE_IPE(CLK_IPE_DPE, "ipe_dpe", "ipe_sel", 0),
+	GATE_IPE(CLK_IPE_FDVT, "ipe_fdvt", "ipe_sel", 1),
+	GATE_IPE(CLK_IPE_ME, "ipe_me", "ipe_sel", 2),
+	GATE_IPE(CLK_IPE_TOP, "ipe_top", "ipe_sel", 3),
+	GATE_IPE(CLK_IPE_SMI_LARB12, "ipe_smi_larb12", "ipe_sel", 4),
+};
+
+static const struct mtk_clk_desc ipe_desc = {
+	.clks = ipe_clks,
+	.num_clks = ARRAY_SIZE(ipe_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_ipe[] = {
+	{
+		.compatible = "mediatek,mt8195-ipesys",
+		.data = &ipe_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_ipe_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-ipe",
+		.of_match_table = of_match_clk_mt8195_ipe,
+	},
+};
+
+builtin_platform_driver(clk_mt8195_ipe_drv);
-- 
2.18.0

