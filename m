Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD48347883
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhCXM3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhCXM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:29:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A33C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:29:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q29so31490317lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdJvCy0plmg5CHNmgit4+S41GZn0t5VRajQX0HllGVk=;
        b=vbI954kA5G6fRAm3NlLe+iuuIB0n6EkmguJm50T0v3JV9A9yNE35SM5JvSs9RHmLbt
         xGaGqVyx59H0hZnIlcBHTT3Vz4s9p6i+F/QuJKYyQEhlwtt5hsiO5esIVVjqRO4FXbTC
         TJDZz+GjYqVymwiN2iVKVSk5Qxlix/ut7gucwuNjuMAUHONQHr1MhyniTDhhOjKEsnzq
         CbxDt8ZcUpIaZLAEsr0uDjKCzmU2GF54A20gR7X/gKwc5WFLoKWf6h1sIJi1Ca4pDWdd
         a/fJHp4ah7zXGJxMcV8sU/7lj8fOf4VnnKcr+F5VLGRVJEE0Lj3y25qnMZPz22C32eIO
         /iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdJvCy0plmg5CHNmgit4+S41GZn0t5VRajQX0HllGVk=;
        b=EL+44hejJa40a8dHvDV7Rh+EoZfse7aDOVkKsdElDHYot+/jBLvJEKtN4Q0mgXEZJG
         8iOk54LOGyvgqMfKS27cnYHSeRvz/D6KLtp8YDOYk+F1VMg8R7ir8sA14gLnwf4qjU36
         cUwnCVlnB5iXpHpacy1WU1SK88GrvC8T9um+2prr/SJXMSEuzZCwJ3BaprGrvbr+NXyH
         SjCMfUpzue2ohptpJAGUNeYAwhKKM377gB738+v1FPt27b7n6Xz8e0vL/QcLGtDsL6AX
         kxyMSyuyTRIiPNna/UIMDI9qkFJDXb/qxqN8AnFksKixqNYmVDwteM7oO+f67Gakx2Dh
         18Yg==
X-Gm-Message-State: AOAM532prXaInmI1us6AOiYJ3cAp8HNsU17dodUU+7WkOgYym9x7G+XD
        oytPifCFHtNI12lOikPYlzsSK7fAI4YFMEQEtRlNzA==
X-Google-Smtp-Source: ABdhPJzOh8wUTZg4ahrsrxrbNvLjXhBbiH1F+KKbzCi+ZNCt1jwRW3RtsBqBO84MG1V2I1q5u7mzBH5bFn8mmMhAhi0=
X-Received: by 2002:ac2:57c2:: with SMTP id k2mr1370181lfo.511.1616588950598;
 Wed, 24 Mar 2021 05:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <1616580892-80815-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1616580892-80815-1-git-send-email-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 24 Mar 2021 17:58:58 +0530
Message-ID: <CAAhSdy2FPHX7Mhg5bRUOTk8SAw+jfWxhKquGZpC6YD0MPLSu0A@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 3:45 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This patch introduces a ticket lock implementation for riscv, along the
> same lines as the implementation for arch/arm & arch/csky.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/Kconfig                      |   1 +
>  arch/riscv/include/asm/Kbuild           |   1 +
>  arch/riscv/include/asm/spinlock.h       | 158 ++++++++++++--------------------
>  arch/riscv/include/asm/spinlock_types.h |  19 ++--

NACK from myside.

Linux ARM64 has moved away from ticket spinlock to qspinlock.

We should directly go for qspinlock.

Regards,
Anup

