Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D983AA6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhFPWvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:51:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51807 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234253AbhFPWvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:51:51 -0400
X-UUID: 0a86d635bca341e4a5e08fad7baf95b4-20210617
X-UUID: 0a86d635bca341e4a5e08fad7baf95b4-20210617
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1339240226; Thu, 17 Jun 2021 06:49:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:49:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:49:40 +0800
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
Subject: [PATCH 07/22] clk: mediatek: Add MT8195 camsys clock support
Date:   Thu, 17 Jun 2021 06:47:28 +0800
Message-ID: <20210616224743.5109-8-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 camsys clock providers

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |   6 ++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8195-cam.c | 144 ++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-cam.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 62dd02bc2755..515155f3d185 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -600,6 +600,12 @@ config COMMON_CLK_MT8195_AUDSYS_SRC
 	help
 	  This driver supports MediaTek MT8195 audsys_src clocks.
 
+config COMMON_CLK_MT8195_CAMSYS
+	bool "Clock driver for MediaTek MT8195 camsys"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 camsys clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 52a5d3f49ff0..421064e7418c 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -83,5 +83,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195.o
 obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS) += clk-mt8195-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS_SRC) += clk-mt8195-aud_src.o
+obj-$(CONFIG_COMMON_CLK_MT8195_CAMSYS) += clk-mt8195-cam.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-cam.c b/drivers/clk/mediatek/clk-mt8195-cam.c
new file mode 100644
index 000000000000..41f48d4b7de6
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-cam.c
@@ -0,0 +1,144 @@
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
+	GATE_CAM(CLK_CAM_LARB13, "cam_larb13", "cam_sel", 0),
+	GATE_CAM(CLK_CAM_LARB14, "cam_larb14", "cam_sel", 1),
+	GATE_CAM(CLK_CAM_MAIN_CAM, "cam_main_cam", "cam_sel", 3),
+	GATE_CAM(CLK_CAM_MAIN_CAMTG, "cam_main_camtg", "cam_sel", 4),
+	GATE_CAM(CLK_CAM_SENINF, "cam_seninf", "cam_sel", 5),
+	GATE_CAM(CLK_CAM_GCAMSVA, "cam_gcamsva", "cam_sel", 6),
+	GATE_CAM(CLK_CAM_GCAMSVB, "cam_gcamsvb", "cam_sel", 7),
+	GATE_CAM(CLK_CAM_GCAMSVC, "cam_gcamsvc", "cam_sel", 8),
+	GATE_CAM(CLK_CAM_SCAMSA, "cam_scamsa", "cam_sel", 9),
+	GATE_CAM(CLK_CAM_SCAMSB, "cam_scamsb", "cam_sel", 10),
+	GATE_CAM(CLK_CAM_CAMSV_TOP, "cam_camsv_top", "cam_sel", 11),
+	GATE_CAM(CLK_CAM_CAMSV_CQ, "cam_camsv_cq", "cam_sel", 12),
+	GATE_CAM(CLK_CAM_ADL, "cam_adl", "cam_sel", 16),
+	GATE_CAM(CLK_CAM_ASG, "cam_asg", "cam_sel", 17),
+	GATE_CAM(CLK_CAM_PDA, "cam_pda", "cam_sel", 18),
+	GATE_CAM(CLK_CAM_FAKE_ENG, "cam_fake_eng", "cam_sel", 19),
+	GATE_CAM(CLK_CAM_MAIN_MRAW0, "cam_main_mraw0", "cam_sel", 20),
+	GATE_CAM(CLK_CAM_MAIN_MRAW1, "cam_main_mraw1", "cam_sel", 21),
+	GATE_CAM(CLK_CAM_MAIN_MRAW2, "cam_main_mraw2", "cam_sel", 22),
+	GATE_CAM(CLK_CAM_MAIN_MRAW3, "cam_main_mraw3", "cam_sel", 23),
+	GATE_CAM(CLK_CAM_CAM2MM0_GALS, "cam_cam2mm0_gals", "cam_sel", 24),
+	GATE_CAM(CLK_CAM_CAM2MM1_GALS, "cam_cam2mm1_gals", "cam_sel", 25),
+	GATE_CAM(CLK_CAM_CAM2SYS_GALS, "cam_cam2sys_gals", "cam_sel", 26),
+};
+
+static const struct mtk_gate cam_mraw_clks[] = {
+	GATE_CAM(CLK_CAM_MRAW_LARBX, "cam_mraw_larbx", "cam_sel", 0),
+	GATE_CAM(CLK_CAM_MRAW_CAMTG, "cam_mraw_camtg", "cam_sel", 2),
+	GATE_CAM(CLK_CAM_MRAW_MRAW0, "cam_mraw_mraw0", "cam_sel", 3),
+	GATE_CAM(CLK_CAM_MRAW_MRAW1, "cam_mraw_mraw1", "cam_sel", 4),
+	GATE_CAM(CLK_CAM_MRAW_MRAW2, "cam_mraw_mraw2", "cam_sel", 5),
+	GATE_CAM(CLK_CAM_MRAW_MRAW3, "cam_mraw_mraw3", "cam_sel", 6),
+};
+
+static const struct mtk_gate cam_rawa_clks[] = {
+	GATE_CAM(CLK_CAM_RAWA_LARBX, "cam_rawa_larbx", "cam_sel", 0),
+	GATE_CAM(CLK_CAM_RAWA_CAM, "cam_rawa_cam", "cam_sel", 1),
+	GATE_CAM(CLK_CAM_RAWA_CAMTG, "cam_rawa_camtg", "cam_sel", 2),
+};
+
+static const struct mtk_gate cam_rawb_clks[] = {
+	GATE_CAM(CLK_CAM_RAWB_LARBX, "cam_rawb_larbx", "cam_sel", 0),
+	GATE_CAM(CLK_CAM_RAWB_CAM, "cam_rawb_cam", "cam_sel", 1),
+	GATE_CAM(CLK_CAM_RAWB_CAMTG, "cam_rawb_camtg", "cam_sel", 2),
+};
+
+static const struct mtk_gate cam_yuva_clks[] = {
+	GATE_CAM(CLK_CAM_YUVA_LARBX, "cam_yuva_larbx", "cam_sel", 0),
+	GATE_CAM(CLK_CAM_YUVA_CAM, "cam_yuva_cam", "cam_sel", 1),
+	GATE_CAM(CLK_CAM_YUVA_CAMTG, "cam_yuva_camtg", "cam_sel", 2),
+};
+
+static const struct mtk_gate cam_yuvb_clks[] = {
+	GATE_CAM(CLK_CAM_YUVB_LARBX, "cam_yuvb_larbx", "cam_sel", 0),
+	GATE_CAM(CLK_CAM_YUVB_CAM, "cam_yuvb_cam", "cam_sel", 1),
+	GATE_CAM(CLK_CAM_YUVB_CAMTG, "cam_yuvb_camtg", "cam_sel", 2),
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
+
+builtin_platform_driver(clk_mt8195_cam_drv);
-- 
2.18.0

