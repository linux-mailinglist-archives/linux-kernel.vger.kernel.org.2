Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45345454AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbhKQQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:32:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42480 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbhKQQcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:32:16 -0500
Received: from zn.tnic (p200300ec2f13a300581971bf8eb608b9.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a300:5819:71bf:8eb6:8b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CFCB01EC0136;
        Wed, 17 Nov 2021 17:29:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637166556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ACSOAN8d0vCDVJOYN5cUHPqdYtZ1SteyMTdGCY7MMmU=;
        b=bfATr+2wOibVKqNTdxxnMOttf7x6X/LKVkOR11lahLFcXYfxD5jKMsUp0nXrMAJ9E0lEnP
        QRUsCxqjUflof1U7JY9yPwtWcpJsBneeZ3SjO68g7b2FYVosBp17CRcHnEGeI0rozzLouo
        B5UYplZkrmKl8YSl8dNYanPU6GfQTv8=
Date:   Wed, 17 Nov 2021 17:29:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH v2 05/23] x86,entry_64: Remove .fixup usage
Message-ID: <YZUt2LcgSweZmyJt@zn.tnic>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.186049322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110101325.186049322@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:01:07AM +0100, Peter Zijlstra wrote:
> Place the anonymous .fixup code at the tail of the regular functions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_64.S |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -735,13 +735,9 @@ SYM_FUNC_START(asm_load_gs_index)
>  	swapgs
>  	FRAME_END
>  	ret
> -SYM_FUNC_END(asm_load_gs_index)
> -EXPORT_SYMBOL(asm_load_gs_index)
>  
> -	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
> -	.section .fixup, "ax"
>  	/* running with kernelgs */
> -SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
> +.Lbad_gs:
>  	swapgs					/* switch back to user gs */
>  .macro ZAP_GS
>  	/* This can't be a string because the preprocessor needs to see it. */
> @@ -752,8 +748,11 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
>  	xorl	%eax, %eax
>  	movl	%eax, %gs
>  	jmp	2b
> -SYM_CODE_END(.Lbad_gs)
> -	.previous
> +
> +	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
> +
> +SYM_FUNC_END(asm_load_gs_index)
> +EXPORT_SYMBOL(asm_load_gs_index)
>  
>  #ifdef CONFIG_XEN_PV
>  /*

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
