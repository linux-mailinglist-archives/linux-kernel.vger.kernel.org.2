Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95363AA705
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhFPWxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:53:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52307 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234404AbhFPWwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:52:55 -0400
X-UUID: cda3cbfc50044fb2b04f180b20054228-20210617
X-UUID: cda3cbfc50044fb2b04f180b20054228-20210617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2120406543; Thu, 17 Jun 2021 06:50:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:50:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:50:44 +0800
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
Subject: [PATCH 20/22] clk: mediatek: Add MT8195 wpesys clock support
Date:   Thu, 17 Jun 2021 06:47:41 +0800
Message-ID: <20210616224743.5109-21-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 wpesys clock providers

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |   6 ++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8195-wpe.c | 145 ++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-wpe.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 91b1c19da1ab..5089bacdf0a5 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -678,6 +678,12 @@ config COMMON_CLK_MT8195_VPPSYS1
 	help
 	  This driver supports MediaTek MT8195 vppsys1 clocks.
 
+config COMMON_CLK_MT8195_WPESYS
+	bool "Clock driver for MediaTek MT8195 wpesys"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 wpesys clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index fbf57473bb91..32cfb0030d92 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -96,5 +96,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS1) += clk-mt8195-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS0) += clk-mt8195-vpp0.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS1) += clk-mt8195-vpp1.o
+obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-wpe.c b/drivers/clk/mediatek/clk-mt8195-wpe.c
new file mode 100644
index 000000000000..99e8b1297ef7
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-wpe.c
@@ -0,0 +1,145 @@
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
+static const struct mtk_gate_regs wpe_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs wpe_vpp0_cg_regs = {
+	.set_ofs = 0x58,
+	.clr_ofs = 0x58,
+	.sta_ofs = 0x58,
+};
+
+static const struct mtk_gate_regs wpe_vpp1_cg_regs = {
+	.set_ofs = 0x5c,
+	.clr_ofs = 0x5c,
+	.sta_ofs = 0x5c,
+};
+
+#define GATE_WPE(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &wpe_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_WPE_VPP0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &wpe_vpp0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_WPE_VPP1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &wpe_vpp1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+static const struct mtk_gate wpe_clks[] = {
+	GATE_WPE(CLK_WPE_VPP0, "wpe_vpp0", "wpe_vpp_sel", 16),
+	GATE_WPE(CLK_WPE_VPP1, "wpe_vpp1", "wpe_vpp_sel", 17),
+	GATE_WPE(CLK_WPE_SMI_LARB7, "wpe_smi_larb7", "wpe_vpp_sel", 18),
+	GATE_WPE(CLK_WPE_SMI_LARB8, "wpe_smi_larb8", "wpe_vpp_sel", 19),
+	GATE_WPE(CLK_WPE_EVENT_TX, "wpe_event_tx", "wpe_vpp_sel", 20),
+	GATE_WPE(CLK_WPE_SMI_LARB7_P, "wpe_smi_larb7_p", "wpe_vpp_sel", 24),
+	GATE_WPE(CLK_WPE_SMI_LARB8_P, "wpe_smi_larb8_p", "wpe_vpp_sel", 25),
+};
+
+static const struct mtk_gate wpe_vpp0_clks[] = {
+	/* WPE_VPP0 */
+	GATE_WPE_VPP0(CLK_WPE_VPP0_VGEN, "wpe_vpp0_vgen", "img_sel", 0),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_EXT, "wpe_vpp0_ext", "img_sel", 1),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_VFC, "wpe_vpp0_vfc", "img_sel", 2),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_CACH0_TOP, "wpe_vpp0_cach0_top", "img_sel", 3),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_CACH0_DMA, "wpe_vpp0_cach0_dma", "img_sel", 4),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_CACH1_TOP, "wpe_vpp0_cach1_top", "img_sel", 5),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_CACH1_DMA, "wpe_vpp0_cach1_dma", "img_sel", 6),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_CACH2_TOP, "wpe_vpp0_cach2_top", "img_sel", 7),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_CACH2_DMA, "wpe_vpp0_cach2_dma", "img_sel", 8),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_CACH3_TOP, "wpe_vpp0_cach3_top", "img_sel", 9),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_CACH3_DMA, "wpe_vpp0_cach3_dma", "img_sel", 10),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_PSP, "wpe_vpp0_psp", "img_sel", 11),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_PSP2, "wpe_vpp0_psp2", "img_sel", 12),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_SYNC, "wpe_vpp0_sync", "img_sel", 13),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_C24, "wpe_vpp0_c24", "img_sel", 14),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_MDP_CROP, "wpe_vpp0_mdp_crop", "img_sel", 15),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_ISP_CROP, "wpe_vpp0_isp_crop", "img_sel", 16),
+	GATE_WPE_VPP0(CLK_WPE_VPP0_TOP, "wpe_vpp0_top", "img_sel", 17),
+	/* WPE_VPP1 */
+	GATE_WPE_VPP1(CLK_WPE_VPP0_VECI, "wpe_vpp0_veci", "img_sel", 0),
+	GATE_WPE_VPP1(CLK_WPE_VPP0_VEC2I, "wpe_vpp0_vec2i", "img_sel", 1),
+	GATE_WPE_VPP1(CLK_WPE_VPP0_VEC3I, "wpe_vpp0_vec3i", "img_sel", 2),
+	GATE_WPE_VPP1(CLK_WPE_VPP0_WPEO, "wpe_vpp0_wpeo", "img_sel", 3),
+	GATE_WPE_VPP1(CLK_WPE_VPP0_MSKO, "wpe_vpp0_msko", "img_sel", 4),
+};
+
+static const struct mtk_gate wpe_vpp1_clks[] = {
+	/* WPE_VPP0 */
+	GATE_WPE_VPP0(CLK_WPE_VPP1_VGEN, "wpe_vpp1_vgen", "img_sel", 0),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_EXT, "wpe_vpp1_ext", "img_sel", 1),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_VFC, "wpe_vpp1_vfc", "img_sel", 2),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_CACH0_TOP, "wpe_vpp1_cach0_top", "img_sel", 3),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_CACH0_DMA, "wpe_vpp1_cach0_dma", "img_sel", 4),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_CACH1_TOP, "wpe_vpp1_cach1_top", "img_sel", 5),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_CACH1_DMA, "wpe_vpp1_cach1_dma", "img_sel", 6),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_CACH2_TOP, "wpe_vpp1_cach2_top", "img_sel", 7),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_CACH2_DMA, "wpe_vpp1_cach2_dma", "img_sel", 8),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_CACH3_TOP, "wpe_vpp1_cach3_top", "img_sel", 9),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_CACH3_DMA, "wpe_vpp1_cach3_dma", "img_sel", 10),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_PSP, "wpe_vpp1_psp", "img_sel", 11),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_PSP2, "wpe_vpp1_psp2", "img_sel", 12),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_SYNC, "wpe_vpp1_sync", "img_sel", 13),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_C24, "wpe_vpp1_c24", "img_sel", 14),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_MDP_CROP, "wpe_vpp1_mdp_crop", "img_sel", 15),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_ISP_CROP, "wpe_vpp1_isp_crop", "img_sel", 16),
+	GATE_WPE_VPP0(CLK_WPE_VPP1_TOP, "wpe_vpp1_top", "img_sel", 17),
+	/* WPE_VPP1 */
+	GATE_WPE_VPP1(CLK_WPE_VPP1_VECI, "wpe_vpp1_veci", "img_sel", 0),
+	GATE_WPE_VPP1(CLK_WPE_VPP1_VEC2I, "wpe_vpp1_vec2i", "img_sel", 1),
+	GATE_WPE_VPP1(CLK_WPE_VPP1_VEC3I, "wpe_vpp1_vec3i", "img_sel", 2),
+	GATE_WPE_VPP1(CLK_WPE_VPP1_WPEO, "wpe_vpp1_wpeo", "img_sel", 3),
+	GATE_WPE_VPP1(CLK_WPE_VPP1_MSKO, "wpe_vpp1_msko", "img_sel", 4),
+};
+
+static const struct mtk_clk_desc wpe_desc = {
+	.clks = wpe_clks,
+	.num_clks = ARRAY_SIZE(wpe_clks),
+};
+
+static const struct mtk_clk_desc wpe_vpp0_desc = {
+	.clks = wpe_vpp0_clks,
+	.num_clks = ARRAY_SIZE(wpe_vpp0_clks),
+};
+
+static const struct mtk_clk_desc wpe_vpp1_desc = {
+	.clks = wpe_vpp1_clks,
+	.num_clks = ARRAY_SIZE(wpe_vpp1_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_wpe[] = {
+	{
+		.compatible = "mediatek,mt8195-wpesys",
+		.data = &wpe_desc,
+	}, {
+		.compatible = "mediatek,mt8195-wpesys_vpp0",
+		.data = &wpe_vpp0_desc,
+	}, {
+		.compatible = "mediatek,mt8195-wpesys_vpp1",
+		.data = &wpe_vpp1_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_wpe_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-wpe",
+		.of_match_table = of_match_clk_mt8195_wpe,
+	},
+};
+
+builtin_platform_driver(clk_mt8195_wpe_drv);
-- 
2.18.0

