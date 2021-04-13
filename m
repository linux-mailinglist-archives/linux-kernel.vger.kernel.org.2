Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E3E35DCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbhDMKp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236770AbhDMKp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:45:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E2C461278;
        Tue, 13 Apr 2021 10:45:06 +0000 (UTC)
Date:   Tue, 13 Apr 2021 11:45:03 +0100
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
Message-ID: <20210413104503.GD15806@arm.com>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
 <YHVl8fFfdQDn+QYW@hirez.programming.kicks-ass.net>
 <CAHB2gtTzEuD7j-+5ztui0eV6UNiEisBTgoK+2Sr=Z0b4PPXRyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB2gtTzEuD7j-+5ztui0eV6UNiEisBTgoK+2Sr=Z0b4PPXRyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 12:25:00PM +0200, Christoph Müllner wrote:
> On Tue, Apr 13, 2021 at 11:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Apr 13, 2021 at 11:22:40AM +0200, Christoph Müllner wrote:
> > > What about trylock()?
> > > I.e. one could implement trylock() without a loop, by letting
> > > trylock() fail if the SC fails.
> > > That looks safe on first view, but nobody does this right now.
> >
> > Generic code has to use cmpxchg(), and then you get something like this:
> >
> > bool trylock(atomic_t *lock)
> > {
> >         u32 old = atomic_read(lock);
> >
> >         if ((old >> 16) != (old & 0xffff))
> >                 return false;
> >
> >         return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
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
>         l.v32 = __smp_load_acquire_reserved(lock);
>         if (l.owner != l.next)
>             return 0;
>         l.next++;
>         success = __smp_store_release_conditional(lock, l.v32);
>     } while (!success);
>     return success;
> }
> 
> But here we can't tell the compiler to optimize the code between LL and SC...

This indeed needs some care. IIUC RISC-V has similar restrictions as arm
here, no load/store instructions are allowed between LR and SC. You
can't guarantee that the compiler won't spill some variable onto the
stack.

BTW, I think the SC doesn't need release semantics above, only the LR
needs acquire semantics.

-- 
Catalin
