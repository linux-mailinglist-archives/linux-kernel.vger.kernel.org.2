Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26631D8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhBQLrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhBQLnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:43:35 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E0C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:40:57 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id do6so11103762ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bzovg3MJ/PGe0BE4lvDzG7ULiOduFRR2/N3B0q7Yo2s=;
        b=ur6iaE7lJ/sNlaMcH31IsJWRRvsSYWP3NVA/THbFGPa+ckOR7fl0fyINJDt4uh7fSI
         6wqVCEnZq47H+cpdhGYyXfsewaxWA8weJ0olkfMAH46a1T0POwq2Nz73gNPAzcgINaee
         3W7r32foS0mtGzxU3ItjI6KJhcUwxkSCLzV//SljU33v8n2IEH5soR8sWijZPlkl0ENC
         4xpWPU7GQwp9NDyycBrCkgySwuC+z2sbgFU5IBXuA7PBZfaNoh9cc4Msh4MZ96JunKUx
         13WA/UZvNHYNP/iCPWWKDLHvZLLPBsnpkJx92FoO0ZtomaodDdeooSiSMWc743dAorlD
         RxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=bzovg3MJ/PGe0BE4lvDzG7ULiOduFRR2/N3B0q7Yo2s=;
        b=uSkMk84DLhfesm0eVhuQfU/yYJ63ahkPvHZJMaET2PrEVvl/fCTqmvt8cUwleP69LW
         f+H9DaxopemNg3i4XSnA2THdwnYRFIBvjzru0OuZYh2EHBpjEfwu1a3kK6q2sFMxcpV7
         MI23UKR5jU7VZTcwGUxo+bylxmW22CejNX4zbFkYRrji/nyCiC4Qrv6Hshj516OqwS4V
         /uGyfsi65uB6Y+2dQuPsQR1UPIwU/Bab/Uf2pbgIcY27w0xR7G0m7aQYpbUi6eh0B40o
         zfwEbjj5VzafYs3f93vNgjePPAjZRUAavL3dwW198FyP0hirhYCyiDRM3eY1f+HAn3zs
         7e0w==
X-Gm-Message-State: AOAM5310Kem88Nkp8Wj/Tph013elYrBph02clhmYm1xXT1d1eClt8WWe
        IoQiFP6VDMwuHeNFtc1sjWY=
X-Google-Smtp-Source: ABdhPJwkN2uItMww6x7Rc49csJ8mR7v+vttZoxu8rOrZOoMTrfoU5RPdCZ/NO2M38g0t7dBR9PsB6Q==
X-Received: by 2002:a17:906:1951:: with SMTP id b17mr6422450eje.409.1613562056129;
        Wed, 17 Feb 2021 03:40:56 -0800 (PST)
Received: from gmail.com (20014C4E1C8ABB004E764B08203955B1.dsl.pool.telekom.hu. [2001:4c4e:1c8a:bb00:4e76:4b08:2039:55b1])
        by smtp.gmail.com with ESMTPSA id q20sm898834ejs.17.2021.02.17.03.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:40:55 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Feb 2021 12:40:54 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking updates for v5.12
Message-ID: <20210217114054.GA80562@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-02-17

   # HEAD: 3765d01bab73bdb920ef711203978f02cd26e4da Merge branch 'for-mingo-lkmm' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into locking/core

These are the v5.12 updates for the locking subsystem:

 - Core locking primitives updates:

    - Remove mutex_trylock_recursive() from the API - no users left
    - Simplify + constify the futex code a bit

 - Lockdep updates:

    - Teach lockdep about local_lock_t
    - Add CONFIG_DEBUG_IRQFLAGS=y debug config option to check for
      potentially unsafe IRQ mask restoration patterns. (I.e.
      calling raw_local_irq_restore() with IRQs enabled.)
    - Add wait context self-tests
    - Fix graph lock corner case corrupting internal data structures
    - Fix noinstr annotations

 - LKMM updates:

    - Simplify the litmus tests
    - Documentation fixes

 - KCSAN updates:

    - Re-enable KCSAN instrumentation in lib/random32.c

 - Misc fixes:

    - Don't branch-trace static label APIs
    - DocBook fix
    - Remove stale leftover empty file

 Thanks,

	Ingo

------------------>
Akira Yokosawa (2):
      tools/memory-model: Remove redundant initialization in litmus tests
      tools/memory-model: Fix typo in klitmus7 compatibility table

Alejandro Colomar (1):
      futex: Change utime parameter to be 'const ... *'

Alex Shi (1):
      locking/rtmutex: Add missing kernel-doc markup

Boqun Feng (3):
      lockdep/selftest: Add wait context selftests
      locking/lockdep: Add a skip() function to __bfs()
      locking/lockdep: Exclude local_lock_t from IRQ inversions

Jangwoong Kim (1):
      futex: Remove unneeded gotos

Marco Elver (2):
      kcsan: Rewrite kcsan_prandom_u32_max() without prandom_u32_state()
      random32: Re-enable KCSAN instrumentation

Mark Rutland (1):
      lockdep: report broken irq restoration

Nikolay Borisov (1):
      locking/rwsem: Remove empty rwsem.h

