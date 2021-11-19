Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C33456D21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhKSKXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhKSKXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:23:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42037C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:20:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u3so41085212lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vyyQJIWDzg6rJQ1Qz1fjtgsCYKQWfuK5Mnjns/24eJU=;
        b=Lm7RVciQKQDnaI/owA4a/9KQVIlYh357n7C28DXsafFmr2VA8Tf1HiCqE4FAJVC0tg
         ml9E/iVn8Y32VoTYBSXGfYdxVJgs56erdM/oDHNgKLhm4fxDP50UxCpbCAM2Bbr644ey
         nBMi4aW6UPxhzbjMz/vnZyLX+pLRHEMpPDYfYAA+3nDw7UMAHV+/4zkIGx62D3GhdnDA
         9a6Yzd31h0rOESI6v8rVFyuUJVZmn7kZdjaxRkJufqvlQoH3DszAkttpcU9dTa5PTmvH
         O19pLE3m8WooqpcQaRHk4N4qKceWS48fyaYriyNucAtNWH0iDwQbtFgpc0KOmgMbN2Dc
         hl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyyQJIWDzg6rJQ1Qz1fjtgsCYKQWfuK5Mnjns/24eJU=;
        b=xuaMox4yNlLL2pqXFUjlpYL6zDbt3RHr6YLRUqpGtK82f4zjPQfbm88u5zc0gE6uvR
         l0eJMI623KCz7VMR+hbLSaxK7q4fmJ9XpdLs7hl0aO0gE5Jtsdb3C11iFwDyWjhg2Cqo
         uTa26RPSiiBoU2t21ymKvSoicFgvrlWqzMbgJ+eGfkM83BbpP9/7mLyJwdsYEuoGUTu8
         KdSdeYq9KRJAHeeM5UaBiSRFZBfhjRDEPOw8sZTYxIZ1m8IghfOxYB2qMwXJGb1eo4TD
         Z8REZSH3cpvWVIwb3KdGWDnrZ2qYuU/tkGbjo8x6tSqp5fAlcZKTahFgLgqRFOJuI3EQ
         npfg==
X-Gm-Message-State: AOAM530kegKcetH5KDdjMbSf7xgJ4kCuT55iYkDkkNFHgVsbplrGdWTR
        ZD5K1KFok38EZWpJSIlddypZvbuE+emlaDzN
X-Google-Smtp-Source: ABdhPJy5vFZyTMrZZFY+KcNekCc5HhV3heR7yONkgF8G84SRU0b7P5Iw3JIad3lwBY/erTSEXrD/Zw==
X-Received: by 2002:a05:651c:11cf:: with SMTP id z15mr23237961ljo.30.1637317243587;
        Fri, 19 Nov 2021 02:20:43 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id bp41sm320059lfb.129.2021.11.19.02.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 02:20:42 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1CAFF103304; Fri, 19 Nov 2021 13:20:48 +0300 (+03)
Date:   Fri, 19 Nov 2021 13:20:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Message-ID: <20211119102048.hjm46edvhryjgluy@box.shutemov.name>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <CAJhGHyBRcAg33DxxGGpbnT+O7CGKp6Ktr3PtCZ0j50oTJ4fgrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBRcAg33DxxGGpbnT+O7CGKp6Ktr3PtCZ0j50oTJ4fgrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 03:51:44PM +0800, Lai Jiangshan wrote:
> On Thu, Nov 18, 2021 at 7:14 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > TDX is going to use CONFIG_PARAVIRT_XXL, but kernel fails to compile if
> > XEN_PV is not enabled:
> >
> >         ld.lld: error: undefined symbol: xen_iret
> >
> > It happens because INTERRUPT_RETURN defined to use xen_iret if
> > CONFIG_PARAVIRT_XXL enabled regardless of CONFIG_XEN_PV.
> >
> > The issue is not visible in the current kernel because CONFIG_XEN_PV is
> > the only user of CONFIG_PARAVIRT_XXL and there's no way to enable them
> > separately.
> >
> > Rework code to define INTERRUPT_RETURN based on CONFIG_XEN_PV, not
> > CONFIG_PARAVIRT_XXL.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Deep Shah <sdeep@vmware.com>
> > Cc: "VMware, Inc." <pv-drivers@vmware.com>
> > ---
> >  arch/x86/include/asm/irqflags.h | 7 +++++--
> >  arch/x86/include/asm/paravirt.h | 5 -----
> >  2 files changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> > index b794b6da3214..3b8ddcb7be76 100644
> > --- a/arch/x86/include/asm/irqflags.h
> > +++ b/arch/x86/include/asm/irqflags.h
> > @@ -118,8 +118,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
> >  #define SAVE_FLAGS             pushfq; popq %rax
> >  #endif
> >
> > -#define INTERRUPT_RETURN       jmp native_iret
> > -
> >  #endif
> >
> >  #endif /* __ASSEMBLY__ */
> > @@ -147,8 +145,13 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
> >  #ifdef CONFIG_X86_64
> >  #ifdef CONFIG_XEN_PV
> >  #define SWAPGS ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
> > +#define INTERRUPT_RETURN                                               \
> > +       ANNOTATE_RETPOLINE_SAFE;                                        \
> > +       ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",                \
> > +               X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
> 
> It is part of what CONFIG_PARAVIRT_XXL was designed for to enable
> pv-aware INTERRUPT_RETURN.

That's very vague statement.

Could you elaborate on what is wrong with proposed fix?

> I would prefer xen_iret is defined as a weak symbol unconditionally.
> Like:
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index e38a4cf795d9..c0953f1b4559 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -635,6 +635,7 @@ SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
>         jnz     native_irq_return_ldt
>  #endif
> 
> +SYM_INNER_LABEL(xen_iret, SYM_L_WEAK) /* placeholder */
>  SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
>         /*
>          * This may fault.  Non-paranoid faults on return to userspace are
> 
> It will work when !CONFIG_XEN_PV

It pollutes namespace for no particular reason. I don't see it justified.

-- 
 Kirill A. Shutemov
