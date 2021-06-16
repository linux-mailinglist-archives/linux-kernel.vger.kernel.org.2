Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD29F3AA6DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhFPWvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:51:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33351 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234292AbhFPWvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:51:47 -0400
X-UUID: c50ff69fbd144a58b5e3c25dce95a524-20210617
X-UUID: c50ff69fbd144a58b5e3c25dce95a524-20210617
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 500044764; Thu, 17 Jun 2021 06:49:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:49:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:49:35 +0800
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
Subject: [PATCH 06/22] clk: mediatek: Add MT8195 audio src clock support
Date:   Thu, 17 Jun 2021 06:47:27 +0800
Message-ID: <20210616224743.5109-7-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 audio src source clock provider

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig              |  6 +++
 drivers/clk/mediatek/Makefile             |  1 +
 drivers/clk/mediatek/clk-mt8195-aud_src.c | 60 +++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-aud_src.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index e2bae9d490a4..62dd02bc2755 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -594,6 +594,12 @@ config COMMON_CLK_MT8195_AUDSYS
 	help
 	  This driver supports MediaTek MT8195 audsys clocks.
 
+config COMMON_CLK_MT8195_AUDSYS_SRC
+	bool "Clock driver for MediaTek MT8195 audsys_src"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 audsys_src clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index f27c04314186..52a5d3f49ff0 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -82,5 +82,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195.o
 obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS) += clk-mt8195-aud.o
+obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS_SRC) += clk-mt8195-aud_src.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-aud_src.c b/drivers/clk/mediatek/clk-mt8195-aud_src.c
new file mode 100644
index 000000000000..7cabe0d68825
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-aud_src.c
@@ -0,0 +1,60 @@
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
+static const struct mtk_gate_regs aud_src_cg_regs = {
+	.set_ofs = 0x1004,
+	.clr_ofs = 0x1004,
+	.sta_ofs = 0x1004,
+};
+
+#define GATE_AUD_SRC(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &aud_src_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate aud_src_clks[] = {
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC0, "aud_src_asrc0", "asm_h_sel", 0),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC1, "aud_src_asrc1", "asm_h_sel", 1),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC2, "aud_src_asrc2", "asm_h_sel", 2),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC3, "aud_src_asrc3", "asm_h_sel", 3),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC4, "aud_src_asrc4", "asm_h_sel", 4),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC5, "aud_src_asrc5", "asm_h_sel", 5),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC6, "aud_src_asrc6", "asm_h_sel", 6),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC7, "aud_src_asrc7", "asm_h_sel", 7),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC8, "aud_src_asrc8", "asm_h_sel", 8),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC9, "aud_src_asrc9", "asm_h_sel", 9),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC10, "aud_src_asrc10", "asm_h_sel", 10),
+	GATE_AUD_SRC(CLK_AUD_SRC_ASRC11, "aud_src_asrc11", "asm_h_sel", 11),
+};
+
+static const struct mtk_clk_desc aud_src_desc = {
+	.clks = aud_src_clks,
+	.num_clks = ARRAY_SIZE(aud_src_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_aud_src[] = {
+	{
+		.compatible = "mediatek,mt8195-audsys_src",
+		.data = &aud_src_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_aud_src_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-aud_src",
+		.of_match_table = of_match_clk_mt8195_aud_src,
+	},
+};
+
+builtin_platform_driver(clk_mt8195_aud_src_drv);
-- 
2.18.0

