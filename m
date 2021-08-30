Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA54F3FB052
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhH3EPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhH3EPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:15:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E50C860F57;
        Mon, 30 Aug 2021 04:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630296899;
        bh=PwINkeEbqR5rqNMtjEpboGA4bTaEbuNc5uWlK64sV7E=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=qWZqBJZTqRGkobGXYXGaErXoK9AA5yHzGxSlV1YefuLLnfLVtFWexAX7LXSei8qCj
         RIMELQsL8lhj+ZRH5dW7q1RUrRVKeCiL16q2t0UiAIlqYmNHZt5DEe/vS8dgHeeBGj
         aqsqGym/TtPW+PiK3KNT0y9ROvoVUr3UTSr+nlGwU4kYsSW2GD1mbbnSRce3h5z7n8
         x15uWkPH8GcUTKdwPqD1/SEwrXVAQMPciwTq2CtgXIpBeNBenFVo4L40AHlSOVX58m
         AIaPQa9nq7Vn6UxuIjup4/5HDeXqf2cII0yk7JYDSsrZC23HcuCSfPWKyg9CT8vK8p
         v122izN0eYkxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B2FFC5C0813; Sun, 29 Aug 2021 21:14:59 -0700 (PDT)
Date:   Sun, 29 Aug 2021 21:14:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        akiyks@gmail.com, unixbhaskar@gmail.com, frederic@kernel.org,
        xiehaocheng.cn@gmail.com, jiangong.han@windriver.com,
        joel@joelfernandes.org, jwi@linux.ibm.com, fishland@aliyun.com,
        broonie@kernel.org, w@1wt.eu, bigeasy@linutronix.de,
        senozhatsky@chromium.org, yanfei.xu@windriver.com,
        zhouzhouyi@gmail.com
Subject: [GIT PULL] RCU changes for v5.15
Message-ID: <20210830041459.GA3067667@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git core-rcu.2021.08.28a
  # HEAD: b770efc4608d24fb446b94e1087d9989425dd39b Merge branches 'doc.2021.07.20c', 'fixes.2021.08.06a', 'nocb.2021.07.20c', 'nolibc.2021.07.20c', 'tasks.2021.07.20c', 'torture.2021.07.27a' and 'torturescript.2021.07.27a' into HEAD

RCU changes for this cycle were:

o	Documentation updates.

o	Miscellaneous fixes.

o	Offloaded-callbacks updates

o	Updates to the nolibc library.

o	Tasks-RCU updates.

o	In-kernel torture-test updates.

o	Torture-test scripting, perhaps most notably the pinning of
	torture-test guest OSes so as to force differences in memory
	latency.  For example, in a two-socket system, a four-CPU guest
	OS will have one pair of its CPUs pinned to threads in a single
	core on one socket and the other pair pinned to threads in a
	single core on the other socket.  This approach proved able
	to force race conditions that earlier testing missed.  Some of
	these race conditions are still being tracked down.

							Thanx, Paul

----------------------------------------------------------------
Akira Yokosawa (2):
      Documentation/RCU: Fix emphasis markers
      Documentation/RCU: Fix nested inline markup

Bhaskar Chowdhury (1):
      tools: include: nolibc: Fix a typo occured to occurred in the file nolibc.h

Frederic Weisbecker (4):
      rcu/doc: Add a quick quiz to explain further why we need smp_mb__after_unlock_lock()
      rcu/nocb: Start moving nocb code to its own plugin file
      rcu/nocb: Remove NOCB deferred wakeup from rcutree_dead_cpu()
      rcu: Explain why rcu_all_qs() is a stub in preemptible TREE RCU

Haocheng Xie (1):
      docs: Fix a typo in Documentation/RCU/stallwarn.rst

Jiangong.Han (1):
      rcuscale: Console output claims too few grace periods

Joel Fernandes (Google) (1):
      rcu: Remove special bit at the bottom of the ->dynticks counter

Julian Wiedmann (1):
      rculist: Unify documentation about missing list_empty_rcu()

Liu Song (2):
      rcu: Remove useless "ret" update in rcu_gp_fqs_loop()
      rcu: Use per_cpu_ptr to get the pointer of per_cpu variable

Mark Brown (1):
      tools/nolibc: Implement msleep()

