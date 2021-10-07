Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F094250C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbhJGKMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhJGKMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:12:31 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2F0C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 03:10:38 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 188so6256620vsv.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=js7t4f/Un1aZrklhhxsPwPoOvuoD5ePJcMwFCy9F83A=;
        b=QP/cH3ptlDrSIzdrqZ8frPtD6DUxw7iLzAlBAJEiGnsbykzri8O2xvXE+U2KzR4ctt
         TF1Ix0Gfkp7sTxNbidq1dqdmaflk4ppGqzpZcoLUydfzY6McHlhYRdYzIKczsbHmYMWi
         5JIJyWrmk1RxYISLq8WCTZ6FmddFHX0kcYEy7/E6KjJj4Mb+ITemtB4OYono5yR7BngA
         Jfprkhfx7HyknAyAOxG7Sqwtry8twINEotjrZZNjGrPsy59J002B89nTAgNbV7Qpz7+u
         CvH54xQ8HeAezF3nWJghyaVZgDdcdIGWziN+E/oEoj2a0rdwkTJAdYyMEnOROl9U37Tl
         4MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=js7t4f/Un1aZrklhhxsPwPoOvuoD5ePJcMwFCy9F83A=;
        b=RPn3Qp2188TxtxKk0SGSZJ6wAcEuS5DsynQyTgRWbvkfqw7ycVaXIrJ3319ndntc6t
         Z+foDzxluYtZec3NtR9hhCcRADQDBc0jyQJYh7YJ4i+IA4Yk9pgRMU5qPCK+8BMkNdeO
         e4ec3GGEqVxKw+zVtWCw8xrn1Q+MlUpZFdZ1zgFKpLzLj31/Zr6U86xvY0ArMjvbzCVM
         sUah1qiMGeyH2GN6MnUl66g1ObnyMdd7zKri56QxJfl/oEdBy8U5h1boGKuqjRQ6sW32
         qs/zKcnWGR//NpYyJCBddg+WGfbrIAdF2GrkxlE8bPJApPiOvbnnUpvoW7CF8RCzLPcw
         Sa/Q==
X-Gm-Message-State: AOAM530+/1A0eRBm0ual+xbIY23vZ3TcztuEi2Q7aDCz9d+IwBI8myCT
        cGhCRjE05ZVeokszishtmOSXtMQtHMfknDI1+qiPjf19DMc=
X-Google-Smtp-Source: ABdhPJyYp4jLOtP0hMx8oY1LVe4far3P1HC8FvFEdwnGYegDNE7nDqnnGFwlE1UwTxNb8i2F2MR4tnmOHVe6xq4qoIk=
X-Received: by 2002:a05:6102:c53:: with SMTP id y19mr2820065vss.55.1633601437585;
 Thu, 07 Oct 2021 03:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
 <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com> <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com> <CAFiDJ5_eoUNjQbCcwgHtXHfykeD7MiSw3xJzx83+bXOFHv-dQQ@mail.gmail.com>
 <CAHCEeh+yXwAyc=G+JEfNx5tk6XXuVgZSF74yuEanBiz7JCiApQ@mail.gmail.com>
 <CAFiDJ5-=Om5rBQ9xWUC_ShdauHkeXbNMFJhE0K37nwsydppzHQ@mail.gmail.com> <CAHCEehLooHmL9Zhg4Bsr2Ea7wvMZkLzMv9093p9KvYJv6H4DAw@mail.gmail.com>
In-Reply-To: <CAHCEehLooHmL9Zhg4Bsr2Ea7wvMZkLzMv9093p9KvYJv6H4DAw@mail.gmail.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Thu, 7 Oct 2021 18:10:26 +0800
Message-ID: <CAFiDJ5-GwxCOOW4O6NL=8UCubt0j6NzxaBT7Cm5yBmcFA_RmyA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Darius Rad <darius@bluespec.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 11:47 PM Greentime Hu <greentime.hu@sifive.com> wrot=
e:
>
> Ley Foon Tan <lftan.linux@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:12=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > On Mon, Oct 4, 2021 at 8:41 PM Greentime Hu <greentime.hu@sifive.com> w=
rote:
> > >
> > > Ley Foon Tan <lftan.linux@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=
=881=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:46=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > >
> > > > On Wed, Sep 29, 2021 at 11:54 PM Darius Rad <darius@bluespec.com> w=
rote:
> > > > >
> > > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=
=8813=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > [....]
> >
> >
> > > > > > >
> > > > > > > So this will unconditionally enable vector instructions, and =
allocate
> > > > > > > memory for vector state, for all processes, regardless of whe=
ther vector
> > > > > > > instructions are used?
> > > > > > >
> > > > > >
> > > > > > Hi Darius,
> > > > > >
> > > > > > Yes, it will enable vector if has_vector() is true. The reason =
that we
> > > > > > choose to enable and allocate memory for user space program is =
because
> > > > > > we also implement some common functions in the glibc such as me=
mcpy
> > > > > > vector version and it is called very often by every process. So=
 that
> > > > > > we assume if the user program is running in a CPU with vector I=
SA
> > > > > > would like to use vector by default. If we disable it by defaul=
t and
> > > > > > make it trigger the illegal instruction, that might be a burden=
 since
> > > > > > almost every process will use vector glibc memcpy or something =
like
> > > > > > that.
> > > > >
> > > > > Do you have any evidence to support the assertion that almost eve=
ry process
> > > > > would use vector operations?  One could easily argue that the con=
verse is
> > > > > true: no existing software uses the vector extension now, so most=
 likely a
