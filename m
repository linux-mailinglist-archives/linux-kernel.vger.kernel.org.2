Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34DA42CD8C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhJMWMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhJMWMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:12:33 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:10:29 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id k1-20020a17090a590100b001971da53970so2557068pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Tl0nUSj0QXvUEN85dGhpBoTdxs/UpAcTzzK1mTgJrQ=;
        b=qDWzWvYnq5+gFWhd3zD6AGKoBSeOKQjToGdNuU6vqKDSCdXa8XVPhP6bu4tXFWdrXJ
         AdgMCwEfyZWvKbhpXUJASdANUTsKusRPffXyLjSXBf03p8a/yr3M6Tk5C1U/DjTCQvnU
         CtffSBZJBvzO4Y3ULgFohOprqJjWN/V5xHnRqRoCNcq842YbiQDSGmDIr0guwr9Jbp3k
         pl6rTvWxnJwTcOtUrjjuQyz0ISv4ZjKlklMweAYRFcTfmLWjpWAInb5HgxhyROiNDay2
         PiA9m/7PQJtEdJXGYr9lnZu875qKvqZL9g62CdKgBXQ8yHIdBU+aG80VnKfVBCOzV/LC
         D3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Tl0nUSj0QXvUEN85dGhpBoTdxs/UpAcTzzK1mTgJrQ=;
        b=rcZ8228B6B3wgz2werHKMgiKKPdQeXcvtMW5nN6C32xGkofAs5QzxaPGsOVXz0o739
         U9QF3BLCufiaNR26l2y8TOlnfSBk8eLsSNXUTyNwRBttOy7SvGHwLOuAooRTIhrHEB8e
         3l18m//3E/opb0KsHi6PR2wMgWc9hC1FJ977a3YrSeYQdH09ul0wPRJlz7WqvHUqyav3
         DnI2dh8caIU8n7ag2idztdMckj8u3/+TZisn89A/xkhyHD81n6Z7QPilO25GYZkNiPg9
         /HW6kuLSWMPLkl7aNPzE9GKcLUowcpA4igI9JTDpyGkIMINRFHuy+hYcWTteYGxp12xg
         xSmg==
X-Gm-Message-State: AOAM5320GJIpfffX4LTkd0qE6a1kEEKGEqZ+ppWMctqOHmVVZskN1R75
        6FJJDcxvKP3JF7eClvFqyo07dr9Nr90Z4T0V/yw=
X-Google-Smtp-Source: ABdhPJwlaJHT6tw5t+L2hE6CrV/5BHbujYrOpg7P42XA8BWbOAfYV3aMtGbxCKpn0URvGRD2uv5w4jeo8ECQ/2TbYVM=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a63:7447:: with SMTP id
 e7mr1394035pgn.261.1634163029412; Wed, 13 Oct 2021 15:10:29 -0700 (PDT)
Date:   Wed, 13 Oct 2021 22:10:19 +0000
In-Reply-To: <20211013221021.3433704-1-willmcvicker@google.com>
Message-Id: <20211013221021.3433704-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20211013221021.3433704-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 1/2] [RFT] clk: samsung: add support for CPU clocks
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

Adds 'struct samsung_cpu_clock' and corresponding CPU clock registration
function to the samsung common clk driver. This allows samsung clock
drivers to register their CPU clocks with the samsung_cmu_register_one()
API.

Currently the exynos5433 apollo and atlas clks have their own custom
init functions to handle registering their CPU clocks. With this patch
we can drop their custom CLK_OF_DECLARE functions and directly call
samsung_cmu_register_one().

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/clk/samsung/clk-cpu.c | 26 ++++++++++++++++++++++++++
 drivers/clk/samsung/clk.c     |  2 ++
 drivers/clk/samsung/clk.h     | 26 ++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 00ef4d1b0888..b5017934fc41 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -469,3 +469,29 @@ int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 	kfree(cpuclk);
 	return ret;
 }
+
+void samsung_clk_register_cpu(struct samsung_clk_provider *ctx,
+		const struct samsung_cpu_clock *list, unsigned int nr_clk)
+{
+	unsigned int idx;
+	unsigned int num_cfgs;
+	struct clk *parent_clk, *alt_parent_clk;
+	const struct clk_hw *parent_clk_hw = NULL;
+	const struct clk_hw *alt_parent_clk_hw = NULL;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		/* find count of configuration rates in cfg */
+		for (num_cfgs = 0; list->cfg[num_cfgs].prate != 0; )
+			num_cfgs++;
+
+		parent_clk = __clk_lookup(list->parent_name);
+		if (parent_clk)
+			parent_clk_hw = __clk_get_hw(parent_clk);
+		alt_parent_clk = __clk_lookup(list->alt_parent_name);
+		if (alt_parent_clk)
+			alt_parent_clk_hw = __clk_get_hw(alt_parent_clk);
+
+		exynos_register_cpu_clock(ctx, list->id, list->name, parent_clk_hw,
+				alt_parent_clk_hw, list->offset, list->cfg, num_cfgs, list->flags);
+	}
+}
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 1949ae7851b2..336243c6f120 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -378,6 +378,8 @@ struct samsung_clk_provider * __init samsung_cmu_register_one(
 		samsung_clk_extended_sleep_init(reg_base,
 			cmu->clk_regs, cmu->nr_clk_regs,
 			cmu->suspend_regs, cmu->nr_suspend_regs);
+	if (cmu->cpu_clks)
+		samsung_clk_register_cpu(ctx, cmu->cpu_clks, cmu->nr_cpu_clks);
 
 	samsung_clk_of_add_provider(np, ctx);
 
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index c1e1a6b2f499..a52a38cc1740 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -271,6 +271,27 @@ struct samsung_pll_clock {
 	__PLL(_typ, _id, _name, _pname, CLK_GET_RATE_NOCACHE, _lock,	\
 	      _con, _rtable)
 
+struct samsung_cpu_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	const char		*alt_parent_name;
+	unsigned long		flags;
+	int			offset;
+	const struct exynos_cpuclk_cfg_data *cfg;
+};
+
+#define CPU_CLK(_id, _name, _pname, _apname, _flags, _offset, _cfg) \
+	{							    \
+		.id		  = _id,			    \
+		.name		  = _name,			    \
+		.parent_name	  = _pname,			    \
+		.alt_parent_name  = _apname,			    \
+		.flags		  = _flags,			    \
+		.offset		  = _offset,			    \
+		.cfg		  = _cfg,			    \
+	}
+
 struct samsung_clock_reg_cache {
 	struct list_head node;
 	void __iomem *reg_base;
@@ -301,6 +322,9 @@ struct samsung_cmu_info {
 	unsigned int nr_fixed_factor_clks;
 	/* total number of clocks with IDs assigned*/
 	unsigned int nr_clk_ids;
+	/* list of cpu clocks and respective count */
+	const struct samsung_cpu_clock *cpu_clks;
+	unsigned int nr_cpu_clks;
 
 	/* list and number of clocks registers */
 	const unsigned long *clk_regs;
@@ -350,6 +374,8 @@ extern void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
 extern void __init samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 			const struct samsung_pll_clock *pll_list,
 			unsigned int nr_clk, void __iomem *base);
+extern void __init samsung_clk_register_cpu(struct samsung_clk_provider *ctx,
+		const struct samsung_cpu_clock *list, unsigned int nr_clk);
 
 extern struct samsung_clk_provider __init *samsung_cmu_register_one(
 			struct device_node *,
-- 
2.33.0.882.g93a45727a2-goog

