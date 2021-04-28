Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241F436D31F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhD1Ha6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbhD1Ha4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:30:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97710C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:30:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l2so9546289wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1NUdJkjyKT33yOIUgLxeLKx/qGD2JPZWSlWczBKx+I8=;
        b=jgvcojzRAlnCC+23HLUxRCE7eHOo69wLD9utMtyU+19Sn+GSVahR4Qn9KKv9p5Rg6X
         AALwRf7mIZhS0prM23g4fyi9IhodfR5UPcg2/EYwD74g0cLlBOXVAuPU856o6jLxth+M
         qBDFrQCUHmOt+iF/Tg7BOGcT/K9oS8MlcfeNg2YulziH72aqxNFPjGQ+Q5STBA0PV+BX
         7xdykTqkTfxfakR7IgQ7y8ybr+HJykxdzPrfPOBW4nYvW+YcMQkTKSVWLhsBL4D5KlUn
         MC5KR+DC/h4Rw1+MAO2GMYLKGGMt54/S6pafpunpdNXQYgPoLrscthJWDfvAraPwQ2V1
         BDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=1NUdJkjyKT33yOIUgLxeLKx/qGD2JPZWSlWczBKx+I8=;
        b=ce4jPTRc8UhkiAS2GFhymL/Kv3ozwlVljlPxSi178RV+PkEIBhmBqU8OaUan/SFzoj
         E/h7d9CnftWtyWoC3skbfRiDm2VewLmfJ8bmPZsQGrjjEbDHGSfnbyadSW1XBkb3K+Ms
         rR8EdBOpWrnatRj3RTgPgSYpbt1czczdrH/sAwKsdLUTpiUIwUTIYUYguH/L7mZ5aFX4
         ClNm56jlYLqt5FKLxoPr/+S2mfaKgfQ99W5yRvvcUouhZquD4YeLpO3UHCCX7AnE75lK
         xr0lBItFSXv5L7NCJg4xzrzOdKLxqjuWz8Jc82cdHSaUCwAQAeUTLAQmJqpl1omXrV06
         79JQ==
X-Gm-Message-State: AOAM5324APZM8CQa9R5SdANEctiwAX11iEgmobIFnnf4eKQvQGfmYdIT
        ZFyAp2YpusSzdIk2/9j7jX/x6hitoTU=
X-Google-Smtp-Source: ABdhPJwMqyno+TVwd/wWZOihGpIADnvK1cEjB9SXTw9MfjFyTmyjyW4j2fzRo82VeYWd6Oq+D9zqow==
X-Received: by 2002:adf:b642:: with SMTP id i2mr33103792wre.8.1619595009389;
        Wed, 28 Apr 2021 00:30:09 -0700 (PDT)
Received: from gmail.com (2E8BA22B.catv.pool.telekom.hu. [46.139.162.43])
        by smtp.gmail.com with ESMTPSA id i2sm4978039wro.0.2021.04.28.00.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:30:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 28 Apr 2021 09:30:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL] locking changes for v5.13
Message-ID: <20210428073007.GA144738@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-04-28

   # HEAD: f4abe9967c6fdb511ee567e129a014b60945ab93 kcsan: Fix printk format string

Locking changes for this cycle were:

 - rtmutex cleanup & spring cleaning pass that removes ~400 lines of code
 - Futex simplifications & cleanups
 - Add debugging to the CSD code, to help track down a tenacious race (or hw problem)
 - Add lockdep_assert_not_held(), to allow code to require a lock to not be held,
   and propagate this into the ath10k driver
 - Misc LKMM documentation updates
 - Misc KCSAN updates: cleanups & documentation updates
 - Misc fixes and cleanups
 - Fix locktorture bugs with ww_mutexes

 Thanks,

	Ingo

------------------>
Akira Yokosawa (1):
      tools/memory-model: Remove reference to atomic_ops.rst

Arnd Bergmann (1):
      kcsan: Fix printk format string

Bhaskar Chowdhury (1):
      locking/rwsem: Fix comment typo

Davidlohr Bueso (5):
      kernel/futex: Kill rt_mutex_next_owner()
      kernel/futex: Make futex_wait_requeue_pi() only call fixup_owner()
      kernel/futex: Move hb unlock out of unqueue_me_pi()
      kernel/futex: Explicitly document pi_lock for pi_state owner fixup
      MAINTAINERS: Add myself as futex reviewer

Ingo Molnar (1):
      locking: Fix typos in comments

Jason Gerecke (1):
      x86/jump_label: Mark arguments as const to satisfy asm constraints

Juergen Gross (3):
      locking/csd_lock: Add boot parameter for controlling CSD lock debugging
      locking/csd_lock: Prepare more CSD lock debugging
      locking/csd_lock: Add more data to CSD lock debugging

Marco Elver (4):
      kcsan, debugfs: Move debugfs file creation out of early init
      kcsan: Make test follow KUnit style recommendations
      kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests
      kcsan: Add missing license and copyright headers

Matthieu Baerts (1):
      static_call: Fix unused variable warn w/o MODULE

