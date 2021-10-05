Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F3F422CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhJEPtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhJEPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:49:08 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FCDC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:47:17 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id a9so12326851qvf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vfa0EbbE2laUFMxdghsJxYa09TklBLgSPleTjeSdegg=;
        b=cmWdAMXNDayRfgTc2d6YL+ORVqe0v6KFUhuypzwotH4zfOKyyzHpwMq15/O3V5EtPJ
         P8zOcKZBaMpaRg1YQ8MKCT5dJjzPOXmBoxBFFDpCyDc9sjfli9koIuWczcmP/JGI1eLV
         V708g+hAiEVi6Wdlne+hyuh/Mcncm1Or/tC3lfOl+9GiYKBkvy0fdcYwfhMeq7X/AMxG
         eNGShxsIhOXeBYh3zSanWpbqa+ryBOHcDaLzzaJ9HOXVdL/in62kJh/9mBYHYSJW6wLR
         qm9Z4xqnhU/1iIQQJEkePIifK2g+YEx9uxZeqBwkMPkyXGqxRj4bmHXYmIRDMhc5V0Dg
         oHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vfa0EbbE2laUFMxdghsJxYa09TklBLgSPleTjeSdegg=;
        b=qk31dr56f6EVIMg5KeMqgeV8HnMItWLXgdujv29sqnyFUnr4SAX1AnJ2gwxujzOFLq
         CLoAOrgf+ojwySsHmfnPXfyNzlJyBEIZTxuCOzr1/rbp6XQVmCTotR/lJy27u08psOrF
         V8F6wNYz4iQ9zpBe1HcDPjbMcO/GM4Awq/TnGnp2R3zkRDmu9abhiiMq5aNeOQGkGdrE
         x0A5o9EQiGoc0jKpMVc09N//ZDlAgn1i9ZX2vPBhZbjJFA/6gFemd3UmQGqH+i6HXvBh
         on0o6+iCMbHmzkQCiEP4CDV9I4ncRZvOopB2UgmNHVkFGfUVx8KzFClDomTVCXI2esn0
         ZofA==
X-Gm-Message-State: AOAM530f1KpLJo1zTYzcwkoUAELMKk+/mghNQqIA+EyplW07r4I8O4Vc
        zwQUljqarDODz3wL7HCwtCnnKXGiitt24/ipi2BkCQ==
X-Google-Smtp-Source: ABdhPJxNhw2GHpsnvzhqFGG6u2k1kaMa1/iBOBsOcDSnBVsnwdE+RET4L40JzBOMupE+3ocSakGaxVy6wQXOYDnpIN0=
X-Received: by 2002:a0c:8e45:: with SMTP id w5mr27927140qvb.17.1633448836496;
 Tue, 05 Oct 2021 08:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
 <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com> <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com> <CAFiDJ5_eoUNjQbCcwgHtXHfykeD7MiSw3xJzx83+bXOFHv-dQQ@mail.gmail.com>
 <CAHCEeh+yXwAyc=G+JEfNx5tk6XXuVgZSF74yuEanBiz7JCiApQ@mail.gmail.com> <CAFiDJ5-=Om5rBQ9xWUC_ShdauHkeXbNMFJhE0K37nwsydppzHQ@mail.gmail.com>
In-Reply-To: <CAFiDJ5-=Om5rBQ9xWUC_ShdauHkeXbNMFJhE0K37nwsydppzHQ@mail.gmail.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 5 Oct 2021 23:46:00 +0800
Message-ID: <CAHCEehLooHmL9Zhg4Bsr2Ea7wvMZkLzMv9093p9KvYJv6H4DAw@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
To:     Ley Foon Tan <lftan.linux@gmail.com>
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

Ley Foon Tan <lftan.linux@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Mon, Oct 4, 2021 at 8:41 PM Greentime Hu <greentime.hu@sifive.com> wro=
te:
> >
> > Ley Foon Tan <lftan.linux@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=88=
1=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:46=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > On Wed, Sep 29, 2021 at 11:54 PM Darius Rad <darius@bluespec.com> wro=
te:
> > > >
> > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=
=8813=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > >
> [....]
>
>
> > > > > >
> > > > > > So this will unconditionally enable vector instructions, and al=
locate
> > > > > > memory for vector state, for all processes, regardless of wheth=
er vector
> > > > > > instructions are used?
> > > > > >
> > > > >
> > > > > Hi Darius,
> > > > >
> > > > > Yes, it will enable vector if has_vector() is true. The reason th=
at we
> > > > > choose to enable and allocate memory for user space program is be=
cause
> > > > > we also implement some common functions in the glibc such as memc=
py
> > > > > vector version and it is called very often by every process. So t=
hat
> > > > > we assume if the user program is running in a CPU with vector ISA
> > > > > would like to use vector by default. If we disable it by default =
and
> > > > > make it trigger the illegal instruction, that might be a burden s=
ince
> > > > > almost every process will use vector glibc memcpy or something li=
ke
> > > > > that.
> > > >
> > > > Do you have any evidence to support the assertion that almost every=
 process
