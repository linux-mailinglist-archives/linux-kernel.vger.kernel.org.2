Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5FD3DCD4B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhHAThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:37:21 -0400
Received: from smtp-36-i2.italiaonline.it ([213.209.12.36]:53393 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229529AbhHAThU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:37:20 -0400
Received: from oxapps-35-162.iol.local ([10.101.8.208])
        by smtp-36.iol.local with ESMTPA
        id AHGomHcGbi9pCAHGomsnFR; Sun, 01 Aug 2021 21:37:10 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1627846630; bh=i+Jr2jch3DQ0iVnKpe8taEm4qVQD9jcH2ZntxFvyIMM=;
        h=From;
        b=Fe1EfhTwz40jto9LLTDp+jE6nnyTidk5iWtrYuLDGLF4zuv7xI4p/AmARe7T+V6wT
         BktCRaYWu48P+tIcUVFeqKizm8E/Vb5uXgb2MhPbZjS4tAoNqDcerY1YpAvAEd/aGD
         ktKaFR951ILong5vlkr88DoE81E7R6skbkOh7wUI0/8gpr9Huh5SzJ3L7uW5PUOnX3
         hDd86UX1A8tTdsZiXHaOksQDopYegNaGcvGl3FZdGBT+hrXszDyfR4I1HqvWF5snn4
         uOBeIYfwOAEnT8W+fnGph2jNFKp2+xSi1xFekBsNVvyxPMxNadkkbstsDfBVi3N9hn
         7bKGcGda9MTbA==
X-CNFS-Analysis: v=2.4 cv=RqYAkAqK c=1 sm=1 tr=0 ts=6106f7e6 cx=a_exe
 a=OCAZjQWm+uh9gf1btJle/A==:117 a=J7go-RGC33AA:10 a=IkcTkHD0fZMA:10
 a=nep-EciQ0nEA:10 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8
 a=8b9GpE9nAAAA:8 a=pgR7JClzwm78P6v5ddwA:9 a=QEXdDO2ut3YA:10
 a=IC2XNlieTeVoXbcui8wp:22 a=AjGcO6oz07-iQ99wixmX:22 a=T3LWEMljR5ZiDmsYVIUa:22
Date:   Sun, 1 Aug 2021 21:37:10 +0200 (CEST)
From:   Dario Binacchi <dariobin@libero.it>
To:     Dillon Hua <dillonhua@gmail.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Message-ID: <1371790418.70998.1627846630234@mail1.libero.it>
In-Reply-To: <CAPTRvH=R822osk86tRJqJCPNYY85t8t90+HJWcz43iASbcg2Jw@mail.gmail.com>
References: <20210725160725.10788-1-dariobin@libero.it>
 <CAPTRvHkf0cK_4ZidM17rPo99gWDmxgqFt4CDUjqFFwkOeQeFDg@mail.gmail.com>
 <1926284813.753014.1627553002984@mail1.libero.it>
 <CAPTRvH=R822osk86tRJqJCPNYY85t8t90+HJWcz43iASbcg2Jw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4] clk: stm32f4: fix post divisor setup for
 I2S/SAI PLLs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev34
X-Originating-IP: 82.60.87.158
X-Originating-Client: open-xchange-appsuite
x-libjamsun: gX2eDhe+Ni6lSZhpX7SY1Lqo02oL3piq
x-libjamv: 3lw8Yq5FSc4=
X-CMAE-Envelope: MS4xfN6Moqv1HwmyWG9rOisAnB/OtKGLRHgc1Gi91WYOykPshhHT4gtwUKA46OF6Rv0dk6iZzpaekkHeqZ/hvjXoZnoKztXDxG2uhQVJftFEl0o14MMfWaJy
 o0Ppfpw6pZMhIYA0GsUMtnNQ6Rz9YKhCvsIjIEkYM6vjWRZ0Tser+QFe9E3hz006YvRlDk9K1nY7Cif+wnsmPk1JqawQVoQi3TJonJrIJ+WY5DvhbHpW/EEo
 8b7D+lC6RHmRAaBtCsRuCYjIfweWTa1BfK1yfDxk81tqMd5R/MEtqdP9u2kt+LmNTZnLJIOXxLugg/tshd1AobJl6VsgadkJk7Un8j7OQk7/kBINFdeUQMLh
 1BACByyCGALbEst0tvYU29ulOraD6z0bXPdjpf/4FNl6UfLL9/tCnEa52apNEfseouC9gnwhrNN324NAsj0a1tmF6TYt0NGcaPzb5wffaYQNxZyLprIW+xfn
 WJc2Zpx+S2G5+xVez0a43rQ3l1XOcyNoyov2s/ZImnutQ7gNUQbmclEwOVwtu7Folqk+WN4yGYqXbzL6oiCIyevOvaUK6HZJWmmqKQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dillon and Stephen,

