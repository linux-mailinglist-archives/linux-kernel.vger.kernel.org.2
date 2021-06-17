Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220843ABA37
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFQRHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:07:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhFQRHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:07:19 -0400
Received: from zn.tnic (p200300ec2f0eb200a2ba6960566addd7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:b200:a2ba:6960:566a:ddd7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 49FC51EC0587;
        Thu, 17 Jun 2021 19:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623949509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L8efLSpUhyaEMmGw2xebh6U+9/gmONiS7Hq0tHA+th8=;
        b=OfBSQjo7MxE/7Oi8VDTmesKbBLWAIZNi2B9GQxVvU14IRK37dT/w+cT2RWQxwPRLJGIcem
        WQlWQAag4e6OWZuIpGNHr/R7yc8Md+x6gOLiYN/lwkVRIT8KFVlDFj76ckX4oAqFuPfUl0
        17TdEVbvXxNlMyxPsXCWL2BpfTSyzbk=
Date:   Thu, 17 Jun 2021 19:05:00 +0200
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
Subject: Re: [PATCH v2 04/12] x86/x86: Add early_is_tdx_guest() interface
Message-ID: <YMuAvP7bqwHVSCw8@zn.tnic>
References: <YMJ/IrBZiCsNMtvO@zn.tnic>
 <20210612210445.2164948-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210612210445.2164948-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 02:04:45PM -0700, Kuppuswamy Sathyanarayanan wrote:

> Subject: Re: [PATCH v2 04/12] x86/x86: Add early_is_tdx_guest() interface

Subject prefix should be "x86/tdx:" ofc.

> diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
> new file mode 100644
> index 000000000000..ddfa4a6d1939
> --- /dev/null
> +++ b/arch/x86/boot/compressed/tdx.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tdx.c - Early boot code for TDX
> + */
> +
> +#include <asm/tdx.h>

Please no kernel proper includes in the decompressor stage - that thing
is an include hell mess and needs cleaning up. Use cpuid_count() from
arch/x86/boot/cpuflags.c by exporting it properly and add the other
defines here instead of using kernel proper facilities.

I know, I know, there is other misuse but it has to stop.

> +static int __ro_after_init tdx_guest = -1;
> +
> +static inline bool native_cpuid_has_tdx_guest(void)

Why is this function prefixed with "native_"?

> +{
> +	u32 eax = TDX_CPUID_LEAF_ID, sig[3] = {0};
> +
> +	if (native_cpuid_eax(0) < TDX_CPUID_LEAF_ID)
> +		return false;
> +
> +	native_cpuid(&eax, &sig[0], &sig[1], &sig[2]);
> +
> +	return !memcmp("IntelTDX    ", sig, 12);
> +}
> +
> +bool early_is_tdx_guest(void)

So I guess this is going to be used somewhere, because I don't see it.
Or is it going away in favor of prot_guest_has(PR_GUEST_TDX) ?

This is the problem with sending new versions of patches as a reply to
the old ones in the patchset: I get confused. Why don't you wait until
the whole thing has been reviewed and then send a new revision which has
all the changes and I can find my way in the context?

And with the amount of changes so far, you should probably send a new
revision of the initial support set now-ish instead of me reviewing this
one 'til the end.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
