Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D532AE29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360642AbhCBWXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351072AbhCBVmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:42:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64A2464F32;
        Tue,  2 Mar 2021 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614721320;
        bh=nZ1YPBcTEc5Eb+9gTvd2F1g+zdYEeqMk6SozTaIVERs=;
        h=From:To:Cc:Subject:Date:From;
        b=d5G4KDNhrdzlhGKMbcTCP1DHrr/CzW1gxHKPsJqIC7VlImP1U6FELXvv5jLPdhL08
         hxCblVaUJYSR3nfYW3gG84raaR6btSQ67gba2BMX4FuLxPXwXOJYc0Ag9JmaKnkdZx
         WfAvDhNzMP1USoWZXtnZ4EBRoFfTiY2CwUA9YReEN9takunX52ICOB8fgSVgOzLV+V
         4J36X37DZmcV1qnJF0yX7pCjE+jutOwWXzkeH2jGlhH39EWN3dkNWSO39ZGg9/0A8A
         0rUylqNldazls9cVqdJ/1AKepnB43dm2fLw+DKVEc2XBzCKfMfywoW4MTZhpR3rXIt
         J/ntVvJks230w==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     sboyd@kernel.org
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: socfpga: use clk_hw_register for a5/c5
Date:   Tue,  2 Mar 2021 15:41:49 -0600
Message-Id: <20210302214151.1333447-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As recommended by Stephen Boyd, convert the cyclone5/arria5 clock driver
to use the clk_hw registration method.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clk/socfpga/clk-gate.c   | 11 +++++++----
 drivers/clk/socfpga/clk-periph.c |  8 ++++----
 drivers/clk/socfpga/clk-pll.c    | 18 +++++++++++-------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 43ecd507bf83..b17aba5799d2 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -174,13 +174,14 @@ void __init socfpga_gate_init(struct device_node *node)
 	u32 div_reg[3];
 	u32 clk_phase[2];
 	u32 fixed_div;
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_gate_clk *socfpga_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
 	struct clk_init_data init;
 	struct clk_ops *ops;
 	int rc;
+	int err;
 
 	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
 	if (WARN_ON(!socfpga_clk))
@@ -238,12 +239,14 @@ void __init socfpga_gate_init(struct device_node *node)
 	init.parent_names = parent_name;
 	socfpga_clk->hw.hw.init = &init;
 
-	clk = clk_register(NULL, &socfpga_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	hw_clk = &socfpga_clk->hw.hw;
+
+	err = clk_hw_register(NULL, hw_clk);
+	if (err) {
 		kfree(socfpga_clk);
 		return;
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
 	if (WARN_ON(rc))
 		return;
 }
diff --git a/drivers/clk/socfpga/clk-periph.c b/drivers/clk/socfpga/clk-periph.c
index 5e0c4b45f77f..43707e2d7248 100644
--- a/drivers/clk/socfpga/clk-periph.c
+++ b/drivers/clk/socfpga/clk-periph.c
@@ -51,7 +51,7 @@ static __init void __socfpga_periph_init(struct device_node *node,
 	const struct clk_ops *ops)
 {
 	u32 reg;
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_periph_clk *periph_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
@@ -94,13 +94,13 @@ static __init void __socfpga_periph_init(struct device_node *node,
 	init.parent_names = parent_name;
 
 	periph_clk->hw.hw.init = &init;
+	hw_clk = &periph_clk->hw.hw;
 
-	clk = clk_register(NULL, &periph_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	if (clk_hw_register(NULL, hw_clk)) {
 		kfree(periph_clk);
 		return;
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
 }
 
 void __init socfpga_periph_init(struct device_node *node)
diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index 3cf99df7d005..dcb573d44034 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -70,16 +70,18 @@ static const struct clk_ops clk_pll_ops = {
 	.get_parent = clk_pll_get_parent,
 };
 
-static __init struct clk *__socfpga_pll_init(struct device_node *node,
+static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
 	const struct clk_ops *ops)
 {
 	u32 reg;
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_pll *pll_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
 	struct clk_init_data init;
 	struct device_node *clkmgr_np;
+	int rc;
+	int err;
 
 	of_property_read_u32(node, "reg", &reg);
 
@@ -105,13 +107,15 @@ static __init struct clk *__socfpga_pll_init(struct device_node *node,
 
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
 
-	clk = clk_register(NULL, &pll_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	hw_clk = &pll_clk->hw.hw;
+
+	err = clk_hw_register(NULL, hw_clk);
+	if (err) {
 		kfree(pll_clk);
-		return NULL;
+		return ERR_PTR(err);
 	}
-	of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	return clk;
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
+	return hw_clk;
 }
 
 void __init socfpga_pll_init(struct device_node *node)
-- 
2.30.0

