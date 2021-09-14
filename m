Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4262640A361
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhINCTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:19:12 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34594 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237662AbhINCSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:48 -0400
X-UUID: 0a0db5bac81540d48a32504d946e71b8-20210914
X-UUID: 0a0db5bac81540d48a32504d946e71b8-20210914
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 979974476; Tue, 14 Sep 2021 10:17:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:17:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:17:27 +0800
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
Subject: [v3 16/24] clk: mediatek: Add MT8195 vdecsys clock support
Date:   Tue, 14 Sep 2021 10:16:25 +0800
Message-ID: <20210914021633.26377-17-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 vdec clock controllers which provide clock gate
control for video decoder.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Makefile          |   3 +-
 drivers/clk/mediatek/clk-mt8195-vdec.c | 104 +++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdec.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 4a823da574e6..71b3eb3fb93d 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o \
 				   clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o \
 				   clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
-				   clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o
+				   clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
+				   clk-mt8195-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-vdec.c b/drivers/clk/mediatek/clk-mt8195-vdec.c
new file mode 100644
index 000000000000..a1df04f42a90
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-vdec.c
@@ -0,0 +1,104 @@
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
+static const struct mtk_gate_regs vdec0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs vdec1_cg_regs = {
+	.set_ofs = 0x200,
+	.clr_ofs = 0x204,
+	.sta_ofs = 0x200,
+};
+
+static const struct mtk_gate_regs vdec2_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x8,
+};
+
+#define GATE_VDEC0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+#define GATE_VDEC1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+#define GATE_VDEC2(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec2_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate vdec_clks[] = {
+	/* VDEC0 */
+	GATE_VDEC0(CLK_VDEC_VDEC, "vdec_vdec", "top_vdec", 0),
+	/* VDEC1 */
+	GATE_VDEC1(CLK_VDEC_LAT, "vdec_lat", "top_vdec", 0),
+	/* VDEC2 */
+	GATE_VDEC2(CLK_VDEC_LARB1, "vdec_larb1", "top_vdec", 0),
+};
+
+static const struct mtk_gate vdec_core1_clks[] = {
+	/* VDEC0 */
+	GATE_VDEC0(CLK_VDEC_CORE1_VDEC, "vdec_core1_vdec", "top_vdec", 0),
+	/* VDEC1 */
+	GATE_VDEC1(CLK_VDEC_CORE1_LAT, "vdec_core1_lat", "top_vdec", 0),
+	/* VDEC2 */
+	GATE_VDEC2(CLK_VDEC_CORE1_LARB1, "vdec_core1_larb1", "top_vdec", 0),
+};
+
+static const struct mtk_gate vdec_soc_clks[] = {
+	/* VDEC0 */
+	GATE_VDEC0(CLK_VDEC_SOC_VDEC, "vdec_soc_vdec", "top_vdec", 0),
+	/* VDEC1 */
+	GATE_VDEC1(CLK_VDEC_SOC_LAT, "vdec_soc_lat", "top_vdec", 0),
+	/* VDEC2 */
+	GATE_VDEC2(CLK_VDEC_SOC_LARB1, "vdec_soc_larb1", "top_vdec", 0),
+};
+
+static const struct mtk_clk_desc vdec_desc = {
+	.clks = vdec_clks,
+	.num_clks = ARRAY_SIZE(vdec_clks),
+};
+
+static const struct mtk_clk_desc vdec_core1_desc = {
+	.clks = vdec_core1_clks,
+	.num_clks = ARRAY_SIZE(vdec_core1_clks),
+};
+
+static const struct mtk_clk_desc vdec_soc_desc = {
+	.clks = vdec_soc_clks,
+	.num_clks = ARRAY_SIZE(vdec_soc_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_vdec[] = {
+	{
+		.compatible = "mediatek,mt8195-vdecsys",
+		.data = &vdec_desc,
+	}, {
+		.compatible = "mediatek,mt8195-vdecsys_core1",
+		.data = &vdec_core1_desc,
+	}, {
+		.compatible = "mediatek,mt8195-vdecsys_soc",
+		.data = &vdec_soc_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_vdec_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-vdec",
+		.of_match_table = of_match_clk_mt8195_vdec,
+	},
+};
+builtin_platform_driver(clk_mt8195_vdec_drv);
-- 
2.18.0

