Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB374412BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 05:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhKAEaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 00:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKAEah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 00:30:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A1BC061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 21:28:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so1199976wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uf+ySBnpt0L81sOA1rQwLjpC6gi+1uIG+41YXpa5cPQ=;
        b=20p6K6qzy2pNd2PulvXyAfM5NyP61vXLtPCvqBuarxHuRHrewqnz61NqEhWKNpb8x/
         2ZSeOl1OXWEEglj+WxZsuJ8TyHBYg0WhZuWmcap/N7Q36qPxyWWIP2R7Wc37A+E+hAdR
         I+kzMpUJ4CRnZu6BYnxhNixKthJWoXgATTH1uNt0tZ3wO1cBlZvXk4h22uDFdTwvQirm
         LcrDk+5TMCN+VHz+wzriH3ld4WSmZ2Dr9exqUHJvq+jBYsDYBXmivNR+3oXq/mufURN/
         LsINXyWpkulQr9z49Spjke6Qj7h8f8zemr3h3LlX4bUFS62a3Co2zp60FmOfBpFHsisd
         T6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uf+ySBnpt0L81sOA1rQwLjpC6gi+1uIG+41YXpa5cPQ=;
        b=cs8S8M6l+mFyXAJUylJv5JNXon4sC8YbAHXpHIiORiSWbc7iVeAGg/ZUuljQG3D5Vg
         rEc19I7AaI+3An9e1dU95f/MQkJmNrIusrs6wqEevbO98Hsoqk6F8Q2mgpidYx4NX9fE
         QBccPb08wznp79qgAH5UCasc2Qo3fWRLLl5qVpRxkLQuPeLPQkO9NJp5L5GIs2cPitgL
         lgbQ5Lyh4cOZxn4s2JPek7KPqHsbhoUrtDVJJBKRrkOSRGBwIW81VnKh8AkjGs6R877T
         4jepEbs6NbR9E+YVsdgPVZROO/FAlrMs1EAeGvrxyhI9mRS35qtjPVxOvui9GYfdhi66
         GWww==
X-Gm-Message-State: AOAM533r5TucB2Zi79ngpPa2ibwJ9qikeVKb3HACS/Jg91NtgCweSF6i
        zcp1SGroS0nhreUAux2Hp36jgWlG/k23Lk0toJpOHw==
X-Google-Smtp-Source: ABdhPJzyv+CSLKPPRMzBxp/wdbHDKrNnGQbCY05ShCFU4VpfLfvznUlO0BlVRRWRVzhw5KcgX8aUw6UsEfBxQ+UZDQg=
X-Received: by 2002:a1c:2057:: with SMTP id g84mr15104450wmg.137.1635740881954;
 Sun, 31 Oct 2021 21:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-4-guoren@kernel.org>
 <87a6ixbcse.wl-maz@kernel.org> <20211028135523.5cf4b66b@redslave.neermore.group>
 <87sfwl9oxg.wl-maz@kernel.org> <CAJF2gTR3CqtmKZKS3fOQ9mzSLn7_oh7YoSSmWP1YM=ujB_srMw@mail.gmail.com>
 <CAAhSdy1WrxbMsiWkwOXd_76A6wNAh05C1QQ-oFXoE9U-F0akiA@mail.gmail.com> <CAJF2gTRwi+yH-hQ0SHKDOuUf=OOMfJxQb6Q5m6xRCPjvbYjqaQ@mail.gmail.com>
In-Reply-To: <CAJF2gTRwi+yH-hQ0SHKDOuUf=OOMfJxQb6Q5m6xRCPjvbYjqaQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 1 Nov 2021 09:57:50 +0530
Message-ID: <CAAhSdy3r2oVOq9yd+ZkOs1oCHRH-qvjLDa25Jp3qeD1tSxWEWQ@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] irqchip/sifive-plic: Fixup thead, c900-plic
 request_threaded_irq with ONESHOT
