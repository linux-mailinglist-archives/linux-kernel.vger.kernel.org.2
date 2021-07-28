Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD13D8B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhG1KEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhG1KEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:04:14 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4707C061757;
        Wed, 28 Jul 2021 03:04:12 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id 10so2090866ill.10;
        Wed, 28 Jul 2021 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4PuMlVCT7jMo4ZUqy0sj2FkowOIa3Yr3Zei1WjK4tiA=;
        b=AWZTCHu7T5tDCBGNj2065haI/yecsifbY8dfwcme2JRMk8FMCmoOHNTIjCkzpLYFIv
         S30c2e6mCzbSJIX4XWzVBOBpIExeLx0+ttzOAt4u4mfWDzvy1nFcYC0VvtFaz0qVlclR
         I/TXFNRGkCgzSacCWtjEQvKKjyyVmJ8rMHbk0kftXxM9X/pyPm5YomGi33MC2kCnTg4N
         9vrEtX2R4F6wrVtJ0xjBuwjq4xJmJUaqcHNlJNBdj3CVetu8Q+MazQJxY0HHi+4udad/
         fYyrkNidxVgeq5enqYnGQ48QLqXYaCA7K9tYa/MnDKcaOGKtzjjwQSe1GDUJzOH9cC/c
         HWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4PuMlVCT7jMo4ZUqy0sj2FkowOIa3Yr3Zei1WjK4tiA=;
        b=swE60Lxe3wsy4uXaKYKSzIFAUOlRGBIeQNDsbOyJElNmeCKbtia0r2igrBq7hhpOPi
         ErHITcA4QWOmU+fSr03BWItjDgkVDS4AG811wjG5WXhNHpuxmuXRAfAIjO1u1mHSMc+T
         Vi5h1JKtnYZUNKolwWs3jRrvI84FdvGLq6fYrOZ57gQeHE2LTc4uRigVLwlay2893jbK
         pJoNO3j+VVnQNyCGfZqghbtN8QGAZKR2Ai9rEsE5jusng4RPRAAFanCJVyt2dowwEXdC
         sKX/trLRIiqmyz1i28j18ZvkorqgsrM0MDHi06FD68pcy35AsFOVda/neZTbnN84GlI6
         DfmQ==
X-Gm-Message-State: AOAM531fjdqLq8xdufXSJXW3bmqRulezQOR4kHlnr2WyVG43yoISdmNJ
        BY9CqZFhIDMcANrTdMKLxcGgC5Yh++stUiTeCvc=
X-Google-Smtp-Source: ABdhPJwiBckW54PjAZOZYMsrEe18cAg4IeU8j8uuKh2570XMFa280TbMFS8RZaButWFLjO5NqGSTmXtVlCCKShsSrVo=
X-Received: by 2002:a05:6e02:20eb:: with SMTP id q11mr20348722ilv.272.1627466652056;
 Wed, 28 Jul 2021 03:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210725160725.10788-1-dariobin@libero.it>
In-Reply-To: <20210725160725.10788-1-dariobin@libero.it>
From:   Dillon Hua <dillonhua@gmail.com>
Date:   Wed, 28 Jul 2021 18:03:36 +0800
Message-ID: <CAPTRvHkf0cK_4ZidM17rPo99gWDmxgqFt4CDUjqFFwkOeQeFDg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4] clk: stm32f4: fix post divisor setup for
 I2S/SAI PLLs
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-clk@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

I have a similar patch [1] submitted last year.
Unfortunately, it did not get accepted by the maintainer.

Just a reminder here for you, should remove

{ STM32F4_RCC_APB2ENR, 26, "ltdc", "apb2_div" },

from stm32{f429, f469, f746, f769}_gates[]; or else
run into white screen after the kernel enters the console.

This patch was verified by Patrice Chotard, you can
find  the history from [2].

Hope you can help to submit a patch to include [2], thanks.

[1]
https://lore.kernel.org/linux-arm-kernel/1590564453-24499-7-git-send-email-dillon.minfei@gmail.com/
https://lore.kernel.org/linux-arm-kernel/1590564453-24499-6-git-send-email-dillon.minfei@gmail.com/

resend this year:
https://lore.kernel.org/lkml/1590378348-8115-6-git-send-email-dillon.minfei@gmail.com/

[2]
https://lore.kernel.org/lkml/6915fa2a-e211-476f-8317-6825e280c322@foss.st.com/

