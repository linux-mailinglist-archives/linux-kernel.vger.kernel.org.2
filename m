Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B279D42B465
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 07:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhJMFGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 01:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJMFGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:06:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B112BC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 22:04:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y3so4035037wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 22:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBWAKhyjvL0DEIOxax/tiNNCYCLY9aiBB6SJS4PnDRo=;
        b=ag4QfPXXGxacJzvKw8Y2T4uuWtNUx5P6CNkb7xbBaNJg8/RjPmPhanvsVdao3X2p5s
         cGwKpdkVDNefBg7vhGdk8uCYuHO5IIoiCdTcKUSVGAqBjqv+KOEJi5AiVdEV0MYMZW5I
         dQB3C/fG+DOmhaVZtwx75UDgvulS5SL+Br88dbYHINh2HXxfQSIrSiPfjDdpaPAXLydr
         sFy0UKGImkVrv6I828/w+MLrX7unXr/I3YX1C4e/IC9RVfyMIVkkzCffkZBlAZ+8b00D
         2PnGmGq8mvb5XezBBEcc34920t4Wmy9YL9ILed3T5Rl340/x7BrUEZ3Bpc46GklMY/Zl
         UXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBWAKhyjvL0DEIOxax/tiNNCYCLY9aiBB6SJS4PnDRo=;
        b=gSOhGMYDY6Q2cVRcKy86im+6jLAk3bMKOr1ry4Ceso0nCoc9rqiEvgLdEg43qPQ7ef
         9BzwgchHp+Vzc+1Y3gOTRF/Trj3cSC/eLjU0ZiOKdJMirhHrjcbyIi8fCttc+bN8xWgy
         EQ/bhFST/CzA/dOeJu8Jc/uoOVV0ScmE0aH7Ksjx8Ubx7k6g/8ky8B0v0A9+t7GES90z
         9maC/0EXtu8OEhZ6VatVs7XFzhfS3gn85YUcfQKXQREYAQLcZ7gVGo8qFdiS9c6TmarO
         sw/PquPGm7SgzG7/RkEk9wbPKUb+xMK2wfmUk9YQlLwN1L54qJboJhn5Fn8yT4jSG8Xp
         861A==
X-Gm-Message-State: AOAM531pH+OJBeK11Lj8U+mB12HRfebf4AKQwhpRhYyQdjGVCs/Zyqd+
        8GKGssYVwj3GEppZ9L/By62MVCCa02jE7cWptbvX4A==
X-Google-Smtp-Source: ABdhPJzoICAIfHQG/AMcUnPkuklmPbpFHoKeQzDPmSw+5K/ti0ZQraiP5gYUezuN6UrX/zQfcdgw56g4g3vTI5xmD9I=
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr10372804wmj.176.1634101459118;
 Tue, 12 Oct 2021 22:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org> <20211013012149.2834212-2-guoren@kernel.org>
In-Reply-To: <20211013012149.2834212-2-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 13 Oct 2021 10:34:07 +0530
Message-ID: <CAAhSdy3B9AtbeBrNoQJOBkmAcOR56s1WExGNPMXsSsF+38y8DA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] irqchip/sifive-plic: Add thead,c900-plic support
To:     Guo Ren <guoren@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 6:52 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> thead,c900-plic would mask IRQ with readl(claim), so it needn't
> mask/unmask which needed in RISC-V PLIC.
>
> When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED path, unnecessary mask
> operation would cause a blocking irq bug in thead,c900-plic. Because
> when IRQ is disabled in c900, writel(hwirq, claim) would be invalid.

This is a totally incorrect description.

Instead of this, the commit description should say the following:

1) The irq_mask/unmask() is used by handle_fasteoi_irq() is mostly
for ONESHOT irqs and there is no limitation in the RISC-V PLIC driver
due to use of irq_mask/unmask() callbacks. In fact, a lot of irqchip
drivers using handle_fasteoi_irq() also implement irq_mask/unmask().

2) The C9xx PLIC does not comply with the interrupt claim/completion
process defined by the RISC-V PLIC specification because C9xx PLIC
will mask an IRQ when it is claimed by PLIC driver (i.e. readl(claim) and
the IRQ will be unmasked upon completion by PLIC driver (i.e. writel(claim).
This behaviour breaks the handling of IRQS_ONESHOT by the generic
handle_fasteoi_irq() used in the PLIC driver.

3) This patch adds an errata fix for IRQS_ONESHOT handling on
C9xx PLIC by using irq_enable/disable() callbacks instead of
irq_mask/unmask().

In general, non-compliance of the C9xx PLIC should be treated as
an errata so please don't project it as a feature.

>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Atish Patra <atish.patra@wdc.com>
>
> ---
>
> Changes since V3:
>  - Rename "c9xx" to "c900"
>  - Add sifive_plic_chip and thead_plic_chip for difference
>
> Changes since V2:
>  - Add a separate compatible string "thead,c9xx-plic"
>  - set irq_mask/unmask of "plic_chip" to NULL and point
>    irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
>  - Add a detailed comment block in plic_init() about the
>    differences in Claim/Completion process of RISC-V PLIC and C9xx
>    PLIC.
> ---
>  drivers/irqchip/irq-sifive-plic.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index cf74cfa82045..5b806d823df7 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -166,7 +166,7 @@ static void plic_irq_eoi(struct irq_data *d)
>         writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
>  }
>
> -static struct irq_chip plic_chip = {
> +static struct irq_chip sifive_plic_chip = {
>         .name           = "SiFive PLIC",
>         .irq_mask       = plic_irq_mask,
>         .irq_unmask     = plic_irq_unmask,
> @@ -176,12 +176,24 @@ static struct irq_chip plic_chip = {
>  #endif
>  };
>

Please add a detailed comment block as described by point#2
above.

> +static struct irq_chip thead_plic_chip = {
> +       .name           = "T-Head PLIC",
> +       .irq_disable    = plic_irq_mask,
> +       .irq_enable     = plic_irq_unmask,
> +       .irq_eoi        = plic_irq_eoi,
> +#ifdef CONFIG_SMP
> +       .irq_set_affinity = plic_set_affinity,
> +#endif
> +};
> +
> +static struct irq_chip *def_plic_chip = &sifive_plic_chip;
> +
>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>                               irq_hw_number_t hwirq)
>  {
>         struct plic_priv *priv = d->host_data;
>
> -       irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> +       irq_domain_set_info(d, irq, hwirq, def_plic_chip, d->host_data,
>                             handle_fasteoi_irq, NULL, NULL);
>         irq_set_noprobe(irq);
>         irq_set_affinity(irq, &priv->lmask);
> @@ -390,5 +402,14 @@ static int __init plic_init(struct device_node *node,
>         return error;
>  }
>
> +static int __init thead_c900_plic_init(struct device_node *node,
> +               struct device_node *parent)
> +{
> +       def_plic_chip = &thead_plic_chip;
> +
> +       return plic_init(node, parent);
> +}
> +
>  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
>  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
> +IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", thead_c900_plic_init);
> --
> 2.25.1
>

Regards,
Anup
