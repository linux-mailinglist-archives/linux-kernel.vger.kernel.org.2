Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EB1436FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhJVC3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231887AbhJVC3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:29:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 257FB613DA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634869620;
        bh=E5i+silWbs1r5UQTsWFM1WSBLmfoDJzLk7uPklQY11k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cGZHGCg0VzcsSBFYJ9HVs/7mxNa756cRLZFqMSxeoy0/gGxyyZBOwOhhALu8fvnEc
         +dhXCOhTShS6mye1gWvJPiE/aq2QJGI1c36pQ1UEsaIWzxBmy5FPV4VXZJrUsE/PlY
         McQE4Qy9XX3w7H0wkdwsir8vEjBnyiGPgoJRFfEwEVnczVl170iX7MfyaMm4m0kHmj
         Wj+VFucxoObc7inEYzzSkSevvEf9zsVu1n0FpAp7dWMz+L5SC3ip2XP16IjXB2NGLT
         kFzhi5J552Jlk+TEacYquT0elJPx7qyV+kAcvAsDcAAKwIGYD2Tc5FDn5Xk6S689AA
         HqZxFUFk5T9qg==
Received: by mail-ua1-f52.google.com with SMTP id k28so687601uaa.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:27:00 -0700 (PDT)
X-Gm-Message-State: AOAM531aSoUKOahR620veBkaucJiZlfSti4kWnKpg9Gk+A2rgeYCDOtK
        abXo4G6ydUXhOLcYXp60amRerjBpKQGIht0JQJk=
X-Google-Smtp-Source: ABdhPJwFrlQkji5/T3quIOABdZBsuG6/z8XG5+RL4oS/xrLElhWy+BNe/3eKV2xRfyndFnnu4RjbIrTgteDNSX8+lIk=
X-Received: by 2002:a05:6102:c4d:: with SMTP id y13mr11538365vss.33.1634869619073;
 Thu, 21 Oct 2021 19:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211021180236.37428-1-mark.rutland@arm.com> <20211021180236.37428-12-mark.rutland@arm.com>
 <CAJF2gTQOtz_=0anK0SdwJJ+Nu+eX1DKRMP+MMiFwpojgf43nyg@mail.gmail.com>
In-Reply-To: <CAJF2gTQOtz_=0anK0SdwJJ+Nu+eX1DKRMP+MMiFwpojgf43nyg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 22 Oct 2021 10:26:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS7pWBBaYmNNuzGUT4DBkQtWVvyzFBrR02CMms1yCQHvg@mail.gmail.com>
Message-ID: <CAJF2gTS7pWBBaYmNNuzGUT4DBkQtWVvyzFBrR02CMms1yCQHvg@mail.gmail.com>
Subject: Re: [PATCH 11/15] irq: csky: perform irqentry in entry code
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>, kernelfans@gmail.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul McKenney <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        vgupta@kernel.org, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:19 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Fri, Oct 22, 2021 at 2:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/csky
> > perform all the irqentry accounting in its entry code. As arch/csky uses
> > GENERIC_IRQ_MULTI_HANDLER, we can use generic_handle_arch_irq() to do
> > so.
> >
> > There should be no functional change as a result of this patch.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/csky/Kconfig        | 1 -
> >  arch/csky/kernel/entry.S | 2 +-
> >  arch/csky/kernel/irq.c   | 5 -----
> >  3 files changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > index 45f03f674a61..9d4d898df76b 100644
> > --- a/arch/csky/Kconfig
> > +++ b/arch/csky/Kconfig
> > @@ -18,7 +18,6 @@ config CSKY
> >         select DMA_DIRECT_REMAP
> >         select IRQ_DOMAIN
> >         select HANDLE_DOMAIN_IRQ
> > -       select HANDLE_DOMAIN_IRQ_IRQENTRY
> >         select DW_APB_TIMER_OF
> >         select GENERIC_IOREMAP
> >         select GENERIC_LIB_ASHLDI3
> > diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> > index 00e3c8ebf9b8..a4ababf25e24 100644
> > --- a/arch/csky/kernel/entry.S
> > +++ b/arch/csky/kernel/entry.S
> > @@ -249,7 +249,7 @@ ENTRY(csky_irq)
> >
> >
> >         mov     a0, sp
> > -       jbsr    csky_do_IRQ
> > +       jbsr    generic_handle_arch_irq
> >
> >         jmpi    ret_from_exception
> >
> > diff --git a/arch/csky/kernel/irq.c b/arch/csky/kernel/irq.c
> > index 03a1930f1cbb..fcdaf3156286 100644
> > --- a/arch/csky/kernel/irq.c
> > +++ b/arch/csky/kernel/irq.c
> > @@ -15,8 +15,3 @@ void __init init_IRQ(void)
> >         setup_smp_ipi();
> >  #endif
> >  }
> > -
> > -asmlinkage void __irq_entry csky_do_IRQ(struct pt_regs *regs)
> > -{
> > -       handle_arch_irq(regs);
> > -}
>
> Seems the previous code has lost old_regs save/restore?
>
> +       struct pt_regs *old_regs;
> +
> +       irq_enter();
> +       old_regs = set_irq_regs(regs);
> +       handle_arch_irq(regs);
> +       set_irq_regs(old_regs);
> +       irq_exit();

Sorry, handle_domain_irq has done it, and C-SKY's IPI is in the
handle_domain_irq.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> > --
> > 2.11.0
> >
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
