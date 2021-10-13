Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7281A42CD8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhJMWMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhJMWMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:12:35 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD600C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:10:31 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 4-20020a620504000000b0044be2cfac9bso2367306pff.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wqNELjpmtlGEH41rLEk9ERkQkG/0kIH/3vHQh1QjL18=;
        b=shMjCyt21hCl3oG5ov9YV/koHCJMWMBpeRKIZiTz/TdlcaUZY4c5029DWcjOLBg55v
         pP/p3ziQunijS7XGR4kOYNbDzOR6MtUq/BOKmmgTSddZKHNI0pM513UrfHdw8LpaxyAl
         SIci4bHoNukoPscZnCMqpCstVAqQYHRiXBzxZahL991idYJeK0uCtq1IywfOAIE8AtVr
         VCCKjdgwleV+Hu4O1F018Lc8VAqXJHmRKiuMmfA3yU1GIIiSYK8cKqfp7neNULCIjHiz
         eArEfyh63J19/YrLexQIp4Uj2WlfTGHVcRz5R/C+noXT3JLTUEMpTr+H0fBM1ncPlnWa
         QhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wqNELjpmtlGEH41rLEk9ERkQkG/0kIH/3vHQh1QjL18=;
        b=MdcWkcOK/I4EEhaDuiEIW4JdfSU1OAzK4DS4MMp30aP479hPf4kn+AHpGL58qUcoQG
         RZaGP0zMOchAv+TeTALEiV1LQoP9IR97ZqItjpzCCIV0iq05yYaTGgwHnbLPjffbe5PF
         C/oQyENC8a0fCsh7ThX/f/9UrNNTGO+fkTeSa0zz+hnDLrzD7gDSXyD06i2IEwMHJiKj
         D4kPYxkIBXsR2nkgJiblB7gsvzJAkjpysUjvQExN6AhlOYsi5/qEb8Py54EFKFnWr930
         +3xKVXK0J4zAKf3dkCodbDeU73ho4MiEqJKo07CZh2xSLT+30t4zGDSeKvMBFrq3qrns
         ZrZw==
X-Gm-Message-State: AOAM530MCiuUHCySXllsRD0/K4UOikVGAj1IXIbac4RkeeTqLHAoEJIa
        ULvOpc9OF5urn1DXQjn5MJvN+BHWjp3EScrqdSM=
X-Google-Smtp-Source: ABdhPJwSHq7t4EDLLAtv4RUzmCWL7n/SHCwJF1dRQXyJ3LKA9du+tmSUO665Mf74ZPLjq2ZJLDufZJT9YVDHODWdxaA=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a17:902:8b81:b0:13f:3d30:f624 with
 SMTP id ay1-20020a1709028b8100b0013f3d30f624mr1635638plb.51.1634163031149;
 Wed, 13 Oct 2021 15:10:31 -0700 (PDT)
Date:   Wed, 13 Oct 2021 22:10:20 +0000
In-Reply-To: <20211013221021.3433704-1-willmcvicker@google.com>
Message-Id: <20211013221021.3433704-3-willmcvicker@google.com>
Mime-Version: 1.0
References: <20211013221021.3433704-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 2/2] [RFT] clk: samsung: exynos5433: update apollo and
 atlas clock probing
From:   Will McVicker <willmcvicker@google.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     kernel-team@android.com, Will McVicker <willmcvicker@google.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the samsung common clk driver to initialize and probe the apollo and
atlas clocks. This removes their custom init functions and uses the
samsung_cmu_register_one() instead.

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 120 +++++++++++----------------
 1 file changed, 48 insertions(+), 72 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index f203074d858b..0ef809c9e2da 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -3675,44 +3675,32 @@ static const struct exynos_cpuclk_cfg_data exynos5433_apolloclk_d[] __initconst
 	{  0 },
 };
 
