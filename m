Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68D131D7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhBQLDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhBQLDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:03:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C145C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:02:33 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b14so15377629eju.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kDv2Gy/lW5GcYH3V39AGGNfshzEOIDnlSqcpiABTPKE=;
        b=RjCs73+qSndDfFVXXFq1bdd7G6Aw5TwMa9fdA9ORrlLx3K/xoKqD/KiCQO6ycT/Unq
         7ad6knxXsS/wWqtc47Ajc7vn0lbaN8pPCdCxaKwu4Au45nCgGcL4mb4zgzsHFcct0Utq
         yO6yvDkRULkt5phu9bH25MAAp1ze24td11Zfm3kKywhKPTHmOsenePdft38Cl63QmcTw
         i/SLOL2uS8bqtyJzUPSmOQ3d8AaCUrawUhpH6a6+jrYCK4hV9u2QEt+pok+HT/k/0qBH
         y1PUTYUlEuv7alHu5KjxlXD0qHJAV3af9HUVXjTAWEEjivav+fq7p3pUBrLspY0AGQJ2
         r+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=kDv2Gy/lW5GcYH3V39AGGNfshzEOIDnlSqcpiABTPKE=;
        b=UBIRNoMYv+Bt0ImSx4jeoTq53XsnoH3DyyHxWR+zJfZ1NVvWQgYQMLbKMa2+cMFZgw
         nx5OZNLWv83fpxsCddXkNek/tS6lWnIMLb9Nsb9t6GTYYJnQv4ws2V+Cs9s1fFJuuTFl
         FIOEK75A+/62ys6HkYuQpr5mfPNEDWvAvNAPVoOrjhdrstcqxABulfc9omKuAFuRmXl0
         beX+oS2bHIIcTSsVDPb7MmDTAOqGbozc2e2HVeyrv4Huy70+JmVu4ZqmJ4tLDzncIr4G
         +g7/NCe6SJ/AM83yAXkz0KKJdgRMysFPZnVmJIBa9+iBnGPqkWE6at2BG9Lazwa06rlp
         gmJQ==
X-Gm-Message-State: AOAM533ssDRyPkJfJosCpWGVm9YGq/QPdNrdUMc8pRHwIRBPeMsJ6nJ2
        Wx89KZw4uPdJaGD4sTKaCkU=
X-Google-Smtp-Source: ABdhPJwAosAug6qFYB5/1ej/WAfKdlaZmFaWCe1PMXPplgE9vc9zClrqUashVLUKZyJJkt9vjXYbqg==
X-Received: by 2002:a17:906:85cd:: with SMTP id i13mr12430821ejy.448.1613559752051;
        Wed, 17 Feb 2021 03:02:32 -0800 (PST)
Received: from gmail.com (20014C4E1C8ABB004E764B08203955B1.dsl.pool.telekom.hu. [2001:4c4e:1c8a:bb00:4e76:4b08:2039:55b1])
        by smtp.gmail.com with ESMTPSA id q14sm881325edw.52.2021.02.17.03.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:02:31 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Feb 2021 12:02:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [GIT PULL] RCU updates for v5.12
Message-ID: <20210217110229.GA21245@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/rcu git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2021-02-17

   # HEAD: 2b392cb11c0db645ba81a08b6a2e96c56ec1fc64 Merge branch 'for-mingo-nolibc' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

These are the latest RCU updates for v5.12:

 - Documentation updates.

 - Miscellaneous fixes.

 - kfree_rcu() updates: Addition of mem_dump_obj() to provide allocator return
   addresses to more easily locate bugs.  This has a couple of RCU-related commits,
   but is mostly MM.  Was pulled in with akpm's agreement.

 - Per-callback-batch tracking of numbers of callbacks,
   which enables better debugging information and smarter
   reactions to large numbers of callbacks.

 - The first round of changes to allow CPUs to be runtime switched from and to
   callback-offloaded state.

 - CONFIG_PREEMPT_RT-related changes.

 - RCU CPU stall warning updates.

 - Addition of polling grace-period APIs for SRCU.

 - Torture-test and torture-test scripting updates, including a "torture everything"
   script that runs rcutorture, locktorture, scftorture, rcuscale, and refscale.
   Plus does an allmodconfig build.

 - nolibc fixes for the torture tests

 Thanks,

	Ingo

