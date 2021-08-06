Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D6A3E221D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 05:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbhHFDRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 23:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhHFDRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 23:17:37 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164CFC061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 20:17:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u13so9927150lje.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zj33fEFxiHh9L7Od2CChfLnX3PMn/v2vhh53C69leEc=;
        b=WhJOF6lEfMQ7PQ2Dm44rut4BwLCIYnh9rETAXNH5YTGCKRwlkP1XvNoa92JL0ffDms
         NiEFnBw+QmXNL8dXPXTHqiBQcfHOrsE966ffYqT5ty1kGZfzAQV4Al6p0trJzTT+kdgK
         vy4Gk11erETBeoWtOJt4AebhLFddQQiA6tSlEuRNmYfcLawEaT1izurTpwCqy/SLwVmL
         TDamTFmrotMv/2tjzYLxYi3VXu9Jz/YLxhqzObYt+JYVI+7ku7748W8nmQwrWtBgxvI4
         L28kwCjCaRgI/2Jn3wPpaBYWcxjepmUawi3xLktc/5CbJqH6EWMxmiCh3P7lixxjvB5C
         iZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zj33fEFxiHh9L7Od2CChfLnX3PMn/v2vhh53C69leEc=;
        b=SxTw0EuX3IeWTjOAw+hx4BHBbmLHD4VeVYVB9zEhsoBawpWtPGFbVsYYBxTM9NXXec
         M+YTwl/lIuosQ9dShOPRIEyypFDYWZPPinyTFDabk2qM/NAjH47NrniLfhwQ1GEeyUqt
         /Cxn+JqqH4wWQ2ZYUVHJ0lnt0lF2yB+fIhvlL/u+JRpnZqXUkQBthQCX8Z0sknjEejJ3
         CR96Ls6T8KeQOwEHawqYOx5S1gcRI2E1nLT51hxBamqtv+WBnJRqwqCruEsl8fbmZ1jz
         NisZnR5LYedWVi0qsSXXkptsRyPZr1/L6622j6+dIBDTsOWRP3e9haDSkWGZIPVOa+ay
         qZbw==
X-Gm-Message-State: AOAM53272l6+byCXMQffxEft/9ty17C2teA64lJ/ip84UPjeha0JUi9w
        HKPLkOed1gc4nakyAbFXo/4wfRujEHC4e1W+tDE=
X-Google-Smtp-Source: ABdhPJyuuwxWUKFdUjxHxsIpU5QiCpC61h0PQQO10OgYsJ21Jq7XYltBMp1TAtD21Z5CMnGJqfLkXM41gflbVGwHShg=
X-Received: by 2002:a2e:3312:: with SMTP id d18mr5169021ljc.297.1628219839913;
 Thu, 05 Aug 2021 20:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210726143053.532839-1-sxwjean@me.com> <20210726143053.532839-3-sxwjean@me.com>
 <56d9e3ce-f303-fd41-bd16-5655d9dc5e52@csgroup.eu>
In-Reply-To: <56d9e3ce-f303-fd41-bd16-5655d9dc5e52@csgroup.eu>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 6 Aug 2021 11:16:53 +0800
Message-ID: <CAEVVKH95gAp-j1JM4TSSGPS1x_B2T7f9DQyryzzvZMcsKCgxWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] powerpc: Optimize register usage for dear register
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

On Thu, Aug 5, 2021 at 6:09 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 26/07/2021 =C3=A0 16:30, sxwjean@me.com a =C3=A9crit :
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > Create an anonymous union for dar and dear regsiters, we can reference
> > dear to get the effective address when CONFIG_4xx=3Dy or CONFIG_BOOKE=
=3Dy.
> > Otherwise, reference dar. This makes code more clear.
>
> Same comment here as for patch 1.

Same reply for the patch 1.
Thank you.

