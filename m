Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB03940866D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhIMI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:26:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56132 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237835AbhIMI03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:26:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 952BD1A2A45;
        Mon, 13 Sep 2021 10:25:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 871F71A2A43;
        Mon, 13 Sep 2021 10:25:13 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 43B5C202EC;
        Mon, 13 Sep 2021 10:25:13 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 3/8] clk: imx: Rework all clk_hw_register_gate wrappers
Date:   Mon, 13 Sep 2021 11:24:45 +0300
Message-Id: <1631521490-17171-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having multiple inline functions that were calling
clk_hw_register_gate, implement a generic low-level __imx_clk_hw_gate
and implement the rest as macros that pass on as arguments whatever
is needed in each case.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 64 ++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 371d8de417ef..2928ce40434e 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -118,6 +118,24 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_pllv2(name, parent, base) \
 	to_clk(imx_clk_hw_pllv2(name, parent, base))
 
+#define imx_clk_hw_gate(name, parent, reg, shift) \
+	imx_clk_hw_gate_flags(name, parent, reg, shift, 0)
+
+#define imx_clk_hw_gate_dis(name, parent, reg, shift) \
+	imx_clk_hw_gate_dis_flags(name, parent, reg, shift, 0)
+
+#define imx_clk_hw_gate_dis_flags(name, parent, reg, shift, flags) \
+	__imx_clk_hw_gate(name, parent, reg, shift, flags, CLK_GATE_SET_TO_DISABLE)
+
+#define imx_clk_hw_gate_flags(name, parent, reg, shift, flags) \
+	__imx_clk_hw_gate(name, parent, reg, shift, flags, 0)
+
+#define imx_clk_hw_gate3(name, parent, reg, shift) \
+	imx_clk_hw_gate3_flags(name, parent, reg, shift, 0)
+
+#define imx_clk_hw_gate3_flags(name, parent, reg, shift, flags) \
+	__imx_clk_hw_gate(name, parent, reg, shift, flags | CLK_OPS_PARENT_ENABLE, 0)
+
 struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 				const char *parent_name, void __iomem *base,
 				const struct imx_pll14xx_clk *pll_clk);
@@ -281,32 +299,13 @@ static inline struct clk_hw *imx_clk_hw_divider2(const char *name, const char *p
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
-static inline struct clk_hw *imx_clk_hw_gate_flags(const char *name, const char *parent,
-		void __iomem *reg, u8 shift, unsigned long flags)
-{
-	return clk_hw_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
-			shift, 0, &imx_ccm_lock);
-}
-
-static inline struct clk_hw *imx_clk_hw_gate(const char *name, const char *parent,
-					     void __iomem *reg, u8 shift)
-{
-	return clk_hw_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-				    shift, 0, &imx_ccm_lock);
-}
-
-static inline struct clk_hw *imx_clk_hw_gate_dis(const char *name, const char *parent,
-		void __iomem *reg, u8 shift)
-{
-	return clk_hw_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);
-}
-
-static inline struct clk_hw *imx_clk_hw_gate_dis_flags(const char *name, const char *parent,
-		void __iomem *reg, u8 shift, unsigned long flags)
+static inline struct clk_hw *__imx_clk_hw_gate(const char *name, const char *parent,
+						void __iomem *reg, u8 shift,
+						unsigned long flags,
+						unsigned long clk_gate_flags)
 {
 	return clk_hw_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
-			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);
+					shift, clk_gate_flags, &imx_ccm_lock);
 }
 
 static inline struct clk_hw *imx_clk_hw_gate2(const char *name, const char *parent,
@@ -347,23 +346,6 @@ static inline struct clk *imx_clk_gate2_cgr(const char *name,
 			shift, cgr_val, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
-static inline struct clk_hw *imx_clk_hw_gate3(const char *name, const char *parent,
-		void __iomem *reg, u8 shift)
-{
-	return clk_hw_register_gate(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, 0, &imx_ccm_lock);
-}
-
-static inline struct clk_hw *imx_clk_hw_gate3_flags(const char *name,
-		const char *parent, void __iomem *reg, u8 shift,
-		unsigned long flags)
-{
-	return clk_hw_register_gate(NULL, name, parent,
-			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_gate4(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
-- 
2.31.1

