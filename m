Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCC3AF6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhFUUpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 16:45:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:54963 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230447AbhFUUpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 16:45:12 -0400
IronPort-SDR: G3lpmzKch+Gi9Wzqjxan0Zd8KXflbwUEzmNqATFQcYQt6DBuSC7c0H6CASWLroyWUzhd2FLR8n
 1kr4da5wBEMw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="194241842"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="194241842"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 13:42:56 -0700
IronPort-SDR: Zz1oieSByT0AbzSHd3S/FGLfG/Xul+3KaiG3Pbkk8W5cWPXMApjntVIVFZo+joRGfLdFYVkjLd
 q22zquyScbhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="406092054"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2021 13:42:55 -0700
Received: from [10.212.235.252] (kliang2-MOBL.ccr.corp.intel.com [10.212.235.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8C61F5808BA;
        Mon, 21 Jun 2021 13:42:54 -0700 (PDT)
Subject: Re: [patch V3 38/66] x86/fpu/xstate: Sanitize handling of independent
 features
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210618141823.161158090@linutronix.de>
 <20210618143448.745062645@linutronix.de>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e03c080d-34ca-a154-cc4c-b315e1249c1a@linux.intel.com>
Date:   Mon, 21 Jun 2021 16:42:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618143448.745062645@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2021 10:19 AM, Thomas Gleixner wrote:
> The copy functions for the independent features are horribly named and the
> supervisor and independent part is just overengineered.
> 
> The point is that the supplied mask has either to be a subset of the
> independent feature or a subset of the task->fpu.xstate managed features.
> 
> Rewrite it so it checks check for invalid overlaps of these areas in the
> caller supplied feature mask. Rename it so it follows the new naming
> convention for these operations. Mop up the function documentation.
> 
> This allows to use that function for other purposes as well.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> ---


I have tested the LBR Xsave feature. Everything looks good.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> V3: Rename
> ---
>   arch/x86/events/intel/lbr.c       |    6 +-
>   arch/x86/include/asm/fpu/xstate.h |    5 +-
>   arch/x86/kernel/fpu/xstate.c      |   93 +++++++++++++++++++-------------------
>   3 files changed, 53 insertions(+), 51 deletions(-)
> 
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -491,7 +491,7 @@ static void intel_pmu_arch_lbr_xrstors(v
>   {
>   	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
>   
> -	copy_kernel_to_independent_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
> +	xrstors(&task_ctx->xsave, XFEATURE_MASK_LBR);
>   }
>   
>   static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
> @@ -576,7 +576,7 @@ static void intel_pmu_arch_lbr_xsaves(vo
>   {
>   	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
>   
> -	copy_independent_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
> +	xsaves(&task_ctx->xsave, XFEATURE_MASK_LBR);
>   }
>   
>   static void __intel_pmu_lbr_save(void *ctx)
> @@ -992,7 +992,7 @@ static void intel_pmu_arch_lbr_read_xsav
>   		intel_pmu_store_lbr(cpuc, NULL);
>   		return;
>   	}
> -	copy_independent_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
> +	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
>   
>   	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
>   }
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -104,8 +104,9 @@ void *get_xsave_addr(struct xregs_state
>   int xfeature_size(int xfeature_nr);
>   int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
>   int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
> -void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
> -void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask);
> +
> +void xsaves(struct xregs_state *xsave, u64 mask);
> +void xrstors(struct xregs_state *xsave, u64 mask);
>   
>   enum xstate_copy_mode {
>   	XSTATE_COPY_FP,
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1163,75 +1163,76 @@ int copy_sigframe_from_user_to_xstate(st
>   }
>   
>   /**
> - * copy_independent_supervisor_to_kernel() - Save independent supervisor states to
> - *                                           an xsave area
> - * @xstate: A pointer to an xsave area
> - * @mask: Represent the independent supervisor features saved into the xsave area
> + * xsaves - Save selected components to a kernel xstate buffer
> + * @xstate:	Pointer to the buffer
> + * @mask:	Feature mask to select the components to save
>    *
> - * Only the independent supervisor states sets in the mask are saved into the xsave
> - * area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of independent
> - * supervisor feature). Besides the independent supervisor states, the legacy
> - * region and XSAVE header are also saved into the xsave area. The supervisor
> - * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
> - * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
> + * The @xstate buffer must be 64 byte aligned and correctly initialized as
> + * XSAVES does not write the full xstate header. Before first use the
> + * buffer should be zeroed otherwise a consecutive XRSTORS from that buffer
> + * can #GP.
>    *
> - * The xsave area must be 64-bytes aligned.
> + * The feature mask must either be a subset of the independent features or
> + * a subset of the task->fpstate related features
>    */
> -void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
> +void xsaves(struct xregs_state *xstate, u64 mask)
>   {
> -	u64 independent_mask = xfeatures_mask_independent() & mask;
> -	u32 lmask, hmask;
> +	u64 xchk;
>   	int err;
>   
> -	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
> +	if (WARN_ON_FPU(!cpu_feature_enabled(X86_FEATURE_XSAVES)))
>   		return;
> +	/*
> +	 * Validate that this is either a task->fpstate related component
> +	 * subset or an independent one.
> +	 */
> +	if (mask & xfeatures_mask_independent())
> +		xchk = ~xfeatures_mask_independent();
> +	else
> +		xchk = ~xfeatures_mask_all;
>   
> -	if (WARN_ON_FPU(!independent_mask))
> +	if (WARN_ON_ONCE(!mask || mask & xchk))
>   		return;
>   
> -	lmask = independent_mask;
> -	hmask = independent_mask >> 32;
> -
> -	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
> -
> -	/* Should never fault when copying to a kernel buffer */
> -	WARN_ON_FPU(err);
> +	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
> +	WARN_ON_ONCE(err);
>   }
>   
>   /**
> - * copy_kernel_to_independent_supervisor() - Restore independent supervisor states from
> - *                                           an xsave area
> - * @xstate: A pointer to an xsave area
> - * @mask: Represent the independent supervisor features restored from the xsave area
> + * xrstors - Restore selected components from a kernel xstate buffer
> + * @xstate:	Pointer to the buffer
> + * @mask:	Feature mask to select the components to restore
> + *
> + * The @xstate buffer must be 64 byte aligned and correctly initialized
> + * otherwise XRSTORS from that buffer can #GP.
>    *
> - * Only the independent supervisor states sets in the mask are restored from the
> - * xsave area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of
> - * independent supervisor feature). Besides the independent supervisor states, the
> - * legacy region and XSAVE header are also restored from the xsave area. The
> - * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
> - * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
> + * Proper usage is to restore the state which was saved with
> + * xsaves() into @xstate.
>    *
> - * The xsave area must be 64-bytes aligned.
> + * The feature mask must either be a subset of the independent features or
> + * a subset of the task->fpstate related features
>    */
> -void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask)
> +void xrstors(struct xregs_state *xstate, u64 mask)
>   {
> -	u64 independent_mask = xfeatures_mask_independent() & mask;
> -	u32 lmask, hmask;
> +	u64 xchk;
>   	int err;
>   
> -	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
> +	if (WARN_ON_FPU(!cpu_feature_enabled(X86_FEATURE_XSAVES)))
>   		return;
> +	/*
> +	 * Validate that this is either a task->fpstate related component
> +	 * subset or an independent one.
> +	 */
> +	if (mask & xfeatures_mask_independent())
> +		xchk = ~xfeatures_mask_independent();
> +	else
> +		xchk = ~xfeatures_mask_all;
>   
> -	if (WARN_ON_FPU(!independent_mask))
> +	if (WARN_ON_ONCE(!mask || mask & xchk))
>   		return;
>   
> -	lmask = independent_mask;
> -	hmask = independent_mask >> 32;
> -
> -	XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
> -
> -	/* Should never fault when copying from a kernel buffer */
> -	WARN_ON_FPU(err);
> +	XSTATE_OP(XRSTORS, xstate, (u32)mask, (u32)(mask >> 32), err);
> +	WARN_ON_ONCE(err);
>   }
>   
>   #ifdef CONFIG_PROC_PID_ARCH_STATUS
> 
