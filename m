Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3744E4568A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhKSDgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:36:45 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34629 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231964AbhKSDgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:36:44 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BD9EF3201C35;
        Thu, 18 Nov 2021 22:33:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 18 Nov 2021 22:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=1fkY8D2gSD0qy
        VwcUvJM6KMxohk36Zo6VZZDFOnMIhY=; b=egMuqO20wu97udT9oe/HmsuqkCTdl
        enHZtQi8IUzopWyzrE0N7ma6lGzhuPZQo1rZUMcDV5QuHa5LtUFYJlaJo38ozjAI
        Nxovilfay5YifFy96K2BQQmsoMAuYynV0UCLlKK1JNV0vzGT8I1cvXhaM0reZisL
        PgK/DcBwkOYW/oJ7Gfvlb1E9lc7LemAcvkqR8dWxg+Qq3F6MnBVXw0W+fQB4iQ+b
        +tlkVS62AHoq2njVlWoteBI1Deuz9GNyl6mURHNiXgbVcbLmi9US+yJMZDhpF+ms
        4GkfOqlgEVg2mBoK69WlGVZS3mDcr+sh3tygWdeZe/oL9T5ivqWCMch1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=1fkY8D2gSD0qyVwcUvJM6KMxohk36Zo6VZZDFOnMIhY=; b=I9qo3Scl
        U0Jb3ZemLox7HkmNql+Gz9kpx2B7udShY8H1KRcu7K+CegJ9aS9lFIZo0rMWBcYe
        JqoA1TTjvfexhv/ymF+nZ6y8Qw7xzmYaowFhrPF5tWmWU+pjte4tnCm7mXZfAftE
        pnJhA5ETfOjH3e0PET5x+l8IK8VV7krU8OBiglDizfNeFKayxAoCBbfMJmNu5i3j
        w6yuBtuIcEoTBnTuoQLnbVd5+DFE/WDmU9fhLZXgFBA07zyk06AcG8QtID750uQV
        Oa6AllJFIdHDvK5rHwFCYL0TQDm8xSAAfZaEXs6NDx3R+3KjhaqeUGLz5Pif1HKK
        abodgGAUY3IgcQ==
X-ME-Sender: <xms:FhuXYWz25trWSeitnOvavhZ0URKSwRIFqhK8wdYlUOwFDzY1FasBBw>
    <xme:FhuXYSQQQtHT2syBULZfNTOIXOyGQGr1u6ficW6UHoIKGD5ejDTZ1HZWgYpG1JKUz
    QkX6rgEk7KU1s9y3w>
X-ME-Received: <xmr:FhuXYYWPMYQPNzMBNgc7P7ntqxlxZzApaSwQaXG-iW5w9tt4C-kS5CCFfRrQoH14LHRY3VNf1QpS4fjwmCIeveI-OGAx1hJ3CrHolygoYeY8Rx2IOg_nTYXWpE6brULeSClUUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:FhuXYcgFi7nVTEze5QdDeJlJkq_KsFV60SDocnWKdE5C2mFTUVDO0Q>
    <xmx:FhuXYYDqBugNfw9OyBsbIcnU4cj-diEvqipd6FO41c1IwApMHh2w5Q>
    <xmx:FhuXYdJ0h7BB7sJ3EuYXmmVtL3ahMQHf4rZzRgZowvZYgpnMXJiehg>
    <xmx:FhuXYU1jpxN3gwftjjytzBozwTQwmQ-2r6FcGSaNAU_bMoRHhdUuLg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 22:33:41 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 1/4] clk: sunxi-ng: Export symbols used by CCU drivers
Date:   Thu, 18 Nov 2021 21:33:34 -0600
Message-Id: <20211119033338.25486-2-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119033338.25486-1-samuel@sholland.org>
References: <20211119033338.25486-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the individual CCU drivers to be built as modules, the ops structs,
helper functions, and callback registration functions must be exported.
These symbols are intended for use only by the adjacent CCU drivers, so
export them into the SUNXI_CCU namespace.

of_sunxi_ccu_probe is not exported because it is only used by built-in
OF clock providers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Also export helper functions.

