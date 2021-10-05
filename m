Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76C8421B20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhJEAch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJEAcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:32:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42474C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:30:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633393843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YCfGkDtElmtLQz3Z7FWO/+Yr7CJjM5nW4YUqIn3/8IA=;
        b=Znsr10xPrh65qvfho5cdK/reSy+gISR5NBPNmjgSztYB7YqQvX3JYdD6YeqKYrw9oiOTM0
        hBqvxMitGyvb9Xty11ikc1DR/I9YMAWcmzXLpo71ZBnViHiDADy2kpn63LxOTYDeQvNEBV
        WVlS33TkJzPDcn1bXHvJ/nCjKuNy8bvz3V+x05RJQwHHAstN/JlFvXmuV6tG+5Qvaii0ak
        FLMuAM3jHK4UckybDye6iGl5v2Ya2qByOBPCMlZ/OZP1K8mklkoSoVQwaZ3srwPnoO/WuL
        zB3+Q4I0xy0f2R1oNY2LUEcpVLEem8G49TOtTRG3s9hiSRROma2ZA8ZuX175LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633393843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YCfGkDtElmtLQz3Z7FWO/+Yr7CJjM5nW4YUqIn3/8IA=;
        b=8imkJHteM/Tti5o1OJPr2trOvOFPyCCVBIqC6iUyFdnBobiOph1c+sMJkFeg2brmQx+Thf
        76DbxFcAZrYzATBA==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v11 15/29] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
In-Reply-To: <20211001223728.9309-16-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <20211001223728.9309-16-chang.seok.bae@intel.com>
Date:   Tue, 05 Oct 2021 02:30:43 +0200
Message-ID: <87o884fh3g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01 2021 at 15:37, Chang S. Bae wrote:
> arch_prctl(ARCH_SET_STATE_ENABLE, u64 bitmask)
>     Some XSTATE features, such as AMX, are unavailable to applications
>     until that process explicitly requests them via this call. Requests can
>     be made for any number of valid user XSTATEs in a single call. This
>     call is intended to be invoked very early in process initialization. A
>     forked child inherits access, but permission is reset upon exec. There
>     is no concept of un-requesting XSTATE access.
>     Return codes:
>         0: success (including repeated calls)
>         EINVAL: no hardware feature for the request
>
> arch_prctl(ARCH_GET_STATE_ENABLE, u64 *bitmask)
>     Return the bitmask of permitted user XSTATE features. If XSAVE is
>     disabled, the bitmask indicates only legacy states.
>
> The permission is checked at every XSTATE buffer expansion: e.g.
> XFD-induced #NM event, and ptracer's XSTATE injection. When no permission
> is found, inform userspace via SIGILL or with error code.
>
> For "dynamic" XSTATE features that have XFD hardware support, the kernel
> can enforce that users can not touch state without permission. For state
> that has no XFD support, the kernel can not prevent a user from touching
> that state.
>
> The notion of granted permission is recorded in the group leader only. A
> new task copies its permission bitmask.

while this patch does again way more than the subject suggests and
really should be split into bits and pieces, the prctl is ill defined
and the implementation is partially buggy.

> +	/*
> +	 * @state_perm:
> +	 *
> +	 * This bitmap indicates the permission for state components.
> +	 *
> +	 * Always reference group_leader's value via
> +	 * get_group_state_perm() as it readily represents the process's
> +	 * state permission.
> +	 */
> +	u64				state_perm;

This want's to be __state_perm to denote that this should not be
accessed directly.

Also the only reason to access this is when a task triggers a permission
check vs. it's own permissions and not unconditionally be deferenced all
over the place.

The point is that you don't want to derefence tsk->group_leader if not
absolutely required. That's why I want to have the information in
fpstate which is thread local and has to be accessed anyway.

Only if tsk->fpstate does not provide the permission then the group
leader state has to be checked, i.e. in #NM and ptrace which is a slow
path anyway. In the case that the permission check on the thread local
info fails then the task is either going to be killed or an extended
buffer has to be allocated.

See?

> +/* Require ARCH_SET_STATE_ENABLE for future features  */
> +#define XFEATURE_MASK_PERMISSION_REQUIRED GENMASK_ULL(63, XFEATURE_MAX)

When you add AMX then XFEATURE_MAX is going to be past AMX. And no, even
if you fix that up later in weird ways, this does not make sense.

