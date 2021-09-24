Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5209416A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbhIXC5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:57:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:19217 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234930AbhIXC5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:57:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="309545799"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="309545799"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 19:56:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="551396204"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 19:56:20 -0700
Date:   Fri, 24 Sep 2021 02:56:19 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YU0+U8AEEOWMgio+@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andy,

On Thu, Sep 23, 2021 at 04:17:05PM -0700, Andy Lutomirski wrote:
> On Mon, Sep 20, 2021, at 12:23 PM, Fenghua Yu wrote:
> > ENQCMD requires the IA32_PASID MSR has a valid PASID value which was
> > allocated to the process during bind. The MSR could be populated eagerly
> > by an IPI after the PASID is allocated in bind. But the method was
> > disabled in commit 9bfecd058339 ("x86/cpufeatures: Force disable
> > X86_FEATURE_ENQCMD and remove update_pasid()")' due to locking and other
> > issues.
> >
> > Since the MSR was cleared in fork()/clone(), the first ENQCMD will
> > generate a #GP fault. The #GP fault handler will initialize the MSR
> > if a PASID has been allocated for this process.
> >
> > The lazy enabling of the PASID MSR in the #GP handler is not an elegant
> > solution. But it has the least complexity that fits with h/w behavior.
> >
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/include/asm/fpu/api.h |  6 ++++
> >  arch/x86/include/asm/iommu.h   |  2 ++
> >  arch/x86/kernel/fpu/xstate.c   | 59 ++++++++++++++++++++++++++++++++++
> >  arch/x86/kernel/traps.c        | 12 +++++++
> >  drivers/iommu/intel/svm.c      | 32 ++++++++++++++++++
> >  5 files changed, 111 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/fpu/api.h 
> > b/arch/x86/include/asm/fpu/api.h
> > index ca4d0dee1ecd..f146849e5c8c 100644
> > --- a/arch/x86/include/asm/fpu/api.h
> > +++ b/arch/x86/include/asm/fpu/api.h
> > @@ -106,4 +106,10 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, 
> > const char **feature_name);
> >   */
> >  #define PASID_DISABLED	0
> > 
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +void fpu__pasid_write(u32 pasid);
> > +#else
> > +static inline void fpu__pasid_write(u32 pasid) { }
> > +#endif
> > +
> >  #endif /* _ASM_X86_FPU_API_H */
> > diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> > index bf1ed2ddc74b..9c4bf9b0702f 100644
> > --- a/arch/x86/include/asm/iommu.h
> > +++ b/arch/x86/include/asm/iommu.h
> > @@ -26,4 +26,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
> >  	return -EINVAL;
> >  }
> > 
> > +bool __fixup_pasid_exception(void);
> > +
> >  #endif /* _ASM_X86_IOMMU_H */
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > index c8def1b7f8fb..8a89b2cecd77 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -1289,3 +1289,62 @@ int proc_pid_arch_status(struct seq_file *m, 
> > struct pid_namespace *ns,
> >  	return 0;
> >  }
> >  #endif /* CONFIG_PROC_PID_ARCH_STATUS */
> > +
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +/**
> > + * fpu__pasid_write - Write the current task's PASID state/MSR.
> > + * @pasid:	the PASID
> > + *
> > + * The PASID is written to the IA32_PASID MSR directly if the MSR is 
> > active.
> > + * Otherwise it's written to the PASID. The IA32_PASID MSR should 
> > contain
> > + * the PASID after returning to the user.
> > + *
> > + * This is called only when ENQCMD is enabled.
> > + */
> > +void fpu__pasid_write(u32 pasid)
> > +{
> > +	struct xregs_state *xsave = &current->thread.fpu.state.xsave;
> > +	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> > +	struct fpu *fpu = &current->thread.fpu;
> > +
> > +	/*
> > +	 * ENQCMD always uses the compacted XSAVE format. Ensure the buffer
> > +	 * has space for the PASID.
> > +	 */
> > +	BUG_ON(!(xsave->header.xcomp_bv & XFEATURE_MASK_PASID));
> > +
> > +	fpregs_lock();
> > +
> > +	/*
> > +	 * If the task's FPU doesn't need to be loaded or is valid, directly
> > +	 * write the IA32_PASID MSR. Otherwise, write the PASID state and
> > +	 * the MSR will be loaded from the PASID state before returning to
> > +	 * the user.
> > +	 */
> > +	if (!test_thread_flag(TIF_NEED_FPU_LOAD) ||
> > +	    fpregs_state_valid(fpu, smp_processor_id())) {
> > +		wrmsrl(MSR_IA32_PASID, msr_val);
> 
> Let me try to decode this.
> 
> If the current task's FPU state is live or if the state is in memory but the CPU regs just happen to match the copy in memory, then write the MSR.  Else write the value to memory.
> 
> This is wrong.  If !TIF_NEED_FPU_LOAD && fpregs_state_valid, you MUST NOT MODIFY FPU STATE.

But the FPU state is not modified if !TIF_NEED_FPU_LOAD && fpregs_state_valid.

The FPU state is modified only if TIF_NEED_FPU_LOAD && !fpregs_state_valid.
In this case, the FPU state will be restored to the IA32_PASID MSR when
exiting to the user. In all other cases, the FPU state will be not be
restored on exiting to the user and thus the IA32_PASID MSR is directly
written here.

Is it right?

>  This is not negotiable -- you will break coherence between CPU regs and the memory image.

fpregs_assert_state_consistent() warns on !TIF_NEED_FPU_LOAD &&
!fpregs_state_valid. Is that breaking coherence you are talking?

>  The way you modify the current task's state is either you modify it in CPU regs (if the kernel knows that the CPU regs are the one and only source of truth) OR you modify it in memory and invalidate any preserved copies (by zapping last_cpu). 
> 
> In any event, that particular bit of logic really doesn't belong in here -- it belongs in some helper that gets it right, once.
> 
> > +
> > +/*
> > + * Try to figure out if there is a PASID MSR value to propagate to the
> > + * thread taking the #GP.
> > + */
> > +bool __fixup_pasid_exception(void)
> > +{
> > +	u32 pasid;
> > +
> > +	/*
> > +	 * This function is called only when this #GP was triggered from user
> > +	 * space. So the mm cannot be NULL.
> > +	 */
> > +	pasid = current->mm->pasid;
> > +
> > +	/* If no PASID is allocated, there is nothing to propagate. */
> > +	if (pasid == PASID_DISABLED)
> > +		return false;
> > +
> > +	/*
> > +	 * If the current task already has a valid PASID MSR, then the #GP
> > +	 * fault must be for some non-ENQCMD related reason.
> > +	 */
> > +	if (current->has_valid_pasid)
> > +		return false;
> 
> IMO "has_valid_pasid" is a poor name.  An mm can have a PASID.  A task has noticed or it hasn't.
> 
> If you really need an in-memory cache, call it "pasid_msr_is_loaded".  Or just read the field out of FPU state, but that might be painfully slow.

Agree. Thomas wants to change "has_valid_pasid" to "holds_pasid_ref" to
represents if the task takes a reference to the PASID.

Thanks.

-Fenghua
