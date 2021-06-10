Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843E73A3464
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFJUBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:01:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57488 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFJUBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:01:52 -0400
Received: from zn.tnic (p200300ec2f0cf6005d9c12d1298a6408.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:5d9c:12d1:298a:6408])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 785851EC04DF;
        Thu, 10 Jun 2021 21:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623355194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lBBqddz2EGvOETeoLd88euAwewgGmyuu/AiEcw26P2I=;
        b=nCoyXoW03lmennUIFKhXDCv7QAHJF/cCAn2yEqLRQ87iKrZJVuMpwKDeUv8Cs0qgL8l52c
        ZnuaehH9aTwaIEn61rHZqXC4sGjsRGdvNs17iTiekIGP7aZf/WA0JsOwlJY/IwRmu5gmuN
        gj6uPxOSxfAKaj/T9iZu4KxoOYSgjBA=
Date:   Thu, 10 Jun 2021 21:59:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 04/11] x86/x86: Add is_tdx_guest() interface
Message-ID: <YMJvNGyIaBItV9c6@zn.tnic>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602022136.2186759-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 07:21:29PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +static int __ro_after_init tdx_guest = -1;
> +
> +static inline bool native_cpuid_has_tdx_guest(void)
> +{
> +	u32 eax = TDX_CPUID_LEAF_ID, signature[3] = {0};
> +
> +	if (native_cpuid_eax(0) < TDX_CPUID_LEAF_ID)
> +		return false;
> +
> +	native_cpuid(&eax, &signature[0], &signature[1], &signature[2]);
> +
> +	if (memcmp("IntelTDX    ", signature, 12))
> +		return false;
> +
> +	return true;

As before, 

 return !memcmp(...

and then that function can return simply an int.


> +}
> +
> +bool is_tdx_guest(void)

If anything, this should be early_is_tdx_guest().

> +{
> +	if (tdx_guest < 0)
> +		tdx_guest = native_cpuid_has_tdx_guest();
> +
> +	return !!tdx_guest;
> +}
> +

Applying: x86/x86: Add is_tdx_guest() interface
.git/rebase-apply/patch:58: new blank line at EOF.
+
warning: 1 line adds whitespace errors.


> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 5b14b72e41c5..5e70617e9877 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -19,6 +19,12 @@ static inline bool cpuid_has_tdx_guest(void)
>  	return true;
>  }
>  
> +bool is_tdx_guest(void)
> +{
> +	return static_cpu_has(X86_FEATURE_TDX_GUEST);
> +}
> +EXPORT_SYMBOL_GPL(is_tdx_guest);

I don't like this is_tdx_guest() thing in kernel proper - what's wrong
with

  prot_guest_has(PR_GUEST_TDX)

?

Also, why is it exported, for kvm?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
