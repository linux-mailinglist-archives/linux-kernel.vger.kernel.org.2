Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342044371D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhJVGiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhJVGh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:37:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC4C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 23:35:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so4932249pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 23:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Etr2b1BhsF/GbVEF28+ESptJncVbUwV68n7PbA8dyY=;
        b=aTJFUvx7aQuZfx34TN3pJYw8QpfRJ6GVXH5ED94CpG4VBLSpBQQGh6lfazS6KiksQB
         57Grcs5IJUCKN0vr70NJrp9BtshcZcd+9XmQ6CjmhZ8+VBFGdljzCd8Yl/BJxvBAjfAf
         5gKM3lxkG2LcX1AQa4MPEoApYp9yyowYHKQWtwFI279Gf2LhH+ovS3gE/S1J+5IzxpfH
         MiFFmxohVjzPZWGolUJGA+YSkpq04oomVV9X9X6UZewEPAFuLX8WOm217L552iCu8gjN
         e8rZnOMgRXBsagdg6VsNaz4HuCTEtUUPkj1Cx0x/n9yXn24IoeOTHz8+5IatrmcKLmBg
         InmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Etr2b1BhsF/GbVEF28+ESptJncVbUwV68n7PbA8dyY=;
        b=sXLDnqcj7CFrQi8y+ZRutNwwieK/noRy9VviXJqDnwkGVP++2d/VDf4SlMKPHi4xXe
         ++8FCr4UA/p4FM4TtiORB2xPfiN7ZbYm1321R4+hcK8m894px103sfvAAvKvwGhzYvR9
         2v2eAkaps8Yrn3fMqR9EaHk3wncGGnFxP4mq5T7fCaPvNQh90I9BMhzvjF+Up4aoabgW
         8U6c9O1yk1xPWh3U4qUSU/mZvSh5XeNgeM8CAmcI/zuLBcS1OAhC4BzTHrf4HTL3ef+7
         n+laTKN0bzn3RWJje5X7nUQgiqOFddjKZnaMbGD9oaBvLWAsfdPNouZEVskeKUyLSPjE
         bsTw==
X-Gm-Message-State: AOAM532iBYsGI0rLG/wFTr8BVvZR6BgQ8hZQvpUMEnLGfpkLkXGlQIXZ
        girI3Vl5BzTsWXNwLU4zN4YPPN31vKwhSm+1fSE=
X-Google-Smtp-Source: ABdhPJwA6NaSO/m4Fz3GcUmDbjeJZ68GGYz9oMrd4HBvvo8hjcJU5iqMNVTkW17pBu4203EwT2pVj1vOkGF7L4qqhso=
X-Received: by 2002:a17:902:e74a:b0:13f:3538:fca0 with SMTP id
 p10-20020a170902e74a00b0013f3538fca0mr9595878plf.22.1634884542351; Thu, 21
 Oct 2021 23:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211021180236.37428-1-mark.rutland@arm.com> <20211021180236.37428-8-mark.rutland@arm.com>
In-Reply-To: <20211021180236.37428-8-mark.rutland@arm.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 22 Oct 2021 14:35:05 +0800
Message-ID: <CAEbi=3cXRuXzViYODk_pHjCBkNSiYZBqB0TO5pFEAfGcPanVug@mail.gmail.com>
Subject: Re: [PATCH 07/15] irq: nds32: avoid CONFIG_HANDLE_DOMAIN_IRQ
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guo Ren <guoren@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        kernelfans@gmail.com, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>, maz@kernel.org,
        Nickhu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        vgupta@kernel.org, Will Deacon <will@kernel.org>,
        Alan Kao <alankao@andestech.com>,
        =?UTF-8?B?Sy5DLiBLdWVuLUNoZXJuIExpbijmnpflnaTmiJAp?= 
        <kclin@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=882:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
> In preparation for removing HANDLE_DOMAIN_IRQ, have arch/nds32 perform
> all the necessary IRQ entry accounting in its entry code.
>
> Currently arch/nds32 is tightly coupled with the ativic32 irqchip, and
> while the entry code should logically live under arch/nds32/, moving the
> entry logic there makes things more convoluted. So for now, place the
> entry logic in the ativic32 irqchip, but separated into a separate
> function to make the split of responsibility clear.
>
> In future this should probably use GENERIC_IRQ_MULTI_HANDLER to cleanly
> decouple this.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vincent Chen <deanbo422@gmail.com>
> ---
>  arch/nds32/Kconfig             |  1 -
>  drivers/irqchip/irq-ativic32.c | 22 ++++++++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
> index aea26e739543..4d1421b18734 100644
> --- a/arch/nds32/Kconfig
> +++ b/arch/nds32/Kconfig
> @@ -27,7 +27,6 @@ config NDS32
>         select GENERIC_LIB_MULDI3
>         select GENERIC_LIB_UCMPDI2
>         select GENERIC_TIME_VSYSCALL
> -       select HANDLE_DOMAIN_IRQ
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_DEBUG_KMEMLEAK
>         select HAVE_EXIT_THREAD
> diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic3=
2.c
> index 476d6024aaf2..223dd2f97d28 100644
> --- a/drivers/irqchip/irq-ativic32.c
> +++ b/drivers/irqchip/irq-ativic32.c
> @@ -5,11 +5,14 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
> +#include <linux/hardirq.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqdomain.h>
>  #include <linux/irqchip.h>
>  #include <nds32_intrinsic.h>
>
> +#include <asm/irq_regs.h>
> +
>  unsigned long wake_mask;
>
>  static void ativic32_ack_irq(struct irq_data *data)
> @@ -103,10 +106,25 @@ static irq_hw_number_t get_intr_src(void)
>                 - NDS32_VECTOR_offINTERRUPT;
>  }
>
> -asmlinkage void asm_do_IRQ(struct pt_regs *regs)
> +static void ativic32_handle_irq(struct pt_regs *regs)
>  {
>         irq_hw_number_t hwirq =3D get_intr_src();
> -       handle_domain_irq(root_domain, hwirq, regs);
> +       generic_handle_domain_irq(root_domain, hwirq);
> +}
> +
> +/*
> + * TODO: convert nds32 to GENERIC_IRQ_MULTI_HANDLER so that this entry l=
ogic
> + * can live in arch code.
> + */
> +asmlinkage void asm_do_IRQ(struct pt_regs *regs)
> +{
> +       struct pt_regs *old_regs;
> +
> +       irq_enter();
> +       old_regs =3D set_irq_regs(regs);
> +       ativic32_handle_irq(regs);
> +       set_irq_regs(old_regs);
> +       irq_exit();
>  }
>
>  int __init ativic32_init_irq(struct device_node *node, struct device_nod=
e *parent)
> --
> 2.11.0
>

Loop in Alan and KC.