------------------>
Frederic Weisbecker (17):
      tools/rcutorture: Make identify_qemu_vcpus() independent of local language
      rcu/nocb: Turn enabled/offload states into a common flag
      rcu/nocb: Provide basic callback offloading state machine bits
      rcu/nocb: Always init segcblist on CPU up
      rcu/nocb: De-offloading CB kthread
      rcu/nocb: Don't deoffload an offline CPU with pending work
      rcu/nocb: De-offloading GP kthread
      rcu/nocb: Re-offload support
      rcu/nocb: Shutdown nocb timer on de-offloading
      rcu/nocb: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
      rcu/nocb: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
      rcu/nocb: Only cond_resched() from actual offloaded batch processing
      rcu/nocb: Process batch locally as long as offloading isn't complete
      rcu/nocb: Locally accelerate callbacks as long as offloading isn't complete
      cpu/hotplug: Add lockdep_is_cpus_held()
      timer: Add timer_curr_running()
      tools/rcutorture: Support nocb toggle in TREE01

Joel Fernandes (Google) (6):
      rcu/tree: Make rcu_do_batch count how many callbacks were executed
      rcu/segcblist: Add additional comments to explain smp_mb()
      rcu/segcblist: Add counters to segcblist datastructure
      rcu/tree: segcblist: Remove redundant smp_mb()s
      rcu/trace: Add tracing for how segcb list changes
      rcu/segcblist: Add debug checks for segment lengths

Julia Cartwright (1):
      rcu: Enable rcu_normal_after_boot unconditionally for RT

Mauro Carvalho Chehab (1):
      list: Fix a typo at the kernel-doc markup

Neeraj Upadhyay (1):
      rcu: Check and report missed fqs timer wakeup on RCU stall

