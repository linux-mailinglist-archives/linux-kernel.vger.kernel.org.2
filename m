Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0FC421C75
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhJECO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhJECO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:14:26 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149BEC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 19:12:37 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id z202so8616915vkd.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AZ805/C+DO95puS3gpWQrJg7B10IPlw3kxeZGNcrz50=;
        b=SfJLrLrmF0Cu9+p9OEXXWVkAI5yhwNIDZ9kYGBJxB9ZfFM4UBUq9lT/jOjzbF7D9dI
         mr3uvs/nRrajGJ1en4K9XVpi8lzUaQKa4cQT7STAJVrxMCVb7mVnGrPrTcmcGk9EFK7p
         R0avwu9M468OzrQa3+r/q9cOND66estY15Ei8NKYyLWpb/1aTCGMwaZePcKVYG01FV8N
         bAymkiNSas8oBCGZ7y8d8pBxh9HvjUlX798D+EF/+w0ijDKXGV6vx8o1yGtL9I2OcHNb
         2ro5DlIXc7zS8HwZbL1zQJWnc3qhrmu64D3isH2ZHf6Kv4aHiP46KVA9S/ebbz5znLf1
         REDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AZ805/C+DO95puS3gpWQrJg7B10IPlw3kxeZGNcrz50=;
        b=uebp7KPCcXz3sq8OMKyOU53XVyRHsQ22ZHCfAJ80kZRMBSVMmzEf5PEkQWQon0e2EI
         VCb7mrVX1AgCAVoyqelFIxEFiNI6zKekHQW58g7FPYhia3fJ7UNVuXGNrjvEbsvW7NRa
         Q1V/fa/btsLk6UAm3aPQMcNa8gRDJRoXXz88Fb4CKT6xSxG51qtdh27GaSrTA8zjgM/o
         Sa/F3ziCo1PGkp4Qcyro0w1Rnu0eB9XyIqkRQVajtVhtx7U/NJgJPCuPNwuGLXi1jZg3
         pzq6wY6YOe1rRoP/vX8ThxRtWNW3xkIG2VUR9kvnnTd+VaK1LdWatMJ6lxCJ55fqruwU
         i8OA==
X-Gm-Message-State: AOAM533lecaIo3I6OGPTOZvp1UNUaKcPV175euNKe/SKSI/aRy1D7wWH
        AvSQUI0xyFUo7FKdMK3sxHGZcMlC8cNMOF73KQQ=
X-Google-Smtp-Source: ABdhPJxfM6BrYyl11I+zrvOuqDDzuDgL2DfNdSPRPwgcAp3x5ccWRamSyapRSb2So9aw2m/TV6U4/KJOBO7orUZcebQ=
X-Received: by 2002:a1f:a00e:: with SMTP id j14mr5471665vke.5.1633399956110;
 Mon, 04 Oct 2021 19:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
 <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com> <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com> <CAFiDJ5_eoUNjQbCcwgHtXHfykeD7MiSw3xJzx83+bXOFHv-dQQ@mail.gmail.com>
 <CAHCEeh+yXwAyc=G+JEfNx5tk6XXuVgZSF74yuEanBiz7JCiApQ@mail.gmail.com>
In-Reply-To: <CAHCEeh+yXwAyc=G+JEfNx5tk6XXuVgZSF74yuEanBiz7JCiApQ@mail.gmail.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Tue, 5 Oct 2021 10:12:25 +0800
Message-ID: <CAFiDJ5-=Om5rBQ9xWUC_ShdauHkeXbNMFJhE0K37nwsydppzHQ@mail.gmail.com>
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

On Mon, Oct 4, 2021 at 8:41 PM Greentime Hu <greentime.hu@sifive.com> wrote=
:
>
> Ley Foon Tan <lftan.linux@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=881=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:46=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > On Wed, Sep 29, 2021 at 11:54 PM Darius Rad <darius@bluespec.com> wrote=
:
> > >
> > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=881=
3=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
[....]


> > > > >
> > > > > So this will unconditionally enable vector instructions, and allo=
cate
> > > > > memory for vector state, for all processes, regardless of whether=
 vector
> > > > > instructions are used?
> > > > >
> > > >
> > > > Hi Darius,
> > > >
> > > > Yes, it will enable vector if has_vector() is true. The reason that=
 we
