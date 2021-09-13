Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50678408671
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbhIMI0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:26:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56318 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237993AbhIMI0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:26:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 469191A2AA9;
        Mon, 13 Sep 2021 10:25:15 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 39DEB1A2A68;
        Mon, 13 Sep 2021 10:25:15 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EB1F2202EC;
        Mon, 13 Sep 2021 10:25:14 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 8/8] clk: imx: Rework imx_clk_hw_pll14xx wrapper
Date:   Mon, 13 Sep 2021 11:24:50 +0300
Message-Id: <1631521490-17171-9-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks much cleaner to just have a macro compared to having
a function that passes NULL as dev to the lower-level
imx_dev_clk_hw_pll14xx.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 4f3b87d8aee3..d170cb988f2b 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -185,6 +185,9 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_hw_divider_flags(name, parent, reg, shift, width, flags) \
 	__imx_clk_hw_divider(name, parent, reg, shift, width, flags)
 
+#define imx_clk_hw_pll14xx(name, parent_name, base, pll_clk) \
+	imx_dev_clk_hw_pll14xx(NULL, name, parent_name, base, pll_clk)
+
 struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 				const char *parent_name, void __iomem *base,
 				const struct imx_pll14xx_clk *pll_clk);
@@ -294,13 +297,6 @@ static inline struct clk *to_clk(struct clk_hw *hw)
 	return hw->clk;
 }
 
-static inline struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_name,
-				  void __iomem *base,
-				  const struct imx_pll14xx_clk *pll_clk)
-{
-	return imx_dev_clk_hw_pll14xx(NULL, name, parent_name, base, pll_clk);
-}
-
 static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
 {
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
-- 
2.31.1

