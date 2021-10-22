Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043C9436FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhJVCWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhJVCWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:22:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8F03613D0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634869205;
        bh=g+Bp25s5AcdR1UXY9t89d+/23B27zYRSUyZtCOv20dw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jgmrFL4LKxeBb18HQ/ov6iE5ZwFf9x0rMtFjegfWV3Cqqp7OWqDwqeWOmCo9iGUa1
         q8XWGX7ET2/yexImpg4VFwblv1xHQrI6J9ZJ1EkWqTAzgNy0eYEJDhf1K0nVfxpniO
         /w0dDlpG/MhCm1c4dgeay5IHw4e/p9W71Kxg56DjrP4b2znquUjFtHbujwO3822Z0T
         1c6ABRrHwjWNonp7+ya/w9uUUUv0SH0raMWrAQySLN+pF76xL9bpFfahABiLA9rLzQ
         C30ilfvvmKqJOXas+x1WXYDcD3eu6S4wqjZhM37q/qsdGOK5si0nA/0d/8HXHTJIVJ
         JSEP+w9pX/urw==
Received: by mail-ua1-f52.google.com with SMTP id h19so4947504uax.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:20:04 -0700 (PDT)
X-Gm-Message-State: AOAM531rXWCNkQz4NOlyreSE0u1nsn2VHzB699bfXVx+WWRvUa94Uykv
        0aZG2PUYWu1x0c8oi3clW2/Oqc9QyajJQntWVoU=
X-Google-Smtp-Source: ABdhPJzk812G5JMy7zdAQjPLQn49PUi0Rfv1mBgbrAZasbvDb0j6JJLAZJs7VI9EN8x4vWXa3I4APhG3sfHhJLjPB/A=
X-Received: by 2002:ab0:3c4d:: with SMTP id u13mr11899281uaw.66.1634869203855;
 Thu, 21 Oct 2021 19:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211021180236.37428-1-mark.rutland@arm.com> <20211021180236.37428-12-mark.rutland@arm.com>
In-Reply-To: <20211021180236.37428-12-mark.rutland@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 22 Oct 2021 10:19:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQOtz_=0anK0SdwJJ+Nu+eX1DKRMP+MMiFwpojgf43nyg@mail.gmail.com>
Message-ID: <CAJF2gTQOtz_=0anK0SdwJJ+Nu+eX1DKRMP+MMiFwpojgf43nyg@mail.gmail.com>
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

On Fri, Oct 22, 2021 at 2:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/csky
> perform all the irqentry accounting in its entry code. As arch/csky uses
> GENERIC_IRQ_MULTI_HANDLER, we can use generic_handle_arch_irq() to do
> so.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/csky/Kconfig        | 1 -
>  arch/csky/kernel/entry.S | 2 +-
>  arch/csky/kernel/irq.c   | 5 -----
>  3 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 45f03f674a61..9d4d898df76b 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -18,7 +18,6 @@ config CSKY
>         select DMA_DIRECT_REMAP
>         select IRQ_DOMAIN
>         select HANDLE_DOMAIN_IRQ
> -       select HANDLE_DOMAIN_IRQ_IRQENTRY
>         select DW_APB_TIMER_OF
>         select GENERIC_IOREMAP
>         select GENERIC_LIB_ASHLDI3
> diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> index 00e3c8ebf9b8..a4ababf25e24 100644
> --- a/arch/csky/kernel/entry.S
> +++ b/arch/csky/kernel/entry.S
> @@ -249,7 +249,7 @@ ENTRY(csky_irq)
>
>
>         mov     a0, sp
> -       jbsr    csky_do_IRQ
> +       jbsr    generic_handle_arch_irq
>
>         jmpi    ret_from_exception
>
> diff --git a/arch/csky/kernel/irq.c b/arch/csky/kernel/irq.c
> index 03a1930f1cbb..fcdaf3156286 100644
> --- a/arch/csky/kernel/irq.c
> +++ b/arch/csky/kernel/irq.c
> @@ -15,8 +15,3 @@ void __init init_IRQ(void)
>         setup_smp_ipi();
>  #endif
>  }
> -
> -asmlinkage void __irq_entry csky_do_IRQ(struct pt_regs *regs)
> -{
> -       handle_arch_irq(regs);
> -}

Seems the previous code has lost old_regs save/restore?

+       struct pt_regs *old_regs;
+
+       irq_enter();
+       old_regs = set_irq_regs(regs);
+       handle_arch_irq(regs);
+       set_irq_regs(old_regs);
+       irq_exit();

> --
> 2.11.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
