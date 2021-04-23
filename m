Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB84368D42
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhDWGo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhDWGoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:44:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:44:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso673808pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=iuJ/jDz+88XCecNJVyqSdZXQOTPOW4XdkZb16DAQ+5Y=;
        b=TWuI+ABEUPqLstLhLgqZ+hJ0Zi6A2tLOdU4VNel4elknqn0OOWMAScdXEEsKa4exTN
         PwSgRT4yyiqVvD3q/3e/TP32SK9dl1Ztiko73kbyVTPZmNuBMG0VKwPBslmp52jyA9/w
         A36LlxJ6w7/Rsbg14IRy9uvxt9870adgKOcQXyBC+0ylYxKglpbeFULDmwh2EyzkM6kt
         kFJiCnMyrZwNiI29DoPQkeKZZuMH3ssj3iVolClnGAhdFCbETbhjlkEoqtpPpbhnU2hD
         j/oG0ZNIeTGkj+X3rZHg3iMLuBY4iNz8dSU9RlUe5tFsfAF4mzA9r+Xc9/vx9XxWWJQT
         92aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iuJ/jDz+88XCecNJVyqSdZXQOTPOW4XdkZb16DAQ+5Y=;
        b=J0L0jU12i5UMBnxCZnChYhfO9yoDpS0Q1hfqWp/qDoN7/yE1bypcY0lpZfzqeAvBn7
         iQN7NpM2xLJoBF+VS7UXRL/Dy/Q7Obai+gASyYrBGM+H/iAOdW0WEG6VrZ0ejWiCE+wc
         amMMwM5QmsZsha8lNdWNa6HDp4xS2p61Aw5DamV+3d2PNFQ0v3qPBWSdLufI1w6T7Zra
         LQoFKEzDDxcSYKEGxz+fX48tRRWliCuWKoPBz3/RlUxAd+O60pF0HdMZ++puGQ631Vyi
         4bQVzz7xb5d2Wx/CAp68FyK8eqBtB6eEJagv5CCcVlPFHcVZRBSNeRkhywgi7U+qguyi
         yq1Q==
X-Gm-Message-State: AOAM533FGzh4e+6tkM5szQkw8WpYjs+nkkXrFJBusQuaHDwParANYM4m
        31ugQN0XE3PjU03nVXLDb53Fcg==
X-Google-Smtp-Source: ABdhPJwFM9zVbcPyHvxfFikIZ/J5QKuR3Wj3T8kwBZMNx1goBqoHB2G4JTXO9Bm11hDWevln3MG6rA==
X-Received: by 2002:a17:90a:5511:: with SMTP id b17mr4034877pji.41.1619160257885;
        Thu, 22 Apr 2021 23:44:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x3sm3937889pfj.95.2021.04.22.23.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 23:44:17 -0700 (PDT)
Date:   Thu, 22 Apr 2021 23:44:17 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 23:44:13 PDT (-0700)
Subject:     Re: [RFC][PATCH] locking: Generic ticket-lock
In-Reply-To: <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
CC:     guoren@kernel.org, christophm30@gmail.com, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Arnd Bergmann <arnd@arndb.de>,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     peterz@infradead.org
Message-ID: <mhng-a6b7bb9b-805c-4580-8279-8e7cad76cecf@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 03:16:38 PDT (-0700), peterz@infradead.org wrote:
> On Wed, Apr 14, 2021 at 11:05:24AM +0200, Peter Zijlstra wrote:
>
>> That made me look at the qspinlock code, and queued_spin_*lock() uses
>> atomic_try_cmpxchg_acquire(), which means any arch that uses qspinlock
>> and has RCpc atomics will give us massive pain.
>>
>> Current archs using qspinlock are: x86, arm64, power, sparc64, mips and
>> openrisc (WTF?!).

We'd been talking about moving to qspinlock on RISC-V as well.  Not sure 
if that's where this thread came from or if there was another one, but 
we did talk about RISC-V qspinlock a bit on IRC (and it looks a bit like 
the prototype I posted there) so I figured it's best to write something 
down here -- at least that way I won't forgot what was going on next 
time qspinlock comes around:

It seems premature to move RISC-V to qspinlock.  In the RISC-V qspinlock 
thread (and my first crack at this) I'd opened the door for supporting 
both, but at the time I wasn't really aware of how complicated the 
requirements imposed by qspinlock on the architecture is.  We're 
definately not there yet on RISC-V, so I don't really see any reason to 
allow flipping on qspinlock yet -- essentially be allowing users to flip 
it on we'd be giving them some indication that it may work, which would 
couple ourselves to that flavor of lock continuing to work in the 
future.  I don't want to do that until we have something we can point to 
that says qspinlocks will function properly, moving over before that 
just opens a huge can of worms.

