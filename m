Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E934E3A2B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhFJMaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhFJMaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:30:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8A8C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 05:28:13 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cf600e70433578266b34c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:e704:3357:8266:b34c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29EBC1EC0493;
        Thu, 10 Jun 2021 14:28:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623328092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=35bw5pjdZNqYAGs3sns2GRGGZjK2Qjk7iy2KlgpNkiU=;
        b=RIKAllYWEb5J2g7gciGdH+sAb+lW3D0dih5fGEQl640Lhp80+aeJBfOwt8cVlWqFSCjJo0
        0f9d0Ni0lBufLaySu4Tmi1tlGJZZGib8c6/WwHPX2MIdRH3pyshGfv7xGQCO+V2W20xFwv
        cw4NTEp3iAbV5LY/hM88QIOdSPTh6t4=
Date:   Thu, 10 Jun 2021 14:28:06 +0200
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
Subject: Re: [PATCH v1 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YMIFVh9WpDiUuRsa@zn.tnic>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602022136.2186759-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 07:21:28PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Add CPU feature detection for Trusted Domain Extensions support.
> TDX feature adds capabilities to keep guest register state and
> memory isolated from hypervisor.
> 
> For TDX guest platforms, executing CPUID(0x21, 0) will return

I'm assuming that 0 is ECX?

> following values in EAX, EBX, ECX and EDX.
> 
> EAX:  Maximum sub-leaf number:  0
> EBX/EDX/ECX:  Vendor string:
> 
> EBX =  "Inte"
> EDX =  "lTDX"
> ECX =  "    "
> 
> So when above condition is true, set X86_FEATURE_TDX_GUEST
> feature cap bit
		 ^
		 Fullstop.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index ac37830ae941..dddc3a27cc8a 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -238,6 +238,7 @@
>  #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
>  #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
>  #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted function */
> +#define X86_FEATURE_TDX_GUEST		( 8*32+22) /* Trusted Domain Extensions Guest */

What's the name of the feature bit? "TDX guest"? Why not only
X86_FEATURE_TDX and then you can have "tdx" in cpuinfo?

>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
>  #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> new file mode 100644
> index 000000000000..679500e807f3
> --- /dev/null
> +++ b/arch/x86/include/asm/tdx.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2020 Intel Corporation */
> +#ifndef _ASM_X86_TDX_H
> +#define _ASM_X86_TDX_H
> +
> +#define TDX_CPUID_LEAF_ID	0x21
> +
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +
> +#include <asm/cpufeature.h>

As before - put the include at the top.

> +void __init tdx_early_init(void);
> +
> +#else // !CONFIG_INTEL_TDX_GUEST

No need for that // - comment

> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> new file mode 100644
> index 000000000000..5b14b72e41c5
> --- /dev/null
> +++ b/arch/x86/kernel/tdx.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2020 Intel Corporation */
> +
> +#include <asm/tdx.h>
> +
> +static inline bool cpuid_has_tdx_guest(void)
> +{
> +	u32 eax, signature[3];

Shorten that array name to "sig" so that you don't have to break the
cpuid_count() line below.

> +
> +	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID)
> +		return false;
> +
> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &signature[0],
> +		    &signature[1], &signature[2]);
> +
> +	if (memcmp("IntelTDX    ", signature, 12))
> +		return false;
> +
> +	return true;

or simply:

return !memcmp(...

> +}
> +
> +void __init tdx_early_init(void)
> +{
> +	if (!cpuid_has_tdx_guest())
> +		return;
> +
> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> +
> +	pr_info("TDX guest is initialized\n");

Use pr_fmt in this file:

#undef pr_fmt
#define pr_fmt(fmt)     "x86/tdx: " fmt

and then do

	pr_info("Guest initialized\n");

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
