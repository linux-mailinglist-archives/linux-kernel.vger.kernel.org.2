Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8955D40A36E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbhINCTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:19:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52080 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238431AbhINCS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:58 -0400
X-UUID: 81dfd41232134e4d8541f166d4c0d428-20210914
X-UUID: 81dfd41232134e4d8541f166d4c0d428-20210914
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1722913414; Tue, 14 Sep 2021 10:17:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:17:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:17:36 +0800
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
Subject: [v3 20/24] clk: mediatek: Add MT8195 vppsys0 clock support
Date:   Tue, 14 Sep 2021 10:16:29 +0800
Message-ID: <20210914021633.26377-21-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 vppsys0 clock controller which provides clock gate
controller for Video Processor Pipe.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Makefile          |   2 +-
 drivers/clk/mediatek/clk-mt8195-vpp0.c | 110 +++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vpp0.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 9e330148fedf..f38a2f15cc32 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -85,6 +85,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
 				   clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
 				   clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
 				   clk-mt8195-vdec.o clk-mt8195-vdo0.o clk-mt8195-vdo1.o \
-				   clk-mt8195-venc.o
+				   clk-mt8195-venc.o clk-mt8195-vpp0.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
new file mode 100644
index 000000000000..c3241466a8d0
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
@@ -0,0 +1,110 @@
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
+static const struct mtk_gate_regs vpp0_0_cg_regs = {
+	.set_ofs = 0x24,
+	.clr_ofs = 0x28,
+	.sta_ofs = 0x20,
+};
+
+static const struct mtk_gate_regs vpp0_1_cg_regs = {
+	.set_ofs = 0x30,
+	.clr_ofs = 0x34,
+	.sta_ofs = 0x2c,
+};
+
+static const struct mtk_gate_regs vpp0_2_cg_regs = {
+	.set_ofs = 0x3c,
+	.clr_ofs = 0x40,
+	.sta_ofs = 0x38,
+};
+
+#define GATE_VPP0_0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vpp0_0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VPP0_1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vpp0_1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VPP0_2(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vpp0_2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate vpp0_clks[] = {
+	/* VPP0_0 */
+	GATE_VPP0_0(CLK_VPP0_MDP_FG, "vpp0_mdp_fg", "top_vpp", 1),
+	GATE_VPP0_0(CLK_VPP0_STITCH, "vpp0_stitch", "top_vpp", 2),
+	GATE_VPP0_0(CLK_VPP0_PADDING, "vpp0_padding", "top_vpp", 7),
+	GATE_VPP0_0(CLK_VPP0_MDP_TCC, "vpp0_mdp_tcc", "top_vpp", 8),
+	GATE_VPP0_0(CLK_VPP0_WARP0_ASYNC_TX, "vpp0_warp0_async_tx", "top_vpp", 10),
+	GATE_VPP0_0(CLK_VPP0_WARP1_ASYNC_TX, "vpp0_warp1_async_tx", "top_vpp", 11),
+	GATE_VPP0_0(CLK_VPP0_MUTEX, "vpp0_mutex", "top_vpp", 13),
+	GATE_VPP0_0(CLK_VPP0_VPP02VPP1_RELAY, "vpp0_vpp02vpp1_relay", "top_vpp", 14),
+	GATE_VPP0_0(CLK_VPP0_VPP12VPP0_ASYNC, "vpp0_vpp12vpp0_async", "top_vpp", 15),
+	GATE_VPP0_0(CLK_VPP0_MMSYSRAM_TOP, "vpp0_mmsysram_top", "top_vpp", 16),
+	GATE_VPP0_0(CLK_VPP0_MDP_AAL, "vpp0_mdp_aal", "top_vpp", 17),
+	GATE_VPP0_0(CLK_VPP0_MDP_RSZ, "vpp0_mdp_rsz", "top_vpp", 18),
+	/* VPP0_1 */
+	GATE_VPP0_1(CLK_VPP0_SMI_COMMON, "vpp0_smi_common", "top_vpp", 0),
+	GATE_VPP0_1(CLK_VPP0_GALS_VDO0_LARB0, "vpp0_gals_vdo0_larb0", "top_vpp", 1),
+	GATE_VPP0_1(CLK_VPP0_GALS_VDO0_LARB1, "vpp0_gals_vdo0_larb1", "top_vpp", 2),
+	GATE_VPP0_1(CLK_VPP0_GALS_VENCSYS, "vpp0_gals_vencsys", "top_vpp", 3),
+	GATE_VPP0_1(CLK_VPP0_GALS_VENCSYS_CORE1, "vpp0_gals_vencsys_core1", "top_vpp", 4),
+	GATE_VPP0_1(CLK_VPP0_GALS_INFRA, "vpp0_gals_infra", "top_vpp", 5),
+	GATE_VPP0_1(CLK_VPP0_GALS_CAMSYS, "vpp0_gals_camsys", "top_vpp", 6),
+	GATE_VPP0_1(CLK_VPP0_GALS_VPP1_LARB5, "vpp0_gals_vpp1_larb5", "top_vpp", 7),
+	GATE_VPP0_1(CLK_VPP0_GALS_VPP1_LARB6, "vpp0_gals_vpp1_larb6", "top_vpp", 8),
+	GATE_VPP0_1(CLK_VPP0_SMI_REORDER, "vpp0_smi_reorder", "top_vpp", 9),
+	GATE_VPP0_1(CLK_VPP0_SMI_IOMMU, "vpp0_smi_iommu", "top_vpp", 10),
+	GATE_VPP0_1(CLK_VPP0_GALS_IMGSYS_CAMSYS, "vpp0_gals_imgsys_camsys", "top_vpp", 11),
+	GATE_VPP0_1(CLK_VPP0_MDP_RDMA, "vpp0_mdp_rdma", "top_vpp", 12),
+	GATE_VPP0_1(CLK_VPP0_MDP_WROT, "vpp0_mdp_wrot", "top_vpp", 13),
+	GATE_VPP0_1(CLK_VPP0_GALS_EMI0_EMI1, "vpp0_gals_emi0_emi1", "top_vpp", 16),
+	GATE_VPP0_1(CLK_VPP0_SMI_SUB_COMMON_REORDER, "vpp0_smi_sub_common_reorder", "top_vpp", 17),
+	GATE_VPP0_1(CLK_VPP0_SMI_RSI, "vpp0_smi_rsi", "top_vpp", 18),
+	GATE_VPP0_1(CLK_VPP0_SMI_COMMON_LARB4, "vpp0_smi_common_larb4", "top_vpp", 19),
+	GATE_VPP0_1(CLK_VPP0_GALS_VDEC_VDEC_CORE1, "vpp0_gals_vdec_vdec_core1", "top_vpp", 20),
+	GATE_VPP0_1(CLK_VPP0_GALS_VPP1_WPE, "vpp0_gals_vpp1_wpe", "top_vpp", 21),
+	GATE_VPP0_1(CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1, "vpp0_gals_vdo0_vdo1_vencsys_core1",
+		    "top_vpp", 22),
+	GATE_VPP0_1(CLK_VPP0_FAKE_ENG, "vpp0_fake_eng", "top_vpp", 23),
+	GATE_VPP0_1(CLK_VPP0_MDP_HDR, "vpp0_mdp_hdr", "top_vpp", 24),
+	GATE_VPP0_1(CLK_VPP0_MDP_TDSHP, "vpp0_mdp_tdshp", "top_vpp", 25),
+	GATE_VPP0_1(CLK_VPP0_MDP_COLOR, "vpp0_mdp_color", "top_vpp", 26),
+	GATE_VPP0_1(CLK_VPP0_MDP_OVL, "vpp0_mdp_ovl", "top_vpp", 27),
+	/* VPP0_2 */
+	GATE_VPP0_2(CLK_VPP0_WARP0_RELAY, "vpp0_warp0_relay", "top_wpe_vpp", 0),
+	GATE_VPP0_2(CLK_VPP0_WARP0_MDP_DL_ASYNC, "vpp0_warp0_mdp_dl_async", "top_wpe_vpp", 1),
+	GATE_VPP0_2(CLK_VPP0_WARP1_RELAY, "vpp0_warp1_relay", "top_wpe_vpp", 2),
+	GATE_VPP0_2(CLK_VPP0_WARP1_MDP_DL_ASYNC, "vpp0_warp1_mdp_dl_async", "top_wpe_vpp", 3),
+};
+
+static const struct mtk_clk_desc vpp0_desc = {
+	.clks = vpp0_clks,
+	.num_clks = ARRAY_SIZE(vpp0_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
+	{
+		.compatible = "mediatek,mt8195-vppsys0",
+		.data = &vpp0_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_vpp0_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-vpp0",
+		.of_match_table = of_match_clk_mt8195_vpp0,
+	},
+};
+builtin_platform_driver(clk_mt8195_vpp0_drv);
-- 
2.18.0

