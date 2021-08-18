Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D113F0906
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhHRQYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHRQYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:24:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD5BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 09:24:17 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cc3005704672aafc25cd6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:5704:672a:afc2:5cd6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8664A1EC04D6;
        Wed, 18 Aug 2021 18:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629303851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gzHPrx/5LOtQcoF1wf6Z+T1kR+q1AVCzYDifEl4tXgA=;
        b=cwyPrHcFNpFIgpXuEr+VZDYmOgvMdsoOWwHqVc2LcuK4G6gty5e4WS9u2GV7+09FbQ9dGp
        9657Id2CXl6y+Ks1eClpVtz77MKIkYUmgPdfe8owEc1OFBIC8k7+NB0Vs+C9bKDRTg5YoI
        Lz7Cu/cVKmvnstg7+6Swih6FThJ12Pk=
Date:   Wed, 18 Aug 2021 18:24:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Message-ID: <YR00U19168BGoRB9@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210730145957.7927-13-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 07:59:43AM -0700, Chang S. Bae wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d0ce5cfd3ac1..37150b7a8e44 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -277,6 +277,7 @@
>  #define X86_FEATURE_XSAVEC		(10*32+ 1) /* XSAVEC instruction */
>  #define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX = 1 instruction */
>  #define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
> +#define X86_FEATURE_XFD			(10*32+ 4) /* eXtended Feature Disabling */
							     ^
							     |

Add "" at the marker above - it doesn't look like we wanna show "xfd" in
/proc/cpuinfo.

>   * Extended auxiliary flags: Linux defined - for features scattered in various
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 263e349ff85a..e3590cf55325 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -535,14 +535,55 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
>   * Misc helper functions:
>   */
>  
> +/* The Extended Feature Disable (XFD) helpers: */
> +
> +static inline void xfd_write(u64 value)
> +{
> +	wrmsrl_safe(MSR_IA32_XFD, value);
> +}
> +
> +static inline u64 xfd_read(void)
> +{
> +	u64 value;
> +
> +	rdmsrl_safe(MSR_IA32_XFD, &value);
> +	return value;
> +}

Those look useless. Imagine we had to add wrappers around *every* MSR we
touch in the kernel...

> +
> +static inline u64 xfd_capable(void)
> +{
> +	return xfeatures_mask_user_dynamic;
> +}

A small helper which returns an u64 but is used in boolean context?

Also, this name is wrong: XFD capable is a system which has
X86_FEATURE_XFD set. You should simply use xfeatures_mask_user_dynamic
everywhere since it is __ro_after_init.

> +/**
> + * xfd_switch - Switches the MSR IA32_XFD context if needed.
> + * @prev:	The previous task's struct fpu pointer
> + * @next:	The next task's struct fpu pointer
> + */
> +static inline void xfd_switch(struct fpu *prev, struct fpu *next)
> +{
> +	u64 prev_xfd_mask, next_xfd_mask;
> +
> +	if (!static_cpu_has(X86_FEATURE_XFD) || !xfd_capable())

cpu_feature_enabled(). Use that everywhere in your patchset. But you
know already...

> +		return;
> +
> +	prev_xfd_mask = prev->state_mask & xfd_capable();
> +	next_xfd_mask = next->state_mask & xfd_capable();

This is just plain misleading:

You're *AND*ing a mask with xfd_capable?!?

Just use xfeatures_mask_user_dynamic directly instead, as already
mentioned.

> +	if (unlikely(prev_xfd_mask != next_xfd_mask))
> +		xfd_write(xfd_capable() ^ next_xfd_mask);
> +}

Here too.

Also, I must be missing something. Let's play with some imaginary masks:

prev->state_mask = 110b
next->state_mask = 111b
dyn		 = 101b

("dyn" is short for xfeatures_mask_user_dynamic)

prev_xfd_mask = 100b
next_xfd_mask = 101b

if (unlikely(100b != 101b))
	xfd_write(101b ^ 101b) == xfd_write(0)

