Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB63E5584
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhHJIeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhHJId6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:33:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC37C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:33:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t9so39875606lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p2Fr5BJzhcYbE5uoZF3uMydSpmFYCPWUAIM4ZDQIAO8=;
        b=ZX9kpQH2G3eesgI+qHAHL1ZSUCALh+QYm9VkNA2ZVb4n/vvxRRGVrH2bWa1vk9TrG4
         WxOt/pG3CQ1DojqpbuVR2VUvdEnpDh82SwV8LJ9fHWaqlMshBTghsuUy7R+K9Kq1I5EH
         eD5wvl1lFJ7sEiLKpGMZ84snliGClZ20x7TIZZvnTuJaGmti15gmHEEtLmmi9rpM/QYg
         mXzrXV1qeourKNTywlvA3jrQcO2M+coW+i0DxdbhOD676KkBDzhAk2zMfu5zHwUhRu/o
         Sp89C5VSXEQPSyKKGrBmI9gRUzAObj3Y29jcYXn/Cn617MSfFtEqsBJ7EoU54HxTwYBa
         d69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p2Fr5BJzhcYbE5uoZF3uMydSpmFYCPWUAIM4ZDQIAO8=;
        b=KCJ1jbQ5UJfN2lgwNNNvvXoT8QyF0fq/EKIEpfbgmjYOMWZt4dpKjHRgygzRqSkUT7
         a+IWeEV2XUPCbpQmx8lUmFokGnOrPXEKa1YKwgKxBmlV4cpSLPR/zBmOwcA9DRLLkPL6
         Rg+xK1XN6tOS3h93viU0j9JQqoOj6XILbhchTbLs06On8XeUcEHorAqNF+4yEJ3TEMLC
         GtZZPusyZt8o56i5kzw4a3/49m6fw8cqyynBMGWZbswVS+r+eTdK8yFV2aIpz5cbaeO4
         algacHCsMRNup4zjmYMlT8dzdB7P9wO90AWELSXclAZoABuLwXQNsFj8cBylTsM414BJ
         QosQ==
X-Gm-Message-State: AOAM530q1clS7xxcp6U5HvB3Jl79TxEWKnJzcMhrbJiVYtdP6uEbchSz
        VdZuDSNAba9E1o5LkNOsjZzyQw0+CrLj+v3kSGw=
X-Google-Smtp-Source: ABdhPJyrI9dStbUFIFtHPxBjTNID3TeK9D5oT0XbVpIxhRowhuOAkAEEEqiEYMCwd5D31/PuAwcBbvCpSVEWo7Kufs4=
X-Received: by 2002:a05:6512:53c:: with SMTP id o28mr21246802lfc.641.1628584414971;
 Tue, 10 Aug 2021 01:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210807010239.416055-1-sxwjean@me.com> <20210807010239.416055-2-sxwjean@me.com>
 <127de0c7-5e30-6797-1e72-6414d4a60119@csgroup.eu>
In-Reply-To: <127de0c7-5e30-6797-1e72-6414d4a60119@csgroup.eu>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 10 Aug 2021 16:33:08 +0800
Message-ID: <CAEVVKH_G1GjofNU4M0mtuaOAtLyTZ+Fcjjr3ywqeXJrJVwpgrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] powerpc: Optimize register usage for esr register
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Xiongwei Song <sxwjean@me.com>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>, oleg@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        efremov@linux.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 7, 2021 at 2:57 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 07/08/2021 =C3=A0 03:02, sxwjean@me.com a =C3=A9crit :
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > Create an anonymous union for dsisr and esr regsiters, we can reference
> > esr to get the exception detail when CONFIG_4xx=3Dy or CONFIG_BOOKE=3Dy=
.
> > Otherwise, reference dsisr. This makes code more clear.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >   arch/powerpc/include/asm/ptrace.h          | 5 ++++-
> >   arch/powerpc/kernel/process.c              | 2 +-
> >   arch/powerpc/kernel/ptrace/ptrace.c        | 2 ++
> >   arch/powerpc/kernel/traps.c                | 2 +-
> >   arch/powerpc/platforms/44x/machine_check.c | 4 ++--
> >   arch/powerpc/platforms/4xx/machine_check.c | 2 +-
> >   6 files changed, 11 insertions(+), 6 deletions(-)
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
> > index 0a0a33eb0d28..a222fd4d6334 100644
> > --- a/arch/powerpc/kernel/ptrace/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> > @@ -375,6 +375,8 @@ void __init pt_regs_check(void)
> >                    offsetof(struct user_pt_regs, dar));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=3D
> >                    offsetof(struct user_pt_regs, dsisr));
> > +     BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=3D
> > +                  offsetof(struct user_pt_regs, dsisr));
>
> esr and dsisr are the same, so checking the same thing a second time is p=
ointless.

Hmm...it's better to check if the changes on pt_regs structure is
expected I think.

Regards,
Xiongwei

>
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
