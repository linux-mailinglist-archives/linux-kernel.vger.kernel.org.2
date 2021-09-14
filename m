Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4F40A351
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbhINCSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:18:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51256 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238064AbhINCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:34 -0400
X-UUID: 84dc313478224073bb3092473693cd86-20210914
X-UUID: 84dc313478224073bb3092473693cd86-20210914
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1902854572; Tue, 14 Sep 2021 10:17:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:17:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:17:11 +0800
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
Subject: [v3 10/24] clk: mediatek: Add MT8195 camsys clock support
Date:   Tue, 14 Sep 2021 10:16:19 +0800
Message-ID: <20210914021633.26377-11-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 camsys clock controllers which provide clock gate
control for camera IP blocks.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Makefile         |   3 +-
 drivers/clk/mediatek/clk-mt8195-cam.c | 142 ++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-cam.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 62c37eae4e62..e9bee5cca9c4 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o \
-				   clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o
+				   clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o \
+				   clk-mt8195-cam.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-cam.c b/drivers/clk/mediatek/clk-mt8195-cam.c
new file mode 100644
index 000000000000..3d261fc3848e
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-cam.c
@@ -0,0 +1,142 @@
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
+static const struct mtk_gate_regs cam_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &cam_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate cam_clks[] = {
+	GATE_CAM(CLK_CAM_LARB13, "cam_larb13", "top_cam", 0),
+	GATE_CAM(CLK_CAM_LARB14, "cam_larb14", "top_cam", 1),
+	GATE_CAM(CLK_CAM_MAIN_CAM, "cam_main_cam", "top_cam", 3),
+	GATE_CAM(CLK_CAM_MAIN_CAMTG, "cam_main_camtg", "top_cam", 4),
+	GATE_CAM(CLK_CAM_SENINF, "cam_seninf", "top_cam", 5),
+	GATE_CAM(CLK_CAM_GCAMSVA, "cam_gcamsva", "top_cam", 6),
+	GATE_CAM(CLK_CAM_GCAMSVB, "cam_gcamsvb", "top_cam", 7),
+	GATE_CAM(CLK_CAM_GCAMSVC, "cam_gcamsvc", "top_cam", 8),
+	GATE_CAM(CLK_CAM_SCAMSA, "cam_scamsa", "top_cam", 9),
+	GATE_CAM(CLK_CAM_SCAMSB, "cam_scamsb", "top_cam", 10),
+	GATE_CAM(CLK_CAM_CAMSV_TOP, "cam_camsv_top", "top_cam", 11),
+	GATE_CAM(CLK_CAM_CAMSV_CQ, "cam_camsv_cq", "top_cam", 12),
+	GATE_CAM(CLK_CAM_ADL, "cam_adl", "top_cam", 16),
+	GATE_CAM(CLK_CAM_ASG, "cam_asg", "top_cam", 17),
+	GATE_CAM(CLK_CAM_PDA, "cam_pda", "top_cam", 18),
+	GATE_CAM(CLK_CAM_FAKE_ENG, "cam_fake_eng", "top_cam", 19),
+	GATE_CAM(CLK_CAM_MAIN_MRAW0, "cam_main_mraw0", "top_cam", 20),
+	GATE_CAM(CLK_CAM_MAIN_MRAW1, "cam_main_mraw1", "top_cam", 21),
+	GATE_CAM(CLK_CAM_MAIN_MRAW2, "cam_main_mraw2", "top_cam", 22),
+	GATE_CAM(CLK_CAM_MAIN_MRAW3, "cam_main_mraw3", "top_cam", 23),
+	GATE_CAM(CLK_CAM_CAM2MM0_GALS, "cam_cam2mm0_gals", "top_cam", 24),
+	GATE_CAM(CLK_CAM_CAM2MM1_GALS, "cam_cam2mm1_gals", "top_cam", 25),
+	GATE_CAM(CLK_CAM_CAM2SYS_GALS, "cam_cam2sys_gals", "top_cam", 26),
+};
+
+static const struct mtk_gate cam_mraw_clks[] = {
+	GATE_CAM(CLK_CAM_MRAW_LARBX, "cam_mraw_larbx", "top_cam", 0),
+	GATE_CAM(CLK_CAM_MRAW_CAMTG, "cam_mraw_camtg", "top_cam", 2),
+	GATE_CAM(CLK_CAM_MRAW_MRAW0, "cam_mraw_mraw0", "top_cam", 3),
+	GATE_CAM(CLK_CAM_MRAW_MRAW1, "cam_mraw_mraw1", "top_cam", 4),
+	GATE_CAM(CLK_CAM_MRAW_MRAW2, "cam_mraw_mraw2", "top_cam", 5),
+	GATE_CAM(CLK_CAM_MRAW_MRAW3, "cam_mraw_mraw3", "top_cam", 6),
+};
+
+static const struct mtk_gate cam_rawa_clks[] = {
+	GATE_CAM(CLK_CAM_RAWA_LARBX, "cam_rawa_larbx", "top_cam", 0),
+	GATE_CAM(CLK_CAM_RAWA_CAM, "cam_rawa_cam", "top_cam", 1),
+	GATE_CAM(CLK_CAM_RAWA_CAMTG, "cam_rawa_camtg", "top_cam", 2),
+};
+
+static const struct mtk_gate cam_rawb_clks[] = {
+	GATE_CAM(CLK_CAM_RAWB_LARBX, "cam_rawb_larbx", "top_cam", 0),
+	GATE_CAM(CLK_CAM_RAWB_CAM, "cam_rawb_cam", "top_cam", 1),
+	GATE_CAM(CLK_CAM_RAWB_CAMTG, "cam_rawb_camtg", "top_cam", 2),
+};
+
+static const struct mtk_gate cam_yuva_clks[] = {
+	GATE_CAM(CLK_CAM_YUVA_LARBX, "cam_yuva_larbx", "top_cam", 0),
+	GATE_CAM(CLK_CAM_YUVA_CAM, "cam_yuva_cam", "top_cam", 1),
+	GATE_CAM(CLK_CAM_YUVA_CAMTG, "cam_yuva_camtg", "top_cam", 2),
+};
+
+static const struct mtk_gate cam_yuvb_clks[] = {
+	GATE_CAM(CLK_CAM_YUVB_LARBX, "cam_yuvb_larbx", "top_cam", 0),
+	GATE_CAM(CLK_CAM_YUVB_CAM, "cam_yuvb_cam", "top_cam", 1),
+	GATE_CAM(CLK_CAM_YUVB_CAMTG, "cam_yuvb_camtg", "top_cam", 2),
+};
+
+static const struct mtk_clk_desc cam_desc = {
+	.clks = cam_clks,
+	.num_clks = ARRAY_SIZE(cam_clks),
+};
+
+static const struct mtk_clk_desc cam_mraw_desc = {
+	.clks = cam_mraw_clks,
+	.num_clks = ARRAY_SIZE(cam_mraw_clks),
+};
+
+static const struct mtk_clk_desc cam_rawa_desc = {
+	.clks = cam_rawa_clks,
+	.num_clks = ARRAY_SIZE(cam_rawa_clks),
+};
+
+static const struct mtk_clk_desc cam_rawb_desc = {
+	.clks = cam_rawb_clks,
+	.num_clks = ARRAY_SIZE(cam_rawb_clks),
+};
+
+static const struct mtk_clk_desc cam_yuva_desc = {
+	.clks = cam_yuva_clks,
+	.num_clks = ARRAY_SIZE(cam_yuva_clks),
+};
+
+static const struct mtk_clk_desc cam_yuvb_desc = {
+	.clks = cam_yuvb_clks,
+	.num_clks = ARRAY_SIZE(cam_yuvb_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_cam[] = {
+	{
+		.compatible = "mediatek,mt8195-camsys",
+		.data = &cam_desc,
+	}, {
+		.compatible = "mediatek,mt8195-camsys_mraw",
+		.data = &cam_mraw_desc,
+	}, {
+		.compatible = "mediatek,mt8195-camsys_rawa",
+		.data = &cam_rawa_desc,
+	}, {
+		.compatible = "mediatek,mt8195-camsys_rawb",
+		.data = &cam_rawb_desc,
+	}, {
+		.compatible = "mediatek,mt8195-camsys_yuva",
+		.data = &cam_yuva_desc,
+	}, {
+		.compatible = "mediatek,mt8195-camsys_yuvb",
+		.data = &cam_yuvb_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_cam_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-cam",
+		.of_match_table = of_match_clk_mt8195_cam,
+	},
+};
+builtin_platform_driver(clk_mt8195_cam_drv);
-- 
2.18.0

