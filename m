Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD2041EF52
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354474AbhJAOWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353728AbhJAOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:22:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF478C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:20:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633098016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0hUlrtCXTAgy5CKPp7BEEqhkx2NXZhwV0ktSZBUrsw=;
        b=cd5hP5kRTpDUUBlEfYi94saktnu+MYxtOLjCuZX4hSIE1g8q8IY6wQwFqrbSARdLPNvYX1
        pZ0jVp6LtjNku5MT+rVUT56Om31w0rI8schCC5p6qEdZPp9yBV7rCj6QU4LO/bgGcfoJ82
        +UcqwajVxztXrXsdMn8R9wZUahmvlKbcUYfyib4s5G9BiLfqHbWYBjDAp5TDbp6S9xUrFm
        y+9D9TAy3H+JHOFvMANviydl+NMcceqxP2NH8UW+2DIpwALGpEEmgPODZEIJ2k4dziPfAJ
        2pOGxRn12d55QFJP9JtJ+1kAh9+jGjhtv487wxTHnGA2keDJEmI+Fuu9wbwiXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633098016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0hUlrtCXTAgy5CKPp7BEEqhkx2NXZhwV0ktSZBUrsw=;
        b=ZU380AYDb+oibpmgMY1S3hk8hDOmiiVyli8MoXk0u4cqHqoGMrfHASKsHoQ/qFxRO+eVi5
        rBKvu4MCVdIxkaAg==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v10 09/28] x86/fpu/xstate: Introduce helpers to manage
 the XSTATE buffer dynamically
In-Reply-To: <20210825155413.19673-10-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-10-chang.seok.bae@intel.com>
Date:   Fri, 01 Oct 2021 16:20:16 +0200
Message-ID: <874ka06d3z.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25 2021 at 08:53, Chang S. Bae wrote:
> +/**
> + * calculate_xstate_buf_size_from_mask - Calculate an xstate buffer size
> + * @mask:	A bitmap to tell which components to be saved in the buffer.
> + *
> + * Available once those arrays for the offset, size, and alignment info are
> + * set up, by setup_xstate_features().
> + *
> + * Returns:	The buffer size
> + */
> +unsigned int calculate_xstate_buf_size_from_mask(u64 mask)
> +{
> +	unsigned int size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
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
> +		return fpu_buf_cfg.min_size;
> +	else if (mask == xfeatures_mask_all)
> +		return fpu_buf_cfg.max_size;
> +
> +	nr = fls64(mask) - 1;
> +	if (nr < FIRST_EXTENDED_XFEATURE)
> +		return size;
> +
> +	/*
> +	 * Each state offset in the non-compacted format is fixed. Take the
> +	 * size from the last feature 'nr'.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
> +		return xstate_offsets[nr] + xstate_sizes[nr];
> +
> +	/*
> +	 * With the given mask, no relevant size is found so far. So,
> +	 * calculate it by summing up each state size.
> +	 */
> +	for (i = FIRST_EXTENDED_XFEATURE; i <= nr; i++) {
> +		if (!(mask & BIT_ULL(i)))
> +			continue;
> +
> +		if (xstate_64byte_aligned[i])
> +			size = ALIGN(size, 64);
> +		size += xstate_sizes[i];
> +	}
> +	return size;
> +}

So we have yet another slightly different function to calculate the
buffer size. Why do we still need calculate_xstate_size()?

> +void free_xstate_buffer(struct fpu *fpu)
> +{

Can you please put the check:

> +	if (fpu->state != &fpu->__default_state)

into this function? If it is ever called without checking it and state
points at fpu->__default_state then the explosions are going to be
interesting.

> +	vfree(fpu->state);
> +}
> +
> +/**
> + * realloc_xstate_buffer - Re-alloc a buffer with the size calculated from
> + *			   @mask.
> + *
> + * @fpu:	A struct fpu * pointer
> + * @mask:	The bitmap tells which components to be reserved in the new
> + *		buffer.
> + *
> + * It deals with enlarging the xstate buffer with dynamic states.
> + *
> + * Use vzalloc() simply here. If the task with a vzalloc()-allocated buffer
> + * tends to terminate quickly, vfree()-induced IPIs may be a concern.
> + * Caching may be helpful for this. But the task with large state is likely
> + * to live longer.
> + *
> + * Also, this method does not shrink or reclaim the buffer.
> + *
> + * Returns 0 on success, -ENOMEM on allocation error.
> + */
> +int realloc_xstate_buffer(struct fpu *fpu, u64 mask)
> +{
> +	union fpregs_state *state;
> +	u64 state_mask;
> +
> +	state_mask = fpu->state_mask | mask;
> +	if ((state_mask & fpu->state_mask) == state_mask)
> +		return 0;
> +
> +	state = vzalloc(calculate_xstate_buf_size_from_mask(state_mask));
> +	if (!state)
> +		return -ENOMEM;
> +
> +	/*
> +	 * As long as the register state is intact, save the xstate in the
> +	 * new buffer at the next context switch or ptrace's context
> +	 * injection.

What exactly guarantees that current's xstate is valid in the hardware
registers? This has to be fully preemptible context, otherwise you could
not invoke vzalloc() which can sleep.

Which in turn means that the placement of the exception fixup in a later
patch is broken:

> DEFINE_IDTENTRY(exc_device_not_available)
> {
> 	unsigned long cr0 = read_cr0();
> 
> +	if (handle_xfd_event(&current->thread.fpu, regs))
> +		return;

And no, we are not going to use an atomic allocation for this.

For the other call site from xstateregs_set() the FPU register state is
definitely not live because the task is stopped and the FPU registers
if live belong to the ptracer.

So you really want something like this:

static struct fpregs_state *swap_fpstate(fpu, newstate, mask, size)
{
        old_state = fpu->state;
        fpu->state = newstate;
        fpu->state_mask = mask;
        fpu->state_size = size;
        return old_state != fpu->__default_state ? old_state : NULL;
}

int realloc_xstate_buffer(struct task_struct *tsk, u64 mask)
{
	old_state;
        fpu = tsk->fpu;
        
        size = calc_size(state_mask);
        state = vzalloc(size);
        if (!state)
        	return -ENOMEM;

	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
		fpstate_init_xstate(&state->xsave, state_mask);

        if (tsk != current) {
                // PTRACE ....
        	old_state = swap_fpstate(fpu, state, state_mask, size);
        } else {
                fpregs_lock();
                if (!registers_valid())
                      copy_state(state, fpu->state);
                old_state = swap_fpstate(fpu, state, state_mask, size);
                fpregs_unlock();
        }

        vfree(old_state);
        return 0;
}

And the exception fixup has to move into the irq enabled region. I come
to that patch later.

> @@ -1147,6 +1268,8 @@ static int copy_uabi_to_xstate(struct fpu *fpu, const void *kbuf,
>  	if (validate_user_xstate_header(&hdr))
>  		return -EINVAL;
>  
> +	hdr.xfeatures &= fpu->state_mask;

This is really the wrong patch doing this. This belongs into the one
which introduces fpu->state_mask.

Thanks,

        tglx