Paul E. McKenney (83):
      docs: Remove redundant "``" from Requirements.rst
      doc: Remove obsolete RCU-bh and RCU-sched update-side API members
      doc: Update RCU requirements RCU_INIT_POINTER() description
      doc: Remove obsolete rcutree.rcu_idle_lazy_gp_delay boot parameter
      srcu: Make Tiny SRCU use multi-bit grace-period counter
      srcu: Provide internal interface to start a Tiny SRCU grace period
      srcu: Provide internal interface to start a Tree SRCU grace period
      srcu: Provide polling interfaces for Tiny SRCU grace periods
      srcu: Provide polling interfaces for Tree SRCU grace periods
      srcu: Document polling interfaces for Tree SRCU grace periods
      srcu: Add comment explaining cookie overflow/wrap
      rcutorture: Prepare for ->start_gp_poll and ->poll_gp_state
      rcutorture: Add writer-side tests of polling grace-period API
      rcutorture: Add reader-side tests of polling grace-period API
      rcutorture: Add testing for RCU's global memory ordering
      scftorture: Add debug output for wrong-CPU warning
      rcu: Mark obtuse portion of stall warning as internal debug
      rcu: For RCU grace-period kthread starvation, dump last CPU it ran on
      rcu: Do not NMI offline CPUs
      torture: Make --kcsan specify lockdep
      torture: Make kvm.sh "--dryrun sched" summarize number of batches
      torture: Make kvm.sh "--dryrun sched" summarize number of builds
      torture: Allow kvm.sh --datestamp to specify subdirectories
      torture: Prepare for splitting qemu execution from kvm-test-1-run.sh
      torture: Add config2csv.sh script to compare torture scenarios
      torture: Make kvm.sh "Test Summary" date be end of test
      torture: Make kvm.sh arguments accumulate
      torture: Print run duration at end of kvm.sh execution
      torture: Make kvm.sh return failure upon build failure
      torture: Make kvm.sh include --kconfig arguments in CPU calculation
      torture: Add kvm.sh test summary to end of log file
      torture: Stop hanging on panic
      torture: Add --dryrun batches to help schedule a distributed run
      torture: s/STOP/STOP.1/ to avoid scenario collision
      torture: Simplify exit-code plumbing for kvm-recheck.sh and kvm-find-errors.sh
      torture: Remove "Failed to add ttynull console" false positive
      torture: Allow standalone kvm-recheck.sh run detect --trust-make
      rcu: Add lockdep_assert_irqs_disabled() to rcu_sched_clock_irq() and callees
      rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros
      rcu: Make TASKS_TRACE_RCU select IRQ_WORK
      torture: Do Kconfig analysis only once per scenario
      rcutorture: Test runtime toggling of CPUs' callback offloading
      rcu/nocb: Add grace period and task state to show_rcu_nocb_state() output
      rcu/nocb: Add nocb CB kthread list to show_rcu_nocb_state() output
      rcu/nocb: Code-style nits in callback-offloading toggling
      rcu: Do any deferred nocb wakeups at CPU offline time
      torture: Add torture.sh torture-everything script
      torture: Make torture.sh use common time-duration bash functions
      torture: Remove use of "eval" in torture.sh
      torture: Add "make allmodconfig" to torture.sh
      torture: Auto-size SCF and scaling runs based on number of CPUs
      torture: Enable torture.sh argument checking
      torture: Make torture.sh rcuscale and refscale deal with allmodconfig
      torture: Make torture.sh refscale runs use verbose_batched module parameter
      torture: Create doyesno helper function for torture.sh
      torture: Make torture.sh allmodconfig retain and label output
      torture: Make torture.sh throttle VERBOSE_TOROUT_*() for refscale
      torture: Make torture.sh refuse to do zero-length runs
      torture: Drop log.long generation from torture.sh
      torture: Allow scenarios to be specified to torture.sh
      torture: Add command and results directory to torture.sh log
      torture: Add --kcsan-kmake-arg to torture.sh for KCSAN
      torture: Compress KASAN vmlinux files
      refscale: Allow summarization of verbose output
      rcutorture: Require entire stutter period be post-boot
      rcutorture: Make synctype[] and nsynctype be static global
      rcutorture: Make rcu_torture_fakewriter() use blocking wait primitives
      torture: Add fuzzed hrtimer-based sleep functions
      rcutorture: Use torture_hrtimeout_jiffies() to avoid busy-waits
      torture: Make stutter use torture_hrtimeout_*() functions
      rcutorture: Use hrtimers for reader and writer delays
      torture: Make refscale throttle high-rate printk()s
      torture: Throttle VERBOSE_TOROUT_*() output
      rcutorture: Make object_debug also double call_rcu() heap object
      torture: Clean up after torture-test CPU hotplugging
      torture: Maintain torture-specific set of CPUs-online books
      rcutorture: Add rcutree.use_softirq=0 to RUDE01 and TASKS01
      mm: Add mem_dump_obj() to print source of memory block
      mm: Make mem_dump_obj() handle NULL and zero-sized pointers
      mm: Make mem_dump_obj() handle vmalloc() memory
      mm: Make mem_obj_dump() vmalloc() dumps include start and length
      rcu: Make call_rcu() print mem_dump_obj() info for double-freed callback
      percpu_ref: Dump mem_dump_obj() info upon reference-count underflow

Paul Gortmaker (1):
      docs: Fix typos and drop/fix dead links in RCU documentation

Peter Zijlstra (1):
      sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled

Scott Wood (1):
      rcu: Unconditionally use rcuc threads on PREEMPT_RT

Sebastian Andrzej Siewior (3):
      rcu: Make RCU_BOOST default on CONFIG_PREEMPT_RT
      doc: Update RCU's requirements page about the PREEMPT_RT wiki
      doc: Use CONFIG_PREEMPTION

Uladzislau Rezki (Sony) (3):
      rcu: Introduce kfree_rcu() single-argument macro
      rcu: Eliminate the __kvfree_rcu() macro
      rcu-tasks: Add RCU-tasks self tests

Wang Qing (1):
      locking: Remove duplicate include of percpu-rwsem.h