Paul E. McKenney (41):
      doc: Update stallwarn.rst with recent changes
      rcu-tasks: Add comments explaining task_struct strategy
      rcu-tasks: Mark ->trc_reader_nesting data races
      rcu-tasks: Mark ->trc_reader_special.b.need_qs data races
      rcu-tasks: Fix synchronize_rcu_rude() typo in comment
      torture: Add clocksource-watchdog testing to torture.sh
      torture: Make torture.sh accept --do-all and --donone
      torture: Enable KCSAN summaries over groups of torture-test runs
      torture: Create KCSAN summaries for torture.sh runs
      torture: Make kvm-recheck-scf.sh tolerate qemu-cmd comments
      torture: Make kvm-recheck-lock.sh tolerate qemu-cmd comments
      torture: Log more kvm-remote.sh information
      torture: Protect kvm-remote.sh directory trees from /tmp reaping
      torture: Make kvm-recheck.sh skip kcsan.sum for build-only runs
      torture: Move parse-console.sh call to PATH-aware scripts
      torture: Put kvm.sh batch-creation awk script into a temp file
      refscale: Add measurement of clock readout
      rcutorture: Preempt rather than block when testing task stalls
      locktorture: Mark statistics data races
      locktorture: Count lock readers
      scftorture: Add RPC-like IPI tests
      scftorture: Avoid NULL pointer exception on early exit
      torture: Make kvm.sh select per-scenario affinity masks
      torture: Don't redirect qemu-cmd comment lines
      torture: Make kvm-test-1-run-qemu.sh apply affinity
      rcutorture: Upgrade two-CPU scenarios to four CPUs
      torture: Use numeric taskset argument in jitter.sh
      torture: Consistently name "qemu*" test output files
      torture: Make kvm-test-1-run-batch.sh select per-scenario affinity masks
      torture: Don't use "test" command's "-a" argument
      torture: Add timestamps to kvm-test-1-run-qemu.sh output
      torture: Make kvm-test-1-run-qemu.sh check for reboot loops
      rcu: Weaken ->dynticks accesses and updates
      rcu: Mark accesses to ->rcu_read_lock_nesting
      rcu: Start timing stall repetitions after warning complete
      srcutiny: Mark read-side data races
      rcu: Mark lockless ->qsmask read in rcu_check_boost_fail()
      rcu: Make rcu_gp_init() and rcu_gp_fqs_loop noinline to conserve stack
      rcu: Mark accesses in tree_stall.h
      rcu: Print human-readable message for schedule() in RCU reader
      Merge branches 'doc.2021.07.20c', 'fixes.2021.08.06a', 'nocb.2021.07.20c', 'nolibc.2021.07.20c', 'tasks.2021.07.20c', 'torture.2021.07.27a' and 'torturescript.2021.07.27a' into HEAD

Sebastian Andrzej Siewior (2):
      rcu: Replace deprecated CPU-hotplug functions
      torture: Replace deprecated CPU-hotplug functions.

Sergey Senozhatsky (2):
      rcu/tree: Handle VM stoppage in stall detection
      rcu: Do not disable GP stall detection in rcu_cpu_stall_reset()

Yanfei Xu (2):
      rcu: Fix to include first blocked task in stall warning
      rcu: Fix stall-warning deadlock due to non-release of rcu_node ->lock

Zhouyi Zhou (1):
      rcu: Fix macro name CONFIG_TASKS_RCU_TRACE

 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |   29 +
 .../RCU/Design/Requirements/Requirements.rst       |    8 +-
 Documentation/RCU/checklist.rst                    |   24 +-
 Documentation/RCU/rcu_dereference.rst              |    6 +-
 Documentation/RCU/stallwarn.rst                    |   31 +-
 include/linux/rculist.h                            |   35 +-
 include/linux/rcupdate.h                           |    4 +-
 include/linux/rcutiny.h                            |    3 -
 include/linux/srcutiny.h                           |    8 +-
 kernel/locking/locktorture.c                       |   25 +-
 kernel/rcu/rcuscale.c                              |    4 +-
 kernel/rcu/rcutorture.c                            |    7 +-
 kernel/rcu/refscale.c                              |   36 +-
 kernel/rcu/srcutiny.c                              |    2 +-
 kernel/rcu/tasks.h                                 |   36 +-
 kernel/rcu/tree.c                                  |  107 +-
 kernel/rcu/tree_nocb.h                             | 1496 +++++++++++++++++++
 kernel/rcu/tree_plugin.h                           | 1506 +-------------------
 kernel/rcu/tree_stall.h                            |  111 +-
 kernel/scftorture.c                                |   78 +-
 kernel/sched/core.c                                |   11 +
 kernel/torture.c                                   |    6 +-
 tools/include/nolibc/nolibc.h                      |   15 +-
 tools/testing/selftests/rcutorture/bin/jitter.sh   |   10 +-
 .../selftests/rcutorture/bin/kcsan-collapse.sh     |    2 +-
 .../testing/selftests/rcutorture/bin/kvm-again.sh  |    4 +-
 .../selftests/rcutorture/bin/kvm-assign-cpus.sh    |  106 ++
 .../rcutorture/bin/kvm-get-cpus-script.sh          |   88 ++
 .../selftests/rcutorture/bin/kvm-recheck-lock.sh   |    2 +-
 .../selftests/rcutorture/bin/kvm-recheck-scf.sh    |    2 +-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |    5 +-
 .../selftests/rcutorture/bin/kvm-remote-noreap.sh  |   30 +
 .../testing/selftests/rcutorture/bin/kvm-remote.sh |   20 +-
 .../rcutorture/bin/kvm-test-1-run-batch.sh         |   24 +
 .../rcutorture/bin/kvm-test-1-run-qemu.sh          |   49 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |    2 +
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   39 +-
 tools/testing/selftests/rcutorture/bin/torture.sh  |   37 +-
 .../selftests/rcutorture/configs/rcu/RUDE01        |    2 +-
 .../selftests/rcutorture/configs/rcu/TASKS01       |    2 +-
 .../selftests/rcutorture/configs/rcu/TASKS03       |    2 +-
 41 files changed, 2241 insertions(+), 1773 deletions(-)
 create mode 100644 kernel/rcu/tree_nocb.h
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-get-cpus-script.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-remote-noreap.sh
