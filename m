Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725E73B0F49
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 23:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFVVQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 17:16:31 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:52104 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229758AbhFVVQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:16:29 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([79.17.119.101])
        by smtp-35.iol.local with ESMTPA
        id vnielNBSisptivniklUEwx; Tue, 22 Jun 2021 23:14:11 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1624396451; bh=q4u5lVWA+wOoq0uMZgU7STwt05PnjBg+HXjVx8Ck3+I=;
        h=From;
        b=SXjiVRGp9HhsDWZ2UgUfmCH8GiQJLMt097kcWS8S0cr/KlZeBNbpkklU6yD0Xwx+U
         ZCG1CjI84JTt9N1i7Ehz7pW4T9cpscjTqmUriNq7S6MKhuXxlRP86E+YKok/I6D5uy
         hvGGkUupN3Za8+BEq8UygFqchMAze3J0NrR5GsqoNsbLuyhtL3xZ/wcFtnaNCKihj2
         NvIGGoM2IgVjNwt6cgR8+xfymw+Kn+DTT8us7f8JQFOmL4pPT1lPPdLpIgNKJOMJ0+
         E7txD9jLxKTtNhTAUu0q2kqaipBPTsJZbhQEz/E4/9pUwde7P2XoeGl+3aVZM1xqLg
         QhcWMKl1FEUXw==
X-CNFS-Analysis: v=2.4 cv=Bo1Yfab5 c=1 sm=1 tr=0 ts=60d252a3 cx=a_exe
 a=do1bHx4A/kh2kuTIUQHSxQ==:117 a=do1bHx4A/kh2kuTIUQHSxQ==:17
 a=-gG3lTu72TRn2TPmmlcA:9
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
Subject: [PATCH] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
Date:   Tue, 22 Jun 2021 23:14:01 +0200
Message-Id: <20210622211401.25604-1-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4xfJoT3wJtQx5iccwp/rPaSpMWyUu/ehUh8qU/5pIjXXjN1oYplvqtlJcBg7DLvrus1byAdQnHI8jJnZ1DyXR2kRQRLQnBaqAbkGFEXwhFX6cX+vf3112X
 v3PMw0o0V9L1YIv+DlTp9oCSUisQAj0pb0+PePaP6NcK0Vwy0tVTwh0K7zkU/guxL5O9fv6+W94V9qx+sZJeKY/1gWaYz9AXicNoVhKExkkdrcHiPKu6jB++
 yOmTLzASg+Ur/Rr7DJAaCTdfkjAgwnR4/+FvPnOGo11dVC9jYXn3CJualoOlH+xIzZYYao3d15bOQkk8yKyy57ygF+T8lrUl7jNNM1ystvWI2vAIs4iRRqtl
 c159dR6MfglP0ajmmj5KAs6Z9Kf/kxu9BLSY+opVxA776TJhRAFH4nv17ery+s1pm0XHkm6KrQvQscvOi6aWdS+V5Bm+Ebr2DF1Waq+gr4AzoGIQg402MUy6
 d/mcDQQrlJgs6I+TcNx73tNltHJqH2J/byPrlHHHplTdQFeED+NtUjDf4BIVac+0H9vevQ/n/h3ftd1gBPGH8j0DtwMvSGDWPnWHDhSsaJnNO9D5mx1fa9SN
 rEk6zw1CaDeJnzTWEnKWFU73
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

---

 drivers/clk/clk-stm32f4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 18117ce5ff85..42ca2dd86aea 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
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
 
-- 
2.17.1

