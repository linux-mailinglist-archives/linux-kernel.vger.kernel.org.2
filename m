Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA435DFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbhDMNUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241658AbhDMNTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:19:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CACB0613BF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618319974;
        bh=dHb+9RWOXpHcRhO99G9+Gl2DwBKyALpUq4BvTIUtTVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F1s0RmSryWKmiV6Lz8MnxRHRlaUoqYwFV9jfjle/K/zXtw/sD0kwDmgM1QrVBfT48
         dP/+r05w75ZF5uUEEj9sYIoiHoM0KbG4INmtF7yfDQRTYjf6B4hLqIJWj22sK4kGLh
         eN74KrkQJig7XYmZfcFtH0rYQq5sSm8bBdAjQ9krnIQeMHU9JeEu48r02NU0D39Jcw
         b8M8I693gSMNQVlT2LFeo8BKnw+NoHvjfpRAJmX14C35Jyi4CMNIBoHF7IBmAFX3X4
         xa3+67B7gQnFve2cmaFA8gyKcP71EsIr6fyp8w7R6JY+dmncsWEwL32yUnSeWY8nUl
         EhUUzg8JXXVEQ==
Received: by mail-lf1-f48.google.com with SMTP id 12so27171667lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:19:34 -0700 (PDT)
X-Gm-Message-State: AOAM533AqYz2XpHDfu27EhKTC+Yjo8sUp9IzdXumvLFOhYCMN2RZipW9
        GMKxwLErqpHAPi01z3skMEkY0keAILVMGQfyPu4=
X-Google-Smtp-Source: ABdhPJxlbGxYM2u/njG9JbO35qDmCzUuVASYD4H4zpPv1qlhX0HZvmEoF8zeFppb2o8CJ6YoDuI+ISrUsjlA0TvaHR4=
X-Received: by 2002:a19:e34c:: with SMTP id c12mr22945713lfk.555.1618319973121;
 Tue, 13 Apr 2021 06:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net> <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
 <YHVl8fFfdQDn+QYW@hirez.programming.kicks-ass.net> <CAHB2gtTzEuD7j-+5ztui0eV6UNiEisBTgoK+2Sr=Z0b4PPXRyA@mail.gmail.com>
In-Reply-To: <CAHB2gtTzEuD7j-+5ztui0eV6UNiEisBTgoK+2Sr=Z0b4PPXRyA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 13 Apr 2021 21:19:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSGwt-hHbYiBUdiUbo+BTkyQtv_XNkLYws-EJcwURQbLQ@mail.gmail.com>
Message-ID: <CAJF2gTSGwt-hHbYiBUdiUbo+BTkyQtv_XNkLYws-EJcwURQbLQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 6:25 PM Christoph M=C3=BCllner
<christophm30@gmail.com> wrote:
>
> On Tue, Apr 13, 2021 at 11:37 AM Peter Zijlstra <peterz@infradead.org> wr=
ote:
> >
> > On Tue, Apr 13, 2021 at 11:22:40AM +0200, Christoph M=C3=BCllner wrote:
> >
> > > > For ticket locks you really only needs atomic_fetch_add() and
> > > > smp_store_release() and an architectural guarantees that the
> > > > atomic_fetch_add() has fwd progress under contention and that a sub=
-word
> > > > store (through smp_store_release()) will fail the SC.
> > > >
> > > > Then you can do something like:
> > > >
> > > > void lock(atomic_t *lock)
> > > > {
> > > >         u32 val =3D atomic_fetch_add(1<<16, lock); /* SC, gives us =
RCsc */
> > > >         u16 ticket =3D val >> 16;
> > > >
> > > >         for (;;) {
> > > >                 if (ticket =3D=3D (u16)val)
> > > >                         break;
> > > >                 cpu_relax();
> > > >                 val =3D atomic_read_acquire(lock);
> > > >         }
> > > > }
> > > >
> > > > void unlock(atomic_t *lock)
> > > > {
> > > >         u16 *ptr =3D (u16 *)lock + (!!__BIG_ENDIAN__);
> > > >         u32 val =3D atomic_read(lock);
> > > >
> > > >         smp_store_release(ptr, (u16)val + 1);
> > > > }
> > > >
> > > > That's _almost_ as simple as a test-and-set :-) It isn't quite opti=
mal
> > > > on x86 for not being allowed to use a memop on unlock, since its be=
ing
> > > > forced into a load-store because of all the volatile, but whatever.
> > >
> > > What about trylock()?
> > > I.e. one could implement trylock() without a loop, by letting
> > > trylock() fail if the SC fails.
> > > That looks safe on first view, but nobody does this right now.
> >
> > Generic code has to use cmpxchg(), and then you get something like this=
:
> >
> > bool trylock(atomic_t *lock)
> > {
> >         u32 old =3D atomic_read(lock);
> >
> >         if ((old >> 16) !=3D (old & 0xffff))
> >                 return false;
> >
> >         return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, fo=
r RCsc */
> > }
>
> This approach requires two loads (atomic_read() and cmpxchg()), which
> is not required.
> Detecting this pattern and optimizing it in a compiler is quite unlikely.
>
> A bit less generic solution would be to wrap the LL/SC (would be
> mandatory in this case)
> instructions and do something like this:
>
> uint32_t __smp_load_acquire_reserved(void*);
> int __smp_store_release_conditional(void*, uint32_t);
>
> typedef union {
>     uint32_t v32;
>     struct {
>         uint16_t owner;
>         uint16_t next;
>     };
> } arch_spinlock_t;
>
> int trylock(arch_spinlock_t *lock)
> {
>     arch_spinlock_t l;
>     int success;
>     do {
>         l.v32 =3D __smp_load_acquire_reserved(lock);
>         if (l.owner !=3D l.next)
>             return 0;
>         l.next++;
>         success =3D __smp_store_release_conditional(lock, l.v32);
It's a new semantics v.s cmpxchg, and cmpxchg is come from CAS
instruction to solve some complex scenario.

The primitive of cmpxchg has been widely used in Linux, so I don't
think introducing a new semantics (reserved_conditional) is a good
idea.

Also, from this point: It seems CAS instruction is more suitable for
software compatibility. Although riscv privilege spec chose the LR/SC
and list some bad sides of CAS.

>     } while (!success);
>     return success;
> }
>
> But here we can't tell the compiler to optimize the code between LL and S=
C...
>
> >
> > That will try and do the full LL/SC loop, because it wants to complete
> > the cmpxchg, but in generic code we have no other option.
> >
> > (Is this what C11's weak cmpxchg is for?)



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
