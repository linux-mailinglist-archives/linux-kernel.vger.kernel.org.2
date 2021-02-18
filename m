Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5231EB39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBRPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:04:51 -0500
Received: from marcansoft.com ([212.63.210.85]:58684 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232596AbhBRMxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:53:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 05A1C3FA55;
        Thu, 18 Feb 2021 12:51:42 +0000 (UTC)
To:     Mark Rutland <mark.rutland@arm.com>
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
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-9-marcan@marcan.st>
 <20210217122200.GC5556@C02TD0UTHF1T.local>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 08/25] arm64: Always keep DAIF.[IF] in sync
Message-ID: <e88fa913-e2ae-35d0-056f-2a5079babbc2@marcan.st>
Date:   Thu, 18 Feb 2021 21:51:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210217122200.GC5556@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2021 21.22, Mark Rutland wrote:
>> Root irqchip drivers can discriminate between IRQs and FIQs by checking
>> the ISR_EL1 system register.
> 
> I think we can remove this note for now. If we go with seperate handlers
> this won't be necessary, and if not this would be better placed on a
> commit adding the FIQ handling capability.

Indeed, this doesn't make sense any more. Changed for v3.

> Judging by `git grep -Wi daif -- arch/arm64`, with this patch applied,
> we'll also need fixups in:
> 
> * gic_arch_enable_irqs() in arch/arm64/include/asm/arch_gicv3.h
> * save_and_disable_irq() in arch/arm64/include/asm/assembler.h (noted below)
> * local_daif_save_flags() in arch/arm64/include/asm/daifflags.h
>    (the fake DAIF should have F set too)
> * __cpu_do_idle_irqprio() in arch/arm64/kernel/process.c

Good catches. A few of those are irrelevant for M1 but need to be done 
now that we're making this change globally, others I just missed from 
the beginning.

There's also an incorrect comment in entry.S:

	/*
	 * DA_F were cleared at start of handling. If anything is set in
	 * DAIF, we come back from an NMI, so skip preemption
	 */
	mrs	x0, daif
	orr	x24, x24, x0

Now only DA__ are cleared. This actually pairs with 
gic_arch_enable_irqs() and begs the question: in priority masking 
systems, do we unmask both IRQ and FIQ (the gic_arch_enable_irqs 
change), or do we leave FIQ masked (which instead would need an AND in 
that part of entry.S so as to not consider FIQ masked as meaning we're 
coming back from an NMI)?

And a minor related one: should init_gic_priority_masking() WARN if FIQ 
is masked too? This probably goes with the above.

Either way, this was nontrivial to make sense of, so I'll make that 
entry.S comment clearer while I'm touching it.

> I think save_and_diable_irq below needs to be updated too, since it
> only sets DAIF.I and leaves DAIF.F as-is.

Totally missed this one! Fixed for v3.

>> - * FIQ is never expected, but we mask it when we disable debug exceptions, and
>> - * unmask it at all other times.
>> + * FIQ is never expected on most platforms, but we keep it synchronized
>> + * with the IRQ mask status. On platforms that do not expect FIQ, that vector
>> + * triggers a kernel panic. On platforms that do, the FIQ vector is unified
>> + * with the IRQ vector.
>>    */
> 
> Can we please delete this bit, though? Now that we say IRQ and FIQ are
> masked/unmasked together, I don't think the rest is necessary to
> understand the masking logic, and it's one less thing to keep in sync
> with changes to the entry code.

Gone :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
