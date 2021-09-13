Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08410408670
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhIMI0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:26:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56234 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237979AbhIMI0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:26:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 965CB1A2A6B;
        Mon, 13 Sep 2021 10:25:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 893401A2A62;
        Mon, 13 Sep 2021 10:25:14 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 46F34202EC;
        Mon, 13 Sep 2021 10:25:14 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 6/8] clk: imx: Rework all clk_hw_register_divider wrappers
Date:   Mon, 13 Sep 2021 11:24:48 +0300
Message-Id: <1631521490-17171-7-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having multiple inline functions that were calling
clk_hw_register_divider, implement a generic low-level
__imx_clk_hw_divider and implement the rest as macros that
pass on as arguments whatever is needed in each case.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index a94170c5c83e..224a22065064 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -175,6 +175,16 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_hw_mux2_flags(name, reg, shift, width, parents, num_parents, flags) \
 	__imx_clk_hw_mux(name, reg, shift, width, parents, num_parents, flags | CLK_OPS_PARENT_ENABLE, 0)
 
+#define imx_clk_hw_divider(name, parent, reg, shift, width) \
+	__imx_clk_hw_divider(name, parent, reg, shift, width, CLK_SET_RATE_PARENT)
+
+#define imx_clk_hw_divider2(name, parent, reg, shift, width) \
+	__imx_clk_hw_divider(name, parent, reg, shift, width, \
+				CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE)
+
+#define imx_clk_hw_divider_flags(name, parent, reg, shift, width, flags) \
+	__imx_clk_hw_divider(name, parent, reg, shift, width, flags)
+
 struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 				const char *parent_name, void __iomem *base,
 				const struct imx_pll14xx_clk *pll_clk);
@@ -303,16 +313,7 @@ static inline struct clk_hw *imx_clk_hw_fixed_factor(const char *name,
 			CLK_SET_RATE_PARENT, mult, div);
 }
 
-static inline struct clk_hw *imx_clk_hw_divider(const char *name,
-						const char *parent,
-						void __iomem *reg, u8 shift,
-						u8 width)
-{
-	return clk_hw_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
-				       reg, shift, width, 0, &imx_ccm_lock);
-}
-
-static inline struct clk_hw *imx_clk_hw_divider_flags(const char *name,
+static inline struct clk_hw *__imx_clk_hw_divider(const char *name,
 						   const char *parent,
 						   void __iomem *reg, u8 shift,
 						   u8 width, unsigned long flags)
@@ -321,14 +322,6 @@ static inline struct clk_hw *imx_clk_hw_divider_flags(const char *name,
 				       reg, shift, width, 0, &imx_ccm_lock);
 }
 
-static inline struct clk_hw *imx_clk_hw_divider2(const char *name, const char *parent,
-		void __iomem *reg, u8 shift, u8 width)
-{
-	return clk_hw_register_divider(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, width, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *__imx_clk_hw_gate(const char *name, const char *parent,
 						void __iomem *reg, u8 shift,
 						unsigned long flags,
-- 
2.31.1

