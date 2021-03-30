Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4928A34EC23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhC3PXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhC3PXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:23:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C447C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:23:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s11so6314353pfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BQWWPOzYz5g9C5Knt72jDBcitEaPe5NCwMHYpAaf1rg=;
        b=cqQbUuyQ04XO0BW+Eqcrk3ZU6s2cT82hcxuhZstnIQ1m6wR898sCUFLPluU2dDvwFe
         cs45wvv5cVYgxTV1mXDNchB6KNyqtD53Zs00jqGSqPbzV/PYYYA/iW0f9RlWBjC3Zssh
         5Z+aUYvYKo+36mpNG861J0KY4Slqzb6fR7n8mC8MVziahRHdJjyTLHVEvUgSS71eSd5F
         mvv7RI3zqLVi8gzLTq6WHwk7U4DhbuJWw1R2F4UfM/KRTIp1Eitgbqe0zlCqz6yYRf76
         DMtOeXs7pySfG1lHCmfEJ+OwQg9jRcmoqvniprNiMSa591jadVNsXhx0+AptTeFxrt/w
         fIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQWWPOzYz5g9C5Knt72jDBcitEaPe5NCwMHYpAaf1rg=;
        b=sbzUpuKNVE9B1gvwe7kufm4J6GP+cBML9m0y+IWYVXjWMLwMkP0jzjQGxPpwxjMdc0
         c7uIXgdjbbTfHj6A7gLYxJaFQo7k+0EFwDV8I6EgWuMhYtxJ3g6jrENdzSGvlV5N4YoV
         G9aHJbnKJxRfKbCbvCS1d5V+ElwPL21pFJRdv34FkHPOsPo2WWSJRA4ljfy+Ez4X9iym
         LwjTzknFTiSWiMLH449Vi33Eom4rG9lIZXtoSfupIsycRcgKp41cO496WjTv1OX6eHrB
         dJi/PHbXRBfFy4LjOEUgFi7cP8c8yB65VWvoSiGaP3GoASzoStTDKkpg8iFE/mvz/ZbO
         2fCg==
X-Gm-Message-State: AOAM532WPi5KoBBuattghIEqHbWWhL2l22Qq1OtCqS0A8QqZBhuFEeuP
        qmPYYhJEmXdMDzJRe+MB6X/+dg==
X-Google-Smtp-Source: ABdhPJxNG8cgnkrIaADUYJhc55HWYqGzaCA5EQjgJ328QLs/vJt22Y9/bqHHRWfhML8gWM8R0zujQQ==
X-Received: by 2002:aa7:86d9:0:b029:1ff:275c:b67a with SMTP id h25-20020aa786d90000b02901ff275cb67amr29590901pfo.69.1617117800542;
        Tue, 30 Mar 2021 08:23:20 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y26sm16426088pfq.187.2021.03.30.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:23:16 -0700 (PDT)
Date:   Tue, 30 Mar 2021 09:23:14 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 07/19] arm64: kvm: Enable access to TRBE support for
 host
Message-ID: <20210330152314.GA2329603@xps15>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
 <20210323120647.454211-8-suzuki.poulose@arm.com>
 <20210326165550.GC2009902@xps15>
 <bc1adc62-55ce-303d-b029-0fa02958998e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc1adc62-55ce-303d-b029-0fa02958998e@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 11:38:18AM +0100, Suzuki K Poulose wrote:
