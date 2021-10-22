Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97543700C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhJVCgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231518AbhJVCgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:36:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71A0161409
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634870045;
        bh=S30f/+4VZLDl1PWHOF5O1gKoF4vRAQfxCHgNTi38Jjc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TcBj99OyD6zWF3UwXNFRErx0LcXWJ57hWLCAODhAwPN6kY0KPhyGt21FAMPg1GZl3
         pzj8LGVJ1PNHo5dBfsUhGMqkl+YPLS8DPL5+cCJaaJilShS3WuLiANd0JHZOdlZdtO
         f8N/IQVGM5SZ6+h8P+UHxSvVyLWG5yWeSWMF+ypSav4rLK5oCWl6LtTMMUSki0fBxy
         lOq9fUns4i7EN9kbED2E/rNXGQx+mew4oOVbyx2Z9/Nno5cj94g3uqYvBbaEBRgiV3
         Q9QwLKPoPZjsKPJtf14vst6AfEmWH88h58srGo1tE9yLgOTea6tAwJWjcVto6rOGBJ
         4ZwU1WzPgCITA==
Received: by mail-ua1-f53.google.com with SMTP id u5so4912860uao.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:34:05 -0700 (PDT)
X-Gm-Message-State: AOAM530QblCTitzkz7gpBmajVpRvfDGMVfxAXlTBnVkgffBaOfvWXJ5q
        2sPm85hb3AKVuoKHe5evaFtNE/gHO9EKA+czAG8=
X-Google-Smtp-Source: ABdhPJy/gyI83O9ILS2ZQF4EyRY5my4JsnhH7AcK0SI5BOBkb/f1C1jqqt5MBh/7WO98B6H39eooKYLw5GLQaGG8CAc=
X-Received: by 2002:a67:ca1c:: with SMTP id z28mr11938388vsk.11.1634870044525;
 Thu, 21 Oct 2021 19:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211021180236.37428-1-mark.rutland@arm.com> <20211021180236.37428-6-mark.rutland@arm.com>
In-Reply-To: <20211021180236.37428-6-mark.rutland@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 22 Oct 2021 10:33:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTShTh5be3SxaVwAzbXTb=LZi-qfweXBvyLeg9TyKgfLNg@mail.gmail.com>
Message-ID: <CAJF2gTShTh5be3SxaVwAzbXTb=LZi-qfweXBvyLeg9TyKgfLNg@mail.gmail.com>
Subject: Re: [PATCH 05/15] irq: add generic_handle_arch_irq()
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
> Several architectures select GENERIC_IRQ_MULTI_HANDLER and branch to
> handle_arch_irq() without performing any entry accounting.
>
> Add a generic wrapper to handle the commoon irqentry work when invoking
> handle_arch_irq(). Where an architecture needs to perform some entry
> accounting itself, it will need to invoke handle_arch_irq() itself.
>
> In subsequent patches it will become the responsibilty of the entry code
> to set the irq regs when entering an IRQ (rather than deferring this to
> an irqchip handler), so generic_handle_arch_irq() is made to set the irq
> regs now. This can be redundant in some cases, but is never harmful as
> saving/restoring the old regs nests safely.
Shall we remove old_regs save/restore in handle_domain_irq? It's duplicated.

>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/handle.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index 221d80c31e94..27182003b879 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -14,6 +14,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel_stat.h>
>
> +#include <asm/irq_regs.h>
> +
>  #include <trace/events/irq.h>
>
>  #include "internals.h"
> @@ -226,4 +228,20 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>         handle_arch_irq = handle_irq;
>         return 0;
>  }
> +
> +/**
> + * generic_handle_arch_irq - root irq handler for architectures which do no
> + *                           entry accounting themselves
> + * @regs:      Register file coming from the low-level handling code
> + */
> +asmlinkage void noinstr generic_handle_arch_irq(struct pt_regs *regs)
> +{
> +       struct pt_regs *old_regs;
> +
> +       irq_enter();
> +       old_regs = set_irq_regs(regs);
> +       handle_arch_irq(regs);
> +       set_irq_regs(old_regs);
> +       irq_exit();
> +}
>  #endif
> --
> 2.11.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
