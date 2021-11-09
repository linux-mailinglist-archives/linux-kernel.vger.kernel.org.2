Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E8A44AAE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244270AbhKIJxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 04:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244158AbhKIJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:52:00 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5912C061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 01:49:14 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id az8so18228468qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 01:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=l8Z1G1vgAJ4FlBEuXVbtpeANxRL+3TLXVnzSevERL00=;
        b=J16utjHFp0h2FDDj1wVFCYQkFdYuHbXKTHJIUnKkt7e9KVrg5TovfFTMWwm/8of0ZY
         S4CLw570Ns6xStx447TpKt3o/bIqrf7mC6S+54AaNFLj/z/hCUxjNzGktdgdl7ISw6Aw
         W2v/atz7PFQ9WBfWsKDWFgsTMzZklnYsLJ5H2LW4d+kSFefJlzKgvbPU3VdAvZeDoc41
         sfTBXuR3cu9pAR5iNQEeYm35p7h6ufUkSYcMeh/VjKtoi3ePRCgd2GNtq3VFPgoAshx6
         J1NZlSrfahpSbHocMqKxMV38wJpvg8zKWOHdZCIs0FUbjIEDsziJXLf54oPIXdhtknof
         X2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=l8Z1G1vgAJ4FlBEuXVbtpeANxRL+3TLXVnzSevERL00=;
        b=VhwGWn7riyanC3NJK74CMQ59mBAnCmU7AuMwliwoJBVNknLYk3OKd8Lsvg8nHm3w4a
         QGseN0Mb4GvTlLd8T2sgqaobtaoWzgjvjmzp6/KwCslIo7TXaIeuiUABUjt5H1kVWHbq
         R1jDyYQ/hiDMV0ssHyFkmP73hNqec4vAyw5SaUffpoPHmrzLUMNeMSq+VwHicaFDQFpc
         IK4fm8VlqDTQY4Wmjf51qeGAEfmVeAxqJVas68norj4WD/y1lN/P/JhTKzVPNU4RIpnR
         nYHecNLqughOdAyKjUJOnLvjd62W+9uyfFiXbzkIpKii4k+uZwIuEyzUAzAVKj8JHOtR
         1S+A==
X-Gm-Message-State: AOAM531uoR2bcAl0nPZIUHyxTulVxPHJJ/lgB8LKK0STNMLILAyDc1nR
        dDlVqGIZ+m6nfqP2s5QWq4oQ1TA82GngjxuSm8wFLw==
X-Google-Smtp-Source: ABdhPJxcjexBhZUI/gO3khiCDQFwF+FMQ5tmnXDl96oc05Q8PbinYu4z3jzE7RXsiq7H6A/er9QQdOOyja4FmEApzIs=
X-Received: by 2002:ae9:ef11:: with SMTP id d17mr4428863qkg.347.1636451353958;
 Tue, 09 Nov 2021 01:49:13 -0800 (PST)
MIME-Version: 1.0
References: <YVRp5uWFGQrwBpgf@bruce.bluespec.com> <CAHCEeh+dA9243=PwNtYvyU1Myu_E8YO2g4UNACxRogQ=6UavLQ@mail.gmail.com>
 <YVxZspMO7rAvtMBS@bruce.bluespec.com> <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
 <YXFGAqTzHMeQA+R+@bruce.bluespec.com> <CABvJ_xjMyZ3HDLinMvY88HtKywb=cwhQNOOCZYTEeL407Gyz2A@mail.gmail.com>
 <YXKVLtT2U2g3JDrm@bruce.bluespec.com> <CAHCEehKpA=d1phuAM1tdeyrp-CYQRmFxGTpvuJqWNMjRCMpWfw@mail.gmail.com>
 <YXbZtTR7TBHvdqck@bruce.bluespec.com> <CAHCEeh++tAWVkhg7uEeWGdwp6UDWqShxn8ACWMvApCkiGfgZgQ@mail.gmail.com>
 <YXlM7Ipsrz0bgv47@bruce.bluespec.com>
