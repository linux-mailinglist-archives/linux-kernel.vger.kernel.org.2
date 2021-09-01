Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB93FD31C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbhIAFlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:41:11 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:50255 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242046AbhIAFk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:40:57 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 911A45805C3;
        Wed,  1 Sep 2021 01:40:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Sep 2021 01:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=AW1628GhGotzk
        KH/YttaXfCJmdGOn33kQwWfNnzFq50=; b=nGipR7Dph/pipc/kQf2JrU8+ilLQT
        jXi/e+flhRlG2lEpHK7GwU538Th5XnZx01WburK5hTt0Au7ILf89VX1SvcRstO8O
        WpN7sQYS069HxziKPLicRBgcIYrPeqUzHoKRggNyXivIBCAEkCr9N+9R6PFVHSgl
        wmaT2vP8Nz8IieSGAdqMWPcXYVsJeQX7P1JAYucjFv1LaxHAulJsAFDJ+fbLakK3
        lVq/T2JoVjlUEX7M54oTz544cJ5pgP0fsfdLG8T/dvHeVDOvgJ9UA2/yWZEnZNhb
        7zxAV2aUFggisKUZjoB26S0L2ChHjZnR+NIoCK6TC+dKdahl8r0c5H2Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=AW1628GhGotzkKH/YttaXfCJmdGOn33kQwWfNnzFq50=; b=VRQ0urmm
        Ez12LOISmZhfRTOwNMl3S95eNhoAUi10A3IGnE4hF8GP8ZIJ+8akBWZPMcKq5Cl2
        lKuSJWAVeWtbMKzbYdqe9MjxtQ4XK24mUi8NvhdRmLj3xvarLeumvtUfVLFxi+Ba
        KrG/k5uDQgIpGabKJGSJnqj+cMmZsn0CFcJpY1OjAr9/Cu0Cah37ZniAgHKOw2/6
        fPl4ltmZoJh0H3NBsWrVZ4058sBozGoaqEQOd12qGY/aU+7ux6ZDXrqSN+C0OIWP
        TeSWuSQFwQ9vyKN38zYPjVdgVl+Ax5e4gZxd8E9533qWYvtvf+ImAJ6ek58iEsOK
        PFVdOPesQBr/VQ==
X-ME-Sender: <xms:MBIvYfeY_KpVwSo0GJTRuRG7uO2IdpxvhfHxuIMQkEj0nb2UwQfyIg>
    <xme:MBIvYVMnpTwe23Zb4Dz_vDyJGEWafBmfAViu6zBCxaLd_V5i3ZYN5juJ6kll4i4os
    ASF_2IIcNxS9B8HMg>
X-ME-Received: <xmr:MBIvYYioimVaeTvBPB6by95Q8B3Xsf09qyD3uPJT2L58HEvRA4n2S8rFx-H5lA6gVizMOx_lt48eGoVbejRCZQcresy01Vwhy3zJ9_kLi3etI4kU1GGa0x0C3L9_I3COGYTvAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:MBIvYQ9et2HOPfDmswW5ho2UwgUvvhBGg7xmbYu3BuZEwwlEj2zHkg>
    <xmx:MBIvYbtKrE0hV9_oH18NHF3cTLK2FkZeigTsMKHeP2drVDizhab-9w>
    <xmx:MBIvYfFvymz3m5oEtmj4W-6p9NOpF-EtPQDal22XoSTndNu1ygQ_rQ>
    <xmx:MBIvYckBd55RuOb99EWy3OlfhrN-yCPgekMo37us46uc3QfycuYHjg>
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
Subject: [RFC PATCH 7/7] [DO NOT MERGE] clk: sunxi-ng: Add support for T5
Date:   Wed,  1 Sep 2021 00:39:51 -0500
Message-Id: <20210901053951.60952-8-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901053951.60952-1-samuel@sholland.org>
References: <20210901053951.60952-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T5 RTC is similar to the H616 RTC (no rtc-32k mux, pll-32k as the
second fanout input), except that it adds the ext-osc32k input.

It also isn't a "sun50i" SoC, so it creates a bit of a naming problem...

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/sun50i-rtc-ccu.c | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
index 9603dc0d3d7b..fe6b21a24193 100644
--- a/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
+++ b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
@@ -227,6 +227,15 @@ static SUNXI_CCU_MUX_DATA_WITH_GATE(osc32k_fanout_clk, "rtc-32k-fanout",
 static SUNXI_CCU_M_FW_WITH_GATE(rtc_spi_clk, "rtc-spi", "ahb",
 				0x310, 0, 5, BIT(31), 0);
 
+static struct ccu_common *sun8i_t5_rtc_ccu_clks[] = {
+	&iosc_clk,
+	&iosc_32k_clk,
+	&ext_osc32k_gate_clk.common,
+	&osc32k_clk.common,
+	&osc24M_32k_clk.common,
+	&osc32k_fanout_clk.common,
+};
+
 static struct ccu_common *sun50i_h6_rtc_ccu_clks[] = {
 	&iosc_clk,
 	&iosc_32k_clk,
@@ -256,6 +265,21 @@ static struct ccu_common *sun50i_r329_rtc_ccu_clks[] = {
 	&rtc_spi_clk.common,
 };
 
+static struct clk_hw_onecell_data sun8i_t5_rtc_ccu_hw_clks = {
+	.num = CLK_NUMBER,
+	.hws = {
+		[CLK_OSC32K]		= &osc32k_clk.common.hw,
+		[CLK_OSC32K_FANOUT]	= &osc32k_fanout_clk.common.hw,
+		[CLK_IOSC]		= &iosc_clk.hw,
+
+		[CLK_IOSC_32K]		= &iosc_32k_clk.hw,
+		[CLK_EXT_OSC32K_GATE]	= &ext_osc32k_gate_clk.common.hw,
+		[CLK_OSC24M_32K]	= &osc24M_32k_clk.common.hw,
+		[CLK_RTC_32K]		= &rtc_32k_fixed_clk.hw,
+		[CLK_RTC_SPI]		= NULL,
+	},
+};
+
 static struct clk_hw_onecell_data sun50i_h6_rtc_ccu_hw_clks = {
 	.num = CLK_NUMBER,
 	.hws = {
@@ -301,6 +325,13 @@ static struct clk_hw_onecell_data sun50i_r329_rtc_ccu_hw_clks = {
 	},
 };
 
+static const struct sunxi_ccu_desc sun8i_t5_rtc_ccu_desc = {
+	.ccu_clks	= sun8i_t5_rtc_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_t5_rtc_ccu_clks),
+
+	.hw_clks	= &sun8i_t5_rtc_ccu_hw_clks,
+};
+
 static const struct sunxi_ccu_desc sun50i_h6_rtc_ccu_desc = {
 	.ccu_clks	= sun50i_h6_rtc_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun50i_h6_rtc_ccu_clks),
@@ -350,6 +381,15 @@ static void __init sunxi_rtc_ccu_init(struct device_node *node,
 	of_sunxi_ccu_probe(node, reg, desc);
 }
 
+static void __init sun8i_t5_rtc_ccu_setup(struct device_node *node)
+{
+	have_iosc_calib = 1;
+
+	sunxi_rtc_ccu_init(node, &sun8i_t5_rtc_ccu_desc);
+}
+CLK_OF_DECLARE_DRIVER(sun8i_t5_rtc_ccu, "allwinner,sun8i-t5-rtc",
+		      sun8i_t5_rtc_ccu_setup);
+
 static void __init sun50i_h6_rtc_ccu_setup(struct device_node *node)
 {
 	struct clk_init_data *init;
-- 
2.31.1