> > > > > process will not be using it.
> > > > >
> > > > > >
> > > > > > > Given the size of the vector state and potential power and pe=
rformance
> > > > > > > implications of enabling the vector engine, it seems like thi=
s should
> > > > > > > treated similarly to Intel AMX on x86.  The full discussion o=
f that is
> > > > > > > here:
> > > > > > >
> > > > > > > https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5=
_WRXtDSAGcbG8N+gtdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
> > > > > > >
> > > > > > > The cover letter for recent Intel AMX patches has a summary o=
f the x86
> > > > > > > implementation:
> > > > > > >
> > > > > > > https://lore.kernel.org/lkml/20210825155413.19673-1-chang.seo=
k.bae@intel.com/
> > > > > > >
> > > > > > > If RISC-V were to adopt a similar approach, I think the signi=
ficant
> > > > > > > points are:
> > > > > > >
> > > > > > >   1. A process (or thread) must specifically request the desi=
re to use
> > > > > > > vector extensions (perhaps with some new arch_prctl() API),
> > > > > > >
> > > > > > >   2. The kernel is free to deny permission, perhaps based on
> > > > > > > administrative rules or for other reasons, and
> > > > > > >
> > > > > > >   3. If a process attempts to use vector extensions before do=
ing the
> > > > > > > above, the process will die due to an illegal instruction.
> > > > > >
> > > > > > Thank you for sharing this, but I am not sure if we should trea=
t
> > > > > > vector like AMX on x86. IMHO, compiler might generate code with=
 vector
> > > > > > instructions automatically someday, maybe we should treat vecto=
r
> > > > > > extensions like other extensions.
> > > > > > If user knows the vector extension is supported in this CPU and=
 he
> > > > > > would like to use it, it seems we should let user use it direct=
ly just
> > > > > > like other extensions.
> > > > > > If user don't know it exists or not, user should use the librar=
y API
> > > > > > transparently and let glibc or other library deal with it. The =
glibc
> > > > > > ifunc feature or multi-lib should be able to choose the correct
> > > > > > implementation.
> > > > >
> > > > > What makes me think that the vector extension should be treated l=
ike AMX is
> > > > > that they both (1) have a significant amount of architectural sta=
te, and
> > > > > (2) likely have a significant power and/or area impact on (non-em=
ulated)
> > > > > designs.
> > > > >
> > > > > For example, I think it is possible, maybe even likely, that vect=
or
> > > > > implementations will have one or more of the following behaviors:
> > > > >
> > > > >   1. A single vector unit shared among two or more harts,
> > > > >
> > > > >   2. Additional power consumption when the vector unit is enabled=
 and idle
> > > > > versus not being enabled at all,
> > > > >
> > > > >   3. For a system which supports variable operating frequency, a =
reduction
> > > > > in the maximum frequency when the vector unit is enabled, and/or
> > > > >
> > > > >   4. The inability to enter low power states and/or delays to low=
 power
> > > > > states transitions when the vector unit is enabled.
> > > > >
> > > > > None of the above constraints apply to more ordinary extensions l=
ike
> > > > > compressed or the various bit manipulation extensions.
> > > > >
> > > > > The discussion I linked to has some well reasoned arguments on wh=
y
> > > > > substantial extensions should have a mechanism to request using t=
hem by
> > > > > user space.  The discussion was in the context of Intel AMX, but =
applies to
> > > > > further x86 extensions, and I think should also apply to similar =
extensions
> > > > > on RISC-V, like vector here.
> > > > >
> > > > There is possible use case where not all cores support vector
> > > > extension due to size, area and power.
> > > > Perhaps can have the mechanism or flow to determine the
> > > > application/thread require vector extension or it specifically requ=
est
> > > > the desire to use
> > > > vector extensions. Then this app/thread run on cpu with vector
> > > > extension capability only.
> > > >
> > >
> > > IIRC, we assume all harts has the same ability in Linux because of SM=
P
> > > assumption.
> > > If we have more information of hw capability and we may use this
> > > information for scheduler to switch the correct process to the correc=
t
> > > CPU.
> > > Do you have any idea how to implement it in Linux kernel? Maybe we ca=
n
> > > list in the TODO list.
> > I think we can refer to other arch implementations as reference:
> >
> > 1. ARM64 supports 32-bit thread on asymmetric AArch32 systems. There
> > is a flag in ELF to check, then start the thread on the core that
> > supports 32-bit execution. This patchset is merged to mainline 5.15.
> > https://lore.kernel.org/linux-arm-kernel/20210730112443.23245-8-will@ke=
rnel.org/T/
>
> Wow! This is useful for AMP.
>
> >
> > 2. Link shared by Darius, on-demand request implementation on Intel AMX
> > https://lore.kernel.org/lkml/20210825155413.19673-1-chang.seok.bae@inte=
l.com/
> >
> > glibc support optimized library functions with vector, this is enabled
> > by default if compiler is with vector extension enabled? If yes, then
> > most of the app required vector core.
>
> As I mentioned earlier, glibc ifunc will solve this issue. The
> Linux/glibc can run on platform with vector or without vector and
> glibc will use the information get from Linux kernel and using ifunc
> to decide whether it should use the vector version or not.
> Which means even your toolchain has vector glibc support and your
> Linux kernel told the glibc this platform doesn't support vector then
> the ifunc mechanism will choose the non-vector version ones.
Okay. Then Linux kernel needs to report vector capability as per core
feature, if not all SMP cores support vector.
