Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9636D2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhD1HLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhD1HLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:11:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:10:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so3996944wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=39KLklPk2f7ZKM5WwwJ2jnknkW3mQiztBviJIH6u8j8=;
        b=aU4flgJsktxvQS4kkPMNdyFtf31h8zEfXfIi/Sr59VT1tpEal5wnFgZ8K9JJnLAYXo
         hoP2yMAJxNyshTWI8kU2KNoOJ1+HMlnK2BEcE7ng7YfIozp35bDHXHdfVFbHXdmU+dzN
         jpwTIUe7gWFO8ZtyVTgjyBOoSKBgJafWXQOcmGWNyEJeH+RacjqhpWomQpSIdwlZ3T3p
         lYHOYIahUZFuceoYDquRrF53BJubYJHE6auFxGk44m/SYP1tvtEanyuuomkPqY9qjOTP
         ERceK48EfiaX0aa+W6hqrrfAUKgr8VyHUN4x74ERYg4ScQmYwiBJeaxCXSHRV9wTHeRz
         ItBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=39KLklPk2f7ZKM5WwwJ2jnknkW3mQiztBviJIH6u8j8=;
        b=mNYnLPD8t4UWw30IFZjF9Rtz/CvCHXnJ9em477FPae5+QaL3yZmOLt1CRJ1rMQxHRJ
         1umDyFpljigon6Pp1RRNm5Wjt67+nRbBazF/r5pFrMdsS6QlYKgQw0T4kmoBTG+zWTu5
         hFv9hqexID3OACh5qr2T1ldpqa+qyJta/bTXcbu526RIsHRhT6avu4MSTUKU+CbJexp3
         UCVxNZ2it1Kuc+nQgwfpaiX42Fc6PiE+0QIFQZDWH+VcC+WjiOQOErCVXoJeI3ABJvdr
         xfjBetiex9BrSMjB8GqM96yY2NNsD8s77bw8mgBt6HWQ0tNwnFWLQ0pbItdmuv6O4T5x
         oZAg==
X-Gm-Message-State: AOAM532wIqhmvuOdH/Xft6acLeeDykgyNic7UeN+jLANwkLOkC/p99/r
        yVOvZnm4FjvwrmAV4TuUEbs=
X-Google-Smtp-Source: ABdhPJzTs+ICS5UFeW1X9XLAryRdi47XiHMej6sgwIT9IxoKqRswVlrniSdD5ZfkfUpSIroNFAJCoQ==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr29283974wmj.97.1619593835377;
        Wed, 28 Apr 2021 00:10:35 -0700 (PDT)
Received: from gmail.com (2E8BA22B.catv.pool.telekom.hu. [46.139.162.43])
        by smtp.gmail.com with ESMTPSA id a15sm8441459wrx.9.2021.04.28.00.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:10:34 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 28 Apr 2021 09:10:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [GIT PULL] RCU changes for v5.13
Message-ID: <20210428071032.GA84588@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/rcu git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2021-04-28

   # HEAD: 120b566d1df22a0a4543ac0e8aef875c49dd2c21 Merge branch 'for-mingo-rcu' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

RCU changes for this cycle were:

 - Bitmap support for "N" as alias for last bit
 - kvfree_rcu updates
 - mm_dump_obj() updates.  (One of these is to mm, but was suggested by Andrew Morton.)
 - RCU callback offloading update
 - Polling RCU grace-period interfaces
 - Realtime-related RCU updates
 - Tasks-RCU updates
 - Torture-test updates
 - Torture-test scripting updates
 - Miscellaneous fixes

 Thanks,

	Ingo

------------------>
Akira Yokosawa (1):
      rculist: Replace reference to atomic_ops.rst

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

Mauro Carvalho Chehab (1):
      rcu: Fix kfree_rcu() docbook errors

Neeraj Upadhyay (1):
      rcu: Fix CPU-offline trace in rcutree_dying_cpu

Paul E. McKenney (45):
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
 include/linux/mm.h                                 |   4 +
 include/linux/rcu_segcblist.h                      |   7 +-
 include/linux/rculist_nulls.h                      |   2 +-
 include/linux/rcupdate.h                           |   2 +-
 include/linux/rcutiny.h                            |   7 +-
 include/linux/rcutree.h                            |   2 +
 include/linux/slab.h                               |   2 +
 include/linux/vmalloc.h                            |   2 +-
 include/trace/events/rcu.h                         |  28 +++
 kernel/rcu/rcu_segcblist.c                         |   3 +-
 kernel/rcu/rcuscale.c                              |  15 +-
 kernel/rcu/rcutorture.c                            |  93 +++++---
 kernel/rcu/tasks.h                                 |  40 +++-
 kernel/rcu/tiny.c                                  |  40 ++++
 kernel/rcu/tree.c                                  | 169 ++++++++++----
 kernel/rcu/tree_exp.h                              |   1 +
 kernel/rcu/tree_plugin.h                           | 252 ++++++++++++++-------
 kernel/rcu/tree_stall.h                            |   2 +
 kernel/softirq.c                                   |   2 +-
 kernel/torture.c                                   |   6 +-
 lib/bitmap.c                                       |  49 ++--
 lib/test_bitmap.c                                  |  46 +++-
 mm/slab.c                                          |   2 +
 mm/slab.h                                          |   2 +
 mm/slab_common.c                                   |   4 +
 mm/slob.c                                          |   2 +
 mm/slub.c                                          |   2 +
 mm/util.c                                          |   3 +
 mm/vmalloc.c                                       |   2 +
 tools/testing/selftests/rcutorture/bin/cpus2use.sh |   1 -
 tools/testing/selftests/rcutorture/bin/jitter.sh   |  20 +-
 .../selftests/rcutorture/bin/jitterstart.sh        |  37 +++
 .../testing/selftests/rcutorture/bin/jitterstop.sh |  23 ++
 .../testing/selftests/rcutorture/bin/kvm-again.sh  | 199 ++++++++++++++++
 .../selftests/rcutorture/bin/kvm-recheck.sh        |   2 +-
 .../rcutorture/bin/kvm-test-1-run-batch.sh         |  67 ++++++
 .../rcutorture/bin/kvm-test-1-run-qemu.sh          | 176 ++++++++++++++
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     | 218 ++++++------------
 .../selftests/rcutorture/bin/kvm-transform.sh      |  54 ++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  98 ++++----
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
 54 files changed, 1304 insertions(+), 422 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/bin/jitterstart.sh
 create mode 100644 tools/testing/selftests/rcutorture/bin/jitterstop.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-again.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-t => SRCU-T} (100%)
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-t.boot => SRCU-T.boot} (100%)
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-u => SRCU-U} (100%)
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-u.boot => SRCU-U.boot} (100%)
