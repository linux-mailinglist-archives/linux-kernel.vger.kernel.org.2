Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BD335075F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhCaT35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235186AbhCaT3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:29:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B96BD6101E;
        Wed, 31 Mar 2021 19:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617218974;
        bh=9sAVjwBmKE4uhXFujIgjGyJ/OhEwLIAmVtG3HLcxpLU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=NwzQ+qPtujeNxYDbLl8CisrIdHjhpdarlbW81Qwl+j9upLhjPWDvJHtjjV24TmHmG
         Lulo4+75gN0eIjsgnOoT8XZIxrDLK7IF6QTA2o+H/v8i3Y0wMPpl8TES2Jqq+jyuzp
         LZ8JaKhF9z0fB3N5m3mN8pHF0LHOYT/++288/uo+RjGwHMBR85jtCfCScD0NV96cpp
         6FlnuVehrSlDmRyZeKwyQyc4bFJ+2yWiMr+2xLWrQsMMxZ7srDZbtgVThCpnzusbhN
         jXjPYS5+osuCmJiBJ9lS9iO1n4vfXChQ4Cfl31GfE6Hajw6/6dL9NlycY2+oHXFI6S
         iMSot47f3s6cA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 77AF9352281B; Wed, 31 Mar 2021 12:29:34 -0700 (PDT)
Date:   Wed, 31 Mar 2021 12:29:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com, elver@google.com,
        frederic@kernel.org, jiapeng.chong@linux.alibaba.com,
        lukas.bulwahn@gmail.com, mchehab+huawei@kernel.org,
        neeraju@codeaurora.org, paul.gortmaker@windriver.com,
        sangmoon.kim@samsung.com, stephenzhangzsd@gmail.com,
        urezki@gmail.com, zhouzhouyi@gmail.com, tglx@linutronix.de
Subject: [GIT PULL tip/core/rcu] RCU, LKMM, and KCSAN commits for v5.13
Message-ID: <20210331192934.GA8127@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo!

This pull request contains changes for RCU, KCSAN, and LKMM.  You can
pull the entire group using branch for-mingo.  Or, if you prefer, you
can pull them separately, using for-mingo-rcu to pull the RCU changes,
for-mingo-kcsan to pull the KCSAN changes, and for-mingo-lkmm to pull
the LKMM changes.

The changes are as follows:

1.	RCU updates (for-mingo-rcu):

	a.	Bitmap support for "N" as alias for last bit, courtesy
		of Paul Gortmaker.  This series is used by rcu and
		rcutorture, and the lib/bitmap.c portions have appropriate
		reviews and acks.
		https://lore.kernel.org/lkml/20210303235526.GA21868@paulmck-ThinkPad-P72/

	b.	Miscellaneous fixes.
		https://lore.kernel.org/lkml/20210303235958.GA22373@paulmck-ThinkPad-P72/

	c.	kvfree_rcu updates, courtesy of Uladzislau Rezki.
		https://lore.kernel.org/lkml/20210304001044.GA22871@paulmck-ThinkPad-P72/

	d.	mm_dump_obj() updates.  One of these is to mm, but is suggested by
		Andrew Morton.
		https://lore.kernel.org/linux-mm/20210304001623.GA23196@paulmck-ThinkPad-P72/

	e.	RCU callback offloading updates, courtesy of Frederic
		Weisbecker and Jiapeng Chong.
		https://lore.kernel.org/lkml/20210304002225.GA23492@paulmck-ThinkPad-P72/

	f.	Polling RCU grace-period interfaces.
		https://lore.kernel.org/lkml/20210304002605.GA23785@paulmck-ThinkPad-P72/

	g.	Realtime-related RCU updates.
		https://lore.kernel.org/lkml/20210304002919.GA24003@paulmck-ThinkPad-P72/

	h.	Tasks-RCU updates.
		https://lore.kernel.org/lkml/20210304003226.GA24261@paulmck-ThinkPad-P72/

	i.	Torture-test updates.
		https://lore.kernel.org/lkml/20210304003431.GA24413@paulmck-ThinkPad-P72/

	j.	Torture-test scripting updates.
		https://lore.kernel.org/lkml/20210304003750.GA24696@paulmck-ThinkPad-P72/

