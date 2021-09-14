Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D040A35F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhINCTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:19:03 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34388 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237856AbhINCSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:41 -0400
X-UUID: 6089aa377c4d467e8b0f745c6c0b092c-20210914
X-UUID: 6089aa377c4d467e8b0f745c6c0b092c-20210914
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1609149092; Tue, 14 Sep 2021 10:17:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:17:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:17:22 +0800
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
Subject: [v3 14/24] clk: mediatek: Add MT8195 mfgcfg clock support
Date:   Tue, 14 Sep 2021 10:16:23 +0800
Message-ID: <20210914021633.26377-15-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 mfg clock controller which provides clock gate
control for GPU.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile         |  2 +-
 drivers/clk/mediatek/clk-mt8195-mfg.c | 47 +++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-mfg.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index e9008dce7b2f..32f6afcf78da 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -83,6 +83,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o \
 				   clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o \
 				   clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
-				   clk-mt8195-ipe.o
+				   clk-mt8195-ipe.o clk-mt8195-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
new file mode 100644
index 000000000000..aca6d9c0837c
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
@@ -0,0 +1,47 @@
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
+static const struct mtk_gate_regs mfg_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_MFG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate mfg_clks[] = {
+	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "top_mfg_core_tmp", 0),
+};
+
+static const struct mtk_clk_desc mfg_desc = {
+	.clks = mfg_clks,
+	.num_clks = ARRAY_SIZE(mfg_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_mfg[] = {
+	{
+		.compatible = "mediatek,mt8195-mfgcfg",
+		.data = &mfg_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_mfg_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-mfg",
+		.of_match_table = of_match_clk_mt8195_mfg,
+	},
+};
+builtin_platform_driver(clk_mt8195_mfg_drv);
-- 
2.18.0

