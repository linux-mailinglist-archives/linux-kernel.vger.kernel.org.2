Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6B53DCC2D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 16:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhHAO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhHAO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 10:57:48 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2FC06179B;
        Sun,  1 Aug 2021 07:57:33 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id 67so246433uaq.4;
        Sun, 01 Aug 2021 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=saguw91hb74EPr3QaQQvQfQjL4oL0CP+oswKgra7Fb4=;
        b=LNJbASq7cDAMx/Y741eG1bXG8Jb9jfY+3Ai8RGO5ez7CNcBiG6HR4JfyfTWXbbcqFV
         SJlEGC9T1UEYxdvxt0f1+3b1pQEfUL7jfTA5iIHasGpi1yMhiShbuR5VYhNRMmXRE6mX
         5gln+kpLpuw1rW/DnOyvr/LtTet6vHVRD6mAr2ONdb+cw3DgyGXCST64I7fVWjZFShMQ
         TGs8VABQeP7TTRJzVU/NK0NmjnPyO6JDyOgaGlanVV4xNBQ5fuf/vyvDfKkVsT38dgMK
         ta2utNVSpdx3Bro/Kj162USfcxLg1rXiMOi0W86rJEPelc+CoKrnAhzgkXAE/wdyfTCy
         DjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saguw91hb74EPr3QaQQvQfQjL4oL0CP+oswKgra7Fb4=;
        b=gCmd3uqgEDEF42ILbqPOjO9GKGs4ceKYKsdeVFx4QZ7MRdlbObXw6N08bYxnQS/+93
         rjTv2yoo4blYrJDBd6SganbJfDYEp9+aYmQanhn55/S92QTJrnn/3X2+yhCVeYi0AMId
         Bi2Qk4FMJaVn6qO9D7cq96sdKw9SWa0wgR46ShVqNT5Hid8ddpJwDxEIo+hPzfle5DWw
         /bH5GyYGf2B8grYaMGgd1nmFdMsx9yBasMJzu0nyLKJN5rO8lKyj0cbyP2V3Tr/EpXSe
         KMPu+jXXdix5kQ3fh949HQfIoXk6oKcs5/UhCI0fIZmAAx2Z6qsU1vIG+H4D1GCUCkYu
         nEgA==
X-Gm-Message-State: AOAM530I051z4T1yR+mpijeY8/pftk89j69CdMsj+dtxOu2zVXvkTO9T
        j8SGjoNFmhvsMHOgu2kHWD/X1NCqVoEU3XBFRvE=
X-Google-Smtp-Source: ABdhPJyM8dn52+2YZpJiAR3AyKmfJpz6rJGTesAdeN35J/73g+H1oR8DSPuhyTpPBveqAgepxWQLNvHBp3crFtlOugo=
X-Received: by 2002:ab0:431:: with SMTP id 46mr7974965uav.5.1627829852515;
 Sun, 01 Aug 2021 07:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210725160725.10788-1-dariobin@libero.it> <CAPTRvHkf0cK_4ZidM17rPo99gWDmxgqFt4CDUjqFFwkOeQeFDg@mail.gmail.com>
 <1926284813.753014.1627553002984@mail1.libero.it>
In-Reply-To: <1926284813.753014.1627553002984@mail1.libero.it>
From:   Dillon Hua <dillonhua@gmail.com>
Date:   Sun, 1 Aug 2021 22:56:55 +0800
Message-ID: <CAPTRvH=R822osk86tRJqJCPNYY85t8t90+HJWcz43iASbcg2Jw@mail.gmail.com>
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

Hi Dario

On Thu, Jul 29, 2021 at 6:03 PM Dario Binacchi <dariobin@libero.it> wrote:
>
> Hi Dillon,
>
> > Il 28/07/2021 12:03 Dillon Hua <dillonhua@gmail.com> ha scritto:
> >
> >
> > Hi Dario,
> >
> > I have a similar patch [1] submitted last year.
> > Unfortunately, it did not get accepted by the maintainer.
> >
> > Just a reminder here for you, should remove
> >
> > { STM32F4_RCC_APB2ENR, 26, "ltdc", "apb2_div" },
>
> Thank you for your suggestion.
> While testing the patch on the stm32f469-disco board I didn't
> notice the white screen issue. I'll try to run the tests again.
> I will let you know.

Thanks, be sure clk_ignore_unused is not set from the kernel cmdline
at your test.

Best Regards
Dillon

