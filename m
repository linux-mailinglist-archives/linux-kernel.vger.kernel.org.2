Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1270831DADF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhBQNoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhBQNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:44:08 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DD6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 05:43:27 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id n1so6145513edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 05:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=U0idyeFnXaorv3iPHJIomvywRCFMp5aMAH/jgmgpCWw=;
        b=WKZdC/23A0C64JypA8Xlk9fgO44EKGd7UCOec+Ef8EyRwXM2bLW2pGsrT/FvNOtihu
         zdRAV1q7W8jywlgeuCg6CT1C7b2SCxBFF5J2LZtJ8eukIvbeM7801mjbfUmfM306LaqR
         PAlPHSvYr0UoXG92ADeXMANbnVWxlqY60/Pm62CFBVe5ViHDAiILMMNBGywqmVcMnXnz
         iRvJc8cIT2hRFOvb6GK6SapwHzXvioh/TArh0u3yI40bYhcMN5PH41NC9I4/bVgNvx/Q
         z7AFWSlWHiliMZncXgIp+rpBov/KolGgPUJfvKrQGkocovDj84MV+9vxGGEVCkFj+bVf
         QlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=U0idyeFnXaorv3iPHJIomvywRCFMp5aMAH/jgmgpCWw=;
        b=Yhf1OIQED79aEE9vrxBpO2d7QTNZ/J1p3iVcBH6pkgfkqXogLljYdOA1Ml6+dqADzj
         sg0qemG7ITzvgLtDVlAXECLhqVXs1CrojKulLwQ1bNFGPIQE4Fw5cNZ/1ipsH/8weC/u
         pXVAcZMMxjRa6P9zhrFGOj26qHD20Cx57x135JmVE0BETt/dwUjchfSDtSAy2KevGoZA
         JDlHO/oD9+5Eew9DRUCPy4JTvc0zwEBBWOxhj1QZOiH5rEGoWtXxVS7nVgn25u43i1L8
         QYYVNJNN6jSM/1JPEeGcH81ZUfQUiOQhOOV2DjrpQCR/EKu6UC8HRyoAqZUGsi2bRnyY
         hV+A==
X-Gm-Message-State: AOAM533Ad3VeZUklYvHINlvrbt0iwoYOeRXqc0fXWbup7kwogjbjwJNH
        8Ghflls5JVHzbTb8prZnUdo=
X-Google-Smtp-Source: ABdhPJwyNeyuqfrAl3nUCkVoHQvU1mhLdn74W+tJO/cbH0aUpnHv3zZhTjWR59pcFU+SbmY4ew0s2Q==
X-Received: by 2002:a50:a086:: with SMTP id 6mr25880974edo.70.1613569405940;
        Wed, 17 Feb 2021 05:43:25 -0800 (PST)
Received: from gmail.com (20014C4E1C8ABB004E764B08203955B1.dsl.pool.telekom.hu. [2001:4c4e:1c8a:bb00:4e76:4b08:2039:55b1])
        by smtp.gmail.com with ESMTPSA id x25sm1131375edv.65.2021.02.17.05.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 05:43:25 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Feb 2021 14:43:23 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [GIT PULL] scheduler updates for v5.12
Message-ID: <20210217134323.GA493750@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-02-17

   # HEAD: c5e6fc08feb2b88dc5dac2f3c817e1c2a4cafda4 sched,x86: Allow !PREEMPT_DYNAMIC

Scheduler updates for v5.12:

[ NOTE: unfortunately this tree had to be freshly rebased today,
        it's a same-content tree of 82891be90f3c (-next published)
        merged with v5.11.

        The main reason for the rebase was an authorship misattribution
        problem with a new commit, which we noticed in the last minute,
        and which we didn't want to be merged upstream. The offending
        commit was deep in the tree, and dependent commits had to be
        rebased as well. ]

