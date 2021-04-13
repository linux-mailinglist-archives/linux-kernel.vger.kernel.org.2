Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A3B35DD64
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345345AbhDMLFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 07:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbhDMLFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:05:09 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB363C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 04:04:49 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id i2so3513189vka.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=je0tXK2szor3C65YXdb81D9aE+MAP/3wuEdJm5mxyfw=;
        b=Mj7Ac0nkjEdSctz+w4445kA2ADO6XOmj12OFa73aesRvYDiBgn+UpPl8quADDUYvS2
         xCraii6FMAvWuzrtW3Zja1qRh88iw06YjNgbrh0WSvy9EOKsGlWHIwZEq/Oaylx181vm
         ioZhfinaESXQZrcg94bpuFY+aj0RsEQwmVDHIzNgk21CAiEa5erqw6CCYqlgNPL6zdYF
         i2ruCYBzuUepCkhFbxq3Ms4ptjPP6Wihg3ByiWwb06T2h7jVwSnTFsiIkBBN6methXP4
         +feO0ty6+q5s6imk/y9xuEKAQHtZ+FUM89habadKZmeVL2a/yqaXocEhL3i0jjqtXAIt
         BJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=je0tXK2szor3C65YXdb81D9aE+MAP/3wuEdJm5mxyfw=;
        b=Eg+i8bBBpEPC2gzhS9XRAJvCo4Bgifo3bsA4An2BjDi7dkzuoYNI8e/IZbp86B0aYM
         Z+uOgvAFmgDLnl7dG8zYq/tgZWYPgjq+dxUsnkd96YdfWg9ESm1JuFMk7BtMBXKhMMSG
         ueZGVebY5kmn2MAz0ocy93HEvl7U7LC2GbMGV/20dSx90hPNvASJa0JBjLt/EcmPXLvQ
         OvVPqQHO4mHXV4dU5EKbKGk56IpqOtTqGtmN9Q4SkGOJQlVeSUqRxy5VToigGvFTn1AG
         ynKZRa3+kJUigRrO3odyvOZdHMk7n9VYNGB8TmUNoc2kzAn0Y05APeZRjT75dWaKZ7A2
         iYcA==
X-Gm-Message-State: AOAM531GeWwPgR8ozqDGzCPbDhTfrmUct2wYV3kk57leKBxP5m8T0qwQ
        BZLWv55J6RHa0f/7yrt1aZk0eku87FUkrm8I8ek=
X-Google-Smtp-Source: ABdhPJw2T4zkH5O3s8wSbpVcYKdfS2ik6a773rVb2Mt8OtX9ebRpMLzavazIbmQCo0FNwIjv/JRFYGcacnplRsVrM3w=
X-Received: by 2002:a1f:1184:: with SMTP id 126mr13452119vkr.21.1618311889073;
 Tue, 13 Apr 2021 04:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net> <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
 <YHVl8fFfdQDn+QYW@hirez.programming.kicks-ass.net> <CAHB2gtTzEuD7j-+5ztui0eV6UNiEisBTgoK+2Sr=Z0b4PPXRyA@mail.gmail.com>
 <20210413104503.GD15806@arm.com>
In-Reply-To: <20210413104503.GD15806@arm.com>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>
Date:   Tue, 13 Apr 2021 13:04:37 +0200
Message-ID: <CAHB2gtTtszK8XjhzByU-ZRP80_L922yEE7qkuJmFcUo2AaN7XQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>, will.deacon@arm.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 12:45 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Tue, Apr 13, 2021 at 12:25:00PM +0200, Christoph M=C3=BCllner wrote:
> > On Tue, Apr 13, 2021 at 11:37 AM Peter Zijlstra <peterz@infradead.org> =
wrote:
> > > On Tue, Apr 13, 2021 at 11:22:40AM +0200, Christoph M=C3=BCllner wrot=
e:
> > > > What about trylock()?
> > > > I.e. one could implement trylock() without a loop, by letting
> > > > trylock() fail if the SC fails.
> > > > That looks safe on first view, but nobody does this right now.
> > >
> > > Generic code has to use cmpxchg(), and then you get something like th=
is:
> > >
> > > bool trylock(atomic_t *lock)
> > > {
> > >         u32 old =3D atomic_read(lock);
> > >
> > >         if ((old >> 16) !=3D (old & 0xffff))
> > >                 return false;
> > >
> > >         return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, =
for RCsc */
> > > }
> >
> > This approach requires two loads (atomic_read() and cmpxchg()), which
> > is not required.
> > Detecting this pattern and optimizing it in a compiler is quite unlikel=
y.
> >
> > A bit less generic solution would be to wrap the LL/SC (would be
> > mandatory in this case)
> > instructions and do something like this:
> >
> > uint32_t __smp_load_acquire_reserved(void*);
> > int __smp_store_release_conditional(void*, uint32_t);
> >
> > typedef union {
> >     uint32_t v32;
> >     struct {
> >         uint16_t owner;
> >         uint16_t next;
> >     };
> > } arch_spinlock_t;
> >
> > int trylock(arch_spinlock_t *lock)
> > {
> >     arch_spinlock_t l;
> >     int success;
> >     do {
> >         l.v32 =3D __smp_load_acquire_reserved(lock);
> >         if (l.owner !=3D l.next)
> >             return 0;
> >         l.next++;
> >         success =3D __smp_store_release_conditional(lock, l.v32);
> >     } while (!success);
> >     return success;
> > }
> >
> > But here we can't tell the compiler to optimize the code between LL and=
 SC...
>
> This indeed needs some care. IIUC RISC-V has similar restrictions as arm
> here, no load/store instructions are allowed between LR and SC. You
> can't guarantee that the compiler won't spill some variable onto the
> stack.

RISC-V behaves similar, but the specification is a bit more precise:
To guarantee forward progress, the ("constrained") LL/SC sequence has to
consist of <=3D16 instructions. Further, the "dynamic code executed between
the LR and SC instructions can only contain instructions from the base =E2=
=80=9CI=E2=80=9D
instruction set, excluding loads, stores, backward jumps, taken backward
branches, JALR, FENCE, and SYSTEM instructions".

And GCC generates a backward jump in-between LL and SC.
So we have more than enough reasons, to no do it this way.

>
> BTW, I think the SC doesn't need release semantics above, only the LR
> needs acquire semantics.
>
> --
> Catalin
