Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854803138B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 16:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhBHP55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 10:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhBHPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:07:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D20C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 07:06:55 -0800 (PST)
Received: from zn.tnic (p200300ec2f073f00a2d14808379c3d02.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3f00:a2d1:4808:379c:3d02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF7111EC04A9;
        Mon,  8 Feb 2021 16:06:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612796812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kpw50PMpLzZImGxZ0E/VD8SzQA6dfPmK2juQkL2Xl7g=;
        b=C+2QvXsAwjNbpnFORlXlJge50Z/MRVSdYe+M2tMcKJR5he7CwRb/MIBEKghM8gOs3veY7w
        aBCw+rWXbDPNw3fuA/0cfT1iRhIzWhxu3lHfqNzjMdCiSXHTzthqeaK25yIjrt6o7Pk/lz
        4Ib2CEFkU9T7fLPc2mWTfNDzIZ+aY2Q=
Date:   Mon, 8 Feb 2021 16:06:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 05/12] x86/irq: Provide macro for inlining irq stack
 switching
Message-ID: <20210208150649.GB18227@zn.tnic>
References: <20210204204903.350275743@linutronix.de>
 <20210204211154.618389756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204211154.618389756@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:49:08PM +0100, Thomas Gleixner wrote:
> The effort to make the ASM entry code slim and unified moved the irq stack
> switching out of the low level ASM code so that the whole return from
> interrupt work and state handling can be done in C and the ASM code just
> handles the low level details of entry and exit.
> 
> This ended up being a suboptimal implementation for various reasons
> (including tooling). The main pain points are:
> 
>  - The indirect call which is expensive thanks to retpoline
> 
>  - The inability to stay on the irq stack for softirq processing on return
>    from interrupt
> 
>  - The fact that the stack switching code ends up being an easy to target
>    exploit gadget.
> 
> Prepare for inlining the stack switching logic into the C entry points by
> providing a ASM macro which contains the guts of the switching mechanism:
> 
>   1) Store RSP at the top of the irq stack
>   2) Switch RSP to the irq stack
>   3) Invoke code
>   4) Pop the original RSP back
> 
> Document the unholy asm() logic while at it to reduce the amount of head
> scratching required a half year from now.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/irq_stack.h |  104 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> --- a/arch/x86/include/asm/irq_stack.h
> +++ b/arch/x86/include/asm/irq_stack.h
> @@ -7,6 +7,110 @@
>  #include <asm/processor.h>
>  
>  #ifdef CONFIG_X86_64
> +
> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
> +# define IRQSTACK_CALL_CONSTRAINT	, ASM_CALL_CONSTRAINT
> +#else
> +# define IRQSTACK_CALL_CONSTRAINT
> +#endif
> +
> +/*
> + * Macro to inline switching to an interrupt stack and invoking function
> + * calls from there. The following rules apply:
> + *
> + * - Ordering:
> + *
> + *   1. Write the stack pointer content into the top most place of

I think "content" is not needed here - just "Write the stack pointer".

> + *	the irq stack. This ensures that the various unwinders can
> + *	link back to the original stack.
> + *
> + *   2. Switch the stack pointer to the top of the irq stack.
> + *
> + *   3. Invoke whatever needs to be done (@asm_call argument)
> + *
> + *   4. Pop the original stack pointer from the top of the irq stack
> + *	which brings it back to the original stack where it left off.
> + *
> + * - Function invocation:
> + *
> + *   To allow flexible usage of the macro, the actual function code including
> + *   the store of the arguments in the call ABI registers is handed in via
> + *   the @asm_call argument.
> + *
> + * - Local variables:
> + *
> + *   @tos:
> + *	The @tos variable holds a pointer to the top of the irq stack and
> + *	_must_ be allocated in a non-callee saved register as this is a
> + *	restriction coming from objtool.
> + *
> + *	Note, that (tos) is both in input and output constraints to ensure
> + *	that the compiler does not assume that R11 is left untouched in
> + *	case this macro is used in some place where the per cpu interrupt
> + *	stack pointer is used again afterwards
> + *
> + * - Function arguments:
> + *        The function argument(s) if any have to be defined in register

Commas:

The function argument(s), if any, ...

> + *	  variables at the place where this is invoked. Storing the
> + *	  argument(s) in the proper register(s) is part of the @asm_call
> + *
> + * - Constraints:
> + *
> + *   The constraints have to be done very carefully because the compiler
> + *   does not know about the assembly call.
> + *
> + *   output:
> + *     As documented already above the @tos variable is required to be in
> + *     the output constraints to make the compiler aware that R11 cannot be
> + *     reused after the asm() statement.
> + *
> + *     For builds with CONFIG_UNWIND_FRAME_POINTER ASM_CALL_CONSTRAINT is
> + *     required as well as this prevents certain creative GCC variants from
> + *     misplacing the ASM code.
> + *
> + *  input:
> + *    - func:
> + *	  Immediate, which tells the compiler that the function is referenced.
> + *
> + *    - tos:
> + *	  Register. The actual register is defined by the variable declaration.
> + *
> + *    - function arguments:
> + *	  The constraints are handed in via the 'argconstr' argument list. They

"argconstr" or "constr"?

> + *	  describe the register arguments which are used in @asm_call.
> + *
> + *  clobbers:
> + *     Function calls can clobber anything except the callee-saved
> + *     registers. Tell the compiler.
> + */
> +#define __call_on_irqstack(func, asm_call, constr...)			\

Does the name need to be prepended with "__"? I don't see a
"call_on_irqstack" variant...

> +{									\
> +	register void *tos asm("r11");					\
> +									\
> +	tos = ((void *)__this_cpu_read(hardirq_stack_ptr));		\
> +									\
> +	asm_inline volatile(						\
> +	"movq	%%rsp, (%[__tos])			\n"		\
> +	"movq	%[__tos], %%rsp				\n"		\
> +									\
> +	asm_call							\
> +									\
> +	"popq	%%rsp					\n"		\
> +									\
> +	: "+r" (tos) IRQSTACK_CALL_CONSTRAINT				\
> +	: [__func] "i" (func), [__tos] "r" (tos) constr			\

I think you can call the symbolic names the same as the variables -
i.e., without the "__" so that there's less confusion when looking at
the code.

> +	: "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10",	\
> +	  "memory"							\
> +	);								\
> +}
> +
> +/* Macros to assert type correctness for run_*_on_irqstack macros */
> +#define assert_function_type(func, proto)				\
> +	static_assert(__builtin_types_compatible_p(typeof(&func), proto))
> +
> +#define assert_arg_type(arg, proto)					\
> +	static_assert(__builtin_types_compatible_p(typeof(arg), proto))
> +
>  static __always_inline bool irqstack_active(void)
>  {
>  	return __this_cpu_read(hardirq_stack_inuse);
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
