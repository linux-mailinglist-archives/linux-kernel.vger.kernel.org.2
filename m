Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4CC430326
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbhJPPCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhJPPCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:02:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85EC061570;
        Sat, 16 Oct 2021 08:00:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y3so31885051wrl.1;
        Sat, 16 Oct 2021 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqnMuFpgSADQq8LPQeZiTx5HVHbVDQMXAFWHZfFF9ZU=;
        b=fk6S2/0U84Ed4T3ZK/U92G/9b6uIOmZ9WS6lCYyMAtTq4M0vSHh9GNLEAUbEW7U+ut
         dmoc70mZ9dAiuHQxKj+Ohy+JyJrvjaCoG5U81nEO0KU4nlovcjYIx84N6gjx3qWS+RK5
         cfkulnmvbTqh8Por5CFHoNGRwib+wNlFZAED4KW4hLJUPd6b/Tbd9jmYXbiIdK4viFXp
         /bOd2d91jI2KKnJT4G3YAmYlMqw/UCooyVr2id8UR+H9fqbCGLm6a8ATt3jt/hu62yDi
         9g0gT8LfkchWkMVlLKUWQ2CzzRM+TmiimAxB2ufhzGgTitD/VpINbAwCCz3MD8N69L/O
         ru8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqnMuFpgSADQq8LPQeZiTx5HVHbVDQMXAFWHZfFF9ZU=;
        b=BV2NJY0gUPdUxmH1mBr5b+CnEh+8Xix3kTyvOFIjcaFVcRn1IXHaYCcN09aRRjHywP
         xeYiAyhpA3nungPPzMKh2QYUaPSfP0TnuGauHBsANK04NlG6X7H1uK+6yC5zUIVi2mem
         K6BPO0TFXciBGzVCgmSEOpFK9iFRUWSANxo2WFohKLxZwwsUxHFxxe1INzDNhRmLCvEd
         H/NVBz0npPMpNZ9zUP9iK/YfOvhxpMRTlWu/oSqqYOovL9V5J3GH3heZvXj3SbLvGib2
         FoeUHrdx5qNB6QVVKUSDMnJllfjqj3wHhXLAOVukiAtK9pVp359otYzhACdXax/LPJB+
         xEGQ==
X-Gm-Message-State: AOAM5328o97n5P8S+E92AD3CKvsGR2Q5g4zb+7IY/tZeGC9X47dPaB8s
        v2rrMthpUGBYHUIZasHWqt2EZxzzxAY=
X-Google-Smtp-Source: ABdhPJy2g66J/9AMlkBlIifsI4nVNpR0kyb4gKOZhUVlH9yhJd/6Dd7f2cmtbUvbfO3Hu7LYaOmcQw==
X-Received: by 2002:a5d:6982:: with SMTP id g2mr22269558wru.51.1634396406342;
        Sat, 16 Oct 2021 08:00:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b82-9800-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7b82:9800:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id k17sm13543280wmj.0.2021.10.16.08.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 08:00:05 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     narmstrong@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] clk: meson: gxbb: Add the spread spectrum bit for MPLL0 on GXBB
Date:   Sat, 16 Oct 2021 16:59:39 +0200
Message-Id: <20211016145939.15643-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian reports that 48kHz audio does not work on his WeTek Play 2
(which uses a GXBB SoC), while 44.1kHz audio works fine on the same
board. He also reports that 48kHz audio works on GXL and GXM SoCs,
which are using an (almost) identical AIU (audio controller).

Experimenting has shown that MPLL0 is causing this problem. In the .dts
we have by default:
	assigned-clocks = <&clkc CLKID_MPLL0>,
			  <&clkc CLKID_MPLL1>,
			  <&clkc CLKID_MPLL2>;
	assigned-clock-rates = <294912000>,
			       <270950400>,
			       <393216000>;
The MPLL0 rate is divisible by 48kHz without remainder and the MPLL1
rate is divisible by 44.1kHz without remainder. Swapping these two clock
rates "fixes" 48kHz audio but breaks 44.1kHz audio.

Everything looks normal when looking at the info provided by the common
clock framework while playing 48kHz audio (via I2S with mclk-fs = 256):
        mpll_prediv                 1        1        0  2000000000
           mpll0_div                1        1        0   294909641
              mpll0                 1        1        0   294909641
                 cts_amclk_sel       1        1        0   294909641
                    cts_amclk_div       1        1        0    12287902
                       cts_amclk       1        1        0    12287902

meson-clk-msr however shows that the actual MPLL0 clock is off by more
than 38MHz:
        mp0_out               333322917    +/-10416Hz

The 3.14 vendor kernel uses the following code to enable SSEN only for
MPLL0 (where con_reg2 is HHI_MPLL_CNTL and SSEN_shift is 25):
	if (strncmp(hw->clk->name, "mpll_clk_out0", 13) == 0) {
		val = readl(mpll->con_reg2);
		val |= 1 <<  mpll->SSEN_shift;
		writel(val, mpll->con_reg2);
	}

Add the SSEN (spread spectrum enable) bit and add the
CLK_MESON_MPLL_SPREAD_SPECTRUM flag to enable this bit for MPLL0. Do
this for GXBB *only* since GXL doesn't seem to care if this bit is set
or not, meaning that meson-clk-msr always sees (approximately) the same
frequency as common clock framework.

Fixes: 8925dbd03bb29b ("clk: meson: gxbb: no spread spectrum on mpll")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/gxbb.c | 50 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index d6eed760327d..673bc915c7d9 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -713,6 +713,41 @@ static struct clk_regmap gxbb_mpll_prediv = {
 };
 
 static struct clk_regmap gxbb_mpll0_div = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 15,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 16,
+			.width   = 9,
+		},
+		.ssen = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 25,
+			.width   = 1,
+		},
+		.flags = CLK_MESON_MPLL_SPREAD_SPECTRUM,
+		.lock = &meson_clk_lock,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll0_div",
+		.ops = &meson_clk_mpll_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&gxbb_mpll_prediv.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap gxl_mpll0_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL_CNTL7,
@@ -749,7 +784,16 @@ static struct clk_regmap gxbb_mpll0 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
 		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) { &gxbb_mpll0_div.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			/*
+			 * Note:
+			 * GXL and GXBB have different SSEN requirements. We
+			 * fallback to the global naming string mechanism so
+			 * mpll0_div picks up the appropriate one.
+			 */
+			.name = "mpll0_div",
+			.index = -1,
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -3044,7 +3088,7 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_VAPB_1]		    = &gxbb_vapb_1.hw,
 		[CLKID_VAPB_SEL]	    = &gxbb_vapb_sel.hw,
 		[CLKID_VAPB]		    = &gxbb_vapb.hw,
-		[CLKID_MPLL0_DIV]	    = &gxbb_mpll0_div.hw,
+		[CLKID_MPLL0_DIV]	    = &gxl_mpll0_div.hw,
 		[CLKID_MPLL1_DIV]	    = &gxbb_mpll1_div.hw,
 		[CLKID_MPLL2_DIV]	    = &gxbb_mpll2_div.hw,
 		[CLKID_MPLL_PREDIV]	    = &gxbb_mpll_prediv.hw,
@@ -3439,7 +3483,7 @@ static struct clk_regmap *const gxl_clk_regmaps[] = {
 	&gxbb_mpll0,
 	&gxbb_mpll1,
 	&gxbb_mpll2,
-	&gxbb_mpll0_div,
+	&gxl_mpll0_div,
 	&gxbb_mpll1_div,
 	&gxbb_mpll2_div,
 	&gxbb_cts_amclk_div,
-- 
2.33.1