Willy Tarreau (10):
      tools/nolibc: Add the definition for dup()
      tools/nolibc: Make dup2() rely on dup3() when available
      tools/nolibc: Make getpgrp() fall back to getpgid(0)
      tools/nolibc: Implement fork() based on clone()
      tools/nolibc: Implement poll() based on ppoll()
      tools/nolibc: Get timeval, timespec and timezone from linux/time.h
      tools/nolibc: Remove incorrect definitions of __ARCH_WANT_*
      tools/nolibc: Emit detailed error for missing alternate syscall number definitions
      tools/nolibc: Fix position of -lgcc in the documented example
      tools/rcutorture: Fix position of -lgcc in mkinitrd.sh

Zqiang (1):
      rcu: Record kvfree_call_rcu() call stack for KASAN


 .../Expedited-Grace-Periods.rst                    |   4 +-
 .../RCU/Design/Requirements/Requirements.rst       | 732 +++++++++++----------
 Documentation/RCU/checklist.rst                    |  10 +-
 Documentation/RCU/rcubarrier.rst                   |   6 +-
 Documentation/RCU/stallwarn.rst                    |  27 +-
 Documentation/RCU/whatisRCU.rst                    |  10 +-
 Documentation/admin-guide/kernel-parameters.txt    |  39 +-
 include/linux/cpu.h                                |   2 +
 include/linux/list.h                               |   2 +-
 include/linux/mm.h                                 |   2 +
 include/linux/rcu_segcblist.h                      | 120 +++-
 include/linux/rcupdate.h                           |  42 +-
 include/linux/slab.h                               |   2 +
 include/linux/srcu.h                               |   3 +
 include/linux/srcutiny.h                           |   7 +-
 include/linux/timer.h                              |   2 +
 include/linux/torture.h                            |  27 +-
 include/linux/vmalloc.h                            |   6 +
 include/trace/events/rcu.h                         |  26 +
 kernel/cpu.c                                       |   7 +
 kernel/locking/locktorture.c                       |   1 -
 kernel/rcu/Kconfig                                 |   5 +-
 kernel/rcu/rcu.h                                   |  16 +-
 kernel/rcu/rcu_segcblist.c                         | 216 ++++--
 kernel/rcu/rcu_segcblist.h                         |  57 +-
 kernel/rcu/rcutorture.c                            | 395 +++++++++--
 kernel/rcu/refscale.c                              |  23 +-
 kernel/rcu/srcutiny.c                              |  77 ++-
 kernel/rcu/srcutree.c                              | 147 ++++-
 kernel/rcu/tasks.h                                 |  79 +++
 kernel/rcu/tree.c                                  | 101 ++-
 kernel/rcu/tree.h                                  |   2 +
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_plugin.h                           | 367 ++++++++++-
 kernel/rcu/tree_stall.h                            |  60 +-
 kernel/rcu/update.c                                |   4 +-
 kernel/scftorture.c                                |   6 +-
 kernel/sched/core.c                                |   9 +-
 kernel/time/timer.c                                |  14 +
 kernel/torture.c                                   | 167 ++++-
 lib/percpu-refcount.c                              |  12 +-
 mm/slab.c                                          |  20 +
 mm/slab.h                                          |  12 +
 mm/slab_common.c                                   |  75 +++
 mm/slob.c                                          |   6 +
 mm/slub.c                                          |  40 ++
 mm/util.c                                          |  31 +
 mm/vmalloc.c                                       |  13 +
 tools/include/nolibc/nolibc.h                      | 153 +++--
 .../testing/selftests/rcutorture/bin/config2csv.sh |  67 ++
 .../selftests/rcutorture/bin/console-badness.sh    |   1 +
 .../testing/selftests/rcutorture/bin/functions.sh  |  36 +-
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   9 +-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |   3 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  12 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 103 ++-
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh |   2 +-
 .../selftests/rcutorture/bin/parse-build.sh        |   2 +-
 .../selftests/rcutorture/bin/parse-console.sh      |   2 +-
 tools/testing/selftests/rcutorture/bin/torture.sh  | 442 +++++++++++++
 .../selftests/rcutorture/configs/rcu/RUDE01.boot   |   1 +
 .../selftests/rcutorture/configs/rcu/TASKS01.boot  |   1 +
 .../selftests/rcutorture/configs/rcu/TREE01.boot   |   4 +-
 63 files changed, 3108 insertions(+), 763 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/config2csv.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/torture.sh
