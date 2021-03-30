Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5434E594
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhC3Kio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:38:44 -0400
Received: from foss.arm.com ([217.140.110.172]:56896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231537AbhC3KiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:38:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74F1BED1;
        Tue, 30 Mar 2021 03:38:21 -0700 (PDT)
Received: from [10.57.22.222] (unknown [10.57.22.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AE8B3F694;
        Tue, 30 Mar 2021 03:38:19 -0700 (PDT)
Subject: Re: [PATCH v5 07/19] arm64: kvm: Enable access to TRBE support for
 host
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, anshuman.khandual@arm.com, maz@kernel.org,
        catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
 <20210323120647.454211-8-suzuki.poulose@arm.com>
 <20210326165550.GC2009902@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <bc1adc62-55ce-303d-b029-0fa02958998e@arm.com>
Date:   Tue, 30 Mar 2021 11:38:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210326165550.GC2009902@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2021 16:55, Mathieu Poirier wrote:
> On Tue, Mar 23, 2021 at 12:06:35PM +0000, Suzuki K Poulose wrote:
>> For a nvhe host, the EL2 must allow the EL1&0 translation
>> regime for TraceBuffer (MDCR_EL2.E2TB == 0b11). This must
>> be saved/restored over a trip to the guest. Also, before
>> entering the guest, we must flush any trace data if the
>> TRBE was enabled. And we must prohibit the generation
>> of trace while we are in EL1 by clearing the TRFCR_EL1.
>>
>> For vhe, the EL2 must prevent the EL1 access to the Trace
>> Buffer.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/el2_setup.h | 13 +++++++++
>>   arch/arm64/include/asm/kvm_arm.h   |  2 ++
>>   arch/arm64/include/asm/kvm_host.h  |  2 ++
>>   arch/arm64/kernel/hyp-stub.S       |  3 ++-
>>   arch/arm64/kvm/debug.c             |  6 ++---
>>   arch/arm64/kvm/hyp/nvhe/debug-sr.c | 42 ++++++++++++++++++++++++++++++
>>   arch/arm64/kvm/hyp/nvhe/switch.c   |  1 +
>>   7 files changed, 65 insertions(+), 4 deletions(-)
>>
> 
> Marc - do you want me to pick up this one?

I think the kvmarm tree is the best route for this patch, given the 
amount of changes the tree is going through, in the areas this patch
touches. Or else there would be conflicts with merging. And this patch
depends on the patches from this series that were queued.

Here is the depency tree :

a) kvm-arm fixes for debug (Patch 1, 2) & SPE save-restore fix (queued 
in v5.12-rc3)

b) TRBE defintions and Trace synchronization barrier (Patches 5 & 6)

c) kvm-arm TRBE host support (Patch 7)

d) TRBE driver support (and the ETE changes)


(c) code merge depends on -> (a) + (b)
(d) build (no conflicts) depends on -> (b)


Now (d) has an indirect dependency on (c) for operational correctness at
runtime.
So, if :

kvmarm tree picks up : b + c
coresight tree picksup : b + d

and if we could ensure the merge order of the trees are in
kvmarm
greg-kh (device-misc tree) (coresight goes via this tree)

we should be fine.

Additionally, we could rip out the Kconfig changes from the TRBE patch
and add it only at the rc1, once we verify both the trees are in to make
sure the runtime operation dependency is not triggered.

Thoughts ?

Suzuki

