Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEC53B5948
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhF1GyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1Gx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:53:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0A2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 23:51:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id c17so2165751ejk.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 23:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=na8wl/amQUQz+etLpG3iPJJYBM7QiPZpM9WHAB/HxB0=;
        b=TE8P8+JtqZPcPkTGgy5YLFgDmVlj+pNu/qLkBH67Zn6fsCl5C0gffxAzz1IDq+MK8Z
         VQnBdfPxjzHhtDs7LVwrBUz25uesGUk9dqU6YTw6IFQ6CAjT4G7c6gqAQ3Vcl97YoLkR
         UFEUR/dO0+C5cwXpcAECWxWLAcMltAlchZ4UqlTCnLAHVdwKX1gLz7vcxSqvrK9rKK0m
         g+cTnr/LSJoYc5jrv9sPCQg5cOfTnUylOM85DAdS5g/EYxCaRcBXAbTdi0fZKamsjqaU
         Xaatte6axJtELq6EqDBPizW840x07URlMQp5KlCBFfkwDssr0HgN08yJUkIkN46tryL7
         HSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=na8wl/amQUQz+etLpG3iPJJYBM7QiPZpM9WHAB/HxB0=;
        b=bRQvJsJs5RJ2q3Oe7eFaVw0BDyenhINJsqbYYl3fK912AOZNbLrBUDSjNiyPNpOMWB
         SiNqa9lcn20it6Ctm+qzOb9Cb+GpdBv6WKQTSPnntJakfShF+dlxM/IMG9LmW5HgWjm2
         Fx0oRo0ndjyiFXpiZzcjQKJ32iEdJL8ZIcBW9NPUwB4XvhZxe0fQOnsoVng1/VjkuBcM
         RNHNfLIXz7aFSZY9uCw486GvyQmJPiQypIv2lDz/fGzSw9DAF06Q/kiLIPF90dQ1ZXhl
         dsKNhRV4odWvjoeVFGlyl2kbjkqSFoRvExRl6xCvOr8nIhpqS8h69KxrcxowF7f7yq2P
         bwVw==
X-Gm-Message-State: AOAM531xoBvP1Qq57h+1M1ulcFE7VbXjb+yCBfLDc8BKD45BqopaRmM+
        A6PmOSOn93nBiCQH39J3flIYr8jKXxY=
X-Google-Smtp-Source: ABdhPJwyh3HFJGXTqfFD86qogZiAm2Ok+LTGY9kRfKL4Xj9R3llXwAtV/elUlmj5zp8mAWg/Q+OCEw==
X-Received: by 2002:a17:906:d8af:: with SMTP id qc15mr22865168ejb.488.1624863090263;
        Sun, 27 Jun 2021 23:51:30 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id i3sm5416067edk.37.2021.06.27.23.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 23:51:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 08:51:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler changes for v5.14
Message-ID: <YNlxcCpk4shGcPrU@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-06-28

   # HEAD: adf3c31e18b765ea24eba7b0c1efc076b8ee3d55 sched/doc: Update the CPU capacity asymmetry bits

Scheduler udpates for this cycle:

 - Changes to core scheduling facilities:

    - Add "Core Scheduling" via CONFIG_SCHED_CORE=y, which enables
      coordinated scheduling across SMT siblings. This is a much
      requested feature for cloud computing platforms, to allow
      the flexible utilization of SMT siblings, without exposing
      untrusted domains to information leaks & side channels, plus
      to ensure more deterministic computing performance on SMT
      systems used by heterogenous workloads.

      There's new prctls to set core scheduling groups, which
      allows more flexible management of workloads that can share
      siblings.

    - Fix task->state access anti-patterns that may result in missed
      wakeups and rename it to ->__state in the process to catch new
      abuses.

 - Load-balancing changes:

     - Tweak newidle_balance for fair-sched, to improve
       'memcache'-like workloads.

     - "Age" (decay) average idle time, to better track & improve workloads
       such as 'tbench'.

     - Fix & improve energy-aware (EAS) balancing logic & metrics.

     - Fix & improve the uclamp metrics.

     - Fix task migration (taskset) corner case on !CONFIG_CPUSET.

     - Fix RT and deadline utilization tracking across policy changes

     - Introduce a "burstable" CFS controller via cgroups, which allows
       bursty CPU-bound workloads to borrow a bit against their future
       quota to improve overall latencies & batching. Can be tweaked
       via /sys/fs/cgroup/cpu/<X>/cpu.cfs_burst_us.

     - Rework assymetric topology/capacity detection & handling.

 - Scheduler statistics & tooling:

     - Disable delayacct by default, but add a sysctl to enable
       it at runtime if tooling needs it. Use static keys and
       other optimizations to make it more palatable.

     - Use sched_clock() in delayacct, instead of ktime_get_ns().

 - Misc cleanups and fixes.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Alexey Dobriyan (4):
      sched: Make nr_running() return 32-bit value
      sched: Make nr_iowait() return 32-bit value
      sched: Make nr_iowait_cpu() return 32-bit value
      sched: Make multiple runqueue task counters 32-bit

