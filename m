Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945483EAB31
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhHLTos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhHLToo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:44:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A043C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:44:19 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f83008ecfd9239c4ebf0f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8300:8ecf:d923:9c4e:bf0f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0CC221EC046C;
        Thu, 12 Aug 2021 21:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628797453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9G4EkbfeombliKQhvOqtGKmyaWjVIapqiFj62900Fhw=;
        b=IB/mlNX/0dnC9C1EwC6DGvMyRAd2WIMCB5lZlpud17fCDgkgRXOGNWbBstRRVK6CW1YDF0
        9ypk3Jz8px/HA5qSIeLkvavbbu2M3jAg+WbvBOT0oNcbD4ra0dt2a8ANkIylYb6IvZEIno
        fmdaGyNHxTYemaj1xT3iFTJqULQPX38=
Date:   Thu, 12 Aug 2021 21:44:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Message-ID: <YRV6M1I/GMXwuJqW@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210730145957.7927-9-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 07:59:39AM -0700, Chang S. Bae wrote:
> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> index c7826708f27f..c0192e16cadb 100644
> --- a/arch/x86/include/asm/fpu/types.h
> +++ b/arch/x86/include/asm/fpu/types.h
> @@ -336,6 +336,14 @@ struct fpu {
>  	 */
>  	unsigned long			avx512_timestamp;
>  
> +	/*
> +	 * @state_mask:
> +	 *
> +	 * The bitmap represents state components reserved to be saved in
> +	 * ->state.

What does "reserved to be saved in" even mean?

> +	 */
> +	u64				state_mask;
> +
>  	/*
>  	 * @state:
>  	 *
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index d722e774a9f9..45735441fbe8 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -146,6 +146,9 @@ extern unsigned int get_xstate_config(enum xstate_config cfg);
>  void set_xstate_config(enum xstate_config cfg, unsigned int value);
>  
>  void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
> +unsigned int get_xstate_size(u64 mask);
> +int alloc_xstate_buffer(struct fpu *fpu, u64 mask);
> +void free_xstate_buffer(struct fpu *fpu);
>  int xfeature_size(int xfeature_nr);
>  int copy_uabi_from_kernel_to_xstate(struct fpu *fpu, const void *kbuf);
>  int copy_sigframe_from_user_to_xstate(struct fpu *fpu, const void __user *ubuf);
> diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
> index ef82f4824ce7..b691c2db47c7 100644
> --- a/arch/x86/include/asm/trace/fpu.h
> +++ b/arch/x86/include/asm/trace/fpu.h
> @@ -89,6 +89,11 @@ DEFINE_EVENT(x86_fpu, x86_fpu_xstate_check_failed,
>  	TP_ARGS(fpu)
>  );
>  
> +DEFINE_EVENT(x86_fpu, x86_fpu_xstate_alloc_failed,
> +	TP_PROTO(struct fpu *fpu),
> +	TP_ARGS(fpu)

Last time I said:

"Yes, add it when it is really needed. Not slapping it proactively and
hoping for any potential usage."

Why is that thing still here?!

> @@ -380,6 +381,9 @@ static void fpu_reset_fpstate(void)
>  	 * flush_thread().
>  	 */
>  	memcpy(fpu->state, &init_fpstate, init_fpstate_copy_size());
> +	/* Adjust the xstate buffer format for current. */
> +	if (boot_cpu_has(X86_FEATURE_XSAVES))

cpu_feature_enabled

> +		fpstate_init_xstate(&fpu->state->xsave, fpu->state_mask);

<---- newline here.

>  	set_thread_flag(TIF_NEED_FPU_LOAD);
>  	fpregs_unlock();
>  }
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 5f58dca4c6b7..26f6d5e0f1ed 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -10,6 +10,7 @@
>  #include <linux/pkeys.h>
>  #include <linux/seq_file.h>
>  #include <linux/proc_fs.h>
> +#include <linux/vmalloc.h>
>  
>  #include <asm/fpu/api.h>
>  #include <asm/fpu/internal.h>
> @@ -19,6 +20,7 @@
>  
>  #include <asm/tlbflush.h>
>  #include <asm/cpufeature.h>
> +#include <asm/trace/fpu.h>
>  
>  /*
>   * Although we spell it out in here, the Processor Trace
> @@ -76,6 +78,12 @@ static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
>  	{ [ 0 ... XFEATURE_MAX - 1] = -1};
>  static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init =
>  	{ [ 0 ... XFEATURE_MAX - 1] = -1};
> +/*
> + * True if the buffer of the corresponding XFEATURE is located on the next 64
> + * byte boundary. Otherwise, it follows the preceding component immediately.
> + */
> +static bool xstate_aligns[XFEATURE_MAX] __ro_after_init =

Then call that thing xstate_64byte_aligned[] to denote *exactly* what it
contains.

