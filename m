Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4F3FD31D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbhIAFlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:41:15 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39031 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242080AbhIAFk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:40:56 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id DCF18580595;
        Wed,  1 Sep 2021 01:39:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Sep 2021 01:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=tkzBfxZlRNpTX
        Jf5+WB8ToGkN4WKFasuV+pjQzUK5zc=; b=lWKLfVv7IzNcDt25ljPma6Ip/fBjD
        iFIOJFb7QU3qSs1Nj62zSjeSGxBL9VMzv4jQkPYKe0rwDBwrt1VM2kfYUC6GOdxm
        KCG3SPFq+NuGW0fTWcee1dCF9k34wUo5kTSS7UprFXSnkq/f5Xoo3z6pq2+Eqknz
        HT+P85tpUyVswc7F0x9nIdYhKg7JEfgGTwdwEY6OHbx0XJjYjE53SMwljCCsXZ3a
        ssjZk5GWgzodtLae1Fc0jUvW3o/XBb4pwufTvfJOmLkXXrQ0PDcz/NXQdZcPtyV3
        GAYxGCO8GMEIx2EXzwFZM2gVrAb8s8GxJdKLpOSXzI0qf7G/S1immTlpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=tkzBfxZlRNpTXJf5+WB8ToGkN4WKFasuV+pjQzUK5zc=; b=ARKJVsY8
        13bzyXhKxnhtyruw34WX9m6FKk3KS1t0exFioejy2r3gMENhOXXGvyX31l2igPou
        EhaLzu3q8RJLNGVSN1q7UO7MuX/2EMipw7uL8Q+e/gZlKzUbBdKe5glLSUOeF4+Z
        yAVK5J/G9dQuGzsp/BRoebVgbqYT11POC7lIjQk5qQcR+O4IbYEbDaPZshcSTnYg
        C94i6y5nRjZOoTW8yXAabAr+dinSRozG2DVQFcdZmtncUpSXc5bqhJD2RemjjaEn
        ooRW2fWJwKIA00GJjaT5+V6MiVDWh++JZsX2Suqu6Lg+WSZd8+q14qOcDtvjb0k1
        p+n+6A3PMISFPA==
X-ME-Sender: <xms:LxIvYWwskIxnjb-qMNzlLXzsgvZ0Ydovk3wCF69oxuRXHtZP5dDH_A>
    <xme:LxIvYSQO0kSTg5oIO_xa8MEcx_fz_oLUidTABRwW3uMFKNkaxX_YylO61EdU_tYZM
    xIwpBoHZU11Ai7a_w>
X-ME-Received: <xmr:LxIvYYW1tD7Fv-ZgRtHuuCG0bH-whr_GO6t1foqXHcOVCELQYca6or1oq3iiDQji1T4XzNrqCA4iFO-yCyhMY1vxvQ-YcTjr0NScyqx9DgtvQwp9ccG3XL_6knWLNMvFnZSxCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:LxIvYcgzhv8nO05WBFnLmFkVJk-WSQbfPNYeuWCIzhbeWfmist-KGw>
    <xmx:LxIvYYCATcfVi_DYxRQ0T9N0WYk7YY-cjySowwwqJ5F-osQewBtQ7w>
    <xmx:LxIvYdJSWXQktJsHfW6fe18fiSxVyYyaqq20VgO0j0WA4qRIUYzUEg>
    <xmx:LxIvYc4yFQBeh2Te_nOVfzHYU1Rh3p0-1P6N4FcPfUYetZ1mYz_uzA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:39:59 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 6/7] [DO NOT MERGE] clk: sunxi-ng: Add support for H6
Date:   Wed,  1 Sep 2021 00:39:50 -0500
Message-Id: <20210901053951.60952-7-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901053951.60952-1-samuel@sholland.org>
References: <20210901053951.60952-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 has IOSC calibration and an ext-osc32k input.

H6 has the osc32k mux and the rtc-32k mux, but no fanout mux.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/sun50i-rtc-ccu.c | 49 +++++++++++++++++++++++++++
 drivers/rtc/rtc-sun6i.c               | 17 ----------
 2 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
