Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A130A40B3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhINP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbhINP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:57:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730FCC061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:56:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y28so5620016lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RF1mZx2A0BJwyns60yFc42fN8PngjocR5HugnGLcRUI=;
        b=ySa3Ocvk2eVZjj671XTmWO5NwX254YRYLMXoE4epqOyiUxNdyJVl5cygyx+2niQI7G
         G95L63SwNNBM9rz7FfZ/evy4SWX5zTm6j+K3+84TgBYT6Na+rT8x56PXf3NeaE1ZmYLh
         AEcwX8P19hakB7hvnzisT/peqG7hyNLuCOZh3MEvygFgetrgeawUJJwg3skdP6v5jsPP
         7iOcpH1gZFKLUy0Tuv5ChIO8oWGBXSOdmOh0G452+qa5suRnx/J99nP5pvaGSi6DqPSC
         UwSEOi7+eVYJ9nO7QwOT6c21D1Pd0Lc/4gHtYJBdtmkfdK/bJTH3qhQQUlBeqEf/Qgb1
         qfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RF1mZx2A0BJwyns60yFc42fN8PngjocR5HugnGLcRUI=;
        b=r7M4U1YvBmoakAVeMUmlYgHjkGcSW6EH90PLcGFsIdF+0oGFIbbUJlCglroKhz+UgZ
         MHdkKVJDx/qvyVDZx8lH9Q3GBY1DJKIfBJ23B++dlmgJJsSxXfAXHxF0He4kAwk22KHv
         fS/0sn2kDm0UI2WZSNfbALzXtNEQdMCCxhkBANbOzoDzCQybga7y3coGG2pCPEWS7tNW
         2QN4XMPMGaKQ3ljo3pLlyWRM7Ya1JuWlMFioowNzXdrlH+8oBtIMANh7tpymoT/zeCN0
         1DJhf2F4UkIroDP96gx24ipDUnoTqfTyEqvNFEtGOfrLzxEXPPvNTcPDqzr2C6VoONn2
         CA5Q==
X-Gm-Message-State: AOAM530aNVYPGURSuD+qMbe7eX1H+S+yaasqSoN+ZHDr07nlBZZX6y6C
        +KCDnhgKGk+oX+7zjuHxh5QZAQ==
X-Google-Smtp-Source: ABdhPJwPiCdCkDqZDBjT7EK7856BGPxiZsq+obgm+7zSkvwQSau9b0vjGQGFyNBCCYjOu5Ank1dKjg==
X-Received: by 2002:a05:6512:23a5:: with SMTP id c37mr13869294lfv.321.1631634973802;
        Tue, 14 Sep 2021 08:56:13 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id u16sm1472260ljj.0.2021.09.14.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:56:13 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Ryu Euiyoul <ryu.real@samsung.com>, Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/6] clk: samsung: clk-pll: Implement pll0831x PLL type
Date:   Tue, 14 Sep 2021 18:56:04 +0300
Message-Id: <20210914155607.14122-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914155607.14122-1-semen.protsenko@linaro.org>
References: <20210914155607.14122-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pll0831x PLL is used in Exynos850 SoC for top-level fractional PLLs. The
code was derived from very similar pll36xx type, with next differences:

1. Lock time for pll0831x is 500*P_DIV, when for pll36xx it's 3000*P_DIV
2. It's not suggested in Exynos850 TRM that S_DIV change doesn't require
   performing PLL lock procedure (which is done in pll36xx
   implementation)
3. The offset from PMS-values register to K-value register is 0x8 for
   pll0831x, when for pll36xx it's 0x4

When defining pll0831x type, CON3 register offset should be provided as
a "con" parameter of PLL() macro, like this:

    PLL(pll_0831x, 0, "fout_mmc_pll", "oscclk",
        PLL_LOCKTIME_PLL_MMC, PLL_CON3_PLL_MMC, pll0831x_26mhz_tbl),

To define PLL rates table, one can use PLL_36XX_RATE() macro, e.g.:

    PLL_36XX_RATE(26 * MHZ, 799999877, 31, 1, 0, -15124)

as it's completely appropriate for pl0831x type and there is no sense in
duplicating that.

If bit #1 (MANUAL_PLL_CTRL) is not set in CON1 register, it won't be
possible to set new rate, with next error showing in kernel log:

    Could not lock PLL fout_mmc_pll

That can happen for example if bootloader clears that bit beforehand.
PLL driver doesn't account for that, so if MANUAL_PLL_CTRL bit was
cleared, it's assumed it was done for a reason and it shouldn't be
possible to change that PLL's rate at all.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-pll.c | 105 ++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-pll.h |   1 +
 2 files changed, 106 insertions(+)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 03131b149c0b..83d1b03647db 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -498,6 +498,103 @@ static const struct clk_ops samsung_pll0822x_clk_min_ops = {
 	.recalc_rate = samsung_pll0822x_recalc_rate,
 };
 
