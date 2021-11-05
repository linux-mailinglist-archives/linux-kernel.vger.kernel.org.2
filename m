Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D32446A86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 22:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhKEV0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhKEV0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:26:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7514C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 14:24:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v23so1938813pjr.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 14:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PJsbEMmA9k9jPfV6ZrVj0hzT5Uz5Or2KzUubJmMRE8Q=;
        b=LbqqufrTqHAHbs1mCu5bvp1hf4bUdbD9QGjTIhULBnO1weAjjkaO1VOgFc38nXQEm6
         7EojuunEJQKSy5vMxPFsfLfgFiYC42hvHGTM3r88WHCpRaDtdEgBnDSrhXz3LFipeH+S
         e55ODCwZmbQ4y0p4Al5mblhrCawMA0tU2Ew+AaBB+TiDVsyQ2yCSsHPy/xAMsD3Hb2/A
         WP/MJ0jnS4E7lnVFhbWTKEDJ+hMTA/h6ZSfzmUQbdl2g2NkztfUPaHOaREuV20d6ys0t
         MVd/Ez6ZRGwbhfLtgh0we7htK6eTTlb2oBk09nS6tgVSbV0g4YgBJ0JrunFNySEV5CbE
         iz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJsbEMmA9k9jPfV6ZrVj0hzT5Uz5Or2KzUubJmMRE8Q=;
        b=F9nxK9zrdIwRdEaf4FVdj0Tzdt/UhXaLipvAoBcvuYXh3XwFc8S0iRlp8495t0j9o3
         bm7Z3lKDSJVyTIoskDRIvu/gg4xd14QDOzw4OJPpxTFHbZZDGZq0k51jb/sIAniP0sEP
         lmYC2YWq5rFpkwlymmw5boD8bKSZX4qQ46NeBr8xFEyWCHMMjJK78jj8mEYxj0hMcysg
         9Nfgq9n/pWDfxcHIMH4uscMww3p0JzxgivG0R37pMPhhPtzjlqAHQwGXaXBky9FBPEYz
         RfkMm3H95YKcfmcyPPFM2QUSKAI7cyJ7RFAAR61Xj5okguSDbHh48/ghcgfxEDeptSvo
         wZLg==
X-Gm-Message-State: AOAM533I8Ul1t8C/3D7jsAPIi24APXXdnFT+Y+Er2rshtnJbWkuMZIlP
        48bXefGC+X1HPy/te5lldaARNA==
X-Google-Smtp-Source: ABdhPJxduACQQIwrJP0sY2B5JA3HXxHtVdYstTlpZTFbNyRupYFz4+x2+NDHq4Nuz9lQdhxg2ePM8A==
X-Received: by 2002:a17:902:e806:b0:142:830:eaa4 with SMTP id u6-20020a170902e80600b001420830eaa4mr26812740plg.16.1636147439966;
        Fri, 05 Nov 2021 14:23:59 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u8sm3494189pfk.22.2021.11.05.14.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:23:59 -0700 (PDT)
Date:   Fri, 5 Nov 2021 21:23:55 +0000
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
Subject: Re: [PATCH v7 05/10] x86/tdx: Handle port I/O
Message-ID: <YYWg6wa398Vw6FJu@google.com>
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-6-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005204136.1812078-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 4cbffcb737d9..cd0fb5d14ad7 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -175,6 +175,38 @@ static u64 tdx_handle_cpuid(struct pt_regs *regs)
>  	return ret;
>  }
>  
> +/*
> + * tdx_handle_early_io() cannot be re-used in #VE handler for handling
> + * I/O because the way of handling string I/O is different between
> + * normal and early I/O case. Also, once trace support is enabled,
> + * tdx_handle_io() will be extended to use trace calls which is also
> + * not valid for early I/O cases.
> + */
> +static void tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
> +{
> +	struct tdx_hypercall_output outh;

Same comments as patch 04.

> +	int out, size, port, ret;
> +	bool string;
> +	u64 mask;
> +
> +	string = VE_IS_IO_STRING(exit_qual);
> +
> +	/* I/O strings ops are unrolled at build time. */
> +	BUG_ON(string);

And here as well.

> +
> +	out = VE_IS_IO_OUT(exit_qual);
> +	size = VE_GET_IO_SIZE(exit_qual);
> +	port = VE_GET_PORT_NUM(exit_qual);
> +	mask = GENMASK(8 * size, 0);

And here.

> +
> +	ret = _tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, out, port,
> +			     regs->ax, &outh);

This one too.

> +	if (!out) {

This needs to check "ret".  In general, why is this continuing on if I/O fails?
If I/O fails, the kernel done messed up and some downstream driver is going to
be real unhappy.  At a minimum, it should WARN.

On a related topic, the GHCB says:

	TDG.VP.VMCALL_INVALID_OPERAND 0x80000000 00000000 Invalid-IO-Port access

The "Invalid-IO-Port access" in particular is poorly worded as it implies the VMM
is allowed to deny access to ports, but AFAIK that's not the intention.  A better
phrasing would be something like "Reserved value in input GPR".

The GHCI should probably also state that bits 63:16 of R14 (port) are reserved.

> +		regs->ax &= ~mask;
> +		regs->ax |= (ret ? UINT_MAX : outh.r11) & mask;
> +	}
> +}
