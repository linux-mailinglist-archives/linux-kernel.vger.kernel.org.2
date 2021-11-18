Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD438455FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhKRP5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 10:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhKRP5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 10:57:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E44DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 07:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wt52NzKLJyhGGE5ZYNYIxdwq+HKe3NAkMCE4yDKMlYo=; b=RHrRmCnFavFRJLxFPQXoQuFJFN
        kiL2cHmk+pE9ErROfK4b5ye2Okv5kIS0rWwUXVexLSXUKUKQqJkYbMxGQWH5zzBLGTTfMYY5aG4hL
        yON1uWFBq9s5/prihpGm+ekxQq5Cla9KPtYg6p/8q+bPBH1GAe4aJUb/mayqJPY5puhtgngGhdcwN
        fZiNJZX1Ud6JPkxIuW4O7NjGPL9tz3cH/ruFwHRYIx+fPDkHF1Qi9cMq2r0gTQhG/cK5o44Y6odLE
        3M6QaY2oNCJsVtiFhqFJ5uHtkdjLjEzpG5a1/FXRxijS7Y5KsWxGgSpFp3wKAeLYbm5CJC5JjE3/S
        eO6VRzlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnjkA-008bMe-0H; Thu, 18 Nov 2021 15:54:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C84030001B;
        Thu, 18 Nov 2021 16:54:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BD55302619A5; Thu, 18 Nov 2021 16:54:33 +0100 (CET)
Date:   Thu, 18 Nov 2021 16:54:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V5 01/50] x86/entry: Add fence for kernel entry swapgs in
 paranoid_entry()
Message-ID: <YZZ3OUaMjMIhvj70@hirez.programming.kicks-ass.net>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
 <20211110115736.3776-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110115736.3776-2-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 07:56:47PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Commit 18ec54fdd6d18 ("x86/speculation: Prepare entry code for Spectre
> v1 swapgs mitigations") adds FENCE_SWAPGS_{KERNEL|USER}_ENTRY
> for conditional swapgs.  And in paranoid_entry(), it uses only
> FENCE_SWAPGS_KERNEL_ENTRY for both branches.  It is because the fence
> is required for both cases since the CR3 write is conditinal even PTI
> is enabled.
> 
> But commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in
> paranoid entry") switches the code order and changes the branches.
> And it misses the needed FENCE_SWAPGS_KERNEL_ENTRY for user gsbase case.
> 
> Add it back by moving FENCE_SWAPGS_KERNEL_ENTRY up to cover both branches.
> 
> Fixes: Commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in paranoid entry")
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_64.S | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index e38a4cf795d9..14ffe12807ba 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -888,6 +888,13 @@ SYM_CODE_START_LOCAL(paranoid_entry)
>  	ret
>  
>  .Lparanoid_entry_checkgs:
> +	/*
> +	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
> +	 * unconditional CR3 write, even in the PTI case.  So do an lfence
> +	 * to prevent GS speculation, regardless of whether PTI is enabled.
> +	 */
> +	FENCE_SWAPGS_KERNEL_ENTRY
> +
>  	/* EBX = 1 -> kernel GSBASE active, no restore required */
>  	movl	$1, %ebx
>  	/*
> @@ -903,13 +910,6 @@ SYM_CODE_START_LOCAL(paranoid_entry)
>  .Lparanoid_entry_swapgs:
>  	swapgs
>  
> -	/*
> -	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
> -	 * unconditional CR3 write, even in the PTI case.  So do an lfence
> -	 * to prevent GS speculation, regardless of whether PTI is enabled.
> -	 */
> -	FENCE_SWAPGS_KERNEL_ENTRY
> -
>  	/* EBX = 0 -> SWAPGS required on exit */
>  	xorl	%ebx, %ebx
>  	ret

I'm confused, shouldn't the LFENCE be between SWAPGS and future uses of
GS prefix?

In the old code, before 96b2371413e8f, we had:

	swapgs
	SAVE_AND_SWITCH_TO_KERNEL_CR3
	FENCE_SWAPGS_KERNEL_ENTRY

	// %gs user comes here..

And the comment made sense, since if SAVE_AND_SWITCH_TO_KERNEL_CR3 would
imply an unconditional CR3 write, the LFENCE would not be needed.

Then along gomes 96b2371413e8f and changes the order to:

	SAVE_AND_SWITCH_TO_KERNEL_CR3
	swapgs
	FENCE_SWAPGS_KERNEL_ENTRY
	// %gs user comes here..

But now the comment is crazy talk, because even if the CR3 write were
unconditional, it'd be pointless, since it's not after SWAPGS, but we
still have the LFENCE in the right place.

But now you want to make it:

	SAVE_AND_SWITCH_TO_KERNEL_CR3
	FENCE_SWAPGS_KERNEL_ENTRY
	swapgs
	// %gs user comes here..

And there's nothing left and speculation can use the old %gs for our
user and things go sideways. Hmm?


(on a completely unrelated note, I find KERNEL_ENTRY and USER_ENTRY
utterly confusing)

