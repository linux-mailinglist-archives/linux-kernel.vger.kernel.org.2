Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2864446A6E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 22:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhKEVPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhKEVPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:15:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD60C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 14:13:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso4238277pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SMBO4Sfl6Q7domxN2tlekQjwHzPXxnsf+mCYazTLskU=;
        b=aeZ+XLkdBLRWQV2H8VkYmVy2h3/j6C8XLOYmIeuv0NyMbW1/Z4smn8SSFWT6MuteD2
         PHPtuQGs7SrVT6AlpdUoK9MWZ+7YlANT5oGJBv6MHz8zsKBwX/Fetldzha/OxLecY2IU
         66UcXWwDYxu9uGZFgBRrDsodAT0NV2B5dcPLOkY3PPZ7J1hLLVvHvhcMJQg3sphBiHFE
         aII5g0fvrS7+Ne2B4o5ZAqCrTtnyUexH+HWLAWqoQWTaLKssNpFfIT5aB79eJBN7m9F/
         B0cxZ/FxYILo5lxKVhjE2fXkD1OedrmQsf4q4XXEJr4emwCAyhWBTUdnLViojuiqLUgg
         G5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMBO4Sfl6Q7domxN2tlekQjwHzPXxnsf+mCYazTLskU=;
        b=EPHk8Rz9zIGwyHfowW4LJzNS9gIPQ4lMnRKt6PYvfcdopcZ3WgDBj1gOjMne7QhmOB
         mPB1rlfuOmuibtjaE4ixsyP2oWlATWgshzXiobn3ki8eXNzgpBR3JpkMbxo7M4jjdo0B
         k2sb77TG74fUvEbUkFXcBfEiYqzSm3ZFHI9mor6EbBvm3U3HYbl673nEsBq99E5Ii3fe
         pW6QQ7INGGUkKKPoplQR/ObjKzEuXf4FKlKD7GppmhtXih5VqabMjaVzrSKG1UZo4Cvo
         1wgqeqF0wnYJal9vMIlkGHjIDCXe4imGNTlyUpSYm/LvAs2SAHTMoSrsQFNCvF0pCVCd
         iU7w==
X-Gm-Message-State: AOAM532uAnIXq19aLQoauxAaToqQaMDDXnTHfqDfkwdRPEfi3+MKa9xv
        ZoDSUsa7ewjDd0iQB1JD42iboQ==
X-Google-Smtp-Source: ABdhPJwCjmyOphpUjtFgMmJQcOoFrOqSFxqzKeI5pwW5vQ9rngPydqhFkkOBgaGAGFXyEPl9i+N5Rw==
X-Received: by 2002:a17:90a:e00f:: with SMTP id u15mr32928567pjy.123.1636146783123;
        Fri, 05 Nov 2021 14:13:03 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g22sm5765668pfj.82.2021.11.05.14.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:13:02 -0700 (PDT)
Date:   Fri, 5 Nov 2021 21:12:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/10] x86/tdx: Handle early IO operations
Message-ID: <YYWeWlmYvotKrX+p@google.com>
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005204136.1812078-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021, Kuppuswamy Sathyanarayanan wrote:
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Heh, is Andi double-dipping to pad his stats?  :-D

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---

...

> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 11e367228e96..4cbffcb737d9 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -10,6 +10,11 @@
>  /* TDX Module call Leaf IDs */
>  #define TDGETVEINFO			3
>  
> +#define VE_IS_IO_OUT(exit_qual)		(((exit_qual) & 8) ? 0 : 1)
> +#define VE_GET_IO_SIZE(exit_qual)	(((exit_qual) & 7) + 1)
> +#define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
> +#define VE_IS_IO_STRING(exit_qual)	((exit_qual) & 16 ? 1 : 0)
> +
>  /*
>   * Allocate it in the data region to avoid zeroing it during
>   * BSS initialization. It is mainly used in cc_platform_has()
> @@ -228,6 +233,61 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
>  	return ret;
>  }
>  
> +/*
> + * Handle early IO, mainly for early printks serial output.
> + * This avoids anything that doesn't work early on, like tracing
> + * or printks, by calling the low level functions directly. Any
> + * problems are handled by falling back to a standard early exception.
> + *
> + * Assumes the IO instruction was using ax, which is enforced
> + * by the standard io.h macros.
> + */
> +static __init bool tdx_early_io(struct pt_regs *regs, u32 exit_qual)
> +{
> +	struct tdx_hypercall_output outh;

"outh" looks like a typo.  Maybe "result" or something alongs those lines?

> +	int out, size, port, ret;
> +	bool string;
> +	u64 mask;
> +
> +	string = VE_IS_IO_STRING(exit_qual);
> +
> +	/* I/O strings ops are unrolled at build time. */
> +	if (string)

Why bother with "string"?

	if (VE_IS_IO_STRING(exit_qual))
		return false;

> +		return 0;

Ugh.  This needs to be "return false".  "return 0" in the kernel usually means
success, but this horror returns a bool where "false" is failure.

> +
> +	out = VE_IS_IO_OUT(exit_qual);
> +	size = VE_GET_IO_SIZE(exit_qual);
> +	port = VE_GET_PORT_NUM(exit_qual);
> +	mask = GENMASK(8 * size, 0);

size * BITS_PER_BYTE

> +
> +	ret = _tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, out, port,
> +			     regs->ax, &outh);

This unnecessarily exposes RAX to the untrusted VMM for IN.

> +	if (!out && !ret) {
> +		regs->ax &= ~mask;
> +		regs->ax |= outh.r11 & mask;
> +	}
> +
> +	return !ret;
> +}
