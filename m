Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB582423167
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhJEUPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231159AbhJEUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633464804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VrzmQTuJxDuCxaH5LlxIeXSJzPyHutyDJ9hcxlOTlsc=;
        b=HelTXipJs/ulzOBPaDPn/Q3Ms8wqXKZV1yrmFWdr/2+0wI5RPWWsJ1XrTcAKINgwDVOnF/
        qPL4U3//5qTs9GZG7YtVJRMwCMEJE89/Gb/axO8n0m3EbjK6ZBQyfa0wkPoxkakd9RKHTc
        ud22gRTuZ3yHgjP22kwXqczLvNuX848=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-Ho9-KbsxP--3opYuryF7qw-1; Tue, 05 Oct 2021 16:13:23 -0400
X-MC-Unique: Ho9-KbsxP--3opYuryF7qw-1
Received: by mail-ot1-f71.google.com with SMTP id i14-20020a056830402e00b0054dd0ce0d1dso171318ots.19
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VrzmQTuJxDuCxaH5LlxIeXSJzPyHutyDJ9hcxlOTlsc=;
        b=HoB63QzaXYONZe3krx5Y7HgOcBIuvJ4V7eS2dUZBh3Csm67WjbRphr73u5zGUsiutx
         dSDs/LLvHWOiFMYiYwzVZqm/SOwkqlOofj5/KBqE1kADg3jsVF81jzfoO3hdj+3INJ5A
         2lBYpmNYSjXSnHtmWa3DOt+U6TvIsvids9ZPN/TCTIaLQHAwvi1w0ZupOyuwGRncmKmh
         WAk0Xdj4qNhKibnQJG+zxo7P0fTr0RKxBoR+aK62mDZudLkx4j6smbw52QODC/2RUZpp
         l6xHaI6EwZqkXJa8gsIiQp6YOXyoumoG/xIvQhCA7M7wtEa46ovhRMyiBQUdi6s6vxa/
         rkcA==
X-Gm-Message-State: AOAM531wl6Kgy0jdy958lD5z5xLtq/IXrQOw4+b4+sN3mTK4uPcWlEUn
        pnjP6OKHreUZOb4PiZFPahzaABcK2P7Ik8rKv/YRUV45az8FWBWm5BQ2SYm8jE5OiMuCAZgFgJ3
        p32rpaRfzDV48xlUj2xG7NGla
X-Received: by 2002:a4a:e899:: with SMTP id g25mr15361842ooe.68.1633464802478;
        Tue, 05 Oct 2021 13:13:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxKkpnxVQNEwBkQVwiLwbOJYc9xRbja1jET9UaR8MfJsz6rK+2uitr8DwJKnW6kI1nOhNEPw==
X-Received: by 2002:a4a:e899:: with SMTP id g25mr15361813ooe.68.1633464802233;
        Tue, 05 Oct 2021 13:13:22 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id d4sm3746201oth.47.2021.10.05.13.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:13:21 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:13:18 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
Subject: Re: [PATCH v8 01/11] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
Message-ID: <20211005201318.j3qg3swnovo7a3ot@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:51:55PM -0700, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index c5ce9845c999..2a2ebf9af43e 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -59,27 +59,15 @@ static inline __cpuidle void native_halt(void)
>  
>  #endif
>  
> -#ifdef CONFIG_PARAVIRT_XXL
> -#include <asm/paravirt.h>
> -#else
> -#ifndef __ASSEMBLY__
> -#include <linux/types.h>
> +#ifdef CONFIG_PARAVIRT
>  
> -static __always_inline unsigned long arch_local_save_flags(void)
> -{
> -	return native_save_fl();
> -}
> -
> -static __always_inline void arch_local_irq_disable(void)
> -{
> -	native_irq_disable();
> -}
> +# ifndef __ASSEMBLY__
> +# include <asm/paravirt.h>
> +# endif /* __ASSEMBLY__ */
>  
> -static __always_inline void arch_local_irq_enable(void)
> -{
> -	native_irq_enable();
> -}
> +#else /* ! CONFIG_PARAVIRT */
>  
> +# ifndef __ASSEMBLY__
>  /*
>   * Used in the idle loop; sti takes one instruction cycle
>   * to complete:
> @@ -97,6 +85,28 @@ static inline __cpuidle void halt(void)
>  {
>  	native_halt();
>  }
> +# endif /* __ASSEMBLY__ */
> +
> +#endif /* CONFIG_PARAVIRT */
> +
> +#ifndef CONFIG_PARAVIRT_XXL
> +#ifndef __ASSEMBLY__

There are a lot of '__ASSEMBLY__' #ifdefs which make this macro maze
extra hard to follow.  Folding in something like this would help a lot:

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 2a2ebf9af43e..afecf7fa20d0 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -57,17 +57,12 @@ static inline __cpuidle void native_halt(void)
 	asm volatile("hlt": : :"memory");
 }
 
-#endif
-
 #ifdef CONFIG_PARAVIRT
 
-# ifndef __ASSEMBLY__
 # include <asm/paravirt.h>
-# endif /* __ASSEMBLY__ */
 
 #else /* ! CONFIG_PARAVIRT */
 
-# ifndef __ASSEMBLY__
 /*
  * Used in the idle loop; sti takes one instruction cycle
  * to complete:
@@ -85,9 +80,9 @@ static inline __cpuidle void halt(void)
 {
 	native_halt();
 }
-# endif /* __ASSEMBLY__ */
 
 #endif /* CONFIG_PARAVIRT */
+#endif /* __ASSEMBLY__ */
 
 #ifndef CONFIG_PARAVIRT_XXL
 #ifndef __ASSEMBLY__

