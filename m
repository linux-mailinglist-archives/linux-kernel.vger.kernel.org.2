Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB3A35E9F6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 02:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348174AbhDNAY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 20:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhDNAYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 20:24:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A833613B6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618359845;
        bh=xovKbGed2hWLO46ZuqrlITDm4dbGTaznZbIgqZ9WyXg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=APFSIBF7YveeiBYs2S0tL7Kh5qTOGxIRIdVCDSczSi4HEc41sLIm2c947gDziZGah
         TwFcbRmvki3xpDLJc125eZEr6aUv9hxXafSBQSgfsrDmuJ3C+WD8195HBLh3hmJJYI
         sjXtoFm+OI6GWEfCVzh7w62AlW8Y7rrpAgvpKXhbUN3WIvBsm39W0oJ4Dv9xd8czDT
         tSaMtB5pNO3TfDTxwij0gD/49rfzWrSpFfO7YQpMDLe7js9YZWPAfCaTNdvcQyqn4Y
         E9CmQWO8Ow9/lk3xRX2T6NGwQ+n64bKbcDdQWCPSQsQ+0ZYre1hmST2ry+Wt/vVK0C
         UpcMlWI2b858w==
Received: by mail-lf1-f51.google.com with SMTP id e14so17440266lfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 17:24:05 -0700 (PDT)
X-Gm-Message-State: AOAM531kKhDkdBK3dhLmN4OHgMkp8OzQ12gQETHaK7K8afp/yhwGnqmw
        ByCEr7I1fmSHaxOx45FTayXiiRCouibOj3AqkWI=
X-Google-Smtp-Source: ABdhPJygo3R6B8xRNxS/T5OobQlEyh5OWixS+23KYstwEOK86NT5oa4jvbiep9TH6hZHgQWozKwBlPTidWdfKXC3uEg=
X-Received: by 2002:a05:6512:3ca7:: with SMTP id h39mr25005082lfv.346.1618359843478;
 Tue, 13 Apr 2021 17:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net> <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
 <20210413093059.GB15806@arm.com>
In-Reply-To: <20210413093059.GB15806@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 14 Apr 2021 08:23:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSa8KO_iPn=05-YCHmAKNDkoESvATw+e434GY9eYy1LDw@mail.gmail.com>
Message-ID: <CAJF2gTSa8KO_iPn=05-YCHmAKNDkoESvATw+e434GY9eYy1LDw@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 5:31 PM Catalin Marinas <catalin.marinas@arm.com> w=
rote:
>
> On Tue, Apr 13, 2021 at 11:22:40AM +0200, Christoph M=C3=BCllner wrote:
> > On Tue, Apr 13, 2021 at 10:03 AM Peter Zijlstra <peterz@infradead.org> =
wrote:
> > > On Mon, Apr 12, 2021 at 11:54:55PM +0200, Christoph M=C3=BCllner wrot=
e:
> > > > On Mon, Apr 12, 2021 at 7:33 PM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
> > > > > My plan is to add a generic ticket-based lock, which can be selec=
ted at
> > > > > compile time.  It'll have no architecture dependencies (though it=
'll
> > > > > likely have some hooks for architectures that can make this go fa=
ster).
> > > > > Users can then just pick which spinlock flavor they want, with th=
e idea
> > > > > being that smaller systems will perform better with ticket locks =
and
> > > > > larger systems will perform better with queued locks.  The main g=
oal
> > > > > here is to give the less widely used architectures an easy way to=
 have
