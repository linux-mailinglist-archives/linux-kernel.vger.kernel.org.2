Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08F03EA407
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbhHLLuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:50:54 -0400
Received: from foss.arm.com ([217.140.110.172]:42310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236091AbhHLLux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:50:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A86F71042;
        Thu, 12 Aug 2021 04:50:27 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C16943F718;
        Thu, 12 Aug 2021 04:50:26 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3: Fix priority comparison when non-secure
 priorities are used
To:     Marc Zyngier <maz@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210811171505.1502090-1-wenst@chromium.org>
 <87fsvfal4n.wl-maz@kernel.org>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <79eabae1-e4a3-7a12-7aa0-3680569584e5@arm.com>
Date:   Thu, 12 Aug 2021 12:51:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87fsvfal4n.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After re-familiarizing myself with the spec, it starting to look to me like indeed
there's something not quite right (read as: totally broken) with my patch.

Arm IHI 0069F, the pseudocode for reading ICC_RPR_EL1 (page 11-797), says that the
priority returned is unchanged if SCTLR_EL3.FIQ == 0. This means that the
ICC_RPR_EL1 read will return the secure view (the value as it is stored by the
GIC) of the priority, so for pseudo-nmis it will return (GICD_INT_NMI_PRI >> 1) |
0x80, which definitely != GICD_INT_NMI_PRI. This is further confirmed by this
statement on page 4-67:

"When GICD_CTLR.DS == 0, [..] For Non-secure access to ICC_PMR_EL1 and ICC_RPR_EL1
when SCR_EL3.FIQ == 0:
The Secure, unshifted view applies."

I don't know how I missed that during testing.

Did a quick test on the model with PMU NMIs (GICD_CTRL.DS = 0, SCTLR_EL2.FIQ = 0),
gic_handle_nmi() was not being called at all, but when I changed the comparison to
gic_read_rpr() == ((GICD_INT_NMI_PRI >> 1) | 0x80), NMIs were being correctly
handled again.

Will try to run some more tests on real hardware and see if I can confirm this.

Thanks,

Alex

On 8/11/21 7:31 PM, Marc Zyngier wrote:
> + Alex, who introduced this.
>
> On Wed, 11 Aug 2021 18:15:05 +0100,
> Chen-Yu Tsai <wenst@chromium.org> wrote:
>> When non-secure priorities are used, compared to the raw priority set,
>> the value read back from RPR is also right-shifted by one and the
>> highest bit set.
>>
>> Add a macro to do the modifications to the raw priority when doing the
>> comparison against the RPR value. This corrects the pseudo-NMI behavior
>> when non-secure priorities in the GIC are used. Tested on 5.10 with
>> the "IPI as pseudo-NMI" series [1] applied on MT8195.
>>
>> [1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/
>>
>> Fixes: 336780590990 ("irqchip/gic-v3: Support pseudo-NMIs when SCR_EL3.FIQ == 0")
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index e0f4debe64e1..e7a0b55413db 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -100,6 +100,15 @@ EXPORT_SYMBOL(gic_pmr_sync);
>>  DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
>>  EXPORT_SYMBOL(gic_nonsecure_priorities);
>>  
>> +#define GICD_INT_RPR_PRI(priority)					\
>> +	({								\
>> +		u32 __priority = (priority);				\
>> +		if (static_branch_unlikely(&gic_nonsecure_priorities))	\
>> +			__priority = 0x80 | (__priority >> 1);		\
>> +									\
>> +		__priority;						\
> This doesn't reflect what the pseudocode says of a read of ICC_RPR_EL1
> AFAICS. When the priority is activated, it is indeed shifted. But a
> read of RPR does appear to shift things back (and you loose the lowest
> bit in the process). Please see 'aarch64/support/ICC_RPR_EL1' in the
> architecture spec.
>
> Can you confirm that SCR_EL3.FIQ is set on your system?
>
> Thanks,
>
> 	M.
>
>> +	})
>> +
>>  /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
>>  static refcount_t *ppi_nmi_refs;
>>  
>> @@ -687,7 +696,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>>  		return;
>>  
>>  	if (gic_supports_nmi() &&
>> -	    unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
>> +	    unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI))) {
>>  		gic_handle_nmi(irqnr, regs);
>>  		return;
>>  	}
>
