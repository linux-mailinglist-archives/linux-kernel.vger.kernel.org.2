Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7509F34B388
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 02:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhC0BcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 21:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhC0BcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 21:32:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6891BC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 18:32:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gb6so3398413pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 18:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1qyM+1DNjW/XD7eEnuQcpKGf5iWK0Q1LvMTIkGjwSqo=;
        b=i/mXW48hpqTfUnccCboWz/o5HV7cXmnzilTBKz3NQDE1smk0rHUPdIGurb50ZnY+4n
         gLW3JR4zCuwaYeezM2FxE9yQVhBrKgps7XT5n7yLSleXrdo89vor9ZeXZ7xYoQgtUSTK
         qFdPbSm+PoRqcMslaPpxZ1vUkVH0+C9Fj3hD9xC/SWx4/r5DItxDvEhgkJPpuNhOnewY
         My1IY9M3EgVFTPs+8NtbFnyIPGMYypmnAj8Om0gP0cqMdAEwTWdMv1xA3fnipgo7sWOl
         cLhjjkt/YOQu9W29DUkib3Q5lrl+pv0llK6l1kDBzAsXgXwmXxmJNsgXlmtSoDKysn1t
         qaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1qyM+1DNjW/XD7eEnuQcpKGf5iWK0Q1LvMTIkGjwSqo=;
        b=R3mXGgUNugyCueKuJtZK13vdN6hbIBomOrB/1rd310j66l8Sc/uxw0cgK1tPBRCJTG
         HGozpvAG/8yoluf3vduTiTPaUJ1bvzhaPyJlUzs3x9eJoGXewGwl9dE3D2R5Z/qIT+C6
         3P17SEGOTU2B3lKlc58RXXtBPXX/A0Z9v1f5pVTacs3b2lOH2gCEW4OBmAJW/cPUb9Gg
         ldsN5u92dMe8sXbdEvQgXeS1rrkSGgJz9i6djYKj1UzVa26jhuC2JzNJf6GsR6vw4b8l
         xt1JDb2uBSNmRCPXOw3eTrYoObLi7HdGtKxCBeEP9TeiGXHfSjLazIAL0wwMvgSIykkf
         /YcA==
X-Gm-Message-State: AOAM532fh8UMzY6swHF72JHSeUuF0Y2BDCpbP0QK5Y1r3PFCHVPb+0Y4
        pISr9f8j7VbXIWI9Ap8I/+BbL4DABnoDl4heL4Y=
X-Google-Smtp-Source: ABdhPJzoJ6uqODnvOnrHmp+8ZL3LHGDUO8eRyRdggrOZqTpzmbp6QOamcV2AvbdiBuyayMLQ9MkOWWRlE96o7nL49QM=
X-Received: by 2002:a17:902:b94c:b029:e6:98b9:c15b with SMTP id
 h12-20020a170902b94cb02900e698b9c15bmr18326448pls.60.1616808719912; Fri, 26
 Mar 2021 18:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210325123446.v2.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
 <049946ac-5263-21ee-9651-7295f0bcf387@linaro.org>
In-Reply-To: <049946ac-5263-21ee-9651-7295f0bcf387@linaro.org>
From:   Evan Benn <evanbenn@gmail.com>
Date:   Sat, 27 Mar 2021 12:31:46 +1100
Message-ID: <CAP8nV8rv6bKARZ31fVqcjVgMe+5UyVG8UAyNsm1hDCP2BbRSgw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/clocksource/mediatek: Ack and disable
 interrupts on shutdown
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Evan Benn <evanbenn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

That is a good point, and I did try that at first and it works fine. I
uploaded this version because the suspend/resume callbacks were
undocumented and mostly not used by other clocksource drivers. I
thought a smaller diff might be preferable.
I also thought it would be better to shut off the interrupt as soon as
it is not needed, avoiding any other potential bugs, instead of just
fixing the one we know about with suspend. I'm not sure how the other
driver / timer disable flows are intended to work for example
(shutdown, detach, etc).

That said I am happy to upload that version if people think it is better.

https://elixir.bootlin.com/linux/latest/source/include/linux/clockchips.h#L=
120


