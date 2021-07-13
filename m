Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5603C7A22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhGMX2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbhGMX2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:28:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D53C0613F0;
        Tue, 13 Jul 2021 16:25:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so241514wmc.2;
        Tue, 13 Jul 2021 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wn4OGffmG6CAMF74sT7Jiq6EaKRXD5BwqoAMkg2t0q8=;
        b=hGeIswUtxXdk4lABeE/3QfZKpbiuJl6XItJJjxK5X7pUg19zVM7REeo5atNckOTe/x
         Rj+r3IZj65gtheQX/flGPczAyhnQ5x1jF8XCFHnRWM1hJ4AF/CwDpzfIUHy1N4no0BOs
         k2RuP02FkJdqwoP+NXafsZHMohytpFOgKL7F7sIZUhBmHjJ5rq4niSfbM+ockDolWD+H
         fhOZp+qE50GVZin6JLz8RT0okllh1IyI9w1m6v5dt4tKsxcr7s2uKmrSwiXmPezAhS6i
         Cv+bLMyPHzUd4zUSe62chmDjo35/OFeKfzEV3r8AwkQ+NwYVtyRQKWvzK9IZtP8uyDze
         ze+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wn4OGffmG6CAMF74sT7Jiq6EaKRXD5BwqoAMkg2t0q8=;
        b=UtKhk6jIkiSsXe75J9CQSMzXZOSkSTVt7HmjqJWEgPvjVbKc9HEdKsZAkzKhY+Lusq
         Hx9VRXJzwG2698EkX1TMYEWxZJrbDCnQbMsiLTmnExjyGJiubBev8VvD2BK5U9w3JKJn
         YTDis1kVZPatbkhuJYtPhm/dr/kv6KahkHYAcR59cy1g6+K1HJ6nXcyH3PHoCNm10yAl
         P6JVc69jUX1/mRggzOpEtetSy+fVuj/9i6c5jt5VlMGt/m3yLfRNd+5phkwN7vjkU6Mu
         9gGZY1HynGCmEw16g3XKDET+wqr/Yggm0C7mqD0b0r52762tggj8rNPOPcShRbj48Q7G
         PJqw==
X-Gm-Message-State: AOAM530KeBkCQlpnAKDCPJ7MuIJnaJ/IAzsJMoFIzkpYTlgk5ntPbK7w
        sGtsBUnjJ2I/SGhtNOZpuqM=
X-Google-Smtp-Source: ABdhPJx7MHybO2+5HQU6G9cFXw5IqIWhFj0v7z3R1gin1s+N0glBMLNzht0s4MXDqWfcwQSqZj1VKw==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr620521wml.177.1626218718929;
        Tue, 13 Jul 2021 16:25:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c041-6f00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c041:6f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id o11sm3857390wmc.2.2021.07.13.16.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:25:18 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/6] clk: meson: meson8b: Add the vid_pll_lvds_en gate clock
Date:   Wed, 14 Jul 2021 01:25:06 +0200
Message-Id: <20210713232510.3057750-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
References: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HHI_VID_DIVIDER_CNTL[11] must be enabled for the video clock tree to
work. This bit is described as "LVDS_CLK_EN". It is not 100% clear where
this bit has to be placed in the hierarchy. But since the "LVDS_OUT" of
the HDMI PLL uses it's own set of registers it's more likely that this
"LVDS_CLK_EN" bit actually enables the input of the "hdmi_pll_lvds_out"
clock to the "vid_pll_in_sel" tree.

Add a gate definition for this bit (which will not be exported) so that
the kernel can manage all required bits to enable and disable the video
clocks.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 23 ++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h |  3 ++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 0f8bd707217a..9ccffbfe44e5 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1045,6 +1045,23 @@ static struct clk_regmap meson8b_l2_dram_clk_gate = {
 	},
 };
 
+/* also called LVDS_CLK_EN */
+static struct clk_regmap meson8b_vid_pll_lvds_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_DIVIDER_CNTL,
+		.bit_idx = 11,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll_lvds_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&meson8b_hdmi_pll_lvds_out.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static struct clk_regmap meson8b_vid_pll_in_sel = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_VID_DIVIDER_CNTL,
@@ -1061,7 +1078,7 @@ static struct clk_regmap meson8b_vid_pll_in_sel = {
 		 * Meson8m2: vid2_pll
 		 */
 		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_hdmi_pll_lvds_out.hw
+			&meson8b_vid_pll_lvds_en.hw
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -2905,6 +2922,7 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
 		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
 		[CLKID_CTS_I958]	    = &meson8b_cts_i958.hw,
+		[CLKID_VID_PLL_LVDS_EN]	    = &meson8b_vid_pll_lvds_en.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -3122,6 +3140,7 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
 		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
 		[CLKID_CTS_I958]	    = &meson8b_cts_i958.hw,
+		[CLKID_VID_PLL_LVDS_EN]	    = &meson8b_vid_pll_lvds_en.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -3341,6 +3360,7 @@ static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
 		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
 		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
 		[CLKID_CTS_I958]	    = &meson8b_cts_i958.hw,
+		[CLKID_VID_PLL_LVDS_EN]	    = &meson8b_vid_pll_lvds_en.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -3539,6 +3559,7 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_cts_mclk_i958_div,
 	&meson8b_cts_mclk_i958,
 	&meson8b_cts_i958,
+	&meson8b_vid_pll_lvds_en,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index b1a5074cf148..954d97cf6c5a 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -182,8 +182,9 @@
 #define CLKID_CTS_MCLK_I958_DIV	211
 #define CLKID_VCLK_EN		214
 #define CLKID_VCLK2_EN		215
+#define CLKID_VID_PLL_LVDS_EN	216
 
-#define CLK_NR_CLKS		216
+#define CLK_NR_CLKS		217
 
 /*
  * include the CLKID and RESETID that have
-- 
2.32.0