+static const struct samsung_cpu_clock apollo_cpu_clks[] __initconst = {
+	CPU_CLK(CLK_SCLK_APOLLO, "apolloclk", "mout_apollo_pll",
+			"mout_bus_pll_apollo_user",
+			CLK_CPU_HAS_E5433_REGS_LAYOUT, 0x200,
+			exynos5433_apolloclk_d),
+};
+
+static const struct samsung_cmu_info apollo_cmu_info __initconst = {
+	.pll_clks	= apollo_pll_clks,
+	.nr_pll_clks	= ARRAY_SIZE(apollo_pll_clks),
+	.mux_clks	= apollo_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(apollo_mux_clks),
+	.div_clks	= apollo_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(apollo_div_clks),
+	.gate_clks	= apollo_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(apollo_gate_clks),
+	.cpu_clks	= apollo_cpu_clks,
+	.nr_cpu_clks	= ARRAY_SIZE(apollo_cpu_clks),
+	.nr_clk_ids	= APOLLO_NR_CLK,
+	.clk_regs	= apollo_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(apollo_clk_regs),
+};
+
 static void __init exynos5433_cmu_apollo_init(struct device_node *np)
 {
-	void __iomem *reg_base;
-	struct samsung_clk_provider *ctx;
-	struct clk_hw **hws;
-
-	reg_base = of_iomap(np, 0);
-	if (!reg_base) {
-		panic("%s: failed to map registers\n", __func__);
-		return;
-	}
-
-	ctx = samsung_clk_init(np, reg_base, APOLLO_NR_CLK);
-	if (!ctx) {
-		panic("%s: unable to allocate ctx\n", __func__);
-		return;
-	}
-
-	samsung_clk_register_pll(ctx, apollo_pll_clks,
-				 ARRAY_SIZE(apollo_pll_clks), reg_base);
-	samsung_clk_register_mux(ctx, apollo_mux_clks,
-				 ARRAY_SIZE(apollo_mux_clks));
-	samsung_clk_register_div(ctx, apollo_div_clks,
-				 ARRAY_SIZE(apollo_div_clks));
-	samsung_clk_register_gate(ctx, apollo_gate_clks,
-				  ARRAY_SIZE(apollo_gate_clks));
-
-	hws = ctx->clk_data.hws;
-
-	exynos_register_cpu_clock(ctx, CLK_SCLK_APOLLO, "apolloclk",
-		hws[CLK_MOUT_APOLLO_PLL], hws[CLK_MOUT_BUS_PLL_APOLLO_USER], 0x200,
-		exynos5433_apolloclk_d, ARRAY_SIZE(exynos5433_apolloclk_d),
-		CLK_CPU_HAS_E5433_REGS_LAYOUT);
-
-	samsung_clk_sleep_init(reg_base, apollo_clk_regs,
-			       ARRAY_SIZE(apollo_clk_regs));
-
-	samsung_clk_of_add_provider(np, ctx);
+	samsung_cmu_register_one(np, &apollo_cmu_info);
 }
 CLK_OF_DECLARE(exynos5433_cmu_apollo, "samsung,exynos5433-cmu-apollo",
 		exynos5433_cmu_apollo_init);
@@ -3932,44 +3920,32 @@ static const struct exynos_cpuclk_cfg_data exynos5433_atlasclk_d[] __initconst =
 	{  0 },
 };
 
-static void __init exynos5433_cmu_atlas_init(struct device_node *np)
-{
-	void __iomem *reg_base;
-	struct samsung_clk_provider *ctx;
-	struct clk_hw **hws;
-
-	reg_base = of_iomap(np, 0);
-	if (!reg_base) {
-		panic("%s: failed to map registers\n", __func__);
-		return;
-	}
-
-	ctx = samsung_clk_init(np, reg_base, ATLAS_NR_CLK);
-	if (!ctx) {
-		panic("%s: unable to allocate ctx\n", __func__);
-		return;
-	}
-
-	samsung_clk_register_pll(ctx, atlas_pll_clks,
-				 ARRAY_SIZE(atlas_pll_clks), reg_base);
-	samsung_clk_register_mux(ctx, atlas_mux_clks,
-				 ARRAY_SIZE(atlas_mux_clks));
-	samsung_clk_register_div(ctx, atlas_div_clks,
-				 ARRAY_SIZE(atlas_div_clks));
-	samsung_clk_register_gate(ctx, atlas_gate_clks,
-				  ARRAY_SIZE(atlas_gate_clks));
-
-	hws = ctx->clk_data.hws;
-
-	exynos_register_cpu_clock(ctx, CLK_SCLK_ATLAS, "atlasclk",
-		hws[CLK_MOUT_ATLAS_PLL], hws[CLK_MOUT_BUS_PLL_ATLAS_USER], 0x200,
-		exynos5433_atlasclk_d, ARRAY_SIZE(exynos5433_atlasclk_d),
-		CLK_CPU_HAS_E5433_REGS_LAYOUT);
+static const struct samsung_cpu_clock atlas_cpu_clks[] __initconst = {
+	CPU_CLK(CLK_SCLK_ATLAS, "atlasclk", "mout_atlas_pll",
+			"mout_bus_pll_atlas_user",
+			CLK_CPU_HAS_E5433_REGS_LAYOUT, 0x200,
+			exynos5433_atlasclk_d),
+};
 
-	samsung_clk_sleep_init(reg_base, atlas_clk_regs,
-			       ARRAY_SIZE(atlas_clk_regs));
+static const struct samsung_cmu_info atlas_cmu_info __initconst = {
+	.pll_clks	= atlas_pll_clks,
+	.nr_pll_clks	= ARRAY_SIZE(atlas_pll_clks),
+	.mux_clks	= atlas_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(atlas_mux_clks),
+	.div_clks	= atlas_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(atlas_div_clks),
+	.gate_clks	= atlas_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(atlas_gate_clks),
+	.cpu_clks	= atlas_cpu_clks,
+	.nr_cpu_clks	= ARRAY_SIZE(atlas_cpu_clks),
+	.nr_clk_ids	= ATLAS_NR_CLK,
+	.clk_regs	= atlas_clk_regs,
+	.nr_clk_regs	= ARRAY_SIZE(atlas_clk_regs),
+};
 
-	samsung_clk_of_add_provider(np, ctx);
+static void __init exynos5433_cmu_atlas_init(struct device_node *np)
+{
+	samsung_cmu_register_one(np, &atlas_cmu_info);
 }
 CLK_OF_DECLARE(exynos5433_cmu_atlas, "samsung,exynos5433-cmu-atlas",
 		exynos5433_cmu_atlas_init);
-- 
2.33.0.882.g93a45727a2-goog