> Il 01/08/2021 16:56 Dillon Hua <dillonhua@gmail.com> ha scritto:
> 
>  
> Hi Dario
> 
> On Thu, Jul 29, 2021 at 6:03 PM Dario Binacchi <dariobin@libero.it> wrote:
> >
> > Hi Dillon,
> >
> > > Il 28/07/2021 12:03 Dillon Hua <dillonhua@gmail.com> ha scritto:
> > >
> > >
> > > Hi Dario,
> > >
> > > I have a similar patch [1] submitted last year.
> > > Unfortunately, it did not get accepted by the maintainer.
> > >
> > > Just a reminder here for you, should remove
> > >
> > > { STM32F4_RCC_APB2ENR, 26, "ltdc", "apb2_div" },
> >
> > Thank you for your suggestion.
> > While testing the patch on the stm32f469-disco board I didn't
> > notice the white screen issue. I'll try to run the tests again.
> > I will let you know.
> 
> Thanks, be sure clk_ignore_unused is not set from the kernel cmdline
> at your test.

This is the kernel command line of my tests:
console=ttySTM0,115200 root=/dev/mmcblk0p2 rw rootfstype=ext2 rootwait earlyprintk consoleblank=0 ignore_loglevel

In previous emails I forgot to mention that the patch was in turn applied to a buildroot patch [1] and
acked by Christophe Priouzeau of ST microelectronics. However, I rerun the tests and did not notice
anything strange.

I then enabled CONFIG_VT, CONFIG_FRAMEBUFFER_CONSOLE and CONFIG_LOGO, and indedd the command
'echo Dario >/dev/tty0' prints my name on the display only by removing
{STM32F4_RCC_APB2ENR, 26, "ltdc", "apb2_div"}.

As said in a previous email to Stephen, the patch I submitted fixes commit 517633ef630e
("clk: stm32f4: Add post divisor for I2S & SAI PLLs"), so IMHO it should not be dropped from the tree.
What Dillon suggested should instead be fixed by another patch.

Waiting for your opinion,
Thanks and regards,
Dario

[1] https://patchwork.ozlabs.org/project/buildroot/patch/20210716164243.17988-1-dariobin@libero.it/


