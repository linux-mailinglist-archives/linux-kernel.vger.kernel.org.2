Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1863BAE07
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 19:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGDR1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 13:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhGDR1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 13:27:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 020AA61378;
        Sun,  4 Jul 2021 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625419481;
        bh=tLMYDeMdVwTRkwpHGduhTjHECTrImhwMgS5StL8Uygs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=rJlSGCD6CjwBLPWXhvbXmSG4OO68QZaHWolgQHsUBfybEE15kOjtistwfrYaDdiv1
         YWywu0HR9Kmg/UmiKHoIG9VHCv16DbLfba2+Bsxm7Y743e6SUc+pqkTaFuIAqz7YKX
         Da5MEXnNi85E+7weLBNeUiIQuanzs0fbsoLExZMzv03hIVPwsJs1GRDFJpmnu/VZYM
         diMvmwUQ1JHFTjD42rAwQaCrVXO5Q5t+x6unIs18VAkTR0OTBmLhfqcJNRRxy3wCL0
         MphCz6SSIBrz/3CU6KMHyZJJdLoQEfqCgXSoX11rx35l+SeTBldhD8fUblcYkVRG56
         t3gDewqGa7Xiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C5EF85C0147; Sun,  4 Jul 2021 10:24:40 -0700 (PDT)
Date:   Sun, 4 Jul 2021 10:24:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz
Subject: [GIT PULL] RCU changes for v5.14
Message-ID: <20210704172440.GA2966393@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

In a deviation from long-standing -tip tradition, please pull the latest
RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git core-rcu-2021.07.04
  # HEAD: 641faf1b9064c270a476a424e60063bb05df3ee9: Merge branches 'bitmaprange.2021.05.10c', 'doc.2021.05.10c', 'fixes.2021.05.13a', 'kvfree_rcu.2021.05.10c', 'mmdumpobj.2021.05.10c', 'nocb.2021.05.12a', 'srcu.2021.05.12a', 'tasks.2021.05.18a' and 'torture.2021.05.10c' into HEAD (2021-05-18 10:56:19 -0700)

RCU changes for this cycle were:

o	Bitmap support for "all" as an alias for all bits.

o	Documentation updates.

o	Miscellaneous fixes, including some that overlap into mm and lockdep.

o	kvfree_rcu() updates.

o	mem_dump_obj() updates, with acks from one of the slab-allocator
	maintainers.

o	RCU NOCB CPU updates, including limited deoffloading.

o	SRCU updates.

o	Tasks-RCU updates.

o	Torture-test updates.

These changes have two merge conflicts with mainline.  The first is
a semantic conflict detected by -next between these two commits:

	2f064a59a11f ("sched: Change task_struct::state")
	e44111ed20d8 ("rcu: Add ->rt_priority and ->gp_start to show_rcu_gp_kthreads() output")

An example merge resolution may be found here:

	4e2b64e124c7 ("Merge remote-tracking branch 'linus/master' into HEAD")

The second is a trivial whitespace conflict between these two commits:

	76c8eaafe4f0 ("rcu: Create an unrcu_pointer() to remove __rcu from a pointer")
	b9964ce74544 ("rcu: Create an unrcu_pointer() to remove __rcu from a pointer")

An example merge resolution may be found here, on top of the merge commit
for the first conflict:

	f5f576accebd ("Example merge commit for RCU fixing whitespace conflict.")

And yes, this second conflict did in fact happen because I handed out
a patch containing this whitespace error, and failed to follow up with
the corrected patch.  :-/

							Thanx, Paul

----------------------------------------------------------------
Frederic Weisbecker (17):
      doc: Fix diagram references in memory-ordering document
      rcu/nocb: Use the rcuog CPU's ->nocb_timer
      timer: Revert "timer: Add timer_curr_running()"
      srcu: Remove superfluous sdp->srcu_lock_count zero filling
      srcu: Remove superfluous ssp initialization for early callbacks
      srcu: Unconditionally embed struct lockdep_map
      srcu: Initialize SRCU after timers
      srcu: Fix broken node geometry after early ssp init
      torture: Correctly fetch number of CPUs for non-English languages
      rcu/nocb: Directly call __wake_nocb_gp() from bypass timer
      rcu/nocb: Allow de-offloading rdp leader
      rcu/nocb: Cancel nocb_timer upon nocb_gp wakeup
      rcu/nocb: Delete bypass_timer upon nocb_gp wakeup
      rcu/nocb: Only cancel nocb timer if not polling
      rcu/nocb: Prepare for fine-grained deferred wakeup
      rcu/nocb: Unify timers
      srcu: Early test SRCU polling start

