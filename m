Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25E531327F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBHMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:38:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231929AbhBHMeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:34:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0EDBB0C6;
        Mon,  8 Feb 2021 12:33:33 +0000 (UTC)
Date:   Mon, 8 Feb 2021 13:33:30 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        jing2.liu@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/21] x86/fpu/xstate: Define the scope of the initial
 xstate data
Message-ID: <20210208123330.GE17908@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-9-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223155717.19556-9-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 07:57:04AM -0800, Chang S. Bae wrote:
> init_fpstate is used to record the initial xstate value for convenience

convenience?

> and covers all the states. But it is wasteful to cover large states all
> with trivial initial data.
> 
> Limit init_fpstate by clarifying its size and coverage, which are all but
> dynamic user states. The dynamic states are assumed to be large but having
> initial data with zeros.
> 
> No functional change until the kernel supports dynamic user states.

What does that mean?

This patch either makes no functional change or it does...

> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v2:
> * Updated the changelog for clarification.
> * Updated the code comments.
> ---
>  arch/x86/include/asm/fpu/internal.h | 18 +++++++++++++++---
>  arch/x86/include/asm/fpu/xstate.h   |  1 +
>  arch/x86/kernel/fpu/core.c          |  4 ++--
>  arch/x86/kernel/fpu/xstate.c        |  4 ++--
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 37ea5e37f21c..bbdd304719c6 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -80,6 +80,18 @@ static __always_inline __pure bool use_fxsr(void)
>  
>  extern union fpregs_state init_fpstate;
>  
> +static inline u64 get_init_fpstate_mask(void)
> +{
> +	/* init_fpstate covers states in fpu->state. */
> +	return (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
> +}

If you're going to introduce such a helper, then use it everywhere in the code:

$ git grep "xfeatures_mask_all & ~xfeatures_mask_user_dynamic"
arch/x86/kernel/fpu/core.c:239: dst_fpu->state_mask = xfeatures_mask_all & ~xfeatures_mask_user_dynamic;
arch/x86/kernel/fpu/xstate.c:148:       else if (mask == (xfeatures_mask_all & ~xfeatures_mask_user_dynamic))
arch/x86/kernel/fpu/xstate.c:932:       current->thread.fpu.state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);

and if you do that, do that in a separate pre-patch which does only this
conversion.

> +static inline unsigned int get_init_fpstate_size(void)
> +{
> +	/* fpu->state size is aligned with the init_fpstate size. */
> +	return fpu_kernel_xstate_min_size;
> +}
> +
>  extern void fpstate_init(struct fpu *fpu);
>  #ifdef CONFIG_MATH_EMULATION
>  extern void fpstate_init_soft(struct swregs_state *soft);
> @@ -269,12 +281,12 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
>  		     : "memory")
>  
>  /*
> - * This function is called only during boot time when x86 caps are not set
> - * up and alternative can not be used yet.
> + * Use this function to dump the initial state, only during boot time when x86
> + * caps not set up and alternative not available yet.
>   */

What's the point of this change? Also, "dump"?!

>  static inline void copy_xregs_to_kernel_booting(struct xregs_state *xstate)
>  {
> -	u64 mask = xfeatures_mask_all;
> +	u64 mask = get_init_fpstate_mask();
>  	u32 lmask = mask;
>  	u32 hmask = mask >> 32;
>  	int err;
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 379e8f8b8440..62f6583f34fa 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -103,6 +103,7 @@ extern void __init update_regset_xstate_info(unsigned int size,
>  					     u64 xstate_mask);
>  
>  void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
> +unsigned int get_xstate_size(u64 mask);
>  int alloc_xstate_buffer(struct fpu *fpu, u64 mask);
>  void free_xstate_buffer(struct fpu *fpu);
>  
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 6dafed34be4f..aad1a7102096 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -206,10 +206,10 @@ void fpstate_init(struct fpu *fpu)
>  		return;
>  	}
>  
> -	memset(state, 0, fpu_kernel_xstate_min_size);
> +	memset(state, 0, fpu ? get_xstate_size(fpu->state_mask) : get_init_fpstate_size());
>  
>  	if (static_cpu_has(X86_FEATURE_XSAVES))
> -		fpstate_init_xstate(&state->xsave, xfeatures_mask_all);
> +		fpstate_init_xstate(&state->xsave, fpu ? fpu->state_mask : get_init_fpstate_mask());

<---- newline here.

>  	if (static_cpu_has(X86_FEATURE_FXSR))
>  		fpstate_init_fxstate(&state->fxsave);
>  	else

...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
