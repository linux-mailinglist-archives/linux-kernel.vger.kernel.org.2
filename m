Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517943F1AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhHSNoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbhHSNoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:44:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3827C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 06:43:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l11so9231441wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xeta399ueKfgah3+8DkNF9mE7pBKdWACVHxSeGwjYPg=;
        b=aX91D+7WmKAH7WFLe+MZHxxefH8HpfLMyVhTNf50GnkbxdCPyv75lIrzEfKBVF5nY3
         JFnTlQJnhMz/lyyScGXwt5H8GkQ1XmAS5WiHs3HHY0h2d6FsT89OCplI4SspESibQ0Ms
         oZYrc+s1rWLoLLGHs0AJgVlm1lm1DLlmP87HySvlcUcjWCTT6hzoi8vIgSzqSrn9o+WA
         mm2w4y7oVPg5+WOIPqaflR/1PBOmTtgKPUUjuz2PV1OMc3oUtevVRC6ZjPq2QSIJKrOQ
         aoNtfPGgw8/o4WMa1CxaH8sihUiwJY+aIaHgMfu+i255s2ex7IgA/2zwQM6Bxu2xwn1Z
         ITcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xeta399ueKfgah3+8DkNF9mE7pBKdWACVHxSeGwjYPg=;
        b=adBq9gpiblC4zeuFNa625mKWSpjg3O1X4Uc7UivRI6l6Px80H24IO4G+oCuZMjPKQX
         eOjaZ9ZLOvgnBJ/y5igT/7Fqu937EB9p2TfT34jBw0UW8FzwFvi7fNJf/pt5jg7tZe3f
         pF/T806KjEkd1uf9oOT0BuvWb8VCP6mK7MgizypbvRhpgcxyoFFD41TRoh95dto5ZKaX
         E5WfgAUp1+dmdPLvo9OLezuisW02lxIHVvJrydt6kny2IH/j9W44C3DSjdfGasWLKoLg
         ghVPkfPrPTxguHtz+26GitSuzta9SrNNOuWzorgZCVumiYGPDKH0/pEAd3H321K8NPfk
         94kw==
X-Gm-Message-State: AOAM5337bwBhJcR6GduJz9qTKzEiwV54wGik3x8m5f1xcLQV6TeN/A56
        EFVk5jA6OEaB4y4MFlmxfbw=
X-Google-Smtp-Source: ABdhPJwxUtbk0fjYw8cQdfXXYwmLUytWXhV9ZcW1ZgiYKx+vOwDHBtM7zQW2lKJIy3twThQ6Okd+0g==
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr3973842wro.7.1629380611415;
        Thu, 19 Aug 2021 06:43:31 -0700 (PDT)
Received: from agape.jhs ([5.171.80.222])
        by smtp.gmail.com with ESMTPSA id r8sm3028381wrj.11.2021.08.19.06.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:43:31 -0700 (PDT)
Date:   Thu, 19 Aug 2021 15:43:28 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: x86/boot/compressed/64: Lenovo Ideapad Miix300 bug report
Message-ID: <20210819134328.GD28768@agape.jhs>
References: <20210819100230.GA28768@agape.jhs>
 <YR4uffjFuqvrz1Tp@zn.tnic>
 <20210819121653.GB28768@agape.jhs>
 <YR5dtDvvcgekoIJu@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR5dtDvvcgekoIJu@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Thu, Aug 19, 2021 at 03:33:40PM +0200, Joerg Roedel wrote:
> Hi Fabio,
> 
> thanks for your report!

you are welcome,

> 
> On Thu, Aug 19, 2021 at 02:16:53PM +0200, Fabio Aiuto wrote:
> > I rebuilt a plain v5.13 kernel (no reverts) with that config
> > disabled and everything goes fine.
> 
> Can you please try the attached patch? I think the problem is that the
> 32-bit EFI boot path sets up its own IDT before ExitBootServices() is
> called.

shall I restore back CONFIG_AMD_MEM_ENCRYPT?

thank you,

fabio

> 
> Regards,
> 
> 	Joerg

> diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
> index 95a223b3e56a..99cfd5dea23c 100644
> --- a/arch/x86/boot/compressed/efi_thunk_64.S
> +++ b/arch/x86/boot/compressed/efi_thunk_64.S
> @@ -39,7 +39,7 @@ SYM_FUNC_START(__efi64_thunk)
>  	/*
>  	 * Convert x86-64 ABI params to i386 ABI
>  	 */
> -	subq	$32, %rsp
> +	subq	$64, %rsp
>  	movl	%esi, 0x0(%rsp)
>  	movl	%edx, 0x4(%rsp)
>  	movl	%ecx, 0x8(%rsp)
> @@ -49,14 +49,19 @@ SYM_FUNC_START(__efi64_thunk)
>  	leaq	0x14(%rsp), %rbx
>  	sgdt	(%rbx)
>  
> +	addq	$16, %rbx
> +	sidt	(%rbx)
> +
>  	/*
> -	 * Switch to gdt with 32-bit segments. This is the firmware GDT
> -	 * that was installed when the kernel started executing. This
> -	 * pointer was saved at the EFI stub entry point in head_64.S.
> +	 * Switch to idt and gdt with 32-bit segments. This is the firmware GDT
> +	 * and IDT that was installed when the kernel started executing. The
> +	 * pointers were saved at the EFI stub entry point in head_64.S.
>  	 *
>  	 * Pass the saved DS selector to the 32-bit code, and use far return to
>  	 * restore the saved CS selector.
>  	 */
> +	leaq	efi32_boot_idt(%rip), %rax
> +	lidt	(%rax)
>  	leaq	efi32_boot_gdt(%rip), %rax
>  	lgdt	(%rax)
>  
> @@ -67,7 +72,7 @@ SYM_FUNC_START(__efi64_thunk)
>  	pushq	%rax
>  	lretq
>  
> -1:	addq	$32, %rsp
> +1:	addq	$64, %rsp
>  	movq	%rdi, %rax
>  
>  	pop	%rbx
> @@ -132,6 +137,9 @@ SYM_FUNC_START_LOCAL(efi_enter32)
>  	 */
>  	cli
>  
> +	lidtl	(%ebx)
> +	subl	$16, %ebx
> +
>  	lgdtl	(%ebx)
>  
>  	movl	%cr4, %eax
> @@ -166,6 +174,11 @@ SYM_DATA_START(efi32_boot_gdt)
>  	.quad	0
>  SYM_DATA_END(efi32_boot_gdt)
>  
> +SYM_DATA_START(efi32_boot_idt)
> +	.word	0
> +	.quad	0
> +SYM_DATA_END(efi32_boot_idt)
> +
>  SYM_DATA_START(efi32_boot_cs)
>  	.word	0
>  SYM_DATA_END(efi32_boot_cs)
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index a2347ded77ea..572c535cf45b 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -319,6 +319,9 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
>  	movw	%cs, rva(efi32_boot_cs)(%ebp)
>  	movw	%ds, rva(efi32_boot_ds)(%ebp)
>  
> +	/* Store firmware IDT descriptor */
> +	sidtl	rva(efi32_boot_idt)(%ebp)
> +
>  	/* Disable paging */
>  	movl	%cr0, %eax
>  	btrl	$X86_CR0_PG_BIT, %eax