Ingo Molnar (1):
      rcu: Fix various typos in comments

Jules Irenge (1):
      rcu: Add missing __releases() annotation

Maninder Singh (2):
      mm/slub: Fix backtrace of objects to handle redzone adjustment
      mm/slub: Add Support for free path information of an object

Paul E. McKenney (47):
      doc: Fix statement of RCU's memory-ordering requirements
      tools/rcu: Add drgn script to dump number of RCU callbacks
      rcu-tasks: Add block comment laying out RCU Tasks design
      rcu-tasks: Add block comment laying out RCU Rude design
      torture: Fix remaining erroneous torture.sh instance of $*
      torture: Add "scenarios" option to kvm.sh --dryrun parameter
      torture: Make kvm-again.sh use "scenarios" rather than "batches" file
      refscale: Allow CPU hotplug to be enabled
      rcuscale: Allow CPU hotplug to be enabled
      torture: Add kvm-remote.sh script for distributed rcutorture test runs
      refscale: Add acqrel, lock, and lock-irq
      rcutorture: Abstract read-lock-held checks
      torture: Fix grace-period rate output
      torture: Abstract end-of-run summary
      torture: Make kvm.sh use abstracted kvm-end-run-stats.sh
      torture:  Make the build machine control N in "make -jN"
      torture: Make kvm-find-errors.sh account for kvm-remote.sh
      rcutorture: Judge RCU priority boosting on grace periods, not callbacks
      torture:  Set kvm.sh language to English
      rcutorture: Delay-based false positives for RCU priority boosting tests
      rcutorture: Consolidate rcu_torture_boost() timing and statistics
      rcutorture: Make rcu_torture_boost_failed() check for GP end
      rcutorture: Add BUSTED-BOOST to test RCU priority boosting tests
      rcutorture: Forgive RCU boost failures when CPUs don't pass through QS
      rcutorture: Don't count CPU-stalled time against priority boosting
      torture: Make kvm-remote.sh account for network failure in pathname checks
      torture: Don't cap remote runs by build-system number of CPUs
      rcutorture: Move mem_dump_obj() tests into separate function
      rcu: Remove the unused rcu_irq_exit_preempt() function
      rcu: Invoke rcu_spawn_core_kthreads() from rcu_spawn_gp_kthread()
      rcu: Add ->rt_priority and ->gp_start to show_rcu_gp_kthreads() output
      rcu: Add ->gp_max to show_rcu_gp_kthreads() output
      lockdep: Explicitly flag likely false-positive report
      rcu: Reject RCU_LOCKDEP_WARN() false positives
      rcu: Add quiescent states and boost states to show_rcu_gp_kthreads() output
      rcu: Make RCU priority boosting work on single-CPU rcu_node structures
      rcu: Make show_rcu_gp_kthreads() dump rcu_node structures blocking GP
      rcu: Restrict RCU_STRICT_GRACE_PERIOD to at most four CPUs
      rcu: Make rcu_gp_cleanup() be noinline for tracing
      rcu: Point to documentation of ordering guarantees
      rcu: Don't penalize priority boosting when there is nothing to boost
      rcu: Create an unrcu_pointer() to remove __rcu from a pointer
      rcu: Improve comments describing RCU read-side critical sections
      rcu: Remove obsolete rcu_read_unlock() deadlock commentary
      rcu-tasks: Make ksoftirqd provide RCU Tasks quiescent states
      tasks-rcu: Make show_rcu_tasks_gp_kthreads() be static inline
      Merge branches 'bitmaprange.2021.05.10c', 'doc.2021.05.10c', 'fixes.2021.05.13a', 'kvfree_rcu.2021.05.10c', 'mmdumpobj.2021.05.10c', 'nocb.2021.05.12a', 'srcu.2021.05.12a', 'tasks.2021.05.18a' and 'torture.2021.05.10c' into HEAD

