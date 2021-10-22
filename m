Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE97436FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhJVCCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhJVCCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:02:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C95136103E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634868007;
        bh=VfCSA663SgKRdVNeL2NBXaB4LcnB9tiuZiI7LrO/Ypo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EAcsXZK4H5ivs+5OjW1UF2W0Iq6xShdppzqvZCRF9R0C+xRumIDRLDth1UVLlQtuH
         NXvXl7k2TCOGKbdgdhMqco26+UQqwqULtVt2I3AcNT2KPa1vbG7fip8TiwBZJMX6u6
         zJVgl/PVOWmoP+aBKZolqm0DLb7zdd7hTL5WSBpeUdR3M0Q2Y8bcOC6L77n+1WvP1n
         uXjKbNbniuZXyR3B6ho9u6CHkcu/LgwyAMG/IASxmdkqOLvhuqXHShyW1Z9qNiw4Cz
         lV9xFBQAls8sj+Fm0HJ86QJyWKWp0epgh0KBdUmhy6l7LXpqt/PVpWfAyPiaTHROMs
         86Rl8idZ8wZCQ==
Received: by mail-ua1-f51.google.com with SMTP id u5so4806522uao.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:00:07 -0700 (PDT)
X-Gm-Message-State: AOAM5328axQATeloIfL9/woyGvToLhm4pJg/6aNJ7c/OocUlaFVG+at2
        33gLGJyuas/55LHplreFedoj853k/4Ujn2pTUgs=
X-Google-Smtp-Source: ABdhPJxBmC35GmTip+BQwx05YNLAePpxvsVt00lGzhtols7NKUb22RyKXaa5rHlcc9KW/nwveT9U+2HtJxLHXVUizUk=
X-Received: by 2002:ab0:3c4d:: with SMTP id u13mr11773257uaw.66.1634868006934;
 Thu, 21 Oct 2021 19:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211021180236.37428-1-mark.rutland@arm.com> <20211021180236.37428-14-mark.rutland@arm.com>
In-Reply-To: <20211021180236.37428-14-mark.rutland@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 22 Oct 2021 09:59:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT9RoEAQK1pRrB6ExwAyr5545pi47RDoNFHUqnCkaK66g@mail.gmail.com>
Message-ID: <CAJF2gTT9RoEAQK1pRrB6ExwAyr5545pi47RDoNFHUqnCkaK66g@mail.gmail.com>
Subject: Re: [PATCH 13/15] irq: riscv: perform irqentry in entry code
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

Reviewed-by: Guo Ren <guoren@kernel.org>

On Fri, Oct 22, 2021 at 2:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/riscv
> perform all the irqentry accounting in its entry code. As arch/riscv
> uses GENERIC_IRQ_MULTI_HANDLER, we can use generic_handle_arch_irq() to
> do so.
>
> Since generic_handle_arch_irq() handles the irq entry and setting the
> irq regs, and happens before the irqchip code calls handle_IPI(), we can
> remove the redundant irq entry and irq regs manipulation from
> handle_IPI().
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/riscv/Kconfig        | 1 -
>  arch/riscv/kernel/entry.S | 3 +--
>  arch/riscv/kernel/smp.c   | 9 +--------
>  3 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 740653063a56..301a54233c7e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -63,7 +63,6 @@ config RISCV
>         select GENERIC_SMP_IDLE_THREAD
>         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>         select HANDLE_DOMAIN_IRQ
> -       select HANDLE_DOMAIN_IRQ_IRQENTRY
>         select HAVE_ARCH_AUDITSYSCALL
>         select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>         select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 98f502654edd..64236f7efde5 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -130,8 +130,7 @@ skip_context_tracking:
>
>         /* Handle interrupts */
>         move a0, sp /* pt_regs */
> -       la a1, handle_arch_irq
> -       REG_L a1, (a1)
> +       la a1, generic_handle_arch_irq
>         jr a1
>  1:
>         /*
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 921d9d7df400..2f6da845c9ae 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -140,12 +140,9 @@ void arch_irq_work_raise(void)
>
>  void handle_IPI(struct pt_regs *regs)
>  {
> -       struct pt_regs *old_regs = set_irq_regs(regs);
>         unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
>         unsigned long *stats = ipi_data[smp_processor_id()].stats;
>
> -       irq_enter();
> -
>         riscv_clear_ipi();
>
>         while (true) {
> @@ -156,7 +153,7 @@ void handle_IPI(struct pt_regs *regs)
>
>                 ops = xchg(pending_ipis, 0);
>                 if (ops == 0)
> -                       goto done;
> +                       return;
>
>                 if (ops & (1 << IPI_RESCHEDULE)) {
>                         stats[IPI_RESCHEDULE]++;
> @@ -189,10 +186,6 @@ void handle_IPI(struct pt_regs *regs)
>                 /* Order data access and bit testing. */
>                 mb();
>         }
> -
> -done:
> -       irq_exit();
> -       set_irq_regs(old_regs);
>  }
>
>  static const char * const ipi_names[] = {
> --
> 2.11.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