> 
> Best Regards
> Dillon
> 
> >
> > Thanks and regards,
> > Dario
> >
> > >
> > > from stm32{f429, f469, f746, f769}_gates[]; or else
> > > run into white screen after the kernel enters the console.
> > >
> > > This patch was verified by Patrice Chotard, you can
> > > find  the history from [2].
> > >
> > > Hope you can help to submit a patch to include [2], thanks.
> > >
> > > [1]
> > > https://lore.kernel.org/linux-arm-kernel/1590564453-24499-7-git-send-email-dillon.minfei@gmail.com/
> > > https://lore.kernel.org/linux-arm-kernel/1590564453-24499-6-git-send-email-dillon.minfei@gmail.com/
> > >
> > > resend this year:
> > > https://lore.kernel.org/lkml/1590378348-8115-6-git-send-email-dillon.minfei@gmail.com/
> > >
> > > [2]
> > > https://lore.kernel.org/lkml/6915fa2a-e211-476f-8317-6825e280c322@foss.st.com/
> > >
> > > Thanks
> > > Best Regards
> > >
> > > Dillon
> > >
> > > On Mon, Jul 26, 2021 at 12:08 AM Dario Binacchi <dariobin@libero.it> wrote:
> > > >
> > > > Enabling the framebuffer leads to a system hang. Running, as a debug
> > > > hack, the store_pan() function in drivers/video/fbdev/core/fbsysfs.c
> > > > without taking the console_lock, allows to see the crash backtrace on
> > > > the serial line.
> > > >
> > > > ~ # echo 0 0 > /sys/class/graphics/fb0/pan
> > > >
> > > > [    9.719414] Unhandled exception: IPSR = 00000005 LR = fffffff1
> > > > [    9.726937] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9
> > > > [    9.733008] Hardware name: STM32 (Device Tree Support)
> > > > [    9.738296] PC is at clk_gate_is_enabled+0x0/0x28
> > > > [    9.743426] LR is at stm32f4_pll_div_set_rate+0xf/0x38
> > > > [    9.748857] pc : [<0011e4be>]    lr : [<0011f9e3>]    psr: 0100000b
> > > > [    9.755373] sp : 00bc7be0  ip : 00000000  fp : 001f3ac4
> > > > [    9.760812] r10: 002610d0  r9 : 01efe920  r8 : 00540560
> > > > [    9.766269] r7 : 02e7ddb0  r6 : 0173eed8  r5 : 00000000  r4 : 004027c0
> > > > [    9.773081] r3 : 0011e4bf  r2 : 02e7ddb0  r1 : 0173eed8  r0 : 1d3267b8
> > > > [    9.779911] xPSR: 0100000b
> > > > [    9.782719] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9
> > > > [    9.788791] Hardware name: STM32 (Device Tree Support)
> > > > [    9.794120] [<0000afa1>] (unwind_backtrace) from [<0000a33f>] (show_stack+0xb/0xc)
> > > > [    9.802421] [<0000a33f>] (show_stack) from [<0000a8df>] (__invalid_entry+0x4b/0x4c)
> > > >
> > > > The `pll_num' field in the post_div_data configuration contained a wrong
> > > > value which also referenced an uninitialized hardware clock when
> > > > clk_register_pll_div() was called.
> > > >
> > > > Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")
> > > > Signed-off-by: Dario Binacchi <dariobin@libero.it>
> > > > Reviewed-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> > > >
> > > > ---
> > > > I added Gabriel Fernandez's 'Reviewed-by' tag as requested by himself
> > > > 15 days ago at https://lore.kernel.org/patchwork/patch/1450964/.
> > > >
> > > > Changes in v4:
> > > > - Really add Gabriel Fernandez 'Reviewed-by' tag. In version 3 I forgot
> > > >   to add the tag.
> > > >
> > > > Changes in v3:
> > > > - Add Gabriel Fernandez 'Reviewed-by' tag.
> > > >
> > > > Changes in v2:
> > > > - Change  'u8 pll_num' from 'stm32f4_pll_post_div_data' structure into
> > > >   'int pll_idx'.
> > > >
> > > >  drivers/clk/clk-stm32f4.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> > > > index 18117ce5ff85..5c75e3d906c2 100644
> > > > --- a/drivers/clk/clk-stm32f4.c
> > > > +++ b/drivers/clk/clk-stm32f4.c
> > > > @@ -526,7 +526,7 @@ struct stm32f4_pll {
> > > >
> > > >  struct stm32f4_pll_post_div_data {
> > > >         int idx;
> > > > -       u8 pll_num;
> > > > +       int pll_idx;
> > > >         const char *name;
> > > >         const char *parent;
> > > >         u8 flag;
> > > > @@ -557,13 +557,13 @@ static const struct clk_div_table post_divr_table[] = {
> > > >
> > > >  #define MAX_POST_DIV 3
> > > >  static const struct stm32f4_pll_post_div_data  post_div_data[MAX_POST_DIV] = {
> > > > -       { CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q-div", "plli2s-q",
> > > > +       { CLK_I2SQ_PDIV, PLL_VCO_I2S, "plli2s-q-div", "plli2s-q",
> > > >                 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 0, 5, 0, NULL},
> > > >
> > > > -       { CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q-div", "pllsai-q",
> > > > +       { CLK_SAIQ_PDIV, PLL_VCO_SAI, "pllsai-q-div", "pllsai-q",
> > > >                 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 8, 5, 0, NULL },
> > > >
> > > > -       { NO_IDX, PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
> > > > +       { NO_IDX, PLL_VCO_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
> > > >                 STM32F4_RCC_DCKCFGR, 16, 2, 0, post_divr_table },
> > > >  };
> > > >
> > > > @@ -1774,7 +1774,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
> > > >                                 post_div->width,
> > > >                                 post_div->flag_div,
> > > >                                 post_div->div_table,
> > > > -                               clks[post_div->pll_num],
> > > > +                               clks[post_div->pll_idx],
> > > >                                 &stm32f4_clk_lock);
> > > >
> > > >                 if (post_div->idx != NO_IDX)
> > > > --
> > > > 2.17.1
> > > >
