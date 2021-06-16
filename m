Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D373AA6EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhFPWwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:52:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33566 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234322AbhFPWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:52:11 -0400
X-UUID: 5eb835c1e7e4496297c0d61d2a17a678-20210617
X-UUID: 5eb835c1e7e4496297c0d61d2a17a678-20210617
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 725970055; Thu, 17 Jun 2021 06:50:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:49:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:49:59 +0800
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
Subject: [PATCH 11/22] clk: mediatek: Add MT8195 mfgcfg clock support
Date:   Thu, 17 Jun 2021 06:47:32 +0800
Message-ID: <20210616224743.5109-12-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 mfgcfg clock provider

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |  6 ++++
 drivers/clk/mediatek/Makefile         |  1 +
 drivers/clk/mediatek/clk-mt8195-mfg.c | 49 +++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-mfg.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index ef7d4b433eee..066c14a89cee 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -624,6 +624,12 @@ config COMMON_CLK_MT8195_IPESYS
 	help
 	  This driver supports MediaTek MT8195 ipesys clocks.
 
+config COMMON_CLK_MT8195_MFGCFG
+	bool "Clock driver for MediaTek MT8195 mfgcfg"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 mfgcfg clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 991a9be7ac46..9b09e7f640d1 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -87,5 +87,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_CAMSYS) += clk-mt8195-cam.o
 obj-$(CONFIG_COMMON_CLK_MT8195_CCUSYS) += clk-mt8195-ccu.o
 obj-$(CONFIG_COMMON_CLK_MT8195_IMGSYS) += clk-mt8195-img.o
 obj-$(CONFIG_COMMON_CLK_MT8195_IPESYS) += clk-mt8195-ipe.o
+obj-$(CONFIG_COMMON_CLK_MT8195_MFGCFG) += clk-mt8195-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
new file mode 100644
index 000000000000..a9b1d337cd01
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
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
+	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel", 0),
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
+
+builtin_platform_driver(clk_mt8195_mfg_drv);
-- 
2.18.0