Patch sets to move RISC-V over to qspinlock have shown up a handful of 
times over the years.  I'd always considered this just a performance 
thing so I'd been worried about moving over without any benchmarks.  We 
still don't have any locking benchmarks, but I'm happy moving over to 
ticket locks: they're not meaningfully more expensive in the 
non-contended case, having fair locks is a huge win, and it gets code of 
out arch/riscv/ (that's probably the most important one on my end :)).  
IIUC qrwlock should be fine (when backed by a ticket lock like this), 
which will let us get rid of all our lock code.  We will pay a small 
price on the existing microarchitectures (it's a few extra cycles for 
the half-word non-atomic RMW than the AMO, oddly enough) but that seems 
like a small price to pay for fairness.

Regardless, I'm not going to flip RISC-V over for the upcoming merge 
window -- it's just too late in the cycle for this sort of change, and I 
do want to at least look at the generated code first.  This is a pretty 
invasive change and I want to at least get it a full round of 
linux-next.

Anyway, thanks for doing this -- it's certainly way cleaner that what I 
was coming up with.  I'm assuming you're going to eventually send out a 
non-RFC for this?

>> Of those, x86 and sparc are TSO archs with SC atomics, arm64 has RCsc
>> atomics, power has RCtso atomics (and is the arch we all hate for having
>> RCtso locks).
>>
>> Now MIPS has all sorts of ill specified barriers, but last time looked
>> at it it didn't actually use any of that and stuck to using smp_mb(), so
>> it will have RCsc atomics.
>>
>> /me goes look at wth openrisc is..  doesn't even appear to have
>> asm/barrier.h :-/ Looking at wikipedia it also doesn't appear to
>> actually have hardware ...
>
> FWIW this is broken, anything SMP *MUST* define mb(), at the very least.
>
>> I'm thinking openrisc is a prime candidate for this ticket_lock.h we're
>> all talking about.
>
> How's this then? Compile tested only on openrisc/simple_smp_defconfig.
>
> ---
>  arch/openrisc/Kconfig                      |  1 -
>  arch/openrisc/include/asm/Kbuild           |  5 +-
>  arch/openrisc/include/asm/spinlock.h       |  3 +-
>  arch/openrisc/include/asm/spinlock_types.h |  2 +-
>  include/asm-generic/qspinlock.h            | 30 +++++++++++
>  include/asm-generic/ticket-lock-types.h    | 11 ++++
>  include/asm-generic/ticket-lock.h          | 86 ++++++++++++++++++++++++++++++
>  7 files changed, 131 insertions(+), 7 deletions(-)
>
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 591acc5990dc..1858cf309f1f 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -32,7 +32,6 @@ config OPENRISC
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select OR1K_PIC
>  	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
> -	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select OMPIC if SMP
>  	select ARCH_WANT_FRAME_POINTERS
> diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
> index ca5987e11053..cb260e7d73db 100644
> --- a/arch/openrisc/include/asm/Kbuild
> +++ b/arch/openrisc/include/asm/Kbuild
> @@ -1,9 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y += extable.h
>  generic-y += kvm_para.h
> -generic-y += mcs_spinlock.h
> -generic-y += qspinlock_types.h
> -generic-y += qspinlock.h
> +generic-y += ticket-lock.h
> +generic-y += ticket-lock-types.h
>  generic-y += qrwlock_types.h
>  generic-y += qrwlock.h
>  generic-y += user.h
> diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
> index a8940bdfcb7e..0b839ed1f3a0 100644
> --- a/arch/openrisc/include/asm/spinlock.h
> +++ b/arch/openrisc/include/asm/spinlock.h
> @@ -15,8 +15,7 @@
>  #ifndef __ASM_OPENRISC_SPINLOCK_H
>  #define __ASM_OPENRISC_SPINLOCK_H
>
> -#include <asm/qspinlock.h>
> -
> +#include <asm/ticket-lock.h>
>  #include <asm/qrwlock.h>
>
>  #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
> diff --git a/arch/openrisc/include/asm/spinlock_types.h b/arch/openrisc/include/asm/spinlock_types.h
> index 7c6fb1208c88..58ea31fa65ce 100644
> --- a/arch/openrisc/include/asm/spinlock_types.h
> +++ b/arch/openrisc/include/asm/spinlock_types.h
> @@ -1,7 +1,7 @@
>  #ifndef _ASM_OPENRISC_SPINLOCK_TYPES_H
>  #define _ASM_OPENRISC_SPINLOCK_TYPES_H
>
> -#include <asm/qspinlock_types.h>
> +#include <asm/ticket-lock-types.h>
>  #include <asm/qrwlock_types.h>
>
>  #endif /* _ASM_OPENRISC_SPINLOCK_TYPES_H */
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
> index d74b13825501..a7a1296b0b4d 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -2,6 +2,36 @@
>  /*
>   * Queued spinlock
>   *
> + * A 'generic' spinlock implementation that is based on MCS locks. An
> + * architecture that's looking for a 'generic' spinlock, please first consider
> + * ticket-lock.h and only come looking here when you've considered all the
> + * constraints below and can show your hardware does actually perform better
> + * with qspinlock.
> + *
> + *
> + * It relies on atomic_*_release()/atomic_*_acquire() to be RCsc (or no weaker
> + * than RCtso if you're power), where regular code only expects atomic_t to be
> + * RCpc.

Thanks for writing this up.  We likely would have made a mess out of it 
without this.

> + *
> + * It relies on a far greater (compared to ticket-lock.h) set of atomic
> + * operations to behave well together, please audit them carefully to ensure
> + * they all have forward progress. Many atomic operations may default to
> + * cmpxchg() loops which will not have good forward progress properties on
> + * LL/SC architectures.
> + *
> + * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
> + * do. Carefully read the patches that introduced queued_fetch_set_pending_acquire().
> + *
> + * It also heavily relies on mixed size atomic operations, in specific it
> + * requires architectures to have xchg16; something which many LL/SC
> + * architectures need to implement as a 32bit and+or in order to satisfy the
> + * forward progress guarantees mentioned above.
> + *
> + * Further reading on mixed size atomics that might be relevant:
> + *
> + *   http://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
> + *
> + *
>   * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
>   * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
>   *
> diff --git a/include/asm-generic/ticket-lock-types.h b/include/asm-generic/ticket-lock-types.h
> new file mode 100644
> index 000000000000..829759aedda8
> --- /dev/null
> +++ b/include/asm-generic/ticket-lock-types.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_GENERIC_TICKET_LOCK_TYPES_H
> +#define __ASM_GENERIC_TICKET_LOCK_TYPES_H
> +
> +#include <linux/types.h>
> +typedef atomic_t arch_spinlock_t;
> +
> +#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
> +
> +#endif /* __ASM_GENERIC_TICKET_LOCK_TYPES_H */
> diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
> new file mode 100644
> index 000000000000..3f0d53e21a37
> --- /dev/null
> +++ b/include/asm-generic/ticket-lock.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * 'Generic' ticket-lock implementation.
> + *
> + * It relies on atomic_fetch_add() having well defined forward progress
> + * guarantees under contention. If your architecture cannot provide this, stick
> + * to a test-and-set lock.
> + *
> + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
> + * sub-word of the value. This is generally true for anything LL/SC although
> + * you'd be hard pressed to find anything useful in architecture specifications
> + * about this. If your architecture cannot do this you might be better off with
> + * a test-and-set.
> + *
> + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
> + * uses atomic_fetch_add() which is SC to create an RCsc lock.
> + *
> + * The implementation uses smp_cond_load_acquire() to spin, so if the
> + * architecture has WFE like instructions to sleep instead of poll for word
> + * modifications be sure to implement that (see ARM64 for example).

That's really neat: I'd missed the "lose a load reservation" in the WFE 
triggers and assumed I had to do some explicit event.  IIUC this should 
all just work on arm64 as-is, and be essentially just as efficient as 
the bespoke ticket lock removed by c11090474d70 ("arm64: locking: 
Replace ticket lock implementation with qspinlock").

> + *
> + */
> +
> +#ifndef __ASM_GENERIC_TICKET_LOCK_H
> +#define __ASM_GENERIC_TICKET_LOCK_H
> +
> +#include <linux/atomic.h>
> +#include <asm/ticket-lock-types.h>
> +
> +static __always_inline void ticket_lock(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> +	u16 ticket = val >> 16;
> +
> +	if (ticket == (u16)val)
> +		return;
> +
> +	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
> +}
> +
> +static __always_inline bool ticket_trylock(arch_spinlock_t *lock)
> +{
> +	u32 old = atomic_read(lock);
> +
> +	if ((old >> 16) != (old & 0xffff))
> +		return false;
> +
> +	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
> +}
> +
> +static __always_inline void ticket_unlock(arch_spinlock_t *lock)
> +{
> +	u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
> +	u32 val = atomic_read(lock);
> +
> +	smp_store_release(ptr, (u16)val + 1);
> +}
> +
> +static __always_inline int ticket_is_locked(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_read(lock);
> +
> +	return ((val >> 16) != (val & 0xffff));
> +}
> +
> +static __always_inline int ticket_is_contended(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_read(lock);
> +
> +	return (s16)((val >> 16) - (val & 0xffff)) > 1;
> +}
> +
> +static __always_inline int ticket_value_unlocked(arch_spinlock_t lock)
> +{
> +	return !ticket_is_locked(&lock);
> +}
> +
> +#define arch_spin_lock(l)		ticket_lock(l)
> +#define arch_spin_trylock(l)		ticket_trylock(l)
> +#define arch_spin_unlock(l)		ticket_unlock(l)
> +#define arch_spin_is_locked(l)		ticket_is_locked(l)
> +#define arch_spin_is_contended(l)	ticket_is_contended(l)
> +#define arch_spin_value_unlocked(l)	ticket_value_unlocked(l)
> +
> +#endif /* __ASM_GENERIC_TICKET_LOCK_H */
