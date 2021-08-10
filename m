Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ECA3E5587
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhHJIef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhHJIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:34:34 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81AEC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:34:12 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x8so39944186lfe.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a6dGXjWO0NCC+0cj+bZFV+qIFXfEn1q96bp9PHM8gws=;
        b=Vxow0MH4iTUSKGYSfuLuIum/eTzzBI1YAPCzCfZXxGQz2BfVWTfRfbtBdl5j2FjJqX
         6qgD7BdR3wVR8R/uX/z0U7o9vI0u/Q6H/rBslZGQvz2Lm1pJXS4Ti70DucY+udnR48an
         Rl3/zOInosa4ev0POv5PVAA9rn6mQ+VHjFo51QlbE0aDlToVfvMIKgF2tbW+uneZWrxD
         3bGoTtwN/9cUzDDVeP2MgTLtH2LdvjJHtkDrgNnwUcWEBy9QEtIdCoOY2yzfUqkVk68z
         QKsYGmB9FxXsC3aeT31KhRpw7JvP/kNdlzPhb8L9/zor3BMwIq+ZVnTD992Xwlu69yx8
         g/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a6dGXjWO0NCC+0cj+bZFV+qIFXfEn1q96bp9PHM8gws=;
        b=h8NzP95PQ/tb9g9q8M714vG8xPrOmjchPbSoZ0ZM43Valz5RK/Z5iRKVB23Erq/Ap/
         m9cRcqtshlUb3eqXSpWHgiAqAVov+8ZaSWHx/t/id3tm71eS7hYKne01yFf/23LuobeA
         o3SIl308bdMeON2wp+ID0D1XBp+9HsXHe/ntugUqYd64SPuzBF+iWshI+PBwJePham2G
         Fn2+nVVdZic6MbE8xGE32Kz6nj/N4uLvIv2kvUOJKg+OtiyJZykHRPL9znH8yhNpWlFU
         2/5hxL/0dctTCl2y5hxXKRe8bJ2jiKJgDSv/+dMf5+Uqs+Sc5C8S6sQo9p2BQAqbESRH
         NBTQ==
X-Gm-Message-State: AOAM532m5ulpaWCW3mqoG/fNiBi/JGXQkkOBvYyFm8U6zRApa3PtpCIu
        A7DCuyZnti/O/rd0xTmKLU4lByESqTkWP5KRCX0=
X-Google-Smtp-Source: ABdhPJxlem10rUrgwQzm2KR3+POEFuLuoRZoBA7fkmY5PZ8qejYLtr7C/lo8nKg8cuZJ7R0kzYMu6r0f4ANGgsm9PVo=
X-Received: by 2002:ac2:4ed3:: with SMTP id p19mr20580652lfr.307.1628584450567;
 Tue, 10 Aug 2021 01:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210807010239.416055-1-sxwjean@me.com> <20210807010239.416055-4-sxwjean@me.com>
 <dfd24c4a-c43f-912c-5876-f1cac704f336@csgroup.eu>
In-Reply-To: <dfd24c4a-c43f-912c-5876-f1cac704f336@csgroup.eu>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 10 Aug 2021 16:33:44 +0800
Message-ID: <CAEVVKH972N2hT-WP=5p6GrYEdEV1DO=D0PJo24WZ9gMVgqzaWA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] powerpc: Optimize register usage for dear register
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

On Sat, Aug 7, 2021 at 2:58 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 07/08/2021 =C3=A0 03:02, sxwjean@me.com a =C3=A9crit :
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > Create an anonymous union for dar and dear regsiters, we can reference
> > dear to get the effective address when CONFIG_4xx=3Dy or CONFIG_BOOKE=
=3Dy.
> > Otherwise, reference dar. This makes code more clear.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >   arch/powerpc/include/asm/ptrace.h   | 5 ++++-
> >   arch/powerpc/kernel/process.c       | 2 +-
> >   arch/powerpc/kernel/ptrace/ptrace.c | 2 ++
> >   3 files changed, 7 insertions(+), 2 deletions(-)
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
> > index a222fd4d6334..7c7093c17c45 100644
> > --- a/arch/powerpc/kernel/ptrace/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> > @@ -373,6 +373,8 @@ void __init pt_regs_check(void)
> >                    offsetof(struct user_pt_regs, trap));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, dar) !=3D
> >                    offsetof(struct user_pt_regs, dar));
> > +     BUILD_BUG_ON(offsetof(struct pt_regs, dear) !=3D
> > +                  offsetof(struct user_pt_regs, dar));
>
> dar and dear are the same, so checking the same thing a second time is po=
intless.

Same reply as the patch 1.

Regards,
Xiongwei

>
> >       BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=3D
> >                    offsetof(struct user_pt_regs, dsisr));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=3D
> >
