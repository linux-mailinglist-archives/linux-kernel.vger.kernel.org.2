Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7539034A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhEYOEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:04:16 -0400
Received: from foss.arm.com ([217.140.110.172]:56522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232728AbhEYOEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:04:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 838DD1FB;
        Tue, 25 May 2021 07:02:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37EC33F73D;
        Tue, 25 May 2021 07:02:40 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, gerg@linux-m68k.org, green.hu@gmail.com,
        guoren@kernel.org, ink@jurassic.park.msu.ru,
        James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com,
        jonas@southpole.se, ley.foon.tan@intel.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, mattst88@gmail.com, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com, palmerdabbelt@google.com,
        paulus@samba.org, paul.walmsley@sifive.com, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@synopsys.com,
        ysato@users.sourceforge.jp
Subject: [PATCH v2 00/33] locking/atomic: convert all architectures to ARCH_ATOMIC
Date:   Tue, 25 May 2021 15:01:59 +0100
Message-Id: <20210525140232.53872-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series (based on v5.13-rc2) converts all architectures to
ARCH_ATOMIC. This will allow the use of instrumented atomics on all
architectures (e.g. for KASAN and similar), and simplifies the core
atomic code (which should allow for easier rework of the fallbacks and
other bits in future).

I'm hoping that we can queue this via the tip tree for v5.14.

I've build-tested this with the kernel.org crosstool GCC 10.3.0 binaries
(all arches except hexagon), and I haven't seen issues with the configs
I tried, so I'm fairly confident this is solid now. I'd like to get this
into linux-next ASAP to flush out any remaining issues.

The series is split into three parts:

1) Some preparatory work is done to prepare architectures and common
   code for the conversion. In this phase h8300 and microblaze are
   converted to use the asm-generic atomics exclusively, and the
   asm-generic implementations are made to function with or without
   ARCH_ATOMIC.

2) Architectures are converted one-by-one to use the ARCH_ATOMIC
   interface. I've converted each architecture with its own patch (even
   where the conversion is trivial) to make review and bisection easier.

3) The code handling !ARCH_ATOMIC is removed.

Note: I've generated the patches with:

  git format-patch -C -M -D

... so the preimage of include/linux/atomic-fallback.h is not included
in the diff when it is deleted.

The series can also be found in my atomics/arch-atomic branch on
kernel.org:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=atomics/arch-atomic
  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/arch-atomic

This version is tagged as arch-atomic-20210525.

Since v1 [1]:
* Rebase to v5.13-rc2
* Accumulate Acked-by / Reviewed-by tags
* Correct missing `arch_` prefixes
* Fix missing preprocessor glue

[1] https://lore.kernel.org/r/20210510093753.40683-1-mark.rutland@arm.com

Thanks,
Mark.

