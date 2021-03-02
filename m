Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA432AE28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360634AbhCBWW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351078AbhCBVmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:42:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E949864F35;
        Tue,  2 Mar 2021 21:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614721322;
        bh=7Wrbh9hE4WdC65V/AJ8ebT2/ZBfh581DMtymckjIKoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdMW2/tB3Yp/04GqRn9+IRSz0xA3QsRG3zv/3k/hnkZqTtMNQy6ArVTAg2lz+W8Er
         Dh+Xsgu6VhnwaEF9zaKjqXbqfzaWJVbIwkcB0jLRkOvz8EZOUIMlSMSTXH6Tx+k/lk
         1f6MtywgWWMIAWQJq/YlkWvcKlsT76n6uptSh7WKynPoQSXt29ZP2bRPG0X7sS9tns
         kDq2CdqYwV7yKwE+tLyZpTjNUBzTjUtV+fR8LLeBj9e3j9snbj++/rA3SE+/Z3XTPv
         icnxy4LXEHnLP5GYl2h125QNaclyxsU8qGG3+9hNNRIlo7tMyX5376rAzX3LWZEL3m
         nj5QGPjjCrJiQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     sboyd@kernel.org
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: socfpga: arria10: convert to use clk_hw
Date:   Tue,  2 Mar 2021 15:41:50 -0600
Message-Id: <20210302214151.1333447-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210302214151.1333447-1-dinguyen@kernel.org>
References: <20210302214151.1333447-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As recommended by Stephen Boyd, convert the Arria10 clock driver to use
the clk_hw registration method.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clk/socfpga/clk-gate-a10.c   |  8 ++++----
 drivers/clk/socfpga/clk-periph-a10.c | 11 ++++++-----
 drivers/clk/socfpga/clk-pll-a10.c    | 12 ++++++------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate-a10.c b/drivers/clk/socfpga/clk-gate-a10.c
index cd5df9103614..f5cba8298712 100644
--- a/drivers/clk/socfpga/clk-gate-a10.c
+++ b/drivers/clk/socfpga/clk-gate-a10.c
@@ -98,7 +98,7 @@ static void __init __socfpga_gate_init(struct device_node *node,
 	u32 div_reg[3];
 	u32 clk_phase[2];
 	u32 fixed_div;
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_gate_clk *socfpga_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
@@ -159,13 +159,13 @@ static void __init __socfpga_gate_init(struct device_node *node,
 	init.num_parents = of_clk_parent_fill(node, parent_name, SOCFPGA_MAX_PARENTS);
 	init.parent_names = parent_name;
 	socfpga_clk->hw.hw.init = &init;
+	hw_clk = &socfpga_clk->hw.hw;
 
-	clk = clk_register(NULL, &socfpga_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	if (clk_hw_register(NULL, hw_clk)) {
 		kfree(socfpga_clk);
 		return;
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
 	if (WARN_ON(rc))
 		return;
 }
diff --git a/drivers/clk/socfpga/clk-periph-a10.c b/drivers/clk/socfpga/clk-periph-a10.c
index 3e0c55727b89..b9cdde4b8441 100644
--- a/drivers/clk/socfpga/clk-periph-a10.c
+++ b/drivers/clk/socfpga/clk-periph-a10.c
@@ -61,7 +61,7 @@ static __init void __socfpga_periph_init(struct device_node *node,
 	const struct clk_ops *ops)
 {
 	u32 reg;
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_periph_clk *periph_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
@@ -104,12 +104,13 @@ static __init void __socfpga_periph_init(struct device_node *node,
 
 	periph_clk->hw.hw.init = &init;
 
-	clk = clk_register(NULL, &periph_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	hw_clk = &periph_clk->hw.hw;
+
+	if (clk_hw_register(NULL, hw_clk)) {
 		kfree(periph_clk);
 		return;
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
 	if (rc < 0) {
 		pr_err("Could not register clock provider for node:%s\n",
 		       clk_name);
@@ -119,7 +120,7 @@ static __init void __socfpga_periph_init(struct device_node *node,
 	return;
 
 err_clk:
-	clk_unregister(clk);
+	clk_hw_unregister(hw_clk);
 }
 
 void __init socfpga_a10_periph_init(struct device_node *node)
diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
index 3338f054fe98..bee0f7da5b6e 100644
--- a/drivers/clk/socfpga/clk-pll-a10.c
+++ b/drivers/clk/socfpga/clk-pll-a10.c
@@ -63,11 +63,11 @@ static const struct clk_ops clk_pll_ops = {
 	.get_parent = clk_pll_get_parent,
 };
 
-static struct clk * __init __socfpga_pll_init(struct device_node *node,
+static struct clk_hw * __init __socfpga_pll_init(struct device_node *node,
 	const struct clk_ops *ops)
 {
 	u32 reg;
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_pll *pll_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFGPA_MAX_PARENTS];
@@ -101,14 +101,14 @@ static struct clk * __init __socfpga_pll_init(struct device_node *node,
 	pll_clk->hw.hw.init = &init;
 
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
+	hw_clk = &pll_clk->hw.hw;
 
-	clk = clk_register(NULL, &pll_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	if (clk_hw_register(NULL, hw_clk)) {
 		kfree(pll_clk);
 		return NULL;
 	}
-	of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	return clk;
+	of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
+	return hw_clk;
 }
 
 void __init socfpga_a10_pll_init(struct device_node *node)
-- 
2.30.0