Aubrey Li (1):
      sched: Migration changes for core scheduling

Beata Michalska (3):
      sched/core: Introduce SD_ASYM_CPUCAPACITY_FULL sched_domain flag
      sched/topology: Rework CPU capacity asymmetry detection
      sched/doc: Update the CPU capacity asymmetry bits

Chris Hyser (2):
      sched: prctl() core-scheduling interface
      kselftest: Add test for core sched prctl interface

Dietmar Eggemann (1):
      sched/fair: Return early from update_tg_cfs_load() if delta == 0

Eric Dumazet (1):
      sched/debug: Remove obsolete init_schedstats()

Frederic Weisbecker (1):
      sched: Stop PF_NO_SETAFFINITY from being inherited by various init system threads

Huaixin Chang (1):
      sched/fair: Introduce the burstable CFS controller

Ingo Molnar (1):
      sched: Fix leftover comment typos

Joel Fernandes (Google) (3):
      sched: Fix priority inversion of cookied task with sibling
      sched/fair: Snapshot the min_vruntime of CPUs on force idle
      Documentation: Add usecases, design and interface for core scheduling

Lukasz Luba (3):
      thermal/cpufreq_cooling: Update offline CPUs per-cpu thermal_pressure
      sched/fair: Take thermal pressure into account while estimating energy
      sched/cpufreq: Consider reduced CPU capacity in energy calculation

Masahiro Yamada (1):
      sched: Fix a stale comment in pick_next_task()

Mel Gorman (1):
      delayacct: Document task_delayacct sysctl

Odin Ugedal (1):
      sched/fair: Fix ascii art by relpacing tabs

Oleg Nesterov (1):
      sched/core: Remove the pointless BUG_ON(!task) from wake_up_q()

Paul Gortmaker (1):
      sched/isolation: Reconcile rcu_nocbs= and nohz_full=

Peter Zijlstra (31):
      delayacct: Use sched_clock()
      sched: Rename sched_info_{queued,dequeued}
      sched: Simplify sched_info_on()
      kvm: Select SCHED_INFO instead of TASK_DELAY_ACCT
      delayacct: Add static_branch in scheduler hooks
      delayacct: Default disabled
      delayacct: Add sysctl to enable at runtime
      sched/fair: Add a few assertions
      sched: Provide raw_spin_rq_*lock*() helpers
      sched: Wrap rq::lock access
      sched: Prepare for Core-wide rq->lock
      sched: Core-wide rq->lock
      sched: Optimize rq_lockp() usage
      sched: Allow sched_core_put() from atomic context
      sched: Introduce sched_class::pick_task()
      sched: Basic tracking of matching tasks
      sched: Add core wide task selection and scheduling
      sched: Trivial forced-newidle balancer
      sched: Trivial core scheduling cookie management
      sched: Inherit task cookie on fork()
      sched,stats: Further simplify sched_info
      sched: Add CONFIG_SCHED_CORE help text
      sched,init: Fix DEBUG_PREEMPT vs early boot
      sched/fair: Age the average idle time
      sched: Unbreak wakeups
      sched: Introduce task_is_running()
      sched,perf,kvm: Fix preemption condition
      sched: Add get_current_state()
      sched,timer: Use __set_current_state()
      sched,arch: Remove unused TASK_STATE offsets
      sched: Change task_struct::state

Pierre Gondois (2):
      sched/fair: Only compute base_energy_pd if necessary
      sched/fair: Fix negative energy delta in find_energy_efficient_cpu()

Qais Yousef (3):
      sched/uclamp: Fix wrong implementation of cpu.uclamp.min
      sched/uclamp: Fix locking around cpu_util_update_eff()
      sched/uclamp: Fix uclamp_tg_restrict()

Rik van Riel (1):
      sched,fair: Skip newidle_balance if a wakeup is pending

Valentin Schneider (3):
      sched/core: Initialize the idle task with preemption disabled
      sched: Make the idle task quack like a per-CPU kthread
      sched: Don't defer CPU pick to migration_cpu_stop()

