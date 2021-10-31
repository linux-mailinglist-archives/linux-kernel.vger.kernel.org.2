Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED768440EB8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 14:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhJaNwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhJaNww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 09:52:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC0C061570;
        Sun, 31 Oct 2021 06:50:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u18so24330624wrg.5;
        Sun, 31 Oct 2021 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hivsyzWfKb3IO8otmU12m10waXWHE3SQBgrLl9NXhYc=;
        b=ntusG/q2A7X9rwYeDzz2+YEIQ1Jd8RONbiYaut+GxmTprG5IPiDXBJHlq7yBcJFPqS
         zI8lUtfwcOiX+TGXNTcHUEiKIsqjZ7tTClBFwntuarXEHkXsY39x+0stx8X/gFLcnkKU
         xrmCIeFbQ6LBFnIFvTU3WJKK4TLqi/t2sMLfXl4FEao3zmhBxTSGwv2j0pI8aEdsOKx/
         5ZakTDQWpknICQRZIc9YRnU8R0kE/X/hVkCSTmy8KP7jdbU/0fV2uoWCvtnrvZo9MUJv
         hsKIoArXFU9LHJ8uFcDr82EiECFdiuZ0kPw3GQi/ewAY2QsGiX8YnnJH/CQuKeeluoKK
         LRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hivsyzWfKb3IO8otmU12m10waXWHE3SQBgrLl9NXhYc=;
        b=OBdbLgl49cs5I4VUjYfwCxxJY3e+iYjyEbdedcltKdmkmhSm42hVN8GCDgw1DwWbGk
         sJEqaR9FeyAzgdm/jHePkAZksM4a4+QLJeEYYBd0Hcr7EwZdjV45N8QI4uScQdP77yni
         3d4YnR2gDlWHumqP057rhcCr6eIjBtz3uIcMN+S0otuQpRxtoRihYDKUQerKRN5v+Rmm
         WDT/Rmp8XfE5exlLNUv3ttbAPKkdwgAItMzLbvyilF+V9FTFXAyymhYLdvm3JIylJOm5
         kMyNtGcvpEUDJTR9R2+ZNG4wUWouj8YGjUnc16aBmvpjnpAjqtWvWZ6rlVoLROucREVg
         50WQ==
X-Gm-Message-State: AOAM531MkomqeP9oLVntCqqy5iqLRKY/JjyILscJxZxVT4kSbgkJvXyC
        8rm9zalFZNq4l/CiVNG0SuA=
X-Google-Smtp-Source: ABdhPJyZNW6hRFZ0KIw1IUOGC0/lHJKyMf2hCpcJ3nFRX7gzQk8HLC04NHaaqq3lEk7R62WlBBRb9A==
X-Received: by 2002:a5d:43c5:: with SMTP id v5mr31149783wrr.11.1635688219167;
        Sun, 31 Oct 2021 06:50:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-73cd-c100-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:73cd:c100:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id o26sm13589719wmc.17.2021.10.31.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 06:50:18 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3] clk: meson: gxbb: Fix the SDM_EN bit for MPLL0 on GXBB
Date:   Sun, 31 Oct 2021 14:50:06 +0100
Message-Id: <20211031135006.1508796-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are reports that 48kHz audio does not work on the WeTek Play 2
(which uses a GXBB SoC), while 44.1kHz audio works fine on the same
board. There are also reports of 48kHz audio working fine on GXL and
GXM SoCs, which are using an (almost) identical AIU (audio controller).

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

The rate seen by meson-clk-msr is very close to what we would get when
SDM (the fractional part) was ignored:
  (2000000000Hz * 16384) / ((16384 * 6) = 333.33MHz
If SDM was considered the we should get close to:
  (2000000000Hz * 16384) / ((16384 * 6) + 12808) = 294.9MHz

Further experimenting shows that HHI_MPLL_CNTL7[15] does not have any
effect on the rate of MPLL0 as seen my meson-clk-msr (regardless of
whether that bit is zero or one the rate is always the same according to
meson-clk-msr). Using HHI_MPLL_CNTL[25] on the other hand as SDM_EN
results in SDM being considered for the rate output by the hardware. The
rate - as seen by meson-clk-msr - matches with what we expect when
SDM_EN is enabled (fractional part is being considered, resulting in a
294.9MHz output) or disable (fractional part being ignored, resulting in
a 333.33MHz output).

Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
changes since v2 at [1]:
- add Christian's Tested-by (thank you!)
- s/his/the/ to fix the grammar in the first sentence as spotted by
  Christian (off-list)

changes since v1 at [0]:
- consider HHI_MPLL_CNTL[25] as SDM_EN bit after Jerome helped me
  understand the purpose of SDM_EN and gave some explanation why this
  can't be a spread spectrum bit


[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20211016145939.15643-1-martin.blumenstingl@googlemail.com/
[1] https://patchwork.kernel.org/project/linux-amlogic/patch/20211027185326.1653827-1-martin.blumenstingl@googlemail.com/


 drivers/clk/meson/gxbb.c | 44 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index d6eed760327d..608e0e8ca49a 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -713,6 +713,35 @@ static struct clk_regmap gxbb_mpll_prediv = {
 };
 
 static struct clk_regmap gxbb_mpll0_div = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 25,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 16,
+			.width   = 9,
+		},
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
@@ -749,7 +778,16 @@ static struct clk_regmap gxbb_mpll0 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
 		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) { &gxbb_mpll0_div.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			/*
+			 * Note:
+			 * GXL and GXBB have different SDM_EN registers. We
+			 * fallback to the global naming string mechanism so
+			 * mpll0_div picks up the appropriate one.
+			 */
+			.name = "mpll0_div",
+			.index = -1,
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -3044,7 +3082,7 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_VAPB_1]		    = &gxbb_vapb_1.hw,
 		[CLKID_VAPB_SEL]	    = &gxbb_vapb_sel.hw,
 		[CLKID_VAPB]		    = &gxbb_vapb.hw,
-		[CLKID_MPLL0_DIV]	    = &gxbb_mpll0_div.hw,
+		[CLKID_MPLL0_DIV]	    = &gxl_mpll0_div.hw,
 		[CLKID_MPLL1_DIV]	    = &gxbb_mpll1_div.hw,
 		[CLKID_MPLL2_DIV]	    = &gxbb_mpll2_div.hw,
 		[CLKID_MPLL_PREDIV]	    = &gxbb_mpll_prediv.hw,
@@ -3439,7 +3477,7 @@ static struct clk_regmap *const gxl_clk_regmaps[] = {
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