2.	Kernel concurrency sanitizer (KCSAN) updates from Marco Elver.
	https://lore.kernel.org/lkml/20210304004022.GA25013@paulmck-ThinkPad-P72/

3.	Linux-kernel memory model (LKMM) updates.
	https://lore.kernel.org/lkml/20210304004438.GA25271@paulmck-ThinkPad-P72/

All of the commits in this pull request have been subjected to subjected
to the kbuild test robot and -next testing, and are available in the
git repository based on v5.12-rc2 at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to dd44ee94db05b80fef1469155c374caad58d8a2e:

  Merge branch 'lkmm.2021.03.15a' into HEAD (2021-03-24 17:21:26 -0700)

----------------------------------------------------------------
Akira Yokosawa (2):
      rculist: Replace reference to atomic_ops.rst
      tools/memory-model: Remove reference to atomic_ops.rst

Frederic Weisbecker (11):
      rcu: Remove superfluous rdp fetch
      rcu/nocb: Detect unsafe checks for offloaded rdp
      rcu/nocb: Comment the reason behind BH disablement on batch processing
      rcu/nocb: Forbid NOCB toggling on offline CPUs
      rcu/nocb: Avoid confusing double write of rdp->nocb_cb_sleep
      rcu/nocb: Only (re-)initialize segcblist when needed on CPU up
      rcu/nocb: Rename nocb_gp_update_state to nocb_gp_update_state_deoffloading
      rcu/nocb: Fix missed nocb_timer requeue
      rcu/nocb: Disable bypass when CPU isn't completely offloaded
      rcu/nocb: Remove stale comment above rcu_segcblist_offload()
      rcu/nocb: Move trace_rcu_nocb_wake() calls outside nocb_lock when possible

Jiapeng Chong (1):
      rcu: Make nocb_nobypass_lim_per_jiffy static

Lukas Bulwahn (1):
      rcu-tasks: Rectify kernel-doc for struct rcu_tasks

Marco Elver (4):
      kcsan, debugfs: Move debugfs file creation out of early init
      kcsan: Make test follow KUnit style recommendations
      kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests
      kcsan: Add missing license and copyright headers

Mauro Carvalho Chehab (2):
      rcu: Fix kfree_rcu() docbook errors
      doc: Update rcu_dereference.rst reference

Neeraj Upadhyay (1):
      rcu: Fix CPU-offline trace in rcutree_dying_cpu

