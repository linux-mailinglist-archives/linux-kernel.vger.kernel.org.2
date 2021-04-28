Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6248A36D44D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhD1I46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1I44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:56:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C07FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:56:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x5so11880538wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iozrnap4oKqKaumOXFJYUpM8VMNqupp565xoLnjxJNI=;
        b=FmUvIG0ySoGT/UH54Xh1aa03FCRYYEfvws69DoOoTrjritHBy+hLDlAiNhfEJ3atT2
         dqzCuThohOEje71gbTPCXHezkED6O2lXnO+40ARLlxKA8QEaLWw360rnxfsqIT76L6Xr
         oiCaLT+wZqN2btJzibl9YgFrsoFq2EmsDN/chlp99tokBIx3LQYK58rdNdQP+jvyNrN6
         wr+n1WUyXk5K2WR7DaGhchMEKWIbME0uQ6rjoTxrxu4R+SwG7jk8U0WcsmSoad4B75G3
         CE2ESllDpPl629TfwmPJoFmBomzJUS/IM5UxO4IlrdGcsMdyUiMs73fnoWZlTwKbXhYB
         mZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=iozrnap4oKqKaumOXFJYUpM8VMNqupp565xoLnjxJNI=;
        b=nz+6Bdk/I/ETnvquu7hT2stHw/KttOSLBtb37KcnBH/6a6+6rqxxDNc4r6Uoj5jvve
         PSxcBvB1k2U5o+F5x+WMu/rU7HyJPgAa5d/IEHpkylHRICcqfudfenyMjxVzn6pcJTOM
         P0qX9LJg32wv8U8PbXimGyMahVmMsEiMtNcbOZRXEyXule4rotLo6KdPEpgB/TfJAJw8
         kVMCWi1yggbUsCFAqKYk19/NJ9RTSGdX5H9uCp0L5nfzZl+/pLYGYF4stFLXPxNhfUcI
         TVQF7P4Uvw5AVPv9YJPhph1+982ZeWlUtSEljR8rb4lOU1FHtVEuYs67FLD30BvqWP8P
         MQsQ==
X-Gm-Message-State: AOAM530mlIF2drBX6XNdb7XwuGSG+nobMw/aeu+8fPCKWLaTglRa2mT8
        nbrjN72iX61kfhJI5QDaQ+4=
X-Google-Smtp-Source: ABdhPJxThvzjjV/+sC3ujtjMRMTaZmRZX0tT8o+tTZLjHLJg8jektrJn680UMnlCUbEzWvrgkgbgyA==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr7348568wrw.49.1619600169320;
        Wed, 28 Apr 2021 01:56:09 -0700 (PDT)
Received: from gmail.com (2E8BA22B.catv.pool.telekom.hu. [46.139.162.43])
        by smtp.gmail.com with ESMTPSA id t206sm3020845wmb.11.2021.04.28.01.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 01:56:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 28 Apr 2021 10:56:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler updates for v5.13
Message-ID: <20210428085606.GA339713@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-04-28

   # HEAD: 2ea46c6fc9452ac100ad907b051d797225847e33 cpumask/hotplug: Fix cpu_dying() state tracking

Scheduler updates for this cycle are:

 - Clean up SCHED_DEBUG: move the decades old mess of sysctl, procfs and debugfs interfaces
   to a unified debugfs interface.

 - Signals: Allow caching one sigqueue object per task, to improve performance & latencies.

 - Improve newidle_balance() irq-off latencies on systems with a large number of CPU cgroups.

 - Improve energy-aware scheduling

 - Improve the PELT metrics for certain workloads

 - Reintroduce select_idle_smt() to improve load-balancing locality - but without the previous
   regressions

 - Add 'scheduler latency debugging': warn after long periods of pending need_resched. This
   is an opt-in feature that requires the enabling of the LATENCY_WARN scheduler feature,
   or the use of the resched_latency_warn_ms=xx boot parameter.

 - CPU hotplug fixes for HP-rollback, and for the 'fail' interface. Fix remaining
   balance_push() vs. hotplug holes/races

 - PSI fixes, plus allow /proc/pressure/ files to be written by CAP_SYS_RESOURCE tasks as well

 - Fix/improve various load-balancing corner cases vs. capacity margins

 - Fix sched topology on systems with NUMA diameter of 3 or above

 - Fix PF_KTHREAD vs to_kthread() race

 - Minor rseq optimizations

 - Misc cleanups, optimizations, fixes and smaller updates

 Thanks,

	Ingo