>
>
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >   arch/powerpc/include/asm/ptrace.h      | 5 ++++-
> >   arch/powerpc/include/uapi/asm/ptrace.h | 5 ++++-
> >   arch/powerpc/kernel/process.c          | 2 +-
> >   arch/powerpc/kernel/ptrace/ptrace.c    | 2 ++
> >   arch/powerpc/kernel/traps.c            | 5 ++++-
> >   arch/powerpc/mm/fault.c                | 2 +-
> >   6 files changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/a=
sm/ptrace.h
> > index c252d04b1206..fa725e3238c2 100644
> > --- a/arch/powerpc/include/asm/ptrace.h
> > +++ b/arch/powerpc/include/asm/ptrace.h
> > @@ -43,7 +43,10 @@ struct pt_regs
> >                       unsigned long mq;
> >   #endif
> >                       unsigned long trap;
> > -                     unsigned long dar;
> > +                     union {
> > +                             unsigned long dar;
> > +                             unsigned long dear;
> > +                     };
> >                       union {
> >                               unsigned long dsisr;
> >                               unsigned long esr;
> > diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/incl=
ude/uapi/asm/ptrace.h
> > index e357288b5f34..9ae150fb4c4b 100644
> > --- a/arch/powerpc/include/uapi/asm/ptrace.h
> > +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> > @@ -52,7 +52,10 @@ struct pt_regs
> >       unsigned long trap;             /* Reason for being here */
> >       /* N.B. for critical exceptions on 4xx, the dar and dsisr
> >          fields are overloaded to hold srr0 and srr1. */
> > -     unsigned long dar;              /* Fault registers */
> > +     union {
> > +             unsigned long dar;              /* Fault registers */
> > +             unsigned long dear;
> > +     };
> >       union {
> >               unsigned long dsisr;            /* on Book-S used for DSI=
SR */
> >               unsigned long esr;              /* on 4xx/Book-E used for=
 ESR */
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proces=
s.c
> > index f74af8f9133c..50436b52c213 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1499,7 +1499,7 @@ static void __show_regs(struct pt_regs *regs)
> >           trap =3D=3D INTERRUPT_DATA_STORAGE ||
> >           trap =3D=3D INTERRUPT_ALIGNMENT) {
> >               if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> > -                     pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, reg=
s->esr);
> > +                     pr_cont("DEAR: "REG" ESR: "REG" ", regs->dear, re=
gs->esr);
> >               else
> >                       pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, re=
gs->dsisr);
> >       }
> > diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/=
ptrace/ptrace.c
> > index 00789ad2c4a3..969dca8b0718 100644
> > --- a/arch/powerpc/kernel/ptrace/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> > @@ -373,6 +373,8 @@ void __init pt_regs_check(void)
> >                    offsetof(struct user_pt_regs, trap));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, dar) !=3D
> >                    offsetof(struct user_pt_regs, dar));
> > +     BUILD_BUG_ON(offsetof(struct pt_regs, dear) !=3D
> > +                  offsetof(struct user_pt_regs, dear));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=3D
> >                    offsetof(struct user_pt_regs, dsisr));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=3D
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index 2164f5705a0b..0796630d3d23 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -1609,7 +1609,10 @@ DEFINE_INTERRUPT_HANDLER(alignment_exception)
> >       }
> >   bad:
> >       if (user_mode(regs))
> > -             _exception(sig, regs, code, regs->dar);
> > +             if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> > +                     _exception(sig, regs, code, regs->dear);
> > +             else
> > +                     _exception(sig, regs, code, regs->dar);
> >       else
> >               bad_page_fault(regs, sig);
> >   }
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index 62953d4e7c93..3db6b39a1178 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -542,7 +542,7 @@ static __always_inline void __do_page_fault(struct =
pt_regs *regs)
> >       long err;
> >
> >       if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> > -             err =3D ___do_page_fault(regs, regs->dar, regs->esr);
> > +             err =3D ___do_page_fault(regs, regs->dear, regs->esr);
> >       else
> >               err =3D ___do_page_fault(regs, regs->dar, regs->dsisr);
> >
> >
