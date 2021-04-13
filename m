Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4A35DB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbhDMJb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241801AbhDMJbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:31:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D94A6613B2;
        Tue, 13 Apr 2021 09:31:01 +0000 (UTC)
Date:   Tue, 13 Apr 2021 10:30:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>, will.deacon@arm.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <20210413093059.GB15806@arm.com>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:22:40AM +0200, Christoph Müllner wrote:
> On Tue, Apr 13, 2021 at 10:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Apr 12, 2021 at 11:54:55PM +0200, Christoph Müllner wrote:
> > > On Mon, Apr 12, 2021 at 7:33 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > > My plan is to add a generic ticket-based lock, which can be selected at
> > > > compile time.  It'll have no architecture dependencies (though it'll
> > > > likely have some hooks for architectures that can make this go faster).
> > > > Users can then just pick which spinlock flavor they want, with the idea
> > > > being that smaller systems will perform better with ticket locks and
> > > > larger systems will perform better with queued locks.  The main goal
> > > > here is to give the less widely used architectures an easy way to have
> > > > fair locks, as right now we've got a lot of code duplication because any
> > > > architecture that wants ticket locks has to do it themselves.
> > >
> > > In the case of LL/SC sequences, we have a maximum of 16 instructions
> > > on RISC-V. My concern with a pure-C implementation would be that
> > > we cannot guarantee this (e.g. somebody wants to compile with -O0)
> > > and I don't know of a way to abort the build in case this limit exceeds.
> > > Therefore I have preferred inline assembly for OpenSBI (my initial idea
> > > was to use closure-like LL/SC macros, where you can write the loop
> > > in form of C code).
> >
> > For ticket locks you really only needs atomic_fetch_add() and
> > smp_store_release() and an architectural guarantees that the
> > atomic_fetch_add() has fwd progress under contention and that a sub-word
> > store (through smp_store_release()) will fail the SC.
> >
> > Then you can do something like:
> >
> > void lock(atomic_t *lock)
> > {
> >         u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> >         u16 ticket = val >> 16;
> >
> >         for (;;) {
> >                 if (ticket == (u16)val)
> >                         break;
> >                 cpu_relax();
> >                 val = atomic_read_acquire(lock);
> >         }
> > }
> >
> > void unlock(atomic_t *lock)
> > {
> >         u16 *ptr = (u16 *)lock + (!!__BIG_ENDIAN__);
> >         u32 val = atomic_read(lock);
> >
> >         smp_store_release(ptr, (u16)val + 1);
> > }
> >
> > That's _almost_ as simple as a test-and-set :-) It isn't quite optimal
> > on x86 for not being allowed to use a memop on unlock, since its being
> > forced into a load-store because of all the volatile, but whatever.
> 
> What about trylock()?
> I.e. one could implement trylock() without a loop, by letting
> trylock() fail if the SC fails.
> That looks safe on first view, but nobody does this right now.

Not familiar with RISC-V but I'd recommend that a trylock only fails if
the lock is locked (after LR). A SC may fail for other reasons
(cacheline eviction; depending on the microarchitecture) even if the
lock is unlocked. At least on arm64 we had this issue with an
implementation having a tendency to always fail the first STXR.

-- 
Catalin
