Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C453B322C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhFXPE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:04:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33018 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhFXPEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:04:24 -0400
Received: from zn.tnic (p200300ec2f0c1e008510e17daa0769aa.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1e00:8510:e17d:aa07:69aa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E6AD1EC0575;
        Thu, 24 Jun 2021 17:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624546924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EbmBZjzk/a7b0Wm081210DtHfALq+LTnsgNteTuznT8=;
        b=OUq89EdUmp9BFpAoZNUnVL+SRvmiJbO5jd1eF9IkxLfj3PFWeWyk8MsNR+403PC61u8oZG
        9JNXqWZ3tE4cFhFolc40jG3SBcigghUA/wZ440ZWKEQ2qLBMKWreXMCqOWptXTfTwif53O
        Hr2MuXIdh/hgTgDHPFt+7/6j2zLezOw=
Date:   Thu, 24 Jun 2021 17:01:58 +0200
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
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] x86: Introduce generic protected guest
 abstraction
Message-ID: <YNSeZv/U6QKK8sBo@zn.tnic>
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618225755.662725-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 03:57:48PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Add a generic way to check if we run with an encrypted guest,

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

> without requiring x86 specific ifdefs. This can then be used in
> non architecture specific code. 

"... in arch-independent code." or so.

> prot_guest_has() is used to check for protected guest feature
> flags.
> 
> Originally-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Change since v1:
>  * Introduced PR_GUEST_TDX and PR_GUEST_SEV vendor flags as per
>    Boris suggestion.
>  * Replaced is_tdx_guest() with if (boot_cpu_data.x86_vendor ==
>    X86_VENDOR_INTEL) in prot_guest_has().
>  * Modified tdx_protected_guest_has() and sev_protected_guest_has()
>    to support vendor flags.

...

> diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
> new file mode 100644
> index 000000000000..d47668dee6c2
> --- /dev/null
> +++ b/arch/x86/include/asm/protected_guest.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2020 Intel Corporation */
> +#ifndef _ASM_PROTECTED_GUEST_H
> +#define _ASM_PROTECTED_GUEST_H 1

#define _ASM_X86_PROTECTED_GUEST_H

> +
> +#include <asm/processor.h>
> +#include <asm/tdx.h>
> +#include <asm/sev.h>
> +
> +static inline bool prot_guest_has(unsigned long flag)
> +{
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		return tdx_protected_guest_has(flag);
> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		return sev_protected_guest_has(flag);

s/protected/prot/

tdx_prot_guest_has
sev_prot_guest_has

...

> @@ -18,6 +20,21 @@ static inline bool cpuid_has_tdx_guest(void)
>  	return !memcmp("IntelTDX    ", sig, 12);
>  }
>  
> +bool tdx_protected_guest_has(unsigned long flag)
> +{
> +	switch (flag) {
> +	case PR_GUEST_MEM_ENCRYPT:
> +	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
> +	case PR_GUEST_UNROLL_STRING_IO:
> +	case PR_GUEST_SHARED_MAPPING_INIT:
> +	case PR_GUEST_TDX:
> +		return static_cpu_has(X86_FEATURE_TDX_GUEST);

		return cpu_feature_enabled(...)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