------------------>
Aubrey Li (1):
      sched/fair: Reduce long-tail newly idle balance cost

Barry Song (3):
      sched/topology: fix the issue groups don't span domain->span for NUMA diameter > 2
      sched/fair: Optimize test_idle_cores() for !SMT
      sched/topology: Remove redundant cpumask_and() in init_overlap_sched_group()

Charan Teja Reddy (1):
      sched,psi: Handle potential task count underflow bugs more gracefully

Chengming Zhou (3):
      psi: Add PSI_CPU_FULL state
      psi: Use ONCPU state tracking machinery to detect reclaim
      psi: Optimize task switch inside shared cgroups

Clement Courbet (1):
      sched: Optimize __calc_delta()

Edmundo Carmona Antoranz (1):
      sched: Remove unnecessary variable from schedule_tail()

Eric Dumazet (3):
      rseq: Optimize rseq_update_cpu_id()
      rseq: Remove redundant access_ok()
      rseq: Optimise rseq_get_rseq_cs() and clear_rseq_cs()

Ingo Molnar (1):
      sched: Fix various typos

Johannes Weiner (1):
      psi: Pressure states are unlikely

Josh Hunt (1):
      psi: allow unprivileged users with CAP_SYS_RESOURCE to write psi files

Lingutla Chandrasekhar (1):
      sched/fair: Ignore percpu threads for imbalance pulls

Mel Gorman (1):
      sched/numa: Allow runtime enabling/disabling of NUMA balance without SCHED_DEBUG

Paul Turner (1):
      sched: Warn on long periods of pending need_resched

Peter Zijlstra (14):
      cpumask: Make cpu_{online,possible,present,active}() inline
      cpumask: Introduce DYING mask
      sched: Use cpu_dying() to fix balance_push vs hotplug-rollback
      sched: Remove sched_schedstats sysctl out from under SCHED_DEBUG
      sched: Don't make LATENCYTOP select SCHED_DEBUG
      sched: Move SCHED_DEBUG sysctl to debugfs
      sched,preempt: Move preempt_dynamic to debug.c
      debugfs: Implement debugfs_create_str()
      sched,debug: Convert sysctl sched_domains to debugfs
      sched: Move /proc/sched_debug to debugfs
      sched,fair: Alternative sched_slice()
      sched/debug: Rename the sched_debug parameter to sched_verbose
      kthread: Fix PF_KTHREAD vs to_kthread() race
      cpumask/hotplug: Fix cpu_dying() state tracking

Piotr Figiel (1):
      rseq, ptrace: Add PTRACE_GET_RSEQ_CONFIGURATION request

Rasmus Villemoes (2):
      sched/core: Stop using magic values in sched_dynamic_mode()
      sched/core: Use -EINVAL in sched_dynamic_mode()

Rik van Riel (1):
      sched/fair: Bring back select_idle_smt(), but differently

Sebastian Andrzej Siewior (1):
      kcov: Remove kcov include from sched.h and move it to its users.

Shakeel Butt (1):
      psi: Reduce calls to sched_clock() in psi

Thomas Gleixner (2):
      signal: Hand SIGQUEUE_PREALLOC flag to __sigqueue_alloc()
      signal: Allow tasks to cache one sigqueue struct

