Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505D140A370
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbhINCT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:19:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52196 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237867AbhINCTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:19:01 -0400
X-UUID: 7a8eef3d00754c9f9e0902fed83d54ee-20210914
X-UUID: 7a8eef3d00754c9f9e0902fed83d54ee-20210914
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 211242248; Tue, 14 Sep 2021 10:17:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:17:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:17:39 +0800
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
Subject: [v3 21/24] clk: mediatek: Add MT8195 vppsys1 clock support
Date:   Tue, 14 Sep 2021 10:16:30 +0800
Message-ID: <20210914021633.26377-22-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 vppsys1 clock controller which provides clock gate
controller for Video Processor Pipe.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Makefile          |   2 +-
 drivers/clk/mediatek/clk-mt8195-vpp1.c | 108 +++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vpp1.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index f38a2f15cc32..f58f689a5dd4 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -85,6 +85,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
 				   clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
 				   clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
 				   clk-mt8195-vdec.o clk-mt8195-vdo0.o clk-mt8195-vdo1.o \
-				   clk-mt8195-venc.o clk-mt8195-vpp0.o
+				   clk-mt8195-venc.o clk-mt8195-vpp0.o clk-mt8195-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
new file mode 100644
index 000000000000..ce0b9a40a179
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
@@ -0,0 +1,108 @@
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
+static const struct mtk_gate_regs vpp1_0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs vpp1_1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+#define GATE_VPP1_0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vpp1_0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_VPP1_1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vpp1_1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate vpp1_clks[] = {
+	/* VPP1_0 */
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_OVL, "vpp1_svpp1_mdp_ovl", "top_vpp", 0),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_TCC, "vpp1_svpp1_mdp_tcc", "top_vpp", 1),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_WROT, "vpp1_svpp1_mdp_wrot", "top_vpp", 2),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_VPP_PAD, "vpp1_svpp1_vpp_pad", "top_vpp", 3),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_WROT, "vpp1_svpp2_mdp_wrot", "top_vpp", 4),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_VPP_PAD, "vpp1_svpp2_vpp_pad", "top_vpp", 5),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_MDP_WROT, "vpp1_svpp3_mdp_wrot", "top_vpp", 6),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_VPP_PAD, "vpp1_svpp3_vpp_pad", "top_vpp", 7),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_RDMA, "vpp1_svpp1_mdp_rdma", "top_vpp", 8),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_FG, "vpp1_svpp1_mdp_fg", "top_vpp", 9),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_RDMA, "vpp1_svpp2_mdp_rdma", "top_vpp", 10),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_FG, "vpp1_svpp2_mdp_fg", "top_vpp", 11),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_MDP_RDMA, "vpp1_svpp3_mdp_rdma", "top_vpp", 12),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_MDP_FG, "vpp1_svpp3_mdp_fg", "top_vpp", 13),
+	GATE_VPP1_0(CLK_VPP1_VPP_SPLIT, "vpp1_vpp_split", "top_vpp", 14),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_VDO0_DL_RELAY, "vpp1_svpp2_vdo0_dl_relay", "top_vpp", 15),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_TDSHP, "vpp1_svpp1_mdp_tdshp", "top_vpp", 16),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_COLOR, "vpp1_svpp1_mdp_color", "top_vpp", 17),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_VDO1_DL_RELAY, "vpp1_svpp3_vdo1_dl_relay", "top_vpp", 18),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_VPP_MERGE, "vpp1_svpp2_vpp_merge", "top_vpp", 19),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_COLOR, "vpp1_svpp2_mdp_color", "top_vpp", 20),
+	GATE_VPP1_0(CLK_VPP1_VPPSYS1_GALS, "vpp1_vppsys1_gals", "top_vpp", 21),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_VPP_MERGE, "vpp1_svpp3_vpp_merge", "top_vpp", 22),
+	GATE_VPP1_0(CLK_VPP1_SVPP3_MDP_COLOR, "vpp1_svpp3_mdp_color", "top_vpp", 23),
+	GATE_VPP1_0(CLK_VPP1_VPPSYS1_LARB, "vpp1_vppsys1_larb", "top_vpp", 24),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_RSZ, "vpp1_svpp1_mdp_rsz", "top_vpp", 25),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_HDR, "vpp1_svpp1_mdp_hdr", "top_vpp", 26),
+	GATE_VPP1_0(CLK_VPP1_SVPP1_MDP_AAL, "vpp1_svpp1_mdp_aal", "top_vpp", 27),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_HDR, "vpp1_svpp2_mdp_hdr", "top_vpp", 28),
+	GATE_VPP1_0(CLK_VPP1_SVPP2_MDP_AAL, "vpp1_svpp2_mdp_aal", "top_vpp", 29),
+	GATE_VPP1_0(CLK_VPP1_DL_ASYNC, "vpp1_dl_async", "top_vpp", 30),
+	GATE_VPP1_0(CLK_VPP1_LARB5_FAKE_ENG, "vpp1_larb5_fake_eng", "top_vpp", 31),
+	/* VPP1_1 */
+	GATE_VPP1_1(CLK_VPP1_SVPP3_MDP_HDR, "vpp1_svpp3_mdp_hdr", "top_vpp", 0),
+	GATE_VPP1_1(CLK_VPP1_SVPP3_MDP_AAL, "vpp1_svpp3_mdp_aal", "top_vpp", 1),
+	GATE_VPP1_1(CLK_VPP1_SVPP2_VDO1_DL_RELAY, "vpp1_svpp2_vdo1_dl_relay", "top_vpp", 2),
+	GATE_VPP1_1(CLK_VPP1_LARB6_FAKE_ENG, "vpp1_larb6_fake_eng", "top_vpp", 3),
+	GATE_VPP1_1(CLK_VPP1_SVPP2_MDP_RSZ, "vpp1_svpp2_mdp_rsz", "top_vpp", 4),
+	GATE_VPP1_1(CLK_VPP1_SVPP3_MDP_RSZ, "vpp1_svpp3_mdp_rsz", "top_vpp", 5),
+	GATE_VPP1_1(CLK_VPP1_SVPP3_VDO0_DL_RELAY, "vpp1_svpp3_vdo0_dl_relay", "top_vpp", 6),
+	GATE_VPP1_1(CLK_VPP1_DISP_MUTEX, "vpp1_disp_mutex", "top_vpp", 7),
+	GATE_VPP1_1(CLK_VPP1_SVPP2_MDP_TDSHP, "vpp1_svpp2_mdp_tdshp", "top_vpp", 8),
+	GATE_VPP1_1(CLK_VPP1_SVPP3_MDP_TDSHP, "vpp1_svpp3_mdp_tdshp", "top_vpp", 9),
+	GATE_VPP1_1(CLK_VPP1_VPP0_DL1_RELAY, "vpp1_vpp0_dl1_relay", "top_vpp", 10),
+	GATE_VPP1_1(CLK_VPP1_HDMI_META, "vpp1_hdmi_meta", "hdmirx_p", 11),
+	GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_HDMI, "vpp1_vpp_split_hdmi", "hdmirx_p", 12),
+	GATE_VPP1_1(CLK_VPP1_DGI_IN, "vpp1_dgi_in", "in_dgi", 13),
+	GATE_VPP1_1(CLK_VPP1_DGI_OUT, "vpp1_dgi_out", "top_dgi_out", 14),
+	GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_DGI, "vpp1_vpp_split_dgi", "top_dgi_out", 15),
+	GATE_VPP1_1(CLK_VPP1_VPP0_DL_ASYNC, "vpp1_vpp0_dl_async", "top_vpp", 16),
+	GATE_VPP1_1(CLK_VPP1_VPP0_DL_RELAY, "vpp1_vpp0_dl_relay", "top_vpp", 17),
+	GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_26M, "vpp1_vpp_split_26m", "clk26m", 26),
+};
+
+static const struct mtk_clk_desc vpp1_desc = {
+	.clks = vpp1_clks,
+	.num_clks = ARRAY_SIZE(vpp1_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_vpp1[] = {
+	{
+		.compatible = "mediatek,mt8195-vppsys1",
+		.data = &vpp1_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_vpp1_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-vpp1",
+		.of_match_table = of_match_clk_mt8195_vpp1,
+	},
+};
+builtin_platform_driver(clk_mt8195_vpp1_drv);
-- 
2.18.0

