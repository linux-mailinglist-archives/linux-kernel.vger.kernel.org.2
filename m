Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6A36CA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbhD0RcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:32:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60178 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0Rb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:31:56 -0400
Received: from zn.tnic (p200300ec2f0c5e0085f018e791730569.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5e00:85f0:18e7:9173:569])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D612A1EC046E;
        Tue, 27 Apr 2021 19:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619544672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIQmBI+Zo3BhMV/gviAp3eIvYdirpGxvrasft61aLUs=;
        b=dTzAlnNA1z73ZlcP8IgG4voK33h2ynjN4Nzgfza5WCYqVpGapyfC5U4Y66Iw/sW+LPx7VK
        2m1TgfhI0djwxM04fpJhE/9B+VrVloQ6pA9Sn0g8im6F4p38Ir5FK3AOLmOD0AxYUQojxL
        IR5B4SDcRtoFud7fv7nJdxuRmIeKyqM=
Date:   Tue, 27 Apr 2021 19:31:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?J=C3=BCrgen?= Gross <jgross@suse.com>
Subject: Re: [RFC v2 01/32] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
Message-ID: <YIhKXcNuinL0ar0O@zn.tnic>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4f8c9559dd04d8e8485c419c5ebc9471613f7928.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f8c9559dd04d8e8485c419c5ebc9471613f7928.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jürgen.

On Mon, Apr 26, 2021 at 11:01:28AM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Split off halt paravirt calls from CONFIG_PARAVIRT_XXL into
> a separate config option. It provides a middle ground for
> not-so-deep paravirtulized environments.

Please introduce a spellchecker into your patch creation workflow.

Also, what does "not-so-deep" mean?

> CONFIG_PARAVIRT_XL will be used by TDX that needs couple of paravirt
> calls that were hidden under CONFIG_PARAVIRT_XXL, but the rest of the
> config would be a bloat for TDX.

Used how? Why is it bloat for TDX?

I'm sure that'll become clear in the remainder of the patches but you
should state it here so that it is clear why you're doing what you're
doing.

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/Kconfig                      |  4 +++
>  arch/x86/boot/compressed/misc.h       |  1 +
>  arch/x86/include/asm/irqflags.h       | 38 +++++++++++++++------------
>  arch/x86/include/asm/paravirt.h       | 22 +++++++++-------
>  arch/x86/include/asm/paravirt_types.h |  3 ++-
>  arch/x86/kernel/paravirt.c            |  4 ++-
>  arch/x86/mm/mem_encrypt_identity.c    |  1 +
>  7 files changed, 44 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2792879d398e..6b4b682af468 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -783,8 +783,12 @@ config PARAVIRT
>  	  over full virtualization.  However, when run without a hypervisor
>  	  the kernel is theoretically slower and slightly larger.
>  
> +config PARAVIRT_XL
> +	bool
> +
>  config PARAVIRT_XXL
>  	bool
> +	select PARAVIRT_XL
>  
>  config PARAVIRT_DEBUG
>  	bool "paravirt-ops debugging"
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 901ea5ebec22..4b84abe43765 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -9,6 +9,7 @@
>   * paravirt and debugging variants are added.)
>   */
>  #undef CONFIG_PARAVIRT
> +#undef CONFIG_PARAVIRT_XL
>  #undef CONFIG_PARAVIRT_XXL

So what happens if someone else needs even less pv and defines
CONFIG_PARAVIRT_L. Or _M? Or _S?

Are we going to teleport into a clothing store each time we look at
paravirt now? :)

So before this goes out of hand let's define explicitly, pls, what
XXL means and XL. And rename them. They could be called PARAVIRT_FULL
and PARAVIRT_HLT as apparently that thing is exposing only the PV ops
related to HLT.

Or something to that effect.

Dunno, maybe Jürgen has a better idea, leaving in the rest quoted for him.

Thx.

