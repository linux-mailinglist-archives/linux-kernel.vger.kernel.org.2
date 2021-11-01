Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389D5441BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhKANtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:49:43 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:37478 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231828AbhKANtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:49:42 -0400
Received: from iva2-4b68470c0b40.qloud-c.yandex.net (iva2-4b68470c0b40.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:1409:0:640:4b68:470c])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 86C4D45C4585;
        Mon,  1 Nov 2021 16:47:07 +0300 (MSK)
Received: from iva1-dcde80888020.qloud-c.yandex.net (2a02:6b8:c0c:7695:0:640:dcde:8088 [2a02:6b8:c0c:7695:0:640:dcde:8088])
        by iva2-4b68470c0b40.qloud-c.yandex.net (mxback/Yandex) with ESMTP id J3jYM5vWaW-l6EK0A90;
        Mon, 01 Nov 2021 16:47:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1635774427;
        bh=962D/PuwhXZcYiC076wE1wmjc0fGppTG5dBkdPxfivw=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID:Cc;
        b=E47ZEfNJIbWeG0JpbkXEFQvK+xQjrvlLF6n0u+aHGDF4KkBHMpCOwemuzs6tyF/La
         X70OC0bONK3wt4d4ek75KZKEbvX27v4GU+RLsif79UWoO1LKgDuAHwtmQD4MEnjf33
         9CA8d9lc22csWzGZZFXVBJ2g9474oagCckCaExOI=
Authentication-Results: iva2-4b68470c0b40.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva1-dcde80888020.qloud-c.yandex.net (smtp/Yandex) with ESMTPS id Srg9LL8h3E-l5M4RZm3;
        Mon, 01 Nov 2021 16:47:05 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Date:   Mon, 1 Nov 2021 16:47:05 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, atish.patra@wdc.com, maz@kernel.org,
        tglx@linutronix.de, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH V6] irqchip/sifive-plic: Fixup EOI failed when masked
Message-ID: <20211101164705.4e07fdb9@redslave.neermore.group>
In-Reply-To: <20211101131736.3800114-1-guoren@kernel.org>
References: <20211101131736.3800114-1-guoren@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Nov 2021 21:17:36 +0800
guoren@kernel.org wrote:

Hi Guo Ren,

Thank you for your patch.

May be it should be applied to stable ?

Tested-by: Nikita Shubin <nikita.shubin@maquefel.me>

> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the
> driver, only the first interrupt could be handled, and continue irq
> is blocked by hw. Because the riscv plic couldn't complete masked irq
> source which has been disabled in enable register. The bug was
> firstly reported in [1].
> 
> Here is the description of Interrupt Completion in PLIC spec [2]:
> 
> The PLIC signals it has completed executing an interrupt handler by
> writing the interrupt ID it received from the claim to the
> claim/complete register. The PLIC does not check whether the
> completion ID is the same as the last claim ID for that target. If
> the completion ID does not match an interrupt source that is
> currently enabled for the target, the ^^ ^^^^^^^^^ ^^^^^^^
> completion is silently ignored.
> 
> [1]
> http://lists.infradead.org/pipermail/linux-riscv/2021-July/007441.html
> [2]
> https://github.com/riscv/riscv-plic-spec/blob/8bc15a35d07c9edf7b5d23fec9728302595ffc4d/riscv-plic.adoc
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
> diff --git a/drivers/irqchip/irq-sifive-plic.c
> b/drivers/irqchip/irq-sifive-plic.c index cf74cfa82045..259065d271ef
> 100644 --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -163,7 +163,13 @@ static void plic_irq_eoi(struct irq_data *d)
>  {
>  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>  
> -	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +	if (irqd_irq_masked(d)) {
> +		plic_irq_unmask(d);
> +		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +		plic_irq_mask(d);
> +	} else {
> +		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +	}
>  }
>  
>  static struct irq_chip plic_chip = {