Changes in v2:
 - Export symbols to the SUNXI_CCU namespace.

 drivers/clk/sunxi-ng/ccu_common.c | 3 +++
 drivers/clk/sunxi-ng/ccu_div.c    | 1 +
 drivers/clk/sunxi-ng/ccu_frac.c   | 6 ++++++
 drivers/clk/sunxi-ng/ccu_gate.c   | 4 ++++
 drivers/clk/sunxi-ng/ccu_mp.c     | 2 ++
 drivers/clk/sunxi-ng/ccu_mult.c   | 1 +
 drivers/clk/sunxi-ng/ccu_mux.c    | 6 ++++++
 drivers/clk/sunxi-ng/ccu_nk.c     | 1 +
 drivers/clk/sunxi-ng/ccu_nkm.c    | 1 +
 drivers/clk/sunxi-ng/ccu_nkmp.c   | 1 +
 drivers/clk/sunxi-ng/ccu_nm.c     | 1 +
 drivers/clk/sunxi-ng/ccu_phase.c  | 1 +
 drivers/clk/sunxi-ng/ccu_reset.c  | 1 +
 drivers/clk/sunxi-ng/ccu_sdm.c    | 6 ++++++
 14 files changed, 35 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 31af8b6b5286..6afdedbce6a2 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -36,6 +36,7 @@ void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock)
 
 	WARN_ON(readl_relaxed_poll_timeout(addr, reg, reg & lock, 100, 70000));
 }
