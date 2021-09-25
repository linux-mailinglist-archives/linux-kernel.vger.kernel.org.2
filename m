Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB484182D7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 16:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343807AbhIYOtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 10:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhIYOtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 10:49:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DD16610EA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632581246;
        bh=j7KjvK/CSPxQZinRjxWJ9ifb7QL00dbxFWTst7bunlg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nppd7eI1bcadlOs8NTWd5aN8ZmcaZ5mLv/5u+GKNrWSBhKopO/G0QHcM1r+5izetz
         xz0ejg5fGUTF9i7AbopzZrRYBMtF5YzwNQT4xz7SrQMknzfmfyEkKVptY8kMvpaEOt
         6sxu8tMdshohVYMdv5k3ofQw96OrMgS/fUL7VrpW7ppPNnr3f98H40Vn5FW58EfCiS
         4f5nA+hzDjLhBnZ9XFdUU9+FUiDKjQsX51G/x7OxsVPdN/NP5rfhYtaQmSEXHV9zTY
         hsVE5yIbrCXOnlPosTuNJ8We+Dc/oZiQFlA+XCmdYxIbtGybFBOkZU7BLDcWACtDCB
         2FXMvIw8MAh/w==
Received: by mail-vk1-f171.google.com with SMTP id t200so5179078vkt.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 07:47:26 -0700 (PDT)
X-Gm-Message-State: AOAM532z7akXA9cC78g6w1WVnjZgXhNd1AB46My8Fq32h8adz8SGbXOq
        HnHnLNp6mZoCRoJwu8egLY6rOxGvhLIj0HWE21U=
X-Google-Smtp-Source: ABdhPJzvRfQ7xtlnVZE5iUxgkPuwZE06FXRG2o9fHqmfudhA4lPQH0jm/yULzl/nRQAz9i82m8i9drm8cnL5QKC4KE8=
X-Received: by 2002:ac5:c896:: with SMTP id n22mr12354745vkl.8.1632581245322;
 Sat, 25 Sep 2021 07:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210919165331.224664-1-guoren@kernel.org>
In-Reply-To: <20210919165331.224664-1-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 25 Sep 2021 22:47:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQu3qa2biCdYHTgfcJCBdAE=03zMs53XbiU4a8svMQmcA@mail.gmail.com>
Message-ID: <CAJF2gTQu3qa2biCdYHTgfcJCBdAE=03zMs53XbiU4a8svMQmcA@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping Peter, would you continue your generic ticket-lock work? Then
riscv could directly use it.

ping Palmer, would you mind take the patch in riscv before the generic
ticket-lock [1] merged in?

ping Anup, let's use ticket-lock first. When future ISA improved,
change to qspinlock. The current riscv progress axiom seems not ready
for a large system.

I've tested the patch on the qemu and 4*SMP hw platform.

[1]: https://lore.kernel.org/linux-riscv/YHbBBuVFNnI4kjj3@hirez.programming=
.kicks-ass.net/raw

On Mon, Sep 20, 2021 at 12:53 AM <guoren@kernel.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> This patch introduces a ticket lock implementation for riscv, and the
> implementation is from Peter Zijlstra generic ticket-lock patch:
>
>     locking: Generic ticket-lock
>
>     On Wed, Apr 14, 2021 at 11:05:24AM +0200, Peter Zijlstra wrote:
>
>     > That made me look at the qspinlock code, and queued_spin_*lock() us=
es
>     > atomic_try_cmpxchg_acquire(), which means any arch that uses qspinl=
ock
>     > and has RCpc atomics will give us massive pain.
>     >
>     > Current archs using qspinlock are: x86, arm64, power, sparc64, mips=
 and
