Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FCB346E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhCXBCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhCXBCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:02:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018C2C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:02:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b4so5505135lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jf3w9BjP/PUPyKVaAz9rRgBHkPWvt9e8CJDxXJRi4BY=;
        b=QtGhhJ6hk/9PHxQYjxOF3k4+ocL9DaQbA0o85qavBi2fgkNM60B1RXVnHvXkSoU6XG
         NaA7jVwPKlqDUU+vX10jUrX9u6am1zD3zvEDT6T/lVVtvrMndVM03VmlymcNbgWUK+58
         wmOQa+gv6PhVANN8rxFJiCaoLdlHQjoejopzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jf3w9BjP/PUPyKVaAz9rRgBHkPWvt9e8CJDxXJRi4BY=;
        b=ZdN6jWlLcgTyRCkSrcnkw1/yOhccZDjdoNhPdXf3DMjTZanc7hop3CEgAXG71/mtk0
         fUTMqC3TluGHC1czHreO3vLcL6X/+nFshizFKXwAwoY6MG3eRmDdEvhYHiCslDF69NxY
         ANCSUYn1db2tRAeaS3RqPRj2WGvVWsxgDbJ5D5bt88nv4eQvDjOpvzkhWoFczfyope2E
         4nz8r+7IsBzJkHX7jvffUlPA9n2a9naBbpCpfCpE9/gdw9i+DGC91biH0KgmpHskKDJQ
         gJguI5NEw6h20zKAMv5PQcen6pvrOap51tPGGGHWJLRgb2KJcJFxvLX7zib6rOZ4yhJD
         j0Vg==
X-Gm-Message-State: AOAM533LbZLnZyiVAJZ5F0rzZiLYhjYOJoBOusx+2e8ji2P8NFRoVCPy
        qz9ta/zaiyfzq+NpQjCArdFpwoGRxRYrrg==
X-Google-Smtp-Source: ABdhPJxQ9uCTcC1XcwUBkp7jv9thwLwdLQQZSXpmWPi1HvDqYfSkmkd3uP1hhaK9loXQL3rp4jRGXA==
X-Received: by 2002:ac2:5a5b:: with SMTP id r27mr387914lfn.255.1616547741956;
        Tue, 23 Mar 2021 18:02:21 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id l5sm90171lja.87.2021.03.23.18.02.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 18:02:21 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id r20so28094020ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:02:21 -0700 (PDT)
X-Received: by 2002:a2e:2e19:: with SMTP id u25mr350452lju.487.1616547250076;
 Tue, 23 Mar 2021 17:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210318160414.1.Ia2a09ce93b47eac45308205820db0938d47604df@changeid>
 <5a0272dc-bb00-ac4b-4e44-5a2980d7baaa@linaro.org>
In-Reply-To: <5a0272dc-bb00-ac4b-4e44-5a2980d7baaa@linaro.org>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Wed, 24 Mar 2021 11:53:43 +1100
X-Gmail-Original-Message-ID: <CAKz_xw1wPxEpPGs1A4jzuoKqbL-okczb9GCdLFqcCbaBs2F-0A@mail.gmail.com>
Message-ID: <CAKz_xw1wPxEpPGs1A4jzuoKqbL-okczb9GCdLFqcCbaBs2F-0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/clocksource/mediatek: Split mediatek drivers
 into 2 files
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:19 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Evan,
>
> On 18/03/2021 06:04, Evan Benn wrote:
> > mtk_gpt and mtk_syst drivers for mt6577 and mt6765 devices were not
> > sharing any code. So split them into separate files.
>
> For the sake of consistency, keeping all in one is better.

Thanks Daniel,

I think you are right.
The other patch does apply cleanly without this one, so please just
ignore this patch.