> 
>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>> index d77d358f9395..bda918948471 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -65,6 +65,19 @@
>>   						// use EL1&0 translation.
>>   
>>   .Lskip_spe_\@:
>> +	/* Trace buffer */
>> +	ubfx	x0, x1, #ID_AA64DFR0_TRBE_SHIFT, #4
>> +	cbz	x0, .Lskip_trace_\@		// Skip if TraceBuffer is not present
>> +
>> +	mrs_s	x0, SYS_TRBIDR_EL1
>> +	and	x0, x0, TRBIDR_PROG
>> +	cbnz	x0, .Lskip_trace_\@		// If TRBE is available at EL2
>> +
>> +	mov	x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
>> +	orr	x2, x2, x0			// allow the EL1&0 translation
>> +						// to own it.
>> +
>> +.Lskip_trace_\@:
>>   	msr	mdcr_el2, x2			// Configure debug traps
>>   .endm
>>   
>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
>> index 94d4025acc0b..692c9049befa 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -278,6 +278,8 @@
>>   #define CPTR_EL2_DEFAULT	CPTR_EL2_RES1
>>   
>>   /* Hyp Debug Configuration Register bits */
>> +#define MDCR_EL2_E2TB_MASK	(UL(0x3))
>> +#define MDCR_EL2_E2TB_SHIFT	(UL(24))
>>   #define MDCR_EL2_TTRF		(1 << 19)
>>   #define MDCR_EL2_TPMS		(1 << 14)
>>   #define MDCR_EL2_E2PB_MASK	(UL(0x3))
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 3d10e6527f7d..80d0a1a82a4c 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -315,6 +315,8 @@ struct kvm_vcpu_arch {
>>   		struct kvm_guest_debug_arch regs;
>>   		/* Statistical profiling extension */
>>   		u64 pmscr_el1;
>> +		/* Self-hosted trace */
>> +		u64 trfcr_el1;
>>   	} host_debug_state;
>>   
>>   	/* VGIC state */
>> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
>> index 5eccbd62fec8..05d25e645b46 100644
>> --- a/arch/arm64/kernel/hyp-stub.S
>> +++ b/arch/arm64/kernel/hyp-stub.S
>> @@ -115,9 +115,10 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
>>   	mrs_s	x0, SYS_VBAR_EL12
>>   	msr	vbar_el1, x0
>>   
>> -	// Use EL2 translations for SPE and disable access from EL1
>> +	// Use EL2 translations for SPE & TRBE and disable access from EL1
>>   	mrs	x0, mdcr_el2
>>   	bic	x0, x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
>> +	bic	x0, x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
>>   	msr	mdcr_el2, x0
>>   
>>   	// Transfer the MM state from EL1 to EL2
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index dbc890511631..7b16f42d39f4 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -89,7 +89,7 @@ void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu)
>>    *  - Debug ROM Address (MDCR_EL2_TDRA)
>>    *  - OS related registers (MDCR_EL2_TDOSA)
>>    *  - Statistical profiler (MDCR_EL2_TPMS/MDCR_EL2_E2PB)
>> - *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
>> + *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
>>    *
>>    * Additionally, KVM only traps guest accesses to the debug registers if
>>    * the guest is not actively using them (see the KVM_ARM64_DEBUG_DIRTY
>> @@ -107,8 +107,8 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>>   	trace_kvm_arm_setup_debug(vcpu, vcpu->guest_debug);
>>   
>>   	/*
>> -	 * This also clears MDCR_EL2_E2PB_MASK to disable guest access
>> -	 * to the profiling buffer.
>> +	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>> +	 * to disable guest access to the profiling and trace buffers
>>   	 */
>>   	vcpu->arch.mdcr_el2 = __this_cpu_read(mdcr_el2) & MDCR_EL2_HPMN_MASK;
>>   	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
>> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> index f401724f12ef..9499e18dd28f 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> @@ -58,10 +58,51 @@ static void __debug_restore_spe(u64 pmscr_el1)
>>   	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
>>   }
>>   
>> +static void __debug_save_trace(u64 *trfcr_el1)
>> +{
>> +
>> +	*trfcr_el1 = 0;
>> +
>> +	/* Check if we have TRBE */
>> +	if (!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
>> +						  ID_AA64DFR0_TRBE_SHIFT))
>> +		return;
>> +
>> +	/* Check we can access the TRBE */
>> +	if ((read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_PROG))
>> +		return;
>> +
>> +	/* Check if the TRBE is enabled */
>> +	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_ENABLE))
>> +		return;
>> +	/*
>> +	 * Prohibit trace generation while we are in guest.
>> +	 * Since access to TRFCR_EL1 is trapped, the guest can't
>> +	 * modify the filtering set by the host.
>> +	 */
>> +	*trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
>> +	write_sysreg_s(0, SYS_TRFCR_EL1);
>> +	isb();
>> +	/* Drain the trace buffer to memory */
>> +	tsb_csync();
>> +	dsb(nsh);
>> +}
>> +
>> +static void __debug_restore_trace(u64 trfcr_el1)
>> +{
>> +	if (!trfcr_el1)
>> +		return;
>> +
>> +	/* Restore trace filter controls */
>> +	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
>> +}
>> +
>>   void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>>   {
>>   	/* Disable and flush SPE data generation */
>>   	__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
>> +	/* Disable and flush Self-Hosted Trace generation */
>> +	__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
>>   }
>>   
>>   void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
>> @@ -72,6 +113,7 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
>>   void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>>   {
>>   	__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
>> +	__debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
>>   }
>>   
>>   void __debug_switch_to_host(struct kvm_vcpu *vcpu)
>> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
>> index 68ab6b4d5141..736805232521 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
>> @@ -95,6 +95,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
>>   
>>   	mdcr_el2 &= MDCR_EL2_HPMN_MASK;
>>   	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
>> +	mdcr_el2 |= MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT;
>>   
>>   	write_sysreg(mdcr_el2, mdcr_el2);
>>   	if (is_protected_kvm_enabled())
>> -- 
>> 2.24.1
>>

