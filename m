Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12103AA6EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhFPWwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:52:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33591 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234331AbhFPWwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:52:14 -0400
X-UUID: f27f954332114cc0bedb5f94aba4070f-20210617
X-UUID: f27f954332114cc0bedb5f94aba4070f-20210617
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 971883785; Thu, 17 Jun 2021 06:50:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:50:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:50:04 +0800
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
Subject: [PATCH 12/22] clk: mediatek: Add MT8195 scp adsp clock support
Date:   Thu, 17 Jun 2021 06:47:33 +0800
Message-ID: <20210616224743.5109-13-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 scp adsp clock provider

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig               |  6 +++
 drivers/clk/mediatek/Makefile              |  1 +
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c | 49 ++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-scp_adsp.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 066c14a89cee..7cb745d47770 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -630,6 +630,12 @@ config COMMON_CLK_MT8195_MFGCFG
 	help
 	  This driver supports MediaTek MT8195 mfgcfg clocks.
 
+config COMMON_CLK_MT8195_SCP_ADSP
+	bool "Clock driver for MediaTek MT8195 scp_adsp"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 scp_adsp clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 9b09e7f640d1..058ff55468a2 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -88,5 +88,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_CCUSYS) += clk-mt8195-ccu.o
 obj-$(CONFIG_COMMON_CLK_MT8195_IMGSYS) += clk-mt8195-img.o
 obj-$(CONFIG_COMMON_CLK_MT8195_IPESYS) += clk-mt8195-ipe.o
 obj-$(CONFIG_COMMON_CLK_MT8195_MFGCFG) += clk-mt8195-mfg.o
+obj-$(CONFIG_COMMON_CLK_MT8195_SCP_ADSP) += clk-mt8195-scp_adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
new file mode 100644
index 000000000000..2ecf90cabadb
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
@@ -0,0 +1,49 @@
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
+static const struct mtk_gate_regs scp_adsp_cg_regs = {
+	.set_ofs = 0x180,
+	.clr_ofs = 0x180,
+	.sta_ofs = 0x180,
+};
+
+#define GATE_SCP_ADSP(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &scp_adsp_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate scp_adsp_clks[] = {
+	GATE_SCP_ADSP(CLK_SCP_ADSP_AUDIODSP, "scp_adsp_audiodsp", "adsp_sel", 0),
+};
+
+static const struct mtk_clk_desc scp_adsp_desc = {
+	.clks = scp_adsp_clks,
+	.num_clks = ARRAY_SIZE(scp_adsp_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_scp_adsp[] = {
+	{
+		.compatible = "mediatek,mt8195-scp_adsp",
+		.data = &scp_adsp_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_scp_adsp_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-scp_adsp",
+		.of_match_table = of_match_clk_mt8195_scp_adsp,
+	},
+};
+
+builtin_platform_driver(clk_mt8195_scp_adsp_drv);
-- 
2.18.0

