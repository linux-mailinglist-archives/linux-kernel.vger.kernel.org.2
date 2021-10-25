Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8643C4397A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhJYNgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231241AbhJYNgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:36:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94EB860FBF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635168819;
        bh=EJ45t84sWIEH4MsSQhX2PuBQrfefoAybdOzP/rNZ+W0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OombQE/tLFdXcoqTbOKCFBEoPkjNSZACFBrDM2ZUyFWNwvqMk5D9UcGaRRacva9y2
         JEkF5mg0tyglX17CJpImlDl71pFmOoDhemZlk35I4pLE3UhWOvGoUfp4RQU/q3zEGf
         88BHvNtZCfKIA5r7/3qm5FQg63dxvzRQTU4f/Ry9f2o9BP0535VjbcAvT1AfRKp2EP
         0qgiakvfCle5yZB2Lq3hIKKAw+GK3uDKotmIcRxy//YjAghnBu2aEJFCLdRmTMNPHZ
         7mgOU1C+q/2KuTGKSed2+/wCipyItHdlnXzsTpqIR7cNa1VyVYKvgZCSu+pT7U17q6
         WXdiCVfJJTxBg==
Received: by mail-vk1-f174.google.com with SMTP id f126so5177495vke.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 06:33:39 -0700 (PDT)
X-Gm-Message-State: AOAM531sSZaer88DYWusrKGEAJ4D7dBj3zgQZWkQVYcEVuSaXnuZgdOD
        Z7HMV7cbpnKXopuwrJzOrKmwAuEgEAfTnRvpCMc=
X-Google-Smtp-Source: ABdhPJwdtSXSO9me5cbpVx8umGxqAOBbaLGaFF8sdWMN1yxlQDvJkj80Gy8e7N7zebHiShNk+776CXMa7XvtZT+wyo8=
X-Received: by 2002:a05:6122:788:: with SMTP id k8mr14826563vkr.8.1635168818708;
 Mon, 25 Oct 2021 06:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-4-guoren@kernel.org>
 <87a6ixbcse.wl-maz@kernel.org>
In-Reply-To: <87a6ixbcse.wl-maz@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 25 Oct 2021 21:33:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTw136y8tzwOJQcNymGGWA2Zz127ozFEnGrRXwQUU7o8Q@mail.gmail.com>
Message-ID: <CAJF2gTTw136y8tzwOJQcNymGGWA2Zz127ozFEnGrRXwQUU7o8Q@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] irqchip/sifive-plic: Fixup thead,c900-plic
 request_threaded_irq with ONESHOT
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
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

On Mon, Oct 25, 2021 at 6:48 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 24 Oct 2021 02:33:03 +0100,
> guoren@kernel.org wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the driver,
> > only the first interrupt could be handled, and continue irq is blocked by
> > hw. Because the thead,c900-plic couldn't complete masked irq source which
> > has been disabled in enable register. Add thead_plic_chip which fix up
> > c906-plic irq source completion problem by unmask/mask wrapper.
> >
> > Here is the description of Interrupt Completion in PLIC spec [1]:
> >
> > The PLIC signals it has completed executing an interrupt handler by
> > writing the interrupt ID it received from the claim to the claim/complete
> > register. The PLIC does not check whether the completion ID is the same
> > as the last claim ID for that target. If the completion ID does not match
> > an interrupt source that is currently enabled for the target, the
> >                          ^^ ^^^^^^^^^ ^^^^^^^
> > completion is silently ignored.
>
> Given this bit of the spec...
>
> > +static void plic_thead_irq_eoi(struct irq_data *d)
> > +{
> > +     struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > +
> > +     if (irqd_irq_masked(d)) {
> > +             plic_irq_unmask(d);
> > +             writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > +             plic_irq_mask(d);
> > +     } else {
> > +             writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > +     }
> > +}
> > +
>
> ... it isn't obvious to me why this cannot happen on an SiFive PLIC.
I'm not sure about SiFive PLIC. Maybe they didn't follow that to implement.

>
> And it isn't only for threaded interrupts in oneshot mode. Any driver
> can mask an interrupt from its handler after having set the
> IRQ_DISABLE_UNLAZY flag, and the interrupt would need the exact same
> treatment.
Thx for mentioned here, and I'll add it in the comment of next version patch.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
