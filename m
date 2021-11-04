Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F01445585
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhKDOny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhKDOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC34C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:40:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso7374270wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyuCyLm/+Cp5VpSzLU2JwivIu6Iv13snX4mcokUnZ4Y=;
        b=SH3ndSYCP/bHAlWNLB1MbaFI/72dBEASUdlQQ7eJxe3gDQjJ/KMiAznjkZ2K3Lp71D
         lXi8E2AWj6iCyasDkgwWggsuB8+juIwv2Ovz4Bna3ia7l2GW2PBZziH9VE8W9a6wQ8u0
         iAJBzdnxV2J5vdkBrTaH2Q93YPiV21zj4o02ZO/RmbI/qwFgnMBoHC+0BUW5PVdGu9kE
         lo77XFrM+j4F/dizCnoVAdFIu/q4RNadLRH7bjPlg+z9rOZstoNoaceX2JFsa/xCayy+
         8iKFsawG2559lItA7JCsqIQaelr0nBWrTVw+Plt79HoL+79Hy+g3gsUiIJuX/xwMab/M
         ezFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyuCyLm/+Cp5VpSzLU2JwivIu6Iv13snX4mcokUnZ4Y=;
        b=lUeB5PIqVcCD31MqlqROCt4oonoDv4b5YqmmvBDkYIPi2aShQUpwgKSAugNV7afp0h
         6JW+QYkDkCjC6+x5j3tyilJE5hj82EYy7KCX8PP9rNZ6eFmGiZUZfg8HcNQ8O4lr8iKy
         MXHtG+T7jmQX2S+SR2n9vQVxyRzCBxTashlkEnmrFmrTzIETDhK1sjOU95OJC+z2SaKC
         RJmAiGBxOOlqeeqgzPJUS7L1pnGuiT9MUzQVwj5uLzTVsgHjkg4ipxWrU0S94kGmS36V
         BCMrnrpXO9LSOPbaMr1DN1kQK4LEjWhbhJepb4MKhYRYV/Buv8ztJBASi7UhuYWk9w8/
         B0qg==
X-Gm-Message-State: AOAM531Y/C9sZviS8DFcZzqhdtTeqfaORUUP3WlAjjf/DRNIjv5P639p
        shrd8uJqMCkVbclJoydm4rI5dQigRPURafpDyKTIVQ==
X-Google-Smtp-Source: ABdhPJxPqhtBmS9Ugwa8o1VEJiVrNuUxJgAEgguDvhGyQ6C+AmAYClWzPJC7tg5ZeC+IFaftXrt709GPGeY6jpuz1Io=
X-Received: by 2002:a1c:20cc:: with SMTP id g195mr15471504wmg.137.1636036854247;
 Thu, 04 Nov 2021 07:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211101131736.3800114-1-guoren@kernel.org>
In-Reply-To: <20211101131736.3800114-1-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 4 Nov 2021 20:10:42 +0530
Message-ID: <CAAhSdy29qhF4JHuMOqwctn+=HQNBbR3X0gsymqD8OAF1pXE43A@mail.gmail.com>
Subject: Re: [PATCH V6] irqchip/sifive-plic: Fixup EOI failed when masked
To:     Guo Ren <guoren@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 6:47 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the driver,
> only the first interrupt could be handled, and continue irq is blocked by
> hw. Because the riscv plic couldn't complete masked irq source which has
> been disabled in enable register. The bug was firstly reported in [1].
>
> Here is the description of Interrupt Completion in PLIC spec [2]:
>
> The PLIC signals it has completed executing an interrupt handler by
> writing the interrupt ID it received from the claim to the claim/complete
> register. The PLIC does not check whether the completion ID is the same
> as the last claim ID for that target. If the completion ID does not match
> an interrupt source that is currently enabled for the target, the
>                          ^^ ^^^^^^^^^ ^^^^^^^
> completion is silently ignored.
>
> [1] http://lists.infradead.org/pipermail/linux-riscv/2021-July/007441.html
> [2] https://github.com/riscv/riscv-plic-spec/blob/8bc15a35d07c9edf7b5d23fec9728302595ffc4d/riscv-plic.adoc
>
> Reported-by: Vincent Pelletier <plr.vincent@gmail.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Nikita Shubin <nikita.shubin@maquefel.me>
> Cc: incent Pelletier <plr.vincent@gmail.com>

Please include a Fixes: tag

Also, I see that you have dropped the DT bindings patch. We still
need separate compatible string for T-HEAD PLIC because OpenSBI
will use it for other work-arounds.

I suggest to include to more patches in this series:
1) Your latest T-HEAD PLIC DT bindings patch
2) Separate patch to use T-HEAD PLIC compatible in PLIC driver

Regards,
Anup

>
> ---
>
> Changes since V6:
>  - Propagate to plic_irq_eoi for all riscv,plic by Nikita Shubin
>  - Remove thead related codes
>
> Changes since V5:
>  - Move back to mask/unmask
>  - Fixup the problem in eoi callback
>  - Remove allwinner,sun20i-d1 IRQCHIP_DECLARE
>  - Rewrite comment log
>
> Changes since V4:
>  - Update comment by Anup
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
>  drivers/irqchip/irq-sifive-plic.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index cf74cfa82045..259065d271ef 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -163,7 +163,13 @@ static void plic_irq_eoi(struct irq_data *d)
>  {
>         struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>
> -       writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +       if (irqd_irq_masked(d)) {
> +               plic_irq_unmask(d);
> +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +               plic_irq_mask(d);
> +       } else {
> +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +       }
>  }
>
>  static struct irq_chip plic_chip = {
> --
> 2.25.1
>
