Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B513F62B7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhHXQe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:34:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44530 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229569AbhHXQe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:34:57 -0400
Received: from zn.tnic (p200300ec2f11440049ee8a07127e6a59.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:49ee:8a07:127e:6a59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4ED8E1EC04D1;
        Tue, 24 Aug 2021 18:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629822848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WReAeCmcujyRlEw8VFjfi6jnCagOpRVKxlDLiVwHDMM=;
        b=mf+IZ0KKzN2z+PLAy3yChJBq0W4PY+SuYPl7vp5+3lLKHOPGN/W4fVJD71FpY1Uc9KkawU
        27LbgZ+GcI+rbK2cUQmIqf/IftIrYIqJj3zvC2BSEMUG2C7qqtIoiKKpMpqvGLYVw+S3c9
        BJ3VRMy0Q3KlKt8vvvaTCh2Q2VkDzHc=
Date:   Tue, 24 Aug 2021 18:34:45 +0200
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
Subject: Re: [PATCH v5 09/12] x86/tdx: Wire up KVM hypercalls
Message-ID: <YSUfpQPvL6wsk6Ou@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-10-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804181329.2899708-10-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:13:26AM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> KVM hypercalls use the "vmcall" or "vmmcall" instructions.

Write instruction mnemonics in all caps pls.

> +# This option enables KVM specific hypercalls in TDX guest.
> +config INTEL_TDX_GUEST_KVM

What is that config option really for? IOW, can't you use
CONFIG_KVM_GUEST instead?

> +	def_bool y
> +	depends on KVM_GUEST && INTEL_TDX_GUEST
> +
>  endif #HYPERVISOR_GUEST
>  
>  source "arch/x86/Kconfig.cpu"
> diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
> index 4cb726c71ed8..9855a9ff2924 100644
> --- a/arch/x86/include/asm/asm-prototypes.h
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -17,6 +17,10 @@
>  extern void cmpxchg8b_emu(void);
>  #endif
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +#include <asm/tdx.h>
> +#endif

What "ASM sysmbol generation issue" forced this?

...

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 846fe58f0426..8fa33e2c98db 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -6,8 +6,9 @@
>  #include <linux/cpufeature.h>
>  #include <linux/types.h>
>  
> -#define TDX_CPUID_LEAF_ID	0x21
> -#define TDX_HYPERCALL_STANDARD  0
> +#define TDX_CPUID_LEAF_ID			0x21
> +#define TDX_HYPERCALL_STANDARD			0
> +#define TDX_HYPERCALL_VENDOR_KVM		0x4d564b2e584454

						"TDX.KVM"

Yeah, you can put it in a comment so that people don't have to do the
CTRL-V game in vim insert mode, i.e., ":help i_CTRL-V_digit" :-)

>  /*
>   * Used in __tdx_module_call() helper function to gather the
> @@ -80,4 +81,29 @@ static inline bool tdx_prot_guest_has(unsigned long flag) { return false; }
>  
>  #endif /* CONFIG_INTEL_TDX_GUEST */
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST_KVM

I don't think that even needs the ifdeffery. If it is not used, the
inline will simply get discarded so why bother?

> +
> +static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
> +				     unsigned long p2, unsigned long p3,
> +				     unsigned long p4)
> +{
> +	struct tdx_hypercall_output out;
> +	u64 err;
> +
> +	err = __tdx_hypercall(TDX_HYPERCALL_VENDOR_KVM, nr, p1, p2,
> +			      p3, p4, &out);
> +
> +	BUG_ON(err);
> +
> +	return out.r10;
> +}
> +#else
> +static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
> +				     unsigned long p2, unsigned long p3,
> +				     unsigned long p4)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_INTEL_TDX_GUEST_KVM */
> +
>  #endif /* _ASM_X86_TDX_H */
> diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
> index 9df94f87465d..1823bac4542d 100644
> --- a/arch/x86/kernel/tdcall.S
> +++ b/arch/x86/kernel/tdcall.S
> @@ -3,6 +3,7 @@
>  #include <asm/asm.h>
>  #include <asm/frame.h>
>  #include <asm/unwind_hints.h>
> +#include <asm/export.h>
>  
>  #include <linux/linkage.h>
>  #include <linux/bits.h>
> @@ -309,3 +310,4 @@ skip_sti:
>  
>         retq
>  SYM_FUNC_END(__tdx_hypercall)
> +EXPORT_SYMBOL(__tdx_hypercall);

EXPORT_SYMBOL_GPL, of course.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