- Core scheduler updates:

  - Add CONFIG_PREEMPT_DYNAMIC: this in its current form adds the
    preempt=none/voluntary/full boot options (default: full),
    to allow distros to build a PREEMPT kernel but fall back to
    close to PREEMPT_VOLUNTARY (or PREEMPT_NONE) runtime scheduling
    behavior via a boot time selection.

    There's also the /debug/sched_debug switch to do this runtime.

    This feature is implemented via runtime patching (a new variant of static calls).

    The scope of the runtime patching can be best reviewed by looking
    at the sched_dynamic_update() function in kernel/sched/core.c.

    ( Note that the dynamic none/voluntary mode isn't 100% identical,
      for example preempt-RCU is available in all cases, plus the
      preempt count is maintained in all models, which has runtime
      overhead even with the code patching. )

    The PREEMPT_VOLUNTARY/PREEMPT_NONE models, used by the vast majority
    of distributions, are supposed to be unaffected.

  - Fix ignored rescheduling after rcu_eqs_enter(). This is a bug that
    was found via rcutorture triggering a hang. The bug is that
    rcu_idle_enter() may wake up a NOCB kthread, but this happens after
    the last generic need_resched() check. Some cpuidle drivers fix it
    by chance but many others don't.

    In true 2020 fashion the original bug fix has grown into a 5-patch
    scheduler/RCU fix series plus another 16 RCU patches to address
    the underlying issue of missed preemption events. These are the
    initial fixes that should fix current incarnations of the bug.

  - Clean up rbtree usage in the scheduler, by providing & using the following
    consistent set of rbtree APIs:

     partial-order; less() based:
       - rb_add(): add a new entry to the rbtree
       - rb_add_cached(): like rb_add(), but for a rb_root_cached

     total-order; cmp() based:
       - rb_find(): find an entry in an rbtree
       - rb_find_add(): find an entry, and add if not found

       - rb_find_first(): find the first (leftmost) matching entry
       - rb_next_match(): continue from rb_find_first()
       - rb_for_each(): iterate a sub-tree using the previous two

  - Improve the SMP/NUMA load-balancer: scan for an idle sibling in a single pass.
    This is a 4-commit series where each commit improves one aspect of the idle
    sibling scan logic.

  - Improve the cpufreq cooling driver by getting the effective CPU utilization
    metrics from the scheduler

  - Improve the fair scheduler's active load-balancing logic by reducing the number
    of active LB attempts & lengthen the load-balancing interval. This improves
    stress-ng mmapfork performance.

  - Fix CFS's estimated utilization (util_est) calculation bug that can result in
    too high utilization values

- Misc updates & fixes:

   - Fix the HRTICK reprogramming & optimization feature
   - Fix SCHED_SOFTIRQ raising race & warning in the CPU offlining code
   - Reduce dl_add_task_root_domain() overhead
   - Fix uprobes refcount bug
   - Process pending softirqs in flush_smp_call_function_from_idle()
   - Clean up task priority related defines, remove *USER_*PRIO and
     USER_PRIO()
   - Simplify the sched_init_numa() deduplication sort
   - Documentation updates
   - Fix EAS bug in update_misfit_status(), which degraded the quality
     of energy-balancing
   - Smaller cleanups

 Thanks,

	Ingo

------------------>
Anna-Maria Behnsen (1):
      sched: Prevent raising SCHED_SOFTIRQ when CPU is !active

Dietmar Eggemann (5):
      sched/topology: Fix sched_domain_topology_level alloc in sched_init_numa()
      sched: Remove MAX_USER_RT_PRIO
      sched: Remove USER_PRIO, TASK_USER_PRIO and MAX_USER_PRIO
      sched/core: Update task_prio() function header
      sched/deadline: Reduce rq lock contention in dl_add_task_root_domain()

Frederic Weisbecker (6):
      static_call: Provide DEFINE_STATIC_CALL_RET0()
      rcu: Pull deferred rcuog wake up to rcu_eqs_enter() callers
      rcu/nocb: Perform deferred wake up before last idle's need_resched() check
      rcu/nocb: Trigger self-IPI on late deferred wake up before user resume
      entry: Explicitly flush pending rcuog wakeup before last rescheduling point
      entry/kvm: Explicitly flush pending rcuog wakeup before last rescheduling point

Hui Su (1):
      sched: Use task_current() instead of 'rq->curr == p'

Josh Poimboeuf (1):
      static_call: Allow module use without exposing static_call_key

Juri Lelli (2):
      sched/features: Fix hrtick reprogramming
      sched/features: Distinguish between NORMAL and DEADLINE hrtick

Mel Gorman (4):
      sched/fair: Remove SIS_AVG_CPU
      sched/fair: Move avg_scan_cost calculations under SIS_PROP
      sched/fair: Remove select_idle_smt()
      sched/fair: Merge select_idle_core/cpu()

Michal Hocko (1):
      preempt: Introduce CONFIG_PREEMPT_DYNAMIC

Peter Oskolkov (1):
      sched: Correctly sort struct predeclarations

Peter Zijlstra (13):
      sched: Add schedutil overview
      rbtree: Add generic add and find helpers
      rbtree, sched/fair: Use rb_add_cached()
      rbtree, sched/deadline: Use rb_add_cached()
      rbtree, perf: Use new rbtree helpers
      rbtree, uprobes: Use rbtree helpers
      rbtree, rtmutex: Use rb_add_cached()
      rbtree, timerqueue: Use rb_add_cached()
      static_call: Pull some static_call declarations to the type headers
      static_call/x86: Add __static_call_return0()
      sched: Add /debug/sched_preempt
      sched: Harden PREEMPT_DYNAMIC
      sched,x86: Allow !PREEMPT_DYNAMIC

