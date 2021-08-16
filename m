Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC53ED999
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhHPPMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhHPPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:12:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C3DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:12:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a7so27706524ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltxjJSY+VvHPYxAhIVLU79dz+oMyxa5HuOkF6wQAJIk=;
        b=GGsCPoehjTncSKsDaO1vTzOLRstc/ohxKm/eXpAu2lR2lgETmgSAq2sbVLB/BgVvIR
         6pK8ZfYgrD8mwTwU+ZLH5JfPBmX3TRj/nRFqM/3a7L3nStljC6cR0snQ+nAyOQaNzwAP
         +IRtWYqEIJb86zQh9MHGEhGmIxLLd+37fVZkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltxjJSY+VvHPYxAhIVLU79dz+oMyxa5HuOkF6wQAJIk=;
        b=qDbs1Tya7XLwPJVq7X0j/FjICpAaQCuoYYumbNZMMB4td3OuEVsmfnGTD0ZdeOXQLf
         pr/hLNmqlnPm1Nr8UBE8EFiuHADhw7XF5Kxdb5JOJ71tiP3965jmDdEJTKBWqTzOIK34
         lNGPSIs7u81ArCtj+tFYAK2CfjgPm9md9uE4GjYemF95eKoKPddwAU4XO+JzEmXQrTW8
         /K96XgTVMDRCxFWSJ99fcncBvbjtZ9Yom34mziSVKaEDMJo7B9v9tPNtrLanUpm4e1Jo
         Y7LEotKwzRCnKF/wt/25ghS3VWBMm980B9oFPOgY2Sr0ytBzK7gYgzYUv5dfXaQwFz85
         KQag==
X-Gm-Message-State: AOAM533x+PtsEOpFj9yRdIDgqPFp1a84qsrv6AlP3lbecEPopbHLAzoA
        guLDebIamsdQu7QHiTUWn32eDutzo9pqSljb2UodEQ==
X-Google-Smtp-Source: ABdhPJyy75Z36m2P327KLjhuFg287kRTm6DUsT1dRBYi+5Yxcy8Q6THE9Wfc/d6sTu+K7e+olQpasRCqXPJ2nHSEStw=
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr8819857ljc.251.1629126721592;
 Mon, 16 Aug 2021 08:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210811171505.1502090-1-wenst@chromium.org> <87fsvfal4n.wl-maz@kernel.org>
