Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F13FD2B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbhIAFGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:06:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55891 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241922AbhIAFGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:06:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6274B5C0192;
        Wed,  1 Sep 2021 01:05:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Sep 2021 01:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=AnImziPhfH+l1
        21jpnfIuI04ucw53R8ndu9hQhiBnb0=; b=aeCJQi987WsLL2flOmeY/HOKgl4wH
        v0Wl1LPzLjbtR6H82c0WV/g0dRl31DF9r1mmTnhm1JEKoTjFp6+5I6WB3a5MGdEc
        46NhX1RukPhslnsnfPuYteILaEz8BDLCGzUHpOs5dFfyYD52uj3+KRRpoiIyx7xV
        QisfmmLw9RCCLRAykx6HVlCGrGVE3QBNylKHXjjXzsTlnlr6dnTlVYWBtp6ZMIf1
        /bW7YEa++W79lm1KCNqxy4cT6aFen9fy+rDFbSp4JcmtjGRBmVNBEmS3AxHcATT1
        YglxPSqjGgUyu5sMKlZqWJ/bURXs3RLra/XSv+VhFvfnpGPHPunw7SxSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=AnImziPhfH+l121jpnfIuI04ucw53R8ndu9hQhiBnb0=; b=F8HuZwH2
        oPbIRD0OYsAQ7gdmzoexJZQ7NBmR/su4kcmKBp50Sc4bwTmHHBs5X7uOflvkk1GC
        5/jg3kdxK3o4hgcIq6TenxPRHoyHZUAEBqNkCO+e+F2ynpc5358YILnr4SqmXgvM
        2DZ98uK1WOZa9UgKnPmCHqszIbtic6AAYDQhZ6tpNzRXovxkpyQTNWRVsLh2XgvF
        heq3ZZ07lJak3+Rw1qFya7k/ghl0V1v5heCrzcB78AGkz9egbNl4r+NMOSXvTlot
        a9EqLFS+oQGvNq4dkpsYsUyylB4kRDlgnYoc8nraqQMmjN/G5cysdd6jiHG/qPSp
        ssJoozNbHIaxBA==
X-ME-Sender: <xms:HwovYe3_q1qw0R17Ntw2LZvHOEsNmUruuMP1XS9BnDk1kGP9x5g8pQ>
    <xme:HwovYRECnd_XpGXQWCMovNK3Xzani7jrrdeRMa9se1qs1QdDYXIOZ-CZnB5N71h7F
    joxG6s8otygXbC8pQ>
X-ME-Received: <xmr:HwovYW5_weKVdDb5rh3U6kJOGhWmH7-phXnoAScMm22rd001wW_j6fFzIcJijOiIy2-wAJ2Boi9J0-pelrdgpvztVB7PdiUDmGhfZSrVW6u1klZ6p5HtLPl0Gh8oZmbmelWT5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HwovYf2BK4d7ydnJfG8l4WuJtgz8v-ifWSzLQaszOehLft2LUigsmQ>
    <xmx:HwovYRFrzxsBITugrYZpGC2RlBNvJQSt1610AqiaRw7JXd-jculEHg>
    <xmx:HwovYY94FCQOtmxe6WHvtqPOyt49TzjSPNpmTD4zYG320cerFsS1Cg>
    <xmx:HwovYXYfp0vpR-dzLa22XQfFmTMZ7c8mPx00Bz6O7jIoMGOj_S5buw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:05:34 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 5/8] clk: sunxi-ng: Export symbols used by CCU drivers
Date:   Wed,  1 Sep 2021 00:05:23 -0500
Message-Id: <20210901050526.45673-6-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901050526.45673-1-samuel@sholland.org>
References: <20210901050526.45673-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the individual drivers to be built as modules, the ops structs and
callback registration functions must be exported. None of the helper
functions are exported, because they are only referenced from the
corresponding ops structs. of_sunxi_ccu_probe is not exported, because
it is only used for built-in early OF clock providers.

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
index 31af8b6b5286..3ab109582646 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -83,6 +83,7 @@ int ccu_pll_notifier_register(struct ccu_pll_nb *pll_nb)
 	return clk_notifier_register(pll_nb->common->hw.clk,
 				     &pll_nb->clk_nb);
 }
+EXPORT_SYMBOL_GPL(ccu_pll_notifier_register);
 
 static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
 			   struct device_node *node, void __iomem *reg,
@@ -194,6 +195,7 @@ int devm_sunxi_ccu_probe(struct device *dev, void __iomem *reg,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(devm_sunxi_ccu_probe);
 
 void of_sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 			const struct sunxi_ccu_desc *desc)
diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index 4c297089483c..74f82a5e340a 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -141,3 +141,4 @@ const struct clk_ops ccu_div_ops = {
 	.recalc_rate	= ccu_div_recalc_rate,
 	.set_rate	= ccu_div_set_rate,
 };