so next has bits 2 and 0 set but the xfd write zaps them so next won't
get any more #NMs for those states.

Why?

>  /*
>   * Delay loading of the complete FPU state until the return to userland.
>   * PKRU is handled separately.
>   */
> -static inline void switch_fpu_finish(struct fpu *new_fpu)
> +static inline void switch_fpu_finish(struct fpu *old_fpu, struct fpu *new_fpu)
>  {
> -	if (cpu_feature_enabled(X86_FEATURE_FPU))
> +	if (cpu_feature_enabled(X86_FEATURE_FPU)) {
>  		set_thread_flag(TIF_NEED_FPU_LOAD);
> +		xfd_switch(old_fpu, new_fpu);
> +	}
>  }
>  
>  #endif /* _ASM_X86_FPU_INTERNAL_H */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index a7c413432b33..eac0cfd9210b 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -626,6 +626,8 @@
>  #define MSR_IA32_BNDCFGS_RSVD		0x00000ffc
>  
>  #define MSR_IA32_XSS			0x00000da0
> +#define MSR_IA32_XFD			0x000001c4
> +#define MSR_IA32_XFD_ERR		0x000001c5

At least try to keep those numerically sorted, at least among the
architectural MSR_IA32_ ones. That is, provided those XFD things are
architectural...

>  #define MSR_IA32_APICBASE		0x0000001b
>  #define MSR_IA32_APICBASE_BSP		(1<<8)
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index defda61f372d..7f891d2eb52e 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -75,6 +75,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>  	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
>  	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
>  	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
> +	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVE     },
>  	{}
>  };
>  
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 3b56e7612c45..c6ff0575d87d 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -182,6 +182,26 @@ static bool xfeature_is_supervisor(int xfeature_nr)
>  	return ecx & 1;
>  }
>  
> +/**
> + * xfd_supported - Check if the feature supports Extended Feature Disable (XFD).
> + * @feature_nr:	The feature number.
> + *
> + * Returns:	True if supported; otherwise, false.
> + */
> +static bool xfd_supported(int feature_nr)

xfeature_supports_xfd()