Rolf Eike Beer (1):
      rcu: Fix typo in comment: kthead -> kthread

Uladzislau Rezki (Sony) (6):
      kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
      kvfree_rcu: Add a bulk-list check when a scheduler is run
      kvfree_rcu: Update "monitor_todo" once a batch is started
      kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant
      kvfree_rcu: Fix comments according to current code
      kvfree_rcu: Refactor kfree_rcu_monitor()

Yury Norov (2):
      bitmap_parse: Support 'all' semantics
      rcu/tree_plugin: Don't handle the case of 'all' CPU range

Zhang Qiang (1):
      kvfree_rcu: Release a page cache under memory pressure

Zhouyi Zhou (1):
      rcu: Improve tree.c comments and add code cleanups

 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |   6 +-
 Documentation/admin-guide/kernel-parameters.rst    |   5 +
 Documentation/admin-guide/kernel-parameters.txt    |   5 +
 include/linux/rcupdate.h                           |  84 +++---
 include/linux/rcutiny.h                            |   1 -
 include/linux/rcutree.h                            |   1 -
 include/linux/srcu.h                               |   6 +
 include/linux/srcutree.h                           |   2 -
 include/linux/timer.h                              |   2 -
 include/trace/events/rcu.h                         |   1 +
 init/main.c                                        |   2 +
 kernel/locking/lockdep.c                           |   6 +-
 kernel/rcu/Kconfig.debug                           |   2 +-
 kernel/rcu/rcu.h                                   |  14 +-
 kernel/rcu/rcutorture.c                            | 315 +++++++++++----------
 kernel/rcu/refscale.c                              | 109 ++++++-
 kernel/rcu/srcutree.c                              |  28 +-
 kernel/rcu/sync.c                                  |   4 +-
 kernel/rcu/tasks.h                                 |  58 +++-
 kernel/rcu/tiny.c                                  |   1 -
 kernel/rcu/tree.c                                  | 313 +++++++++++---------
 kernel/rcu/tree.h                                  |  14 +-
 kernel/rcu/tree_plugin.h                           | 239 ++++++++--------
 kernel/rcu/tree_stall.h                            |  84 +++++-
 kernel/rcu/update.c                                |   8 +-
 kernel/time/timer.c                                |  14 -
 lib/bitmap.c                                       |   9 +
 lib/test_bitmap.c                                  |   7 +
 mm/oom_kill.c                                      |   2 +-
 mm/slab.h                                          |   1 +
 mm/slab_common.c                                   |  12 +-
 mm/slub.c                                          |   8 +
 mm/util.c                                          |   2 +-
 tools/rcu/rcu-cbs.py                               |  46 +++
 .../testing/selftests/rcutorture/bin/kvm-again.sh  |  33 +--
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |   6 +-
 .../selftests/rcutorture/bin/kvm-end-run-stats.sh  |  40 +++
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   2 +-
 .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |   2 +-
 .../testing/selftests/rcutorture/bin/kvm-remote.sh | 249 ++++++++++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  61 ++--
 tools/testing/selftests/rcutorture/bin/torture.sh  |   2 +-
 .../selftests/rcutorture/configs/rcu/BUSTED-BOOST  |  17 ++
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot       |   8 +
 .../selftests/rcutorture/configs/rcuscale/TREE     |   2 +-
 .../selftests/rcutorture/configs/rcuscale/TREE54   |   2 +-
 .../rcutorture/configs/refscale/NOPREEMPT          |   2 +-
 .../selftests/rcutorture/configs/refscale/PREEMPT  |   2 +-
 .../rcutorture/formal/srcu-cbmc/src/locks.h        |   2 +-
 49 files changed, 1265 insertions(+), 576 deletions(-)
 create mode 100644 tools/rcu/rcu-cbs.py
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-remote.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
