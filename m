Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE3834E932
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhC3NfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:35:01 -0400
Received: from foss.arm.com ([217.140.110.172]:33922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232067AbhC3Nec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:34:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F0631B;
        Tue, 30 Mar 2021 06:34:27 -0700 (PDT)
Received: from [10.57.22.222] (unknown [10.57.22.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E7CE3F694;
        Tue, 30 Mar 2021 06:34:25 -0700 (PDT)
Subject: Re: [PATCH v5 07/19] arm64: kvm: Enable access to TRBE support for
 host
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
 <20210323120647.454211-8-suzuki.poulose@arm.com>
 <87r1jxq7ax.wl-maz@kernel.org> <c87d9dd9-72b2-6730-e3d4-9aaa0370a639@arm.com>
 <87mtukrg6o.wl-maz@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ad570007-404b-0c42-3f8e-fe3c537716be@arm.com>
Date:   Tue, 30 Mar 2021 14:34:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87mtukrg6o.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2021 13:15, Marc Zyngier wrote:
> On Tue, 30 Mar 2021 12:12:49 +0100,
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Hi Marc
>>
>> On 30/03/2021 11:12, Marc Zyngier wrote:
>>> Hi Suzuki,
>>>
>>> [+ Alex]
>>>
>>> On Tue, 23 Mar 2021 12:06:35 +0000,
>>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>
>>>> For a nvhe host, the EL2 must allow the EL1&0 translation
>>>> regime for TraceBuffer (MDCR_EL2.E2TB == 0b11). This must
>>>> be saved/restored over a trip to the guest. Also, before
>>>> entering the guest, we must flush any trace data if the
>>>> TRBE was enabled. And we must prohibit the generation
>>>> of trace while we are in EL1 by clearing the TRFCR_EL1.
>>>>
>>>> For vhe, the EL2 must prevent the EL1 access to the Trace
>>>> Buffer.
>>>>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>    arch/arm64/include/asm/el2_setup.h | 13 +++++++++
>>>>    arch/arm64/include/asm/kvm_arm.h   |  2 ++
>>>>    arch/arm64/include/asm/kvm_host.h  |  2 ++
>>>>    arch/arm64/kernel/hyp-stub.S       |  3 ++-
>>>>    arch/arm64/kvm/debug.c             |  6 ++---
>>>>    arch/arm64/kvm/hyp/nvhe/debug-sr.c | 42 ++++++++++++++++++++++++++++++
>>>>    arch/arm64/kvm/hyp/nvhe/switch.c   |  1 +
>>>>    7 files changed, 65 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>>>> index d77d358f9395..bda918948471 100644
>>>> --- a/arch/arm64/include/asm/el2_setup.h
>>>> +++ b/arch/arm64/include/asm/el2_setup.h
>>>> @@ -65,6 +65,19 @@
>>>>    						// use EL1&0 translation.
>>>>      .Lskip_spe_\@:
>>>> +	/* Trace buffer */
>>>> +	ubfx	x0, x1, #ID_AA64DFR0_TRBE_SHIFT, #4
>>>> +	cbz	x0, .Lskip_trace_\@		// Skip if TraceBuffer is not present
>>>> +
>>>> +	mrs_s	x0, SYS_TRBIDR_EL1
>>>> +	and	x0, x0, TRBIDR_PROG
>>>> +	cbnz	x0, .Lskip_trace_\@		// If TRBE is available at EL2
>>>> +
>>>> +	mov	x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
>>>> +	orr	x2, x2, x0			// allow the EL1&0 translation
>>>> +						// to own it.
>>>> +
>>>> +.Lskip_trace_\@:
>>>>    	msr	mdcr_el2, x2			// Configure debug traps
>>>>    .endm
>>>>    diff --git a/arch/arm64/include/asm/kvm_arm.h
>>>> b/arch/arm64/include/asm/kvm_arm.h
>>>> index 94d4025acc0b..692c9049befa 100644
>>>> --- a/arch/arm64/include/asm/kvm_arm.h
>>>> +++ b/arch/arm64/include/asm/kvm_arm.h
>>>> @@ -278,6 +278,8 @@
>>>>    #define CPTR_EL2_DEFAULT	CPTR_EL2_RES1
>>>>      /* Hyp Debug Configuration Register bits */
>>>> +#define MDCR_EL2_E2TB_MASK	(UL(0x3))
>>>> +#define MDCR_EL2_E2TB_SHIFT	(UL(24))
>>>
>>> Where are these bits defined? DDI0487G_a has them as RES0.
>>
>> They are part of the Future architecture technology and a register
>> definition XML is available here :
>>
>> https://developer.arm.com/documentation/ddi0601/2020-12/AArch64-Registers/MDCR-EL2--Monitor-Debug-Configuration-Register--EL2-?lang=en#fieldset_0-25_24-1
>>
> 
> It be worth adding a pointer to that documentation until this is part
> of a released ARM ARM.
> 
>>>
>>>>    #define MDCR_EL2_TTRF		(1 << 19)
>>>>    #define MDCR_EL2_TPMS		(1 << 14)
>>>>    #define MDCR_EL2_E2PB_MASK	(UL(0x3))
>>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>>> index 3d10e6527f7d..80d0a1a82a4c 100644
>>>> --- a/arch/arm64/include/asm/kvm_host.h
>>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>>> @@ -315,6 +315,8 @@ struct kvm_vcpu_arch {
>>>>    		struct kvm_guest_debug_arch regs;
>>>>    		/* Statistical profiling extension */
>>>>    		u64 pmscr_el1;
>>>> +		/* Self-hosted trace */
>>>> +		u64 trfcr_el1;
>>>>    	} host_debug_state;
>>>>      	/* VGIC state */
>>>> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
>>>> index 5eccbd62fec8..05d25e645b46 100644
>>>> --- a/arch/arm64/kernel/hyp-stub.S
>>>> +++ b/arch/arm64/kernel/hyp-stub.S
>>>> @@ -115,9 +115,10 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
>>>>    	mrs_s	x0, SYS_VBAR_EL12
>>>>    	msr	vbar_el1, x0
>>>>    -	// Use EL2 translations for SPE and disable access from EL1
>>>> +	// Use EL2 translations for SPE & TRBE and disable access from EL1
>>>>    	mrs	x0, mdcr_el2
>>>>    	bic	x0, x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
>>>> +	bic	x0, x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
>>>>    	msr	mdcr_el2, x0
>>>>      	// Transfer the MM state from EL1 to EL2
>>>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>>>> index dbc890511631..7b16f42d39f4 100644
>>>> --- a/arch/arm64/kvm/debug.c
>>>> +++ b/arch/arm64/kvm/debug.c
>>>> @@ -89,7 +89,7 @@ void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu)
>>>>     *  - Debug ROM Address (MDCR_EL2_TDRA)
>>>>     *  - OS related registers (MDCR_EL2_TDOSA)
>>>>     *  - Statistical profiler (MDCR_EL2_TPMS/MDCR_EL2_E2PB)
>>>> - *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
>>>> + *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
>>>
>>> For the record, this is likely to conflict with [1], although that
>>> patch still has some issues.
>>
>> Thanks for the heads up. I think that patch will also conflict with my
>> fixes that is queued in kvmarm/fixes.
> 
> Most probably. This is a popular landing spot, these days...
> 
>>
>>
>>>
>>>>     *
>>>>     * Additionally, KVM only traps guest accesses to the debug registers if
>>>>     * the guest is not actively using them (see the KVM_ARM64_DEBUG_DIRTY
>>>> @@ -107,8 +107,8 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>>>>    	trace_kvm_arm_setup_debug(vcpu, vcpu->guest_debug);
>>>>      	/*
>>>> -	 * This also clears MDCR_EL2_E2PB_MASK to disable guest access
>>>> -	 * to the profiling buffer.
>>>> +	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>>>> +	 * to disable guest access to the profiling and trace buffers
>>>>    	 */
>>>>    	vcpu->arch.mdcr_el2 = __this_cpu_read(mdcr_el2) & MDCR_EL2_HPMN_MASK;
>>>>    	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
>>>> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>>>> index f401724f12ef..9499e18dd28f 100644
>>>> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>>>> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>>>> @@ -58,10 +58,51 @@ static void __debug_restore_spe(u64 pmscr_el1)
>>>>    	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
>>>>    }
>>>>    +static void __debug_save_trace(u64 *trfcr_el1)
>>>> +{
>>>> +
>>>
>>> Spurious blank line?
>>>
>>
>> Sure, will fix it
>>
>>>> +	*trfcr_el1 = 0;
>>>> +
>>>> +	/* Check if we have TRBE */
>>>> +	if (!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
>>>> +						  ID_AA64DFR0_TRBE_SHIFT))
>>>> +		return;
>>>
>>> Do we have a way to track this that doesn't involve reading an ID
>>> register? This is on the hot path, and is going to really suck badly
>>> with NV (which traps all ID regs for obvious reasons). I would have
>>> hoped that one way or another, we'd have a static key for this.
>>
>> TRBE, like SPE can be optionally enabled on a subset of the CPUs. We
>> could have a per-CPU static key in the worst case. I guess this would
>> apply to SPE as well.
> 
> Ah, so you want to support asymmetric tracing... fair enough. But I
> don't think you need a per-CPU static key (and I'm not sure how that'd
> work either). You could have a static key indicating if *any* CPU
> implements tracing, in which case the check only happens when at least
> one CPU is capable of tracing.
> 
> You would only need a new capability.
> 
>> May be we could do this check at kvm_arch_vcpu_load()/put() ?
> 
> That would extend the tracing blackout period enormously, wouldn't it?
> I'm not sure that's the best thing to do...

Sorry for not making this clear. We could check if the SPE/TRBE is 
available on this CPU (including the PMB/TRB_IDR bits and a set a flag
in the VCPU on every kvm_arch_vcpu_load() and cleared on put.
The actual switching code could check this flag and check if the unit
is enabled and then do the actual save/restore as we do below.
(We may be able to even check if unit is enabled there, need to double
check this.)


Cheers
Suzuki