>  #undef CONFIG_PARAVIRT_SPINLOCKS
>  #undef CONFIG_KASAN
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index 144d70ea4393..1688841893d7 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -59,27 +59,11 @@ static inline __cpuidle void native_halt(void)
>  
>  #endif
>  
> -#ifdef CONFIG_PARAVIRT_XXL
> +#ifdef CONFIG_PARAVIRT_XL
>  #include <asm/paravirt.h>
>  #else
>  #ifndef __ASSEMBLY__
>  #include <linux/types.h>
> -
> -static __always_inline unsigned long arch_local_save_flags(void)
> -{
> -	return native_save_fl();
> -}
> -
> -static __always_inline void arch_local_irq_disable(void)
> -{
> -	native_irq_disable();
> -}
> -
> -static __always_inline void arch_local_irq_enable(void)
> -{
> -	native_irq_enable();
> -}
> -
>  /*
>   * Used in the idle loop; sti takes one instruction cycle
>   * to complete:
> @@ -97,6 +81,26 @@ static inline __cpuidle void halt(void)
>  {
>  	native_halt();
>  }
> +#endif /* !__ASSEMBLY__ */
> +#endif /* CONFIG_PARAVIRT_XL */
> +
> +#ifndef CONFIG_PARAVIRT_XXL
> +#ifndef __ASSEMBLY__
> +
> +static __always_inline unsigned long arch_local_save_flags(void)
> +{
> +	return native_save_fl();
> +}
> +
> +static __always_inline void arch_local_irq_disable(void)
> +{
> +	native_irq_disable();
> +}
> +
> +static __always_inline void arch_local_irq_enable(void)
> +{
> +	native_irq_enable();
> +}
>  
>  /*
>   * For spinlocks, etc:
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 4abf110e2243..2dbb6c9c7e98 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -84,6 +84,18 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
>  	PVOP_VCALL1(mmu.exit_mmap, mm);
>  }
>  
> +#ifdef CONFIG_PARAVIRT_XL
> +static inline void arch_safe_halt(void)
> +{
> +	PVOP_VCALL0(irq.safe_halt);
> +}
> +
> +static inline void halt(void)
> +{
> +	PVOP_VCALL0(irq.halt);
> +}
> +#endif
> +
>  #ifdef CONFIG_PARAVIRT_XXL
>  static inline void load_sp0(unsigned long sp0)
>  {
> @@ -145,16 +157,6 @@ static inline void __write_cr4(unsigned long x)
>  	PVOP_VCALL1(cpu.write_cr4, x);
>  }
>  
> -static inline void arch_safe_halt(void)
> -{
> -	PVOP_VCALL0(irq.safe_halt);
> -}
> -
> -static inline void halt(void)
> -{
> -	PVOP_VCALL0(irq.halt);
> -}
> -
>  static inline void wbinvd(void)
>  {
>  	PVOP_VCALL0(cpu.wbinvd);
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index de87087d3bde..5261fba47ba5 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -177,7 +177,8 @@ struct pv_irq_ops {
>  	struct paravirt_callee_save save_fl;
>  	struct paravirt_callee_save irq_disable;
>  	struct paravirt_callee_save irq_enable;
> -
> +#endif
> +#ifdef CONFIG_PARAVIRT_XL
>  	void (*safe_halt)(void);
>  	void (*halt)(void);
>  #endif
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index c60222ab8ab9..d6d0b363fe70 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -322,9 +322,11 @@ struct paravirt_patch_template pv_ops = {
>  	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
>  	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
>  	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
> +#endif /* CONFIG_PARAVIRT_XXL */
> +#ifdef CONFIG_PARAVIRT_XL
>  	.irq.safe_halt		= native_safe_halt,
>  	.irq.halt		= native_halt,
> -#endif /* CONFIG_PARAVIRT_XXL */
> +#endif /* CONFIG_PARAVIRT_XL */
>  
>  	/* Mmu ops. */
>  	.mmu.flush_tlb_user	= native_flush_tlb_local,
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 6c5eb6f3f14f..20d0cb116557 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -24,6 +24,7 @@
>   * be extended when new paravirt and debugging variants are added.)
>   */
>  #undef CONFIG_PARAVIRT
> +#undef CONFIG_PARAVIRT_XL
>  #undef CONFIG_PARAVIRT_XXL
>  #undef CONFIG_PARAVIRT_SPINLOCKS
>  
> -- 
> 2.25.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
