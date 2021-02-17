Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20831D955
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhBQMXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:23:03 -0500
Received: from foss.arm.com ([217.140.110.172]:57836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232385AbhBQMWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:22:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 246671042;
        Wed, 17 Feb 2021 04:22:07 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.46.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 630103F694;
        Wed, 17 Feb 2021 04:22:03 -0800 (PST)
Date:   Wed, 17 Feb 2021 12:22:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/25] arm64: Always keep DAIF.[IF] in sync
Message-ID: <20210217122200.GC5556@C02TD0UTHF1T.local>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-9-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-9-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

On Mon, Feb 15, 2021 at 09:16:56PM +0900, Hector Martin wrote:
> Apple SoCs (A11 and newer) have some interrupt sources hardwired to the
> FIQ line. We implement support for this by simply treating IRQs and FIQs
> the same way in the interrupt vectors.
> 
> To support these systems, the FIQ mask bit needs to be kept in sync with
> the IRQ mask bit, so both kinds of exceptions are masked together. No
> other platforms should be delivering FIQ exceptions right now, and we
> already unmask FIQ in normal process context, so this should not have an
> effect on other systems - if spurious FIQs were arriving, they would
> already panic the kernel.

Keeping these in sync sounds fine to me, FWIW.

> Root irqchip drivers can discriminate between IRQs and FIQs by checking
> the ISR_EL1 system register.

I think we can remove this note for now. If we go with seperate handlers
this won't be necessary, and if not this would be better placed on a
commit adding the FIQ handling capability.

> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  arch/arm64/include/asm/assembler.h |  6 +++---
>  arch/arm64/include/asm/daifflags.h |  4 ++--
>  arch/arm64/include/asm/irqflags.h  | 19 +++++++++++--------
>  arch/arm64/kernel/entry.S          |  6 +++---
>  4 files changed, 19 insertions(+), 16 deletions(-)

Judging by `git grep -Wi daif -- arch/arm64`, with this patch applied,
we'll also need fixups in:

* gic_arch_enable_irqs() in arch/arm64/include/asm/arch_gicv3.h
* save_and_disable_irq() in arch/arm64/include/asm/assembler.h (noted below)
* local_daif_save_flags() in arch/arm64/include/asm/daifflags.h
  (the fake DAIF should have F set too)
* __cpu_do_idle_irqprio() in arch/arm64/kernel/process.c

> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index bf125c591116..ac4c823bf2b6 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -40,9 +40,9 @@
>  	msr	daif, \flags
>  	.endm
>  
> -	/* IRQ is the lowest priority flag, unconditionally unmask the rest. */
> -	.macro enable_da_f
> -	msr	daifclr, #(8 | 4 | 1)
> +	/* IRQ/FIQ are the lowest priority flags, unconditionally unmask the rest. */
> +	.macro enable_da
> +	msr	daifclr, #(8 | 4)
>  	.endm

I think save_and_diable_irq below needs to be updated too, since it
only sets DAIF.I and leaves DAIF.F as-is.

[...]

> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index ff328e5bbb75..125201dced5f 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -12,15 +12,18 @@
>  
>  /*
>   * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
> - * FIQ exceptions, in the 'daif' register. We mask and unmask them in 'dai'
> + * FIQ exceptions, in the 'daif' register. We mask and unmask them in 'daif'
>   * order:
>   * Masking debug exceptions causes all other exceptions to be masked too/
> - * Masking SError masks irq, but not debug exceptions. Masking irqs has no
> - * side effects for other flags. Keeping to this order makes it easier for
> - * entry.S to know which exceptions should be unmasked.
> + * Masking SError masks IRQ/FIQ, but not debug exceptions. IRQ and FIQ are
> + * always masked and unmasked together, and have no side effects for other
> + * flags. Keeping to this order makes it easier for entry.S to know which
> + * exceptions should be unmasked.
>   *

This sounds good.

> - * FIQ is never expected, but we mask it when we disable debug exceptions, and
> - * unmask it at all other times.
> + * FIQ is never expected on most platforms, but we keep it synchronized
> + * with the IRQ mask status. On platforms that do not expect FIQ, that vector
> + * triggers a kernel panic. On platforms that do, the FIQ vector is unified
> + * with the IRQ vector.
>   */

Can we please delete this bit, though? Now that we say IRQ and FIQ are
masked/unmasked together, I don't think the rest is necessary to
understand the masking logic, and it's one less thing to keep in sync
with changes to the entry code.

Otherwise this looks good to me.

Thanks,
Mark.
