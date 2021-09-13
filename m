Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F0640866E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhIMI0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:26:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59834 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237890AbhIMI0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:26:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E6997202A0A;
        Mon, 13 Sep 2021 10:25:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D942A202A02;
        Mon, 13 Sep 2021 10:25:13 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 96309202EC;
        Mon, 13 Sep 2021 10:25:13 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 4/8] clk: imx: Rework all clk_hw_register_gate2 wrappers
Date:   Mon, 13 Sep 2021 11:24:46 +0300
Message-Id: <1631521490-17171-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having multiple inline functions that were calling
clk_hw_register_gate2, implement a generic low-level __imx_clk_hw_gate2
and implement the rest as macros that pass on as arguments whatever
is needed in each case.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 81 +++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 53 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 2928ce40434e..467877115771 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -100,6 +100,9 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_gate2(name, parent, reg, shift) \
 	to_clk(imx_clk_hw_gate2(name, parent, reg, shift))
 
+#define imx_clk_gate2_cgr(name, parent, reg, shift, cgr_val) \
+	to_clk(__imx_clk_hw_gate2(name, parent, reg, shift, cgr_val, 0, NULL))
+
 #define imx_clk_gate2_flags(name, parent, reg, shift, flags) \
 	to_clk(imx_clk_hw_gate2_flags(name, parent, reg, shift, flags))
 
@@ -121,6 +124,9 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_hw_gate(name, parent, reg, shift) \
 	imx_clk_hw_gate_flags(name, parent, reg, shift, 0)
 
+#define imx_clk_hw_gate2(name, parent, reg, shift) \
+	imx_clk_hw_gate2_flags(name, parent, reg, shift, 0)
+
 #define imx_clk_hw_gate_dis(name, parent, reg, shift) \
 	imx_clk_hw_gate_dis_flags(name, parent, reg, shift, 0)
 
@@ -130,12 +136,27 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_hw_gate_flags(name, parent, reg, shift, flags) \
 	__imx_clk_hw_gate(name, parent, reg, shift, flags, 0)
 
+#define imx_clk_hw_gate2_flags(name, parent, reg, shift, flags) \
+	__imx_clk_hw_gate2(name, parent, reg, shift, 0x3, flags, NULL)
+
+#define imx_clk_hw_gate2_shared(name, parent, reg, shift, shared_count) \
+	__imx_clk_hw_gate2(name, parent, reg, shift, 0x3, 0, shared_count)
+
+#define imx_clk_hw_gate2_shared2(name, parent, reg, shift, shared_count) \
+	__imx_clk_hw_gate2(name, parent, reg, shift, 0x3, CLK_OPS_PARENT_ENABLE, shared_count)
+
 #define imx_clk_hw_gate3(name, parent, reg, shift) \
 	imx_clk_hw_gate3_flags(name, parent, reg, shift, 0)
 
 #define imx_clk_hw_gate3_flags(name, parent, reg, shift, flags) \
 	__imx_clk_hw_gate(name, parent, reg, shift, flags | CLK_OPS_PARENT_ENABLE, 0)
 
+#define imx_clk_hw_gate4(name, parent, reg, shift) \
+	imx_clk_hw_gate4_flags(name, parent, reg, shift, 0)
+
+#define imx_clk_hw_gate4_flags(name, parent, reg, shift, flags) \
+	imx_clk_hw_gate2_flags(name, parent, reg, shift, flags | CLK_OPS_PARENT_ENABLE)
+
 struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 				const char *parent_name, void __iomem *base,
 				const struct imx_pll14xx_clk *pll_clk);
@@ -308,68 +329,22 @@ static inline struct clk_hw *__imx_clk_hw_gate(const char *name, const char *par
 					shift, clk_gate_flags, &imx_ccm_lock);
 }
 
-static inline struct clk_hw *imx_clk_hw_gate2(const char *name, const char *parent,
-		void __iomem *reg, u8 shift)
-{
-	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, 0x3, 0x3, 0, &imx_ccm_lock, NULL);
-}
-
-static inline struct clk_hw *imx_clk_hw_gate2_flags(const char *name, const char *parent,
-		void __iomem *reg, u8 shift, unsigned long flags)
+static inline struct clk_hw *__imx_clk_hw_gate2(const char *name, const char *parent,
+						void __iomem *reg, u8 shift, u8 cgr_val,
+						unsigned long flags,
+						unsigned int *share_count)
 {
 	return clk_hw_register_gate2(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
-			shift, 0x3, 0x3, 0, &imx_ccm_lock, NULL);
-}
-
-static inline struct clk_hw *imx_clk_hw_gate2_shared(const char *name,
-		const char *parent, void __iomem *reg, u8 shift,
-		unsigned int *share_count)
-{
-	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, 0x3, 0x3, 0, &imx_ccm_lock, share_count);
-}
-
-static inline struct clk_hw *imx_clk_hw_gate2_shared2(const char *name,
-		const char *parent, void __iomem *reg, u8 shift,
-		unsigned int *share_count)
-{
-	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0x3, 0,
-				  &imx_ccm_lock, share_count);
-}
-
-static inline struct clk *imx_clk_gate2_cgr(const char *name,
-		const char *parent, void __iomem *reg, u8 shift, u8 cgr_val)
-{
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, cgr_val, 0x3, 0, &imx_ccm_lock, NULL);
-}
-
-static inline struct clk_hw *imx_clk_hw_gate4(const char *name, const char *parent,
-		void __iomem *reg, u8 shift)
-{
-	return clk_hw_register_gate2(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, 0x3, 0x3, 0, &imx_ccm_lock, NULL);
-}
-
-static inline struct clk_hw *imx_clk_hw_gate4_flags(const char *name,
-		const char *parent, void __iomem *reg, u8 shift,
-		unsigned long flags)
-{
-	return clk_hw_register_gate2(NULL, name, parent,
-			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, 0x3, 0x3, 0, &imx_ccm_lock, NULL);
+					shift, cgr_val, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
 static inline struct clk_hw *imx_clk_hw_mux(const char *name, void __iomem *reg,
 			u8 shift, u8 width, const char * const *parents,
-			int num_parents)
+			int num_parents, unsigned long flags, unsigned long clk_mux_flags)
 {
 	return clk_hw_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT, reg, shift,
-			width, 0, &imx_ccm_lock);
+			width, clk_mux_flags, &imx_ccm_lock);
 }
 
 static inline struct clk_hw *imx_clk_hw_mux2(const char *name, void __iomem *reg,
-- 
2.31.1

