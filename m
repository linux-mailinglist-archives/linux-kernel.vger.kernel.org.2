Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8660842E23E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhJNT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhJNT4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:56:00 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A37C061755
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:53:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j18-20020a633c12000000b0029956680edaso3352437pga.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0GKVOGkPMBjbaiErSowZ5WVlrNu9T3lMTGZvDZcgDiQ=;
        b=O2y756NxwhwBs3hCW4hzTGJSUy8ycUL5Kon8QUqqwOzeQTsmkbudN71Z8nfyOh1ajI
         5uzBMRTKntgvLwftR+g17/k6r/G2Cw1LPAGWICo/u28QZABdyNojDa7VGTnSfxCLybYx
         3HiHSKCLyV4mwqU+PdHrKOZembQ2GXb0IyHQcxsOEk0LRO1/S/e4/E8uPZwiY/g1jTm1
         CjfmJVvtqS8COv4tY4bqiJW5z1jUx2P6nHjEJPp/a79pTD2T8fgw1jCZ8ap+j/SX2skt
         WyKFUkaT5La9nbizAqKE+rW9oKqJjzoWmCmIvoP/XjRvMOJHFCyWzZ4yEjoDUQ1F9liT
         Rhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0GKVOGkPMBjbaiErSowZ5WVlrNu9T3lMTGZvDZcgDiQ=;
        b=ChcbY0PGG1PJqUuXTXCO5THoP7PPDEhm1hVAuE60+aUk/UqCstEOlAasuAKrbjrbKm
         PbTHKoqxODDdOI48NAToEFUduVOcye1lPzgSTJFh4YdBv0l7FdaYcDNaewTxLi2/L4mk
         9OEQm8Vf0uvgzGvU3clHQuwTmmvT92oxodHS367WDSLRnD2DGtOsj8GZwpsNuEWCTQZz
         MyGibRcA4wJHje7DgWValB9qUYCRtQPfeJ8yigCHulOvDRNH/jZYZ+hohV9RLGG0Belu
         Q1ASkafQfklhHLaRb93i+QO5W99ui0BW78FwXzK6maxKyPaQAm2P2bPDV65xfgdVXc4j
         o2/A==
X-Gm-Message-State: AOAM531EXBJogfpOVabsjX89Zu0XzXPWEteTKWShFqwu1Ur/ZZ1e86ZJ
        mjl+ywhldEneIzl5LS4+aG/WwGX6+GV/mjwJqNg=
X-Google-Smtp-Source: ABdhPJz4vELIwsudd5JRcFZ1QD4iWztE+ipKg383YgxXZq5OfuRfj2Qb43PQEb0T9XFYzew4p7mFVl9csvZEHEdEU4c=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a17:903:31cd:b0:134:5b6f:2ff8 with
 SMTP id v13-20020a17090331cd00b001345b6f2ff8mr6925892ple.46.1634241234621;
 Thu, 14 Oct 2021 12:53:54 -0700 (PDT)
Date:   Thu, 14 Oct 2021 19:53:45 +0000
In-Reply-To: <20211014195347.3635601-1-willmcvicker@google.com>
Message-Id: <20211014195347.3635601-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20211014195347.3635601-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 1/2] [RFT] clk: samsung: add support for CPU clocks
From:   Will McVicker <willmcvicker@google.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     kernel-team@android.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Will McVicker <willmcvicker@google.com>,
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
 drivers/clk/samsung/clk-cpu.c | 18 ++++++++++++++++++
 drivers/clk/samsung/clk.c     |  2 ++
 drivers/clk/samsung/clk.h     | 26 ++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 00ef4d1b0888..7f20d9aedaa9 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -469,3 +469,21 @@ int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 	kfree(cpuclk);
 	return ret;
 }
+
+void __init samsung_clk_register_cpu(struct samsung_clk_provider *ctx,
+		const struct samsung_cpu_clock *list, unsigned int nr_clk)
+{
+	unsigned int idx;
+	unsigned int num_cfgs;
+	struct clk_hw **hws = ctx->clk_data.hws;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		/* find count of configuration rates in cfg */
+		for (num_cfgs = 0; list->cfg[num_cfgs].prate != 0; )
+			num_cfgs++;
+
+		exynos_register_cpu_clock(ctx, list->id, list->name, hws[list->parent_id],
+				hws[list->alt_parent_id], list->offset, list->cfg, num_cfgs,
+				list->flags);
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
index c1e1a6b2f499..26499e97275b 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -271,6 +271,27 @@ struct samsung_pll_clock {
 	__PLL(_typ, _id, _name, _pname, CLK_GET_RATE_NOCACHE, _lock,	\
 	      _con, _rtable)
 
+struct samsung_cpu_clock {
+	unsigned int	id;
+	const char	*name;
+	unsigned int	parent_id;
+	unsigned int	alt_parent_id;
+	unsigned long	flags;
+	int		offset;
+	const struct exynos_cpuclk_cfg_data *cfg;
+};
+
+#define CPU_CLK(_id, _name, _pid, _apid, _flags, _offset, _cfg) \
+	{							\
+		.id		  = _id,			\
+		.name		  = _name,			\
+		.parent_id	  = _pid,			\
+		.alt_parent_id	  = _apid,			\
+		.flags		  = _flags,			\
+		.offset		  = _offset,			\
+		.cfg		  = _cfg,			\
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
+extern void samsung_clk_register_cpu(struct samsung_clk_provider *ctx,
+		const struct samsung_cpu_clock *list, unsigned int nr_clk);
 
 extern struct samsung_clk_provider __init *samsung_cmu_register_one(
 			struct device_node *,
-- 
2.33.0.1079.g6e70778dc9-goog