> > > > > fair locks, as right now we've got a lot of code duplication beca=
use any
> > > > > architecture that wants ticket locks has to do it themselves.
> > > >
> > > > In the case of LL/SC sequences, we have a maximum of 16 instruction=
s
> > > > on RISC-V. My concern with a pure-C implementation would be that
> > > > we cannot guarantee this (e.g. somebody wants to compile with -O0)
> > > > and I don't know of a way to abort the build in case this limit exc=
eeds.
> > > > Therefore I have preferred inline assembly for OpenSBI (my initial =
idea
> > > > was to use closure-like LL/SC macros, where you can write the loop
> > > > in form of C code).
> > >
> > > For ticket locks you really only needs atomic_fetch_add() and
> > > smp_store_release() and an architectural guarantees that the
> > > atomic_fetch_add() has fwd progress under contention and that a sub-w=
ord
> > > store (through smp_store_release()) will fail the SC.
> > >
> > > Then you can do something like:
> > >
> > > void lock(atomic_t *lock)
> > > {
> > >         u32 val =3D atomic_fetch_add(1<<16, lock); /* SC, gives us RC=
sc */
> > >         u16 ticket =3D val >> 16;
> > >
> > >         for (;;) {
> > >                 if (ticket =3D=3D (u16)val)
> > >                         break;
> > >                 cpu_relax();
> > >                 val =3D atomic_read_acquire(lock);
> > >         }
> > > }
> > >
> > > void unlock(atomic_t *lock)
> > > {
> > >         u16 *ptr =3D (u16 *)lock + (!!__BIG_ENDIAN__);
> > >         u32 val =3D atomic_read(lock);
> > >
> > >         smp_store_release(ptr, (u16)val + 1);
> > > }
> > >
> > > That's _almost_ as simple as a test-and-set :-) It isn't quite optima=
l
> > > on x86 for not being allowed to use a memop on unlock, since its bein=
g
> > > forced into a load-store because of all the volatile, but whatever.
> >
> > What about trylock()?
> > I.e. one could implement trylock() without a loop, by letting
> > trylock() fail if the SC fails.
> > That looks safe on first view, but nobody does this right now.
I think it's safe for riscv LR/SC, because in spec A 8.3 section:
"As a consequence of the eventuality guarantee, if some harts in an
execution environment are executing constrained LR/SC loops, and no
other harts or devices in the execution environment execute an
unconditional store or AMO to that reservation set, then at least one
hart will eventually exit its constrained LR/SC loop."

So it guarantees LR/SC pair:

CPU0                   CPU1
=3D=3D=3D=3D=3D=3D=3D             =3D=3D=3D=3D=3D=3D=3D
LR addr1
                            LR addr1
                            SC addr1 // guarantee success.
SC addr1

But not guarantee, another hart unconditional store (which I mentioned befo=
re):
u32 a =3D 0x55aa66bb;
u16 *ptr =3D &a;

CPU0                       CPU1
=3D=3D=3D=3D=3D=3D=3D=3D=3D             =3D=3D=3D=3D=3D=3D=3D=3D=3D
xchg16(ptr, new)     while(1)
                                    WRITE_ONCE(*(ptr + 1), x);



>
> Not familiar with RISC-V but I'd recommend that a trylock only fails if
> the lock is locked (after LR). A SC may fail for other reasons
> (cacheline eviction; depending on the microarchitecture) even if the
> lock is unlocked. At least on arm64 we had this issue with an
> implementation having a tendency to always fail the first STXR.

I think it's a broken implementation for riscv. SC couldn't fail by
cache line bouncing and only could fail by another real write.
That means the HW implementation should use a per-hart address monitor
not just grab the cache line into the exclusive state without lockdown
the SNOOP channel.
I think the implementation of LR/SC you mentioned is a gambling style
but broke the riscv spec.

Is the patch of Will's would fix up the problem you mentioned?
----
commit 9bb17be062de6f5a9c9643258951aa0935652ec3
Author: Will Deacon <will.deacon@arm.com>
Date:   Tue Jul 2 14:54:33 2013 +0100

    ARM: locks: prefetch the destination word for write prior to strex

    The cost of changing a cacheline from shared to exclusive state can be
    significant, especially when this is triggered by an exclusive store,
    since it may result in having to retry the transaction.

    This patch prefixes our {spin,read,write}_[try]lock implementations wit=
h
    pldw instructions (on CPUs which support them) to try and grab the line
    in exclusive state from the start. arch_rwlock_t is changed to avoid
    using a volatile member, since this generates compiler warnings when
    falling back on the __builtin_prefetch intrinsic which expects a const
    void * argument.

    Acked-by: Nicolas Pitre <nico@linaro.org>
    Signed-off-by: Will Deacon <will.deacon@arm.com>
----

In the end, I want to conclude my suggestions here:
 - Using ticket-lock as default
 - Using ARCH_USE_QUEUED_SPINLOCKS_XCHG32 for riscv qspinlock
 - Disable xhg16/cmxchg16 and any sub-word atomic primitive in riscv

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
