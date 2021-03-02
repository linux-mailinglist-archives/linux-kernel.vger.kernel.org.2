Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BE932AE2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360692AbhCBWXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351081AbhCBVmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:42:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 866CC64F34;
        Tue,  2 Mar 2021 21:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614721323;
        bh=5ZWDjPlSsimBioG9Isf0JvfbEeVDd9jx8ia2qBvh5Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0w+Vx7o7Gm1SoKZjOKyIJixywunAQ544q7P2Y9eMrGeactSVvNbMVRcwfOR8ZPSK
         3uimi3Dx9nox4mWiBCZH9+cLsToUOFtIjxZPzUB3lEP6rphbQl6Uw3VdKSoFBRADlN
         lgI5h9eqXMeR2ChJEqdY6yf/VNAbp5RzSzzSB531vuD5vRJTk/09jR3IyXkXZTRXsu
         FkoYmGYeoOyIhiPqpLdA9/V3sx32OCNzkVuutw+JKaL4zhg/PACnLv8I5iVxgD3iPM
         wlXty0FKeRUVA2fiNrliELu2neZC2VWxQYLudAm2JwaHA9oroetqkfTCkwLaxZbVXt
         iURnOTlYz1v6Q==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     sboyd@kernel.org
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] clk: socfpga: Convert to s10/agilex/n5x to use clk_hw
Date:   Tue,  2 Mar 2021 15:41:51 -0600
Message-Id: <20210302214151.1333447-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210302214151.1333447-1-dinguyen@kernel.org>
References: <20210302214151.1333447-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As recommended by Stephen Boyd, convert the Agilex/Stratix10/n5x clock
driver to use the clk_hw registration method.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clk/socfpga/clk-agilex.c     | 114 ++++++++++++++-------------
 drivers/clk/socfpga/clk-gate-s10.c   |  15 ++--
 drivers/clk/socfpga/clk-periph-s10.c |  42 +++++-----
 drivers/clk/socfpga/clk-pll-s10.c    |  43 +++++-----
 drivers/clk/socfpga/clk-s10.c        |  68 +++++++---------
 drivers/clk/socfpga/stratix10-clk.h  |  24 +++---
 6 files changed, 159 insertions(+), 147 deletions(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 7689bdd0a914..319c69112bcf 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -303,18 +303,18 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
 static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
 				       int nums, struct stratix10_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = n5x_register_periph(&clks[i], base);
-		if (IS_ERR(clk)) {
+		hw_clk = n5x_register_periph(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data.hws[clks[i].id] = hw_clk;
 	}
 	return 0;
 }
@@ -322,18 +322,18 @@ static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
 static int agilex_clk_register_c_perip(const struct stratix10_perip_c_clock *clks,
 				       int nums, struct stratix10_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = s10_register_periph(&clks[i], base);
-		if (IS_ERR(clk)) {
+		hw_clk = s10_register_periph(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data.hws[clks[i].id] = hw_clk;
 	}
 	return 0;
 }
@@ -341,18 +341,18 @@ static int agilex_clk_register_c_perip(const struct stratix10_perip_c_clock *clk
 static int agilex_clk_register_cnt_perip(const struct stratix10_perip_cnt_clock *clks,
 					 int nums, struct stratix10_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = s10_register_cnt_periph(&clks[i], base);
-		if (IS_ERR(clk)) {
+		hw_clk = s10_register_cnt_periph(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data.hws[clks[i].id] = hw_clk;
 	}
 
 	return 0;
@@ -360,18 +360,18 @@ static int agilex_clk_register_cnt_perip(const struct stratix10_perip_cnt_clock
 
 static int agilex_clk_register_gate(const struct stratix10_gate_clock *clks,					    int nums, struct stratix10_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = s10_register_gate(&clks[i], base);
-		if (IS_ERR(clk)) {
+		hw_clk = s10_register_gate(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data.hws[clks[i].id] = hw_clk;
 	}
 
 	return 0;
@@ -380,18 +380,18 @@ static int agilex_clk_register_gate(const struct stratix10_gate_clock *clks,
 static int agilex_clk_register_pll(const struct stratix10_pll_clock *clks,
 				 int nums, struct stratix10_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = agilex_register_pll(&clks[i], base);
-		if (IS_ERR(clk)) {
+		hw_clk = agilex_register_pll(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data.hws[clks[i].id] = hw_clk;
 	}
 
 	return 0;
@@ -400,64 +400,49 @@ static int agilex_clk_register_pll(const struct stratix10_pll_clock *clks,
 static int n5x_clk_register_pll(const struct stratix10_pll_clock *clks,
 				 int nums, struct stratix10_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = n5x_register_pll(&clks[i], base);
-		if (IS_ERR(clk)) {
+		hw_clk = n5x_register_pll(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data.hws[clks[i].id] = hw_clk;
 	}
 
 	return 0;
 }
 
-static struct stratix10_clock_data *__socfpga_agilex_clk_init(struct platform_device *pdev,
-						    int nr_clks)
+static int agilex_clkmgr_init(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct stratix10_clock_data *clk_data;
-	struct clk **clk_table;
 	struct resource *res;
 	void __iomem *base;
-	int ret;
+	int i, num_clks;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
-		return ERR_CAST(base);
-
-	clk_data = devm_kzalloc(dev, sizeof(*clk_data), GFP_KERNEL);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
+		return PTR_ERR(base);
 
-	clk_data->base = base;
-	clk_table = devm_kcalloc(dev, nr_clks, sizeof(*clk_table), GFP_KERNEL);
-	if (!clk_table)
-		return ERR_PTR(-ENOMEM);
-
-	clk_data->clk_data.clks = clk_table;
-	clk_data->clk_data.clk_num = nr_clks;
-	ret = of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		return ERR_PTR(ret);
+	num_clks = AGILEX_NUM_CLKS;
 
-	return clk_data;
-}
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
+				num_clks), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
 
-static int agilex_clkmgr_init(struct platform_device *pdev)
-{
-	struct stratix10_clock_data *clk_data;
+	for (i = 0; i < num_clks; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
 
-	clk_data = __socfpga_agilex_clk_init(pdev, AGILEX_NUM_CLKS);
-	if (IS_ERR(clk_data))
-		return PTR_ERR(clk_data);
+	clk_data->base = base;
+	clk_data->clk_data.num = num_clks;
 
 	agilex_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
 
@@ -470,16 +455,36 @@ static int agilex_clkmgr_init(struct platform_device *pdev)
 
 	agilex_clk_register_gate(agilex_gate_clks, ARRAY_SIZE(agilex_gate_clks),
 			      clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_data);
 	return 0;
 }
 
 static int n5x_clkmgr_init(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct stratix10_clock_data *clk_data;
+	struct resource *res;
+	void __iomem *base;
+	int i, num_clks;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	num_clks = AGILEX_NUM_CLKS;
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
+				num_clks), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_clks; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
 
-	clk_data = __socfpga_agilex_clk_init(pdev, AGILEX_NUM_CLKS);
-	if (IS_ERR(clk_data))
-		return PTR_ERR(clk_data);
+	clk_data->base = base;
+	clk_data->clk_data.num = num_clks;
 
 	n5x_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
 
@@ -492,6 +497,7 @@ static int n5x_clkmgr_init(struct platform_device *pdev)
 
 	agilex_clk_register_gate(agilex_gate_clks, ARRAY_SIZE(agilex_gate_clks),
 			      clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_data);
 	return 0;
 }
 
diff --git a/drivers/clk/socfpga/clk-gate-s10.c b/drivers/clk/socfpga/clk-gate-s10.c
index 083b2ec21fdd..f9f403d7bb58 100644
--- a/drivers/clk/socfpga/clk-gate-s10.c
+++ b/drivers/clk/socfpga/clk-gate-s10.c
@@ -65,12 +65,13 @@ static const struct clk_ops dbgclk_ops = {
 	.get_parent = socfpga_gate_get_parent,
 };
 
-struct clk *s10_register_gate(const struct stratix10_gate_clock *clks, void __iomem *regbase)
+struct clk_hw *s10_register_gate(const struct stratix10_gate_clock *clks, void __iomem *regbase)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_gate_clk *socfpga_clk;
 	struct clk_init_data init;
 	const char *parent_name = clks->parent_name;
+	int ret;
 
 	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
 	if (!socfpga_clk)
@@ -112,10 +113,12 @@ struct clk *s10_register_gate(const struct stratix10_gate_clock *clks, void __io
 		init.parent_data = clks->parent_data;
 	socfpga_clk->hw.hw.init = &init;
 
-	clk = clk_register(NULL, &socfpga_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	hw_clk = &socfpga_clk->hw.hw;
+
+	ret = clk_hw_register(NULL, &socfpga_clk->hw.hw);
+	if (ret) {
 		kfree(socfpga_clk);
-		return NULL;
+		return ERR_PTR(ret);
 	}
-	return clk;
+	return hw_clk;
 }
diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
index 0ff2b9d24035..e5a5fef76df7 100644
--- a/drivers/clk/socfpga/clk-periph-s10.c
+++ b/drivers/clk/socfpga/clk-periph-s10.c
@@ -93,14 +93,15 @@ static const struct clk_ops peri_cnt_clk_ops = {
 	.get_parent = clk_periclk_get_parent,
 };
 
-struct clk *s10_register_periph(const struct stratix10_perip_c_clock *clks,
+struct clk_hw *s10_register_periph(const struct stratix10_perip_c_clock *clks,
 				void __iomem *reg)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_periph_clk *periph_clk;
 	struct clk_init_data init;
 	const char *name = clks->name;
 	const char *parent_name = clks->parent_name;
+	int ret;
 
 	periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
 	if (WARN_ON(!periph_clk))
@@ -118,23 +119,25 @@ struct clk *s10_register_periph(const struct stratix10_perip_c_clock *clks,
 		init.parent_data = clks->parent_data;
 
 	periph_clk->hw.hw.init = &init;
+	hw_clk = &periph_clk->hw.hw;
 
-	clk = clk_register(NULL, &periph_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	ret = clk_hw_register(NULL, hw_clk);
+	if (ret) {
 		kfree(periph_clk);
-		return NULL;
+		return ERR_PTR(ret);
 	}
-	return clk;
+	return hw_clk;
 }
 
-struct clk *n5x_register_periph(const struct n5x_perip_c_clock *clks,
+struct clk_hw *n5x_register_periph(const struct n5x_perip_c_clock *clks,
 				void __iomem *regbase)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_periph_clk *periph_clk;
 	struct clk_init_data init;
 	const char *name = clks->name;
 	const char *parent_name = clks->parent_name;
+	int ret;
 
 	periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
 	if (WARN_ON(!periph_clk))
@@ -151,23 +154,25 @@ struct clk *n5x_register_periph(const struct n5x_perip_c_clock *clks,
 	init.parent_names = parent_name ? &parent_name : NULL;
 
 	periph_clk->hw.hw.init = &init;
+	hw_clk = &periph_clk->hw.hw;
 
-	clk = clk_register(NULL, &periph_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	ret = clk_hw_register(NULL, hw_clk);
+	if (ret) {
 		kfree(periph_clk);
-		return NULL;
+		return ERR_PTR(ret);
 	}
-	return clk;
+	return hw_clk;
 }
 
-struct clk *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *clks,
+struct clk_hw *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *clks,
 				    void __iomem *regbase)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_periph_clk *periph_clk;
 	struct clk_init_data init;
 	const char *name = clks->name;
 	const char *parent_name = clks->parent_name;
+	int ret;
 
 	periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
 	if (WARN_ON(!periph_clk))
@@ -195,11 +200,12 @@ struct clk *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *clks
 		init.parent_data = clks->parent_data;
 
 	periph_clk->hw.hw.init = &init;
+	hw_clk = &periph_clk->hw.hw;
 
-	clk = clk_register(NULL, &periph_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	ret = clk_hw_register(NULL, hw_clk);
+	if (ret) {
 		kfree(periph_clk);
-		return NULL;
+		return ERR_PTR(ret);
 	}
-	return clk;
+	return hw_clk;
 }
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index f6f66e08e1f4..bc37461d43c0 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -187,13 +187,14 @@ static const struct clk_ops clk_boot_ops = {
 	.prepare = clk_pll_prepare,
 };
 
-struct clk *s10_register_pll(const struct stratix10_pll_clock *clks,
+struct clk_hw *s10_register_pll(const struct stratix10_pll_clock *clks,
 			     void __iomem *reg)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_pll *pll_clk;
 	struct clk_init_data init;
 	const char *name = clks->name;
+	int ret;
 
 	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
 	if (WARN_ON(!pll_clk))
@@ -216,21 +217,24 @@ struct clk *s10_register_pll(const struct stratix10_pll_clock *clks,
 
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_POWER;
 
-	clk = clk_register(NULL, &pll_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	hw_clk = &pll_clk->hw.hw;
+
+	ret = clk_hw_register(NULL, hw_clk);
+	if (ret) {
 		kfree(pll_clk);
-		return NULL;
+		return ERR_PTR(ret);
 	}
-	return clk;
+	return hw_clk;
 }
 
-struct clk *agilex_register_pll(const struct stratix10_pll_clock *clks,
+struct clk_hw *agilex_register_pll(const struct stratix10_pll_clock *clks,
 				void __iomem *reg)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_pll *pll_clk;
 	struct clk_init_data init;
 	const char *name = clks->name;
+	int ret;
 
 	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
 	if (WARN_ON(!pll_clk))
@@ -252,22 +256,24 @@ struct clk *agilex_register_pll(const struct stratix10_pll_clock *clks,
 	pll_clk->hw.hw.init = &init;
 
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_POWER;
+	hw_clk = &pll_clk->hw.hw;
 
-	clk = clk_register(NULL, &pll_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	ret = clk_hw_register(NULL, hw_clk);
+	if (ret) {
 		kfree(pll_clk);
-		return NULL;
+		return ERR_PTR(ret);
 	}
-	return clk;
+	return hw_clk;
 }
 
-struct clk *n5x_register_pll(const struct stratix10_pll_clock *clks,
+struct clk_hw *n5x_register_pll(const struct stratix10_pll_clock *clks,
 			     void __iomem *reg)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	struct socfpga_pll *pll_clk;
 	struct clk_init_data init;
 	const char *name = clks->name;
+	int ret;
 
 	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
 	if (WARN_ON(!pll_clk))
@@ -289,11 +295,12 @@ struct clk *n5x_register_pll(const struct stratix10_pll_clock *clks,
 	pll_clk->hw.hw.init = &init;
 
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_POWER;
+	hw_clk = &pll_clk->hw.hw;
 
-	clk = clk_register(NULL, &pll_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	ret = clk_hw_register(NULL, hw_clk);
+	if (ret) {
 		kfree(pll_clk);
-		return NULL;
+		return ERR_PTR(ret);
 	}
-	return clk;
+	return hw_clk;
 }
diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
index 661a8e9bfb9b..f0bd77138ecb 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -274,18 +274,18 @@ static const struct stratix10_gate_clock s10_gate_clks[] = {
 static int s10_clk_register_c_perip(const struct stratix10_perip_c_clock *clks,
 				    int nums, struct stratix10_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = s10_register_periph(&clks[i], base);
-		if (IS_ERR(clk)) {
+		hw_clk = s10_register_periph(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data.hws[clks[i].id] = hw_clk;
 	}
 	return 0;
 }
@@ -293,18 +293,18 @@ static int s10_clk_register_c_perip(const struct stratix10_perip_c_clock *clks,
 static int s10_clk_register_cnt_perip(const struct stratix10_perip_cnt_clock *clks,
 				      int nums, struct stratix10_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = s10_register_cnt_periph(&clks[i], base);
-		if (IS_ERR(clk)) {
+		hw_clk = s10_register_cnt_periph(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data.hws[clks[i].id] = hw_clk;
 	}
 
 	return 0;
@@ -313,18 +313,18 @@ static int s10_clk_register_cnt_perip(const struct stratix10_perip_cnt_clock *cl
 static int s10_clk_register_gate(const struct stratix10_gate_clock *clks,
 				 int nums, struct stratix10_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = s10_register_gate(&clks[i], base);
-		if (IS_ERR(clk)) {
+		hw_clk = s10_register_gate(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data.hws[clks[i].id] = hw_clk;
 	}
 
 	return 0;
@@ -333,62 +333,50 @@ static int s10_clk_register_gate(const struct stratix10_gate_clock *clks,
 static int s10_clk_register_pll(const struct stratix10_pll_clock *clks,
 				 int nums, struct stratix10_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = s10_register_pll(&clks[i], base);
-		if (IS_ERR(clk)) {
+		hw_clk = s10_register_pll(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data.hws[clks[i].id] = hw_clk;
 	}
 
 	return 0;
 }
 
-static struct stratix10_clock_data *__socfpga_s10_clk_init(struct platform_device *pdev,
-						    int nr_clks)
+static int s10_clkmgr_init(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct stratix10_clock_data *clk_data;
-	struct clk **clk_table;
 	struct resource *res;
 	void __iomem *base;
+	int i, num_clks;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base)) {
 		pr_err("%s: failed to map clock registers\n", __func__);
-		return ERR_CAST(base);
+		return PTR_ERR(base);
 	}
 
-	clk_data = devm_kzalloc(dev, sizeof(*clk_data), GFP_KERNEL);
+	num_clks = STRATIX10_NUM_CLKS;
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
+						 num_clks), GFP_KERNEL);
 	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	clk_data->base = base;
-	clk_table = devm_kcalloc(dev, nr_clks, sizeof(*clk_table), GFP_KERNEL);
-	if (!clk_table)
-		return ERR_PTR(-ENOMEM);
-
-	clk_data->clk_data.clks = clk_table;
-	clk_data->clk_data.clk_num = nr_clks;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
-	return clk_data;
-}
+	for (i = 0; i < num_clks; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
 
-static int s10_clkmgr_init(struct platform_device *pdev)
-{
-	struct stratix10_clock_data *clk_data;
-
-	clk_data = __socfpga_s10_clk_init(pdev, STRATIX10_NUM_CLKS);
-	if (IS_ERR(clk_data))
-		return PTR_ERR(clk_data);
+	clk_data->base = base;
+	clk_data->clk_data.num = num_clks;
 
 	s10_clk_register_pll(s10_pll_clks, ARRAY_SIZE(s10_pll_clks), clk_data);
 
@@ -401,6 +389,8 @@ static int s10_clkmgr_init(struct platform_device *pdev)
 
 	s10_clk_register_gate(s10_gate_clks, ARRAY_SIZE(s10_gate_clks),
 			      clk_data);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_data);
 	return 0;
 }
 
diff --git a/drivers/clk/socfpga/stratix10-clk.h b/drivers/clk/socfpga/stratix10-clk.h
index 420deed677ce..61eaf3a41fbb 100644
--- a/drivers/clk/socfpga/stratix10-clk.h
+++ b/drivers/clk/socfpga/stratix10-clk.h
@@ -7,7 +7,7 @@
 #define	__STRATIX10_CLK_H
 
 struct stratix10_clock_data {
-	struct clk_onecell_data	clk_data;
+	struct clk_hw_onecell_data	clk_data;
 	void __iomem		*base;
 };
 
@@ -71,18 +71,18 @@ struct stratix10_gate_clock {
 	u8			fixed_div;
 };
 
-struct clk *s10_register_pll(const struct stratix10_pll_clock *,
-			     void __iomem *);
-struct clk *agilex_register_pll(const struct stratix10_pll_clock *,
-				void __iomem *);
-struct clk *n5x_register_pll(const struct stratix10_pll_clock *clks,
+struct clk_hw *s10_register_pll(const struct stratix10_pll_clock *clks,
 			     void __iomem *reg);
-struct clk *s10_register_periph(const struct stratix10_perip_c_clock *,
+struct clk_hw *agilex_register_pll(const struct stratix10_pll_clock *clks,
 				void __iomem *reg);
-struct clk *n5x_register_periph(const struct n5x_perip_c_clock *clks,
+struct clk_hw *n5x_register_pll(const struct stratix10_pll_clock *clks,
+			     void __iomem *reg);
+struct clk_hw *s10_register_periph(const struct stratix10_perip_c_clock *clks,
+				void __iomem *reg);
+struct clk_hw *n5x_register_periph(const struct n5x_perip_c_clock *clks,
 				void __iomem *reg);
-struct clk *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *,
-				    void __iomem *);
-struct clk *s10_register_gate(const struct stratix10_gate_clock *,
-			      void __iomem *);
+struct clk_hw *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *clks,
+				    void __iomem *reg);
+struct clk_hw *s10_register_gate(const struct stratix10_gate_clock *clks,
+			      void __iomem *reg);
 #endif	/* __STRATIX10_CLK_H */
-- 
2.30.0

