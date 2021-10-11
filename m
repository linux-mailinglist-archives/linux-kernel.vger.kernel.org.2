Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E3A4292C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhJKPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbhJKPEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:04:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5571C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:02:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y3so24115590wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVndUYssrhT1+TAmUJh5faXD018hrwwoKVlYhzJy80Q=;
        b=FasKWF+h3LWJMaLN9s630gc2WwMKFbazr2bx1CBPqgeqwfOwdjCMhq/eJK01cwpTAJ
         gB8eBvjRtQ7DrkC1Pw7bEukO2eMxmZmV7FhMS+skZ52kcwWF5sWZje0+PMK2g6GyB8Ka
         TqkHo+8i+n7NaNRdpF3aWWvcutEamrnuFNpTujN2YpbK6Jj8d1X8jYvKECFZbeyM4Z8s
         NCefVt60WsaJtrUa3kpAlqlf6AERtFxyn8FdgkLfRhEwm59XGqk6jfzG7v25CnfrNhCI
         2Wkf5d7Dred82bLPRErYscWqFyOMb1VIdZt3tZPtF05D4GU4KSdxxbWFqDihZHcAQE9u
         tdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVndUYssrhT1+TAmUJh5faXD018hrwwoKVlYhzJy80Q=;
        b=cWGciFhTaCx10fUmCjTwGnfwcm/80K8w5Uo77vqZyCjhf0KU6/0BY3CWBktdGRvQbn
         Kq+76tVL71nvpED1MB9wWptstftD/Azrizxfw06s6jm7ZbJJukH7MAXTYRH5iU9BNb5E
         kGHVLWy2SUte19RxvAZ7Ws6A3uj7XAIRMaSlWCta8Mwo2glrBdj5NFxSJIDYQMjwNyKs
         ssQv0cunMC6aZbBUP1A74s4ffFRw+9iAsT1vJcraDDPyDjH5bUHiYGaWOBNYoAnhC1as
         IELeoVwHXOUdSBcbFLGSPzLB3sgM0FSgztiPQWhQ5SU995KletoGFiQVKRWs6WOKSx47
         qHHg==
X-Gm-Message-State: AOAM530zs4kVBXl1z2qW1a7Wh5u9OiqEIo5KUnJMQ8Wlq3ODIrEvk6/0
        M0gjSGOCEVZP3At3kigXZ55skcXTGjZinYruxbGbQJqYjY0=
X-Google-Smtp-Source: ABdhPJzLl/vVPAkLeynPMkJbCDqObfBfXCwKXMgwbPIBrrMIJpi3K/CBDE3cWw6gazA8Yyn82prufGMxb89OHd2ycRg=
X-Received: by 2002:a05:6000:1acc:: with SMTP id i12mr24854107wry.249.1633964523086;
 Mon, 11 Oct 2021 08:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211011132431.2792797-1-guoren@kernel.org>
In-Reply-To: <20211011132431.2792797-1-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 11 Oct 2021 20:31:51 +0530
Message-ID: <CAAhSdy1xjRE0TJ_Nd9fdz4RAK2J5FskQYbWDVXO7jhfcZsFm_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/sifive-plic: Fix duplicate mask/unmask for claim/complete
To:     Guo Ren <guoren@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 6:54 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> PLIC only has enable-registers not mask/unmask registers. Mixing
> mask/unmask with irq_eoi is wrong, because readl(claim) could mask

This is an incorrect assumption about readl(claim). When SW does
read(claim) the HW updates internal state that IRQ has been claimed.
The HW can still get same (already claimed) IRQ again before
writel(claim) which will be delivered after writel(claim).

> irq by hardware. We only need mask/unmask to fixup the hardware
> which couldn't claim + mask correctly.

The handle_fasteoi_irq() only calls unmask_irq() mostly when the
underlying IRQ is threaded. Is there any other case ?

Another fact is that all irqchip drivers using handle_fasteoi_irq()
implement irq_mask/unmask().

Regards,
Anup

>
> If hardware supports claim + mask, it would cause unnecessary
> mask/umak operations.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index cf74cfa82045..0fa46912f452 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -64,6 +64,7 @@ struct plic_priv {
>         struct cpumask lmask;
>         struct irq_domain *irqdomain;
>         void __iomem *regs;
> +       bool claim_mask_support;
>  };
>
>  struct plic_handler {
> @@ -111,7 +112,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
>         }
>  }
>
> -static void plic_irq_unmask(struct irq_data *d)
> +static void plic_irq_enable(struct irq_data *d)
>  {
>         struct cpumask amask;
>         unsigned int cpu;
> @@ -125,7 +126,7 @@ static void plic_irq_unmask(struct irq_data *d)
>         plic_irq_toggle(cpumask_of(cpu), d, 1);
>  }
>
> -static void plic_irq_mask(struct irq_data *d)
> +static void plic_irq_disable(struct irq_data *d)
>  {
>         struct plic_priv *priv = irq_data_get_irq_chip_data(d);
>
> @@ -168,8 +169,8 @@ static void plic_irq_eoi(struct irq_data *d)
>
>  static struct irq_chip plic_chip = {
>         .name           = "SiFive PLIC",
> -       .irq_mask       = plic_irq_mask,
> -       .irq_unmask     = plic_irq_unmask,
> +       .irq_enable     = plic_irq_enable,
> +       .irq_disable    = plic_irq_disable,
>         .irq_eoi        = plic_irq_eoi,
>  #ifdef CONFIG_SMP
>         .irq_set_affinity = plic_set_affinity,
> @@ -181,6 +182,11 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>  {
>         struct plic_priv *priv = d->host_data;
>
> +       if (!priv->claim_mask_support) {
> +               plic_chip.irq_mask      = plic_irq_disable;
> +               plic_chip.irq_unmask    = plic_irq_enable;
> +       }
> +
>         irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
>                             handle_fasteoi_irq, NULL, NULL);
>         irq_set_noprobe(irq);
> @@ -298,6 +304,8 @@ static int __init plic_init(struct device_node *node,
>         if (WARN_ON(!nr_contexts))
>                 goto out_iounmap;
>
> +       priv->claim_mask_support = of_property_read_bool(node, "claim-mask-support");
> +
>         error = -ENOMEM;
>         priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
>                         &plic_irqdomain_ops, priv);
> --
> 2.25.1
>
