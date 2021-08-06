Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC903E221A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 05:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbhHFDQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 23:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhHFDQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 23:16:48 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2BDC061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 20:16:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b21so9906181ljo.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 20:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RmRATZxrymVsUqvsQ5vTjEe605V0iyo3kp0EeC+Y5p0=;
        b=rhj+LKN7OY+Dw294X/vOBki1UE3swP8RONHxScGZ7Hv+7g4gBrjmBaXsx8KO8Hp6id
         BgWsaCrCobvAHJOXFFegrft7dWq2iaRmGR/b+nJap0fGkiIuLJrgvzyOZImgFM+B6Ouj
         dgQPpkIneBAy6IHHMSHeUvkQQpuhdeI52uLhPfU5ZzimjlknZUYLLH1HNagBLAS+pQdZ
         W3D9LzppADUM5iC/3mwXBjaa3/q9ki3O3uCJb1srwpSq0S0c1yeRgvY96abxDkofqdDr
         +djfgy4X6+odkKsouZySCtHVr1D6pXo1PDx+3PzYQO7bBvgSBIHfiekM467zD44/Y2Y0
         Njkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RmRATZxrymVsUqvsQ5vTjEe605V0iyo3kp0EeC+Y5p0=;
        b=OFSH32VX5r4sJxaaXPL14513dF/N7DnWkGsqPFyXNlvO10ih8CyLt6Jv7rN+519ANf
         70awt2NP/rY1rRtZ/eInmJ0Fz74Dz7zv9tQP2IyHauLn8I2WgYHzUPJFbA6+HyikyqCk
         /oXp7DBd1qrqU2Vx4Kf6/7GfoMRo6nfAxLOtLue+C+XA7q43bx7EYHMTeu1oL7ogTtp3
         gbLAf3v36mDDHkJuvP5T4mg2bffMlvTnb6xXhYBovz2i0dOqXMd0lGfWqyvbvaeb48DP
         GcXklMnx0w75oTF/BcjG+nPXjVZceRKtr6Fs+wrp/WPehJOwnwZ9HYUSKXcU9dULsA9x
         35WA==
X-Gm-Message-State: AOAM532QqNkVMim7qNj0ExP+YyPzzizNOQmnrdwf0np802Lt6sxH6olU
        wwOS6OVynG+oTpTMY0CqPsa+exKx0E6xglufUBI=
X-Google-Smtp-Source: ABdhPJzUdM+HDWSM1iZqx4YSWjIdow+6ZgqSIaqlID5PznpvQ1vjprIINnFT39mCGJtkScok9g5Y6Y9HmXCNs8TUW7k=
X-Received: by 2002:a2e:a817:: with SMTP id l23mr5193557ljq.86.1628219791097;
 Thu, 05 Aug 2021 20:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210726143053.532839-1-sxwjean@me.com> <5e2336aa-90bf-b820-b5e4-e9a63088930f@csgroup.eu>
In-Reply-To: <5e2336aa-90bf-b820-b5e4-e9a63088930f@csgroup.eu>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 6 Aug 2021 11:16:04 +0800
Message-ID: <CAEVVKH-rht+xpwTUL=ny6qENe2Fb0n=3e7DEmc5qzpSq2_1gTA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] powerpc: Optimize register usage for esr register
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Xiongwei Song <sxwjean@me.com>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>, oleg@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ravi.bangoria@linux.ibm.com,
        npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
        sandipan@linux.ibm.com, efremov@linux.com, peterx@redhat.com,
        akpm@linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 6:06 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 26/07/2021 =C3=A0 16:30, sxwjean@me.com a =C3=A9crit :
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > Create an anonymous union for dsisr and esr regsiters, we can reference
> > esr to get the exception detail when CONFIG_4xx=3Dy or CONFIG_BOOKE=3Dy=
.
> > Otherwise, reference dsisr. This makes code more clear.
>
> I'm not sure it is worth doing that.
Why don't we use "esr" as reference manauls mentioned?

