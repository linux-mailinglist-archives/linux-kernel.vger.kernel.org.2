Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC889408678
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhIMI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:28:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59924 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237987AbhIMI0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:26:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E9A312029BB;
        Mon, 13 Sep 2021 10:25:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DC5062029AF;
        Mon, 13 Sep 2021 10:25:14 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 98B0E202EC;
        Mon, 13 Sep 2021 10:25:14 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 7/8] clk: imx: Rework all imx_clk_hw_composite wrappers
Date:   Mon, 13 Sep 2021 11:24:49 +0300
Message-Id: <1631521490-17171-8-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than having multiple different macros for each different type
of imx8m_clk_hw_composite, implement them in such a way so we can
take advantage the most of the already defined simpler types. Basically,
we end up having one low-level __imx8m_clk_hw_composite function, a
wrapper to simplify the parents related arguments called
_imx8m_clk_hw_composite and then all the types can use those for each
specific case.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c |  4 +-
 drivers/clk/imx/clk.h              | 64 ++++++++++++++++--------------
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 04e728538cef..2dfd6149e528 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -171,7 +171,7 @@ static const struct clk_ops imx8m_clk_composite_mux_ops = {
 	.determine_rate = imx8m_clk_composite_mux_determine_rate,
 };
 
-struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
+struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
 					u32 composite_flags,
@@ -246,4 +246,4 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 	kfree(mux);
 	return ERR_CAST(hw);
 }
-EXPORT_SYMBOL_GPL(imx8m_clk_hw_composite_flags);
+EXPORT_SYMBOL_GPL(__imx8m_clk_hw_composite);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 224a22065064..4f3b87d8aee3 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -357,51 +357,55 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 #define IMX_COMPOSITE_BUS		BIT(1)
 #define IMX_COMPOSITE_FW_MANAGED	BIT(2)
 
-struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
+#define IMX_COMPOSITE_CLK_FLAGS_DEFAULT \
+	(CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+#define IMX_COMPOSITE_CLK_FLAGS_CRITICAL \
+	(IMX_COMPOSITE_CLK_FLAGS_DEFAULT | CLK_IS_CRITICAL)
+#define IMX_COMPOSITE_CLK_FLAGS_GET_RATE_NO_CACHE \
+	(IMX_COMPOSITE_CLK_FLAGS_DEFAULT | CLK_GET_RATE_NOCACHE)
+#define IMX_COMPOSITE_CLK_FLAGS_CRITICAL_GET_RATE_NO_CACHE \
+	(IMX_COMPOSITE_CLK_FLAGS_GET_RATE_NO_CACHE | CLK_IS_CRITICAL)
+
+struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 					    const char * const *parent_names,
 					    int num_parents,
 					    void __iomem *reg,
 					    u32 composite_flags,
 					    unsigned long flags);
 
+#define _imx8m_clk_hw_composite(name, parent_names, reg, composite_flags, flags) \
+	__imx8m_clk_hw_composite(name, parent_names, \
+		ARRAY_SIZE(parent_names), reg, composite_flags, flags)
+
+#define imx8m_clk_hw_composite(name, parent_names, reg) \
+	_imx8m_clk_hw_composite(name, parent_names, reg, \
+			IMX_COMPOSITE_CORE, IMX_COMPOSITE_CLK_FLAGS_DEFAULT)
+
+#define imx8m_clk_hw_composite_critical(name, parent_names, reg) \
+	_imx8m_clk_hw_composite(name, parent_names, reg, \
+			IMX_COMPOSITE_CORE, IMX_COMPOSITE_CLK_FLAGS_CRITICAL)
+
 #define imx8m_clk_hw_composite_bus(name, parent_names, reg)	\
-	imx8m_clk_hw_composite_flags(name, parent_names, \
-			ARRAY_SIZE(parent_names), reg, \
-			IMX_COMPOSITE_BUS, \
-			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+	_imx8m_clk_hw_composite(name, parent_names, reg, \
+			IMX_COMPOSITE_BUS, IMX_COMPOSITE_CLK_FLAGS_DEFAULT)
 
 #define imx8m_clk_hw_composite_bus_critical(name, parent_names, reg)	\
-	imx8m_clk_hw_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
-			IMX_COMPOSITE_BUS, \
-			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE | CLK_IS_CRITICAL)
+	_imx8m_clk_hw_composite(name, parent_names, reg, \
+			IMX_COMPOSITE_BUS, IMX_COMPOSITE_CLK_FLAGS_CRITICAL)
 
 #define imx8m_clk_hw_composite_core(name, parent_names, reg)	\
-	imx8m_clk_hw_composite_flags(name, parent_names, \
-			ARRAY_SIZE(parent_names), reg, \
-			IMX_COMPOSITE_CORE, \
-			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
-
-#define __imx8m_clk_hw_composite(name, parent_names, reg, flags) \
-	imx8m_clk_hw_composite_flags(name, parent_names, \
-		ARRAY_SIZE(parent_names), reg, 0, \
-		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
-
-#define __imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, flags) \
-	imx8m_clk_hw_composite_flags(name, parent_names, \
-		ARRAY_SIZE(parent_names), reg, IMX_COMPOSITE_FW_MANAGED, \
-		flags | CLK_GET_RATE_NOCACHE | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+	_imx8m_clk_hw_composite(name, parent_names, reg, \
+			IMX_COMPOSITE_CORE, IMX_COMPOSITE_CLK_FLAGS_DEFAULT)
 
 #define imx8m_clk_hw_fw_managed_composite(name, parent_names, reg) \
-	__imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, 0)
+	_imx8m_clk_hw_composite(name, parent_names, reg, \
+			IMX_COMPOSITE_FW_MANAGED, \
+			IMX_COMPOSITE_CLK_FLAGS_GET_RATE_NO_CACHE)
 
 #define imx8m_clk_hw_fw_managed_composite_critical(name, parent_names, reg) \
-	__imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, CLK_IS_CRITICAL)
-
-#define imx8m_clk_hw_composite(name, parent_names, reg) \
-	__imx8m_clk_hw_composite(name, parent_names, reg, 0)
-
-#define imx8m_clk_hw_composite_critical(name, parent_names, reg) \
-	__imx8m_clk_hw_composite(name, parent_names, reg, CLK_IS_CRITICAL)
+	_imx8m_clk_hw_composite(name, parent_names, reg, \
+			IMX_COMPOSITE_FW_MANAGED, \
+			IMX_COMPOSITE_CLK_FLAGS_CRITICAL_GET_RATE_NO_CACHE)
 
 struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
-- 
2.31.1

