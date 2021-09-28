Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A1441A9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbhI1HlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:41:09 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:57989 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239287AbhI1HlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:41:08 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EB0DA3201E87;
        Tue, 28 Sep 2021 03:39:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Sep 2021 03:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=DWF+p9YbD0hLg
        2FdhNa3X8UTo55dbts1qgkMeUtsZhQ=; b=RLGzRQKklRhJRUeL6T2QMJyaPwxwC
        /3Nfi2Wrt1GcP0MCCgQflvK8QKkgKaxsB3/F/RDFovsE/ZfvEc2/sJneSDRxIdAd
        TtfFe3BnGFZXnnCEj9j8u/TqscTxOxFgtiMFbwX8StQvy+1Z+4NtMSBxdbQp5JD9
        wIzfG4jD0gDo7CRfzvdJreXtp0bF2C+VmfvhC8NCPZOZOOWGTti8R5fuamJ4FR6u
        tlMIelNgUNTWd2I94W5kyOzDB/PX2ReX+ImD82J9Ob0CpeB70kXfaisFHdI6pOZv
        GLGLRQGiKl43MhdU7i9+fIRR5+bdgXkfqOTnaCvIGcnqBbzCaljd+V29g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=DWF+p9YbD0hLg2FdhNa3X8UTo55dbts1qgkMeUtsZhQ=; b=KUkjDzJq
        HRHg+QgN5IKeLr2nYduve7Irzh5DWQtmw1ChHgSlWHbVM5BpvYfni2SR85cAAO3I
        TPV035x6BJYHUlaLzz92JsUnmkiaLRztVvcytI4k07WqoQovuoGBfmIsq5JwxI8v
        WROOGttNk5JAC3RlQldM+NZek3T0IsoZ5/zjpk4qNB3zTgftFtisp6lIB1E1e+BJ
        sY6t5Edf7C5/Ip4MduZgqPmcSl1+C8Sx//ckPhw/Z112SKEJbnV8baifWxYtMTcA
        FgRRZpBCpF7cvGugeHXh7qxejzxjqZR3ieUKagl1ExZsyQNvn4UqD6hmkMk/xVg/
        GlfowY4WQzWgrw==
X-ME-Sender: <xms:rsZSYX3S3xgScMbdYBvMYPqAirYp17UiKZlrVCkIdqtjdFZq2J0UdA>
    <xme:rsZSYWEJm2fN1ZFmmC6u2fy-O2skgEn9clVQWt6FrDI6z_v1B5hukyIv4JddHZuCC
    07txdC9b3W-_cG1XA>
X-ME-Received: <xmr:rsZSYX58PCLRc-HfnkHTQeDwvdRI6HfwcotqqsbJNqAMwswHTFP-ZayhDOxH-nQMkxcStDxpmHhMRF6cu7nVUS7zbOFEYwmD7uBuyfIBp0P_0GHlbKG9ZjHIt1VboC9En17gJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheej
    vdfgjeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:rsZSYc2hpTjUI97OsOFVLefvoDsLdxbfekLC_Suez_-COv5SboCulg>
    <xmx:rsZSYaHWIxmh1Qw8SWSbqa7lFcMWmtjM_eZMa0KfdetqPy3fxiUghA>
    <xmx:rsZSYd-kaeJdhbhPI7ok_Oov7NGaBqOJlLLC5EpHAidjFwvzd4_Usg>
    <xmx:rsZSYYaAGwsDEJJDgjrQq-TjtDfvRjBMzsgZo0P4jhPJ_NWaolVMag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 03:39:25 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 1/4] clk: sunxi-ng: Export symbols used by CCU drivers
Date:   Tue, 28 Sep 2021 02:39:19 -0500
Message-Id: <20210928073922.34264-2-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928073922.34264-1-samuel@sholland.org>
References: <20210928073922.34264-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the individual CCU drivers to be built as modules, the ops structs
and callback registration functions must be exported. These symbols are
intended for use only by the adjacent CCU drivers, so export them into
the SUNXI_CCU namespace.

None of the helper functions need to be exported, because those
functions are only referenced from the corresponding ops structs.
of_sunxi_ccu_probe is not exported either, because it is only used
by built-in early OF clock providers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu_common.c | 2 ++
 drivers/clk/sunxi-ng/ccu_div.c    | 1 +
 drivers/clk/sunxi-ng/ccu_gate.c   | 1 +
 drivers/clk/sunxi-ng/ccu_mp.c     | 2 ++
 drivers/clk/sunxi-ng/ccu_mult.c   | 1 +
 drivers/clk/sunxi-ng/ccu_mux.c    | 2 ++
 drivers/clk/sunxi-ng/ccu_nk.c     | 1 +
 drivers/clk/sunxi-ng/ccu_nkm.c    | 1 +
 drivers/clk/sunxi-ng/ccu_nkmp.c   | 1 +
 drivers/clk/sunxi-ng/ccu_nm.c     | 1 +
 drivers/clk/sunxi-ng/ccu_phase.c  | 1 +
 drivers/clk/sunxi-ng/ccu_reset.c  | 1 +
 12 files changed, 15 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 31af8b6b5286..fe35336f6b87 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -83,6 +83,7 @@ int ccu_pll_notifier_register(struct ccu_pll_nb *pll_nb)
 	return clk_notifier_register(pll_nb->common->hw.clk,
 				     &pll_nb->clk_nb);
 }
+EXPORT_SYMBOL_NS_GPL(ccu_pll_notifier_register, SUNXI_CCU);
 
 static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
 			   struct device_node *node, void __iomem *reg,
@@ -194,6 +195,7 @@ int devm_sunxi_ccu_probe(struct device *dev, void __iomem *reg,
 
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
diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu_gate.c
index 3d5ca092b08f..b77288f44118 100644
--- a/drivers/clk/sunxi-ng/ccu_gate.c
+++ b/drivers/clk/sunxi-ng/ccu_gate.c
@@ -124,3 +124,4 @@ const struct clk_ops ccu_gate_ops = {
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
index 7d75da9a1f2e..e8149f3c2324 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -251,6 +251,7 @@ const struct clk_ops ccu_mux_ops = {
 	.determine_rate	= __clk_mux_determine_rate,
 	.recalc_rate	= ccu_mux_recalc_rate,
 };
+EXPORT_SYMBOL_NS_GPL(ccu_mux_ops, SUNXI_CCU);
 
 /*
  * This clock notifier is called when the frequency of the of the parent
@@ -285,3 +286,4 @@ int ccu_mux_notifier_register(struct clk *clk, struct ccu_mux_nb *mux_nb)
 
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
-- 
2.31.1