Vincent Donnefort (2):
      sched/rt: Fix RT utilization tracking during policy change
      sched/rt: Fix Deadline utilization tracking during policy change

Vincent Guittot (1):
      sched/pelt: Check that *_avg are null when *_sum are

Vineeth Pillai (1):
      sched/fair: Fix forced idle sibling starvation corner case

Yejune Deng (1):
      lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed

Zhaoyang Huang (1):
      psi: Fix race between psi_trigger_create/destroy


 Documentation/accounting/delay-accounting.rst      |   12 +-
 .../admin-guide/hw-vuln/core-scheduling.rst        |  223 ++++
 Documentation/admin-guide/hw-vuln/index.rst        |    1 +
 Documentation/admin-guide/kernel-parameters.txt    |    2 +-
 Documentation/admin-guide/sysctl/kernel.rst        |    7 +
 Documentation/scheduler/sched-capacity.rst         |    6 +-
 Documentation/scheduler/sched-energy.rst           |    2 +-
 arch/alpha/kernel/process.c                        |    2 +-
 arch/alpha/kernel/smp.c                            |    1 -
 arch/arc/kernel/smp.c                              |    1 -
 arch/arc/kernel/stacktrace.c                       |    2 +-
 arch/arm/kernel/process.c                          |    2 +-
 arch/arm/kernel/smp.c                              |    1 -
 arch/arm64/include/asm/preempt.h                   |    2 +-
 arch/arm64/kernel/process.c                        |    2 +-
 arch/arm64/kernel/smp.c                            |    1 -
 arch/arm64/kvm/Kconfig                             |    5 +-
 arch/csky/kernel/asm-offsets.c                     |    1 -
 arch/csky/kernel/smp.c                             |    1 -
 arch/csky/kernel/stacktrace.c                      |    2 +-
 arch/h8300/kernel/asm-offsets.c                    |    1 -
 arch/h8300/kernel/process.c                        |    2 +-
 arch/hexagon/kernel/process.c                      |    2 +-
 arch/ia64/kernel/mca.c                             |    2 +-
 arch/ia64/kernel/process.c                         |    4 +-
 arch/ia64/kernel/ptrace.c                          |    8 +-
 arch/ia64/kernel/smpboot.c                         |    1 -
 arch/m68k/kernel/process.c                         |    2 +-
 arch/microblaze/kernel/asm-offsets.c               |    1 -
 arch/mips/kernel/asm-offsets.c                     |    1 -
 arch/mips/kernel/process.c                         |    2 +-
 arch/mips/kernel/smp.c                             |    1 -
 arch/nds32/kernel/process.c                        |    2 +-
 arch/nios2/kernel/process.c                        |    2 +-
 arch/openrisc/kernel/asm-offsets.c                 |    1 -
 arch/openrisc/kernel/smp.c                         |    2 -
 arch/parisc/kernel/asm-offsets.c                   |    1 -
 arch/parisc/kernel/process.c                       |    4 +-
 arch/parisc/kernel/smp.c                           |    1 -
 arch/powerpc/kernel/process.c                      |    4 +-
 arch/powerpc/kernel/smp.c                          |    1 -
 arch/powerpc/xmon/xmon.c                           |   13 +-
 arch/riscv/kernel/smpboot.c                        |    1 -
 arch/riscv/kernel/stacktrace.c                     |    2 +-
 arch/s390/include/asm/preempt.h                    |    4 +-
 arch/s390/kernel/process.c                         |    2 +-
 arch/s390/kernel/smp.c                             |    1 -
 arch/s390/mm/fault.c                               |    2 +-
 arch/sh/kernel/process_32.c                        |    2 +-
 arch/sh/kernel/smp.c                               |    2 -
 arch/sparc/kernel/process_32.c                     |    3 +-
 arch/sparc/kernel/process_64.c                     |    3 +-
 arch/sparc/kernel/smp_32.c                         |    1 -
 arch/sparc/kernel/smp_64.c                         |    3 -
 arch/um/kernel/process.c                           |    2 +-
 arch/x86/include/asm/preempt.h                     |    2 +-
 arch/x86/kernel/process.c                          |    4 +-
 arch/x86/kernel/smpboot.c                          |    1 -
 arch/x86/kvm/Kconfig                               |    5 +-
 arch/xtensa/kernel/process.c                       |    2 +-
 arch/xtensa/kernel/smp.c                           |    1 -
 block/blk-mq.c                                     |    6 +-
 drivers/cpuidle/governors/menu.c                   |    6 +-
 drivers/md/dm.c                                    |    6 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |    6 +-
 drivers/thermal/cpufreq_cooling.c                  |    2 +-
 drivers/usb/gadget/udc/max3420_udc.c               |   15 +-
 drivers/usb/host/max3421-hcd.c                     |    3 +-
 fs/binfmt_elf.c                                    |    8 +-
 fs/binfmt_elf_fdpic.c                              |    4 +-
 fs/proc/loadavg.c                                  |    2 +-
 fs/proc/stat.c                                     |    4 +-
 fs/userfaultfd.c                                   |    4 +-
 include/asm-generic/preempt.h                      |    2 +-
 include/linux/delayacct.h                          |   22 +-
 include/linux/energy_model.h                       |   16 +-
 include/linux/kthread.h                            |    2 +
 include/linux/sched.h                              |   50 +-
 include/linux/sched/cpufreq.h                      |    2 +-
 include/linux/sched/debug.h                        |    2 +-
 include/linux/sched/sd_flags.h                     |   10 +
 include/linux/sched/signal.h                       |    2 +-
 include/linux/sched/stat.h                         |   16 +-
 include/linux/sched_clock.h                        |    2 +-
 include/uapi/linux/prctl.h                         |    8 +
 init/init_task.c                                   |    2 +-
 init/main.c                                        |   17 +-
 kernel/Kconfig.preempt                             |   20 +
 kernel/cgroup/cgroup-v1.c                          |    2 +-
 kernel/debug/kdb/kdb_support.c                     |   18 +-
 kernel/delayacct.c                                 |   71 +-
 kernel/events/core.c                               |    7 +-
 kernel/fork.c                                      |   12 +-
 kernel/freezer.c                                   |    2 +-
 kernel/hung_task.c                                 |    2 +-
 kernel/kcsan/report.c                              |    2 +-
 kernel/kthread.c                                   |   34 +-
 kernel/locking/lockdep.c                           |    2 +-
 kernel/locking/mutex.c                             |    6 +-
 kernel/locking/rtmutex.c                           |    4 +-
 kernel/locking/rwsem.c                             |    2 +-
 kernel/ptrace.c                                    |   12 +-
 kernel/rcu/rcutorture.c                            |    4 +-
 kernel/rcu/tree_plugin.h                           |    2 +-
 kernel/rcu/tree_stall.h                            |   12 +-
 kernel/sched/Makefile                              |    1 +
 kernel/sched/core.c                                | 1138 +++++++++++++++++---
 kernel/sched/core_sched.c                          |  229 ++++
 kernel/sched/cpuacct.c                             |   12 +-
 kernel/sched/cpufreq_schedutil.c                   |    1 +
 kernel/sched/deadline.c                            |   50 +-
 kernel/sched/debug.c                               |    4 +-
 kernel/sched/fair.c                                |  440 +++++---
 kernel/sched/idle.c                                |   13 +-
 kernel/sched/isolation.c                           |    4 +-
 kernel/sched/loadavg.c                             |    2 +-
 kernel/sched/pelt.h                                |    2 +-
 kernel/sched/psi.c                                 |   12 +-
 kernel/sched/rt.c                                  |   48 +-
 kernel/sched/sched.h                               |  437 ++++++--
 kernel/sched/stats.h                               |   68 +-
 kernel/sched/stop_task.c                           |   14 +-
 kernel/sched/topology.c                            |  213 ++--
 kernel/signal.c                                    |    2 +-
 kernel/smpboot.c                                   |    1 -
 kernel/softirq.c                                   |    5 +-
 kernel/sys.c                                       |    5 +
 kernel/sysctl.c                                    |   12 +
 kernel/time/timer.c                                |    2 +-
 lib/smp_processor_id.c                             |    6 +-
 lib/syscall.c                                      |    4 +-
 mm/compaction.c                                    |    2 +-
 net/core/dev.c                                     |    2 +-
 tools/include/uapi/linux/prctl.h                   |    8 +
 tools/testing/selftests/sched/.gitignore           |    1 +
 tools/testing/selftests/sched/Makefile             |   14 +
 tools/testing/selftests/sched/config               |    1 +
 tools/testing/selftests/sched/cs_prctl_test.c      |  338 ++++++
 virt/kvm/kvm_main.c                                |    2 +-
 139 files changed, 3122 insertions(+), 781 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst
 create mode 100644 kernel/sched/core_sched.c
 create mode 100644 tools/testing/selftests/sched/.gitignore
 create mode 100644 tools/testing/selftests/sched/Makefile
 create mode 100644 tools/testing/selftests/sched/config
 create mode 100644 tools/testing/selftests/sched/cs_prctl_test.c