index 1dfa05c2f0e9..9603dc0d3d7b 100644
--- a/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
+++ b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
@@ -227,6 +227,16 @@ static SUNXI_CCU_MUX_DATA_WITH_GATE(osc32k_fanout_clk, "rtc-32k-fanout",
 static SUNXI_CCU_M_FW_WITH_GATE(rtc_spi_clk, "rtc-spi", "ahb",
 				0x310, 0, 5, BIT(31), 0);
 
+static struct ccu_common *sun50i_h6_rtc_ccu_clks[] = {
+	&iosc_clk,
+	&iosc_32k_clk,
+	&ext_osc32k_gate_clk.common,
+	&osc32k_clk.common,
+	&osc24M_32k_clk.common,
+	&rtc_32k_mux_clk.common,
+	&osc32k_fanout_clk.common,
+};
+
 static struct ccu_common *sun50i_h616_rtc_ccu_clks[] = {
 	&iosc_clk,
 	&iosc_32k_clk,
@@ -246,6 +256,21 @@ static struct ccu_common *sun50i_r329_rtc_ccu_clks[] = {
 	&rtc_spi_clk.common,
 };
 
+static struct clk_hw_onecell_data sun50i_h6_rtc_ccu_hw_clks = {
+	.num = CLK_NUMBER,
+	.hws = {
+		[CLK_OSC32K]		= &osc32k_clk.common.hw,
+		[CLK_OSC32K_FANOUT]	= &osc32k_fanout_clk.common.hw,
+		[CLK_IOSC]		= &iosc_clk.hw,
+
+		[CLK_IOSC_32K]		= &iosc_32k_clk.hw,
+		[CLK_EXT_OSC32K_GATE]	= &ext_osc32k_gate_clk.common.hw,
+		[CLK_OSC24M_32K]	= &osc24M_32k_clk.common.hw,
+		[CLK_RTC_32K]		= &rtc_32k_mux_clk.common.hw,
+		[CLK_RTC_SPI]		= NULL,
+	},
+};
+
 static struct clk_hw_onecell_data sun50i_h616_rtc_ccu_hw_clks = {
 	.num = CLK_NUMBER,
 	.hws = {
@@ -276,6 +301,13 @@ static struct clk_hw_onecell_data sun50i_r329_rtc_ccu_hw_clks = {
 	},
 };
 
+static const struct sunxi_ccu_desc sun50i_h6_rtc_ccu_desc = {
+	.ccu_clks	= sun50i_h6_rtc_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun50i_h6_rtc_ccu_clks),
+
+	.hw_clks	= &sun50i_h6_rtc_ccu_hw_clks,
+};
+
 static const struct sunxi_ccu_desc sun50i_h616_rtc_ccu_desc = {
 	.ccu_clks	= sun50i_h616_rtc_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun50i_h616_rtc_ccu_clks),
@@ -318,6 +350,23 @@ static void __init sunxi_rtc_ccu_init(struct device_node *node,
 	of_sunxi_ccu_probe(node, reg, desc);
 }
 
+static void __init sun50i_h6_rtc_ccu_setup(struct device_node *node)
+{
+	struct clk_init_data *init;
+
+	have_iosc_calib = 1;
+
+	/* Casting away the const from a pointer to a non-const anonymous object... */
+	init = (struct clk_init_data *)osc32k_fanout_clk.common.hw.init;
+
+	/* Fanout only has one parent: osc32k. */
+	init->num_parents = 1;
+
+	sunxi_rtc_ccu_init(node, &sun50i_h6_rtc_ccu_desc);
+}
+CLK_OF_DECLARE_DRIVER(sun50i_h6_rtc_ccu, "allwinner,sun50i-h6-rtc",
+		      sun50i_h6_rtc_ccu_setup);
+
 static void __init sun50i_h616_rtc_ccu_setup(struct device_node *node)
 {
 	have_iosc_calib = 1;
diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index adec1b14a8de..f7cbbf57f112 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -363,23 +363,6 @@ CLK_OF_DECLARE_DRIVER(sun8i_h3_rtc_clk, "allwinner,sun8i-h3-rtc",
 CLK_OF_DECLARE_DRIVER(sun50i_h5_rtc_clk, "allwinner,sun50i-h5-rtc",
 		      sun8i_h3_rtc_clk_init);
 
-static const struct sun6i_rtc_clk_data sun50i_h6_rtc_data = {
-	.rc_osc_rate = 16000000,
-	.fixed_prescaler = 32,
-	.has_prescaler = 1,
-	.has_out_clk = 1,
-	.export_iosc = 1,
-	.has_losc_en = 1,
-	.has_auto_swt = 1,
-};
-
-static void __init sun50i_h6_rtc_clk_init(struct device_node *node)
-{
-	sun6i_rtc_clk_init(node, &sun50i_h6_rtc_data);
-}
-CLK_OF_DECLARE_DRIVER(sun50i_h6_rtc_clk, "allwinner,sun50i-h6-rtc",
-		      sun50i_h6_rtc_clk_init);
-
 /*
  * The R40 user manual is self-conflicting on whether the prescaler is
  * fixed or configurable. The clock diagram shows it as fixed, but there
-- 
2.31.1