Mark Rutland (33):
  locking/atomic: make ARCH_ATOMIC a Kconfig symbol
  locking/atomic: net: use linux/atomic.h for xchg & cmpxchg
  locking/atomic: h8300: use asm-generic exclusively
  locking/atomic: microblaze: use asm-generic exclusively
  locking/atomic: openrisc: avoid asm-generic/atomic.h
  locking/atomic: atomic: remove stale comments
  locking/atomic: atomic: remove redundant include
  locking/atomic: atomic: simplify ifdeffery
  locking/atomic: atomic: support ARCH_ATOMIC
  locking/atomic: atomic64: support ARCH_ATOMIC
  locking/atomic: cmpxchg: make `generic` a prefix
  locking/atomic: cmpxchg: support ARCH_ATOMIC
  locking/atomic: alpha: move to ARCH_ATOMIC
  locking/atomic: arc: move to ARCH_ATOMIC
  locking/atomic: arm: move to ARCH_ATOMIC
  locking/atomic: csky: move to ARCH_ATOMIC
  locking/atomic: h8300: move to ARCH_ATOMIC
  locking/atomic: hexagon: move to ARCH_ATOMIC
  locking/atomic: ia64: move to ARCH_ATOMIC
  locking/atomic: m68k: move to ARCH_ATOMIC
  locking/atomic: microblaze: move to ARCH_ATOMIC
  locking/atomic: mips: move to ARCH_ATOMIC
  locking/atomic: nds32: move to ARCH_ATOMIC
  locking/atomic: nios2: move to ARCH_ATOMIC
  locking/atomic: openrisc: move to ARCH_ATOMIC
  locking/atomic: parisc: move to ARCH_ATOMIC
  locking/atomic: powerpc: move to ARCH_ATOMIC
  locking/atomic: riscv: move to ARCH_ATOMIC
  locking/atomic: sh: move to ARCH_ATOMIC
  locking/atomic: sparc: move to ARCH_ATOMIC
  locking/atomic: xtensa: move to ARCH_ATOMIC
  locking/atomic: delete !ARCH_ATOMIC remnants
  locking/atomics: atomic-instrumented: simplify ifdeffery

 arch/alpha/include/asm/atomic.h           |   88 +-
 arch/alpha/include/asm/cmpxchg.h          |   12 +-
 arch/arc/include/asm/atomic.h             |   60 +-
 arch/arc/include/asm/cmpxchg.h            |   10 +-
 arch/arm/include/asm/atomic.h             |   96 +-
 arch/arm/include/asm/cmpxchg.h            |   20 +-
 arch/arm/include/asm/sync_bitops.h        |    2 +-
 arch/arm64/include/asm/atomic.h           |    2 -
 arch/csky/include/asm/cmpxchg.h           |    8 +-
 arch/h8300/include/asm/Kbuild             |    1 +
 arch/h8300/include/asm/atomic.h           |   97 --
 arch/h8300/include/asm/cmpxchg.h          |   66 -
 arch/hexagon/include/asm/atomic.h         |   28 +-
 arch/hexagon/include/asm/cmpxchg.h        |    4 +-
 arch/ia64/include/asm/atomic.h            |   74 +-
 arch/ia64/include/asm/cmpxchg.h           |   16 +
 arch/ia64/include/uapi/asm/cmpxchg.h      |   10 +-
 arch/m68k/include/asm/atomic.h            |   60 +-
 arch/m68k/include/asm/cmpxchg.h           |   10 +-
 arch/m68k/include/asm/mmu_context.h       |    2 +-
 arch/microblaze/include/asm/Kbuild        |    1 +
 arch/microblaze/include/asm/atomic.h      |   28 -
 arch/microblaze/include/asm/cmpxchg.h     |    9 -
 arch/mips/include/asm/atomic.h            |   55 +-
 arch/mips/include/asm/cmpxchg.h           |   22 +-
 arch/mips/kernel/cmpxchg.c                |    4 +-
 arch/openrisc/include/asm/atomic.h        |   42 +-
 arch/openrisc/include/asm/cmpxchg.h       |    4 +-
 arch/parisc/include/asm/atomic.h          |   34 +-
 arch/parisc/include/asm/cmpxchg.h         |   14 +-
 arch/powerpc/include/asm/atomic.h         |  140 +-
 arch/powerpc/include/asm/cmpxchg.h        |   30 +-
 arch/powerpc/include/asm/qspinlock.h      |    2 +-
 arch/riscv/include/asm/atomic.h           |  128 +-
 arch/riscv/include/asm/cmpxchg.h          |   34 +-
 arch/s390/include/asm/atomic.h            |    2 -
 arch/sh/include/asm/atomic-grb.h          |    6 +-
 arch/sh/include/asm/atomic-irq.h          |    6 +-
 arch/sh/include/asm/atomic-llsc.h         |    6 +-
 arch/sh/include/asm/atomic.h              |    8 +-
 arch/sh/include/asm/cmpxchg.h             |    4 +-
 arch/sparc/include/asm/atomic_32.h        |   38 +-
 arch/sparc/include/asm/atomic_64.h        |   36 +-
 arch/sparc/include/asm/cmpxchg_32.h       |   12 +-
 arch/sparc/include/asm/cmpxchg_64.h       |   12 +-
 arch/sparc/lib/atomic32.c                 |   24 +-
 arch/sparc/lib/atomic_64.S                |   42 +-
 arch/x86/include/asm/atomic.h             |    2 -
 arch/xtensa/include/asm/atomic.h          |   26 +-
 arch/xtensa/include/asm/cmpxchg.h         |   14 +-
 include/asm-generic/atomic-instrumented.h |  498 +-----
 include/asm-generic/atomic.h              |  118 +-
 include/asm-generic/atomic64.h            |   45 +-
 include/asm-generic/cmpxchg-local.h       |    4 +-
 include/asm-generic/cmpxchg.h             |   42 +-
 include/linux/atomic-fallback.h           | 2595 -----------------------------
 include/linux/atomic.h                    |    4 -
 lib/atomic64.c                            |   36 +-
 net/core/filter.c                         |    2 +-
 net/sunrpc/xprtmultipath.c                |    2 +-
 scripts/atomic/check-atomics.sh           |    1 -
 scripts/atomic/gen-atomic-instrumented.sh |   51 +-
 scripts/atomic/gen-atomics.sh             |    1 -
 63 files changed, 756 insertions(+), 4094 deletions(-)
 delete mode 100644 arch/h8300/include/asm/atomic.h
 delete mode 100644 arch/h8300/include/asm/cmpxchg.h
 create mode 100644 arch/ia64/include/asm/cmpxchg.h
 delete mode 100644 arch/microblaze/include/asm/atomic.h
 delete mode 100644 arch/microblaze/include/asm/cmpxchg.h
 delete mode 100644 include/linux/atomic-fallback.h

-- 
2.11.0

