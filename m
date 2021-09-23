Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4EA415CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbhIWLdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhIWLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:33:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A77C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 04:31:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632396690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ODvcRdqn5ATZUTeAZX+QVSmK4LQTW4+KuKCMEOCTHnY=;
        b=mihvJjq0xBrdJF20Pl4fHXAR4ntgK2dUB5CvTkzcc13YVxoVeLCVf3EV5fxvhJMj0vtFKq
        a7dh84nwqekkbDFBEeNn2A5N8PlDdCW7HPFuaIEh2u9XTYyfrKkj6gu8h23E+QHeWUdqVZ
        nlzupnpG8TyuIQPX4G5q7XeFxiIqCOHQqKwVlZNe0aD7IxpU3cn2ythKd+v9RMyyRS3Kzv
        3TLN6dE+gFuGHOEtiUXlWV43YUfU9Yj5RsKZIPYAALrjzGNy9eTMsT3UIYhVoiy9gZxnmS
        e+Q3tY8BnfuV5zsxQynC5Ir5mIABWym5CjcoWD59NHJD9srDuxLWztN228OKog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632396690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ODvcRdqn5ATZUTeAZX+QVSmK4LQTW4+KuKCMEOCTHnY=;
        b=qKlkmtb7K2F7dLV38+9K6R1qwFrPd7IEUwkXsR/I5SVdsR/NJsgge39R7HS+dyiTsmVM9a
        RjLF05CVJlBQ/4Cw==
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
In-Reply-To: <20210920192349.2602141-5-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
Date:   Thu, 23 Sep 2021 13:31:29 +0200
Message-ID: <875yurh6jy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20 2021 at 19:23, Fenghua Yu wrote:
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c8def1b7f8fb..8a89b2cecd77 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1289,3 +1289,62 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
>  	return 0;
>  }
>  #endif /* CONFIG_PROC_PID_ARCH_STATUS */
> +
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +/**
> + * fpu__pasid_write - Write the current task's PASID state/MSR.
> + * @pasid:	the PASID
> + *
> + * The PASID is written to the IA32_PASID MSR directly if the MSR is active.
> + * Otherwise it's written to the PASID. The IA32_PASID MSR should contain

written to the PASID? What's 'the PASID' ?

> + * the PASID after returning to the user.
> + *
> + * This is called only when ENQCMD is enabled.

Well, yes, but it does not explain why it is called and from which context.

> + */
> +void fpu__pasid_write(u32 pasid)
> +{
> +	struct xregs_state *xsave = &current->thread.fpu.state.xsave;
> +	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> +	struct fpu *fpu = &current->thread.fpu;
> +
> +	/*
> +	 * ENQCMD always uses the compacted XSAVE format. Ensure the buffer
> +	 * has space for the PASID.
> +	 */
> +	BUG_ON(!(xsave->header.xcomp_bv & XFEATURE_MASK_PASID));
> +
> +	fpregs_lock();
> +
> +	/*
> +	 * If the task's FPU doesn't need to be loaded or is valid, directly
> +	 * write the IA32_PASID MSR. Otherwise, write the PASID state and
> +	 * the MSR will be loaded from the PASID state before returning to
> +	 * the user.
> +	 */
> +	if (!test_thread_flag(TIF_NEED_FPU_LOAD) ||
> +	    fpregs_state_valid(fpu, smp_processor_id())) {
> +		wrmsrl(MSR_IA32_PASID, msr_val);
> +	} else {
> +		struct ia32_pasid_state *ppasid_state;
> +		/*
> +		 * Mark XFEATURE_PASID as non-init in the XSAVE buffer.
> +		 * This ensures that a subsequent XRSTOR will see the new
> +		 * value instead of writing the init value to the MSR.
> +		 */

This and the above wrmsrl() assume that @pasid is valid which might be
correct, but I don't see any information about pasid lifetime. I assume
that there is no way to drop a PASID, right?

> +		xsave->header.xfeatures |= XFEATURE_MASK_PASID;
> +		ppasid_state = get_xsave_addr(xsave, XFEATURE_PASID);
> +		/*
> +		 * ppasid_state shouldn't be NULL because XFEATURE_PASID
> +		 * was set just now.
> +		 *
> +		 * Please note that the following operation is a "write only"
> +		 * operation on the PASID state and it writes the *ENTIRE*
> +		 * state component. Please don't blindly copy this code to
> +		 * modify other XSAVE states.
> +		 */
> +		ppasid_state->pasid = msr_val;
> +	}
> +
> +	fpregs_unlock();
> +}
> +#endif /* CONFIG_INTEL_IOMMU_SVM */

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..a25d738ae839 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
>  
> +static bool fixup_pasid_exception(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> +		return false;
> +
> +	return __fixup_pasid_exception();
> +}

Ok, so here is the hook into #GP which then calls out into:

> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1179,3 +1179,35 @@ int intel_svm_page_response(struct device *dev,
>  	mutex_unlock(&pasid_mutex);
>  	return ret;
>  }
> +
> +/*
> + * Try to figure out if there is a PASID MSR value to propagate to the
> + * thread taking the #GP.
> + */
> +bool __fixup_pasid_exception(void)
> +{
> +	u32 pasid;
> +
> +	/*
> +	 * This function is called only when this #GP was triggered from user
> +	 * space. So the mm cannot be NULL.
> +	 */
> +	pasid = current->mm->pasid;
> +
> +	/* If no PASID is allocated, there is nothing to propagate. */
> +	if (pasid == PASID_DISABLED)
> +		return false;
> +
> +	/*
> +	 * If the current task already has a valid PASID MSR, then the #GP
> +	 * fault must be for some non-ENQCMD related reason.
> +	 */
> +	if (current->has_valid_pasid)
> +		return false;
> +
> +	/* Fix up the MSR by the PASID in the mm. */
> +	fpu__pasid_write(pasid);
> +	current->has_valid_pasid = 1;
> +
> +	return true;
> +}

What is INTEL SVM specific on this? Nothing at all.

If there is a valid PASID in current->mm and the MSR has not been
updated yet, write it. Otherwise bail.

Thanks,

        tglx