Paul E. McKenney (49):
      rcutorture: Use "all" and "N" in "nohz_full" and "rcu_nocbs"
      kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()
      kvfree_rcu: Make krc_this_cpu_unlock() use raw_spin_unlock_irqrestore()
      mm: Don't build mm_dump_obj() on CONFIG_PRINTK=n kernels
      rcutorture: Add crude tests for mem_dump_obj()
      rcu: Expedite deboost in case of deferred quiescent state
      rcutorture: Make TREE03 use real-time tree.use_softirq setting
      rcutorture: Fix testing of RCU priority boosting
      rcu: Make rcu_read_unlock_special() expedite strict grace periods
      torture: Make jitter.sh handle large systems
      rcu-tasks: Add block comment laying out RCU Tasks Trace design
      torturescript: Don't rerun failed rcutorture builds
      torture: Allow 1G of memory for torture.sh kvfree testing
      torture: Provide bare-metal modprobe-based advice
      torture: Improve readability of the testid.txt file
      rcuscale: Disable verbose torture-test output
      refscale: Disable verbose torture-test output
      torture: Move build/run synchronization files into scenario directories
      torture: Use file-based protocol to mark batch's runs complete
      torture: Use "jittering" file to control jitter.sh execution
      torture: Eliminate jitter_pids file
      torture: Reverse jittering and duration parameters for jitter.sh
      softirq: Don't try waking ksoftirqd before it has been spawned
      docs: Correctly spell Stephen Hemminger's name
      rcu: Add explicit barrier() to __rcu_read_unlock()
      tools/memory-model: Add access-marking documentation
      rcu: Provide polling interfaces for Tree RCU grace periods
      torture: Abstract jitter.sh start/stop into scripts
      torture: Record TORTURE_KCONFIG_GDB_ARG in qemu-cmd
      torture: Extract kvm-test-1-run-qemu.sh from kvm-test-1-run.sh
      torture: Record jitter start/stop commands
      torture: Record kvm-test-1-run.sh and kvm-test-1-run-qemu.sh PIDs
      torture: Remove no-mpstat error message
      torture: Rename SRCU-t and SRCU-u to avoid lowercase characters
      torture: Make upper-case-only no-dot no-slash scenario names official
      torture: De-capitalize TORTURE_SUITE
      torture: Create a "batches" file for build reuse
      torture: Add kvm-again.sh to rerun a previous torture-test
      torture: Add --duration argument to kvm-again.sh
      torture: Make kvm-transform.sh update jitter commands
      torture: Make TORTURE_TRUST_MAKE available in kvm-again.sh environment
      torture: Print proper vmlinux path for kvm-again.sh runs
      torture: Consolidate qemu-cmd duration editing into kvm-transform.sh
      torture: Fix kvm.sh --datestamp regex check
      rcu: Provide polling interfaces for Tiny RCU grace periods
      rcutorture: Test start_poll_synchronize_rcu() and poll_state_synchronize_rcu()
      Merge branches 'bitmaprange.2021.03.08a', 'fixes.2021.03.15a', 'kvfree_rcu.2021.03.08a', 'mmdumpobj.2021.03.08a', 'nocb.2021.03.15a', 'poll.2021.03.24a', 'rt.2021.03.08a', 'tasks.2021.03.08a', 'torture.2021.03.08a' and 'torturescript.2021.03.22a' into HEAD
      Merge branch 'kcsan.2021.03.08a' into HEAD
      Merge branch 'lkmm.2021.03.15a' into HEAD

Paul Gortmaker (8):
      lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
      lib: test_bitmap: add tests to trigger ERANGE case.
      lib: test_bitmap: add more start-end:offset/len tests
      lib: bitmap: fold nbits into region struct
      lib: bitmap: move ERANGE check from set_region to check_region
      lib: bitmap: support "N" as an alias for size of bitmap
      lib: test_bitmap: add tests for "N" alias
      rcu: deprecate "all" option to rcu_nocbs=

Sangmoon Kim (1):
      rcu/tree: Add a trace event for RCU CPU stall warnings

Stephen Zhang (2):
      torture: Replace torture_init_begin string with %s
      rcutorture: Replace rcu_torture_stall string with %s

Uladzislau Rezki (Sony) (4):
      kvfree_rcu: Directly allocate page for single-argument case
      kvfree_rcu: Replace __GFP_RETRY_MAYFAIL by __GFP_NORETRY
      kvfree_rcu: Use same set of GFP flags as does single-argument
      rcuscale: Add kfree_rcu() single-argument scale test