>  4 files changed, 74 insertions(+), 105 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 87d7b52..7c56a20 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -30,6 +30,7 @@ config RISCV
>         select ARCH_HAS_STRICT_KERNEL_RWX if MMU
>         select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>         select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> +       select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>         select ARCH_WANT_FRAME_POINTERS
>         select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 445ccc9..e57ef80 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -3,5 +3,6 @@ generic-y += early_ioremap.h
>  generic-y += extable.h
>  generic-y += flat.h
>  generic-y += kvm_para.h
> +generic-y += qrwlock.h
>  generic-y += user.h
>  generic-y += vmlinux.lds.h
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> index f4f7fa1..2c81764 100644
> --- a/arch/riscv/include/asm/spinlock.h
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -7,129 +7,91 @@
>  #ifndef _ASM_RISCV_SPINLOCK_H
>  #define _ASM_RISCV_SPINLOCK_H
>
> -#include <linux/kernel.h>
> -#include <asm/current.h>
> -#include <asm/fence.h>
> -
>  /*
> - * Simple spin lock operations.  These provide no fairness guarantees.
> + * Ticket-based spin-locking.
>   */
> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +       arch_spinlock_t lockval;
> +       u32 tmp;
> +
> +       asm volatile (
> +               "1:     lr.w    %0, %2          \n"
> +               "       mv      %1, %0          \n"
> +               "       addw    %0, %0, %3      \n"
> +               "       sc.w    %0, %0, %2      \n"
> +               "       bnez    %0, 1b          \n"
> +               : "=&r" (tmp), "=&r" (lockval), "+A" (lock->lock)
> +               : "r" (1 << TICKET_NEXT)
> +               : "memory");
>
> -/* FIXME: Replace this with a ticket lock, like MIPS. */
> -
> -#define arch_spin_is_locked(x) (READ_ONCE((x)->lock) != 0)
> +       while (lockval.tickets.next != lockval.tickets.owner) {
> +               /*
> +                * FIXME - we need wfi/wfe here to prevent:
> +                *  - cache line bouncing
> +                *  - saving cpu pipeline in multi-harts-per-core
> +                *    processor
> +                */
> +               lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
> +       }
>
> -static inline void arch_spin_unlock(arch_spinlock_t *lock)
> -{
> -       smp_store_release(&lock->lock, 0);
> +       __atomic_acquire_fence();
>  }
>
>  static inline int arch_spin_trylock(arch_spinlock_t *lock)
>  {
> -       int tmp = 1, busy;
> -
> -       __asm__ __volatile__ (
> -               "       amoswap.w %0, %2, %1\n"
> -               RISCV_ACQUIRE_BARRIER
> -               : "=r" (busy), "+A" (lock->lock)
> -               : "r" (tmp)
> +       u32 tmp, contended, res;
> +
> +       do {
> +               asm volatile (
> +               "       lr.w    %0, %3          \n"
> +               "       srliw   %1, %0, %5      \n"
> +               "       slliw   %2, %0, %5      \n"
> +               "       or      %1, %2, %1      \n"
> +               "       li      %2, 0           \n"
> +               "       sub     %1, %1, %0      \n"
> +               "       bnez    %1, 1f          \n"
> +               "       addw    %0, %0, %4      \n"
> +               "       sc.w    %2, %0, %3      \n"
> +               "1:                             \n"
> +               : "=&r" (tmp), "=&r" (contended), "=&r" (res),
> +                 "+A" (lock->lock)
> +               : "r" (1 << TICKET_NEXT), "I" (TICKET_NEXT)
>                 : "memory");
> +       } while (res);
>
> -       return !busy;
> -}
> -
> -static inline void arch_spin_lock(arch_spinlock_t *lock)
> -{
> -       while (1) {
> -               if (arch_spin_is_locked(lock))
> -                       continue;
> -
> -               if (arch_spin_trylock(lock))
> -                       break;
> +       if (!contended) {
> +               __atomic_acquire_fence();
> +               return 1;
> +       } else {
> +               return 0;
>         }
>  }
>
> -/***********************************************************/
> -
> -static inline void arch_read_lock(arch_rwlock_t *lock)
> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
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
> -               : "+A" (lock->lock), "=&r" (tmp)
> -               :: "memory");
> +       smp_store_release(&lock->tickets.owner, lock->tickets.owner + 1);
> +       /* FIXME - we need ipi/sev here to notify above */
>  }
>
> -static inline void arch_write_lock(arch_rwlock_t *lock)
> +static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
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
> -               : "+A" (lock->lock), "=&r" (tmp)
> -               :: "memory");
> +       return lock.tickets.owner == lock.tickets.next;
>  }
>
> -static inline int arch_read_trylock(arch_rwlock_t *lock)
> +static inline int arch_spin_is_locked(arch_spinlock_t *lock)
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
> -               : "+A" (lock->lock), "=&r" (busy)
> -               :: "memory");
> -
> -       return !busy;
> +       return !arch_spin_value_unlocked(READ_ONCE(*lock));
>  }
>
> -static inline int arch_write_trylock(arch_rwlock_t *lock)
> +static inline int arch_spin_is_contended(arch_spinlock_t *lock)
>  {
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
> -               : "+A" (lock->lock), "=&r" (busy)
> -               :: "memory");
> +       struct __raw_tickets tickets = READ_ONCE(lock->tickets);
>
> -       return !busy;
> +       return (tickets.next - tickets.owner) > 1;
>  }
> +#define arch_spin_is_contended arch_spin_is_contended
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
> -
> -static inline void arch_write_unlock(arch_rwlock_t *lock)
> -{
> -       smp_store_release(&lock->lock, 0);
> -}
> +#include <asm/qrwlock.h>
>
>  #endif /* _ASM_RISCV_SPINLOCK_H */
> diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
> index f398e76..d7b38bf 100644
> --- a/arch/riscv/include/asm/spinlock_types.h
> +++ b/arch/riscv/include/asm/spinlock_types.h
> @@ -10,16 +10,21 @@
>  # error "please don't include this file directly"
>  #endif
>
> +#define TICKET_NEXT    16
> +
>  typedef struct {
> -       volatile unsigned int lock;
> +       union {
> +               u32 lock;
> +               struct __raw_tickets {
> +                       /* little endian */
> +                       u16 owner;
> +                       u16 next;
> +               } tickets;
> +       };
>  } arch_spinlock_t;
>
> -#define __ARCH_SPIN_LOCK_UNLOCKED      { 0 }
> -
> -typedef struct {
> -       volatile unsigned int lock;
> -} arch_rwlock_t;
> +#define __ARCH_SPIN_LOCK_UNLOCKED      { { 0 } }
>
> -#define __ARCH_RW_LOCK_UNLOCKED                { 0 }
> +#include <asm-generic/qrwlock_types.h>
>
>  #endif /* _ASM_RISCV_SPINLOCK_TYPES_H */
> --
> 2.7.4
>