Mauro Carvalho Chehab (1):
      doc: Update rcu_dereference.rst reference

Paul E. McKenney (1):
      tools/memory-model: Add access-marking documentation

Peter Zijlstra (1):
      static_call: Relax static_call_update() function argument type

Sebastian Andrzej Siewior (4):
      locking/rtmutex: Remove rt_mutex_timed_lock()
      locking/rtmutex: Remove rtmutex deadlock tester leftovers
      locking/rtmutex: Remove output from deadlock detector
      locking/rtmutex: Consolidate rt_mutex_init()

Shaokun Zhang (1):
      locking/mutex: Remove repeated declaration

Shuah Khan (3):
      lockdep: Add lockdep_assert_not_held()
      lockdep: Add lockdep lock state defines
      ath10k: Detect conf_mutex held ath10k_drain_tx() calls

Thomas Gleixner (11):
      locking/rtmutex: Remove empty and unused debug stubs
      locking/rtmutex: Move rt_mutex_debug_task_free() to rtmutex.c
      locking/rtmutex: Inline chainwalk depth check
      locking/rtmutex: Remove pointless CONFIG_RT_MUTEXES=n stubs
      locking/rtmutex: Decrapify __rt_mutex_init()
      locking/rtmutex: Move debug functions as inlines into common header
      locking/rtmutex: Make text section and inlining consistent
      locking/rtmutex: Consolidate the fast/slowpath invocation
      locking/rtmutex: Fix misleading comment in rt_mutex_postunlock()
      locking/rtmutex: Restrict the trylock WARN_ON() to debug
      locking/rtmutex: Clean up signal handling in __rt_mutex_slowlock()

Waiman Long (4):
      locking/locktorture: Fix false positive circular locking splat in ww_mutex test
      locking/ww_mutex: Remove DEFINE_WW_MUTEX() macro
      locking/locktorture: Pass thread id to lock/unlock functions
      locking/locktorture: Fix incorrect use of ww_acquire_ctx in ww_mutex test


 Documentation/admin-guide/kernel-parameters.txt    |  10 +
 Documentation/dev-tools/kcsan.rst                  |   3 +
 MAINTAINERS                                        |   1 +
 arch/arm/include/asm/spinlock.h                    |   2 +-
 arch/x86/include/asm/jump_label.h                  |   4 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   2 +
 include/linux/kcsan-checks.h                       |   6 +
 include/linux/kcsan.h                              |   7 +
 include/linux/lockdep.h                            |  20 +-
 include/linux/mutex.h                              |   4 +-
 include/linux/rtmutex.h                            |  35 +-
 include/linux/rwsem.h                              |   2 +-
 include/linux/static_call.h                        |   4 +-
 include/linux/ww_mutex.h                           |  17 +-
 kernel/futex.c                                     |  29 +-
 kernel/kcsan/Makefile                              |   4 +-
 kernel/kcsan/atomic.h                              |   5 +
 kernel/kcsan/core.c                                |   7 +-
 kernel/kcsan/debugfs.c                             |   9 +-
 kernel/kcsan/encoding.h                            |   5 +
 kernel/kcsan/kcsan.h                               |   8 +-
 kernel/kcsan/{kcsan-test.c => kcsan_test.c}        | 118 +++--
 kernel/kcsan/report.c                              |   5 +
 kernel/kcsan/selftest.c                            |   5 +
 kernel/locking/Makefile                            |   2 -
 kernel/locking/lockdep.c                           |  19 +-
 kernel/locking/lockdep_proc.c                      |   2 +-
 kernel/locking/locktorture.c                       | 146 ++++---
 kernel/locking/mcs_spinlock.h                      |   2 +-
 kernel/locking/mutex.c                             |   4 +-
 kernel/locking/osq_lock.c                          |   4 +-
 kernel/locking/rtmutex-debug.c                     | 182 --------
 kernel/locking/rtmutex-debug.h                     |  37 --
 kernel/locking/rtmutex.c                           | 432 +++++++------------
 kernel/locking/rtmutex.h                           |  35 --
 kernel/locking/rtmutex_common.h                    | 105 +++--
 kernel/locking/rwsem.c                             |   4 +-
 kernel/locking/spinlock.c                          |   4 +-
 kernel/sched/core.c                                |  18 +-
 kernel/smp.c                                       | 276 +++++++++++-
 kernel/static_call.c                               |   4 +-
 lib/Kconfig.kcsan                                  |   5 +-
 .../memory-model/Documentation/access-marking.txt  | 479 +++++++++++++++++++++
 tools/memory-model/Documentation/glossary.txt      |   2 +-
 tools/memory-model/Documentation/simple.txt        |   1 -
 45 files changed, 1247 insertions(+), 828 deletions(-)
 rename kernel/kcsan/{kcsan-test.c => kcsan_test.c} (94%)
 delete mode 100644 kernel/locking/rtmutex-debug.c
 delete mode 100644 kernel/locking/rtmutex-debug.h
 delete mode 100644 kernel/locking/rtmutex.h
 create mode 100644 tools/memory-model/Documentation/access-marking.txt
