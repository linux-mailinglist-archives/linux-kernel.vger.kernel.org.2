Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A92416B24
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 07:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244104AbhIXFOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 01:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231256AbhIXFOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 01:14:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0192160F48;
        Fri, 24 Sep 2021 05:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632460391;
        bh=7EANzrtPhkJEHIYO2ckExVCE52EMERJeZGkAtEX4/lk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=NspJRmnA8Ru8HPQnqmLO0zTeC8xpfMcf/EU1QRmgLie65zGddU+kE9ME169LaM5BW
         zpH3lLc2s+whfM+uVaqOuG07XjM+RpcxI1TMdo9ALKncWvdiL5gt5wIL+sUDJ6m46e
         kY5WghFREulW7SsLSXwEH8a9ZDiVr6gV2B0WjlMXDeySnncaL2/Wri64WNFqAHzvFr
         4f2oDeOziCPJDWSoEKQMeAohPw7QUrCLz6sR8/aDp7ZRus3rxkwy4S0dIX5Z5BHelM
         xL0RPvXpxiVlT3ErbnRP4Lj+MUh9kBv62I81+UlstLIr7xxWjXPTR+d84DvvSzYpdt
         I3hmCcJh3Gk3Q==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id F210427C0054;
        Fri, 24 Sep 2021 01:13:08 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Fri, 24 Sep 2021 01:13:09 -0400
X-ME-Sender: <xms:Y15NYUHE4RUf_BV4ayLmEB9gdxct2bwLYu0naunnTmj6iTbrBAOLHA>
    <xme:Y15NYdURVbnMNrv48K-VMFOlIXVeTbPmRH1SLav9Qi8rl4HYwA71INmg0myWAenKU
    7UD4x3i1lY_1JqByeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejtddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:Y15NYeJN-nR1RB1BVr3FtwhK00oMha5hiZN3GvRbOsIjqWv6AI1gqA>
    <xmx:Y15NYWGhx73wDG4yiUT38t5Zi51PytOpvN9vhA44r27rXwVDzzxtcg>
    <xmx:Y15NYaWgrEg802cdiBDSwBJSq3yH5UZhEK199FkmfsfTJ5pwOEkJuA>
    <xmx:ZF5NYbuZ7ql-V2hOqOX4gG1nuDLdHMbqEAZJFYwDR63x_6NR4bWMloCq0SQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 617AC21E0063; Fri, 24 Sep 2021 01:13:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <b4b8f736-9b0a-46ee-9519-1e8bd088858d@www.fastmail.com>
