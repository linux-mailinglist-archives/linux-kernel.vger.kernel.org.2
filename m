Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CA23E2B38
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343999AbhHFNPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbhHFNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:15:04 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF73C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 06:14:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m18so584722ljo.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1EUQQB8pNWqOdaIHcqaccRGVpN7D96fkqmkWU/G1Go=;
        b=VBFkSeoM0MDEuRDVWRNzCSd8lUuAkAkwl8MOor8uD1xzJOeuHOGG08wna9pkbp49/B
         kDK7sKNj69dWKTUQ1tmJN7nnHP7YAQvMvs0YP7azUuJolNS1P3ABKJx1rzpQhRyGcthi
         2wIqpDEUbZ2zNHVCSSFq2sHeCk1/i8K7rYHGo7bZfjBV1j1CKO7oJifr64i5oO4CaU8h
         bLkx5hPffsukaI6cOqj4Qk2Yme7UWPP1uuEnyyK48RPXh/3PhhpMeGSsF25zVQKTvFi3
         vkDPR0yn3nGdaOmjpGmxQNAsKqRySw4QwWGiAbetv4ZQrM8vi2mzJZj0Ah/14Ml0yy/A
         2TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1EUQQB8pNWqOdaIHcqaccRGVpN7D96fkqmkWU/G1Go=;
        b=VneJre2ykRN+3sjqVWKTjikngjIVK//1P+VvbGlUX4feS0pzpQDDZVwwG5xmnX15zL
         /z39ktN2evtHgdcj25C9tkWPTrgWhEPuUBAwfvLrOjXgwY9onSdpW8YAfTrwKQEOyezV
         fTRSEHgHJyjefFr44PlsWWZo92qrrcsV02RoDCfDijju5fNjacoZOpshWIVPtI00MhfA
         bYgvZQkShb0MWB4WAl9xYTPP51nA87lYYHWibZ2/2WPFeZoh5occ8JuRIpPiNjXKpdeX
         qT07YPzOOUebwQnu7m9PhUiF7NbwD3MHCm4r+J0fZb2wM/8Y1a4JcJxba0PIRTMGaCKr
         Iezw==
X-Gm-Message-State: AOAM531INoSF32Wcs1HMxbahzjDiqPVssWML2bDFoNgIpj7JOGRRmzYe
        z2hSxdLfGtRcFrxK1CV+KPgg2kxtahQ4/kW/+MQ=
X-Google-Smtp-Source: ABdhPJw1QTWFG3ah81HEQQrWVxzoREAZSPfao1dbNbVueBqoKQY3vEIVZFTsb4casd/1Och6p5hRNeRES+NFUuKDztA=
X-Received: by 2002:a2e:9d47:: with SMTP id y7mr6390517ljj.408.1628255687307;
 Fri, 06 Aug 2021 06:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210726143053.532839-1-sxwjean@me.com> <874kc3njxh.fsf@mpe.ellerman.id.au>
In-Reply-To: <874kc3njxh.fsf@mpe.ellerman.id.au>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 6 Aug 2021 21:14:21 +0800
Message-ID: <CAEVVKH-7suvS3E6ZDbSXL=18Mocjn8kHTeemF0yOG8Egy2nzjA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] powerpc: Optimize register usage for esr register
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Xiongwei Song <sxwjean@me.com>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>, oleg@redhat.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ravi.bangoria@linux.ibm.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
        sandipan@linux.ibm.com, efremov@linux.com, peterx@redhat.com,
        akpm@linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 2:53 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> sxwjean@me.com writes:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > Create an anonymous union for dsisr and esr regsiters, we can reference
