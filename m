Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1245B3E0A79
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 00:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhHDWi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 18:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhHDWi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 18:38:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E54C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 15:38:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i10so4730636pla.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 15:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aVyHYA4wWqGiHay7mEaNY+3DhCOe05sArbi0hivwJ5Y=;
        b=bQHh6iZoHgv3of+vKoqb4SE9Dqb+7J9TZIYjRdNb11jGshOmj+T9wfEAZ+umwzQqUm
         HmX+pyIFlNF/OtxMkfoHRzYm6kNua6Z+7+wJnSPcIUnyKkIRipatDWnG6G5m85tyN9LG
         1T+FXeZDHYkN13NRdnT3VLZSD2inTZPd6nRfAF1EPJ4yBL2f2zgd5jHbXb5xjjnlA1s+
         PePT9ctxmj2wVFaKMuOxLdtsT9odHaIBEUxsGij60389zdsM5ZVrIjwRJjosBWela1VD
         5YDPfdrorcM/6nWWhb+Y0xmVX4X6f18cDJ4NTbsMyIZRbvQavbBdtS9keKoqWkc4LQWv
         73Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aVyHYA4wWqGiHay7mEaNY+3DhCOe05sArbi0hivwJ5Y=;
        b=b1h1IHAbOQUzHNgv8Vn5rdNiyXA6SzeowS5K/4s29FmhqaKh/jo8RMwC7u5mUkaBc5
         KWZdaaIIk2rtpO68auQbSuw1Z1WpyPI0VDD+JDVaDGsF5+vHfKkY1MsSZsZGh+vLhR4F
         QU1awz6MlxJdZllAkq/SjpL43yKtFAt0jIePR22dLZ/+yCPdY2eZ8dgPp60rGHqVPelE
         bEJ3PCymdQJCsZsOavclJR26ylfNyPBv2NJmO9vE3Q5SNsM3okd4rOfdF/Imy6Yl21CP
         Kdf9+xmzJT/qUjK8WKmdHMYF1RG1BBX1kQjWeJoSooAg5POngqOqstEHUHse//QAxZlv
         HqPA==
X-Gm-Message-State: AOAM530YkAkCdKMG0rxyUWXY6aqIa6WQHMha5x648ZqCSDVPS7PFbhIm
        R8FoQV4WTxt4EktbplIXuU6byw==
X-Google-Smtp-Source: ABdhPJwSdfA9U6eSfZHGCKN2IlZDIiLdaBYAE7k0tR2JAMV/uuKWaxBWo5QopOTRHNzTpGW1AM3iQw==
X-Received: by 2002:a65:428b:: with SMTP id j11mr11402pgp.301.1628116725269;
        Wed, 04 Aug 2021 15:38:45 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j15sm3968550pfh.194.2021.08.04.15.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:38:44 -0700 (PDT)
Date:   Wed, 4 Aug 2021 22:38:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/12] x86/tdx: Get TD execution environment
 information via TDINFO
Message-ID: <YQsW8KfbGVoyqGZl@google.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-7-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804181329.2899708-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 287564990f21..3973e81751ba 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -8,6 +8,14 @@
>  
>  #include <asm/tdx.h>
>  
> +/* TDX Module call Leaf IDs */
> +#define TDINFO				1
> +
> +static struct {
> +	unsigned int gpa_width;
> +	unsigned long attributes;
> +} td_info __ro_after_init;
> +
>  /*
>   * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
>   * for TDCALL error.
> @@ -54,6 +62,19 @@ bool tdx_prot_guest_has(unsigned long flag)
>  }
>  EXPORT_SYMBOL_GPL(tdx_prot_guest_has);
>  
> +static void tdg_get_info(void)

I've already made my dislike of "tdg" abundantly clear, but I will keep on complaining
so long as y'all keep sending patches with "tdx" and "tdg" interspersed without any
obvious method to the madness.

Also, a function with "get" in the name that returns a void and fills in a global
struct that's is a bit misleading.  

> +{
> +	u64 ret;
> +	struct tdx_module_output out = {0};
> +
> +	ret = __tdx_module_call(TDINFO, 0, 0, 0, 0, &out);
> +
> +	BUG_ON(ret);
> +
> +	td_info.gpa_width = out.rcx & GENMASK(5, 0);
> +	td_info.attributes = out.rdx;
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	if (!cpuid_has_tdx_guest())
> @@ -61,5 +82,7 @@ void __init tdx_early_init(void)
>  
>  	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>  
> +	tdg_get_info();
> +
>  	pr_info("Guest initialized\n");
>  }
> -- 
> 2.25.1
> 