In-Reply-To: <YXlM7Ipsrz0bgv47@bruce.bluespec.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 9 Nov 2021 17:49:03 +0800
Message-ID: <CAHCEehJRGQwkVYiKTFh7r0sp=JnpTxdgy3CeVG=UYA2JMjqJRg@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
To:     Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 26, 2021 at 12:44:31PM +0800, Greentime Hu wrote:
> > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=8826=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:22=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > On Mon, Oct 25, 2021 at 12:47:49PM +0800, Greentime Hu wrote:
> > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=88=
22=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:40=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > On Fri, Oct 22, 2021 at 11:52:01AM +0800, Vincent Chen wrote:
> > > > > > On Thu, Oct 21, 2021 at 6:50 PM Darius Rad <darius@bluespec.com=
> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 20, 2021 at 06:01:31PM -0700, Paul Walmsley wrote=
:
> > > > > > > > Hello Darius,
> > > > > > > >
> > > > > > > > On Tue, 5 Oct 2021, Darius Rad wrote:
> > > > > > > >
> > > > > > > > > On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wr=
ote:
> > > > > > > > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=
=B49=E6=9C=8829=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:28=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime H=
u wrote:
> > > > > > > > > > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=
=B9=B49=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:21=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > > > > > > > > > > > >
> > > > > > > > > > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > > > > > > > > > This patch adds task switch support for vector.=
 It supports partial lazy
> > > > > > > > > > > > > > save and restore mechanism. It also supports al=
l lengths of vlen.
> > > > > > > >
> > > > > > > > [ ... ]
> > > > > > > >
> > > > > > > > > > > > > So this will unconditionally enable vector instru=
ctions, and allocate
> > > > > > > > > > > > > memory for vector state, for all processes, regar=
dless of whether vector
> > > > > > > > > > > > > instructions are used?
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, it will enable vector if has_vector() is true.=
 The reason that we
> > > > > > > > > > > > choose to enable and allocate memory for user space=
 program is because
> > > > > > > > > > > > we also implement some common functions in the glib=
c such as memcpy
> > > > > > > > > > > > vector version and it is called very often by every=
 process. So that
> > > > > > > > > > > > we assume if the user program is running in a CPU w=
ith vector ISA
> > > > > > > > > > > > would like to use vector by default. If we disable =
it by default and
> > > > > > > > > > > > make it trigger the illegal instruction, that might=
 be a burden since
> > > > > > > > > > > > almost every process will use vector glibc memcpy o=
r something like
> > > > > > > > > > > > that.
> > > > > > > > > > >
> > > > > > > > > > > Do you have any evidence to support the assertion tha=
t almost every process
> > > > > > > > > > > would use vector operations?  One could easily argue =
that the converse is
> > > > > > > > > > > true: no existing software uses the vector extension =
now, so most likely a
> > > > > > > > > > > process will not be using it.
> > > > > > > > > >
> > > > > > > > > > Glibc ustreaming is just starting so you didn't see sof=
tware using the
> > > > > > > > > > vector extension now and this patchset is testing based=
 on those
> > > > > > > > > > optimized glibc too. Vincent Chen is working on the gli=
bc vector
> > > > > > > > > > support upstreaming and we will also upstream the vecto=
r version glibc
> > > > > > > > > > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen=
. Then we will
> > > > > > > > > > see platform with vector support can use vector version=
 mem* and str*
> > > > > > > > > > functions automatically based on ifunc and platform wit=
hout vector
> > > > > > > > > > will use the original one automatically. These could be=
 done to select
> > > > > > > > > > the correct optimized glibc functions by ifunc mechanis=
m.
> > > > > > > >
> > > > > > > > In your reply, I noticed that you didn't address Greentime'=
s response
> > > > > > > > here.  But this looks like the key issue.  If common librar=
y functions are
> > > > > > > > vector-accelerated, wouldn't it make sense that almost ever=
y process would
> > > > > > > > wind up using vector instructions?  And thus there wouldn't=
 be much point
> > > > > > > > to skipping the vector context memory allocation?
> > > > > > > >
> > > > > > >
> > > > > > > This issue was addressed in the thread regarding Intel AMX I =
linked to in a
> > > > > > > previous message.  I don't agree that this is the key issue; =
it is one of a
> > > > > > > number of issues.  What if I don't want to take the potential
> > > > > > > power/frequency hit for the vector unit for a workload that, =
at best, uses
> > > > > > > it for the occasional memcpy?  What if the allocation fails, =
how will that
> > > > > >
> > > > > > Hi Darius,
> > > > > > The memcpy function seems not to be occasionally used in the pr=
ograms
> > > > > > because many functions in Glibc use memcpy() to complete the me=
mory
> > > > > > copy. I use the following simple case as an example.
> > > > > > test.c
> > > > > > void main(void) {
> > > > > >     return;
> > > > > > }
> > > > > > Then, we compile it by "gcc test.c -o a.out" and execute it. In=
 the
