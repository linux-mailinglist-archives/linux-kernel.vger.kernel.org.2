Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F124D40A366
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbhINCTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:19:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51892 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238294AbhINCSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:52 -0400
X-UUID: 1960ef31825e4c9cafbc2ee537f2616f-20210914
X-UUID: 1960ef31825e4c9cafbc2ee537f2616f-20210914
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1615615630; Tue, 14 Sep 2021 10:17:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:17:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:17:29 +0800
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
Subject: [v3 17/24] clk: mediatek: Add MT8195 vdosys0 clock support
Date:   Tue, 14 Sep 2021 10:16:26 +0800
Message-ID: <20210914021633.26377-18-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 vdosys0 clock controller which provides clock gate
control in video system. This is integrated with mtk-mmsys
driver which will populate device by platform_device_register_data
to start vdosys clock driver.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile          |   2 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c | 123 +++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdo0.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 71b3eb3fb93d..6a642f7850f2 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -84,6 +84,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
 				   clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o \
 				   clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
 				   clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
-				   clk-mt8195-vdec.o
+				   clk-mt8195-vdec.o clk-mt8195-vdo0.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
new file mode 100644
index 000000000000..f7ff7618c714
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2021 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mt8195-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+static const struct mtk_gate_regs vdo0_0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs vdo0_1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+static const struct mtk_gate_regs vdo0_2_cg_regs = {
+	.set_ofs = 0x124,
+	.clr_ofs = 0x128,
+	.sta_ofs = 0x120,
+};
+
+#define GATE_VDO0_0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo0_0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VDO0_1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo0_1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VDO0_2(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo0_2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate vdo0_clks[] = {
+	/* VDO0_0 */
+	GATE_VDO0_0(CLK_VDO0_DISP_OVL0, "vdo0_disp_ovl0", "top_vpp", 0),
+	GATE_VDO0_0(CLK_VDO0_DISP_COLOR0, "vdo0_disp_color0", "top_vpp", 2),
+	GATE_VDO0_0(CLK_VDO0_DISP_COLOR1, "vdo0_disp_color1", "top_vpp", 3),
+	GATE_VDO0_0(CLK_VDO0_DISP_CCORR0, "vdo0_disp_ccorr0", "top_vpp", 4),
+	GATE_VDO0_0(CLK_VDO0_DISP_CCORR1, "vdo0_disp_ccorr1", "top_vpp", 5),
+	GATE_VDO0_0(CLK_VDO0_DISP_AAL0, "vdo0_disp_aal0", "top_vpp", 6),
+	GATE_VDO0_0(CLK_VDO0_DISP_AAL1, "vdo0_disp_aal1", "top_vpp", 7),
+	GATE_VDO0_0(CLK_VDO0_DISP_GAMMA0, "vdo0_disp_gamma0", "top_vpp", 8),
+	GATE_VDO0_0(CLK_VDO0_DISP_GAMMA1, "vdo0_disp_gamma1", "top_vpp", 9),
+	GATE_VDO0_0(CLK_VDO0_DISP_DITHER0, "vdo0_disp_dither0", "top_vpp", 10),
+	GATE_VDO0_0(CLK_VDO0_DISP_DITHER1, "vdo0_disp_dither1", "top_vpp", 11),
+	GATE_VDO0_0(CLK_VDO0_DISP_OVL1, "vdo0_disp_ovl1", "top_vpp", 16),
+	GATE_VDO0_0(CLK_VDO0_DISP_WDMA0, "vdo0_disp_wdma0", "top_vpp", 17),
+	GATE_VDO0_0(CLK_VDO0_DISP_WDMA1, "vdo0_disp_wdma1", "top_vpp", 18),
+	GATE_VDO0_0(CLK_VDO0_DISP_RDMA0, "vdo0_disp_rdma0", "top_vpp", 19),
+	GATE_VDO0_0(CLK_VDO0_DISP_RDMA1, "vdo0_disp_rdma1", "top_vpp", 20),
+	GATE_VDO0_0(CLK_VDO0_DSI0, "vdo0_dsi0", "top_vpp", 21),
+	GATE_VDO0_0(CLK_VDO0_DSI1, "vdo0_dsi1", "top_vpp", 22),
+	GATE_VDO0_0(CLK_VDO0_DSC_WRAP0, "vdo0_dsc_wrap0", "top_vpp", 23),
+	GATE_VDO0_0(CLK_VDO0_VPP_MERGE0, "vdo0_vpp_merge0", "top_vpp", 24),
+	GATE_VDO0_0(CLK_VDO0_DP_INTF0, "vdo0_dp_intf0", "top_vpp", 25),
+	GATE_VDO0_0(CLK_VDO0_DISP_MUTEX0, "vdo0_disp_mutex0", "top_vpp", 26),
+	GATE_VDO0_0(CLK_VDO0_DISP_IL_ROT0, "vdo0_disp_il_rot0", "top_vpp", 27),
+	GATE_VDO0_0(CLK_VDO0_APB_BUS, "vdo0_apb_bus", "top_vpp", 28),
+	GATE_VDO0_0(CLK_VDO0_FAKE_ENG0, "vdo0_fake_eng0", "top_vpp", 29),
+	GATE_VDO0_0(CLK_VDO0_FAKE_ENG1, "vdo0_fake_eng1", "top_vpp", 30),
+	/* VDO0_1 */
+	GATE_VDO0_1(CLK_VDO0_DL_ASYNC0, "vdo0_dl_async0", "top_vpp", 0),
+	GATE_VDO0_1(CLK_VDO0_DL_ASYNC1, "vdo0_dl_async1", "top_vpp", 1),
+	GATE_VDO0_1(CLK_VDO0_DL_ASYNC2, "vdo0_dl_async2", "top_vpp", 2),
+	GATE_VDO0_1(CLK_VDO0_DL_ASYNC3, "vdo0_dl_async3", "top_vpp", 3),
+	GATE_VDO0_1(CLK_VDO0_DL_ASYNC4, "vdo0_dl_async4", "top_vpp", 4),
+	GATE_VDO0_1(CLK_VDO0_DISP_MONITOR0, "vdo0_disp_monitor0", "top_vpp", 5),
+	GATE_VDO0_1(CLK_VDO0_DISP_MONITOR1, "vdo0_disp_monitor1", "top_vpp", 6),
+	GATE_VDO0_1(CLK_VDO0_DISP_MONITOR2, "vdo0_disp_monitor2", "top_vpp", 7),
+	GATE_VDO0_1(CLK_VDO0_DISP_MONITOR3, "vdo0_disp_monitor3", "top_vpp", 8),
+	GATE_VDO0_1(CLK_VDO0_DISP_MONITOR4, "vdo0_disp_monitor4", "top_vpp", 9),
+	GATE_VDO0_1(CLK_VDO0_SMI_GALS, "vdo0_smi_gals", "top_vpp", 10),
+	GATE_VDO0_1(CLK_VDO0_SMI_COMMON, "vdo0_smi_common", "top_vpp", 11),
+	GATE_VDO0_1(CLK_VDO0_SMI_EMI, "vdo0_smi_emi", "top_vpp", 12),
+	GATE_VDO0_1(CLK_VDO0_SMI_IOMMU, "vdo0_smi_iommu", "top_vpp", 13),
+	GATE_VDO0_1(CLK_VDO0_SMI_LARB, "vdo0_smi_larb", "top_vpp", 14),
+	GATE_VDO0_1(CLK_VDO0_SMI_RSI, "vdo0_smi_rsi", "top_vpp", 15),
+	/* VDO0_2 */
+	GATE_VDO0_2(CLK_VDO0_DSI0_DSI, "vdo0_dsi0_dsi", "top_dsi_occ", 0),
+	GATE_VDO0_2(CLK_VDO0_DSI1_DSI, "vdo0_dsi1_dsi", "top_dsi_occ", 8),
+	GATE_VDO0_2(CLK_VDO0_DP_INTF0_DP_INTF, "vdo0_dp_intf0_dp_intf", "top_edp", 16),
+};
+
+static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_VDO0_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_gates(node, vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
+	if (r)
+		goto free_vdo0_data;
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto free_vdo0_data;
+
+	return r;
+
+free_vdo0_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static struct platform_driver clk_mt8195_vdo0_drv = {
+	.probe = clk_mt8195_vdo0_probe,
+	.driver = {
+		.name = "clk-mt8195-vdo0",
+	},
+};
+builtin_platform_driver(clk_mt8195_vdo0_drv);
-- 
2.18.0