> On 26/03/2021 16:55, Mathieu Poirier wrote:
> > On Tue, Mar 23, 2021 at 12:06:35PM +0000, Suzuki K Poulose wrote:
> > > For a nvhe host, the EL2 must allow the EL1&0 translation
> > > regime for TraceBuffer (MDCR_EL2.E2TB == 0b11). This must
> > > be saved/restored over a trip to the guest. Also, before
> > > entering the guest, we must flush any trace data if the
> > > TRBE was enabled. And we must prohibit the generation
> > > of trace while we are in EL1 by clearing the TRFCR_EL1.
> > > 
> > > For vhe, the EL2 must prevent the EL1 access to the Trace
> > > Buffer.
> > > 
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   arch/arm64/include/asm/el2_setup.h | 13 +++++++++
> > >   arch/arm64/include/asm/kvm_arm.h   |  2 ++
> > >   arch/arm64/include/asm/kvm_host.h  |  2 ++
> > >   arch/arm64/kernel/hyp-stub.S       |  3 ++-
> > >   arch/arm64/kvm/debug.c             |  6 ++---
> > >   arch/arm64/kvm/hyp/nvhe/debug-sr.c | 42 ++++++++++++++++++++++++++++++
> > >   arch/arm64/kvm/hyp/nvhe/switch.c   |  1 +
> > >   7 files changed, 65 insertions(+), 4 deletions(-)
> > > 
> > 
> > Marc - do you want me to pick up this one?
> 
> I think the kvmarm tree is the best route for this patch, given the amount
> of changes the tree is going through, in the areas this patch
> touches. Or else there would be conflicts with merging. And this patch
> depends on the patches from this series that were queued.
> 
> Here is the depency tree :
> 
> a) kvm-arm fixes for debug (Patch 1, 2) & SPE save-restore fix (queued in
> v5.12-rc3)
> 
> b) TRBE defintions and Trace synchronization barrier (Patches 5 & 6)
> 
> c) kvm-arm TRBE host support (Patch 7)
> 
> d) TRBE driver support (and the ETE changes)
> 
> 
> (c) code merge depends on -> (a) + (b)
> (d) build (no conflicts) depends on -> (b)
> 
> 
> Now (d) has an indirect dependency on (c) for operational correctness at
> runtime.
> So, if :
> 
> kvmarm tree picks up : b + c
> coresight tree picksup : b + d
> 
> and if we could ensure the merge order of the trees are in
> kvmarm
> greg-kh (device-misc tree) (coresight goes via this tree)
>

Greg's char-misc tree is based on the rc releases rather than next.  As such it
is a while before other branches like kvmarm get merged, causing all sort of
compilation breakage.
 
> we should be fine.
> 
> Additionally, we could rip out the Kconfig changes from the TRBE patch
> and add it only at the rc1, once we verify both the trees are in to make
> sure the runtime operation dependency is not triggered.
>

We could also do that but Greg might frown at the tactic, and rightly so.  The
usual way to work with complex merge dependencies is to proceed in steps, which
would mean that all KVM related patches go in the v5.13 merge window.  When that
is done we add the ETE/TRBE for the v5.14 merge window.  I agree that we waste
an entire cycle but it guarantees to avoid breaking builds and follows the
conventional way to do things.   

