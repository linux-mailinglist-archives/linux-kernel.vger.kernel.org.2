Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29030F868
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhBDQsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:48:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48828 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236971AbhBDQrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:47:37 -0500
Received: from zn.tnic (p200300ec2f0c7e006c9e5905fdac8460.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7e00:6c9e:5905:fdac:8460])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BCC0A1EC01DF;
        Thu,  4 Feb 2021 17:46:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612457213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zyGJ6/Zv/jlWekLvHdRZ9qZvj3WcVrl03ax/HB5JuI0=;
        b=lyDt/9+nsiEGgfE+9kmHo46EKuBie+nYdB1zV715tusIhONjo7BhUUAzKAace37tJZdjqT
        vf+8rScIIeNbLudlBbuezsB7ffHaOrt0tB0DxLEJeXaQS91jHW8TNEnLTLMNAVrkUFfa52
        4yoyj1SJ0U6VtL6RjQ9XKDC1/T8RNpY=
Date:   Thu, 4 Feb 2021 17:46:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH V3 1/6] x86_64: move cpu_current_top_of_stack out of TSS
Message-ID: <20210204164649.GB32255@zn.tnic>
References: <20210127163231.12709-1-jiangshanlai@gmail.com>
 <20210127163231.12709-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127163231.12709-2-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3 1/6] x86_64: move cpu_current_top_of_stack out of TSS

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone.

Fix all your subjects pls.

On Thu, Jan 28, 2021 at 12:32:17AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> When X86_BUG_CPU_MELTDOWN & KPTI,

Please write that out properly.

> cpu_current_top_of_stack lives in the
> TSS which is also in the user CR3 and it becomes a coveted fruit.  An
> attacker can fetch the kernel stack top from it and continue next steps
> of actions based on the kernel stack.
> 
> The address might not be very usefull for attacker,

You just said it is a "coveted fruit" and now it is not very useful?!
Which is it?

Also, use spellchecker pls.

> but it is not so
> necessary to be in TSS either.  It is only accessed when CR3 is kernel CR3
> and gs_base is kernel gs_base

You mean when at CPL0?

> which means it can be in any percpu variable.
> 
> The major reason it is in TSS might be performance because it is hot in

"might be"?

> cache and tlb since we just access sp2 as the scratch space in syscall.

"TLB"

You can use the comment text directly as it is more precise:

"entry_SYSCALL_64 uses it as scratch space to stash the user RSP value."

> 
> So we can move it to a percpu variable near other hot percpu variables,

Who's "we" ?

Also, from Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

> such as current_task, __preempt_count, and they are in the same
> cache line.
> 
> tools/testing/selftests/seccomp/seccomp_benchmark desn't show any
> performance lost in "getpid native" result.  And actually, the result
> changes from 93ns before patch to 92ns after patch when !KPTI, and the
> test is very stable although the test desn't show a higher degree of
> precision but enough to know it doesn't cause degression for the test.

This paragraph belongs ...

> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---

....

<--- here.

>  arch/x86/include/asm/processor.h   | 10 ----------
>  arch/x86/include/asm/switch_to.h   |  7 +------
>  arch/x86/include/asm/thread_info.h |  6 ------
>  arch/x86/kernel/cpu/common.c       |  3 +++
>  arch/x86/kernel/process.c          |  7 +------
>  arch/x86/mm/pti.c                  |  7 +++----
>  6 files changed, 8 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index c20a52b5534b..886d32da1318 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -314,11 +314,6 @@ struct x86_hw_tss {
>  struct x86_hw_tss {
>  	u32			reserved1;
>  	u64			sp0;
> -
> -	/*
> -	 * We store cpu_current_top_of_stack in sp1 so it's always accessible.
> -	 * Linux does not use ring 1, so sp1 is not otherwise needed.
> -	 */
>  	u64			sp1;
>  
>  	/*
> @@ -428,12 +423,7 @@ struct irq_stack {
>  
>  DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
>  
> -#ifdef CONFIG_X86_32
>  DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
> -#else
> -/* The RO copy can't be accessed with this_cpu_xyz(), so use the RW copy. */
> -#define cpu_current_top_of_stack cpu_tss_rw.x86_tss.sp1
> -#endif
>  
>  #ifdef CONFIG_X86_64
>  struct fixed_percpu_data {
> diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
> index 9f69cc497f4b..b5f0d2ff47e4 100644
> --- a/arch/x86/include/asm/switch_to.h
> +++ b/arch/x86/include/asm/switch_to.h
> @@ -71,12 +71,7 @@ static inline void update_task_stack(struct task_struct *task)
>  	else
>  		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
>  #else
> -	/*
> -	 * x86-64 updates x86_tss.sp1 via cpu_current_top_of_stack. That
> -	 * doesn't work on x86-32 because sp1 and
> -	 * cpu_current_top_of_stack have different values (because of
> -	 * the non-zero stack-padding on 32bit).
> -	 */
> +	/* Xen PV enters the kernel on the thread stack. */

What's that comment here for?

>  	if (static_cpu_has(X86_FEATURE_XENPV))
>  		load_sp0(task_top_of_stack(task));
>  #endif
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 0d751d5da702..3dc93d8df425 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -197,12 +197,6 @@ static inline int arch_within_stack_frames(const void * const stack,
>  #endif
>  }
>  
> -#else /* !__ASSEMBLY__ */
> -
> -#ifdef CONFIG_X86_64
> -# define cpu_current_top_of_stack (cpu_tss_rw + TSS_sp1)
> -#endif
> -
>  #endif
>  
>  #ifdef CONFIG_COMPAT
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 35ad8480c464..f3d7fd7e9684 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1745,6 +1745,9 @@ DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
>  DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
>  EXPORT_PER_CPU_SYMBOL(__preempt_count);
>  
> +DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
> +EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);

... _GPL, of course.

Or lemme rephrase: who's going to cry if this export is _GPL?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