On Thu, 25 Mar 2021 at 19:10, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 25/03/2021 02:35, Evan Benn wrote:
> > set_state_shutdown is called during system suspend after interrupts hav=
e
> > been disabled. If the timer has fired in the meantime, there will be
> > a pending IRQ. So we ack that now and disable the timer. Without this
> > ARM trusted firmware will abort the suspend due to the pending
> > interrupt.
> >
> > Now always disable the IRQ in state transitions, and re-enable in
> > set_periodic and next_event.
>
> Why not put add the suspend/resume callbacks and put there the specific
> code and let the irq untouched in the normal flow ?
>
> > Signed-off-by: Evan Benn <evanbenn@chromium.org>
> > ---
> >
> > Changes in v2:
> > Remove the patch that splits the drivers into 2 files.
> >
> >  drivers/clocksource/timer-mediatek.c | 49 +++++++++++++++++-----------
> >  1 file changed, 30 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource=
/timer-mediatek.c
> > index 9318edcd8963..fba2f9494d90 100644
> > --- a/drivers/clocksource/timer-mediatek.c
> > +++ b/drivers/clocksource/timer-mediatek.c
> > @@ -132,13 +132,33 @@ static u64 notrace mtk_gpt_read_sched_clock(void)
> >       return readl_relaxed(gpt_sched_reg);
> >  }
> >
> > +static void mtk_gpt_disable_ack_interrupts(struct timer_of *to, u8 tim=
er)
> > +{
> > +     u32 val;
> > +
> > +     /* Disable interrupts */
> > +     val =3D readl(timer_of_base(to) + GPT_IRQ_EN_REG);
> > +     writel(val & ~GPT_IRQ_ENABLE(timer), timer_of_base(to) +
> > +            GPT_IRQ_EN_REG);
> > +
> > +     /* Ack interrupts */
> > +     writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
> > +}
> > +
> >  static void mtk_gpt_clkevt_time_stop(struct timer_of *to, u8 timer)
> >  {
> >       u32 val;
> >
> > +     /* Disable timer */
> >       val =3D readl(timer_of_base(to) + GPT_CTRL_REG(timer));
> >       writel(val & ~GPT_CTRL_ENABLE, timer_of_base(to) +
> >              GPT_CTRL_REG(timer));
> > +
> > +     /* This may be called with interrupts disabled,
> > +      * so we need to ack any interrupt that is pending
> > +      * Or for example ATF will prevent a suspend from completing.
> > +      */
> > +     mtk_gpt_disable_ack_interrupts(to, timer);
> >  }
> >
> >  static void mtk_gpt_clkevt_time_setup(struct timer_of *to,
> > @@ -152,8 +172,10 @@ static void mtk_gpt_clkevt_time_start(struct timer=
_of *to,
> >  {
> >       u32 val;
> >
> > -     /* Acknowledge interrupt */
> > -     writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
> > +     /* Enable interrupts */
> > +     val =3D readl(timer_of_base(to) + GPT_IRQ_EN_REG);
> > +     writel(val | GPT_IRQ_ENABLE(timer),
> > +            timer_of_base(to) + GPT_IRQ_EN_REG);
> >
> >       val =3D readl(timer_of_base(to) + GPT_CTRL_REG(timer));
> >
> > @@ -226,21 +248,6 @@ __init mtk_gpt_setup(struct timer_of *to, u8 timer=
, u8 option)
> >              timer_of_base(to) + GPT_CTRL_REG(timer));
> >  }
> >
> > -static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
> > -{
> > -     u32 val;
> > -
> > -     /* Disable all interrupts */
> > -     writel(0x0, timer_of_base(to) + GPT_IRQ_EN_REG);
> > -
> > -     /* Acknowledge all spurious pending interrupts */
> > -     writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
> > -
> > -     val =3D readl(timer_of_base(to) + GPT_IRQ_EN_REG);
> > -     writel(val | GPT_IRQ_ENABLE(timer),
> > -            timer_of_base(to) + GPT_IRQ_EN_REG);
> > -}
> > -
> >  static struct timer_of to =3D {
> >       .flags =3D TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> >
> > @@ -292,6 +299,12 @@ static int __init mtk_gpt_init(struct device_node =
*node)
> >       if (ret)
> >               return ret;
> >
> > +     /* In case the firmware left the interrupts enabled
> > +      * disable and ack those now
> > +      */
> > +     mtk_gpt_disable_ack_interrupts(&to, TIMER_CLK_SRC);
> > +     mtk_gpt_disable_ack_interrupts(&to, TIMER_CLK_EVT);
> > +
> >       /* Configure clock source */
> >       mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
> >       clocksource_mmio_init(timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_=
SRC),
> > @@ -305,8 +318,6 @@ static int __init mtk_gpt_init(struct device_node *=
node)
> >       clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> >                                       TIMER_SYNC_TICKS, 0xffffffff);
> >
> > -     mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
> > -
> >       return 0;
> >  }
> >  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