Thanks
Best Regards

Dillon

On Mon, Jul 26, 2021 at 12:08 AM Dario Binacchi <dariobin@libero.it> wrote:
>
> Enabling the framebuffer leads to a system hang. Running, as a debug
> hack, the store_pan() function in drivers/video/fbdev/core/fbsysfs.c
> without taking the console_lock, allows to see the crash backtrace on
> the serial line.
>
> ~ # echo 0 0 > /sys/class/graphics/fb0/pan
>
> [    9.719414] Unhandled exception: IPSR = 00000005 LR = fffffff1
> [    9.726937] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9
> [    9.733008] Hardware name: STM32 (Device Tree Support)
> [    9.738296] PC is at clk_gate_is_enabled+0x0/0x28
> [    9.743426] LR is at stm32f4_pll_div_set_rate+0xf/0x38
> [    9.748857] pc : [<0011e4be>]    lr : [<0011f9e3>]    psr: 0100000b
> [    9.755373] sp : 00bc7be0  ip : 00000000  fp : 001f3ac4
> [    9.760812] r10: 002610d0  r9 : 01efe920  r8 : 00540560
> [    9.766269] r7 : 02e7ddb0  r6 : 0173eed8  r5 : 00000000  r4 : 004027c0
> [    9.773081] r3 : 0011e4bf  r2 : 02e7ddb0  r1 : 0173eed8  r0 : 1d3267b8
> [    9.779911] xPSR: 0100000b
> [    9.782719] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9
> [    9.788791] Hardware name: STM32 (Device Tree Support)
> [    9.794120] [<0000afa1>] (unwind_backtrace) from [<0000a33f>] (show_stack+0xb/0xc)
> [    9.802421] [<0000a33f>] (show_stack) from [<0000a8df>] (__invalid_entry+0x4b/0x4c)
>
> The `pll_num' field in the post_div_data configuration contained a wrong
> value which also referenced an uninitialized hardware clock when
> clk_register_pll_div() was called.
>
> Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> Reviewed-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>
> ---
> I added Gabriel Fernandez's 'Reviewed-by' tag as requested by himself
> 15 days ago at https://lore.kernel.org/patchwork/patch/1450964/.
>
> Changes in v4:
> - Really add Gabriel Fernandez 'Reviewed-by' tag. In version 3 I forgot
>   to add the tag.
>
> Changes in v3:
> - Add Gabriel Fernandez 'Reviewed-by' tag.
>
> Changes in v2:
> - Change  'u8 pll_num' from 'stm32f4_pll_post_div_data' structure into
>   'int pll_idx'.
>
>  drivers/clk/clk-stm32f4.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> index 18117ce5ff85..5c75e3d906c2 100644
> --- a/drivers/clk/clk-stm32f4.c
> +++ b/drivers/clk/clk-stm32f4.c
> @@ -526,7 +526,7 @@ struct stm32f4_pll {
>
>  struct stm32f4_pll_post_div_data {
>         int idx;
> -       u8 pll_num;
> +       int pll_idx;
>         const char *name;
>         const char *parent;
>         u8 flag;
> @@ -557,13 +557,13 @@ static const struct clk_div_table post_divr_table[] = {
>
>  #define MAX_POST_DIV 3
>  static const struct stm32f4_pll_post_div_data  post_div_data[MAX_POST_DIV] = {
> -       { CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q-div", "plli2s-q",
> +       { CLK_I2SQ_PDIV, PLL_VCO_I2S, "plli2s-q-div", "plli2s-q",
>                 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 0, 5, 0, NULL},
>
> -       { CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q-div", "pllsai-q",
> +       { CLK_SAIQ_PDIV, PLL_VCO_SAI, "pllsai-q-div", "pllsai-q",
>                 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 8, 5, 0, NULL },
>
> -       { NO_IDX, PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
> +       { NO_IDX, PLL_VCO_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
>                 STM32F4_RCC_DCKCFGR, 16, 2, 0, post_divr_table },
>  };
>
> @@ -1774,7 +1774,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
>                                 post_div->width,
>                                 post_div->flag_div,
>                                 post_div->div_table,
> -                               clks[post_div->pll_num],
> +                               clks[post_div->pll_idx],
>                                 &stm32f4_clk_lock);
>
>                 if (post_div->idx != NO_IDX)
> --
> 2.17.1
>