>
> Thanks and regards,
> Dario
>
> >
> > from stm32{f429, f469, f746, f769}_gates[]; or else
> > run into white screen after the kernel enters the console.
> >
> > This patch was verified by Patrice Chotard, you can
> > find  the history from [2].
> >
> > Hope you can help to submit a patch to include [2], thanks.
> >
> > [1]
> > https://lore.kernel.org/linux-arm-kernel/1590564453-24499-7-git-send-email-dillon.minfei@gmail.com/
> > https://lore.kernel.org/linux-arm-kernel/1590564453-24499-6-git-send-email-dillon.minfei@gmail.com/
> >
> > resend this year:
> > https://lore.kernel.org/lkml/1590378348-8115-6-git-send-email-dillon.minfei@gmail.com/
> >
> > [2]
> > https://lore.kernel.org/lkml/6915fa2a-e211-476f-8317-6825e280c322@foss.st.com/
> >
> > Thanks
> > Best Regards
> >
> > Dillon
> >
> > On Mon, Jul 26, 2021 at 12:08 AM Dario Binacchi <dariobin@libero.it> wrote:
> > >
> > > Enabling the framebuffer leads to a system hang. Running, as a debug
> > > hack, the store_pan() function in drivers/video/fbdev/core/fbsysfs.c
> > > without taking the console_lock, allows to see the crash backtrace on
> > > the serial line.
> > >
> > > ~ # echo 0 0 > /sys/class/graphics/fb0/pan
> > >
> > > [    9.719414] Unhandled exception: IPSR = 00000005 LR = fffffff1
> > > [    9.726937] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9
> > > [    9.733008] Hardware name: STM32 (Device Tree Support)
> > > [    9.738296] PC is at clk_gate_is_enabled+0x0/0x28
> > > [    9.743426] LR is at stm32f4_pll_div_set_rate+0xf/0x38
> > > [    9.748857] pc : [<0011e4be>]    lr : [<0011f9e3>]    psr: 0100000b
> > > [    9.755373] sp : 00bc7be0  ip : 00000000  fp : 001f3ac4
> > > [    9.760812] r10: 002610d0  r9 : 01efe920  r8 : 00540560
> > > [    9.766269] r7 : 02e7ddb0  r6 : 0173eed8  r5 : 00000000  r4 : 004027c0
> > > [    9.773081] r3 : 0011e4bf  r2 : 02e7ddb0  r1 : 0173eed8  r0 : 1d3267b8
> > > [    9.779911] xPSR: 0100000b
> > > [    9.782719] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9
> > > [    9.788791] Hardware name: STM32 (Device Tree Support)
> > > [    9.794120] [<0000afa1>] (unwind_backtrace) from [<0000a33f>] (show_stack+0xb/0xc)
> > > [    9.802421] [<0000a33f>] (show_stack) from [<0000a8df>] (__invalid_entry+0x4b/0x4c)
> > >
> > > The `pll_num' field in the post_div_data configuration contained a wrong
> > > value which also referenced an uninitialized hardware clock when
> > > clk_register_pll_div() was called.
> > >
> > > Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")
> > > Signed-off-by: Dario Binacchi <dariobin@libero.it>
> > > Reviewed-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> > >
> > > ---
> > > I added Gabriel Fernandez's 'Reviewed-by' tag as requested by himself
> > > 15 days ago at https://lore.kernel.org/patchwork/patch/1450964/.
> > >
> > > Changes in v4:
> > > - Really add Gabriel Fernandez 'Reviewed-by' tag. In version 3 I forgot
> > >   to add the tag.
> > >
> > > Changes in v3:
> > > - Add Gabriel Fernandez 'Reviewed-by' tag.
> > >
> > > Changes in v2:
> > > - Change  'u8 pll_num' from 'stm32f4_pll_post_div_data' structure into
> > >   'int pll_idx'.
> > >
> > >  drivers/clk/clk-stm32f4.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> > > index 18117ce5ff85..5c75e3d906c2 100644
> > > --- a/drivers/clk/clk-stm32f4.c
> > > +++ b/drivers/clk/clk-stm32f4.c
> > > @@ -526,7 +526,7 @@ struct stm32f4_pll {
> > >
> > >  struct stm32f4_pll_post_div_data {
> > >         int idx;
> > > -       u8 pll_num;
> > > +       int pll_idx;
> > >         const char *name;
> > >         const char *parent;
> > >         u8 flag;
> > > @@ -557,13 +557,13 @@ static const struct clk_div_table post_divr_table[] = {
> > >
> > >  #define MAX_POST_DIV 3
> > >  static const struct stm32f4_pll_post_div_data  post_div_data[MAX_POST_DIV] = {
> > > -       { CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q-div", "plli2s-q",
> > > +       { CLK_I2SQ_PDIV, PLL_VCO_I2S, "plli2s-q-div", "plli2s-q",
> > >                 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 0, 5, 0, NULL},
> > >
> > > -       { CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q-div", "pllsai-q",
> > > +       { CLK_SAIQ_PDIV, PLL_VCO_SAI, "pllsai-q-div", "pllsai-q",
> > >                 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 8, 5, 0, NULL },
> > >
> > > -       { NO_IDX, PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
> > > +       { NO_IDX, PLL_VCO_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
> > >                 STM32F4_RCC_DCKCFGR, 16, 2, 0, post_divr_table },
> > >  };
> > >
> > > @@ -1774,7 +1774,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
> > >                                 post_div->width,
> > >                                 post_div->flag_div,
> > >                                 post_div->div_table,
> > > -                               clks[post_div->pll_num],
> > > +                               clks[post_div->pll_idx],
> > >                                 &stm32f4_clk_lock);
> > >
> > >                 if (post_div->idx != NO_IDX)
> > > --
> > > 2.17.1
> > >
