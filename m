Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ACA408669
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbhIMI0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:26:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56082 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235824AbhIMI03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:26:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E49871A2A16;
        Mon, 13 Sep 2021 10:25:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D655A1A29F9;
        Mon, 13 Sep 2021 10:25:12 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9341A202EC;
        Mon, 13 Sep 2021 10:25:12 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 1/8] clk: imx: Remove unused helpers
Date:   Mon, 13 Sep 2021 11:24:43 +0300
Message-Id: <1631521490-17171-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all the helpers that are not referenced anywhere
anymore. Most of them are not clk_hw based. The rest are
passing the device as an argument and were intented for
BLK_CTL driver usage, but that is not the case anymore since
the BLK_CTL is (or will be) implemented outside of CCF.

 - imx_clk_divider2
 - imx_clk_gate2_shared2
 - imx_clk_gate3
 - imx_clk_gate4
 - imx_clk_frac_pll
 - imx_clk_sscg_pll
 - imx_clk_pll14xx
 - imx_clk_pll14xx
 - imx_clk_divider2_flags
 - imx_dev_clk_hw_gate
 - imx_dev_clk_hw_gate_shared
 - imx_clk_gate3_flags
 - imx_clk_gate4_flags
 - imx_dev_clk_hw_mux
 - imx_clk_mux2
 - imx_dev_clk_hw_mux_flags
 - imx8m_clk_composite_flags
 - __imx8m_clk_composite
 - imx8m_clk_composite
 - imx8m_clk_composite_critical

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 103 ------------------------------------------
 1 file changed, 103 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index e144f983fd8c..4a755498cb17 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -88,9 +88,6 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_divider(name, parent, reg, shift, width) \
 	to_clk(imx_clk_hw_divider(name, parent, reg, shift, width))
 
-#define imx_clk_divider2(name, parent, reg, shift, width) \
-	to_clk(imx_clk_hw_divider2(name, parent, reg, shift, width))
-
 #define imx_clk_divider_flags(name, parent, reg, shift, width, flags) \
 	to_clk(imx_clk_hw_divider_flags(name, parent, reg, shift, width, flags))
 
@@ -106,15 +103,6 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_gate2_flags(name, parent, reg, shift, flags) \
 	to_clk(imx_clk_hw_gate2_flags(name, parent, reg, shift, flags))
 
-#define imx_clk_gate2_shared2(name, parent, reg, shift, share_count) \
-	to_clk(imx_clk_hw_gate2_shared2(name, parent, reg, shift, share_count))
-
-#define imx_clk_gate3(name, parent, reg, shift) \
-	to_clk(imx_clk_hw_gate3(name, parent, reg, shift))
-
-#define imx_clk_gate4(name, parent, reg, shift) \
-	to_clk(imx_clk_hw_gate4(name, parent, reg, shift))
-
 #define imx_clk_mux(name, reg, shift, width, parents, num_parents) \
 	to_clk(imx_clk_hw_mux(name, reg, shift, width, parents, num_parents))
 
@@ -124,20 +112,6 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_pllv2(name, parent, base) \
 	to_clk(imx_clk_hw_pllv2(name, parent, base))
 
-#define imx_clk_frac_pll(name, parent_name, base) \
-	to_clk(imx_clk_hw_frac_pll(name, parent_name, base))
-
-#define imx_clk_sscg_pll(name, parent_names, num_parents, parent,\
-				bypass1, bypass2, base, flags) \
-	to_clk(imx_clk_hw_sscg_pll(name, parent_names, num_parents, parent,\
-				bypass1, bypass2, base, flags))
-
-struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
-		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
-
-#define imx_clk_pll14xx(name, parent_name, base, pll_clk) \
-	to_clk(imx_clk_hw_pll14xx(name, parent_name, base, pll_clk))
-
 struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 				const char *parent_name, void __iomem *base,
 				const struct imx_pll14xx_clk *pll_clk);