>
> Thanks
>   -- Daniel
>
> > Signed-off-by: Evan Benn <evanbenn@chromium.org>
> > ---
> >
> >  arch/arm/mach-mediatek/Kconfig                |   3 +-
> >  arch/arm64/Kconfig.platforms                  |   3 +-
> >  drivers/clocksource/Kconfig                   |  13 +-
> >  drivers/clocksource/Makefile                  |   3 +-
> >  ...mer-mediatek.c =3D> timer-mediatek-mt6577.c} | 100 -------------
> >  drivers/clocksource/timer-mediatek-mt6765.c   | 135 ++++++++++++++++++
> >  6 files changed, 151 insertions(+), 106 deletions(-)
> >  rename drivers/clocksource/{timer-mediatek.c =3D> timer-mediatek-mt657=
7.c} (69%)
> >  create mode 100644 drivers/clocksource/timer-mediatek-mt6765.c
> >
> > diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kc=
onfig
> > index 9e0f592d87d8..8686f992c4b6 100644
> > --- a/arch/arm/mach-mediatek/Kconfig
> > +++ b/arch/arm/mach-mediatek/Kconfig
> > @@ -4,7 +4,8 @@ menuconfig ARCH_MEDIATEK
> >       depends on ARCH_MULTI_V7
> >       select ARM_GIC
> >       select PINCTRL
> > -     select MTK_TIMER
> > +     select TIMER_MEDIATEK_MT6577
> > +     select TIMER_MEDIATEK_MT6765
> >       select MFD_SYSCON
> >       help
> >         Support for Mediatek MT65xx & MT81xx SoCs
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platform=
s
> > index cdfd5fed457f..d4752375ab0b 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -161,7 +161,8 @@ config ARCH_MEDIATEK
> >       bool "MediaTek SoC Family"
> >       select ARM_GIC
> >       select PINCTRL
> > -     select MTK_TIMER
> > +     select TIMER_MEDIATEK_MT6577
> > +     select TIMER_MEDIATEK_MT6765
> >       help
> >         This enables support for MediaTek MT27xx, MT65xx, MT76xx
> >         & MT81xx ARMv8 SoCs
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 39aa21d01e05..d697c799284e 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -438,13 +438,20 @@ config OXNAS_RPS_TIMER
> >  config SYS_SUPPORTS_SH_CMT
> >       bool
> >
> > -config MTK_TIMER
> > -     bool "Mediatek timer driver" if COMPILE_TEST
> > +config TIMER_MEDIATEK_MT6577
> > +     bool "Mediatek mt6577 timer driver" if COMPILE_TEST
> >       depends on HAS_IOMEM
> >       select TIMER_OF
> >       select CLKSRC_MMIO
> >       help
> > -       Support for Mediatek timer driver.
> > +       Enables clocksource and clockevent driver for Mediatek mt6577 t=
imer.
> > +
> > +config TIMER_MEDIATEK_MT6765
> > +     bool "Mediatek mt6765 timer driver" if COMPILE_TEST
> > +     depends on HAS_IOMEM
> > +     select TIMER_OF
> > +     help
> > +       Enables clockevent driver for Mediatek mt6765 timer.
> >
> >  config SPRD_TIMER
> >       bool "Spreadtrum timer driver" if EXPERT
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefil=
e
> > index c17ee32a7151..b1f06ce114f9 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -49,7 +49,8 @@ obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)    +=3D samsung_pwm_=
timer.o
> >  obj-$(CONFIG_FSL_FTM_TIMER)  +=3D timer-fsl-ftm.o
> >  obj-$(CONFIG_VF_PIT_TIMER)   +=3D timer-vf-pit.o
> >  obj-$(CONFIG_CLKSRC_QCOM)    +=3D timer-qcom.o
> > -obj-$(CONFIG_MTK_TIMER)              +=3D timer-mediatek.o
> > +obj-$(CONFIG_TIMER_MEDIATEK_MT6577)          +=3D timer-mediatek-mt657=
7.o
> > +obj-$(CONFIG_TIMER_MEDIATEK_MT6765)          +=3D timer-mediatek-mt676=
5.o
> >  obj-$(CONFIG_CLKSRC_PISTACHIO)       +=3D timer-pistachio.o
> >  obj-$(CONFIG_CLKSRC_TI_32K)  +=3D timer-ti-32k.o
> >  obj-$(CONFIG_OXNAS_RPS_TIMER)        +=3D timer-oxnas-rps.o
> > diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource=
/timer-mediatek-mt6577.c
> > similarity index 69%
> > rename from drivers/clocksource/timer-mediatek.c
> > rename to drivers/clocksource/timer-mediatek-mt6577.c
> > index 9318edcd8963..9e5241d1876d 100644
> > --- a/drivers/clocksource/timer-mediatek.c
> > +++ b/drivers/clocksource/timer-mediatek-mt6577.c
> > @@ -47,86 +47,8 @@
> >  #define GPT_CNT_REG(val)        (0x08 + (0x10 * (val)))
> >  #define GPT_CMP_REG(val)        (0x0C + (0x10 * (val)))
> >
> > -/* system timer */
> > -#define SYST_BASE               (0x40)
> > -
> > -#define SYST_CON                (SYST_BASE + 0x0)
> > -#define SYST_VAL                (SYST_BASE + 0x4)
> > -
> > -#define SYST_CON_REG(to)        (timer_of_base(to) + SYST_CON)
> > -#define SYST_VAL_REG(to)        (timer_of_base(to) + SYST_VAL)
> > -
> > -/*
> > - * SYST_CON_EN: Clock enable. Shall be set to
> > - *   - Start timer countdown.
> > - *   - Allow timeout ticks being updated.
> > - *   - Allow changing interrupt functions.
> > - *
> > - * SYST_CON_IRQ_EN: Set to allow interrupt.
> > - *
> > - * SYST_CON_IRQ_CLR: Set to clear interrupt.
> > - */
> > -#define SYST_CON_EN              BIT(0)
> > -#define SYST_CON_IRQ_EN          BIT(1)
> > -#define SYST_CON_IRQ_CLR         BIT(4)
> > -
> >  static void __iomem *gpt_sched_reg __read_mostly;
> >
> > -static void mtk_syst_ack_irq(struct timer_of *to)
> > -{
> > -     /* Clear and disable interrupt */
> > -     writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
> > -}
> > -
> > -static irqreturn_t mtk_syst_handler(int irq, void *dev_id)
> > -{
> > -     struct clock_event_device *clkevt =3D dev_id;
> > -     struct timer_of *to =3D to_timer_of(clkevt);
> > -
> > -     mtk_syst_ack_irq(to);
> > -     clkevt->event_handler(clkevt);
> > -
> > -     return IRQ_HANDLED;
> > -}
> > -
> > -static int mtk_syst_clkevt_next_event(unsigned long ticks,
> > -                                   struct clock_event_device *clkevt)
> > -{
> > -     struct timer_of *to =3D to_timer_of(clkevt);
> > -
> > -     /* Enable clock to allow timeout tick update later */
> > -     writel(SYST_CON_EN, SYST_CON_REG(to));
> > -
> > -     /*
> > -      * Write new timeout ticks. Timer shall start countdown
> > -      * after timeout ticks are updated.
> > -      */
> > -     writel(ticks, SYST_VAL_REG(to));
> > -
> > -     /* Enable interrupt */
> > -     writel(SYST_CON_EN | SYST_CON_IRQ_EN, SYST_CON_REG(to));
> > -
> > -     return 0;
> > -}
> > -
> > -static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
> > -{
> > -     /* Disable timer */
> > -     writel(0, SYST_CON_REG(to_timer_of(clkevt)));
> > -
> > -     return 0;
> > -}
> > -
> > -static int mtk_syst_clkevt_resume(struct clock_event_device *clkevt)
> > -{
> > -     return mtk_syst_clkevt_shutdown(clkevt);
> > -}
> > -
> > -static int mtk_syst_clkevt_oneshot(struct clock_event_device *clkevt)
> > -{
> > -     return 0;
> > -}
> > -
> >  static u64 notrace mtk_gpt_read_sched_clock(void)
> >  {
> >       return readl_relaxed(gpt_sched_reg);
> > @@ -255,27 +177,6 @@ static struct timer_of to =3D {
> >       },
> >  };
> >
> > -static int __init mtk_syst_init(struct device_node *node)
> > -{
> > -     int ret;
> > -
> > -     to.clkevt.features =3D CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONE=
SHOT;
> > -     to.clkevt.set_state_shutdown =3D mtk_syst_clkevt_shutdown;
> > -     to.clkevt.set_state_oneshot =3D mtk_syst_clkevt_oneshot;
> > -     to.clkevt.tick_resume =3D mtk_syst_clkevt_resume;
> > -     to.clkevt.set_next_event =3D mtk_syst_clkevt_next_event;
> > -     to.of_irq.handler =3D mtk_syst_handler;
> > -
> > -     ret =3D timer_of_init(node, &to);
> > -     if (ret)
> > -             return ret;
> > -
> > -     clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> > -                                     TIMER_SYNC_TICKS, 0xffffffff);
> > -
> > -     return 0;
> > -}
> > -
> >  static int __init mtk_gpt_init(struct device_node *node)
> >  {
> >       int ret;
> > @@ -310,4 +211,3 @@ static int __init mtk_gpt_init(struct device_node *=
node)
> >       return 0;
> >  }
> >  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
> > -TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
> > diff --git a/drivers/clocksource/timer-mediatek-mt6765.c b/drivers/cloc=
ksource/timer-mediatek-mt6765.c
> > new file mode 100644
> > index 000000000000..b4f22f226feb
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-mediatek-mt6765.c
> > @@ -0,0 +1,135 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Mediatek SoCs General-Purpose Timer handling.
> > + *
> > + * Copyright (C) 2014 Matthias Brugger
> > + *
> > + * Matthias Brugger <matthias.bgg@gmail.com>
> > + */
> > +
> > +#define pr_fmt(fmt)  KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/clockchips.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/sched_clock.h>
> > +#include <linux/slab.h>
> > +#include "timer-of.h"
> > +
> > +#define TIMER_SYNC_TICKS        (3)
> > +
> > +/* system timer */
> > +#define SYST_BASE               (0x40)
> > +
> > +#define SYST_CON                (SYST_BASE + 0x0)
> > +#define SYST_VAL                (SYST_BASE + 0x4)
> > +
> > +#define SYST_CON_REG(to)        (timer_of_base(to) + SYST_CON)
> > +#define SYST_VAL_REG(to)        (timer_of_base(to) + SYST_VAL)
> > +
> > +/*
> > + * SYST_CON_EN: Clock enable. Shall be set to
> > + *   - Start timer countdown.
> > + *   - Allow timeout ticks being updated.
> > + *   - Allow changing interrupt functions.
> > + *
> > + * SYST_CON_IRQ_EN: Set to allow interrupt.
> > + *
> > + * SYST_CON_IRQ_CLR: Set to clear interrupt.
> > + */
> > +#define SYST_CON_EN              BIT(0)
> > +#define SYST_CON_IRQ_EN          BIT(1)
> > +#define SYST_CON_IRQ_CLR         BIT(4)
> > +
> > +static void mtk_syst_ack_irq(struct timer_of *to)
> > +{
> > +     /* Clear and disable interrupt */
> > +     writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
> > +}
> > +
> > +static irqreturn_t mtk_syst_handler(int irq, void *dev_id)
> > +{
> > +     struct clock_event_device *clkevt =3D dev_id;
> > +     struct timer_of *to =3D to_timer_of(clkevt);
> > +
> > +     mtk_syst_ack_irq(to);
> > +     clkevt->event_handler(clkevt);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int mtk_syst_clkevt_next_event(unsigned long ticks,
> > +                                   struct clock_event_device *clkevt)
> > +{
> > +     struct timer_of *to =3D to_timer_of(clkevt);
> > +
> > +     /* Enable clock to allow timeout tick update later */
> > +     writel(SYST_CON_EN, SYST_CON_REG(to));
> > +
> > +     /*
> > +      * Write new timeout ticks. Timer shall start countdown
> > +      * after timeout ticks are updated.
> > +      */
> > +     writel(ticks, SYST_VAL_REG(to));
> > +
> > +     /* Enable interrupt */
> > +     writel(SYST_CON_EN | SYST_CON_IRQ_EN, SYST_CON_REG(to));
> > +
> > +     return 0;
> > +}
> > +
> > +static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
> > +{
> > +     /* Disable timer */
> > +     writel(0, SYST_CON_REG(to_timer_of(clkevt)));
> > +
> > +     return 0;
> > +}
> > +
> > +static int mtk_syst_clkevt_resume(struct clock_event_device *clkevt)
> > +{
> > +     return mtk_syst_clkevt_shutdown(clkevt);
> > +}
> > +
> > +static int mtk_syst_clkevt_oneshot(struct clock_event_device *clkevt)
> > +{
> > +     return 0;
> > +}
> > +
> > +static struct timer_of to =3D {
> > +     .flags =3D TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> > +
> > +     .clkevt =3D {
> > +             .name =3D "mtk-clkevt",
> > +             .rating =3D 300,
> > +             .cpumask =3D cpu_possible_mask,
> > +     },
> > +
> > +     .of_irq =3D {
> > +             .flags =3D IRQF_TIMER | IRQF_IRQPOLL,
> > +     },
> > +};
> > +
> > +static int __init mtk_syst_init(struct device_node *node)
> > +{
> > +     int ret;
> > +
> > +     to.clkevt.features =3D CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONE=
SHOT;
> > +     to.clkevt.set_state_shutdown =3D mtk_syst_clkevt_shutdown;
> > +     to.clkevt.set_state_oneshot =3D mtk_syst_clkevt_oneshot;
> > +     to.clkevt.tick_resume =3D mtk_syst_clkevt_resume;
> > +     to.clkevt.set_next_event =3D mtk_syst_clkevt_next_event;
> > +     to.of_irq.handler =3D mtk_syst_handler;
> > +
> > +     ret =3D timer_of_init(node, &to);
> > +     if (ret)
> > +             return ret;
> > +
> > +     clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> > +                                     TIMER_SYNC_TICKS, 0xffffffff);
> > +
> > +     return 0;
> > +}
> > +
> > +TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
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