> > esr to get the exception detail when CONFIG_4xx=y or CONFIG_BOOKE=y.
> > Otherwise, reference dsisr. This makes code more clear.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >  arch/powerpc/include/asm/ptrace.h          |  5 ++++-
> >  arch/powerpc/include/uapi/asm/ptrace.h     |  5 ++++-
> >  arch/powerpc/kernel/process.c              |  2 +-
> >  arch/powerpc/kernel/ptrace/ptrace.c        |  2 ++
> >  arch/powerpc/kernel/traps.c                |  2 +-
> >  arch/powerpc/mm/fault.c                    | 16 ++++++++++++++--
> >  arch/powerpc/platforms/44x/machine_check.c |  4 ++--
> >  arch/powerpc/platforms/4xx/machine_check.c |  2 +-
> >  8 files changed, 29 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> > index 3e5d470a6155..c252d04b1206 100644
> > --- a/arch/powerpc/include/asm/ptrace.h
> > +++ b/arch/powerpc/include/asm/ptrace.h
> > @@ -44,7 +44,10 @@ struct pt_regs
> >  #endif
> >                       unsigned long trap;
> >                       unsigned long dar;
> > -                     unsigned long dsisr;
> > +                     union {
> > +                             unsigned long dsisr;
> > +                             unsigned long esr;
> > +                     };
>
> I don't mind doing that.
>
> >                       unsigned long result;
> >               };
> >       };
> > diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> > index 7004cfea3f5f..e357288b5f34 100644
> > --- a/arch/powerpc/include/uapi/asm/ptrace.h
> > +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> > @@ -53,7 +53,10 @@ struct pt_regs
> >       /* N.B. for critical exceptions on 4xx, the dar and dsisr
> >          fields are overloaded to hold srr0 and srr1. */
> >       unsigned long dar;              /* Fault registers */
> > -     unsigned long dsisr;            /* on 4xx/Book-E used for ESR */
> > +     union {
> > +             unsigned long dsisr;            /* on Book-S used for DSISR */
> > +             unsigned long esr;              /* on 4xx/Book-E used for ESR */
> > +     };
> >       unsigned long result;           /* Result of a system call */
> >  };
>
> But I'm not sure about the use of anonymous unions in UAPI headers. Old
> compilers don't support them, so there's a risk of breakage.
>
> I'd rather we didn't touch the uapi version.

Ok. Will discard the change.

>
>
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 185beb290580..f74af8f9133c 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1499,7 +1499,7 @@ static void __show_regs(struct pt_regs *regs)
> >           trap == INTERRUPT_DATA_STORAGE ||
> >           trap == INTERRUPT_ALIGNMENT) {
> >               if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> > -                     pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
> > +                     pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->esr);
> >               else
> >                       pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
> >       }
> > diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> > index 0a0a33eb0d28..00789ad2c4a3 100644
> > --- a/arch/powerpc/kernel/ptrace/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> > @@ -375,6 +375,8 @@ void __init pt_regs_check(void)
> >                    offsetof(struct user_pt_regs, dar));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=
> >                    offsetof(struct user_pt_regs, dsisr));
> > +     BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=
> > +                  offsetof(struct user_pt_regs, esr));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
> >                    offsetof(struct user_pt_regs, result));
> >
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index dfbce527c98e..2164f5705a0b 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -562,7 +562,7 @@ static inline int check_io_access(struct pt_regs *regs)
> >  #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> >  /* On 4xx, the reason for the machine check or program exception
> >     is in the ESR. */
> > -#define get_reason(regs)     ((regs)->dsisr)
> > +#define get_reason(regs)     ((regs)->esr)
> >  #define REASON_FP            ESR_FP
> >  #define REASON_ILLEGAL               (ESR_PIL | ESR_PUO)
> >  #define REASON_PRIVILEGED    ESR_PPR
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index a8d0ce85d39a..62953d4e7c93 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -541,7 +541,11 @@ static __always_inline void __do_page_fault(struct pt_regs *regs)
> >  {
> >       long err;
> >
> > -     err = ___do_page_fault(regs, regs->dar, regs->dsisr);
> > +     if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> > +             err = ___do_page_fault(regs, regs->dar, regs->esr);
> > +     else
> > +             err = ___do_page_fault(regs, regs->dar, regs->dsisr);
>
> As Christophe said, I don't thinks this is an improvement.
>
> It makes the code less readable. If anyone is confused about what is
> passed to ___do_page_fault() they can either read the comment above it,
> or look at the definition of pt_regs to see that esr and dsisr share
> storage.

Ok, thanks a lot.  Will send v2.

Regards,
Xiongwei

>
> cheers
