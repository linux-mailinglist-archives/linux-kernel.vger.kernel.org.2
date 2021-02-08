Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6233140A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhBHUiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbhBHTVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:21:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1FBC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 11:21:08 -0800 (PST)
Received: from zn.tnic (p200300ec2f073f00132389f64ded89c1.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3f00:1323:89f6:4ded:89c1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 564261EC0516;
        Mon,  8 Feb 2021 20:21:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612812067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4c9RhzPbwN8HS3XfQ2Z1I8RZIi0JC8xqn8Lcka/rU64=;
        b=Kv3JtNGzM3ucgPQ00jQDkS8CYaKY8hL3yNXGcmS7nazBAFDYNGP4Z1699dAXAg/zPm+mpN
        mECxYEldKRNIv5VSWlL7PS+FHjCh1HK+lEqxmiDVARjt/mp96rODm3V3xtfo3K7umLE3fY
        Z51txNE/TRbY3OYvojUc3WBqwVltI2A=
Date:   Mon, 8 Feb 2021 20:21:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH V3 2/6] x86_32: use percpu instead of offset-calculation
 to get thread.sp0 when SWITCH_TO_KERNEL_STACK
Message-ID: <20210208192109.GH18227@zn.tnic>
References: <20210127163231.12709-1-jiangshanlai@gmail.com>
 <20210127163231.12709-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127163231.12709-3-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:32:18AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> TSS_entry2task_stack is used to refer to tss.sp1 which is stored the value
> of thread.sp0.

"... which is a copy of thread.sp0."

> 
> At the code where TSS_entry2task_stack is used in SWITCH_TO_KERNEL_STACK,

"TSS_entry2task_stack is used in SWITCH_TO_KERNEL_STACK and CR3 is
already... "

> the CR3 is already kernel CR3 and kernel segments is loaded.
> 
> So we can directly use the percpu to get tss.sp1(thread.sp0) instead of

Who's "we"?

> the complex offset-calculation.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_32.S | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index df8c017e6161..3b4d1a63d1f0 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -465,16 +465,11 @@
>  	cmpl	$SIZEOF_entry_stack, %ecx
>  	jae	.Lend_\@
>  
> -	/* Load stack pointer into %esi and %edi */
> +	/* Load stack pointer into %esi */
>  	movl	%esp, %esi
> -	movl	%esi, %edi
> -
> -	/* Move %edi to the top of the entry stack */
> -	andl	$(MASK_entry_stack), %edi
> -	addl	$(SIZEOF_entry_stack), %edi
>  
>  	/* Load top of task-stack into %edi */
> -	movl	TSS_entry2task_stack(%edi), %edi
> +	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %edi
>  
>  	/* Special case - entry from kernel mode via entry stack */
>  #ifdef CONFIG_VM86
> -- 

The change itself looks ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