> +/**
> + * get_group_state_perm - Get a per-process state permission
> + * @tsk:	A struct task_struct * pointer
> + * Return:	A bitmap to indicate state permission.
> + */
> +static inline u64 get_group_state_perm(struct task_struct *tsk)
> +{
> +	return tsk->group_leader->thread.fpu.state_perm;

This needs a READ_ONCE() because it can be concurrently modified and the
read is lockless. Which means that the write side needs a WRITE_ONCE(),
but see below.

> +}
> +
> +/**
> + * state_permitted - Check a task's permission for indicated features.

state_permitted and all the other state names are way too broad. This is
about xstate and not about random states. We have name spaces for a
reason.

> +#define ARCH_SET_STATE_ENABLE	0x1021
> +#define ARCH_GET_STATE_ENABLE	0x1022

This is about XSTATE components and should be named as such,
i.e. something which is entirely clear, e.g. _XCOMP_ because that is
what this is about. More below.

Aside of that why does this not start with the obvious and simple prctl
option to retrieve the possible supported features?

> +/**
> + * reset_state_perm - Reset a task's permission for dynamic user state
> + *
> + * It is expected to call at exec in which one task runs in a process.
> + *
> + * @task:	A struct task_struct * pointer
> + */
> +void reset_state_perm(struct task_struct *tsk)
> +{
> +	struct fpu *fpu = &tsk->thread.fpu;
> +
> +	fpu->state_perm = xfeatures_mask_all & ~xfeatures_mask_user_perm();
> +
> +	if (!xfeatures_mask_user_dynamic ||
> +	    !(fpu->state_mask & xfeatures_mask_user_dynamic))
> +		return;
> +
> +	WARN_ON(tsk->signal->nr_threads > 1);

Why? The only two callers are from set_personality*().

Aside of that why are you doing this from set_personality()?

This has absolutely nothing to do with set_personality() which is
exclusively about native and compat format of the executable.

At the point where set_personality() is invoked the task which does
exec() has already invoked flush_thread(), which invokes
fpu_flush_thread() which in turn resets the FPU state...

So what?

> +/**
> + * do_arch_prctl_state - Read or write the state permission.
> + * @fpu:	A struct task_struct * pointer

fpu != tsk

Also yuck, that task argument is silly because task cannot be anything
else than current, but that's not your fault.

> + * @option:	A subfunction of arch_prctl()
> + * @arg2:	Either a pointer to userspace memory or state-component
> + *		bitmap value.
> + * Return:	0 if successful; otherwise, return a relevant error code.
> + */
> +long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2)
> +{
> +	u64 features_mask;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_FPU))
> +		features_mask = 0;
> +	else if (use_fxsr())
> +		features_mask = XFEATURE_MASK_FPSSE;
> +	else
> +		features_mask = XFEATURE_MASK_FP;

Why? This feature mask should be evaluated once and not over and over again.

> +	switch (option) {
> +	case ARCH_SET_STATE_ENABLE: {
> +		u64 state_perm = arg2;

This does nowhere mention in the comments above that this limits the
available state space to 32bit for 32bit tasks running on a 64 bit
kernel. I don't think it's a problem, but it has to be documented.

> +
> +		if (use_xsave())
> +			features_mask = xfeatures_mask_uabi();
> +
> +		if (state_perm & ~features_mask)
> +			return -EINVAL;
> +
> +		state_perm &= xfeatures_mask_user_perm();
> +		if (!state_perm)
> +			return 0;

I really do not get the semantics of this prctl at all.

GET stores _all_ permitted bits in the user space variable which makes
sense.

SET is just accepting everything except not supported bits, but as it
takes a feature bitmask it suggests that this sets the xfeature bits
which are available for the task or the process.

How does prctl(..., SET, 0) make sense?

It does not make any sense at all. There is no support for downgrading
the permitted features:

    1) Default features up to AVX512 cannot be disabled
    
    2) Once AMX (or any upcoming state) is enabled there is not way back.

So no. This really want's to be

   prctl(SET, xfeature_number)

and not something which is semanticaly ill defined.

> +		tsk->group_leader->thread.fpu.state_perm |= state_perm;

While this "works" with a single permission controlled state this is
completely broken once more permission controlled states come into play
when tasks of the same process invoke this concurrently and request
different features.

> +		return 0;
> +	}
> +	case ARCH_GET_STATE_ENABLE: {
> +		if (use_xsave())
> +			features_mask = get_group_state_perm(tsk);
> +
> +		return put_user(features_mask, (unsigned long __user *)arg2);

This is broken for 32bit kernels. The prctl is unconditional and
therefore this needs to be a *u64 cast.

Thanks,

        tglx

