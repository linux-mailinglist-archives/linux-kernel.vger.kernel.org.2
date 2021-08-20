Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13683F320E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhHTRNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:13:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48062 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhHTRNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:13:07 -0400
Received: from zn.tnic (p200300ec2f107b0070f9113f083a3500.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:7b00:70f9:113f:83a:3500])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41C4D1EC0589;
        Fri, 20 Aug 2021 19:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629479544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=S4jTLQYXku/9jh4+L0ipAB4Go6isuVtIEWY084R3acs=;
        b=m65S1MDuRHDhfyL4Lim7QkFQLc8a3FcTndsNB1G3hhVph0E1vSuCHzCCbk22W5a5VMKtEO
        4RRrjhzwVOmUO2oeaFpJl+taxV+TMe1vjkEGGFPPC1oUXRZpzseNdAttbAMrfDWFTTai97
        GfPZYtBQqrkNF2TnKK9OWNP0VnqbHAA=
Date:   Fri, 20 Aug 2021 19:13:03 +0200
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
Subject: Re: [PATCH v5 06/12] x86/tdx: Get TD execution environment
 information via TDINFO
Message-ID: <YR/in4WqEQQ/LyPA@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-7-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804181329.2899708-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:13:23AM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Per Guest-Host-Communication Interface (GHCI) for Intel Trust
> Domain Extensions (Intel TDX) specification, sec 2.4.2,
> TDCALL[TDINFO] provides basic TD execution environment information, not
> provided by CPUID.
> 
> Call TDINFO during early boot to be used for following system
> initialization.
> 
> The call provides info on which bit in pfn is used to indicate that the
> page is shared with the host and attributes of the TD, such as debug.
> 
> Information about the number of CPUs need not be saved because there are
> no users so far for it.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v4:
>  * None
> 
> Changes since v3:
>  * None
> 
>  arch/x86/kernel/tdx.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
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

Where is that thing even used? I don't see it in the whole patchset.

> +
>  /*
>   * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
>   * for TDCALL error.
> @@ -54,6 +62,19 @@ bool tdx_prot_guest_has(unsigned long flag)
>  }
>  EXPORT_SYMBOL_GPL(tdx_prot_guest_has);
>  
> +static void tdg_get_info(void)

Also, what Sean said: "tdx_" please. Unless there's a real reason to
have a different prefix - then state that reason.

> +{
> +	u64 ret;
> +	struct tdx_module_output out = {0};

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

> +
> +	ret = __tdx_module_call(TDINFO, 0, 0, 0, 0, &out);
> +
> +	BUG_ON(ret);

WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()
#121: FILE: arch/x86/kernel/tdx.c:72:
+	BUG_ON(ret);

Have I already told you about checkpatch?

If not, here it is:

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
