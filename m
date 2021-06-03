Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6358E399FD3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFCLeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:34:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34192 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhFCLeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:34:19 -0400
Received: from zn.tnic (p200300ec2f138500cdba27e87082b0ea.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:cdba:27e8:7082:b0ea])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FF1B1EC0535;
        Thu,  3 Jun 2021 13:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622719954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7zJDB/2PnuDH6C3gZBgFWn1is9sL6JTpHCdLnryhTbo=;
        b=n0htR08ERJS8ekRxucBJhLR7E4uFslh62z7gzzuVyrO9HzGREuqucltJ0JQHu9sDLLZhpI
        1uDKu1+kqecV2yfotkUVSE9tYyezWPxHWDGv1tf65KgSbe0TSe9gpijZm9FaXJkRBd5Iqw
        gpiwguwkbAYJiYYYCla7EaKwI8J9MwI=
Date:   Thu, 3 Jun 2021 13:32:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [patch V2 5/8] x86/fpu: Sanitize xstateregs_set()
Message-ID: <YLi9xCjkHrNMzwls@zn.tnic>
References: <20210602095543.149814064@linutronix.de>
 <20210602101618.851242793@linutronix.de>
 <87sg20z25y.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sg20z25y.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 06:01:13PM +0200, Thomas Gleixner wrote:
> xstateregs_set() operates on a stopped task and tries to copy the provided
> buffer into the tasks fpu.state.xsave buffer.

task's

> 
> Any error while copying or invalid state detected after copying results in
> wiping the target tasks FPU state completely including supervisor states.

Ditto.

> 
> That's just wrong. The caller supplied invalid data or has a problem with
> unmapped memory, so there is absolutely no justification to wreckage the
> target.
> 
> Fix this with the following modifications:
> 
>  1) If data has to be copied from userspace, allocate a buffer and copy from
>     user first.
> 
>  2) Use copy_kernel_to_xstate() unconditionally so that header checking
>     works correctly.
> 
>  3) Return on error without wreckaging the target state.
> 
> This prevents corrupting supervisor states and lets the caller deal with
> the problem it caused in the first place.
> 
> Make validate_user_xstate_header() static as this was the last user
> outside of xstate.c

Niice.


> @@ -120,32 +124,21 @@ int xstateregs_set(struct task_struct *t
>  	if (pos != 0 || count != fpu_user_xstate_size)
>  		return -EFAULT;
>  
> -	xsave = &fpu->state.xsave;
> -
> -	fpu__prepare_write(fpu);
> -
> -	if (using_compacted_format()) {
> -		if (kbuf)
> -			ret = copy_kernel_to_xstate(xsave, kbuf);
> -		else
> -			ret = copy_user_to_xstate(xsave, ubuf);
> -	} else {
> -		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
> -		if (!ret)
> -			ret = validate_user_xstate_header(&xsave->header);
> +	if (!kbuf) {
> +		xbuf = vmalloc(count);
> +		if (!xbuf)
> +			return -ENOMEM;

<---- newline here.

Btw, AFAICT and if I'm staring properly at the bowels of ptrace, that
ENOMEM would percolate up the chain when ptrace(2) is called.

The ptrace(2) manpage doesn't mention ENOMEM and I guess this is a small
ABI change. I say "small" because it is still a negative error and
properly written luserspace code should check it anyway...

Or am I being overly cautious here?

 ( Frankly, can you blame me, with that madness called xstate?! )

> +		ret = user_regset_copyin(&pos, &count, NULL, &ubuf, xbuf, 0, -1);
> +		if (ret)
> +			goto out;
>  	}
>  
> -	/*
> -	 * mxcsr reserved bits must be masked to zero for security reasons.
> -	 */
> -	xsave->i387.mxcsr &= mxcsr_feature_mask;
> -
> -	/*
> -	 * In case of failure, mark all states as init:
> -	 */
> -	if (ret)
> -		fpstate_init(&fpu->state);
> +	xsave = &fpu->state.xsave;
> +	fpu__prepare_write(fpu);
> +	ret = copy_kernel_to_xstate(xsave, kbuf ? kbuf : xbuf);

Uff, three buffers in a single function. How about we call "xbuf"
"tmp_buf" so that it is even more visible what it is and it differs more
from the other <letter>buf thingies?

>  /*
> - * Convert from a ptrace or sigreturn standard-format user-space buffer to
> - * kernel XSAVES format and copy to the target thread. This is called from
> - * xstateregs_set(), as well as potentially from the sigreturn() and
> - * rt_sigreturn() system calls.
> + * Convert from a sigreturn standard-format user-space buffer to kernel
> + * XSAVES format and copy to the target thread. This is called from the

Yeah, I guess we call that the "compacted" format. Just getting our
terminology simplified because this is one helluva mess, as we all know.

> + * sigreturn() and rt_sigreturn() system calls.
>   */
>  int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
>  {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