To:     Guo Ren <guoren@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 9:27 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Nov 1, 2021 at 10:53 AM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Nov 1, 2021 at 7:50 AM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > On Thu, Oct 28, 2021 at 10:58 PM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > On Thu, 28 Oct 2021 11:55:23 +0100,
> > > > Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> > > > >
> > > > > Hello Marc and Guo Ren!
> > > > >
> > > > > On Mon, 25 Oct 2021 11:48:33 +0100
> > > > > Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > > On Sun, 24 Oct 2021 02:33:03 +0100,
> > > > > > guoren@kernel.org wrote:
> > > > > > >
> > > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > > >
> > > > > > > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the
> > > > > > > driver, only the first interrupt could be handled, and continue irq
> > > > > > > is blocked by hw. Because the thead,c900-plic couldn't complete
> > > > > > > masked irq source which has been disabled in enable register. Add
> > > > > > > thead_plic_chip which fix up c906-plic irq source completion
> > > > > > > problem by unmask/mask wrapper.
> > > > > > >
> > > > > > > Here is the description of Interrupt Completion in PLIC spec [1]:
> > > > > > >
> > > > > > > The PLIC signals it has completed executing an interrupt handler by
> > > > > > > writing the interrupt ID it received from the claim to the
> > > > > > > claim/complete register. The PLIC does not check whether the
> > > > > > > completion ID is the same as the last claim ID for that target. If
> > > > > > > the completion ID does not match an interrupt source that is
> > > > > > > currently enabled for the target, the ^^ ^^^^^^^^^ ^^^^^^^
> > > > > > > completion is silently ignored.
> > > > > >
> > > > > > Given this bit of the spec...
> > > > > >
> > > > > > > +static void plic_thead_irq_eoi(struct irq_data *d)
> > > > > > > +{
> > > > > > > + struct plic_handler *handler =
> > > > > > > this_cpu_ptr(&plic_handlers); +
> > > > > > > + if (irqd_irq_masked(d)) {
> > > > > > > +         plic_irq_unmask(d);
> > > > > > > +         writel(d->hwirq, handler->hart_base +
> > > > > > > CONTEXT_CLAIM);
> > > > > > > +         plic_irq_mask(d);
> > > > > > > + } else {
> > > > > > > +         writel(d->hwirq, handler->hart_base +
> > > > > > > CONTEXT_CLAIM);
> > > > > > > + }
> > > > > > > +}
> > > > > > > +
> > > > > >
> > > > > > ... it isn't obvious to me why this cannot happen on an SiFive PLIC.
> > > > >
> > > > > This indeed happens with SiFive PLIC. I am currently tinkering with
> > > > > da9063 RTC on SiFive Unmatched, and ALARM irq fires only once. However
> > > > > with changes proposed by Guo Ren in plic_thead_irq_eoi, everything
> > > > > begins to work fine.
> > > > >
> > > > > May be these change should be propagated to plic_irq_eoi instead of
> > > > > making a new function ?
> > > >
> > > > That's my impression too. I think the T-Head defect is pretty much
> > > > immaterial when you consider how 'interesting' the PLIC architecture
> > > > is.
> > > Which is the "T-Head defect" you mentioned here?
> > >  1. Auto masking with claim + complete (I don't think it's a defect,
> > > right? May I add a new patch to utilize the feature to decrease a
> > > little duplicate mask/unmask operations in the future?)
> >
> > This is definitely a defect and non-compliance for T-HEAD because
> I just agree with non-compliance, but what's the defect of
> auto-masking? If somebody could explain, I'm very grateful.
>
> > no sane interrupt controller would mask interrupt upon claim and this
> > is not what RISC-V PLIC defines.
> >
> > >  2. EOI failed when masked
> >
> > This defect exists for both RISC-V PLIC and T-HEAD PLIC
> > because of the way interrupt completion is defined.
> >
> > >
> > > > Conflating EOI and masking really is a misfeature...
> > > I think the problem is riscv PLIC reuse enable bit as mask bit. I
> > > recommend separating them. That means:
> >
> > There are no per-interrupt mask bits. We only have per-context
> > and per-interrupt enable bits which is used to provide mask/unmask
> > functionality expected by the irqchip framework.
> >
> > I don't see how this is a problem for RISC-V PLIC. The only real
> > issue with RISC-V PLIC is the fact the interrupt completion will be
> > ignored for a masked interrupt which is what Marc is pointing at.
> So you are not considering add per-interrupt mask bits to solve the
> above problem, right?

The RISC-V PLIC has several limitations and also lacks a lot of features
hence it's marked as deprecated in RISC-V platform specs and will be
removed eventually from RISC-V platform specs.

The RISC-V AIA will totally replace RISC-V PLIC going forward. In fact,
RISC-V AIA APLIC addresses all limitations of RISC-V PLIC along with
new features additions.

>
> I don't think you would keep below codes in AIA eoi.
>  +             plic_irq_unmask(d);
>  +             writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
>  +             plic_irq_mask(d);

Like I mentioned previously, the AIA APLIC is very different from the
PLIC so we don't need this mask/unmask dance over there. It has global
per-interrupt enable bits in AIA APLIC which is different from PLIC.

Regards,
Anup

>
> >
> > Regards,
> > Anup
> >
> > >  - EOI still depends on enable bit.
> > >  - Add mask/unmask bit regs to do the right thing.
> >
> >
> >
> > >
> > > >
> > > >         M.
> > > >
> > > > --
> > > > Without deviation from the norm, progress is not possible.
> > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> > > ML: https://lore.kernel.org/linux-csky/
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
