Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9221B3B5906
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhF1GRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhF1GR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:17:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E036C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 23:15:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o11so14771637ejd.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=TWbktd4YXRMltDNInbLTTyq3pkPSuFkBZTDUxrS/Kek=;
        b=iP4hXah5uZuUNmUoSLEA+He+Qrc65vzkraptctekuDZKru3GesBrtmZok7rQh1XVeu
         dsSqwJ4SF6UHhH/u8nhSe13CuTiHefS04a81TSgYIC5MLlVZ4wOQ5i3ify90e35gaS3c
         eNeWFhEnDDW9aws3I5zqcSqO6rnAwj8rQTLc7munOcIhl4JhVPayRunAKrbE6i4EG07x
         SjTqSaW5WRUI4Cef7UZ8h7hvu/7OHU+AQbeUTdZgJBGTS5hFV3cOWvRq6fAEr9wImoxo
         aZZKaCjnKn5wU5C/i1v/IR4wJQ4uHXaT1o3jK4eRmovLYwZbTC6do45hrC6Dnzyjf4iX
         xN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=TWbktd4YXRMltDNInbLTTyq3pkPSuFkBZTDUxrS/Kek=;
        b=Q0rk7cZ32Q6x/vBmWOr0Wt7uZ39ywtG0+lQ90U7fh+tjQ3nFLgYHlLeKPnkZMqn1RH
         FElmwjzzcqbnIRfB+hrQHrASj9bB0I8Q3zqjb7LUIVxgCb6xnlU6laFz5xylj8Vpj0fb
         GExF9VheydMm6PesrLWFJCMTZ21UavBTMjPST+zZ3RSlDNQ27lCBHX7qES2qoPPjfVf2
         CdJyZZCde0CVXaWCTHcEPmFIRKDaEkpj8r7Yc2bHlBUYHeoT79dbUhugFj/8c8O/mGV3
         zpd4NGjrbbye0MKlw2cLMjsj83yj3K3foPxYllYKG8pDj0D6l8kdSYXqgOU8qB9dRk18
         nZAQ==
X-Gm-Message-State: AOAM533HMYfApJn5klQGMka+8Pp6mc5/RNd6ZwWkGtClqthQJ6BUJJse
        xW2dvKpIatqwvPobwAqQ/3o=
X-Google-Smtp-Source: ABdhPJwFPpYwxF7E28mwn3xd5GZOWkPxXZHaSrBRQ45+GVhcghaL3I1o0dtbCfQ498yCrSxT8S5TcA==
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr21930493ejx.430.1624860901833;
        Sun, 27 Jun 2021 23:15:01 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id v5sm8821549edt.55.2021.06.27.23.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 23:15:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 08:14:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.14
Message-ID: <YNlo43RtRbxBb+so@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-06-28

   # HEAD: 0e8a89d49d45197770f2e57fb15f1bc9ded96eb0 locking/lockdep: Correct the description error for check_redundant()

Locking changes for this cycle:

 - Core locking & atomics:

     - Convert all architectures to ARCH_ATOMIC: move every
       architecture to ARCH_ATOMIC, then get rid of ARCH_ATOMIC
       and all the transitory facilities and #ifdefs.

       Much reduction in complexity from that series:

           63 files changed, 756 insertions(+), 4094 deletions(-)

     - Self-test enhancements

 - Futexes:

     - Add the new FUTEX_LOCK_PI2 ABI, which is a variant that
       doesn't set FLAGS_CLOCKRT (.e. uses CLOCK_MONOTONIC).

       [ The temptation to repurpose FUTEX_LOCK_PI's implicit
         setting of FLAGS_CLOCKRT & invert the flag's meaning
         to avoid having to introduce a new variant was
         resisted successfully. ]

     - Enhance futex self-tests

 - Lockdep:

     - Fix dependency path printouts
     - Optimize trace saving
     - Broaden & fix wait-context checks

 - Misc cleanups and fixes.

 Thanks,

	Ingo

------------------>
André Almeida (4):
      selftests: futex: Correctly include headers dirs
      selftests: futex: Expand timeout test
      selftests: futex: Add futex wait test
      selftests: futex: Add futex compare requeue test

Boqun Feng (4):
      locking/lockdep: Fix the dep path printing for backwards BFS
      locking/lockdep: Remove the unnecessary trace saving
      lockding/lockdep: Avoid to find wrong lock dep path in check_irq_usage()
      locking/selftests: Add a selftest for check_irq_usage()

Huilong Deng (1):
      seqlock: Remove trailing semicolon in macros

Ingo Molnar (1):
      locking: Fix comment typos

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

Pavel Begunkov (1):
      futex: Deduplicate cond_resched() invocation in futex_wake_op()

Peter Zijlstra (3):
      lockdep: Fix wait-type for empty stack
      lockdep/selftests: Fix selftests vs PROVE_RAW_LOCK_NESTING
      lockdep/selftest: Remove wait-type RCU_CALLBACK tests

Randy Dunlap (1):
      locking/lockdep: Reduce LOCKDEP dependency list

Thomas Gleixner (2):
      futex: Prepare futex_lock_pi() for runtime clock selection
      futex: Provide FUTEX_LOCK_PI2 to support clock selection

