Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9213CC96A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 15:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhGROAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 10:00:08 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:60550 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229842AbhGROAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 10:00:07 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([79.45.45.231])
        by smtp-34.iol.local with ESMTPA
        id 57Hym0FThLCum57I2mIAvx; Sun, 18 Jul 2021 15:57:07 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1626616627; bh=rOfM+3SnDUoi4Zw7AQaIgYut2m3EXateesuCvJ04ulU=;
        h=From;
        b=JrnyqGMhY4RO+0YzAjovFlnHMyqriWq3eUn8pOak0yBMk9GgJCqTwUjA/6OLd+NHK
         U0bQHXqK+msbDgUjlcsCHFm812Xicq42VfkwifuyfNC4eI6QW3PCqNT2in4mlbBudB
         Kz014GqJjZfayD2j0LPbL4cGh4OuxgyUQMWDSvyTtq3JKjozwYblduys3UNYXA3kwc
         S6yWJ8yBIxTbT6IDl4ez00l0hgAY+hKYBxx4gMyGiGapcr5iy3Vo+FAI6TaNZztJQt
         8ZDd205s12ngVELTnq0iTn84a/U14wF9VZEuSIlJcEu7hpEsveKHDcRatMgvFC6TQ6
         U1ZJVrBJrSrYw==
X-CNFS-Analysis: v=2.4 cv=a8D1SWeF c=1 sm=1 tr=0 ts=60f43333 cx=a_exe
 a=TX8r+oJM0yLPAmPh5WrBoQ==:117 a=TX8r+oJM0yLPAmPh5WrBoQ==:17 a=8b9GpE9nAAAA:8
 a=VwQbUJbxAAAA:8 a=wSIzyl8AIrrWyGTfDxQA:9 a=T3LWEMljR5ZiDmsYVIUa:22
 a=AjGcO6oz07-iQ99wixmX:22
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-clk@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v4] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
Date:   Sun, 18 Jul 2021 15:57:00 +0200
Message-Id: <20210718135700.27247-1-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4xfNdcUJVaPcCs2XhTQXQRRi4T1vSjJGkxrKaH2JDps0CgcRK7Q9xaRlwEOZudmAeMlX5cm38tkXi5bMbmGsCxY7Tj8G0GutHOCKFzK//aYXqbp6v6TyZ+
 0/aVFhsZHmYYbaA6buzm+Et5WRSx6AyVOA5kiGg7FPTcHWI1RcBSunm/krObAZGP4HyBU3jThxziNkuDrK2dQg8aCXI64iC+JK3Lz80MOW+H9bwapI6wjZMu
 yC0o5C3HnZ+fpQ4tKm6+yTdYhJR0oYN5skye/fldQP6Q2P7p7RbNHR9biYJS4wob5n2VUzALpHWMljEfF1ytNLy5g+ZKVCWJSc85+yP3bp7s0+yMQhpQkKIh
 VZqB/RfZRco2/sAZgNuBPvsXxNognotXOimzkGwuHokVTVqUGfgwrK93Vu47sxXpAVFyZI0GWk79ziW/SgtfctHx0Jm2QSK3tuQt/iGkQ3CSJLProBJth6oj
 UHyp5uvQrYNG5/u4FstZWizFm0EaSlztYpB+WvVhF+MeRMExj+pEhPM/SesmvFMh5K+7fkyh+KZ/SC3D+31//a/n9bwJUYPsk7aNP9Ytx7ilz0wSuWzbEn7n
 HOVkiEanhMdCEaCU5c2cqHjp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the framebuffer leads to a system hang. Running, as a debug
hack, the store_pan() function in drivers/video/fbdev/core/fbsysfs.c
without taking the console_lock, allows to see the crash backtrace on
the serial line.

~ # echo 0 0 > /sys/class/graphics/fb0/pan

[    9.719414] Unhandled exception: IPSR = 00000005 LR = fffffff1
[    9.726937] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9
[    9.733008] Hardware name: STM32 (Device Tree Support)
[    9.738296] PC is at clk_gate_is_enabled+0x0/0x28
[    9.743426] LR is at stm32f4_pll_div_set_rate+0xf/0x38
[    9.748857] pc : [<0011e4be>]    lr : [<0011f9e3>]    psr: 0100000b
[    9.755373] sp : 00bc7be0  ip : 00000000  fp : 001f3ac4
[    9.760812] r10: 002610d0  r9 : 01efe920  r8 : 00540560
[    9.766269] r7 : 02e7ddb0  r6 : 0173eed8  r5 : 00000000  r4 : 004027c0
[    9.773081] r3 : 0011e4bf  r2 : 02e7ddb0  r1 : 0173eed8  r0 : 1d3267b8
[    9.779911] xPSR: 0100000b
[    9.782719] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9
[    9.788791] Hardware name: STM32 (Device Tree Support)
[    9.794120] [<0000afa1>] (unwind_backtrace) from [<0000a33f>] (show_stack+0xb/0xc)
[    9.802421] [<0000a33f>] (show_stack) from [<0000a8df>] (__invalid_entry+0x4b/0x4c)

The `pll_num' field in the post_div_data configuration contained a wrong
value which also referenced an uninitialized hardware clock when
clk_register_pll_div() was called.

Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")
Signed-off-by: Dario Binacchi <dariobin@libero.it>
Reviewed-by: Gabriel Fernandez <gabriel.fernandez@st.com>

---
I added Gabriel Fernandez's 'Reviewed-by' tag as requested by himself
15 days ago at https://lore.kernel.org/patchwork/patch/1450964/.

Changes in v4:
- Really add Gabriel Fernandez 'Reviewed-by' tag. In version 3 I forgot
  to add the tag.

Changes in v3:
- Add Gabriel Fernandez 'Reviewed-by' tag.

Changes in v2:
- Change  'u8 pll_num' from 'stm32f4_pll_post_div_data' structure into
  'int pll_idx'.

 drivers/clk/clk-stm32f4.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 18117ce5ff85..5c75e3d906c2 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -526,7 +526,7 @@ struct stm32f4_pll {
 
 struct stm32f4_pll_post_div_data {
 	int idx;
-	u8 pll_num;
+	int pll_idx;
 	const char *name;
 	const char *parent;
 	u8 flag;
@@ -557,13 +557,13 @@ static const struct clk_div_table post_divr_table[] = {
 
 #define MAX_POST_DIV 3
 static const struct stm32f4_pll_post_div_data  post_div_data[MAX_POST_DIV] = {
-	{ CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q-div", "plli2s-q",
+	{ CLK_I2SQ_PDIV, PLL_VCO_I2S, "plli2s-q-div", "plli2s-q",
 		CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 0, 5, 0, NULL},
 
-	{ CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q-div", "pllsai-q",
+	{ CLK_SAIQ_PDIV, PLL_VCO_SAI, "pllsai-q-div", "pllsai-q",
 		CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 8, 5, 0, NULL },
 
-	{ NO_IDX, PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
+	{ NO_IDX, PLL_VCO_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
 		STM32F4_RCC_DCKCFGR, 16, 2, 0, post_divr_table },
 };
 
@@ -1774,7 +1774,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 				post_div->width,
 				post_div->flag_div,
 				post_div->div_table,
-				clks[post_div->pll_num],
+				clks[post_div->pll_idx],
 				&stm32f4_clk_lock);
 
 		if (post_div->idx != NO_IDX)
-- 
2.17.1