Zhouyi Zhou (1):
      rcu: Remove spurious instrumentation_end() in rcu_nmi_enter()

 Documentation/RCU/RTFP.txt                         |   2 +-
 Documentation/admin-guide/kernel-parameters.rst    |   7 +
 Documentation/admin-guide/kernel-parameters.txt    |  16 +-
 Documentation/dev-tools/kcsan.rst                  |   3 +
 include/linux/kcsan-checks.h                       |   6 +
 include/linux/kcsan.h                              |   7 +
 include/linux/mm.h                                 |   4 +
 include/linux/rcu_segcblist.h                      |   7 +-
 include/linux/rculist_nulls.h                      |   2 +-
 include/linux/rcupdate.h                           |   2 +-
 include/linux/rcutiny.h                            |   7 +-
 include/linux/rcutree.h                            |   2 +
 include/linux/slab.h                               |   2 +
 include/linux/vmalloc.h                            |   2 +-
 include/trace/events/rcu.h                         |  28 ++
 kernel/kcsan/Makefile                              |   4 +-
 kernel/kcsan/atomic.h                              |   5 +
 kernel/kcsan/core.c                                |   7 +-
 kernel/kcsan/debugfs.c                             |   9 +-
 kernel/kcsan/encoding.h                            |   5 +
 kernel/kcsan/kcsan.h                               |   8 +-
 kernel/kcsan/{kcsan-test.c => kcsan_test.c}        | 118 +++--
 kernel/kcsan/report.c                              |   5 +
 kernel/kcsan/selftest.c                            |   5 +
 kernel/rcu/rcu_segcblist.c                         |   3 +-
 kernel/rcu/rcuscale.c                              |  15 +-
 kernel/rcu/rcutorture.c                            |  93 ++--
 kernel/rcu/tasks.h                                 |  40 +-
 kernel/rcu/tiny.c                                  |  40 ++
 kernel/rcu/tree.c                                  | 169 ++++++--
 kernel/rcu/tree_exp.h                              |   1 +
 kernel/rcu/tree_plugin.h                           | 252 +++++++----
 kernel/rcu/tree_stall.h                            |   2 +
 kernel/softirq.c                                   |   2 +-
 kernel/torture.c                                   |   6 +-
 lib/Kconfig.kcsan                                  |   5 +-
 lib/bitmap.c                                       |  49 ++-
 lib/test_bitmap.c                                  |  46 +-
 mm/slab.c                                          |   2 +
 mm/slab.h                                          |   2 +
 mm/slab_common.c                                   |   4 +
 mm/slob.c                                          |   2 +
 mm/slub.c                                          |   2 +
 mm/util.c                                          |   3 +
 mm/vmalloc.c                                       |   2 +
 .../memory-model/Documentation/access-marking.txt  | 479 +++++++++++++++++++++
 tools/memory-model/Documentation/glossary.txt      |   2 +-
 tools/memory-model/Documentation/simple.txt        |   1 -
 tools/testing/selftests/rcutorture/bin/cpus2use.sh |   1 -
 tools/testing/selftests/rcutorture/bin/jitter.sh   |  20 +-
 .../selftests/rcutorture/bin/jitterstart.sh        |  37 ++
 .../testing/selftests/rcutorture/bin/jitterstop.sh |  23 +
 .../testing/selftests/rcutorture/bin/kvm-again.sh  | 199 +++++++++
 .../selftests/rcutorture/bin/kvm-recheck.sh        |   2 +-
 .../rcutorture/bin/kvm-test-1-run-batch.sh         |  67 +++
 .../rcutorture/bin/kvm-test-1-run-qemu.sh          | 176 ++++++++
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     | 218 +++-------
 .../selftests/rcutorture/bin/kvm-transform.sh      |  54 ++-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  98 +++--
 tools/testing/selftests/rcutorture/bin/torture.sh  |   2 +-
 .../selftests/rcutorture/configs/rcu/CFLIST        |   4 +-
 .../rcutorture/configs/rcu/{SRCU-t => SRCU-T}      |   0
 .../configs/rcu/{SRCU-t.boot => SRCU-T.boot}       |   0
 .../rcutorture/configs/rcu/{SRCU-u => SRCU-U}      |   0
 .../configs/rcu/{SRCU-u.boot => SRCU-U.boot}       |   0
 .../selftests/rcutorture/configs/rcu/TREE03.boot   |   1 +
 .../selftests/rcutorture/configs/rcu/TREE04.boot   |   2 +-
 .../selftests/rcutorture/configs/rcu/TREE08.boot   |   2 +-
 .../rcutorture/configs/rcuscale/ver_functions.sh   |   2 +-
 .../rcutorture/configs/refscale/ver_functions.sh   |   2 +-
 70 files changed, 1895 insertions(+), 500 deletions(-)
 rename kernel/kcsan/{kcsan-test.c => kcsan_test.c} (94%)
 create mode 100644 tools/memory-model/Documentation/access-marking.txt
 create mode 100644 tools/testing/selftests/rcutorture/bin/jitterstart.sh
 create mode 100644 tools/testing/selftests/rcutorture/bin/jitterstop.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-again.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-t => SRCU-T} (100%)
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-t.boot => SRCU-T.boot} (100%)
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-u => SRCU-U} (100%)
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-u.boot => SRCU-U.boot} (100%)