>     > openrisc (WTF?!).
>     >
>     > Of those, x86 and sparc are TSO archs with SC atomics, arm64 has RC=
sc
>     > atomics, power has RCtso atomics (and is the arch we all hate for h=
aving
>     > RCtso locks).
>     >
>     > Now MIPS has all sorts of ill specified barriers, but last time loo=
ked
>     > at it it didn't actually use any of that and stuck to using smp_mb(=
), so
>     > it will have RCsc atomics.
>     >
>     > /me goes look at wth openrisc is..  doesn't even appear to have
>     > asm/barrier.h :-/ Looking at wikipedia it also doesn't appear to
>     > actually have hardware ...
>
>     FWIW this is broken, anything SMP *MUST* define mb(), at the very lea=
st.
>
>     > I'm thinking openrisc is a prime candidate for this ticket_lock.h w=
e're
>     > all talking about.
>
>     How's this then? Compile tested only on openrisc/simple_smp_defconfig=
.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> Tested-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Christoph M=C3=BCllner <christophm30@gmail.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/Kconfig                      |   1 +
>  arch/riscv/include/asm/Kbuild           |   1 +
>  arch/riscv/include/asm/spinlock.h       | 130 ++++++------------------
>  arch/riscv/include/asm/spinlock_types.h |  13 +--
>  4 files changed, 36 insertions(+), 109 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d18a59ea10e5..a2f745715614 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -36,6 +36,7 @@ config RISCV
>         select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>         select ARCH_SUPPORTS_HUGETLBFS if MMU
>         select ARCH_USE_MEMTEST
> +       select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>         select ARCH_WANT_FRAME_POINTERS
>         select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuil=
d
> index 445ccc97305a..e57ef80a796e 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -3,5 +3,6 @@ generic-y +=3D early_ioremap.h
>  generic-y +=3D extable.h
>  generic-y +=3D flat.h
>  generic-y +=3D kvm_para.h
> +generic-y +=3D qrwlock.h
>  generic-y +=3D user.h
>  generic-y +=3D vmlinux.lds.h
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/s=
pinlock.h
> index f4f7fa1b7ca8..61287b3ff4a7 100644
> --- a/arch/riscv/include/asm/spinlock.h
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -7,129 +7,59 @@
>  #ifndef _ASM_RISCV_SPINLOCK_H
>  #define _ASM_RISCV_SPINLOCK_H
>
> -#include <linux/kernel.h>
> -#include <asm/current.h>
> -#include <asm/fence.h>
> -
> -/*
> - * Simple spin lock operations.  These provide no fairness guarantees.
> - */
> -
> -/* FIXME: Replace this with a ticket lock, like MIPS. */
> +static __always_inline void ticket_lock(arch_spinlock_t *lock)
> +{
> +       u32 val =3D atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc *=
/
> +       u16 ticket =3D val >> 16;
>
> -#define arch_spin_is_locked(x) (READ_ONCE((x)->lock) !=3D 0)
> +       if (ticket =3D=3D (u16)val)
> +               return;
>
> -static inline void arch_spin_unlock(arch_spinlock_t *lock)
> -{
> -       smp_store_release(&lock->lock, 0);
> +       atomic_cond_read_acquire(lock, ticket =3D=3D (u16)VAL);
>  }
>
> -static inline int arch_spin_trylock(arch_spinlock_t *lock)
> +static __always_inline bool ticket_trylock(arch_spinlock_t *lock)
>  {
> -       int tmp =3D 1, busy;
> +       u32 old =3D atomic_read(lock);
>
> -       __asm__ __volatile__ (
> -               "       amoswap.w %0, %2, %1\n"
> -               RISCV_ACQUIRE_BARRIER
> -               : "=3Dr" (busy), "+A" (lock->lock)
> -               : "r" (tmp)
> -               : "memory");
> +       if ((old >> 16) !=3D (old & 0xffff))
> +               return false;
>
> -       return !busy;
> +       return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for =
RCsc */
>  }
>
> -static inline void arch_spin_lock(arch_spinlock_t *lock)
> +static __always_inline void ticket_unlock(arch_spinlock_t *lock)
>  {
> -       while (1) {
> -               if (arch_spin_is_locked(lock))
> -                       continue;
> +       u16 *ptr =3D (u16 *)lock;
> +       u32 val =3D atomic_read(lock);
>
> -               if (arch_spin_trylock(lock))
> -                       break;
> -       }
> +       smp_store_release(ptr, (u16)val + 1);
>  }
>
> -/***********************************************************/
> -
> -static inline void arch_read_lock(arch_rwlock_t *lock)
> +static __always_inline int ticket_value_unlocked(arch_spinlock_t lock)
>  {
> -       int tmp;
> -
> -       __asm__ __volatile__(
> -               "1:     lr.w    %1, %0\n"
> -               "       bltz    %1, 1b\n"
> -               "       addi    %1, %1, 1\n"
> -               "       sc.w    %1, %1, %0\n"
> -               "       bnez    %1, 1b\n"
> -               RISCV_ACQUIRE_BARRIER
> -               : "+A" (lock->lock), "=3D&r" (tmp)
> -               :: "memory");
> +       return (((u32)lock.counter >> 16) =3D=3D ((u32)lock.counter & 0xf=
fff));
>  }
>
> -static inline void arch_write_lock(arch_rwlock_t *lock)
> +static __always_inline int ticket_is_locked(arch_spinlock_t *lock)
>  {
> -       int tmp;
> -
> -       __asm__ __volatile__(
> -               "1:     lr.w    %1, %0\n"
> -               "       bnez    %1, 1b\n"
> -               "       li      %1, -1\n"
> -               "       sc.w    %1, %1, %0\n"
> -               "       bnez    %1, 1b\n"
> -               RISCV_ACQUIRE_BARRIER
> -               : "+A" (lock->lock), "=3D&r" (tmp)
> -               :: "memory");
> +       return !ticket_value_unlocked(READ_ONCE(*lock));
>  }
>
> -static inline int arch_read_trylock(arch_rwlock_t *lock)
> +static __always_inline int ticket_is_contended(arch_spinlock_t *lock)
>  {
> -       int busy;
> -
> -       __asm__ __volatile__(
> -               "1:     lr.w    %1, %0\n"
> -               "       bltz    %1, 1f\n"
> -               "       addi    %1, %1, 1\n"
> -               "       sc.w    %1, %1, %0\n"
> -               "       bnez    %1, 1b\n"
> -               RISCV_ACQUIRE_BARRIER
> -               "1:\n"
> -               : "+A" (lock->lock), "=3D&r" (busy)
> -               :: "memory");
> -
> -       return !busy;
> -}
> +       u32 val =3D atomic_read(lock);
>
> -static inline int arch_write_trylock(arch_rwlock_t *lock)
> -{
> -       int busy;
> -
> -       __asm__ __volatile__(
> -               "1:     lr.w    %1, %0\n"
> -               "       bnez    %1, 1f\n"
> -               "       li      %1, -1\n"
> -               "       sc.w    %1, %1, %0\n"
> -               "       bnez    %1, 1b\n"
> -               RISCV_ACQUIRE_BARRIER
> -               "1:\n"
> -               : "+A" (lock->lock), "=3D&r" (busy)
> -               :: "memory");
> -
> -       return !busy;
> +       return (s16)((val >> 16) - (val & 0xffff)) > 1;
>  }
>
> -static inline void arch_read_unlock(arch_rwlock_t *lock)
> -{
> -       __asm__ __volatile__(
> -               RISCV_RELEASE_BARRIER
> -               "       amoadd.w x0, %1, %0\n"
> -               : "+A" (lock->lock)
> -               : "r" (-1)
> -               : "memory");
> -}
> +#define arch_spin_lock(l)              ticket_lock(l)
> +#define arch_spin_trylock(l)           ticket_trylock(l)
> +#define arch_spin_unlock(l)            ticket_unlock(l)
> +#define arch_spin_value_unlocked(l)    ticket_value_unlocked(l)
> +#define arch_spin_is_locked(l)         ticket_is_locked(l)
> +#define arch_spin_is_contended(l)      ticket_is_contended(l)
>
> -static inline void arch_write_unlock(arch_rwlock_t *lock)
> -{
> -       smp_store_release(&lock->lock, 0);
> -}
> +#include <asm/qrwlock.h>
>
>  #endif /* _ASM_RISCV_SPINLOCK_H */
> diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include=
/asm/spinlock_types.h
> index f398e7638dd6..4d7cbb3d62e8 100644
> --- a/arch/riscv/include/asm/spinlock_types.h
> +++ b/arch/riscv/include/asm/spinlock_types.h
> @@ -10,16 +10,11 @@
>  # error "please don't include this file directly"
>  #endif
>
> -typedef struct {
> -       volatile unsigned int lock;
> -} arch_spinlock_t;
> +#include <linux/types.h>
> +typedef atomic_t arch_spinlock_t;
>
> -#define __ARCH_SPIN_LOCK_UNLOCKED      { 0 }
> +#define __ARCH_SPIN_LOCK_UNLOCKED      ATOMIC_INIT(0)
>
> -typedef struct {
> -       volatile unsigned int lock;
> -} arch_rwlock_t;
> -
> -#define __ARCH_RW_LOCK_UNLOCKED                { 0 }
> +#include <asm-generic/qrwlock_types.h>
>
>  #endif /* _ASM_RISCV_SPINLOCK_TYPES_H */
> --
> 2.25.1
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
