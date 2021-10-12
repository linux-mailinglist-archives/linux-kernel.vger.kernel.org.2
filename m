Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7F042A9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 18:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhJLQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLQml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 12:42:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E03AC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 09:40:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u18so68922400wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 09:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyQ0FnQ11AjdF2tqrPUXu5b7mdoj6pFrq0SdLPzJPkw=;
        b=rGHKljQqqx6UUOEcCaCWB0mvux/wtJzhPa0mghK9VK59QDdZPMz+EFlcsGbt4sNk6I
         dyldHIawBSm6ujxvuZQgJCz0zMNfCvOKL4zgkMjVYJSKoYONsRcTxTZCi9AQa93iuJho
         hfGhw74lHfAaNG0aF3VIVCN5W1cISpGNmyb3zpexwL3FOnoxpaQvoNZeOqBzbEUhIB8Q
         76l5LY7ol3rFh1MLE3P8JOdFCrq9CnLEvd6y88QbBm3TmD48mTL6R3XviQQlA3TUhz/L
         21s2u3NFXKUpgikwV0d0bd0nWuBMwOs94/5Fi4bWjuAT+NDi8u//Eco6c600cpOLUiM6
         n0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyQ0FnQ11AjdF2tqrPUXu5b7mdoj6pFrq0SdLPzJPkw=;
        b=o6wCOCqdg25/qReH/UAhiUBc2OISP59FSX6g3K4nvK+vOwussMhj1Wr0WWfRRSRZS3
         tRYbMq+mDG61bzykniYWyItm4GBHFZlMULwtxw2M2TQzh7GuGEF6/X+tFS9GRGqIineV
         x2zVEy6rpLHY7JoPsKE4QV4XfmLodUWXhBEG1WNxZCfNdCE6y2rB9ajw3RFoo8wdXyr0
         w+clGpvidn66r41Ymq086HqybqkrNi7s4etwKZIPUWCE9q48SVkaj8yXnufFUBIUgpJT
         Hd1OYTnqeSzsn7sVmd278GOvCpXgXbn3pBY3JB4H4k1Owpn2Wr30usAG0eMpo84ddAiV
         B6sw==
X-Gm-Message-State: AOAM530XbUjxbKULA9OLPNuhh8OgBuzEAQ2RTQMDaDV1CTZcJMq4AdlK
        bV84931C2epNioCwBx9gtBWM3P9oSo1mhBK5FouELg==
X-Google-Smtp-Source: ABdhPJwz57L/hHGultmk7g4qhHuJAITX4mG0H7WBkqWl+rfltPL7ZABp7P53IBf5A2LbjaPfp5hc8flDHi7u07YjGAA=
X-Received: by 2002:adf:ab57:: with SMTP id r23mr34064613wrc.199.1634056837790;
 Tue, 12 Oct 2021 09:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211012153432.2817285-1-guoren@kernel.org> <20211012153432.2817285-2-guoren@kernel.org>
In-Reply-To: <20211012153432.2817285-2-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 12 Oct 2021 22:10:26 +0530
Message-ID: <CAAhSdy32wkwH5k3iwdUNDsXjUNX8icQwcz_h2E6UixH7ZmD5KQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] irqchip/sifive-plic: Add thead,c9xx-plic support
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

On Tue, Oct 12, 2021 at 9:04 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> thead,c9xx-plic would mask IRQ with readl(claim), so it needn't
> mask/unmask which needed in RISC-V PLIC.
>
> When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED path, unnecessary mask
> operation would cause a blocking irq bug in thead,c9xx-plic. Because
> when IRQ is disabled in c9xx, writel(hwirq, claim) would be invalid.
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
> Changes since V2:
>  - Add a separate compatible string "thead,c9xx-plic"
>  - set irq_mask/unmask of "plic_chip" to NULL and point
>    irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
>  - Add a detailed comment block in plic_init() about the
>    differences in Claim/Completion process of RISC-V PLIC and C9xx
>    PLIC.
> ---
>  drivers/irqchip/irq-sifive-plic.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index cf74cfa82045..3756b1c147c3 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -79,6 +79,7 @@ struct plic_handler {
>  };
>  static int plic_parent_irq __ro_after_init;
>  static bool plic_cpuhp_setup_done __ro_after_init;
> +static bool disable_mask_unmask __ro_after_init;
>  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
>
>  static inline void plic_toggle(struct plic_handler *handler,
> @@ -181,6 +182,13 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>  {
>         struct plic_priv *priv = d->host_data;
>
> +       if (disable_mask_unmask) {
> +               plic_chip.irq_mask      = NULL;
> +               plic_chip.irq_unmask    = NULL;
> +               plic_chip.irq_enable    = plic_irq_unmask;
> +               plic_chip.irq_disable   = plic_irq_mask;
> +       }
> +
>         irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
>                             handle_fasteoi_irq, NULL, NULL);
>         irq_set_noprobe(irq);
> @@ -390,5 +398,14 @@ static int __init plic_init(struct device_node *node,
>         return error;
>  }
>
> +static int __init thead_c9xx_plic_init(struct device_node *node,
> +               struct device_node *parent)
> +{
> +       disable_mask_unmask = true;

The plic_irqdomain_map() is called for each irq so "plic_chip"
will be updated multiple times.

You can drop the disable_mask_unmask variable and instead
directly update "plic_chip" here.

> +
> +       return plic_init(node, parent);
> +}
> +
>  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
>  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
> +IRQCHIP_DECLARE(thead_c9xx_plic, "thead,c9xx-plic", thead_c9xx_plic_init);
> --
> 2.25.1
>

Regards,
Anup
