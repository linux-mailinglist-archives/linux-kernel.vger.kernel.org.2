Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9EB355C27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhDFTZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:25:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50738 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232553AbhDFTY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:24:57 -0400
Received: from zn.tnic (p200300ec2f0a0d0098c8242cdcf6564d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d00:98c8:242c:dcf6:564d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA8F81EC01A9;
        Tue,  6 Apr 2021 21:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617737088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VEKpYltx5cUrSdL3AGy4C4Fkwk89IILt63r/FqJJAGg=;
        b=d6bQzbhq7INBekNgate3k8Cy6LV/vsnBXwFo20OOZteEHuNijbpqu54Ecy2sEfh4WIF17Y
        q5KdAnrL+UH7sROIh+fxRT4E7Z964CnDa90L4Hf6XwCsTDpIv4QiaeY6N3ARty5+I5kDKy
        cOHtF4SOUM97aejllgU1RtNuzNo61nk=
Date:   Tue, 6 Apr 2021 21:24:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEoIOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
Subject: Re: [PATCH 1/4] x86/mce: Fix copyin code to return -EFAULT on
 machine check.
Message-ID: <20210406192446.GP17806@zn.tnic>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210326000235.370514-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210326000235.370514-2-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:02:32PM -0700, Tony Luck wrote:
> When copy from user fails due to a machine check on poison reading
> user data it should return an error code.
> 
> ---
> 
> Separate patch just now, but likely needs to be combined with patches
> to iteration code for bisection safety.
> ---
>  arch/x86/lib/copy_user_64.S | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
> index 77b9b2a3b5c8..2987118c541a 100644
> --- a/arch/x86/lib/copy_user_64.S
> +++ b/arch/x86/lib/copy_user_64.S
> @@ -14,6 +14,7 @@
>  #include <asm/alternative-asm.h>
>  #include <asm/asm.h>
>  #include <asm/smap.h>
> +#include <asm/errno.h>
>  #include <asm/export.h>
>  #include <asm/trapnr.h>
>  
> @@ -237,18 +238,21 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
>  	cmp $X86_TRAP_MC,%eax		/* check if X86_TRAP_MC */
>  	je 3f
>  1:	rep movsb
> -2:	mov %ecx,%eax
> +	mov %ecx,%eax
> +	ASM_CLAC
> +	ret
> +
> +2:
> +	cmp $X86_TRAP_MC,%eax
> +	je 3f
> +	mov %ecx,%eax
>  	ASM_CLAC
>  	ret
>  
>  	/*
> -	 * Return zero to pretend that this copy succeeded. This
> -	 * is counter-intuitive, but needed to prevent the code
> -	 * in lib/iov_iter.c from retrying and running back into
> -	 * the poison cache line again. The machine check handler
> -	 * will ensure that a SIGBUS is sent to the task.
> +	 * Return -EFAULT for the machine check cases
>  	 */
> -3:	xorl %eax,%eax
> +3:	movl $-EFAULT,%eax
>  	ASM_CLAC
>  	ret

Right, looks ok after swapping all that
fault-handlers-rerouting-based-on-labels thing back in. You'd need to
update the blubber in the comment above it that we're returning -EFAULT
now too.

Also, you might wanna converge the exit paths to a single "out" label
if the unconditional JMPs are not that big of a deal (pasting the whole
thing and not as a diff because diff is unreadable):

SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
        movl %edx,%ecx
        cmp $X86_TRAP_MC,%eax           /* check if X86_TRAP_MC */
        je 3f

1:      rep movsb
        mov %ecx,%eax
        jmp out

2:      cmp $X86_TRAP_MC,%eax
        je 3f
        mov %ecx,%eax
        jmp out

        /* Return -EFAULT for the machine check cases */
3:      movl $-EFAULT,%eax

out:
        ASM_CLAC
        ret

        _ASM_EXTABLE_CPY(1b, 2b)
SYM_CODE_END(.Lcopy_user_handle_tail)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