> > > > would use vector operations?  One could easily argue that the conve=
rse is
> > > > true: no existing software uses the vector extension now, so most l=
ikely a
> > > > process will not be using it.
> > > >
> > > > >
> > > > > > Given the size of the vector state and potential power and perf=
ormance
> > > > > > implications of enabling the vector engine, it seems like this =
should
> > > > > > treated similarly to Intel AMX on x86.  The full discussion of =
that is
> > > > > > here:
> > > > > >
> > > > > > https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_W=
RXtDSAGcbG8N+gtdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
> > > > > >
> > > > > > The cover letter for recent Intel AMX patches has a summary of =
the x86
> > > > > > implementation:
> > > > > >
> > > > > > https://lore.kernel.org/lkml/20210825155413.19673-1-chang.seok.=
bae@intel.com/
> > > > > >
> > > > > > If RISC-V were to adopt a similar approach, I think the signifi=
cant
> > > > > > points are:
> > > > > >
> > > > > >   1. A process (or thread) must specifically request the desire=
 to use
> > > > > > vector extensions (perhaps with some new arch_prctl() API),
> > > > > >
> > > > > >   2. The kernel is free to deny permission, perhaps based on
> > > > > > administrative rules or for other reasons, and
> > > > > >
> > > > > >   3. If a process attempts to use vector extensions before doin=
g the
> > > > > > above, the process will die due to an illegal instruction.
> > > > >
> > > > > Thank you for sharing this, but I am not sure if we should treat
> > > > > vector like AMX on x86. IMHO, compiler might generate code with v=
ector
> > > > > instructions automatically someday, maybe we should treat vector
> > > > > extensions like other extensions.
> > > > > If user knows the vector extension is supported in this CPU and h=
e
> > > > > would like to use it, it seems we should let user use it directly=
 just
> > > > > like other extensions.
> > > > > If user don't know it exists or not, user should use the library =
API
> > > > > transparently and let glibc or other library deal with it. The gl=
ibc
> > > > > ifunc feature or multi-lib should be able to choose the correct
> > > > > implementation.
> > > >
> > > > What makes me think that the vector extension should be treated lik=
e AMX is
> > > > that they both (1) have a significant amount of architectural state=
, and
> > > > (2) likely have a significant power and/or area impact on (non-emul=
ated)
> > > > designs.
> > > >
> > > > For example, I think it is possible, maybe even likely, that vector
> > > > implementations will have one or more of the following behaviors:
> > > >
> > > >   1. A single vector unit shared among two or more harts,
> > > >
> > > >   2. Additional power consumption when the vector unit is enabled a=
nd idle
> > > > versus not being enabled at all,
> > > >
> > > >   3. For a system which supports variable operating frequency, a re=
duction
> > > > in the maximum frequency when the vector unit is enabled, and/or
> > > >
> > > >   4. The inability to enter low power states and/or delays to low p=
ower
> > > > states transitions when the vector unit is enabled.
> > > >
> > > > None of the above constraints apply to more ordinary extensions lik=
e
> > > > compressed or the various bit manipulation extensions.
> > > >
> > > > The discussion I linked to has some well reasoned arguments on why
> > > > substantial extensions should have a mechanism to request using the=
m by
> > > > user space.  The discussion was in the context of Intel AMX, but ap=
plies to
> > > > further x86 extensions, and I think should also apply to similar ex=
tensions
> > > > on RISC-V, like vector here.
> > > >
> > > There is possible use case where not all cores support vector
> > > extension due to size, area and power.
> > > Perhaps can have the mechanism or flow to determine the
> > > application/thread require vector extension or it specifically reques=
t
> > > the desire to use
> > > vector extensions. Then this app/thread run on cpu with vector
> > > extension capability only.
> > >
> >
> > IIRC, we assume all harts has the same ability in Linux because of SMP
> > assumption.
> > If we have more information of hw capability and we may use this
> > information for scheduler to switch the correct process to the correct
> > CPU.
> > Do you have any idea how to implement it in Linux kernel? Maybe we can
> > list in the TODO list.
> I think we can refer to other arch implementations as reference:
>
> 1. ARM64 supports 32-bit thread on asymmetric AArch32 systems. There
> is a flag in ELF to check, then start the thread on the core that
> supports 32-bit execution. This patchset is merged to mainline 5.15.
> https://lore.kernel.org/linux-arm-kernel/20210730112443.23245-8-will@kern=
el.org/T/

Wow! This is useful for AMP.

>
> 2. Link shared by Darius, on-demand request implementation on Intel AMX
> https://lore.kernel.org/lkml/20210825155413.19673-1-chang.seok.bae@intel.=
com/
>
> glibc support optimized library functions with vector, this is enabled
> by default if compiler is with vector extension enabled? If yes, then
> most of the app required vector core.

As I mentioned earlier, glibc ifunc will solve this issue. The
Linux/glibc can run on platform with vector or without vector and
glibc will use the information get from Linux kernel and using ifunc
to decide whether it should use the vector version or not.
Which means even your toolchain has vector glibc support and your
Linux kernel told the glibc this platform doesn't support vector then
the ifunc mechanism will choose the non-vector version ones.