Xiongwei Song (2):
      locking/lockdep,doc: Improve readability of the block matrix
      locking/lockdep: Correct the description error for check_redundant()


 Documentation/locking/lockdep-design.rst           |    4 +-
 arch/alpha/include/asm/atomic.h                    |   88 +-
 arch/alpha/include/asm/cmpxchg.h                   |   12 +-
 arch/arc/include/asm/atomic.h                      |   60 +-
 arch/arc/include/asm/cmpxchg.h                     |   10 +-
 arch/arm/include/asm/atomic.h                      |   96 +-
 arch/arm/include/asm/cmpxchg.h                     |   20 +-
 arch/arm/include/asm/sync_bitops.h                 |    2 +-
 arch/arm64/include/asm/atomic.h                    |    2 -
 arch/csky/include/asm/cmpxchg.h                    |    8 +-
 arch/h8300/include/asm/Kbuild                      |    1 +
 arch/h8300/include/asm/atomic.h                    |   97 -
 arch/h8300/include/asm/cmpxchg.h                   |   66 -
 arch/hexagon/include/asm/atomic.h                  |   28 +-
 arch/hexagon/include/asm/cmpxchg.h                 |    4 +-
 arch/ia64/include/asm/atomic.h                     |   74 +-
 arch/ia64/include/asm/cmpxchg.h                    |   16 +
 arch/ia64/include/uapi/asm/cmpxchg.h               |   10 +-
 arch/m68k/include/asm/atomic.h                     |   60 +-
 arch/m68k/include/asm/cmpxchg.h                    |   10 +-
 arch/m68k/include/asm/mmu_context.h                |    2 +-
 arch/microblaze/include/asm/Kbuild                 |    1 +
 arch/microblaze/include/asm/atomic.h               |   28 -
 arch/microblaze/include/asm/cmpxchg.h              |    9 -
 arch/mips/include/asm/atomic.h                     |   55 +-
 arch/mips/include/asm/cmpxchg.h                    |   22 +-
 arch/mips/kernel/cmpxchg.c                         |    4 +-
 arch/openrisc/include/asm/atomic.h                 |   42 +-
 arch/openrisc/include/asm/cmpxchg.h                |    4 +-
 arch/parisc/include/asm/atomic.h                   |   34 +-
 arch/parisc/include/asm/cmpxchg.h                  |   14 +-
 arch/powerpc/include/asm/atomic.h                  |  140 +-
 arch/powerpc/include/asm/cmpxchg.h                 |   30 +-
 arch/powerpc/include/asm/qspinlock.h               |    2 +-
 arch/riscv/include/asm/atomic.h                    |  128 +-
 arch/riscv/include/asm/cmpxchg.h                   |   34 +-
 arch/s390/include/asm/atomic.h                     |    2 -
 arch/sh/include/asm/atomic-grb.h                   |    6 +-
 arch/sh/include/asm/atomic-irq.h                   |    6 +-
 arch/sh/include/asm/atomic-llsc.h                  |    6 +-
 arch/sh/include/asm/atomic.h                       |    8 +-
 arch/sh/include/asm/cmpxchg.h                      |    4 +-
 arch/sparc/include/asm/atomic_32.h                 |   38 +-
 arch/sparc/include/asm/atomic_64.h                 |   36 +-
 arch/sparc/include/asm/cmpxchg_32.h                |   12 +-
 arch/sparc/include/asm/cmpxchg_64.h                |   12 +-
 arch/sparc/lib/atomic32.c                          |   24 +-
 arch/sparc/lib/atomic_64.S                         |   42 +-
 arch/x86/include/asm/atomic.h                      |    2 -
 arch/xtensa/include/asm/atomic.h                   |   26 +-
 arch/xtensa/include/asm/cmpxchg.h                  |   14 +-
 include/asm-generic/atomic-instrumented.h          |  498 +---
 include/asm-generic/atomic.h                       |  118 +-
 include/asm-generic/atomic64.h                     |   45 +-
 include/asm-generic/cmpxchg-local.h                |    4 +-
 include/asm-generic/cmpxchg.h                      |   42 +-
 include/linux/atomic-fallback.h                    | 2595 --------------------
 include/linux/atomic.h                             |    4 -
 include/linux/lockdep_types.h                      |    2 +-
 include/linux/seqlock.h                            |    6 +-
 include/uapi/linux/futex.h                         |    2 +
 kernel/futex.c                                     |   29 +-
 kernel/locking/lockdep.c                           |  127 +-
 lib/Kconfig.debug                                  |    1 -
 lib/atomic64.c                                     |   36 +-
 lib/locking-selftest.c                             |   83 +-
 net/core/filter.c                                  |    2 +-
 net/sunrpc/xprtmultipath.c                         |    2 +-
 scripts/atomic/check-atomics.sh                    |    1 -
 scripts/atomic/gen-atomic-instrumented.sh          |   51 +-
 scripts/atomic/gen-atomics.sh                      |    1 -
 .../testing/selftests/futex/functional/.gitignore  |    2 +
 tools/testing/selftests/futex/functional/Makefile  |    7 +-
 .../selftests/futex/functional/futex_requeue.c     |  136 +
 .../selftests/futex/functional/futex_wait.c        |  171 ++
 .../futex/functional/futex_wait_timeout.c          |  126 +-
 tools/testing/selftests/futex/functional/run.sh    |    6 +
 77 files changed, 1395 insertions(+), 4157 deletions(-)
 delete mode 100644 arch/h8300/include/asm/atomic.h
 delete mode 100644 arch/h8300/include/asm/cmpxchg.h
 create mode 100644 arch/ia64/include/asm/cmpxchg.h
 delete mode 100644 arch/microblaze/include/asm/atomic.h
 delete mode 100644 arch/microblaze/include/asm/cmpxchg.h
 delete mode 100644 include/linux/atomic-fallback.h
 create mode 100644 tools/testing/selftests/futex/functional/futex_requeue.c
 create mode 100644 tools/testing/selftests/futex/functional/futex_wait.c