Valentin Schneider (5):
      sched: Simplify migration_cpu_stop()
      sched/fair: Fix shift-out-of-bounds in load_balance()
      stop_machine: Add caller debug info to queue_stop_cpus_work
      sched/fair: Clean up active balance nr_balance_failed trickery
      sched/fair: Introduce a CPU capacity comparison helper

Vincent Donnefort (6):
      sched/fair: Fix task utilization accountability in compute_energy()
      sched/fair: use lsub_positive in cpu_util_next()
      sched/pelt: Fix task util_est update filtering
      cpu/hotplug: Allowing to reset fail injection
      cpu/hotplug: CPUHP_BRINGUP_CPU failure exception
      cpu/hotplug: Add cpuhp_invoke_callback_range()

Vincent Guittot (7):
      sched/fair: Remove update of blocked load from newidle_balance
      sched/fair: Remove unused return of _nohz_idle_balance
      sched/fair: Remove unused parameter of update_nohz_stats
      sched/fair: Merge for each idle cpu loop of ILB
      sched/fair: Reorder newidle_balance pulled_task tests
      sched/fair: Trigger the update of blocked load on newly idle cpu
      sched/fair: Reduce the window for duplicated update

Waiman Long (1):
      sched/debug: Fix cgroup_path[] serialization

YueHaibing (1):
      sched/fair: Move update_nohz_stats() to the CONFIG_NO_HZ_COMMON block to simplify the code & fix an unused function warning


 Documentation/admin-guide/kernel-parameters.txt |   2 +-
 Documentation/scheduler/sched-domains.rst       |  10 +-
 drivers/usb/usbip/usbip_common.h                |   1 +
 fs/debugfs/file.c                               |  91 +++++
 include/linux/cpumask.h                         | 117 +++++--
 include/linux/debugfs.h                         |  17 +
 include/linux/kcov.h                            |   1 +
 include/linux/psi.h                             |   1 -
 include/linux/psi_types.h                       |   3 +-
 include/linux/sched.h                           |   4 +-
 include/linux/sched/sysctl.h                    |   9 +-
 include/linux/signal.h                          |   1 +
 include/uapi/linux/ptrace.h                     |  10 +
 kernel/cpu.c                                    | 210 ++++++++----
 kernel/exit.c                                   |   1 +
 kernel/fork.c                                   |   1 +
 kernel/kthread.c                                |  33 +-
 kernel/ptrace.c                                 |  25 ++
 kernel/rseq.c                                   |  29 +-
 kernel/sched/clock.c                            |   2 +-
 kernel/sched/core.c                             | 217 ++++++------
 kernel/sched/cpuacct.c                          |   2 +-
 kernel/sched/cpufreq_schedutil.c                |   2 +-
 kernel/sched/cpupri.c                           |   4 +-
 kernel/sched/cputime.c                          |   2 +-
 kernel/sched/deadline.c                         |  12 +-
 kernel/sched/debug.c                            | 435 +++++++++++++-----------
 kernel/sched/fair.c                             | 380 +++++++++++----------
 kernel/sched/features.h                         |   7 +-
 kernel/sched/idle.c                             |  10 +-
 kernel/sched/loadavg.c                          |   2 +-
 kernel/sched/pelt.c                             |   2 +-
 kernel/sched/pelt.h                             |   2 +-
 kernel/sched/psi.c                              | 164 +++++----
 kernel/sched/rt.c                               |   6 +-
 kernel/sched/sched.h                            |  59 +++-
 kernel/sched/stats.c                            |   2 +-
 kernel/sched/stats.h                            |  37 +-
 kernel/sched/topology.c                         | 113 +++---
 kernel/signal.c                                 |  59 +++-
 kernel/stop_machine.c                           |   1 +
 kernel/sysctl.c                                 |  94 -----
 lib/Kconfig.debug                               |   1 -
 net/core/skbuff.c                               |   1 +
 net/mac80211/iface.c                            |   1 +
 net/mac80211/rx.c                               |   1 +
 46 files changed, 1284 insertions(+), 900 deletions(-)