>
> What is the point in doing the following when you know that regs->esr and=
 regs->dsisr are exactly
> the same:
>
>  > -    err =3D ___do_page_fault(regs, regs->dar, regs->dsisr);
>  > +    if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
>  > +            err =3D ___do_page_fault(regs, regs->dar, regs->esr);
>  > +    else
>  > +            err =3D ___do_page_fault(regs, regs->dar, regs->dsisr);
>  > +
Yes, we can drop this. But it's a bit vague.

> Or even
>
>  > -    int is_write =3D page_fault_is_write(regs->dsisr);
>  > +    unsigned long err_reg;
>  > +    int is_write;
>  > +
>  > +    if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
>  > +            err_reg =3D regs->esr;
>  > +    else
>  > +            err_reg =3D regs->dsisr;
>  > +
>  > +    is_write =3D page_fault_is_write(err_reg);
>
>
> Artificially growing the code for that makes no sense to me.

We can drop this too.
>
>
> To avoid anbiguity, maybe the best would be to rename regs->dsisr to some=
thing like regs->sr , so
> that we know it represents the status register, which is DSISR or ESR dep=
ending on the platform.

If so, this would make other people more confused. My consideration is
to follow what the reference
manuals represent.

Thank you so much for your comments.

Regards,
Xiongwei
>
>
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >   arch/powerpc/include/asm/ptrace.h          |  5 ++++-
> >   arch/powerpc/include/uapi/asm/ptrace.h     |  5 ++++-
> >   arch/powerpc/kernel/process.c              |  2 +-
> >   arch/powerpc/kernel/ptrace/ptrace.c        |  2 ++
> >   arch/powerpc/kernel/traps.c                |  2 +-
> >   arch/powerpc/mm/fault.c                    | 16 ++++++++++++++--
> >   arch/powerpc/platforms/44x/machine_check.c |  4 ++--
> >   arch/powerpc/platforms/4xx/machine_check.c |  2 +-
> >   8 files changed, 29 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/a=
sm/ptrace.h
> > index 3e5d470a6155..c252d04b1206 100644
> > --- a/arch/powerpc/include/asm/ptrace.h
> > +++ b/arch/powerpc/include/asm/ptrace.h
> > @@ -44,7 +44,10 @@ struct pt_regs
> >   #endif
> >                       unsigned long trap;
> >                       unsigned long dar;
> > -                     unsigned long dsisr;
> > +                     union {
> > +                             unsigned long dsisr;
> > +                             unsigned long esr;
> > +                     };
> >                       unsigned long result;
> >               };
> >       };
> > diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/incl=
ude/uapi/asm/ptrace.h
> > index 7004cfea3f5f..e357288b5f34 100644
> > --- a/arch/powerpc/include/uapi/asm/ptrace.h
> > +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> > @@ -53,7 +53,10 @@ struct pt_regs
> >       /* N.B. for critical exceptions on 4xx, the dar and dsisr
> >          fields are overloaded to hold srr0 and srr1. */
> >       unsigned long dar;              /* Fault registers */
> > -     unsigned long dsisr;            /* on 4xx/Book-E used for ESR */
> > +     union {
> > +             unsigned long dsisr;            /* on Book-S used for DSI=
SR */
> > +             unsigned long esr;              /* on 4xx/Book-E used for=
 ESR */
> > +     };
> >       unsigned long result;           /* Result of a system call */
> >   };
> >
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proces=
s.c
> > index 185beb290580..f74af8f9133c 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1499,7 +1499,7 @@ static void __show_regs(struct pt_regs *regs)
> >           trap =3D=3D INTERRUPT_DATA_STORAGE ||
> >           trap =3D=3D INTERRUPT_ALIGNMENT) {
> >               if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> > -                     pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, reg=
s->dsisr);
> > +                     pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, reg=
s->esr);
> >               else
> >                       pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, re=
gs->dsisr);
> >       }
> > diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/=
ptrace/ptrace.c
> > index 0a0a33eb0d28..00789ad2c4a3 100644
> > --- a/arch/powerpc/kernel/ptrace/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> > @@ -375,6 +375,8 @@ void __init pt_regs_check(void)
> >                    offsetof(struct user_pt_regs, dar));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=3D
> >                    offsetof(struct user_pt_regs, dsisr));
> > +     BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=3D
> > +                  offsetof(struct user_pt_regs, esr));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, result) !=3D
> >                    offsetof(struct user_pt_regs, result));
> >
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index dfbce527c98e..2164f5705a0b 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -562,7 +562,7 @@ static inline int check_io_access(struct pt_regs *r=
egs)
> >   #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> >   /* On 4xx, the reason for the machine check or program exception
> >      is in the ESR. */
> > -#define get_reason(regs)     ((regs)->dsisr)
> > +#define get_reason(regs)     ((regs)->esr)
> >   #define REASON_FP           ESR_FP
> >   #define REASON_ILLEGAL              (ESR_PIL | ESR_PUO)
> >   #define REASON_PRIVILEGED   ESR_PPR
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index a8d0ce85d39a..62953d4e7c93 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -541,7 +541,11 @@ static __always_inline void __do_page_fault(struct=
 pt_regs *regs)
