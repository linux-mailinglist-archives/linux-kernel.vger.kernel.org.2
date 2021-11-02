Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173F34429FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhKBJAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhKBJAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:00:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6645BC061767
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:58:16 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f62005f026b777d4e743c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6200:5f02:6b77:7d4e:743c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF4561EC0399;
        Tue,  2 Nov 2021 09:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635843495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1uNXrjMg71tsOxKJhJFEEkWxKIgfWGBG7bqJii3XBpE=;
        b=HEFGYp55Jr0ZE18+k8Z9i4P3QR5dpxJqyEv8zk0g8j7dshvQzAzEBxdF6AY4bOcC09Gxjy
        z22/ciISUsTjJuKnR0VVa+nLj+O5zs2S5hO2Aeu7MGti0kXOYdB+1f+JOgxg5+7TD195kf
        YhmSJURBLMPsKTRlAMH6xdkZAaPO/Ik=
Date:   Tue, 2 Nov 2021 09:58:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, Peter Anvin <hpa@zytor.com>,
        xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH V4 04/50] x86/xen: Add
 xenpv_restore_regs_and_return_to_usermode()
Message-ID: <YYD9ohN2Zcy4EdMb@zn.tnic>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
 <20211026141420.17138-5-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026141420.17138-5-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:13:34PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> While in the native case, PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is the
> trampoline stack.  But XEN pv doesn't use trampoline stack, so
> PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is also the kernel stack.  Hence source
> and destination stacks are identical in that case, which means reusing
> swapgs_restore_regs_and_return_to_usermode() in XEN pv would cause %rsp
> to move up to the top of the kernel stack and leave the IRET frame below
> %rsp, which is dangerous to be corrupted if #NMI / #MC hit as either of
> these events occurring in the middle of the stack pushing would clobber
> data on the (original) stack.
> 
> And swapgs_restore_regs_and_return_to_usermode() pushing the IRET frame
> on to the original address is useless and error-prone when there is any
> future attempt to modify the code.
> 
> Fixes: 7f2590a110b8 ("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
> Cc: Jan Beulich <jbeulich@suse.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Peter Anvin <hpa@zytor.com>
> Cc: xen-devel@lists.xenproject.org>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_64.S        |  9 ++++++---
>  arch/x86/entry/entry_64_compat.S |  7 ++++---
>  arch/x86/xen/xen-asm.S           | 27 +++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 9d468c8877e2..0dde5a253dda 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -119,7 +119,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
>  	 * In the Xen PV case we must use iret anyway.
>  	 */
>  
> -	ALTERNATIVE "", "jmp	swapgs_restore_regs_and_return_to_usermode", \
> +	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", \

Instead of sprinkling all those ALTERNATIVE calls everywhere,
why don't you simply jump to the xenpv-one at the
swapgs_restore_regs_and_return_to_usermode label itself and have a
single ALTERNATIVE there?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