+/*
+ * PLL0831x Clock Type
+ */
+/* Maximum lock time can be 500 * PDIV cycles */
+#define PLL0831X_LOCK_FACTOR		(500)
+
+#define PLL0831X_KDIV_MASK		(0xFFFF)
+#define PLL0831X_MDIV_MASK		(0x1FF)
+#define PLL0831X_PDIV_MASK		(0x3F)
+#define PLL0831X_SDIV_MASK		(0x7)
+#define PLL0831X_MDIV_SHIFT		(16)
+#define PLL0831X_PDIV_SHIFT		(8)
+#define PLL0831X_SDIV_SHIFT		(0)
+#define PLL0831X_KDIV_SHIFT		(0)
+#define PLL0831X_LOCK_STAT_SHIFT	(29)
+#define PLL0831X_ENABLE_SHIFT		(31)
+
+static unsigned long samsung_pll0831x_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
+	u32 mdiv, pdiv, sdiv, pll_con3, pll_con5;
+	s16 kdiv;
+	u64 fvco = parent_rate;
+
+	pll_con3 = readl_relaxed(pll->con_reg);
+	pll_con5 = readl_relaxed(pll->con_reg + 8);
+	mdiv = (pll_con3 >> PLL0831X_MDIV_SHIFT) & PLL0831X_MDIV_MASK;
+	pdiv = (pll_con3 >> PLL0831X_PDIV_SHIFT) & PLL0831X_PDIV_MASK;
+	sdiv = (pll_con3 >> PLL0831X_SDIV_SHIFT) & PLL0831X_SDIV_MASK;
+	kdiv = (s16)((pll_con5 >> PLL0831X_KDIV_SHIFT) & PLL0831X_KDIV_MASK);
+
+	fvco *= (mdiv << 16) + kdiv;
+	do_div(fvco, (pdiv << sdiv));
+	fvco >>= 16;
+
+	return (unsigned long)fvco;
+}
+
+static int samsung_pll0831x_set_rate(struct clk_hw *hw, unsigned long drate,
+				     unsigned long parent_rate)
+{
+	const struct samsung_pll_rate_table *rate;
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
+	u32 pll_con3, pll_con5;
+
+	/* Get required rate settings from table */
+	rate = samsung_get_pll_settings(pll, drate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
+			drate, clk_hw_get_name(hw));
+		return -EINVAL;
+	}
+
+	pll_con3 = readl_relaxed(pll->con_reg);
+	pll_con5 = readl_relaxed(pll->con_reg + 8);
+
+	/* Change PLL PMSK values */
+	pll_con3 &= ~((PLL0831X_MDIV_MASK << PLL0831X_MDIV_SHIFT) |
+			(PLL0831X_PDIV_MASK << PLL0831X_PDIV_SHIFT) |
+			(PLL0831X_SDIV_MASK << PLL0831X_SDIV_SHIFT));
+	pll_con3 |= (rate->mdiv << PLL0831X_MDIV_SHIFT) |
+			(rate->pdiv << PLL0831X_PDIV_SHIFT) |
+			(rate->sdiv << PLL0831X_SDIV_SHIFT);
+	pll_con5 &= ~(PLL0831X_KDIV_MASK << PLL0831X_KDIV_SHIFT);
+	/*
+	 * kdiv is 16-bit 2's complement (s16), but stored as unsigned int.
+	 * Cast it to u16 to avoid leading 0xffff's in case of negative value.
+	 */
+	pll_con5 |= ((u16)rate->kdiv << PLL0831X_KDIV_SHIFT);
+
+	/* Set PLL lock time */
+	writel_relaxed(rate->pdiv * PLL0831X_LOCK_FACTOR, pll->lock_reg);
+
+	/* Write PMSK values */
+	writel_relaxed(pll_con3, pll->con_reg);
+	writel_relaxed(pll_con5, pll->con_reg + 8);
+
+	/* Wait for PLL lock if the PLL is enabled */
+	if (pll_con3 & BIT(pll->enable_offs))
+		return samsung_pll_lock_wait(pll, BIT(pll->lock_offs));
+
+	return 0;
+}
+
+static const struct clk_ops samsung_pll0831x_clk_ops = {
+	.recalc_rate = samsung_pll0831x_recalc_rate,
+	.set_rate = samsung_pll0831x_set_rate,
+	.round_rate = samsung_pll_round_rate,
+	.enable = samsung_pll3xxx_enable,
+	.disable = samsung_pll3xxx_disable,
+};
+
+static const struct clk_ops samsung_pll0831x_clk_min_ops = {
+	.recalc_rate = samsung_pll0831x_recalc_rate,
+};
+
 /*
  * PLL45xx Clock Type
  */
@@ -1407,6 +1504,14 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 		else
 			init.ops = &samsung_pll36xx_clk_ops;
 		break;
+	case pll_0831x:
+		pll->enable_offs = PLL0831X_ENABLE_SHIFT;
+		pll->lock_offs = PLL0831X_LOCK_STAT_SHIFT;
+		if (!pll->rate_table)
+			init.ops = &samsung_pll0831x_clk_min_ops;
+		else
+			init.ops = &samsung_pll0831x_clk_ops;
+		break;
 	case pll_6552:
 	case pll_6552_s3c2416:
 		init.ops = &samsung_pll6552_clk_ops;
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 213e94a97f23..a739f2b7ae80 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -37,6 +37,7 @@ enum samsung_pll_type {
 	pll_1452x,
 	pll_1460x,
 	pll_0822x,
+	pll_0831x,
 };
 
 #define PLL_RATE(_fin, _m, _p, _s, _k, _ks) \
-- 
2.30.2