+EXPORT_SYMBOL_GPL(ccu_div_ops);
diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu_gate.c
index 3d5ca092b08f..3c568efaabff 100644
--- a/drivers/clk/sunxi-ng/ccu_gate.c
+++ b/drivers/clk/sunxi-ng/ccu_gate.c
@@ -124,3 +124,4 @@ const struct clk_ops ccu_gate_ops = {
 	.set_rate	= ccu_gate_set_rate,
 	.recalc_rate	= ccu_gate_recalc_rate,
 };
+EXPORT_SYMBOL_GPL(ccu_gate_ops);
diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index 9d3a76604d94..cef8e7cba555 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -245,6 +245,7 @@ const struct clk_ops ccu_mp_ops = {
 	.recalc_rate	= ccu_mp_recalc_rate,
 	.set_rate	= ccu_mp_set_rate,
 };
+EXPORT_SYMBOL_GPL(ccu_mp_ops);
 
 /*
  * Support for MMC timing mode switching
@@ -325,3 +326,4 @@ const struct clk_ops ccu_mp_mmc_ops = {
 	.recalc_rate	= ccu_mp_mmc_recalc_rate,
 	.set_rate	= ccu_mp_mmc_set_rate,
 };
+EXPORT_SYMBOL_GPL(ccu_mp_mmc_ops);
diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index 7c8cf2e04e94..a7223bd3e9f9 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -170,3 +170,4 @@ const struct clk_ops ccu_mult_ops = {
 	.recalc_rate	= ccu_mult_recalc_rate,
 	.set_rate	= ccu_mult_set_rate,
 };
+EXPORT_SYMBOL_GPL(ccu_mult_ops);
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 7d75da9a1f2e..785803cd7e51 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -251,6 +251,7 @@ const struct clk_ops ccu_mux_ops = {
 	.determine_rate	= __clk_mux_determine_rate,
 	.recalc_rate	= ccu_mux_recalc_rate,
 };
+EXPORT_SYMBOL_GPL(ccu_mux_ops);
 
 /*
  * This clock notifier is called when the frequency of the of the parent
@@ -285,3 +286,4 @@ int ccu_mux_notifier_register(struct clk *clk, struct ccu_mux_nb *mux_nb)
 
 	return clk_notifier_register(clk, &mux_nb->clk_nb);
 }
+EXPORT_SYMBOL_GPL(ccu_mux_notifier_register);
diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
index aee68b00f3b2..b8fa0bf422fb 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.c
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -157,3 +157,4 @@ const struct clk_ops ccu_nk_ops = {
 	.round_rate	= ccu_nk_round_rate,
 	.set_rate	= ccu_nk_set_rate,
 };
+EXPORT_SYMBOL_GPL(ccu_nk_ops);
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index b9cfee0276ea..583d3ba5e624 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -206,3 +206,4 @@ const struct clk_ops ccu_nkm_ops = {
 	.recalc_rate	= ccu_nkm_recalc_rate,
 	.set_rate	= ccu_nkm_set_rate,
 };
+EXPORT_SYMBOL_GPL(ccu_nkm_ops);
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index bda87b38c45c..ec5224ba5b99 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -230,3 +230,4 @@ const struct clk_ops ccu_nkmp_ops = {
 	.round_rate	= ccu_nkmp_round_rate,
 	.set_rate	= ccu_nkmp_set_rate,
 };
+EXPORT_SYMBOL_GPL(ccu_nkmp_ops);
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index e6bcc0a7170c..576e464bdf03 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -238,3 +238,4 @@ const struct clk_ops ccu_nm_ops = {
 	.round_rate	= ccu_nm_round_rate,
 	.set_rate	= ccu_nm_set_rate,
 };
+EXPORT_SYMBOL_GPL(ccu_nm_ops);
diff --git a/drivers/clk/sunxi-ng/ccu_phase.c b/drivers/clk/sunxi-ng/ccu_phase.c
index 92ab8bd66427..ededb36d531c 100644
--- a/drivers/clk/sunxi-ng/ccu_phase.c
+++ b/drivers/clk/sunxi-ng/ccu_phase.c
@@ -121,3 +121,4 @@ const struct clk_ops ccu_phase_ops = {
 	.get_phase	= ccu_phase_get_phase,
 	.set_phase	= ccu_phase_set_phase,
 };
+EXPORT_SYMBOL_GPL(ccu_phase_ops);
diff --git a/drivers/clk/sunxi-ng/ccu_reset.c b/drivers/clk/sunxi-ng/ccu_reset.c
index 483100e45df3..8413de004574 100644
--- a/drivers/clk/sunxi-ng/ccu_reset.c
+++ b/drivers/clk/sunxi-ng/ccu_reset.c
@@ -75,3 +75,4 @@ const struct reset_control_ops ccu_reset_ops = {
 	.reset		= ccu_reset_reset,
 	.status		= ccu_reset_status,
 };
+EXPORT_SYMBOL_GPL(ccu_reset_ops);
-- 
2.31.1