@@ -301,15 +275,6 @@ static inline struct clk_hw *imx_clk_hw_divider2(const char *name, const char *p
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
-static inline struct clk *imx_clk_divider2_flags(const char *name,
-		const char *parent, void __iomem *reg, u8 shift, u8 width,
-		unsigned long flags)
-{
-	return clk_register_divider(NULL, name, parent,
-			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, width, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_gate_flags(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, unsigned long flags)
 {
@@ -324,13 +289,6 @@ static inline struct clk_hw *imx_clk_hw_gate(const char *name, const char *paren
 				    shift, 0, &imx_ccm_lock);
 }
 
-static inline struct clk_hw *imx_dev_clk_hw_gate(struct device *dev, const char *name,
-						const char *parent, void __iomem *reg, u8 shift)
-{
-	return clk_hw_register_gate(dev, name, parent, CLK_SET_RATE_PARENT, reg,
-				    shift, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_gate_dis(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -376,16 +334,6 @@ static inline struct clk_hw *imx_clk_hw_gate2_shared2(const char *name,
 				  &imx_ccm_lock, share_count);
 }
 
-static inline struct clk_hw *imx_dev_clk_hw_gate_shared(struct device *dev,
-				const char *name, const char *parent,
-				void __iomem *reg, u8 shift,
-				unsigned int *share_count)
-{
-	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-					CLK_OPS_PARENT_ENABLE, reg, shift, 0x1,
-					0x1, 0, &imx_ccm_lock, share_count);
-}
-
 static inline struct clk *imx_clk_gate2_cgr(const char *name,
 		const char *parent, void __iomem *reg, u8 shift, u8 cgr_val)
 {
@@ -410,9 +358,6 @@ static inline struct clk_hw *imx_clk_hw_gate3_flags(const char *name,
 			reg, shift, 0, &imx_ccm_lock);
 }
 
-#define imx_clk_gate3_flags(name, parent, reg, shift, flags) \
-	to_clk(imx_clk_hw_gate3_flags(name, parent, reg, shift, flags))
-
 static inline struct clk_hw *imx_clk_hw_gate4(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -430,9 +375,6 @@ static inline struct clk_hw *imx_clk_hw_gate4_flags(const char *name,
 			reg, shift, 0x3, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
-#define imx_clk_gate4_flags(name, parent, reg, shift, flags) \
-	to_clk(imx_clk_hw_gate4_flags(name, parent, reg, shift, flags))
-
 static inline struct clk_hw *imx_clk_hw_mux(const char *name, void __iomem *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
@@ -442,24 +384,6 @@ static inline struct clk_hw *imx_clk_hw_mux(const char *name, void __iomem *reg,
 			width, 0, &imx_ccm_lock);
 }
 
-static inline struct clk_hw *imx_dev_clk_hw_mux(struct device *dev,
-			const char *name, void __iomem *reg, u8 shift,
-			u8 width, const char * const *parents, int num_parents)
-{
-	return clk_hw_register_mux(dev, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT | CLK_SET_PARENT_GATE,
-			reg, shift, width, 0, &imx_ccm_lock);
-}
-
-static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
-			u8 shift, u8 width, const char * const *parents,
-			int num_parents)
-{
-	return clk_register_mux(NULL, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, width, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_mux2(const char *name, void __iomem *reg,
 					     u8 shift, u8 width,
 					     const char * const *parents,
@@ -513,19 +437,6 @@ static inline struct clk_hw *imx_clk_hw_mux_flags(const char *name,
 				   reg, shift, width, 0, &imx_ccm_lock);
 }
 
-static inline struct clk_hw *imx_dev_clk_hw_mux_flags(struct device *dev,
-						  const char *name,
-						  void __iomem *reg, u8 shift,
-						  u8 width,
-						  const char * const *parents,
-						  int num_parents,
-						  unsigned long flags)
-{
-	return clk_hw_register_mux(dev, name, parents, num_parents,
-				   flags | CLK_SET_RATE_NO_REPARENT,
-				   reg, shift, width, 0, &imx_ccm_lock);
-}
-
 struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
@@ -558,11 +469,6 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 			IMX_COMPOSITE_CORE, \
 			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
 
-#define imx8m_clk_composite_flags(name, parent_names, num_parents, reg, \
-				  flags) \
-	to_clk(imx8m_clk_hw_composite_flags(name, parent_names, \
-				num_parents, reg, 0, flags))
-
 #define __imx8m_clk_hw_composite(name, parent_names, reg, flags) \
 	imx8m_clk_hw_composite_flags(name, parent_names, \
 		ARRAY_SIZE(parent_names), reg, 0, \
@@ -579,21 +485,12 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 #define imx8m_clk_hw_fw_managed_composite_critical(name, parent_names, reg) \
 	__imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, CLK_IS_CRITICAL)
 
-#define __imx8m_clk_composite(name, parent_names, reg, flags) \
-	to_clk(__imx8m_clk_hw_composite(name, parent_names, reg, flags))
-
 #define imx8m_clk_hw_composite(name, parent_names, reg) \
 	__imx8m_clk_hw_composite(name, parent_names, reg, 0)
 
-#define imx8m_clk_composite(name, parent_names, reg) \
-	__imx8m_clk_composite(name, parent_names, reg, 0)
-
 #define imx8m_clk_hw_composite_critical(name, parent_names, reg) \
 	__imx8m_clk_hw_composite(name, parent_names, reg, CLK_IS_CRITICAL)
 
-#define imx8m_clk_composite_critical(name, parent_names, reg) \
-	__imx8m_clk_composite(name, parent_names, reg, CLK_IS_CRITICAL)
-
 struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
-- 
2.31.1