> +{
> +	u32 eax, ebx, ecx, edx;
> +
> +	if (!boot_cpu_has(X86_FEATURE_XFD))
> +		return false;
> +
> +	/*
> +	 * If state component 'i' supports it, ECX[2] return 1; otherwise, 0.
> +	 */
> +	cpuid_count(XSTATE_CPUID, feature_nr, &eax, &ebx, &ecx, &edx);
> +	return ecx & 4;
> +}
> +
>  /**
>   * get_xstate_comp_offset - Find the feature's offset in the compacted
>   *			    format.
> @@ -274,6 +294,9 @@ void fpu__init_cpu_xstate(void)
>  		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
>  				     xfeatures_mask_independent());
>  	}
> +
> +	if (boot_cpu_has(X86_FEATURE_XFD))
> +		xfd_write(xfd_capable());
>  }
>  
>  static bool xfeature_enabled(enum xfeature xfeature)
> @@ -473,8 +496,9 @@ static void __init print_xstate_offset_size(void)
>  	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
>  		if (!xfeature_enabled(i))
>  			continue;
> -		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
> -			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
> +		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d (%s)\n",
> +			i, xstate_comp_offsets[i], i, xstate_sizes[i],
> +			(xfeatures_mask_user_dynamic & BIT_ULL(i)) ? "dynamic" : "default");

Make that

			(xfeatures_mask_user_dynamic & BIT_ULL(i)) ? "(dynamic)" : "");

> @@ -920,6 +944,16 @@ void __init fpu__init_system_xstate(void)
>  	/* Do not support the dynamically allocated buffer yet. */
>  	xfeatures_mask_user_dynamic = 0;
>  
> +	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
> +		u64 feature_mask = BIT_ULL(i);
> +
> +		if (!(xfeatures_mask_uabi() & feature_mask))
> +			continue;
> +
> +		if (xfd_supported(i))
> +			xfeatures_mask_user_dynamic |= feature_mask;
> +	}
> +
>  	/* Enable xstate instructions to be able to continue with initialization: */
>  	fpu__init_cpu_xstate();
>  	err = init_xstate_size();
> @@ -981,6 +1015,12 @@ void fpu__resume_cpu(void)
>  		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
>  				     xfeatures_mask_independent());
>  	}
> +
> +	if (boot_cpu_has(X86_FEATURE_XFD)) {
> +		u64 fpu_xfd_mask = current->thread.fpu.state_mask & xfd_capable();
> +
> +		xfd_write(xfd_capable() ^ fpu_xfd_mask);
> +	}
>  }
>  
>  /**
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 534b9fb7e7ee..b85fa499f195 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -97,6 +97,12 @@ void arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
>  	*size = get_xstate_config(XSTATE_MIN_SIZE);
>  }
>  
> +void arch_release_task_struct(struct task_struct *task)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_FPU))
> +		free_xstate_buffer(&task->thread.fpu);
> +}
> +
>  /*
>   * Free thread data structures etc..
>   */
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 4f2f54e1281c..7bd5d08eeb41 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -213,7 +213,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  
>  	this_cpu_write(current_task, next_p);
>  
> -	switch_fpu_finish(next_fpu);
> +	switch_fpu_finish(prev_fpu, next_fpu);
>  
>  	/* Load the Intel cache allocation PQR MSR. */
>  	resctrl_sched_in();
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index ec0d836a13b1..41c9855158d6 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -620,7 +620,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	this_cpu_write(current_task, next_p);
>  	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
>  
> -	switch_fpu_finish(next_fpu);
> +	switch_fpu_finish(prev_fpu, next_fpu);
>  
>  	/* Reload sp0. */
>  	update_task_stack(next_p);
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..dd66d528afd8 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1112,6 +1112,45 @@ DEFINE_IDTENTRY(exc_device_not_available)
>  {
>  	unsigned long cr0 = read_cr0();
>  
> +	if (boot_cpu_has(X86_FEATURE_XFD)) {

This whole thing wants to be in a separate function. Even the
indentation level is begging for it.

> +		u64 xfd_err;
> +
> +		rdmsrl_safe(MSR_IA32_XFD_ERR, &xfd_err);
> +		wrmsrl_safe(MSR_IA32_XFD_ERR, 0);
> +
> +		if (xfd_err) {
> +			u64 xfd_event = xfd_err & xfd_capable();
> +
> +			if (WARN_ON(!xfd_event)) {
> +				/*
> +				 * Unexpected event is raised. But update XFD state to
> +				 * unblock the task.
> +				 */
> +				xfd_write(xfd_read() & ~xfd_err);

So AFAIU, xfd_err points to some other feature which caused this
exception.

So if that feature bit is set in XFD, you're clearing it here. Why?

So that it doesn't raise that #NM for it anymore?

This looks weird.

> +			} else {
> +				struct fpu *fpu = &current->thread.fpu;
> +				int err = -1;
> +
> +				/*
> +				 * Make sure not in interrupt context as handling a
> +				 * trap from userspace.
> +				 */
> +				if (!WARN_ON(in_interrupt())) {

I'm guessing that's supposed to stop people from using AMX and other
dynamic states in the kernel?

> +					err = alloc_xstate_buffer(fpu, xfd_event);
> +					if (!err)
> +						xfd_write((fpu->state_mask & xfd_capable()) ^
> +							  xfd_capable());
> +				}
> +
> +				/* Raise a signal when it failed to handle. */
> +				if (err)
> +					force_sig_fault(SIGILL, ILL_ILLOPC,
> +							error_get_trap_addr(regs));

Where is it documented that that configuration of SIG* types means,
failure to allocate the dynamic buffer?

To the general picture: why is this thing even allocating a buffer in #NM?

Why isn't the buffer pre-allocated for the process after latter having
done prctl() so that when an #NM happens, no allocation happens at all?

And with those buffers preallocated, all that XFD muck is not needed
either.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
