Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF22E3B4628
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhFYO4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhFYO4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:56:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E4EF6196C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624632861;
        bh=4E0gJHmVQf3DAdKTz9RRWsCyT2UriHYgkJuXFju6qwk=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=sog8FFB9PdbR5HbctvZVXYwWmuL0bq1kf0vf5igVUFJuRuhpCuluyFbUnjj57529Y
         JeGX7GkW+J4AHjNR0RtLMEDgj9aJ5nn4HIVKqXHgsH2KfDrtJK/v2nArF68jsAPA3M
         ZQEXQhC1MrwC58VW2TkZPjrDck4qpDE3Quy6Y9urdBFakjrdQLUftI5HpG+3gbXhm5
         LeFozQ/YdTTq8QJcNa8Rck21UfabXDKK1n9uohFE/PK4On6GPLTMZnzj3VJZn1uZNp
         dXWhfx6co6BT/9O4AAwd4bGAd17Qpc7iwD2t4PB6r7eDVglq6sHNUbtpbuaRlMAgRV
         wYNkJFshDxH9Q==
Received: by mail-lj1-f173.google.com with SMTP id q4so4494856ljp.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 07:54:21 -0700 (PDT)
X-Gm-Message-State: AOAM532haIkE+c/RGrJ7bAXwyePllRanHcSj1M5omytsXMD7ZiFz63cE
        PbEr92QQSRGLN6BQn9CMnfe7MKsmu4zZgQyBDSE=
X-Google-Smtp-Source: ABdhPJxrHnBWtk/8r5JziuSDB7JQedMAzgB4dDImce2eOUZ634eYmmPW1uIOpI7KWR41HQn91xgscPrMR2ghq94rJwY=
X-Received: by 2002:a2e:9ac3:: with SMTP id p3mr8915246ljj.94.1624632859618;
 Fri, 25 Jun 2021 07:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org> <1604317487-14543-8-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1604317487-14543-8-git-send-email-sumit.garg@linaro.org>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Fri, 25 Jun 2021 22:54:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v67yfWbRA4MNa2f+pAJAyiEqeCaREziaPjvGcDzTw5Za=A@mail.gmail.com>
Message-ID: <CAGb2v67yfWbRA4MNa2f+pAJAyiEqeCaREziaPjvGcDzTw5Za=A@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] arm64: kgdb: Roundup cpus using IPI as NMI
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        daniel.thompson@linaro.org, Mark Rutland <mark.rutland@arm.com>,
        tsbogend@alpha.franken.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>, ito-yuichi@fujitsu.com,
        mpe@ellerman.id.au, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>, mingo@redhat.com,
        bp@alien8.de, julien.thierry.kdev@gmail.com,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        Thomas Gleixner <tglx@linutronix.de>, msys.mizuma@gmail.com,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 2, 2020 at 7:47 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> arm64 platforms with GICv3 or later supports pseudo NMIs which can be
> leveraged to roundup CPUs which are stuck in hard lockup state with
> interrupts disabled that wouldn't be possible with a normal IPI.
>
> So instead switch to roundup CPUs using IPI turned as NMI. And in
> case a particular arm64 platform doesn't supports pseudo NMIs,
> it will switch back to default kgdb CPUs roundup mechanism.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/kernel/ipi_nmi.c |  5 +++++
>  arch/arm64/kernel/kgdb.c    | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> index 597dcf7..898d69c 100644
> --- a/arch/arm64/kernel/ipi_nmi.c
> +++ b/arch/arm64/kernel/ipi_nmi.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/kgdb.h>
>  #include <linux/nmi.h>
>  #include <linux/smp.h>
>
> @@ -45,10 +46,14 @@ bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>  static irqreturn_t ipi_nmi_handler(int irq, void *data)
>  {
>         irqreturn_t ret = IRQ_NONE;
> +       unsigned int cpu = smp_processor_id();
>
>         if (nmi_cpu_backtrace(get_irq_regs()))
>                 ret = IRQ_HANDLED;
>
> +       if (!kgdb_nmicallback(cpu, get_irq_regs()))

This fails to compile if CONFIG_KGDB isn't enabled.


ChenYu


> +               ret = IRQ_HANDLED;
> +
>         return ret;
>  }
>
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 1a157ca3..371b176 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -17,6 +17,7 @@
>
>  #include <asm/debug-monitors.h>
>  #include <asm/insn.h>
> +#include <asm/nmi.h>
>  #include <asm/traps.h>
>
>  struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
> @@ -353,3 +354,20 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>         return aarch64_insn_write((void *)bpt->bpt_addr,
>                         *(u32 *)bpt->saved_instr);
>  }
> +
> +void kgdb_roundup_cpus(void)
> +{
> +       struct cpumask mask;
> +
> +       if (!arm64_supports_nmi()) {
> +               kgdb_smp_call_nmi_hook();
> +               return;
> +       }
> +
> +       cpumask_copy(&mask, cpu_online_mask);
> +       cpumask_clear_cpu(raw_smp_processor_id(), &mask);
> +       if (cpumask_empty(&mask))
> +               return;
> +
> +       arm64_send_nmi(&mask);
> +}
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
