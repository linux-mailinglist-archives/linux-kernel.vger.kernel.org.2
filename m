Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46D38DFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 05:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhEXD1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 23:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhEXD1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 23:27:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FA2260FE7;
        Mon, 24 May 2021 03:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621826736;
        bh=EDFTkcAwSFOK0FnRgG63bT405VUM1DCJshGwKByLqq8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VpojPf6CSZo4wVFGVUXyrBSVNeOOlOHKh/Saa57vbhrMbnR/pY/RPtdPSw3oSAzcW
         FisMR/BZq2oOBEDqfVNaJL3pwYlrY+MCDi+pTnKxb2Iv0eKg0M7/yLJOTDVc3hK8ss
         1qEJdCJz/tx9CUzj7uHYr8cPS6a4JGnMmRAABpQ+3Ns/FTu6G1uz3YcGfuyHxnQ6zx
         Kq8fZ7d23ot45EpWkj+/nEC1DI/RC0QxUnW7+Kpso7JQcg5C8ZYL3PFT4KzSy6x7Rl
         h4ESTRwypJLcNJGkGQYSJmTRAN3KSwHy7YWpBHeSh4fPYtyyQqewoPR4RwLpaC+Ax9
         zmNoqVMMJ+ovQ==
Subject: Re: [PATCH v5 25/28] x86/fpu/xstate: Skip writing zeros to signal
 frame for dynamic user states if in INIT-state
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        tglx@linutronix.de, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-26-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <6197fd94-76a9-a391-f290-7001a71add7f@kernel.org>
Date:   Sun, 23 May 2021 20:25:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210523193259.26200-26-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/21 12:32 PM, Chang S. Bae wrote:
> By default, for xstate features in the INIT-state, XSAVE writes zeros to
> the uncompressed destination buffer.
> 
> E.g., if you are not using AVX-512, you will still get a bunch of zeros on
> the signal stack where live AVX-512 data would go.
> 
> For 'dynamic user state' (currently only XTILEDATA), explicitly skip this
> data transfer. The result is that the user buffer for the AMX region will
> not be touched by XSAVE.

Why?

> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v4:
> * Added as a new patch.
> ---
>  arch/x86/include/asm/fpu/internal.h | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 4a3436684805..131f2557fc85 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -354,11 +354,27 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
>   */
>  static inline int copy_xregs_to_user(struct xregs_state __user *buf)
>  {
> -	u64 mask = current->thread.fpu.state_mask;
> -	u32 lmask = mask;
> -	u32 hmask = mask >> 32;
> +	u64 state_mask = current->thread.fpu.state_mask;
> +	u64 dynamic_state_mask;
> +	u32 lmask, hmask;
>  	int err;
>  
> +	dynamic_state_mask = state_mask & xfeatures_mask_user_dynamic;
> +	if (dynamic_state_mask && boot_cpu_has(X86_FEATURE_XGETBV1)) {
> +		u64 dynamic_xinuse, dynamic_init;
> +		u64 xinuse = xgetbv(1);
> +
> +		dynamic_xinuse = xinuse & dynamic_state_mask;
> +		dynamic_init = ~(xinuse) & dynamic_state_mask;
> +		if (dynamic_init) {
> +			state_mask &= ~xfeatures_mask_user_dynamic;
> +			state_mask |= dynamic_xinuse;

That's a long-winded way to say:

state_mask &= ~dynamic_init;

But what happens if we don't have the XGETBV1 feature?  Are we making
AMX support depend on XGETBV1?

How does this patch interact with "[PATCH v5 24/28] x86/fpu/xstate: Use
per-task xstate mask for saving xstate in signal frame"?  They seem to
be try to do something similar but not quite the same, and they seem to
be patching the same function.  The result seems odd.

Finally, isn't part of the point that we need to avoid even *allocating*
space for non-AMX-using tasks?  That would require writing out the
compacted format and/or fiddling with XCR0.

