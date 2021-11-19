Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C51456B25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 08:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhKSHy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 02:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKSHy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:54:57 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A5DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 23:51:56 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k1so9392292ilo.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 23:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHJ63EyrYstiFPxKW8TeYaIjNnO9UB1DYunK5TU+/6U=;
        b=kLMQ++Uxoc+OS1z0wPz00oRC34sKXu17Lx8X5O38Xdb37w3bJmmiv7dvyWzTUGSSwj
         p088gAaSl9djzmBM745iR2NxpkXURL40LyUAJ81D/2+4qqR35KHJDRdwbnT0zvMvhvgX
         3xJut5oXEkxRZcoEHkK8I4tpBliOqzrt+zlkvRd1tZYJ+QMgBVuMs3zQEGSGaDoXq8xy
         zbStBnSoe2i1VIUFZ2kGZ1jBukHGUqjbMus1zsaAR54tBSvHesQhzvmXJEzyRnKlEpX1
         ft8XW+gY5s1xkSUMaw5R4KbNFP4aWDiDPvwRHTbuM0vGRb1ybyTZ9C26GP9gRINnBjPj
         fvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHJ63EyrYstiFPxKW8TeYaIjNnO9UB1DYunK5TU+/6U=;
        b=B/622Wwsz9iEIuuKBj+dppcgw6RUuegV7/2DJFV9NUuFY7uAPRm7Dt5jzqpf3ygMNA
         mkubHy6Mr+pQYrxr7wghR7Hai0BCtMCJ3CBFAmm4NlprtiKzXXBuQPOR6ByQanZ+kuYT
         vWDFWgpaF37iuU1P9XhHoko1nOmKjz+FVhCyiZo4l94qAZkgmClHxW8DRQ+rDIKxA3/r
         fDHqsudLJoKCAfOLq9n11zV5m9+FVcVxuOIY+NyOs+tYBc0Dtt/XGWgrX1eVucJkh026
         KXGOWC0PDHDpULwLPKSyhd5rUwOvcNFCXhOiCLcuIw0UGIElnwplqev9mAXHlFQ71jxa
         y7cw==
X-Gm-Message-State: AOAM533k3vHypyNMEVMTIEAV6dxgBrVuimLRC8QESx4nN8MQ7fcONE8N
        Atq7V9AhUHfjUW4wpvEDxLrssVcMz7ByCBcWJs8=
X-Google-Smtp-Source: ABdhPJwJp0I3GE4GZ9EdGqVzipJUC6g3hvIW5O/7HBKoXM3S6eICcjxkYwv9frxHqm430WEuRuQGFGwrfl0+RzvkS/4=
X-Received: by 2002:a92:1a08:: with SMTP id a8mr3409418ila.286.1637308316255;
 Thu, 18 Nov 2021 23:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Fri, 19 Nov 2021 15:51:44 +0800
Message-ID: <CAJhGHyBRcAg33DxxGGpbnT+O7CGKp6Ktr3PtCZ0j50oTJ4fgrg@mail.gmail.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 7:14 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> TDX is going to use CONFIG_PARAVIRT_XXL, but kernel fails to compile if
> XEN_PV is not enabled:
>
>         ld.lld: error: undefined symbol: xen_iret
>
> It happens because INTERRUPT_RETURN defined to use xen_iret if
> CONFIG_PARAVIRT_XXL enabled regardless of CONFIG_XEN_PV.
>
> The issue is not visible in the current kernel because CONFIG_XEN_PV is
> the only user of CONFIG_PARAVIRT_XXL and there's no way to enable them
> separately.
>
> Rework code to define INTERRUPT_RETURN based on CONFIG_XEN_PV, not
> CONFIG_PARAVIRT_XXL.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Deep Shah <sdeep@vmware.com>
> Cc: "VMware, Inc." <pv-drivers@vmware.com>
> ---
>  arch/x86/include/asm/irqflags.h | 7 +++++--
>  arch/x86/include/asm/paravirt.h | 5 -----
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index b794b6da3214..3b8ddcb7be76 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -118,8 +118,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
>  #define SAVE_FLAGS             pushfq; popq %rax
>  #endif
>
> -#define INTERRUPT_RETURN       jmp native_iret
> -
>  #endif
>
>  #endif /* __ASSEMBLY__ */
> @@ -147,8 +145,13 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
>  #ifdef CONFIG_X86_64
>  #ifdef CONFIG_XEN_PV
>  #define SWAPGS ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
> +#define INTERRUPT_RETURN                                               \
> +       ANNOTATE_RETPOLINE_SAFE;                                        \
> +       ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",                \
> +               X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")

It is part of what CONFIG_PARAVIRT_XXL was designed for to enable
pv-aware INTERRUPT_RETURN.

I would prefer xen_iret is defined as a weak symbol unconditionally.
Like:

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf795d9..c0953f1b4559 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -635,6 +635,7 @@ SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
        jnz     native_irq_return_ldt
 #endif

+SYM_INNER_LABEL(xen_iret, SYM_L_WEAK) /* placeholder */
 SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
        /*
         * This may fault.  Non-paranoid faults on return to userspace are

It will work when !CONFIG_XEN_PV
