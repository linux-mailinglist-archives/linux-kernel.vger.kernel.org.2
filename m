Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27235FCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348469AbhDNUsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhDNUsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:48:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BEBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:47:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so11474893pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sLv93iXIycaLiO5hR7ABqewJtoqEdT4F46Yjt+NKeHE=;
        b=gW2TgG9TCYZTJWWjUh8puMz9PGn7xT6vV8ZGnB26aip7Uyq/R8Kee4q90EE3YlKNL/
         t1X11KaWDfLgjvmIYRs7H1IRqr+Q34Ub9gXVBwIjx7BRJu/w+t3ySVKiUCZ9aRH15qdx
         PL/AJNKkxhb2PxnXjcueEMd6ZbmJoUp4MLXUCTkuGrwxBl83RFPx1NfC+9vdkiT+n6iz
         Q2Jqtlv3COFZXzQIVobzMJdJX/1Ruhs4GcFLYeIYUqoXj29nqS0beRas1Qr/6ds/T6qK
         wuolW4HSlw/t5/t/1Y+/hQPTybEhAF24/NDM/txhlIHcrOkn8fMw9o3t0S207+FsACom
         bANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sLv93iXIycaLiO5hR7ABqewJtoqEdT4F46Yjt+NKeHE=;
        b=RcwfJXb7EqaW767eaaH89lNG+IYH0Z94HMpcRtaanwL2Jgne8OqQfQcv47p11tnBV9
         hrZd22zwpTrSxUPdyLjBajAYIuE+tnoryXG8XnHWF1t735SaSzHl/dOloUohhsILrCkN
         CQs6Ca9T5Z+tbjjXvH9/I5H2pg/a8fhYvV2mlNTGfBylW12AkNs9oFvB2WxqvmqLy1AM
         n+//B0tSjiKAmvKdOsrErDN85ta2GPl2hqOIVXbwo05FsdedI2YhnPNH2Y4sjT8bKTpz
         vc5o3CgZwPV78WQBrYq6GiIBHbLL6aTWRMRbEletdh+YIeVqqSjH2aNzcSJGNAiXVgnE
         NoDg==
X-Gm-Message-State: AOAM533S0DOqbGZUehtSKoz0lxSASU/FXhhK1qdxu+xk9C4Rs6fK8Ay3
        3SQtfjk0vnz3xCgG+vovVXE=
X-Google-Smtp-Source: ABdhPJxG7xnEb8Q8TbY0UrVLjkKo7TU4fG4oadoUY/4mNY2u0bhj7mnDN/RtN15rFzbiVJ/9Ku824w==
X-Received: by 2002:a17:90b:fd8:: with SMTP id gd24mr8503pjb.229.1618433257584;
        Wed, 14 Apr 2021 13:47:37 -0700 (PDT)
Received: from localhost (g191.124-44-145.ppp.wakwak.ne.jp. [124.44.145.191])
        by smtp.gmail.com with ESMTPSA id w21sm246367pjy.21.2021.04.14.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 13:47:36 -0700 (PDT)
Date:   Thu, 15 Apr 2021 05:47:34 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC][PATCH] locking: Generic ticket-lock
Message-ID: <20210414204734.GJ3288043@lianli.shorne-pla.net>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
 <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
 <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:16:38PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 14, 2021 at 11:05:24AM +0200, Peter Zijlstra wrote:
> 
> > That made me look at the qspinlock code, and queued_spin_*lock() uses
> > atomic_try_cmpxchg_acquire(), which means any arch that uses qspinlock
> > and has RCpc atomics will give us massive pain.
> > 
> > Current archs using qspinlock are: x86, arm64, power, sparc64, mips and
> > openrisc (WTF?!).
> > 
> > Of those, x86 and sparc are TSO archs with SC atomics, arm64 has RCsc
> > atomics, power has RCtso atomics (and is the arch we all hate for having
> > RCtso locks).
> > 
> > Now MIPS has all sorts of ill specified barriers, but last time looked
> > at it it didn't actually use any of that and stuck to using smp_mb(), so
> > it will have RCsc atomics.
> > 
> > /me goes look at wth openrisc is..  doesn't even appear to have
> > asm/barrier.h :-/ Looking at wikipedia it also doesn't appear to
> > actually have hardware ...

Yes, not hardware available to consumers directoy, my development is done on
FPGAs.

> FWIW this is broken, anything SMP *MUST* define mb(), at the very least.

Oh, thats right, something missed, when we developed qspinlocks we discussed
this and my point there was that l.swa/l.lwa implied a mem flush
l.msync/barrier.  But mb still needs to be added.

> > I'm thinking openrisc is a prime candidate for this ticket_lock.h we're
> > all talking about.
> 
> How's this then? Compile tested only on openrisc/simple_smp_defconfig.

I did my testing with this FPGA build SoC:

 https://github.com/stffrdhrn/de0_nano-multicore

Note, the CPU timer sync logic uses mb() and is a bit flaky.  So missing mb()
might be a reason.  I thought we had defined mb() and l.msync, but it seems to
have gotten lost.

With that said I could test out this ticket-lock implementation.  How would I
tell if its better than qspinlock?

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
