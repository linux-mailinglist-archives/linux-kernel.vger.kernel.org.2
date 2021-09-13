Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C4A40866F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhIMI0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:26:42 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59882 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237952AbhIMI0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:26:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 43EB7202A0F;
        Mon, 13 Sep 2021 10:25:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 37AD72029AF;
        Mon, 13 Sep 2021 10:25:14 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E85D7202EC;
        Mon, 13 Sep 2021 10:25:13 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 5/8] clk: imx: Rework all clk_hw_register_mux wrappers
Date:   Mon, 13 Sep 2021 11:24:47 +0300
Message-Id: <1631521490-17171-6-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having multiple inline functions that were calling
clk_hw_register_mux, implement a generic low-level __imx_clk_hw_mux
and implement the rest as macros that pass on as arguments whatever
is needed in each case.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 62 +++++++++++++------------------------------
 1 file changed, 19 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 467877115771..a94170c5c83e 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -121,6 +121,9 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_pllv2(name, parent, base) \
 	to_clk(imx_clk_hw_pllv2(name, parent, base))
 
+#define imx_clk_mux_flags(name, reg, shift, width, parents, num_parents, flags) \
+	to_clk(imx_clk_hw_mux_flags(name, reg, shift, width, parents, num_parents, flags))
+
 #define imx_clk_hw_gate(name, parent, reg, shift) \
 	imx_clk_hw_gate_flags(name, parent, reg, shift, 0)
 
@@ -157,6 +160,21 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_hw_gate4_flags(name, parent, reg, shift, flags) \
 	imx_clk_hw_gate2_flags(name, parent, reg, shift, flags | CLK_OPS_PARENT_ENABLE)
 
+#define imx_clk_hw_mux2(name, reg, shift, width, parents, num_parents) \
+	imx_clk_hw_mux2_flags(name, reg, shift, width, parents, num_parents, 0)
+
+#define imx_clk_hw_mux(name, reg, shift, width, parents, num_parents) \
+	__imx_clk_hw_mux(name, reg, shift, width, parents, num_parents, 0, 0)
+
+#define imx_clk_hw_mux_flags(name, reg, shift, width, parents, num_parents, flags) \
+	__imx_clk_hw_mux(name, reg, shift, width, parents, num_parents, flags, 0)
+
+#define imx_clk_hw_mux_ldb(name, reg, shift, width, parents, num_parents) \
+	__imx_clk_hw_mux(name, reg, shift, width, parents, num_parents, CLK_SET_RATE_PARENT, CLK_MUX_READ_ONLY)
+
+#define imx_clk_hw_mux2_flags(name, reg, shift, width, parents, num_parents, flags) \
+	__imx_clk_hw_mux(name, reg, shift, width, parents, num_parents, flags | CLK_OPS_PARENT_ENABLE, 0)
+
 struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 				const char *parent_name, void __iomem *base,
 				const struct imx_pll14xx_clk *pll_clk);
@@ -278,15 +296,6 @@ static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
-static inline struct clk_hw *imx_clk_hw_mux_ldb(const char *name, void __iomem *reg,
-			u8 shift, u8 width, const char * const *parents,
-			int num_parents)
-{
-	return clk_hw_register_mux(NULL, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT, reg,
-			shift, width, CLK_MUX_READ_ONLY, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_fixed_factor(const char *name,
 		const char *parent, unsigned int mult, unsigned int div)
 {
@@ -338,7 +347,7 @@ static inline struct clk_hw *__imx_clk_hw_gate2(const char *name, const char *pa
 					shift, cgr_val, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
-static inline struct clk_hw *imx_clk_hw_mux(const char *name, void __iomem *reg,
+static inline struct clk_hw *__imx_clk_hw_mux(const char *name, void __iomem *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents, unsigned long flags, unsigned long clk_mux_flags)
 {
@@ -347,39 +356,6 @@ static inline struct clk_hw *imx_clk_hw_mux(const char *name, void __iomem *reg,
 			width, clk_mux_flags, &imx_ccm_lock);
 }
 
-static inline struct clk_hw *imx_clk_hw_mux2(const char *name, void __iomem *reg,
-					     u8 shift, u8 width,
-					     const char * const *parents,
-					     int num_parents)
-{
-	return clk_hw_register_mux(NULL, name, parents, num_parents,
-				   CLK_SET_RATE_NO_REPARENT |
-				   CLK_OPS_PARENT_ENABLE,
-				   reg, shift, width, 0, &imx_ccm_lock);
-}
-
-static inline struct clk_hw *imx_clk_hw_mux2_flags(const char *name,
-		void __iomem *reg, u8 shift, u8 width,
-		const char * const *parents,
-		int num_parents, unsigned long flags)
-{
-	return clk_hw_register_mux(NULL, name, parents, num_parents,
-			flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, width, 0, &imx_ccm_lock);
-}
-
-static inline struct clk_hw *imx_clk_hw_mux_flags(const char *name,
-						  void __iomem *reg, u8 shift,
-						  u8 width,
-						  const char * const *parents,
-						  int num_parents,
-						  unsigned long flags)
-{
-	return clk_hw_register_mux(NULL, name, parents, num_parents,
-				   flags | CLK_SET_RATE_NO_REPARENT,
-				   reg, shift, width, 0, &imx_ccm_lock);
-}
-
 struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
-- 
2.31.1