+EXPORT_SYMBOL_NS_GPL(ccu_helper_wait_for_lock, SUNXI_CCU);
 
 /*
  * This clock notifier is called when the frequency of a PLL clock is
@@ -83,6 +84,7 @@ int ccu_pll_notifier_register(struct ccu_pll_nb *pll_nb)
 	return clk_notifier_register(pll_nb->common->hw.clk,
 				     &pll_nb->clk_nb);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_pll_notifier_register, SUNXI_CCU);
 
 static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
 			   struct device_node *node, void __iomem *reg,
@@ -194,6 +196,7 @@ int devm_sunxi_ccu_probe(struct device *dev, void __iomem *reg,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(devm_sunxi_ccu_probe, SUNXI_CCU);
 
 void of_sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 			const struct sunxi_ccu_desc *desc)
diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index 4c297089483c..cb10a3ea23f9 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -141,3 +141,4 @@ const struct clk_ops ccu_div_ops = {
 	.recalc_rate	= ccu_div_recalc_rate,
 	.set_rate	= ccu_div_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_div_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_frac.c b/drivers/clk/sunxi-ng/ccu_frac.c
index 44fcded8b354..b31f3ad946d6 100644
--- a/drivers/clk/sunxi-ng/ccu_frac.c
+++ b/drivers/clk/sunxi-ng/ccu_frac.c
@@ -18,6 +18,7 @@ bool ccu_frac_helper_is_enabled(struct ccu_common *common,
 
 	return !(readl(common->base + common->reg) & cf->enable);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_frac_helper_is_enabled, SUNXI_CCU);
 
 void ccu_frac_helper_enable(struct ccu_common *common,
 			    struct ccu_frac_internal *cf)
@@ -33,6 +34,7 @@ void ccu_frac_helper_enable(struct ccu_common *common,
 	writel(reg & ~cf->enable, common->base + common->reg);
 	spin_unlock_irqrestore(common->lock, flags);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_frac_helper_enable, SUNXI_CCU);
 
 void ccu_frac_helper_disable(struct ccu_common *common,
 			     struct ccu_frac_internal *cf)
@@ -48,6 +50,7 @@ void ccu_frac_helper_disable(struct ccu_common *common,
 	writel(reg | cf->enable, common->base + common->reg);
 	spin_unlock_irqrestore(common->lock, flags);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_frac_helper_disable, SUNXI_CCU);
 
 bool ccu_frac_helper_has_rate(struct ccu_common *common,
 			      struct ccu_frac_internal *cf,
@@ -58,6 +61,7 @@ bool ccu_frac_helper_has_rate(struct ccu_common *common,
 
 	return (cf->rates[0] == rate) || (cf->rates[1] == rate);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_frac_helper_has_rate, SUNXI_CCU);
 
 unsigned long ccu_frac_helper_read_rate(struct ccu_common *common,
 					struct ccu_frac_internal *cf)
@@ -79,6 +83,7 @@ unsigned long ccu_frac_helper_read_rate(struct ccu_common *common,
 
 	return (reg & cf->select) ? cf->rates[1] : cf->rates[0];
 }
+EXPORT_SYMBOL_NS_GPL(ccu_frac_helper_read_rate, SUNXI_CCU);
 
 int ccu_frac_helper_set_rate(struct ccu_common *common,
 			     struct ccu_frac_internal *cf,
@@ -107,3 +112,4 @@ int ccu_frac_helper_set_rate(struct ccu_common *common,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(ccu_frac_helper_set_rate, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu_gate.c
index 3d5ca092b08f..a2115a21807d 100644
--- a/drivers/clk/sunxi-ng/ccu_gate.c
+++ b/drivers/clk/sunxi-ng/ccu_gate.c
@@ -24,6 +24,7 @@ void ccu_gate_helper_disable(struct ccu_common *common, u32 gate)
 
 	spin_unlock_irqrestore(common->lock, flags);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_gate_helper_disable, SUNXI_CCU);
 
 static void ccu_gate_disable(struct clk_hw *hw)
 {
@@ -49,6 +50,7 @@ int ccu_gate_helper_enable(struct ccu_common *common, u32 gate)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(ccu_gate_helper_enable, SUNXI_CCU);
 
 static int ccu_gate_enable(struct clk_hw *hw)
 {
@@ -64,6 +66,7 @@ int ccu_gate_helper_is_enabled(struct ccu_common *common, u32 gate)
 
 	return readl(common->base + common->reg) & gate;
 }
+EXPORT_SYMBOL_NS_GPL(ccu_gate_helper_is_enabled, SUNXI_CCU);
 
 static int ccu_gate_is_enabled(struct clk_hw *hw)
 {
@@ -124,3 +127,4 @@ const struct clk_ops ccu_gate_ops = {
 	.set_rate	= ccu_gate_set_rate,
 	.recalc_rate	= ccu_gate_recalc_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_gate_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index 9d3a76604d94..57cf2d615148 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -245,6 +245,7 @@ const struct clk_ops ccu_mp_ops = {
 	.recalc_rate	= ccu_mp_recalc_rate,
 	.set_rate	= ccu_mp_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_mp_ops, SUNXI_CCU);
 
 /*
  * Support for MMC timing mode switching
@@ -325,3 +326,4 @@ const struct clk_ops ccu_mp_mmc_ops = {
 	.recalc_rate	= ccu_mp_mmc_recalc_rate,
 	.set_rate	= ccu_mp_mmc_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_mp_mmc_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index 7c8cf2e04e94..7bee217ef111 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -170,3 +170,4 @@ const struct clk_ops ccu_mult_ops = {
 	.recalc_rate	= ccu_mult_recalc_rate,
 	.set_rate	= ccu_mult_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_mult_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 7d75da9a1f2e..2306a1cd83e4 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -64,6 +64,7 @@ unsigned long ccu_mux_helper_apply_prediv(struct ccu_common *common,
 {
 	return parent_rate / ccu_mux_get_prediv(common, cm, parent_index);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_mux_helper_apply_prediv, SUNXI_CCU);
 
 static unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *common,
 					    struct ccu_mux_internal *cm,
@@ -152,6 +153,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 	req->rate = best_rate;
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(ccu_mux_helper_determine_rate, SUNXI_CCU);
 
 u8 ccu_mux_helper_get_parent(struct ccu_common *common,
 			     struct ccu_mux_internal *cm)
@@ -174,6 +176,7 @@ u8 ccu_mux_helper_get_parent(struct ccu_common *common,
 
 	return parent;
 }
+EXPORT_SYMBOL_NS_GPL(ccu_mux_helper_get_parent, SUNXI_CCU);
 
 int ccu_mux_helper_set_parent(struct ccu_common *common,
 			      struct ccu_mux_internal *cm,
@@ -195,6 +198,7 @@ int ccu_mux_helper_set_parent(struct ccu_common *common,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(ccu_mux_helper_set_parent, SUNXI_CCU);
 
 static void ccu_mux_disable(struct clk_hw *hw)
 {
@@ -251,6 +255,7 @@ const struct clk_ops ccu_mux_ops = {
 	.determine_rate	= __clk_mux_determine_rate,
 	.recalc_rate	= ccu_mux_recalc_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_mux_ops, SUNXI_CCU);
 
 /*
  * This clock notifier is called when the frequency of the of the parent
@@ -285,3 +290,4 @@ int ccu_mux_notifier_register(struct clk *clk, struct ccu_mux_nb *mux_nb)
 
 	return clk_notifier_register(clk, &mux_nb->clk_nb);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_mux_notifier_register, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
index aee68b00f3b2..c4fb82af97e8 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.c
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -157,3 +157,4 @@ const struct clk_ops ccu_nk_ops = {
 	.round_rate	= ccu_nk_round_rate,
 	.set_rate	= ccu_nk_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_nk_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index b9cfee0276ea..67da2c189b53 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -206,3 +206,4 @@ const struct clk_ops ccu_nkm_ops = {
 	.recalc_rate	= ccu_nkm_recalc_rate,
 	.set_rate	= ccu_nkm_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_nkm_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index bda87b38c45c..39413cb0985c 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -230,3 +230,4 @@ const struct clk_ops ccu_nkmp_ops = {
 	.round_rate	= ccu_nkmp_round_rate,
 	.set_rate	= ccu_nkmp_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_nkmp_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index e6bcc0a7170c..9ca9257f4426 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -238,3 +238,4 @@ const struct clk_ops ccu_nm_ops = {
 	.round_rate	= ccu_nm_round_rate,
 	.set_rate	= ccu_nm_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_nm_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_phase.c b/drivers/clk/sunxi-ng/ccu_phase.c
index 92ab8bd66427..e4cae2afe9db 100644
--- a/drivers/clk/sunxi-ng/ccu_phase.c
+++ b/drivers/clk/sunxi-ng/ccu_phase.c
@@ -121,3 +121,4 @@ const struct clk_ops ccu_phase_ops = {
 	.get_phase	= ccu_phase_get_phase,
 	.set_phase	= ccu_phase_set_phase,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_phase_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_reset.c b/drivers/clk/sunxi-ng/ccu_reset.c
index 483100e45df3..6577aa18cb01 100644
--- a/drivers/clk/sunxi-ng/ccu_reset.c
+++ b/drivers/clk/sunxi-ng/ccu_reset.c
@@ -75,3 +75,4 @@ const struct reset_control_ops ccu_reset_ops = {
 	.reset		= ccu_reset_reset,
 	.status		= ccu_reset_status,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_reset_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_sdm.c b/drivers/clk/sunxi-ng/ccu_sdm.c
index 79581a1c649a..41937ed0766d 100644
--- a/drivers/clk/sunxi-ng/ccu_sdm.c
+++ b/drivers/clk/sunxi-ng/ccu_sdm.c
@@ -20,6 +20,7 @@ bool ccu_sdm_helper_is_enabled(struct ccu_common *common,
 
 	return !!(readl(common->base + sdm->tuning_reg) & sdm->tuning_enable);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_is_enabled, SUNXI_CCU);
 
 void ccu_sdm_helper_enable(struct ccu_common *common,
 			   struct ccu_sdm_internal *sdm,
@@ -49,6 +50,7 @@ void ccu_sdm_helper_enable(struct ccu_common *common,
 	writel(reg | sdm->enable, common->base + common->reg);
 	spin_unlock_irqrestore(common->lock, flags);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_enable, SUNXI_CCU);
 
 void ccu_sdm_helper_disable(struct ccu_common *common,
 			    struct ccu_sdm_internal *sdm)
@@ -69,6 +71,7 @@ void ccu_sdm_helper_disable(struct ccu_common *common,
 	writel(reg & ~sdm->tuning_enable, common->base + sdm->tuning_reg);
 	spin_unlock_irqrestore(common->lock, flags);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_disable, SUNXI_CCU);
 
 /*
  * Sigma delta modulation provides a way to do fractional-N frequency
@@ -102,6 +105,7 @@ bool ccu_sdm_helper_has_rate(struct ccu_common *common,
 
 	return false;
 }
+EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_has_rate, SUNXI_CCU);
 
 unsigned long ccu_sdm_helper_read_rate(struct ccu_common *common,
 				       struct ccu_sdm_internal *sdm,
@@ -132,6 +136,7 @@ unsigned long ccu_sdm_helper_read_rate(struct ccu_common *common,
 	/* We can't calculate the effective clock rate, so just fail. */
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_read_rate, SUNXI_CCU);
 
 int ccu_sdm_helper_get_factors(struct ccu_common *common,
 			       struct ccu_sdm_internal *sdm,
@@ -153,3 +158,4 @@ int ccu_sdm_helper_get_factors(struct ccu_common *common,
 	/* nothing found */
 	return -EINVAL;
 }
+EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_get_factors, SUNXI_CCU);
-- 
2.32.0

