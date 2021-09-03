Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5952F4004C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhICSWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:22:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45188 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhICSWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:22:35 -0400
Received: from zn.tnic (p200300ec2f0d58000d44f02d043b904a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5800:d44:f02d:43b:904a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B24201EC0287;
        Fri,  3 Sep 2021 20:21:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630693293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hs5R959SOHm+FY2nHSnYB8p0QSZDrkCRkJApp51mQfY=;
        b=sVl7qEq4MBIoEdWUGYfhXOReT71JBg8eR4VGKyDJsHFqzpuL0PqAtzkBeVh9sqgsQhYwsd
        U/avLGOMLZlAjiUGGDSaTA1dsJYeg+/aV02O0Sir1Qd7JzHQ+jaVIM8m4HmhcJGgjE+ai1
        ZwHWaC0SHGAci2vIEwkQz9cyo7zMeq8=
Date:   Fri, 3 Sep 2021 20:22:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/11] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
Message-ID: <YTJn0HOkMd0thT+3@zn.tnic>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210903172812.1097643-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 10:28:02AM -0700, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index c5ce9845c999..ddc77c95adc6 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -59,27 +59,8 @@ static inline __cpuidle void native_halt(void)
>  
>  #endif
>  
> -#ifdef CONFIG_PARAVIRT_XXL
> -#include <asm/paravirt.h>
> -#else
> +#ifndef CONFIG_PARAVIRT
>  #ifndef __ASSEMBLY__
> -#include <linux/types.h>
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
> @@ -97,6 +78,33 @@ static inline __cpuidle void halt(void)
>  {
>  	native_halt();
>  }
> +#endif /* __ASSEMBLY__ */
> +#endif /* CONFIG_PARAVIRT */
> +
> +#ifdef CONFIG_PARAVIRT
> +#ifndef __ASSEMBLY__
> +#include <asm/paravirt.h>
> +#endif /* __ASSEMBLY__ */
> +#endif /* CONFIG_PARAVIRT */

I think the way we write those is like this:

#ifdef CONFIG_PARAVIRT

# ifndef __ASSEMBLY__
# include <asm/paravirt.h>
# endif

#else /* ! CONFIG_PARAVIRT */

# ifndef __ASSEMBLY__
/*
 * Used in the idle loop; sti takes one instruction cycle
 * to complete:
 */
static inline __cpuidle void arch_safe_halt(void)
{
	native_safe_halt();
}

/*
 * Used when interrupts are already enabled or to
 * shutdown the processor:
 */
static inline __cpuidle void halt(void)
{
	native_halt();
}
# endif /* __ASSEMBLY__ */

#endif /* CONFIG_PARAVIRT */

Note the empty space after the '#' of the inner ifdef to show that it is
an inner one.

Also, this header has clearly too many #if*def __ASSEMBLY__ things
sprinkled around. Lemme see if I can get rid of them so that it is at
least a bit readable.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
