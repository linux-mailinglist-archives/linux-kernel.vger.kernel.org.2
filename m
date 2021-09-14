Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4938B40A369
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbhINCTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:19:19 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34822 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238361AbhINCSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:54 -0400
X-UUID: 702fbd2725714fd78118d096c3394b63-20210914
X-UUID: 702fbd2725714fd78118d096c3394b63-20210914
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 679694045; Tue, 14 Sep 2021 10:17:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:17:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:17:32 +0800
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
Subject: [v3 18/24] clk: mediatek: Add MT8195 vdosys1 clock support
Date:   Tue, 14 Sep 2021 10:16:27 +0800
Message-ID: <20210914021633.26377-19-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 vdosys1 clock controller which provides clock gate
control in video system. This is integrated with mtk-mmsys
driver which will populate device by platform_device_register_data
to start vdosys clock driver.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile          |   2 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c | 140 +++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdo1.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 6a642f7850f2..2acc12c09b06 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -84,6 +84,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
 				   clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o \
 				   clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
 				   clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
-				   clk-mt8195-vdec.o clk-mt8195-vdo0.o
+				   clk-mt8195-vdec.o clk-mt8195-vdo0.o clk-mt8195-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
new file mode 100644
index 000000000000..03df8eae8838
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -0,0 +1,140 @@
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
+static const struct mtk_gate_regs vdo1_0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs vdo1_1_cg_regs = {
+	.set_ofs = 0x124,
+	.clr_ofs = 0x128,
+	.sta_ofs = 0x120,
+};
+
+static const struct mtk_gate_regs vdo1_2_cg_regs = {
+	.set_ofs = 0x134,
+	.clr_ofs = 0x138,
+	.sta_ofs = 0x130,
+};
+
+static const struct mtk_gate_regs vdo1_3_cg_regs = {
+	.set_ofs = 0x144,
+	.clr_ofs = 0x148,
+	.sta_ofs = 0x140,
+};
+
+#define GATE_VDO1_0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo1_0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VDO1_1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo1_1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VDO1_2(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo1_2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VDO1_3(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo1_3_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate vdo1_clks[] = {
+	/* VDO1_0 */
+	GATE_VDO1_0(CLK_VDO1_SMI_LARB2, "vdo1_smi_larb2", "top_vpp", 0),
+	GATE_VDO1_0(CLK_VDO1_SMI_LARB3, "vdo1_smi_larb3", "top_vpp", 1),
+	GATE_VDO1_0(CLK_VDO1_GALS, "vdo1_gals", "top_vpp", 2),
+	GATE_VDO1_0(CLK_VDO1_FAKE_ENG0, "vdo1_fake_eng0", "top_vpp", 3),
+	GATE_VDO1_0(CLK_VDO1_FAKE_ENG, "vdo1_fake_eng", "top_vpp", 4),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA0, "vdo1_mdp_rdma0", "top_vpp", 5),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA1, "vdo1_mdp_rdma1", "top_vpp", 6),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA2, "vdo1_mdp_rdma2", "top_vpp", 7),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA3, "vdo1_mdp_rdma3", "top_vpp", 8),
+	GATE_VDO1_0(CLK_VDO1_VPP_MERGE0, "vdo1_vpp_merge0", "top_vpp", 9),
+	GATE_VDO1_0(CLK_VDO1_VPP_MERGE1, "vdo1_vpp_merge1", "top_vpp", 10),
+	GATE_VDO1_0(CLK_VDO1_VPP_MERGE2, "vdo1_vpp_merge2", "top_vpp", 11),
+	GATE_VDO1_0(CLK_VDO1_VPP_MERGE3, "vdo1_vpp_merge3", "top_vpp", 12),
+	GATE_VDO1_0(CLK_VDO1_VPP_MERGE4, "vdo1_vpp_merge4", "top_vpp", 13),
+	GATE_VDO1_0(CLK_VDO1_VPP2_TO_VDO1_DL_ASYNC, "vdo1_vpp2_to_vdo1_dl_async", "top_vpp", 14),
+	GATE_VDO1_0(CLK_VDO1_VPP3_TO_VDO1_DL_ASYNC, "vdo1_vpp3_to_vdo1_dl_async", "top_vpp", 15),
+	GATE_VDO1_0(CLK_VDO1_DISP_MUTEX, "vdo1_disp_mutex", "top_vpp", 16),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA4, "vdo1_mdp_rdma4", "top_vpp", 17),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA5, "vdo1_mdp_rdma5", "top_vpp", 18),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA6, "vdo1_mdp_rdma6", "top_vpp", 19),
+	GATE_VDO1_0(CLK_VDO1_MDP_RDMA7, "vdo1_mdp_rdma7", "top_vpp", 20),
+	GATE_VDO1_0(CLK_VDO1_DP_INTF0_MM, "vdo1_dp_intf0_mm", "top_vpp", 21),
+	GATE_VDO1_0(CLK_VDO1_DPI0_MM, "vdo1_dpi0_mm", "top_vpp", 22),
+	GATE_VDO1_0(CLK_VDO1_DPI1_MM, "vdo1_dpi1_mm", "top_vpp", 23),
+	GATE_VDO1_0(CLK_VDO1_DISP_MONITOR, "vdo1_disp_monitor", "top_vpp", 24),
+	GATE_VDO1_0(CLK_VDO1_MERGE0_DL_ASYNC, "vdo1_merge0_dl_async", "top_vpp", 25),
+	GATE_VDO1_0(CLK_VDO1_MERGE1_DL_ASYNC, "vdo1_merge1_dl_async", "top_vpp", 26),
+	GATE_VDO1_0(CLK_VDO1_MERGE2_DL_ASYNC, "vdo1_merge2_dl_async", "top_vpp", 27),
+	GATE_VDO1_0(CLK_VDO1_MERGE3_DL_ASYNC, "vdo1_merge3_dl_async", "top_vpp", 28),
+	GATE_VDO1_0(CLK_VDO1_MERGE4_DL_ASYNC, "vdo1_merge4_dl_async", "top_vpp", 29),
+	GATE_VDO1_0(CLK_VDO1_VDO0_DSC_TO_VDO1_DL_ASYNC, "vdo1_vdo0_dsc_to_vdo1_dl_async",
+		    "top_vpp", 30),
+	GATE_VDO1_0(CLK_VDO1_VDO0_MERGE_TO_VDO1_DL_ASYNC, "vdo1_vdo0_merge_to_vdo1_dl_async",
+		    "top_vpp", 31),
+	/* VDO1_1 */
+	GATE_VDO1_1(CLK_VDO1_HDR_VDO_FE0, "vdo1_hdr_vdo_fe0", "top_vpp", 0),
+	GATE_VDO1_1(CLK_VDO1_HDR_GFX_FE0, "vdo1_hdr_gfx_fe0", "top_vpp", 1),
+	GATE_VDO1_1(CLK_VDO1_HDR_VDO_BE, "vdo1_hdr_vdo_be", "top_vpp", 2),
+	GATE_VDO1_1(CLK_VDO1_HDR_VDO_FE1, "vdo1_hdr_vdo_fe1", "top_vpp", 16),
+	GATE_VDO1_1(CLK_VDO1_HDR_GFX_FE1, "vdo1_hdr_gfx_fe1", "top_vpp", 17),
+	GATE_VDO1_1(CLK_VDO1_DISP_MIXER, "vdo1_disp_mixer", "top_vpp", 18),
+	GATE_VDO1_1(CLK_VDO1_HDR_VDO_FE0_DL_ASYNC, "vdo1_hdr_vdo_fe0_dl_async", "top_vpp", 19),
+	GATE_VDO1_1(CLK_VDO1_HDR_VDO_FE1_DL_ASYNC, "vdo1_hdr_vdo_fe1_dl_async", "top_vpp", 20),
+	GATE_VDO1_1(CLK_VDO1_HDR_GFX_FE0_DL_ASYNC, "vdo1_hdr_gfx_fe0_dl_async", "top_vpp", 21),
+	GATE_VDO1_1(CLK_VDO1_HDR_GFX_FE1_DL_ASYNC, "vdo1_hdr_gfx_fe1_dl_async", "top_vpp", 22),
+	GATE_VDO1_1(CLK_VDO1_HDR_VDO_BE_DL_ASYNC, "vdo1_hdr_vdo_be_dl_async", "top_vpp", 23),
+	/* VDO1_2 */
+	GATE_VDO1_2(CLK_VDO1_DPI0, "vdo1_dpi0", "top_vpp", 0),
+	GATE_VDO1_2(CLK_VDO1_DISP_MONITOR_DPI0, "vdo1_disp_monitor_dpi0", "top_vpp", 1),
+	GATE_VDO1_2(CLK_VDO1_DPI1, "vdo1_dpi1", "top_vpp", 8),
+	GATE_VDO1_2(CLK_VDO1_DISP_MONITOR_DPI1, "vdo1_disp_monitor_dpi1", "top_vpp", 9),
+	GATE_VDO1_2(CLK_VDO1_DPINTF, "vdo1_dpintf", "top_vpp", 16),
+	GATE_VDO1_2(CLK_VDO1_DISP_MONITOR_DPINTF, "vdo1_disp_monitor_dpintf", "top_vpp", 17),
+	/* VDO1_3 */
+	GATE_VDO1_3(CLK_VDO1_26M_SLOW, "vdo1_26m_slow", "clk26m", 8),
+};
+
+static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_VDO1_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_gates(node, vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
+	if (r)
+		goto free_vdo1_data;
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto free_vdo1_data;
+
+	return r;
+
+free_vdo1_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static struct platform_driver clk_mt8195_vdo1_drv = {
+	.probe = clk_mt8195_vdo1_probe,
+	.driver = {
+		.name = "clk-mt8195-vdo1",
+	},
+};
+builtin_platform_driver(clk_mt8195_vdo1_drv);
-- 
2.18.0