> Thoughts ?
> 
> Suzuki
> 
> > 
> > > diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> > > index d77d358f9395..bda918948471 100644
> > > --- a/arch/arm64/include/asm/el2_setup.h
> > > +++ b/arch/arm64/include/asm/el2_setup.h
> > > @@ -65,6 +65,19 @@
> > >   						// use EL1&0 translation.
> > >   .Lskip_spe_\@:
> > > +	/* Trace buffer */
> > > +	ubfx	x0, x1, #ID_AA64DFR0_TRBE_SHIFT, #4
> > > +	cbz	x0, .Lskip_trace_\@		// Skip if TraceBuffer is not present
> > > +
> > > +	mrs_s	x0, SYS_TRBIDR_EL1
> > > +	and	x0, x0, TRBIDR_PROG
> > > +	cbnz	x0, .Lskip_trace_\@		// If TRBE is available at EL2
> > > +
> > > +	mov	x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
> > > +	orr	x2, x2, x0			// allow the EL1&0 translation
> > > +						// to own it.
> > > +
> > > +.Lskip_trace_\@:
> > >   	msr	mdcr_el2, x2			// Configure debug traps
> > >   .endm
> > > diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> > > index 94d4025acc0b..692c9049befa 100644
> > > --- a/arch/arm64/include/asm/kvm_arm.h
> > > +++ b/arch/arm64/include/asm/kvm_arm.h
> > > @@ -278,6 +278,8 @@
> > >   #define CPTR_EL2_DEFAULT	CPTR_EL2_RES1
> > >   /* Hyp Debug Configuration Register bits */
> > > +#define MDCR_EL2_E2TB_MASK	(UL(0x3))
> > > +#define MDCR_EL2_E2TB_SHIFT	(UL(24))
> > >   #define MDCR_EL2_TTRF		(1 << 19)
> > >   #define MDCR_EL2_TPMS		(1 << 14)
> > >   #define MDCR_EL2_E2PB_MASK	(UL(0x3))
> > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > index 3d10e6527f7d..80d0a1a82a4c 100644
> > > --- a/arch/arm64/include/asm/kvm_host.h
> > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > @@ -315,6 +315,8 @@ struct kvm_vcpu_arch {
> > >   		struct kvm_guest_debug_arch regs;
> > >   		/* Statistical profiling extension */
> > >   		u64 pmscr_el1;
> > > +		/* Self-hosted trace */
> > > +		u64 trfcr_el1;
> > >   	} host_debug_state;
> > >   	/* VGIC state */
> > > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > > index 5eccbd62fec8..05d25e645b46 100644
> > > --- a/arch/arm64/kernel/hyp-stub.S
> > > +++ b/arch/arm64/kernel/hyp-stub.S
> > > @@ -115,9 +115,10 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
> > >   	mrs_s	x0, SYS_VBAR_EL12
> > >   	msr	vbar_el1, x0
> > > -	// Use EL2 translations for SPE and disable access from EL1
> > > +	// Use EL2 translations for SPE & TRBE and disable access from EL1
> > >   	mrs	x0, mdcr_el2
> > >   	bic	x0, x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
> > > +	bic	x0, x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
> > >   	msr	mdcr_el2, x0
> > >   	// Transfer the MM state from EL1 to EL2
> > > diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> > > index dbc890511631..7b16f42d39f4 100644
> > > --- a/arch/arm64/kvm/debug.c
> > > +++ b/arch/arm64/kvm/debug.c
> > > @@ -89,7 +89,7 @@ void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu)
> > >    *  - Debug ROM Address (MDCR_EL2_TDRA)
> > >    *  - OS related registers (MDCR_EL2_TDOSA)
> > >    *  - Statistical profiler (MDCR_EL2_TPMS/MDCR_EL2_E2PB)
> > > - *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
> > > + *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
> > >    *
> > >    * Additionally, KVM only traps guest accesses to the debug registers if
> > >    * the guest is not actively using them (see the KVM_ARM64_DEBUG_DIRTY
> > > @@ -107,8 +107,8 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
> > >   	trace_kvm_arm_setup_debug(vcpu, vcpu->guest_debug);
> > >   	/*
> > > -	 * This also clears MDCR_EL2_E2PB_MASK to disable guest access
> > > -	 * to the profiling buffer.
> > > +	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
> > > +	 * to disable guest access to the profiling and trace buffers
> > >   	 */
> > >   	vcpu->arch.mdcr_el2 = __this_cpu_read(mdcr_el2) & MDCR_EL2_HPMN_MASK;
> > >   	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> > > index f401724f12ef..9499e18dd28f 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> > > @@ -58,10 +58,51 @@ static void __debug_restore_spe(u64 pmscr_el1)
> > >   	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
> > >   }
> > > +static void __debug_save_trace(u64 *trfcr_el1)
> > > +{
> > > +
> > > +	*trfcr_el1 = 0;
> > > +
> > > +	/* Check if we have TRBE */
> > > +	if (!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
> > > +						  ID_AA64DFR0_TRBE_SHIFT))
> > > +		return;
> > > +
> > > +	/* Check we can access the TRBE */
> > > +	if ((read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_PROG))
> > > +		return;
> > > +
> > > +	/* Check if the TRBE is enabled */
> > > +	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_ENABLE))
> > > +		return;
> > > +	/*
> > > +	 * Prohibit trace generation while we are in guest.
> > > +	 * Since access to TRFCR_EL1 is trapped, the guest can't
> > > +	 * modify the filtering set by the host.
> > > +	 */
> > > +	*trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
> > > +	write_sysreg_s(0, SYS_TRFCR_EL1);
> > > +	isb();
> > > +	/* Drain the trace buffer to memory */
> > > +	tsb_csync();
> > > +	dsb(nsh);
> > > +}
> > > +
> > > +static void __debug_restore_trace(u64 trfcr_el1)
> > > +{
> > > +	if (!trfcr_el1)
> > > +		return;
> > > +
> > > +	/* Restore trace filter controls */
> > > +	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
> > > +}
> > > +
> > >   void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
> > >   {
> > >   	/* Disable and flush SPE data generation */
> > >   	__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
> > > +	/* Disable and flush Self-Hosted Trace generation */
> > > +	__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
> > >   }
> > >   void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
> > > @@ -72,6 +113,7 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
> > >   void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
> > >   {
> > >   	__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
> > > +	__debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
> > >   }
> > >   void __debug_switch_to_host(struct kvm_vcpu *vcpu)
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> > > index 68ab6b4d5141..736805232521 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> > > @@ -95,6 +95,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
> > >   	mdcr_el2 &= MDCR_EL2_HPMN_MASK;
> > >   	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
> > > +	mdcr_el2 |= MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT;
> > >   	write_sysreg(mdcr_el2, mdcr_el2);
> > >   	if (is_protected_kvm_enabled())
> > > -- 
> > > 2.24.1
> > > 
> 