Peter Zijlstra (Intel) (4):
      preempt/dynamic: Provide cond_resched() and might_resched() static calls
      preempt/dynamic: Provide preempt_schedule[_notrace]() static calls
      preempt/dynamic: Provide irqentry_exit_cond_resched() static call
      preempt/dynamic: Support dynamic preempt with preempt= boot option

Qais Yousef (1):
      sched/eas: Don't update misfit status if the task is pinned

Sebastian Andrzej Siewior (1):
      smp: Process pending softirqs in flush_smp_call_function_from_idle()

Sven Schnelle (1):
      uprobes: (Re)add missing get_uprobe() in __find_uprobe()

Valentin Schneider (1):
      sched/topology: Make sched_init_numa() use a set for the deduplicating sort

Vincent Guittot (3):
      sched/fair: Skip idle cfs_rq
      sched/fair: Don't set LBF_ALL_PINNED unnecessarily
      sched/fair: Reduce cases for active balance

Viresh Kumar (3):
      sched/core: Move schedutil_cpu_util() to core.c
      sched/core: Rename schedutil_cpu_util() and allow rest of the kernel to use it
      thermal: cpufreq_cooling: Reuse sched_cpu_util() for SMP platforms

Xuewen Yan (1):
      sched/fair: Avoid stale CPU util_est value for schedutil in task dequeue

Yue Hu (1):
      init/Kconfig: Correct thermal pressure help text


 Documentation/admin-guide/kernel-parameters.txt |   7 +
 Documentation/scheduler/schedutil.txt           | 169 +++++++++++
 arch/Kconfig                                    |   9 +
 arch/powerpc/platforms/cell/spufs/sched.c       |   2 +-
 arch/x86/Kconfig                                |   1 +
 arch/x86/include/asm/preempt.h                  |  48 +++-
 arch/x86/include/asm/static_call.h              |   7 +
 arch/x86/kernel/static_call.c                   |  17 +-
 arch/x86/kvm/x86.c                              |   1 +
 drivers/thermal/cpufreq_cooling.c               |  69 ++++-
 include/asm-generic/vmlinux.lds.h               |   5 +-
 include/linux/cgroup.h                          |   4 +-
 include/linux/entry-common.h                    |   4 +
 include/linux/entry-kvm.h                       |  14 +
 include/linux/kernel.h                          |  23 +-
 include/linux/rbtree.h                          | 206 +++++++++++++-
 include/linux/rcupdate.h                        |   2 +
 include/linux/sched.h                           |  34 ++-
 include/linux/sched/prio.h                      |  18 +-
 include/linux/static_call.h                     |  77 +++--
 include/linux/static_call_types.h               |  50 ++++
 include/linux/topology.h                        |   1 +
 init/Kconfig                                    |   2 +-
 kernel/Kconfig.preempt                          |  19 ++
 kernel/entry/common.c                           |  17 +-
 kernel/events/core.c                            | 195 ++++++-------
 kernel/events/uprobes.c                         |  80 +++---
 kernel/locking/rtmutex.c                        |  54 ++--
 kernel/rcu/tree.c                               |  53 +++-
 kernel/rcu/tree.h                               |   2 +-
 kernel/rcu/tree_plugin.h                        |  31 +-
 kernel/sched/core.c                             | 357 ++++++++++++++++++++++--
 kernel/sched/cpufreq_schedutil.c                | 108 +------
 kernel/sched/deadline.c                         |  94 +++----
 kernel/sched/debug.c                            |   2 +-
 kernel/sched/fair.c                             | 322 +++++++++++----------
 kernel/sched/features.h                         |   2 +-
 kernel/sched/idle.c                             |   1 +
 kernel/sched/rt.c                               |   2 +-
 kernel/sched/sched.h                            |  51 ++--
 kernel/sched/topology.c                         |  99 ++++---
 kernel/smp.c                                    |   4 +
 kernel/static_call.c                            |  60 +++-
 lib/timerqueue.c                                |  28 +-
 tools/include/linux/rbtree.h                    | 192 ++++++++++++-
 tools/include/linux/static_call_types.h         |  50 ++++
 tools/objtool/check.c                           |  17 +-
 tools/objtool/elf.c                             |  73 +----
 48 files changed, 1898 insertions(+), 785 deletions(-)
 create mode 100644 Documentation/scheduler/schedutil.txt