> > > > choose to enable and allocate memory for user space program is beca=
use
> > > > we also implement some common functions in the glibc such as memcpy
> > > > vector version and it is called very often by every process. So tha=
t
> > > > we assume if the user program is running in a CPU with vector ISA
> > > > would like to use vector by default. If we disable it by default an=
d
> > > > make it trigger the illegal instruction, that might be a burden sin=
ce
> > > > almost every process will use vector glibc memcpy or something like
> > > > that.
> > >
> > > Do you have any evidence to support the assertion that almost every p=
rocess
> > > would use vector operations?  One could easily argue that the convers=
e is
> > > true: no existing software uses the vector extension now, so most lik=
ely a
> > > process will not be using it.
> > >
> > > >
> > > > > Given the size of the vector state and potential power and perfor=
mance
> > > > > implications of enabling the vector engine, it seems like this sh=
ould
> > > > > treated similarly to Intel AMX on x86.  The full discussion of th=
at is
> > > > > here:
> > > > >
> > > > > https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRX=
tDSAGcbG8N+gtdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
> > > > >
> > > > > The cover letter for recent Intel AMX patches has a summary of th=
e x86
> > > > > implementation:
> > > > >
> > > > > https://lore.kernel.org/lkml/20210825155413.19673-1-chang.seok.ba=
e@intel.com/
> > > > >
> > > > > If RISC-V were to adopt a similar approach, I think the significa=
nt
> > > > > points are:
> > > > >
> > > > >   1. A process (or thread) must specifically request the desire t=
o use
> > > > > vector extensions (perhaps with some new arch_prctl() API),
> > > > >
> > > > >   2. The kernel is free to deny permission, perhaps based on
> > > > > administrative rules or for other reasons, and
> > > > >
> > > > >   3. If a process attempts to use vector extensions before doing =
the
> > > > > above, the process will die due to an illegal instruction.
> > > >
> > > > Thank you for sharing this, but I am not sure if we should treat
> > > > vector like AMX on x86. IMHO, compiler might generate code with vec=
tor
> > > > instructions automatically someday, maybe we should treat vector
> > > > extensions like other extensions.
> > > > If user knows the vector extension is supported in this CPU and he
> > > > would like to use it, it seems we should let user use it directly j=
ust
> > > > like other extensions.
> > > > If user don't know it exists or not, user should use the library AP=
I
> > > > transparently and let glibc or other library deal with it. The glib=
c
> > > > ifunc feature or multi-lib should be able to choose the correct
> > > > implementation.
> > >
> > > What makes me think that the vector extension should be treated like =
AMX is
> > > that they both (1) have a significant amount of architectural state, =
and
> > > (2) likely have a significant power and/or area impact on (non-emulat=
ed)
> > > designs.
> > >
> > > For example, I think it is possible, maybe even likely, that vector
> > > implementations will have one or more of the following behaviors:
> > >
> > >   1. A single vector unit shared among two or more harts,
> > >
> > >   2. Additional power consumption when the vector unit is enabled and=
 idle
> > > versus not being enabled at all,
> > >
> > >   3. For a system which supports variable operating frequency, a redu=
ction
> > > in the maximum frequency when the vector unit is enabled, and/or
> > >
> > >   4. The inability to enter low power states and/or delays to low pow=
er
> > > states transitions when the vector unit is enabled.
> > >
> > > None of the above constraints apply to more ordinary extensions like
> > > compressed or the various bit manipulation extensions.
> > >
> > > The discussion I linked to has some well reasoned arguments on why
> > > substantial extensions should have a mechanism to request using them =
by
> > > user space.  The discussion was in the context of Intel AMX, but appl=
ies to
> > > further x86 extensions, and I think should also apply to similar exte=
nsions
> > > on RISC-V, like vector here.
> > >
> > There is possible use case where not all cores support vector
> > extension due to size, area and power.
> > Perhaps can have the mechanism or flow to determine the
> > application/thread require vector extension or it specifically request
> > the desire to use
> > vector extensions. Then this app/thread run on cpu with vector
> > extension capability only.
> >
>
> IIRC, we assume all harts has the same ability in Linux because of SMP
> assumption.
> If we have more information of hw capability and we may use this
> information for scheduler to switch the correct process to the correct
> CPU.
> Do you have any idea how to implement it in Linux kernel? Maybe we can
> list in the TODO list.
I think we can refer to other arch implementations as reference:

1. ARM64 supports 32-bit thread on asymmetric AArch32 systems. There
is a flag in ELF to check, then start the thread on the core that
supports 32-bit execution. This patchset is merged to mainline 5.15.
https://lore.kernel.org/linux-arm-kernel/20210730112443.23245-8-will@kernel=
.org/T/

2. Link shared by Darius, on-demand request implementation on Intel AMX
https://lore.kernel.org/lkml/20210825155413.19673-1-chang.seok.bae@intel.co=
m/

glibc support optimized library functions with vector, this is enabled
by default if compiler is with vector extension enabled? If yes, then
most of the app required vector core.

Regards
Ley Foon
