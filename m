Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8607E3E9F57
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhHLHSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhHLHSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:18:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C041C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:17:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f8300af8ada8aa61ab0b3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8300:af8a:da8a:a61a:b0b3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4001A1EC0345;
        Thu, 12 Aug 2021 09:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628752660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rlbGUby7rx2QkiCySEi6WXCyifPvfBthfPyCaUrpaLc=;
        b=VGj+6MDYHJpXuXWHYk7AbYhv8P/p0nJRCed4SL5osKyvLByiTm+fk+MxeJwXltxWkfNSJ3
        72bGBHOMSbgzr3u1az3vO7cvHfYmTo/bApWKHci0va1dcAB/5LvWtqxHDB6OXwyNjIqaUU
        c+kuxJ7dQ5xfQsdwP6t8VfOV4FHHBKA=
Date:   Thu, 12 Aug 2021 09:18:19 +0200
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
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH v5 01/12] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
Message-ID: <YRTLO0eQOEChETId@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804181329.2899708-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:13:18AM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
> other VM guest types, features supported under CONFIG_PARAVIRT
> are self sufficient. CONFIG_PARAVIRT mainly provides support for
> TLB flush operations and time related operations.
> 
> For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
> most of its requirement except the need of HLT and SAFE_HLT
> paravirt calls, which is currently defined under
> COFNIG_PARAVIRT_XXL.
> 
> Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
> like platforms, move HLT and SAFE_HLT paravirt calls under
> CONFIG_PARAVIRT.
> 
> Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
> break any functionality for current users of CONFIG_PARAVIRT.
> 
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

You need to do this before sending your patches:

./scripts/get_maintainer.pl /tmp/tdx.01
Thomas Gleixner <tglx@linutronix.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT),commit_signer:1/6=17%)
Ingo Molnar <mingo@redhat.com> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Borislav Petkov <bp@alien8.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT),commit_signer:6/6=100%)
x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
"H. Peter Anvin" <hpa@zytor.com> (reviewer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Juergen Gross <jgross@suse.com> (supporter:PARAVIRT_OPS INTERFACE,commit_signer:5/6=83%,authored:5/6=83%,added_lines:15/16=94%,removed_lines:38/39=97%)
Deep Shah <sdeep@vmware.com> (supporter:PARAVIRT_OPS INTERFACE)
"VMware, Inc." <pv-drivers@vmware.com> (supporter:PARAVIRT_OPS INTERFACE)
...

and CC also the supporters - I'm pretty sure at least Juergen would like
to be kept up-to-date on pv changes. I'll CC him and the others now and
leave in the whole diff but make sure you do that in the future please.

>  arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
>  arch/x86/include/asm/paravirt.h       | 20 +++++++-------
>  arch/x86/include/asm/paravirt_types.h |  3 +-
>  arch/x86/kernel/paravirt.c            |  4 ++-
>  4 files changed, 36 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index c5ce9845c999..f3bb33b1715d 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -59,6 +59,28 @@ static inline __cpuidle void native_halt(void)
>  
>  #endif
>  
> +#ifndef CONFIG_PARAVIRT
> +#ifndef __ASSEMBLY__
> +/*
> + * Used in the idle loop; sti takes one instruction cycle
> + * to complete:
> + */
> +static inline __cpuidle void arch_safe_halt(void)
> +{
> +	native_safe_halt();
> +}
> +
> +/*
> + * Used when interrupts are already enabled or to
> + * shutdown the processor:
> + */
> +static inline __cpuidle void halt(void)
> +{
> +	native_halt();
> +}
> +#endif /* __ASSEMBLY__ */
> +#endif /* CONFIG_PARAVIRT */
> +
>  #ifdef CONFIG_PARAVIRT_XXL
>  #include <asm/paravirt.h>
>  #else
> @@ -80,24 +102,6 @@ static __always_inline void arch_local_irq_enable(void)
>  	native_irq_enable();
>  }
>  
> -/*
> - * Used in the idle loop; sti takes one instruction cycle
> - * to complete:
> - */
> -static inline __cpuidle void arch_safe_halt(void)
> -{
> -	native_safe_halt();
> -}
> -
> -/*
> - * Used when interrupts are already enabled or to
> - * shutdown the processor:
> - */
> -static inline __cpuidle void halt(void)
> -{
> -	native_halt();
> -}
> -
>  /*
>   * For spinlocks, etc:
>   */
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index da3a1ac82be5..d323a626c7a8 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -97,6 +97,16 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
>  	PVOP_VCALL1(mmu.exit_mmap, mm);
>  }
>  
> +static inline void arch_safe_halt(void)
> +{
> +	PVOP_VCALL0(irq.safe_halt);
> +}
> +
> +static inline void halt(void)
> +{
> +	PVOP_VCALL0(irq.halt);
> +}
> +
>  #ifdef CONFIG_PARAVIRT_XXL
>  static inline void load_sp0(unsigned long sp0)
>  {
> @@ -162,16 +172,6 @@ static inline void __write_cr4(unsigned long x)
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
>  	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT(X86_FEATURE_XENPV));
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index d9d6b0203ec4..40082847f314 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -150,10 +150,9 @@ struct pv_irq_ops {
>  	struct paravirt_callee_save save_fl;
>  	struct paravirt_callee_save irq_disable;
>  	struct paravirt_callee_save irq_enable;
> -
> +#endif
>  	void (*safe_halt)(void);
>  	void (*halt)(void);
> -#endif
>  } __no_randomize_layout;
>  
>  struct pv_mmu_ops {
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 04cafc057bed..124e0f6c5d1c 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -283,9 +283,11 @@ struct paravirt_patch_template pv_ops = {
>  	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
>  	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
>  	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
> +#endif /* CONFIG_PARAVIRT_XXL */
> +
> +	/* Irq HLT ops. */

What's that comment for?

>  	.irq.safe_halt		= native_safe_halt,
>  	.irq.halt		= native_halt,
> -#endif /* CONFIG_PARAVIRT_XXL */
>  
>  	/* Mmu ops. */
>  	.mmu.flush_tlb_user	= native_flush_tlb_local,
> -- 
> 2.25.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
