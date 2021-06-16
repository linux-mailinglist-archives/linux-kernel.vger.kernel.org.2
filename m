Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0173AA6FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhFPWwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:52:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52153 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234380AbhFPWwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:52:37 -0400
X-UUID: e788d9279fbf494ab5aae9abd019d810-20210617
X-UUID: e788d9279fbf494ab5aae9abd019d810-20210617
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 467241417; Thu, 17 Jun 2021 06:50:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:50:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:50:24 +0800
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
Subject: [PATCH 16/22] clk: mediatek: Add MT8195 vdosys1 clock support
Date:   Thu, 17 Jun 2021 06:47:37 +0800
Message-ID: <20210616224743.5109-17-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 vdosys1 clock provider

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig           |   6 ++
 drivers/clk/mediatek/Makefile          |   1 +
 drivers/clk/mediatek/clk-mt8195-vdo1.c | 131 +++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdo1.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 6602f9ba13c7..1e89c68f6c6c 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -654,6 +654,12 @@ config COMMON_CLK_MT8195_VDOSYS0
 	help
 	  This driver supports MediaTek MT8195 vdosys0 clocks.
 
+config COMMON_CLK_MT8195_VDOSYS1
+	bool "Clock driver for MediaTek MT8195 vdosys1"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 vdosys1 clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 6aa1ba00342a..76c0fa837cb0 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -92,5 +92,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_SCP_ADSP) += clk-mt8195-scp_adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8195_NNASYS) += clk-mt8195-nna.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VDECSYS) += clk-mt8195-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS0) += clk-mt8195-vdo0.o
+obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS1) += clk-mt8195-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
new file mode 100644
index 000000000000..4d16f2e9c03a
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -0,0 +1,131 @@
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
+static const struct mtk_gate_regs vdo10_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs vdo11_cg_regs = {
+	.set_ofs = 0x124,
+	.clr_ofs = 0x128,
+	.sta_ofs = 0x120,
+};
+
+static const struct mtk_gate_regs vdo12_cg_regs = {
+	.set_ofs = 0x134,
+	.clr_ofs = 0x138,
+	.sta_ofs = 0x130,
+};
+
+static const struct mtk_gate_regs vdo13_cg_regs = {
+	.set_ofs = 0x144,
+	.clr_ofs = 0x148,
+	.sta_ofs = 0x140,
+};
+
+#define GATE_VDO10(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo10_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VDO11(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo11_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VDO12(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo12_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VDO13(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo13_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate vdo1_clks[] = {
+	/* VDO10 */
+	GATE_VDO10(CLK_VDO1_SMI_LARB2, "vdo1_smi_larb2", "vpp_sel", 0),
+	GATE_VDO10(CLK_VDO1_SMI_LARB3, "vdo1_smi_larb3", "vpp_sel", 1),
+	GATE_VDO10(CLK_VDO1_GALS, "vdo1_gals", "vpp_sel", 2),
+	GATE_VDO10(CLK_VDO1_FAKE_ENG0, "vdo1_fake_eng0", "vpp_sel", 3),
+	GATE_VDO10(CLK_VDO1_FAKE_ENG, "vdo1_fake_eng", "vpp_sel", 4),
+	GATE_VDO10(CLK_VDO1_MDP_RDMA0, "vdo1_mdp_rdma0", "vpp_sel", 5),
+	GATE_VDO10(CLK_VDO1_MDP_RDMA1, "vdo1_mdp_rdma1", "vpp_sel", 6),
+	GATE_VDO10(CLK_VDO1_MDP_RDMA2, "vdo1_mdp_rdma2", "vpp_sel", 7),
+	GATE_VDO10(CLK_VDO1_MDP_RDMA3, "vdo1_mdp_rdma3", "vpp_sel", 8),
+	GATE_VDO10(CLK_VDO1_VPP_MERGE0, "vdo1_vpp_merge0", "vpp_sel", 9),
+	GATE_VDO10(CLK_VDO1_VPP_MERGE1, "vdo1_vpp_merge1", "vpp_sel", 10),
+	GATE_VDO10(CLK_VDO1_VPP_MERGE2, "vdo1_vpp_merge2", "vpp_sel", 11),
+	GATE_VDO10(CLK_VDO1_VPP_MERGE3, "vdo1_vpp_merge3", "vpp_sel", 12),
+	GATE_VDO10(CLK_VDO1_VPP_MERGE4, "vdo1_vpp_merge4", "vpp_sel", 13),
+	GATE_VDO10(CLK_VDO1_VPP2_TO_VDO1_DL_ASYNC, "vdo1_vpp2_to_vdo1_dl_async", "vpp_sel", 14),
+	GATE_VDO10(CLK_VDO1_VPP3_TO_VDO1_DL_ASYNC, "vdo1_vpp3_to_vdo1_dl_async", "vpp_sel", 15),
+	GATE_VDO10(CLK_VDO1_DISP_MUTEX, "vdo1_disp_mutex", "vpp_sel", 16),
+	GATE_VDO10(CLK_VDO1_MDP_RDMA4, "vdo1_mdp_rdma4", "vpp_sel", 17),
+	GATE_VDO10(CLK_VDO1_MDP_RDMA5, "vdo1_mdp_rdma5", "vpp_sel", 18),
+	GATE_VDO10(CLK_VDO1_MDP_RDMA6, "vdo1_mdp_rdma6", "vpp_sel", 19),
+	GATE_VDO10(CLK_VDO1_MDP_RDMA7, "vdo1_mdp_rdma7", "vpp_sel", 20),
+	GATE_VDO10(CLK_VDO1_DP_INTF0_MM, "vdo1_dp_intf0_mm", "vpp_sel", 21),
+	GATE_VDO10(CLK_VDO1_DPI0_MM, "vdo1_dpi0_mm", "vpp_sel", 22),
+	GATE_VDO10(CLK_VDO1_DPI1_MM, "vdo1_dpi1_mm", "vpp_sel", 23),
+	GATE_VDO10(CLK_VDO1_DISP_MONITOR, "vdo1_disp_monitor", "vpp_sel", 24),
+	GATE_VDO10(CLK_VDO1_MERGE0_DL_ASYNC, "vdo1_merge0_dl_async", "vpp_sel", 25),
+	GATE_VDO10(CLK_VDO1_MERGE1_DL_ASYNC, "vdo1_merge1_dl_async", "vpp_sel", 26),
+	GATE_VDO10(CLK_VDO1_MERGE2_DL_ASYNC, "vdo1_merge2_dl_async", "vpp_sel", 27),
+	GATE_VDO10(CLK_VDO1_MERGE3_DL_ASYNC, "vdo1_merge3_dl_async", "vpp_sel", 28),
+	GATE_VDO10(CLK_VDO1_MERGE4_DL_ASYNC, "vdo1_merge4_dl_async", "vpp_sel", 29),
+	GATE_VDO10(CLK_VDO1_VDO0_DSC_TO_VDO1_DL_ASYNC, "vdo1_vdo0_dsc_to_vdo1_dl_async",
+		"vpp_sel", 30),
+	GATE_VDO10(CLK_VDO1_VDO0_MERGE_TO_VDO1_DL_ASYNC, "vdo1_vdo0_merge_to_vdo1_dl_async",
+		"vpp_sel", 31),
+	/* VDO11 */
+	GATE_VDO11(CLK_VDO1_HDR_VDO_FE0, "vdo1_hdr_vdo_fe0", "vpp_sel", 0),
+	GATE_VDO11(CLK_VDO1_HDR_GFX_FE0, "vdo1_hdr_gfx_fe0", "vpp_sel", 1),
+	GATE_VDO11(CLK_VDO1_HDR_VDO_BE, "vdo1_hdr_vdo_be", "vpp_sel", 2),
+	GATE_VDO11(CLK_VDO1_HDR_VDO_FE1, "vdo1_hdr_vdo_fe1", "vpp_sel", 16),
+	GATE_VDO11(CLK_VDO1_HDR_GFX_FE1, "vdo1_hdr_gfx_fe1", "vpp_sel", 17),
+	GATE_VDO11(CLK_VDO1_DISP_MIXER, "vdo1_disp_mixer", "vpp_sel", 18),
+	GATE_VDO11(CLK_VDO1_HDR_VDO_FE0_DL_ASYNC, "vdo1_hdr_vdo_fe0_dl_async", "vpp_sel", 19),
+	GATE_VDO11(CLK_VDO1_HDR_VDO_FE1_DL_ASYNC, "vdo1_hdr_vdo_fe1_dl_async", "vpp_sel", 20),
+	GATE_VDO11(CLK_VDO1_HDR_GFX_FE0_DL_ASYNC, "vdo1_hdr_gfx_fe0_dl_async", "vpp_sel", 21),
+	GATE_VDO11(CLK_VDO1_HDR_GFX_FE1_DL_ASYNC, "vdo1_hdr_gfx_fe1_dl_async", "vpp_sel", 22),
+	GATE_VDO11(CLK_VDO1_HDR_VDO_BE_DL_ASYNC, "vdo1_hdr_vdo_be_dl_async", "vpp_sel", 23),
+	/* VDO12 */
+	GATE_VDO12(CLK_VDO1_DPI0, "vdo1_dpi0", "vpp_sel", 0),
+	GATE_VDO12(CLK_VDO1_DISP_MONITOR_DPI0, "vdo1_disp_monitor_dpi0", "vpp_sel", 1),
+	GATE_VDO12(CLK_VDO1_DPI1, "vdo1_dpi1", "vpp_sel", 8),
+	GATE_VDO12(CLK_VDO1_DISP_MONITOR_DPI1, "vdo1_disp_monitor_dpi1", "vpp_sel", 9),
+	GATE_VDO12(CLK_VDO1_DPINTF, "vdo1_dpintf", "vpp_sel", 16),
+	GATE_VDO12(CLK_VDO1_DISP_MONITOR_DPINTF, "vdo1_disp_monitor_dpintf", "vpp_sel", 17),
+	/* VDO13 */
+	GATE_VDO13(CLK_VDO1_26M_SLOW, "vdo1_26m_slow", "clk26m", 8),
+};
+
+static const struct mtk_clk_desc vdo1_desc = {
+	.clks = vdo1_clks,
+	.num_clks = ARRAY_SIZE(vdo1_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_vdo1[] = {
+	{
+		.compatible = "mediatek,mt8195-vdosys1",
+		.data = &vdo1_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_vdo1_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-vdo1",
+		.of_match_table = of_match_clk_mt8195_vdo1,
+	},
+};
+
+builtin_platform_driver(clk_mt8195_vdo1_drv);
-- 
2.18.0

