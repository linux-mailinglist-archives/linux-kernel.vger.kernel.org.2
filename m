Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D995E39A959
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFCRkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhFCRkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:40:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CF2961359;
        Thu,  3 Jun 2021 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622741914;
        bh=mbA/RbQu9W1QdRb3EfA6YF6E9+vaRvVXQpsVRjvSbG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LsjAGp3wAJiRQCvZRhbwnJPpwoP9mtl7zm2JsxIy0VL9C3KOH87jHO2b4NgIdo0wW
         ElxNf8QYQ5k+7x/jd9isS3g/NZXxdo1Qn0JOG9JwVfE1cfrcVWbNgC+l1HJtannDd3
         V6vFoPlpqobZJMWHRSyYmTwGQM2SEfVC2mRW8uBGk7XyNshi/crcEyBREz+MDtMqgY
         L9/YNT4zBcoi0n3TFNjHBhvFtFwO5E3sR+EBu+1duQ+UCmrGpJp7CvkRIiHsVsxRB5
         aN8gLnhAIpK4+FeCLEnNvc85njGsvViMb98t9bAv/bE2jnLB3FykZdeWEgG0ECf0k4
         Ye0p4MBA0d7Aw==
Subject: Re: [RFC PATCH 4/4] x86/entry/nmi: unmask NMIs on userspace NMI when
 entry debugging
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
 <20210601065217.23540-5-jiangshanlai@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <d487b2db-7179-285a-01d5-2f47c3a5bc47@kernel.org>
Date:   Thu, 3 Jun 2021 10:38:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210601065217.23540-5-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 11:52 PM, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>

Why?

> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_64.S | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index f54e06139d4b..309e63f4f391 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1055,6 +1055,24 @@ SYM_CODE_START_LOCAL(error_return)
>  	jmp	swapgs_restore_regs_and_return_to_usermode
>  SYM_CODE_END(error_return)
>  
> +.macro debug_entry_unmask_NMIs
> +#ifdef CONFIG_DEBUG_ENTRY
> +	/*
> +	 * For ease of testing, unmask NMIs right away.  Disabled by
> +	 * default because IRET is very expensive.
> +	 */
> +	pushq	$0		/* SS */
> +	pushq	%rsp		/* RSP (minus 8 because of the previous push) */
> +	addq	$8, (%rsp)	/* Fix up RSP */
> +	pushfq			/* RFLAGS */
> +	pushq	$__KERNEL_CS	/* CS */
> +	pushq	$1f		/* RIP */
> +	iretq			/* continues with NMI unmasked */
> +	UNWIND_HINT_IRET_REGS
> +1:
> +#endif
> +.endm
> +
>  /*
>   * Runs on exception stack.  Xen PV does not go through this path at all,
>   * so we can use real assembly here.
> @@ -1145,6 +1163,7 @@ SYM_CODE_START(asm_exc_nmi)
>  	 * At this point we no longer need to worry about stack damage
>  	 * due to nesting -- we're done with the NMI stack.
>  	 */
> +	debug_entry_unmask_NMIs
>  	pushq	$-1		/* pt_regs->orig_ax */
>  	idtentry_body exc_nmi has_error_code=0
>  
> @@ -1286,22 +1305,7 @@ first_nmi:
>  	UNWIND_HINT_IRET_REGS
>  
>  	/* Everything up to here is safe from nested NMIs */
> -
> -#ifdef CONFIG_DEBUG_ENTRY
> -	/*
> -	 * For ease of testing, unmask NMIs right away.  Disabled by
> -	 * default because IRET is very expensive.
> -	 */
> -	pushq	$0		/* SS */
> -	pushq	%rsp		/* RSP (minus 8 because of the previous push) */
> -	addq	$8, (%rsp)	/* Fix up RSP */
> -	pushfq			/* RFLAGS */
> -	pushq	$__KERNEL_CS	/* CS */
> -	pushq	$1f		/* RIP */
> -	iretq			/* continues at repeat_nmi below */
> -	UNWIND_HINT_IRET_REGS
> -1:
> -#endif
> +	debug_entry_unmask_NMIs
>  
>  repeat_nmi:
>  	/*
> 