> +	{ [ 0 ... XFEATURE_MAX - 1] = false};
>  
>  /**
>   * struct fpu_xstate_buffer_config - xstate buffer configuration
> @@ -174,6 +182,55 @@ static bool xfeature_is_supervisor(int xfeature_nr)
>  	return ecx & 1;
>  }
>  
> +/**
> + * get_xstate_size - Calculate an xstate buffer size

calculate_xstate_buf_size_from_mask()

if anything. This name is deceivingly generic.

> + * @mask:	This bitmap tells which components reserved in the buffer.

are reserved?

What's this notion of reservation here? The mask is dictating what gets
reserved in the buffer or what?

Looking at the usage, that mask is simply saying which components are
going to be saved in the buffer. So all this "reserved" bla is only
confusing - drop it.

> + *
> + * Available once those arrays for the offset, size, and alignment info are
> + * set up, by setup_xstate_features().
> + *
> + * Returns:	The buffer size
> + */
> +unsigned int get_xstate_size(u64 mask)
> +{
> +	unsigned int size;
> +	int i, nr;
> +
> +	if (!mask)
> +		return 0;
> +
> +	/*
> +	 * The minimum buffer size excludes the dynamic user state. When a
> +	 * task uses the state, the buffer can grow up to the max size.
> +	 */
> +	if (mask == (xfeatures_mask_all & ~xfeatures_mask_user_dynamic))
> +		return get_xstate_config(XSTATE_MIN_SIZE);
> +	else if (mask == xfeatures_mask_all)
> +		return get_xstate_config(XSTATE_MAX_SIZE);
> +
> +	nr = fls64(mask) - 1;
> +
> +	if (!boot_cpu_has(X86_FEATURE_XSAVES))

cpu_feature_enabled()

> +		return xstate_offsets[nr] + xstate_sizes[nr];

From all the superfluous commenting, where a comment is really needed is
here but there's none.

What's that doing? No compacted states enabled so take the offset and
size of the *last* state and use that as the buffer size?

> +
> +	if ((xfeatures_mask_all & (BIT_ULL(nr + 1) - 1)) == mask)
				  ^^^^^^^^^^^^^^^^^^^^^


That thing looks like a GENMASK_ULL() thing. Use it?

Also, what is that test doing?!

If a mask up to nr ANDed with mask_all is == mask?!

You need to explain yourself a lot more here what you're doing. Why
those two special cases if you can simply iterate over the extended
states and be done with it? Except maybe the first two special cases
which are trivial...

> @@ -848,6 +908,9 @@ void __init fpu__init_system_xstate(void)
>  	if (err)
>  		goto out_disable;
>  
> +	/* Make sure init_task does not include the dynamic user states. */

My constant review question: why?

I probably should put it on a t-shirt.

> +	current->thread.fpu.state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
> +
>  	/*
>  	 * Update info used for ptrace frames; use standard-format size and no
>  	 * supervisor xstates:
> @@ -1038,6 +1101,70 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  }
>  #endif /* ! CONFIG_ARCH_HAS_PKEYS */
>  
> +void free_xstate_buffer(struct fpu *fpu)
> +{
> +	/* Free up only the dynamically-allocated memory. */

This belongs above the function along with an explanation when it needs
to be called.

> +	if (fpu->state != &fpu->__default_state)
> +		vfree(fpu->state);
> +}


> +
> +/**
> + * alloc_xstate_buffer - Allocate a buffer with the size calculated from

This name doesn't even begin to tell me that this function deals with
enlarging the xstate buffer with dynamic states. How is the caller
supposed to know?

Also, you need to move all possible xfeatures_mask_user_dynamic querying
inside it so that its user doesn't have to do it. I'm looking at the
callsite in xstateregs_set().

The other callsite in exc_device_not_available() seems to not check the
dynamic states but uses only XFD. I guess I'll parse that properly when
I get there but right now I have no clue why you're not checking the
dynamic mask there.

> + *			 @mask.
> + *
> + * @fpu:	A struct fpu * pointer
> + * @mask:	The bitmap tells which components to be reserved in the new
> + *		buffer.
> + *
> + * Use vmalloc() simply here. If the task with a vmalloc()-allocated buffer

vzalloc

> + * tends to terminate quickly, vfree()-induced IPIs may be a concern.
> + * Caching may be helpful for this. But the task with large state is likely
> + * to live longer.
> + *
> + * Also, this method does not shrink or reclaim the buffer.
> + *
> + * Returns 0 on success, -ENOMEM on allocation error.
> + */
> +int alloc_xstate_buffer(struct fpu *fpu, u64 mask)
> +{
> +	union fpregs_state *state;
> +	unsigned int oldsz, newsz;
> +	u64 state_mask;
> +
> +	state_mask = fpu->state_mask | mask;
> +
> +	oldsz = get_xstate_size(fpu->state_mask);
> +	newsz = get_xstate_size(state_mask);
> +
> +	if (oldsz >= newsz)
> +		return 0;

Why?

Why not simply:

	if (fpu->state_mask == mask)
		return 0;

	/* vzalloc */

	/* free the old buffer */
	free_xstate_buffer(fpu);

	fpu->state = state;
	...

?

Our FPU code is a mess - you should try not to make it an even bigger
one without a good reason.

> +
> +	state = vzalloc(newsz);
> +	if (!state) {
> +		/*
> +		 * When allocation requested from #NM, the error code may
> +		 * not be populated well. Then, this tracepoint is useful
> +		 * for providing the failure context.
> +		 */
> +		trace_x86_fpu_xstate_alloc_failed(fpu);
> +		return -ENOMEM;

What happens with the old buffer here? It seems we leak it...

> +	}
> +
> +	if (boot_cpu_has(X86_FEATURE_XSAVES))

cpu_feature_enabled


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