In-Reply-To: <87fsvfal4n.wl-maz@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 16 Aug 2021 23:11:50 +0800
Message-ID: <CAGXv+5GjVZ582u29_bbSKoLjb00vtvPo_ACn4WKDEfFiPULxPQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: Fix priority comparison when non-secure
 priorities are used
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 12, 2021 at 2:31 AM Marc Zyngier <maz@kernel.org> wrote:
>
> + Alex, who introduced this.
>
> On Wed, 11 Aug 2021 18:15:05 +0100,
> Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > When non-secure priorities are used, compared to the raw priority set,
> > the value read back from RPR is also right-shifted by one and the
> > highest bit set.
> >
> > Add a macro to do the modifications to the raw priority when doing the
> > comparison against the RPR value. This corrects the pseudo-NMI behavior
> > when non-secure priorities in the GIC are used. Tested on 5.10 with
> > the "IPI as pseudo-NMI" series [1] applied on MT8195.
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/
> >
> > Fixes: 336780590990 ("irqchip/gic-v3: Support pseudo-NMIs when SCR_EL3.FIQ == 0")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index e0f4debe64e1..e7a0b55413db 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -100,6 +100,15 @@ EXPORT_SYMBOL(gic_pmr_sync);
> >  DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
> >  EXPORT_SYMBOL(gic_nonsecure_priorities);
> >
> > +#define GICD_INT_RPR_PRI(priority)                                   \
> > +     ({                                                              \
> > +             u32 __priority = (priority);                            \
> > +             if (static_branch_unlikely(&gic_nonsecure_priorities))  \
> > +                     __priority = 0x80 | (__priority >> 1);          \
> > +                                                                     \
> > +             __priority;                                             \
>
> This doesn't reflect what the pseudocode says of a read of ICC_RPR_EL1
> AFAICS. When the priority is activated, it is indeed shifted. But a
> read of RPR does appear to shift things back (and you loose the lowest
> bit in the process). Please see 'aarch64/support/ICC_RPR_EL1' in the
> architecture spec.
>
> Can you confirm that SCR_EL3.FIQ is set on your system?

I gave this a test with mainline on an ROC-RK3399-PC. I figure this is
more available and stable than the MT8195 [1].

My board is running:

- ATF v2.4-561-g465af20ce (based on git commit 8078b5c5a) with console and
  some erratas enabled, but otherwise standard rk3399 config
  "-dirty" was due to the SCR_EL3 line.

NOTICE:  BL31: v2.4(debug):v2.4-561-g465af20ce-dirty
NOTICE:  BL31: Built : 22:59:42, Aug 16 2021
INFO:    GICv3 with legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    Maximum SPI INTID supported: 287
INFO:    plat_rockchip_pmu_init(1628): pd status 3e
INFO:    BL31: Initializing runtime services
INFO:    BL31: cortex_a53: CPU workaround for 855873 was applied
INFO:    BL31: cortex_a53: CPU workaround for 1530924 was applied
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    BL31: SCR_EL3=0x238, FIQ not set
INFO:    Entry point address = 0x200000
INFO:    SPSR = 0x3c9

- kernel next-20210813 + "NMI as IPI" series + debug printks scattered
  in the GICv3 driver

GICv3: GIC: Using split EOI/Deactivate mode
GICv3: 256 SPIs implemented
GICv3: 0 Extended SPIs implemented
GICv3: Distributor has no Range Selector support
Root IRQ handler: gic_handle_irq
GICv3: 16 PPIs implemented
GICv3: CPU0: found redistributor 0 region 0:0x00000000fef00000
GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
GICv3: Priority bits (gic_get_pribits()): 5
GICv3: Group0 available (gic_has_group0())
GICv3: Distributor security enabled (gic_dist_security_disabled()
GICv3: non-secure priorities used (gic_nonsecure_priorities)
GICv3: gic_irq_nmi_setup start: irq 7
GICv3: interrupt 7 priority a0
GICv3: interrupt 7 priority 20

So the RK3399 actually works correctly _without_ my fix. The NMI backtrace
triggers going through `gic_handle_nmi()`. If my fix is applied, it goes
through `gic_handle_irq()` instead.


However the MT8195 needs this to work correctly.

 === ATF ===
NOTICE:  MT8195 bl31_setup
NOTICE:  BL31: v2.5(debug):
NOTICE:  BL31: Built : Wed Jul  7 11:17:50 UTC 2021
INFO:    GICv3 without legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    Maximum SPI INTID supported: 895
NOTICE:  MT8195 spm_boot_init
INFO:    BL31: Initializing runtime services
INFO:    BL31: cortex_a55: CPU workaround for 1530923 was applied
INFO:    SPM: enable CPC mode
INFO:    mcdi ready for mcusys-off-idle and system suspend
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x80000000
INFO:    SPSR = 0x8

 === kernel GICv3 ===
GICv3: GIC: Using split EOI/Deactivate mode
GICv3: 864 SPIs implemented
GICv3: 0 Extended SPIs implemented
GICv3: Distributor has no Range Selector support
GICv3: 16 PPIs implemented
GICv3: CPU0: found redistributor 0 region 0:0x000000000c040000
GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
GICv3: Priority bits: 5
GICv3: Group0 available
GICv3: Distributor security enabled
GICv3: non-secure priorities used
GICv3: gic_irq_nmi_setup start: irq 7
GICv3: interrupt 7 priority a0
GICv3: interrupt 7 priority 20

I will dig through our ATF code base and try to see what's different.


ChenYu


[1] On a side note, the latest Chrome OS kernel 5.10 for the MT8195 gives
    a spinlock recursion during boot and hangs if pseudo-NMIs are enabled.
    I had to dig through my reflog to find the early version I developed
    on.


> Thanks,
>
>         M.
>
> > +     })
> > +
> >  /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
> >  static refcount_t *ppi_nmi_refs;
> >
> > @@ -687,7 +696,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
> >               return;
> >
> >       if (gic_supports_nmi() &&
> > -         unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
> > +         unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI))) {
> >               gic_handle_nmi(irqnr, regs);
> >               return;
> >       }
>
>
> --
> Without deviation from the norm, progress is not possible.