In-Reply-To: <YU0+U8AEEOWMgio+@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YU0+U8AEEOWMgio+@otcwcpicx3.sc.intel.com>
Date:   Thu, 23 Sep 2021 22:12:45 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Fenghua Yu" <fenghua.yu@intel.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Raj Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Sep 23, 2021, at 7:56 PM, Fenghua Yu wrote:
> Hi, Andy,
>
> On Thu, Sep 23, 2021 at 04:17:05PM -0700, Andy Lutomirski wrote:
>> On Mon, Sep 20, 2021, at 12:23 PM, Fenghua Yu wrote:
>> > ENQCMD requires the IA32_PASID MSR has a valid PASID value which was
>> > allocated to the process during bind. The MSR could be populated eagerly
>> > by an IPI after the PASID is allocated in bind. But the method was
>> > disabled in commit 9bfecd058339 ("x86/cpufeatures: Force disable
>> > X86_FEATURE_ENQCMD and remove update_pasid()")' due to locking and other
>> > issues.
>> >
>> > Since the MSR was cleared in fork()/clone(), the first ENQCMD will
>> > generate a #GP fault. The #GP fault handler will initialize the MSR
>> > if a PASID has been allocated for this process.
>> >
>> > The lazy enabling of the PASID MSR in the #GP handler is not an elegant
>> > solution. But it has the least complexity that fits with h/w behavior.
>> >
>> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> > Reviewed-by: Tony Luck <tony.luck@intel.com>
>> > ---
>> >  arch/x86/include/asm/fpu/api.h |  6 ++++
>> >  arch/x86/include/asm/iommu.h   |  2 ++
>> >  arch/x86/kernel/fpu/xstate.c   | 59 ++++++++++++++++++++++++++++++++++
>> >  arch/x86/kernel/traps.c        | 12 +++++++
>> >  drivers/iommu/intel/svm.c      | 32 ++++++++++++++++++
>> >  5 files changed, 111 insertions(+)
>> >
>> > diff --git a/arch/x86/include/asm/fpu/api.h 
>> > b/arch/x86/include/asm/fpu/api.h
>> > index ca4d0dee1ecd..f146849e5c8c 100644
>> > --- a/arch/x86/include/asm/fpu/api.h
>> > +++ b/arch/x86/include/asm/fpu/api.h
>> > @@ -106,4 +106,10 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, 
>> > const char **feature_name);
>> >   */
>> >  #define PASID_DISABLED	0
>> > 
>> > +#ifdef CONFIG_INTEL_IOMMU_SVM
>> > +void fpu__pasid_write(u32 pasid);
>> > +#else
>> > +static inline void fpu__pasid_write(u32 pasid) { }
>> > +#endif
>> > +
>> >  #endif /* _ASM_X86_FPU_API_H */
>> > diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
>> > index bf1ed2ddc74b..9c4bf9b0702f 100644
>> > --- a/arch/x86/include/asm/iommu.h
>> > +++ b/arch/x86/include/asm/iommu.h
>> > @@ -26,4 +26,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>> >  	return -EINVAL;
>> >  }
>> > 
>> > +bool __fixup_pasid_exception(void);
>> > +
>> >  #endif /* _ASM_X86_IOMMU_H */
>> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> > index c8def1b7f8fb..8a89b2cecd77 100644
>> > --- a/arch/x86/kernel/fpu/xstate.c
>> > +++ b/arch/x86/kernel/fpu/xstate.c
>> > @@ -1289,3 +1289,62 @@ int proc_pid_arch_status(struct seq_file *m, 
>> > struct pid_namespace *ns,
>> >  	return 0;
>> >  }
>> >  #endif /* CONFIG_PROC_PID_ARCH_STATUS */
>> > +
>> > +#ifdef CONFIG_INTEL_IOMMU_SVM
>> > +/**
>> > + * fpu__pasid_write - Write the current task's PASID state/MSR.
>> > + * @pasid:	the PASID
>> > + *
>> > + * The PASID is written to the IA32_PASID MSR directly if the MSR is 
>> > active.
>> > + * Otherwise it's written to the PASID. The IA32_PASID MSR should 
>> > contain
>> > + * the PASID after returning to the user.
>> > + *
>> > + * This is called only when ENQCMD is enabled.
>> > + */
>> > +void fpu__pasid_write(u32 pasid)
>> > +{
>> > +	struct xregs_state *xsave = &current->thread.fpu.state.xsave;
>> > +	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
>> > +	struct fpu *fpu = &current->thread.fpu;
>> > +
>> > +	/*
>> > +	 * ENQCMD always uses the compacted XSAVE format. Ensure the buffer
>> > +	 * has space for the PASID.
>> > +	 */
>> > +	BUG_ON(!(xsave->header.xcomp_bv & XFEATURE_MASK_PASID));
>> > +
>> > +	fpregs_lock();
>> > +
>> > +	/*
>> > +	 * If the task's FPU doesn't need to be loaded or is valid, directly
>> > +	 * write the IA32_PASID MSR. Otherwise, write the PASID state and
>> > +	 * the MSR will be loaded from the PASID state before returning to
>> > +	 * the user.
>> > +	 */
>> > +	if (!test_thread_flag(TIF_NEED_FPU_LOAD) ||
>> > +	    fpregs_state_valid(fpu, smp_processor_id())) {
>> > +		wrmsrl(MSR_IA32_PASID, msr_val);
>> 
>> Let me try to decode this.
>> 
>> If the current task's FPU state is live or if the state is in memory but the CPU regs just happen to match the copy in memory, then write the MSR.  Else write the value to memory.
>> 
>> This is wrong.  If !TIF_NEED_FPU_LOAD && fpregs_state_valid, you MUST NOT MODIFY FPU STATE.

Sorry, I typoed that.  I meant TIF_NEED_FPU_LOAD && fpregs_state_valid, which is in the case that does wrmsr.

>
> But the FPU state is not modified if !TIF_NEED_FPU_LOAD && fpregs_state_valid.
>
> The FPU state is modified only if TIF_NEED_FPU_LOAD && !fpregs_state_valid.

The MSR is FPU state.  If TIF_NEED_FPU_LOAD && fpregs_state_valid, then the authoritative copy of the FPU state is in memory, but the CPU regs are known to match memory.  You MUST NOT modify the in-memory state or the regs.

> In this case, the FPU state will be restored to the IA32_PASID MSR when
> exiting to the user. In all other cases, the FPU state will be not be
> restored on exiting to the user and thus the IA32_PASID MSR is directly
> written here.


>
> Is it right?
>
>>  This is not negotiable -- you will break coherence between CPU regs and the memory image.
>
> fpregs_assert_state_consistent() warns on !TIF_NEED_FPU_LOAD &&
> !fpregs_state_valid. Is that breaking coherence you are talking?

No.  I mean that you broke coherence between memory and registers.  If the task resumes on the current CPU without scheduling, the MSR write will take effect.  If the task resumes on a different CPU or after something else takes over the current CPU's regs, the MSR write will be lost.

>
>>  The way you modify the current task's state is either you modify it in CPU regs (if the kernel knows that the CPU regs are the one and only source of truth) OR you modify it in memory and invalidate any preserved copies (by zapping last_cpu). 
>> 
>> In any event, that particular bit of logic really doesn't belong in here -- it belongs in some helper that gets it right, once.
>> 
>> > +
>> > +/*
>> > + * Try to figure out if there is a PASID MSR value to propagate to the
>> > + * thread taking the #GP.
>> > + */
>> > +bool __fixup_pasid_exception(void)
>> > +{
>> > +	u32 pasid;
>> > +
>> > +	/*
>> > +	 * This function is called only when this #GP was triggered from user
>> > +	 * space. So the mm cannot be NULL.
>> > +	 */
>> > +	pasid = current->mm->pasid;
>> > +
>> > +	/* If no PASID is allocated, there is nothing to propagate. */
>> > +	if (pasid == PASID_DISABLED)
>> > +		return false;
>> > +
>> > +	/*
>> > +	 * If the current task already has a valid PASID MSR, then the #GP
>> > +	 * fault must be for some non-ENQCMD related reason.
>> > +	 */
>> > +	if (current->has_valid_pasid)
>> > +		return false;
>> 
>> IMO "has_valid_pasid" is a poor name.  An mm can have a PASID.  A task has noticed or it hasn't.
>> 
>> If you really need an in-memory cache, call it "pasid_msr_is_loaded".  Or just read the field out of FPU state, but that might be painfully slow.
>
> Agree. Thomas wants to change "has_valid_pasid" to "holds_pasid_ref" to
> represents if the task takes a reference to the PASID.

That name will stop making sense when tasks stop holding references.