Paul E. McKenney (1):
      tools/memory-model: Tie acquire loads to reads-from

Peter Zijlstra (7):
      locking/selftests: More granular debug_locks_verbose
      locking/lockdep: Mark local_lock_t
      locking/lockdep: Clean up check_redundant() a bit
      locking/selftests: Add local_lock inversion tests
      locking: Add Reviewers
      locking/lockdep: Avoid unmatched unlock
      lockdep: Noinstr annotate warn_bogus_irq_restore()

Sebastian Andrzej Siewior (2):
      locking/mutex: Kill mutex_trylock_recursive()
      checkpatch: Don't check for mutex_trylock_recursive()

Steven Rostedt (VMware) (1):
      jump_label: Do not profile branch annotations

Sven Schnelle (1):
      s390: Use arch_local_irq_{save,restore}() in early boot code


 Documentation/admin-guide/kernel-parameters.txt    |  11 +-
 MAINTAINERS                                        |   2 +
 drivers/s390/char/sclp_early_core.c                |   4 +-
 include/linux/compiler.h                           |   2 +
 include/linux/irqflags.h                           |  12 +
 include/linux/jump_label.h                         |  12 +-
 include/linux/local_lock_internal.h                |   5 +-
 include/linux/lockdep.h                            |  15 +-
 include/linux/lockdep_types.h                      |  18 +-
 include/linux/mutex.h                              |  25 --
 include/linux/syscalls.h                           |   8 +-
 kernel/futex.c                                     |  13 +-
 kernel/kcsan/core.c                                |  26 +-
 kernel/locking/Makefile                            |   1 +
 kernel/locking/irqflag-debug.c                     |  13 +
 kernel/locking/lockdep.c                           | 186 ++++++++----
 kernel/locking/mutex.c                             |  10 -
 kernel/locking/rtmutex.c                           |  17 +-
 kernel/locking/rwsem.h                             |   0
 lib/Kconfig.debug                                  |   8 +
 lib/Makefile                                       |   3 -
 lib/locking-selftest.c                             | 334 ++++++++++++++++++++-
 scripts/checkpatch.pl                              |   6 -
 tools/memory-model/Documentation/glossary.txt      |  12 +-
 tools/memory-model/README                          |   2 +-
 .../litmus-tests/CoRR+poonceonce+Once.litmus       |   4 +-
 .../litmus-tests/CoRW+poonceonce+Once.litmus       |   4 +-
 .../litmus-tests/CoWR+poonceonce+Once.litmus       |   4 +-
 .../litmus-tests/CoWW+poonceonce.litmus            |   4 +-
 .../IRIW+fencembonceonces+OnceOnce.litmus          |   5 +-
 .../litmus-tests/IRIW+poonceonces+OnceOnce.litmus  |   5 +-
 .../ISA2+pooncelock+pooncelock+pombonce.litmus     |   7 +-
 .../litmus-tests/ISA2+poonceonces.litmus           |   6 +-
 ...cerelease+poacquirerelease+poacquireonce.litmus |   6 +-
 .../LB+fencembonceonce+ctrlonceonce.litmus         |   5 +-
 .../LB+poacquireonce+pooncerelease.litmus          |   5 +-
 .../litmus-tests/LB+poonceonces.litmus             |   5 +-
 .../MP+fencewmbonceonce+fencermbonceonce.litmus    |   5 +-
 .../litmus-tests/MP+onceassign+derefonce.litmus    |   4 +-
 .../MP+polockmbonce+poacquiresilsil.litmus         |   5 +-
 .../MP+polockonce+poacquiresilsil.litmus           |   5 +-
 tools/memory-model/litmus-tests/MP+polocks.litmus  |   6 +-
 .../litmus-tests/MP+poonceonces.litmus             |   5 +-
 .../MP+pooncerelease+poacquireonce.litmus          |   5 +-
 .../memory-model/litmus-tests/MP+porevlocks.litmus |   6 +-
 .../litmus-tests/R+fencembonceonces.litmus         |   5 +-
 .../memory-model/litmus-tests/R+poonceonces.litmus |   5 +-
 .../S+fencewmbonceonce+poacquireonce.litmus        |   5 +-
 .../memory-model/litmus-tests/S+poonceonces.litmus |   5 +-
 .../litmus-tests/SB+fencembonceonces.litmus        |   5 +-
 .../litmus-tests/SB+poonceonces.litmus             |   5 +-
 .../litmus-tests/SB+rfionceonce-poonceonces.litmus |   5 +-
 .../litmus-tests/WRC+poonceonces+Once.litmus       |   5 +-
 .../WRC+pooncerelease+fencermbonceonce+Once.litmus |   5 +-
 .../Z6.0+pooncelock+poonceLock+pombonce.litmus     |   7 +-
 .../Z6.0+pooncelock+pooncelock+pombonce.litmus     |   7 +-
 ...release+poacquirerelease+fencembonceonce.litmus |   6 +-
 57 files changed, 617 insertions(+), 294 deletions(-)
 create mode 100644 kernel/locking/irqflag-debug.c
 delete mode 100644 kernel/locking/rwsem.h

