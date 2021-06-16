Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C63AA6EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhFPWw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:52:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52055 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234362AbhFPWwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:52:23 -0400
X-UUID: b97bc7064b9443b4abb92a51a4cf299a-20210617
X-UUID: b97bc7064b9443b4abb92a51a4cf299a-20210617
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 567623272; Thu, 17 Jun 2021 06:50:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:50:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:50:10 +0800
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
Subject: [PATCH 13/22] clk: mediatek: Add MT8195 nnasys clock support
Date:   Thu, 17 Jun 2021 06:47:34 +0800
Message-ID: <20210616224743.5109-14-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 nnasys clock provider

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |   6 ++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8195-nna.c | 128 ++++++++++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-nna.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 7cb745d47770..d34517728f4a 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -636,6 +636,12 @@ config COMMON_CLK_MT8195_SCP_ADSP
 	help
 	  This driver supports MediaTek MT8195 scp_adsp clocks.
 
+config COMMON_CLK_MT8195_NNASYS
+	bool "Clock driver for MediaTek MT8195 nnasys"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 nnasys clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 058ff55468a2..49e585a7ac8e 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -89,5 +89,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_IMGSYS) += clk-mt8195-img.o
 obj-$(CONFIG_COMMON_CLK_MT8195_IPESYS) += clk-mt8195-ipe.o
 obj-$(CONFIG_COMMON_CLK_MT8195_MFGCFG) += clk-mt8195-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8195_SCP_ADSP) += clk-mt8195-scp_adsp.o
+obj-$(CONFIG_COMMON_CLK_MT8195_NNASYS) += clk-mt8195-nna.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-nna.c b/drivers/clk/mediatek/clk-mt8195-nna.c
new file mode 100644
index 000000000000..4210c6cf5ef4
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-nna.c
@@ -0,0 +1,128 @@
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
+static const struct mtk_gate_regs nna0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x104,
+	.sta_ofs = 0x104,
+};
+
+static const struct mtk_gate_regs nna1_cg_regs = {
+	.set_ofs = 0x110,
+	.clr_ofs = 0x110,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs nna2_cg_regs = {
+	.set_ofs = 0x90,
+	.clr_ofs = 0x90,
+	.sta_ofs = 0x90,
+};
+
+static const struct mtk_gate_regs nna3_cg_regs = {
+	.set_ofs = 0x94,
+	.clr_ofs = 0x94,
+	.sta_ofs = 0x94,
+};
+
+static const struct mtk_gate_regs nna4_cg_regs = {
+	.set_ofs = 0x98,
+	.clr_ofs = 0x98,
+	.sta_ofs = 0x98,
+};
+
+static const struct mtk_gate_regs nna5_cg_regs = {
+	.set_ofs = 0x9c,
+	.clr_ofs = 0x9c,
+	.sta_ofs = 0x9c,
+};
+
+static const struct mtk_gate_regs nna6_cg_regs = {
+	.set_ofs = 0xa0,
+	.clr_ofs = 0xa0,
+	.sta_ofs = 0xa0,
+};
+
+static const struct mtk_gate_regs nna7_cg_regs = {
+	.set_ofs = 0xa4,
+	.clr_ofs = 0xa4,
+	.sta_ofs = 0xa4,
+};
+
+#define GATE_NNA0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &nna0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_NNA1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &nna1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_NNA2(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &nna2_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_NNA3(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &nna3_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_NNA4(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &nna4_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_NNA5(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &nna5_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_NNA6(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &nna6_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_NNA7(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &nna7_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+static const struct mtk_gate nna_clks[] = {
+	/* NNA0 */
+	GATE_NNA0(CLK_NNA_F26M, "nna_f26m", "clk26m", 0),
+	/* NNA1 */
+	GATE_NNA1(CLK_NNA_AXI, "nna_axi", "axi_sel", 0),
+	/* NNA2 */
+	GATE_NNA2(CLK_NNA_NNA0, "nna_nna0", "nna0_sel", 0),
+	/* NNA3 */
+	GATE_NNA3(CLK_NNA_NNA1, "nna_nna1", "nna0_sel", 0),
+	/* NNA4 */
+	GATE_NNA4(CLK_NNA_NNA0_EMI, "nna_nna0_emi", "mem_466m", 0),
+	GATE_NNA4(CLK_NNA_CKGEN_MEM, "nna_ckgen_mem", "mem_466m", 4),
+	/* NNA5 */
+	GATE_NNA5(CLK_NNA_NNA1_EMI, "nna_nna1_emi", "mem_466m", 0),
+	/* NNA6 */
+	GATE_NNA6(CLK_NNA_NNA0_AXI, "nna_nna0_axi", "axi_sel", 0),
+	/* NNA7 */
+	GATE_NNA7(CLK_NNA_NNA1_AXI, "nna_nna1_axi", "axi_sel", 0),
+};
+
+static const struct mtk_clk_desc nna_desc = {
+	.clks = nna_clks,
+	.num_clks = ARRAY_SIZE(nna_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_nna[] = {
+	{
+		.compatible = "mediatek,mt8195-nnasys",
+		.data = &nna_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_nna_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-nna",
+		.of_match_table = of_match_clk_mt8195_nna,
+	},
+};
+
+builtin_platform_driver(clk_mt8195_nna_drv);
-- 
2.18.0