> >   {
> >       long err;
> >
> > -     err =3D ___do_page_fault(regs, regs->dar, regs->dsisr);
> > +     if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> > +             err =3D ___do_page_fault(regs, regs->dar, regs->esr);
> > +     else
> > +             err =3D ___do_page_fault(regs, regs->dar, regs->dsisr);
> > +
> >       if (unlikely(err))
> >               bad_page_fault(regs, err);
> >   }
> > @@ -567,7 +571,15 @@ NOKPROBE_SYMBOL(hash__do_page_fault);
> >    */
> >   static void __bad_page_fault(struct pt_regs *regs, int sig)
> >   {
> > -     int is_write =3D page_fault_is_write(regs->dsisr);
> > +     unsigned long err_reg;
> > +     int is_write;
> > +
> > +     if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> > +             err_reg =3D regs->esr;
> > +     else
> > +             err_reg =3D regs->dsisr;
> > +
> > +     is_write =3D page_fault_is_write(err_reg);
> >
> >       /* kernel has accessed a bad area */
> >
> > diff --git a/arch/powerpc/platforms/44x/machine_check.c b/arch/powerpc/=
platforms/44x/machine_check.c
> > index a5c898bb9bab..5d19daacd78a 100644
> > --- a/arch/powerpc/platforms/44x/machine_check.c
> > +++ b/arch/powerpc/platforms/44x/machine_check.c
> > @@ -11,7 +11,7 @@
> >
> >   int machine_check_440A(struct pt_regs *regs)
> >   {
> > -     unsigned long reason =3D regs->dsisr;
> > +     unsigned long reason =3D regs->esr;
> >
> >       printk("Machine check in kernel mode.\n");
> >       if (reason & ESR_IMCP){
> > @@ -48,7 +48,7 @@ int machine_check_440A(struct pt_regs *regs)
> >   #ifdef CONFIG_PPC_47x
> >   int machine_check_47x(struct pt_regs *regs)
> >   {
> > -     unsigned long reason =3D regs->dsisr;
> > +     unsigned long reason =3D regs->esr;
> >       u32 mcsr;
> >
> >       printk(KERN_ERR "Machine check in kernel mode.\n");
> > diff --git a/arch/powerpc/platforms/4xx/machine_check.c b/arch/powerpc/=
platforms/4xx/machine_check.c
> > index a71c29892a91..a905da1d6f41 100644
> > --- a/arch/powerpc/platforms/4xx/machine_check.c
> > +++ b/arch/powerpc/platforms/4xx/machine_check.c
> > @@ -10,7 +10,7 @@
> >
> >   int machine_check_4xx(struct pt_regs *regs)
> >   {
> > -     unsigned long reason =3D regs->dsisr;
> > +     unsigned long reason =3D regs->esr;
> >
> >       if (reason & ESR_IMCP) {
> >               printk("Instruction");
> >
