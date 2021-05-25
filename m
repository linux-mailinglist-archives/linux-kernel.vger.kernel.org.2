Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D75C3905CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhEYPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:48:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:64988 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230013AbhEYPsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:48:19 -0400
IronPort-SDR: AmNJCARHIOCLALXqjFWtjPTpVCWtfwxznPEmYHESIQ95Msq7PpuPEibe8IHU4kLlhYjjlUh4tF
 dSYeEidhjBHA==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202262489"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="202262489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 08:46:46 -0700
IronPort-SDR: xh8CJL/T9z4eWn8IcOO9sF5FWO6L1K5jeytA2MlalmzUmHzA4hFQaohbn+J6w0p7mgVoqufjnQ
 7Fw5OYpaza6w==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="442595574"
Received: from heperezr-mobl1.amr.corp.intel.com (HELO [10.255.229.92]) ([10.255.229.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 08:46:45 -0700
Subject: Re: [PATCH v5 15/28] x86/arch_prctl: Create
 ARCH_GET_XSTATE/ARCH_PUT_XSTATE
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, jing2.liu@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-16-chang.seok.bae@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <cfd7a4bd-4381-4128-c193-e767a2cc9686@intel.com>
Date:   Tue, 25 May 2021 08:46:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210523193259.26200-16-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel enforces access to the specified using XFD hardware support. By
> default, XFD is armed and results in #NM traps on un-authorized access.
> Upon successful ARCH_GET_XSTATE, XFD traps are dis-armed and the user is
> free to access the feature.

Does this really need to talk about XFD?

I also don't really like this talking about being "authorized" or not.
Isn't this interface simply to give userspace the opportunity to
deterministically avoid being killed by signals from ENOMEM during a #NM?

I'd also define the behavior a bit more generically.  Maybe:

After a successful ARCH_GET_XSTATE, the kernel guarantees that no #NM
exception will be generated for access to any of the specified XSAVE
features.  This guarantee will persist until at least the point where a
ARCH_PUT_XSTATE operation occurs, possibly longer.

The kernel may choose to return an error for any ARCH_GET_XSTATE request
at any time, even if a prior one succeeds.  This might be as a result of
a memory allocation failure, resource exhaustion, or exceeding the
implementations limits for "outstanding" ARCH_GET_XSTATE operations.

The kernel may return errors if the number of ARCH_PUT_XSTATE operations
for a given XSAVE feature exceed the number of ARCH_GET_XSTATE operations.

--

Note that there's no discussion of XFD.

> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 25c9c7dad3f9..016c3adebec3 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -254,6 +254,8 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
> 
>  	WARN_ON_FPU(src_fpu != &current->thread.fpu);
> 
> +	dst_fpu->refcount = NULL;

For the future, don't forget to call out the fork/exec() behavior.

>  	/*
>  	 * The child does not inherit the dynamic states. Thus, use the buffer
>  	 * embedded in struct task_struct, which has the minimum size.
> @@ -541,3 +543,15 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
>  	 */
>  	return 0;
>  }
> +
> +/**
> + * free_fpu() - Free up memory that belongs to the FPU context.
> + * @fpu:	A struct fpu * pointer
> + *
> + * Return:	Nothing
> + */
> +void free_fpu(struct fpu *fpu)
> +{
> +	kfree(fpu->refcount);
> +	free_xstate_buffer(fpu);
> +}

FWIW, I don't think that needs a formal kdoc comment.

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index e60a20a1b24b..126c4a509669 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -21,6 +21,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/trace/fpu.h>
> +#include <asm/prctl.h>
> 
>  /*
>   * Although we spell it out in here, the Processor Trace
> @@ -78,6 +79,11 @@ static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] = { [ 0 ... XFE
>   * byte boundary. Otherwise, it follows the preceding component immediately.
>   */
>  static bool xstate_aligns[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = false};
> +/*
> + * Remember the index number in the reference counter array that supports
> + * access request. '-1' indicates that a state component does not support it.
> + */
> +static unsigned int xstate_refcount_idx[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};

For now when we have a single feature, isn't this overkill?  Also, even
if you decide to keep this, there are only 63 possible XSAVE features.
We don't need 'unsigned int' for storing a maximum value of 63.

>  /**
>   * struct fpu_xstate_buffer_config - xstate per-task buffer configuration
> @@ -969,8 +975,7 @@ void __init fpu__init_system_xstate(void)
>  {
>  	unsigned int eax, ebx, ecx, edx;
>  	static int on_boot_cpu __initdata = 1;
> -	int err;
> -	int i;
> +	int err, i, j;
> 
>  	WARN_ON_FPU(!on_boot_cpu);
>  	on_boot_cpu = 0;
> @@ -1025,14 +1030,17 @@ void __init fpu__init_system_xstate(void)
>  	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
>  	xfeatures_mask_user_dynamic = 0;
> 
> -	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
> +	for (i = FIRST_EXTENDED_XFEATURE, j = 0; i < XFEATURE_MAX; i++) {
>  		u64 feature_mask = BIT_ULL(i);
> 
>  		if (!(xfeatures_mask_user() & feature_mask))
>  			continue;
> 
> -		if (xfd_supported(i))
> +		if (xfd_supported(i)) {
>  			xfeatures_mask_user_dynamic |= feature_mask;
> +			xstate_refcount_idx[i] = j;
> +			j++;
> +		}
>  	}
> 
>  	/* Enable xstate instructions to be able to continue with initialization: */
> @@ -1339,6 +1347,93 @@ int alloc_xstate_buffer(struct fpu *fpu, u64 mask)
>  	return 0;
>  }
> 
> +/**
> + * do_arch_prctl_xstate() - Handle xstate-related arch_prctl requests.

Not the most helpful patch description.

> + * @fpu:	A struct fpu * pointer
> + * @option:	A subfunction of arch_prctl()
> + * @mask:	A xstate-component bitmap
> + *
> + * Return:	0 if successful; otherwise, return a relevant error code.
> + */
> +long do_arch_prctl_xstate(struct fpu *fpu, int option, unsigned long mask)
> +{
> +	bool need_xfd_update = false;
> +	int i;
> +
> +	switch (option) {
> +	case ARCH_GET_XSTATE: {
> +		int err = 0;
> +
> +		if (mask & ~xfeatures_mask_user())
> +			return -EPERM;

This would also return -EPERM for unknown features.  That's a bit odd.

How about just -EINVAL, to cover all cases: supervisor or unknown?

> +		if (!fpu->refcount) {
> +			fpu->refcount = kcalloc(hweight64(xfeatures_mask_user_dynamic),
> +						sizeof(int), GFP_KERNEL);
> +			if (!fpu->refcount)
> +				return -ENOMEM;
> +		}

If someone calls this on a non-XFD system, this kcalloc() will fail.
It's a bit odd that if I say "get XSTATE_FP", it returns -ENOMEM.

Maybe you could check 'mask" against xfeatures_mask_user_dynamic up front.

IIRC, this dynamic allocation costs 32 bytes of kmalloc() space for a
single integer, plus the pointer.  This would be simpler, faster and
smaller if just a single XFD feature was supported for now.

> +		for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
> +			unsigned int idx = xstate_refcount_idx[i];
> +
> +			if ((idx == -1) || !(BIT_ULL(i) & mask))
> +				continue;
> +
> +			if (fpu->refcount[idx] == INT_MAX)
> +				return -EINVAL;
> +
> +			fpu->refcount[idx]++;
> +		}

Let's say you have 5 xfeatures that support XFD.  The first 4 have their
fpu->refcount[]++ and the fifth hits the limit.  This will bump those 4
refcounts and then return -EINVAL.  How could the user ever recover from
that?

Also, a few comments in here would really help.  It's bare and fairly
hard to grok at the moment.  I *think* it's guaranteed by this point
that at least *ONE* refcount has to be bumped (or the kcalloc() would
fail), but it took me a while to convince myself that it works.

> +		if ((mask & fpu->state_mask) == mask)
> +			return 0;
> +
> +		err = alloc_xstate_buffer(fpu, mask);
> +		if (!err)
> +			need_xfd_update = true;
> +		else
> +			return err;

'return' without dropping the refcounts?

> +		break;
> +	}
> +	case ARCH_PUT_XSTATE: {
> +		if (mask & ~xfeatures_mask_user())
> +			return -EPERM;
> +
> +		if (!fpu->refcount)
> +			return -EINVAL;

This needs a comment:

		/* No successful GET_XSTATE was ever performed */

> +		for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
> +			int idx = xstate_refcount_idx[i];
> +			u64 feature_mask = BIT_ULL(i);
> +
> +			if ((idx == -1) || !(feature_mask & mask))
> +				continue;
> +
> +			if (fpu->refcount[idx] <= 0)
> +				return -EINVAL;

This has the same bug as the upper loop.

> +			fpu->refcount[idx]--;
> +			if (!fpu->refcount[idx]) {
> +				need_xfd_update = true;
> +				fpu->state_mask &= ~(feature_mask);
> +			}

Because of that bug, it's possible to return from this without getting
to the 'need_xfd_update' below.

> +		}
> +		break;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (need_xfd_update) {
> +		u64 fpu_xfd_mask = fpu->state_mask & xfd_capable();
> +
> +		xfd_write(xfd_capable() ^ fpu_xfd_mask);
> +	}
> +	return 0;
> +}
> +
>  static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
>  {
>  	if (*last >= offset)
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 5252464a27e3..c166243f64e4 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -98,6 +98,12 @@ void arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
>  	*size = get_xstate_config(XSTATE_MIN_SIZE);
>  }
> 
> +void arch_release_task_struct(struct task_struct *tsk)
> +{
> +	if (boot_cpu_has(X86_FEATURE_FPU))
> +		free_fpu(&tsk->thread.fpu);
> +}
> +
>  /*
>   * Free thread data structures etc..
>   */
> @@ -990,13 +996,16 @@ unsigned long get_wchan(struct task_struct *p)
>  }
> 
>  long do_arch_prctl_common(struct task_struct *task, int option,
> -			  unsigned long cpuid_enabled)
> +			  unsigned long arg2)
>  {
>  	switch (option) {
>  	case ARCH_GET_CPUID:
>  		return get_cpuid_mode();
>  	case ARCH_SET_CPUID:
> -		return set_cpuid_mode(task, cpuid_enabled);
> +		return set_cpuid_mode(task, arg2);
> +	case ARCH_GET_XSTATE:
> +	case ARCH_PUT_XSTATE:
> +		return do_arch_prctl_xstate(&task->thread.fpu, option, arg2);
>  	}
> 
>  	return -EINVAL;
> --
> 2.17.1
> 

