Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D09741F045
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354768AbhJAPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:04:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57930 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354765AbhJAPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:04:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkahMb00/2ZOB3OTBy1INbxnjaoRkIMrPGAeMzpZqq4=;
        b=VvAbATfHtKYOGYETTF4NyAZJH0nLm539yYltnLygMzbsW/tEjTosnqw19MbnXdR/rnK7YR
        2gfMFdiGhpFaZ5tQC82CVyMj+qAI10owVUzsEUEEZyAL10FpSozE/JFriZBhwGiDmB8R8h
        hKkBEsJ8RK+UzTT2tMRGhAUMJsnqut+uN3bt7Ttb3X2YAZWvrH9/xuPYlTVo2KmQlMLJcz
        n53R48hp2BPxnaQLKBszUkVeTtGDdKofjtZixfvRV2GnLJLHmSZ6atwcZpXjXUcsGANWI5
        Tqiwj49RQxsZBqLoWCHz2VOJ1ty98w6Pnl5AyyJVGmOH/IbdoZPNE0PToIAVjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkahMb00/2ZOB3OTBy1INbxnjaoRkIMrPGAeMzpZqq4=;
        b=pcOb3Ej2c2nCvd9kpicGl6rnch6vwgCq0kClnm6XbkHUugUqvyUgR4DW0P1KvBr85CVRS7
        71RB9rhBWBi3sYDw==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v10 13/28] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
In-Reply-To: <20210825155413.19673-14-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-14-chang.seok.bae@intel.com>
Date:   Fri, 01 Oct 2021 17:02:49 +0200
Message-ID: <871r546b52.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25 2021 at 08:53, Chang S. Bae wrote:
> +/**
> + * xfd_switch - Switches the MSR IA32_XFD context if needed.
> + * @prev:	The previous task's struct fpu pointer
> + * @next:	The next task's struct fpu pointer
> + */
> +static inline void xfd_switch(struct fpu *prev, struct fpu *next)
> +{
> +	u64 prev_xfd_mask, next_xfd_mask;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_XFD) || !xfeatures_mask_user_dynamic)
> +		return;

This is context switch, so this wants to be a static key which is turned
on during init when the CPU supports XFD and user dynamic features are
available.

> +
> +	prev_xfd_mask = prev->state_mask & xfeatures_mask_user_dynamic;
> +	next_xfd_mask = next->state_mask & xfeatures_mask_user_dynamic;
> +
> +	if (unlikely(prev_xfd_mask != next_xfd_mask))
> +		wrmsrl_safe(MSR_IA32_XFD, xfeatures_mask_user_dynamic ^ next_xfd_mask);
> +}
> +
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

Why has this to be done on context switch? Zero explanation provided.

Why can't this be done in exit_to_user() where the FPU state restore is
handled?

>  	}
> +
> +	if (boot_cpu_has(X86_FEATURE_XFD))

s/boot_cpu_has/cpu_feature_enabled/g

> +		wrmsrl(MSR_IA32_XFD, xfeatures_mask_user_dynamic);
>  }
> +
> +	if (cpu_feature_enabled(X86_FEATURE_XFD))
> +		wrmsrl_safe(MSR_IA32_XFD, (current->thread.fpu.state_mask &
> +					   xfeatures_mask_user_dynamic) ^
> +					  xfeatures_mask_user_dynamic);

Lacks curly braces as it's not a single line of code.

>  }
>  
>  /**
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 33f5d8d07367..6cd4fb098f8f 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -97,6 +97,16 @@ void arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
>  	*size = fpu_buf_cfg.min_size;
>  }
>  
> +void arch_release_task_struct(struct task_struct *task)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_FPU))
> +		return;
> +
> +	/* Free up only the dynamically-allocated memory. */
> +	if (task->thread.fpu.state != &task->thread.fpu.__default_state)

Sigh.

> +		free_xstate_buffer(&task->thread.fpu);
>  
> +static __always_inline bool handle_xfd_event(struct fpu *fpu, struct pt_regs *regs)
> +{
> +	bool handled = false;
> +	u64 xfd_err;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_XFD))
> +		return handled;
> +
> +	rdmsrl_safe(MSR_IA32_XFD_ERR, &xfd_err);
> +	wrmsrl_safe(MSR_IA32_XFD_ERR, 0);
> +
> +	if (xfd_err) {

What's wrong with

       if (!xfd_err)
       		return false;

an spare the full indentation levels below

> +		u64 xfd_event = xfd_err & xfeatures_mask_user_dynamic;
> +		u64 value;
> +
> +		if (WARN_ON(!xfd_event)) {
> +			/*
> +			 * Unexpected event is raised. But update XFD state to
> +			 * unblock the task.
> +			 */
> +			rdmsrl_safe(MSR_IA32_XFD, &value);
> +			wrmsrl_safe(MSR_IA32_XFD, value & ~xfd_err);

Ditto. But returning false here will not unblock the task as
exc_device_not_available() will simply reach "die()".

> +		} else {
> +			struct fpu *fpu = &current->thread.fpu;

You need this because the fpu argument above is invalid?

> +			int err = -1;
> +
> +			/*
> +			 * Make sure not in interrupt context as handling a
> +			 * trap from userspace.
> +			 */
> +			if (!WARN_ON(in_interrupt())) {

Why would in_interrupt() be necessarily true when the trap comes from
kernel space? The proper check is user_mode(regs) as done anywhere else.

> +				err = realloc_xstate_buffer(fpu, xfd_event);
> +				if (!err)
> +					wrmsrl_safe(MSR_IA32_XFD, (fpu->state_mask &
> +								   xfeatures_mask_user_dynamic) ^
> +								  xfeatures_mask_user_dynamic);
> +			}
> +
> +			/* Raise a signal when it failed to handle. */
> +			if (err)
> +				force_sig_fault(SIGILL, ILL_ILLOPC, error_get_trap_addr(regs));
> +		}
> +		handled = true;
> +	}
> +	return handled;
> +}
> +
>  DEFINE_IDTENTRY(exc_device_not_available)
>  {
>  	unsigned long cr0 = read_cr0();

> +	if (handle_xfd_event(&current->thread.fpu, regs))
> +		return;

As I said before, this is wrong because at that point interrupts are disabled.

Thanks,

        tglx