> > > > > > execution, the memcpy() has been called unexpectedly. It is bec=
ause
> > > > > > many libc initialized functions will be executed before enterin=
g the
> > > > > > user-defined main function. One of the example is __libc_setup_=
tls(),
> > > > > > which is called by __libc_start_main(). The __libc_setup_tls() =
will
> > > > > > use memcpy() during the process of creating the Dynamic Thread =
Vector
> > > > > > (DTV).
> > > > > >
> > > > > > Therefore, I think the memcpy() is widely used in most programs=
.
> > > > > >
> > > > >
> > > > > You're missing my point.  Not every (any?) program spends a major=
ity of the
> > > > > time doing memcpy(), and even if a program did, all of my points =
are still
> > > > > valid.
> > > > >
> > > > > Please read the discussion in the thread I referenced and the que=
stions in
> > > > > my prior message.
> > > > >
> > > >
> > > > Hi Darius,
> > > >
> > > > As I mentioned before, we want to treat vector ISA like a general I=
SA
> > > > instead of a specific IP. User program should be able to use it
> > > > transparently just like FPU.
> > > > It seems that the use case you want is asking user to use vector li=
ke
> > > > a specific IP, user program should ask kernel before they use it an=
d
> > > > that is not what we want to do in this patchset.
> > > >
> > >
> > > Hi Greentime,
> > >
> > > Right.
> > >
> > > But beyond what I want to do or what you want to do, is what *should*=
 Linux
> > > do?  I have attempted to provide evidence to support my position.  Yo=
u have
> > > not responded to or addressed the majority of my questions, which is
> > > concerning to me.
> >
> > Hi Darius,
> >
> > What is your majority questions?
> >
>
> 1. How will memory allocation failures for context state memory be report=
ed
> to user space?

it will return -ENOMEM for some cases or show the warning messages for
some cases.
We know it's not perfect, we should enhance that in the future, but
let's take an example: 256 bits vector length system. 256 bits * 32
registers /8 =3D 1KB.

> 2. How will a system administrator (i.e., the user) be able to effectivel=
y
> manage a system where the vector unit, which could have a considerable ar=
ea
> and/or power impact to the system, has one or more of the following
> properties:

As I mentioned before,
We would like to let user use vector transparently just like FPU or
other extensions.
If user knows that this system supports vector and user uses intrinsic
functions or assembly codes or compiler generating vector codes, user
can just use it just like FPU.
If user doesn't know that whether this system support vector or not,
user can just use the glibc or ifunc in his own libraries to detect
vector support dynamically.

>   a. A single vector unit shared among two or more harts,
>
>   b. Additional power consumption when the vector unit is enabled and idl=
e
> versus not being enabled at all,
>
>   c. For a system which supports variable operating frequency, a reductio=
n
> in the maximum frequency when the vector unit is enabled, and/or
>
>   d. The inability to enter low power states and/or delays to low power
> states transitions when the vector unit is enabled.

We also don't support this kind of system(a single vector unit shared
among 2 or more harts) in this implementation. I'll add more
assumptions in the next version patches.
For the frequency or power issues, I'll also not treat them as a
special case since we want to treat vector like an normal extension of
ISA instead of a specific IP.

> 3. You contend that the RISC-V V-extension resembles ARM SVE/SVE2, at lea=
st
> more than Intel AMX.  I do not agree, but nevertheless, why then does thi=
s
> patchset not behave similar to SVE?  On arm64, SVE is only enabled and
> memory is only allocated on first use, *not* unconditionally for all task=
s.

As we mentioned before, almost every user space program will use glibc
ld.so/libc.so and these libraries will use the vector version
optimization porting in a system with vector support.
That's why we don't let it trigger the first illegal instruction
exception because vector registers will be used at very beginning of
the program and the illegal instruction exception handling is also
heavier because we need to go to M-mode first than S-mode which means
we will need to save context and restore context twice in both M-mode
and S-mode. Since the vstate will be allocated eventually, why not
save these 2 context save/restore overhead in both M-mode and S-mode
for handling this illegal instruction exception. And if the system
doesn't support vector, glibc won't use the vector porting and the
Linux kernel won't allocate vstate for every process too.
