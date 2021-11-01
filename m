Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458E94411C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 02:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhKABSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 21:18:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39154 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhKABSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 21:18:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635729366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=laphivRq8bB2YCIaWfHAXYuW41rn7AMvSPmha6pVyR0=;
        b=hQ+Wt1OsCB1s23SxJRgswsjaiQF/1DIapKuUHqVZUn87mSZFh5a9JD0arRiuJTZmDhQ7kR
        +KSmppfj5BFkdGGBd75J41AsO+nrtqZe7oQOft3XniB7J9DNl11T3Jh4Sbe9SIgHiYfkql
        nJn47RZel+nUg5hYtZWXOxHSfiwJkGZ8bs26GMJki5lKxY8FI9REhiQygi2GGbSMAWmP2R
        eepxCWg9xwqtiTaU0H5NuPjlH1FNPQyWGCoiA/jNGfI+6Q6nBzLamt5ozsHEM8k2LntdVS
        veCvg2nkV6QG2pi+RU6EvD24qKdfK9eUXpPflZd7g7SuxsLfL+QtjPJRyYDqSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635729366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=laphivRq8bB2YCIaWfHAXYuW41rn7AMvSPmha6pVyR0=;
        b=TJ6PSDlR8beyvU1bxh6VKsGFO940EDBo9CAKH77w1f2K/92+5aVY/DoK7h+RmV0u27MTx6
        ilnpJtUHmZRC6jDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/core for v5.16-rc1
References: <163572864256.3357115.931779940195622047.tglx@xen13>
Message-ID: <163572864855.3357115.17938524897008353101.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon,  1 Nov 2021 02:16:04 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-=
11-01

up to:  8ea9183db4ad: sched/fair: Cleanup newidle_balance


Scheduler updates:

 - Revert the printk format based wchan() symbol resolution as it can leak
   the raw value in case that the symbol is not resolvable.

 - Make wchan() more robust and work with all kind of unwinders by
   enforcing that the task stays blocked while unwinding is in progress.

 - Prevent sched_fork() from accessing an invalid sched_task_group

 - Improve asymmetric packing logic

 - Extend scheduler statistics to RT and DL scheduling classes and add
   statistics for bandwith burst to the SCHED_FAIR class.

 - Properly account SCHED_IDLE entities

 - Prevent a potential deadlock when initial priority is assigned to a
   newly created kthread. A recent change to plug a race between cpuset and
   __sched_setscheduler() introduced a new lock dependency which is now
   triggered. Break the lock dependency chain by moving the priority
   assignment to the thread function.

 - Fix the idle time reporting in /proc/uptime for NOHZ enabled systems.

 - Improve idle balancing in general and especially for NOHZ enabled
   systems.

 - Provide proper interfaces for live patching so it does not have to
   fiddle with scheduler internals.

 - Add cluster aware scheduling support.

 - A small set of tweaks for RT (irqwork, wait_task_inactive(), various
   scheduler options and delaying mmdrop)

 - The usual small tweaks and improvements all over the place

Thanks,

	tglx

------------------>
Barry Song (1):
      sched: Add cluster scheduler level in core and related Kconfig for ARM64

Bharata B Rao (3):
      sched/numa: Replace hard-coded number by a define in numa_task_group()
      sched/numa: Remove the redundant member numa_group::fault_cpus
      sched/numa: Fix a few comments

Frederic Weisbecker (1):
      sched: Provide Kconfig support for default dynamic preempt mode

Huaixin Chang (2):
      sched/fair: Add cfs bandwidth burst statistics
      sched/fair: Add document for burstable CFS bandwidth

Jonathan Cameron (1):
      topology: Represent clusters of CPUs within a die

Josh Don (4):
      fs/proc/uptime.c: Fix idle time reporting in /proc/uptime
      sched: Account number of SCHED_IDLE entities on each cfs_rq
      sched: reduce sched slice for SCHED_IDLE entities
      sched: adjust sleeper credit for SCHED_IDLE entities

Kees Cook (5):
      sched: Fill unconditional hole induced by sched_entity
      Revert "proc/wchan: use printk format instead of lookup_symbol_name()"
      leaking_addresses: Always print a trailing newline
      proc: Use task_is_running() for wchan in /proc/$pid/stat
      sched: Add wrapper for get_wchan() to keep task blocked

Li Zhijian (1):
      kselftests/sched: cleanup the child processes

Peng Wang (1):
      sched/core: Remove rq_relock()

Peter Zijlstra (11):
      sched/core: Simplify core-wide task selection
      sched: Fix DEBUG && !SCHEDSTATS warn
      sched: Improve try_invoke_on_locked_down_task()
      sched,rcu: Rework try_invoke_on_locked_down_task()
      sched,livepatch: Use task_call_func()
      sched: Simplify wake_up_*idle*()
      sched,livepatch: Use wake_up_if_idle()
      sched: Disable -Wunused-but-set-variable
      sched: Improve wake_up_all_idle_cpus() take #2
      sched,x86: Fix L2 cache mask
      x86: Fix __get_wchan() for !STACKTRACE

Qi Zheng (1):
      x86: Fix get_wchan() to support the ORC unwinder

Ricardo Neri (6):
      x86/sched: Decrease further the priorities of SMT siblings
      sched/topology: Introduce sched_group::flags
      sched/fair: Optimize checking for group_asym_packing
      sched/fair: Provide update_sg_lb_stats() with sched domain statistics
      sched/fair: Carve out logic to mark a group for asymmetric packing
      sched/fair: Consider SMT in ASYM_PACKING load balance

Sebastian Andrzej Siewior (6):
      sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
      kthread: Move prio/affinite change into the newly created thread
      sched/rt: Annotate the RT balancing logic irqwork as IRQ_WORK_HARD_IRQ
      irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.
      irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT
      irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT

Shaokun Zhang (1):
      sched: Make cookie functions static

Thomas Gleixner (5):
      sched: Move mmdrop to RCU on RT
      sched: Limit the number of task migrations per batch on RT
      sched: Disable TTWU_QUEUE on RT
      sched: Move kprobes cleanup out of finish_task_switch()
      sched: Remove pointless preemption disable in sched_submit_work()

Tim Chen (1):
      sched: Add cluster scheduler level for x86

Valentin Schneider (2):
      sched/fair: Add NOHZ balancer flag for nohz.next_balance updates
      sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle

Vincent Guittot (6):
      sched/fair: Removed useless update of p->recent_used_cpu
      sched/fair: Account update_blocked_averages in newidle_balance cost
      sched/fair: Skip update_blocked_averages if we are defering load balance
      sched/fair: Wait before decaying max_newidle_lb_cost
      sched/fair: Remove sysctl_sched_migration_cost condition
      sched/fair: Cleanup newidle_balance

Yafang Shao (8):
      sched/fair: Use __schedstat_set() in set_next_entity()
      sched: Make struct sched_statistics independent of fair sched class
      sched: Make schedstats helpers independent of fair sched class
      sched: Introduce task block time in schedstats
      sched/rt: Support sched_stat_runtime tracepoint for RT sched class
      sched/rt: Support schedstats for RT sched class
      sched/dl: Support sched_stat_runtime tracepoint for deadline sched class
      sched/dl: Support schedstats for deadline sched class

Yicong Yang (1):
      sched/topology: Remove unused numa_distance in cpu_attach_domain()

YueHaibing (1):
      sched: Remove unused inline function __rq_clock_broken()

Zhang Qiao (1):
      kernel/sched: Fix sched_fork() access an invalid sched_task_group


 Documentation/ABI/stable/sysfs-devices-system-cpu |  15 +
 Documentation/admin-guide/cgroup-v2.rst           |   8 +
 Documentation/admin-guide/cputopology.rst         |  12 +-
 Documentation/scheduler/sched-bwc.rst             |  84 +++-
 arch/alpha/include/asm/processor.h                |   2 +-
 arch/alpha/kernel/process.c                       |   5 +-
 arch/arc/include/asm/processor.h                  |   2 +-
 arch/arc/kernel/stacktrace.c                      |   4 +-
 arch/arm/include/asm/processor.h                  |   2 +-
 arch/arm/kernel/process.c                         |   4 +-
 arch/arm64/Kconfig                                |   9 +
 arch/arm64/include/asm/processor.h                |   2 +-
 arch/arm64/kernel/process.c                       |   4 +-
 arch/arm64/kernel/topology.c                      |   2 +
 arch/csky/include/asm/processor.h                 |   2 +-
 arch/csky/kernel/stacktrace.c                     |   5 +-
 arch/h8300/include/asm/processor.h                |   2 +-
 arch/h8300/kernel/process.c                       |   5 +-
 arch/hexagon/include/asm/processor.h              |   2 +-
 arch/hexagon/kernel/process.c                     |   4 +-
 arch/ia64/include/asm/processor.h                 |   2 +-
 arch/ia64/kernel/process.c                        |   5 +-
 arch/m68k/include/asm/processor.h                 |   2 +-
 arch/m68k/kernel/process.c                        |   4 +-
 arch/microblaze/include/asm/processor.h           |   2 +-
 arch/microblaze/kernel/process.c                  |   2 +-
 arch/mips/include/asm/processor.h                 |   2 +-
 arch/mips/kernel/process.c                        |   8 +-
 arch/nds32/include/asm/processor.h                |   2 +-
 arch/nds32/kernel/process.c                       |   7 +-
 arch/nios2/include/asm/processor.h                |   2 +-
 arch/nios2/kernel/process.c                       |   5 +-
 arch/openrisc/include/asm/processor.h             |   2 +-
 arch/openrisc/kernel/process.c                    |   2 +-
 arch/parisc/include/asm/processor.h               |   2 +-
 arch/parisc/kernel/process.c                      |   5 +-
 arch/powerpc/include/asm/processor.h              |   2 +-
 arch/powerpc/kernel/process.c                     |   9 +-
 arch/riscv/include/asm/processor.h                |   2 +-
 arch/riscv/kernel/stacktrace.c                    |  12 +-
 arch/s390/include/asm/processor.h                 |   2 +-
 arch/s390/kernel/process.c                        |   4 +-
 arch/sh/include/asm/processor_32.h                |   2 +-
 arch/sh/kernel/process_32.c                       |   5 +-
 arch/sparc/include/asm/processor_32.h             |   2 +-
 arch/sparc/include/asm/processor_64.h             |   2 +-
 arch/sparc/kernel/process_32.c                    |   5 +-
 arch/sparc/kernel/process_64.c                    |   5 +-
 arch/um/include/asm/processor-generic.h           |   2 +-
 arch/um/kernel/process.c                          |   5 +-
 arch/x86/Kconfig                                  |  11 +
 arch/x86/include/asm/processor.h                  |   2 +-
 arch/x86/include/asm/smp.h                        |   7 +
 arch/x86/include/asm/topology.h                   |   3 +
 arch/x86/kernel/cpu/cacheinfo.c                   |   1 +
 arch/x86/kernel/cpu/common.c                      |   3 +
 arch/x86/kernel/itmt.c                            |   2 +-
 arch/x86/kernel/process.c                         |  65 +--
 arch/x86/kernel/smpboot.c                         |  44 +-
 arch/xtensa/include/asm/processor.h               |   2 +-
 arch/xtensa/kernel/process.c                      |   5 +-
 drivers/acpi/pptt.c                               |  67 +++
 drivers/base/arch_topology.c                      |  15 +
 drivers/base/topology.c                           |  10 +
 fs/proc/array.c                                   |   7 +-
 fs/proc/base.c                                    |  19 +-
 fs/proc/stat.c                                    |   4 +-
 fs/proc/uptime.c                                  |  14 +-
 include/linux/acpi.h                              |   5 +
 include/linux/arch_topology.h                     |   5 +
 include/linux/irq_work.h                          |   8 +
 include/linux/kernel_stat.h                       |   1 +
 include/linux/mm_types.h                          |   4 +
 include/linux/sched.h                             |  11 +-
 include/linux/sched/idle.h                        |   4 +
 include/linux/sched/mm.h                          |  29 ++
 include/linux/sched/task.h                        |   3 +-
 include/linux/sched/topology.h                    |   9 +-
 include/linux/topology.h                          |  13 +
 include/linux/wait.h                              |   3 +-
 kernel/Kconfig.preempt                            |  32 +-
 kernel/exit.c                                     |   2 +
 kernel/fork.c                                     |   2 +-
 kernel/irq_work.c                                 | 130 +++++-
 kernel/kprobes.c                                  |   8 +-
 kernel/kthread.c                                  |  16 +-
 kernel/livepatch/transition.c                     |  95 +++--
 kernel/rcu/tasks.h                                |  12 +-
 kernel/rcu/tree_stall.h                           |   8 +-
 kernel/sched/Makefile                             |   4 +
 kernel/sched/core.c                               | 392 +++++++++--------
 kernel/sched/core_sched.c                         |   9 +-
 kernel/sched/deadline.c                           |  99 ++++-
 kernel/sched/debug.c                              | 101 +++--
 kernel/sched/fair.c                               | 496 +++++++++++++-------=
--
 kernel/sched/features.h                           |   5 +
 kernel/sched/rt.c                                 | 130 +++++-
 kernel/sched/sched.h                              |  32 +-
 kernel/sched/stats.c                              | 104 +++++
 kernel/sched/stats.h                              |  49 +++
 kernel/sched/stop_task.c                          |   4 +-
 kernel/sched/topology.c                           |  34 +-
 kernel/smp.c                                      |  12 +-
 scripts/leaking_addresses.pl                      |   3 +-
 tools/testing/selftests/sched/cs_prctl_test.c     |  28 +-
 105 files changed, 1682 insertions(+), 789 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-system-cpu b/Documentatio=
n/ABI/stable/sysfs-devices-system-cpu
index 516dafea03eb..3965ce504484 100644
--- a/Documentation/ABI/stable/sysfs-devices-system-cpu
+++ b/Documentation/ABI/stable/sysfs-devices-system-cpu
@@ -42,6 +42,12 @@ Description:    the CPU core ID of cpuX. Typically it is t=
he hardware platform's
                 architecture and platform dependent.
 Values:         integer
=20
+What:           /sys/devices/system/cpu/cpuX/topology/cluster_id
+Description:    the cluster ID of cpuX.  Typically it is the hardware platfo=
rm's
+                identifier (rather than the kernel's). The actual value is
+                architecture and platform dependent.
+Values:         integer
+
 What:           /sys/devices/system/cpu/cpuX/topology/book_id
 Description:    the book ID of cpuX. Typically it is the hardware platform's
                 identifier (rather than the kernel's). The actual value is
@@ -85,6 +91,15 @@ Description:    human-readable list of CPUs within the sam=
e die.
                 The format is like 0-3, 8-11, 14,17.
 Values:         decimal list.
=20
+What:           /sys/devices/system/cpu/cpuX/topology/cluster_cpus
+Description:    internal kernel map of CPUs within the same cluster.
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/cluster_cpus_list
+Description:    human-readable list of CPUs within the same cluster.
+                The format is like 0-3, 8-11, 14,17.
+Values:         decimal list.
+
 What:           /sys/devices/system/cpu/cpuX/topology/book_siblings
 Description:    internal kernel map of cpuX's hardware threads within the sa=
me
                 book_id. it's only used on s390.
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-gu=
ide/cgroup-v2.rst
index babbe04c8d37..d5b0e8aa043a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1016,6 +1016,8 @@ All time durations are in microseconds.
 	- nr_periods
 	- nr_throttled
 	- throttled_usec
+	- nr_bursts
+	- burst_usec
=20
   cpu.weight
 	A read-write single value file which exists on non-root
@@ -1047,6 +1049,12 @@ All time durations are in microseconds.
 	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
 	one number is written, $MAX is updated.
=20
+  cpu.max.burst
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "0".
+
+	The burst in the range [0, $MAX].
+
   cpu.pressure
 	A read-write nested-keyed file.
=20
diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-=
guide/cputopology.rst
index b085dbac60a5..6b62e182baf4 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -19,11 +19,13 @@ these macros in include/asm-XXX/topology.h::
=20
 	#define topology_physical_package_id(cpu)
 	#define topology_die_id(cpu)
+	#define topology_cluster_id(cpu)
 	#define topology_core_id(cpu)
 	#define topology_book_id(cpu)
 	#define topology_drawer_id(cpu)
 	#define topology_sibling_cpumask(cpu)
 	#define topology_core_cpumask(cpu)
+	#define topology_cluster_cpumask(cpu)
 	#define topology_die_cpumask(cpu)
 	#define topology_book_cpumask(cpu)
 	#define topology_drawer_cpumask(cpu)
@@ -39,10 +41,12 @@ not defined by include/asm-XXX/topology.h:
=20
 1) topology_physical_package_id: -1
 2) topology_die_id: -1
-3) topology_core_id: 0
-4) topology_sibling_cpumask: just the given CPU
-5) topology_core_cpumask: just the given CPU
-6) topology_die_cpumask: just the given CPU
+3) topology_cluster_id: -1
+4) topology_core_id: 0
+5) topology_sibling_cpumask: just the given CPU
+6) topology_core_cpumask: just the given CPU
+7) topology_cluster_cpumask: just the given CPU
+8) topology_die_cpumask: just the given CPU
=20
 For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
 default definitions for topology_book_id() and topology_book_cpumask().
diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/=
sched-bwc.rst
index 1fc73555f5c4..173c14110c85 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -22,9 +22,52 @@ cfs_quota units at each period boundary. As threads consum=
e this bandwidth it
 is transferred to cpu-local "silos" on a demand basis. The amount transferred
 within each of these updates is tunable and described as the "slice".
=20
+Burst feature
+-------------
+This feature borrows time now against our future underrun, at the cost of
+increased interference against the other system users. All nicely bounded.
+
+Traditional (UP-EDF) bandwidth control is something like:
+
+  (U =3D \Sum u_i) <=3D 1
+
+This guaranteeds both that every deadline is met and that the system is
+stable. After all, if U were > 1, then for every second of walltime,
+we'd have to run more than a second of program time, and obviously miss
+our deadline, but the next deadline will be further out still, there is
+never time to catch up, unbounded fail.
+
+The burst feature observes that a workload doesn't always executes the full
+quota; this enables one to describe u_i as a statistical distribution.
+
+For example, have u_i =3D {x,e}_i, where x is the p(95) and x+e p(100)
+(the traditional WCET). This effectively allows u to be smaller,
+increasing the efficiency (we can pack more tasks in the system), but at
+the cost of missing deadlines when all the odds line up. However, it
+does maintain stability, since every overrun must be paired with an
+underrun as long as our x is above the average.
+
+That is, suppose we have 2 tasks, both specify a p(95) value, then we
+have a p(95)*p(95) =3D 90.25% chance both tasks are within their quota and
+everything is good. At the same time we have a p(5)p(5) =3D 0.25% chance
+both tasks will exceed their quota at the same time (guaranteed deadline
+fail). Somewhere in between there's a threshold where one exceeds and
+the other doesn't underrun enough to compensate; this depends on the
+specific CDFs.
+
+At the same time, we can say that the worst case deadline miss, will be
+\Sum e_i; that is, there is a bounded tardiness (under the assumption
+that x+e is indeed WCET).
+
+The interferenece when using burst is valued by the possibilities for
+missing the deadline and the average WCET. Test results showed that when
+there many cgroups or CPU is under utilized, the interference is
+limited. More details are shown in:
+https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alib=
aba.com/
+
 Management
 ----------
-Quota and period are managed within the cpu subsystem via cgroupfs.
+Quota, period and burst are managed within the cpu subsystem via cgroupfs.
=20
 .. note::
    The cgroupfs files described in this section are only applicable
@@ -32,29 +75,37 @@ Quota and period are managed within the cpu subsystem via=
 cgroupfs.
    :ref:`Documentation/admin-guide/cgroup-v2.rst <cgroup-v2-cpu>`.
=20
 - cpu.cfs_quota_us: the total available run-time within a period (in
-  microseconds)
+- cpu.cfs_quota_us: run-time replenished within a period (in microseconds)
 - cpu.cfs_period_us: the length of a period (in microseconds)
 - cpu.stat: exports throttling statistics [explained further below]
+- cpu.cfs_burst_us: the maximum accumulated run-time (in microseconds)
=20
 The default values are::
=20
 	cpu.cfs_period_us=3D100ms
-	cpu.cfs_quota=3D-1
+	cpu.cfs_quota_us=3D-1
+	cpu.cfs_burst_us=3D0
=20
 A value of -1 for cpu.cfs_quota_us indicates that the group does not have any
 bandwidth restriction in place, such a group is described as an unconstrained
 bandwidth group. This represents the traditional work-conserving behavior for
 CFS.
=20
-Writing any (valid) positive value(s) will enact the specified bandwidth lim=
it.
-The minimum quota allowed for the quota or period is 1ms. There is also an
-upper bound on the period length of 1s. Additional restrictions exist when
-bandwidth limits are used in a hierarchical fashion, these are explained in
-more detail below.
+Writing any (valid) positive value(s) no smaller than cpu.cfs_burst_us will
+enact the specified bandwidth limit. The minimum quota allowed for the quota=
 or
+period is 1ms. There is also an upper bound on the period length of 1s.
+Additional restrictions exist when bandwidth limits are used in a hierarchic=
al
+fashion, these are explained in more detail below.
=20
 Writing any negative value to cpu.cfs_quota_us will remove the bandwidth lim=
it
 and return the group to an unconstrained state once more.
=20
+A value of 0 for cpu.cfs_burst_us indicates that the group can not accumulate
+any unused bandwidth. It makes the traditional bandwidth control behavior for
+CFS unchanged. Writing any (valid) positive value(s) no larger than
+cpu.cfs_quota_us into cpu.cfs_burst_us will enact the cap on unused bandwidth
+accumulation.
+
 Any updates to a group's bandwidth specification will result in it becoming
 unthrottled if it is in a constrained state.
=20
@@ -74,7 +125,7 @@ for more fine-grained consumption.
=20
 Statistics
 ----------
-A group's bandwidth statistics are exported via 3 fields in cpu.stat.
+A group's bandwidth statistics are exported via 5 fields in cpu.stat.
=20
 cpu.stat:
=20
@@ -82,6 +133,9 @@ cpu.stat:
 - nr_throttled: Number of times the group has been throttled/limited.
 - throttled_time: The total time duration (in nanoseconds) for which entities
   of the group have been throttled.
+- nr_bursts: Number of periods burst occurs.
+- burst_time: Cumulative wall-time (in nanoseconds) that any CPUs has used
+  above quota in respective periods
=20
 This interface is read-only.
=20
@@ -179,3 +233,15 @@ Examples
=20
    By using a small period here we are ensuring a consistent latency
    response at the expense of burst capacity.
+
+4. Limit a group to 40% of 1 CPU, and allow accumulate up to 20% of 1 CPU
+   additionally, in case accumulation has been done.
+
+   With 50ms period, 20ms quota will be equivalent to 40% of 1 CPU.
+   And 10ms burst will be equivalent to 20% of 1 CPU.
+
+	# echo 20000 > cpu.cfs_quota_us /* quota =3D 20ms */
+	# echo 50000 > cpu.cfs_period_us /* period =3D 50ms */
+	# echo 10000 > cpu.cfs_burst_us /* burst =3D 10ms */
+
+   Larger buffer setting (no larger than quota) allows greater burst capacit=
y.
diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/proc=
essor.h
index 6100431da07a..090499c99c1c 100644
--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -42,7 +42,7 @@ extern void start_thread(struct pt_regs *, unsigned long, u=
nsigned long);
 struct task_struct;
 extern void release_thread(struct task_struct *);
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 #define KSTK_EIP(tsk) (task_pt_regs(tsk)->pc)
=20
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index a5123ea426ce..5f8527081da9 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -376,12 +376,11 @@ thread_saved_pc(struct task_struct *t)
 }
=20
 unsigned long
-get_wchan(struct task_struct *p)
+__get_wchan(struct task_struct *p)
 {
 	unsigned long schedule_frame;
 	unsigned long pc;
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
+
 	/*
 	 * This one depends on the frame size of schedule().  Do a
 	 * "disass schedule" in gdb to find the frame size.  Also, the
diff --git a/arch/arc/include/asm/processor.h b/arch/arc/include/asm/processo=
r.h
index f28afcf5c6d1..54db9d7bb562 100644
--- a/arch/arc/include/asm/processor.h
+++ b/arch/arc/include/asm/processor.h
@@ -70,7 +70,7 @@ struct task_struct;
 extern void start_thread(struct pt_regs * regs, unsigned long pc,
 			 unsigned long usp);
=20
-extern unsigned int get_wchan(struct task_struct *p);
+extern unsigned int __get_wchan(struct task_struct *p);
=20
 #endif /* !__ASSEMBLY__ */
=20
diff --git a/arch/arc/kernel/stacktrace.c b/arch/arc/kernel/stacktrace.c
index c376ff3147e7..5372dc04e784 100644
--- a/arch/arc/kernel/stacktrace.c
+++ b/arch/arc/kernel/stacktrace.c
@@ -15,7 +15,7 @@
  *      =3D specifics of data structs where trace is saved(CONFIG_STACKTRACE=
 etc)
  *
  *  vineetg: March 2009
- *  -Implemented correct versions of thread_saved_pc() and get_wchan()
+ *  -Implemented correct versions of thread_saved_pc() and __get_wchan()
  *
  *  rajeshwarr: 2008
  *  -Initial implementation
@@ -248,7 +248,7 @@ void show_stack(struct task_struct *tsk, unsigned long *s=
p, const char *loglvl)
  * Of course just returning schedule( ) would be pointless so unwind until
  * the function is not in schedular code
  */
-unsigned int get_wchan(struct task_struct *tsk)
+unsigned int __get_wchan(struct task_struct *tsk)
 {
 	return arc_unwind_core(tsk, NULL, __get_first_nonsched, NULL);
 }
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processo=
r.h
index 9e6b97286307..6af68edfa53a 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -84,7 +84,7 @@ struct task_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 0e2d3051741e..96f577e59595 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -276,13 +276,11 @@ int copy_thread(unsigned long clone_flags, unsigned lon=
g stack_start,
 	return 0;
 }
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	struct stackframe frame;
 	unsigned long stack_page;
 	int count =3D 0;
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
=20
 	frame.fp =3D thread_saved_fp(p);
 	frame.sp =3D thread_saved_sp(p);
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..d13677f4731d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -989,6 +989,15 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
=20
+config SCHED_CLUSTER
+	bool "Cluster scheduler support"
+	help
+	  Cluster scheduler support improves the CPU scheduler's decision
+	  making when dealing with machines that have clusters of CPUs.
+	  Cluster usually means a couple of CPUs which are placed closely
+	  by sharing mid-level caches, last-level cache tags or internal
+	  busses.
+
 config SCHED_SMT
 	bool "SMT scheduler support"
 	help
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/proc=
essor.h
index ee2bdc1b9f5b..55ca034238ea 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -257,7 +257,7 @@ struct task_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 void update_sctlr_el1(u64 sctlr);
=20
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 40adb8cdbf5a..aacf2f5559a8 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -528,13 +528,11 @@ __notrace_funcgraph struct task_struct *__switch_to(str=
uct task_struct *prev,
 	return last;
 }
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	struct stackframe frame;
 	unsigned long stack_page, ret =3D 0;
 	int count =3D 0;
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
=20
 	stack_page =3D (unsigned long)try_get_task_stack(p);
 	if (!stack_page)
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 4dd14a6620c1..9ab78ad826e2 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -103,6 +103,8 @@ int __init parse_acpi_topology(void)
 			cpu_topology[cpu].thread_id  =3D -1;
 			cpu_topology[cpu].core_id    =3D topology_id;
 		}
+		topology_id =3D find_acpi_cpu_topology_cluster(cpu);
+		cpu_topology[cpu].cluster_id =3D topology_id;
 		topology_id =3D find_acpi_cpu_topology_package(cpu);
 		cpu_topology[cpu].package_id =3D topology_id;
=20
diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/proces=
sor.h
index 9e933021fe8e..817dd60ff152 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -81,7 +81,7 @@ static inline void release_thread(struct task_struct *dead_=
task)
=20
 extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->usp)
diff --git a/arch/csky/kernel/stacktrace.c b/arch/csky/kernel/stacktrace.c
index 1b280ef08004..9f78f5d21511 100644
--- a/arch/csky/kernel/stacktrace.c
+++ b/arch/csky/kernel/stacktrace.c
@@ -111,12 +111,11 @@ static bool save_wchan(unsigned long pc, void *arg)
 	return false;
 }
=20
-unsigned long get_wchan(struct task_struct *task)
+unsigned long __get_wchan(struct task_struct *task)
 {
 	unsigned long pc =3D 0;
=20
-	if (likely(task && task !=3D current && !task_is_running(task)))
-		walk_stackframe(task, NULL, save_wchan, &pc);
+	walk_stackframe(task, NULL, save_wchan, &pc);
 	return pc;
 }
=20
diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/proc=
essor.h
index a060b41b2d31..141a23eb62b7 100644
--- a/arch/h8300/include/asm/processor.h
+++ b/arch/h8300/include/asm/processor.h
@@ -105,7 +105,7 @@ static inline void release_thread(struct task_struct *dea=
d_task)
 {
 }
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 #define	KSTK_EIP(tsk)	\
 	({			 \
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 2ac27e4248a4..8833fa4f5d51 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -128,15 +128,12 @@ int copy_thread(unsigned long clone_flags, unsigned lon=
g usp,
 	return 0;
 }
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count =3D 0;
=20
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
-
 	stack_page =3D (unsigned long)p;
 	fp =3D ((struct pt_regs *)p->thread.ksp)->er6;
 	do {
diff --git a/arch/hexagon/include/asm/processor.h b/arch/hexagon/include/asm/=
processor.h
index 9f0cc99420be..615f7e49968e 100644
--- a/arch/hexagon/include/asm/processor.h
+++ b/arch/hexagon/include/asm/processor.h
@@ -64,7 +64,7 @@ struct thread_struct {
 extern void release_thread(struct task_struct *dead_task);
=20
 /* Get wait channel for task P.  */
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
=20
 /*  The following stuff is pretty HEXAGON specific.  */
=20
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 6a6835fb4242..232dfd8956aa 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -130,13 +130,11 @@ void flush_thread(void)
  * is an identification of the point at which the scheduler
  * was invoked by a blocked thread.
  */
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count =3D 0;
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
=20
 	stack_page =3D (unsigned long)task_stack_page(p);
 	fp =3D ((struct hexagon_switch_stack *)p->thread.switch_sp)->fp;
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/proces=
sor.h
index 2d8bcdc27d7f..45365c2ef598 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -330,7 +330,7 @@ struct task_struct;
 #define release_thread(dead_task)
=20
 /* Get wait channel for task P.  */
-extern unsigned long get_wchan (struct task_struct *p);
+extern unsigned long __get_wchan (struct task_struct *p);
=20
 /* Return instruction pointer of blocked task TSK.  */
 #define KSTK_EIP(tsk)					\
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index e56d63f4abf9..834df24a88f1 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -523,15 +523,12 @@ exit_thread (struct task_struct *tsk)
 }
=20
 unsigned long
-get_wchan (struct task_struct *p)
+__get_wchan (struct task_struct *p)
 {
 	struct unw_frame_info info;
 	unsigned long ip;
 	int count =3D 0;
=20
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
-
 	/*
 	 * Note: p may not be a blocked task (it could be current or
 	 * another process running on some other CPU.  Rather than
diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/proces=
sor.h
index f4d82c619a5c..ffeda9aa526a 100644
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -150,7 +150,7 @@ static inline void release_thread(struct task_struct *dea=
d_task)
 {
 }
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 #define	KSTK_EIP(tsk)	\
     ({			\
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 1ab692b952cd..a6030dbaa089 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -263,13 +263,11 @@ int dump_fpu (struct pt_regs *regs, struct user_m68kfp_=
struct *fpu)
 }
 EXPORT_SYMBOL(dump_fpu);
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count =3D 0;
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
=20
 	stack_page =3D (unsigned long)task_stack_page(p);
 	fp =3D ((struct switch_stack *)p->thread.ksp)->a6;
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/includ=
e/asm/processor.h
index 06c6e493590a..7e9e92670df3 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -68,7 +68,7 @@ static inline void release_thread(struct task_struct *dead_=
task)
 {
 }
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 /* The size allocated for kernel stacks. This _must_ be a power of two! */
 # define KERNEL_STACK_SIZE	0x2000
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/proces=
s.c
index 62aa237180b6..5e2b91c1e8ce 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -112,7 +112,7 @@ int copy_thread(unsigned long clone_flags, unsigned long =
usp, unsigned long arg,
 	return 0;
 }
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 /* TBD (used by procfs) */
 	return 0;
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/proces=
sor.h
index 0c3550c82b72..252ed38ce8c5 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -369,7 +369,7 @@ static inline void flush_thread(void)
 {
 }
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
 			 THREAD_SIZE - 32 - sizeof(struct pt_regs))
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 95aa86fa6077..cbff1b974f88 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -511,7 +511,7 @@ static int __init frame_info_init(void)
=20
 	/*
 	 * Without schedule() frame info, result given by
-	 * thread_saved_pc() and get_wchan() are not reliable.
+	 * thread_saved_pc() and __get_wchan() are not reliable.
 	 */
 	if (schedule_mfi.pc_offset < 0)
 		printk("Can't analyze schedule() prologue at %p\n", schedule);
@@ -652,9 +652,9 @@ unsigned long unwind_stack(struct task_struct *task, unsi=
gned long *sp,
 #endif
=20
 /*
- * get_wchan - a maintenance nightmare^W^Wpain in the ass ...
+ * __get_wchan - a maintenance nightmare^W^Wpain in the ass ...
  */
-unsigned long get_wchan(struct task_struct *task)
+unsigned long __get_wchan(struct task_struct *task)
 {
 	unsigned long pc =3D 0;
 #ifdef CONFIG_KALLSYMS
@@ -662,8 +662,6 @@ unsigned long get_wchan(struct task_struct *task)
 	unsigned long ra =3D 0;
 #endif
=20
-	if (!task || task =3D=3D current || task_is_running(task))
-		goto out;
 	if (!task_stack_page(task))
 		goto out;
=20
diff --git a/arch/nds32/include/asm/processor.h b/arch/nds32/include/asm/proc=
essor.h
index b82369c7659d..e6bfc74972bb 100644
--- a/arch/nds32/include/asm/processor.h
+++ b/arch/nds32/include/asm/processor.h
@@ -83,7 +83,7 @@ extern struct task_struct *last_task_used_math;
 /* Prepare to copy thread state - unlazy all lazy status */
 #define prepare_to_copy(tsk)	do { } while (0)
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 #define cpu_relax()			barrier()
=20
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 391895b54d13..49fab9e39cbf 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -233,15 +233,12 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t * fpu)
=20
 EXPORT_SYMBOL(dump_fpu);
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long fp, lr;
 	unsigned long stack_start, stack_end;
 	int count =3D 0;
=20
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
-
 	if (IS_ENABLED(CONFIG_FRAME_POINTER)) {
 		stack_start =3D (unsigned long)end_of_stack(p);
 		stack_end =3D (unsigned long)task_stack_page(p) + THREAD_SIZE;
@@ -258,5 +255,3 @@ unsigned long get_wchan(struct task_struct *p)
 	}
 	return 0;
 }
-
-EXPORT_SYMBOL(get_wchan);
diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/proc=
essor.h
index 94bcb86f679f..b8125dfbcad2 100644
--- a/arch/nios2/include/asm/processor.h
+++ b/arch/nios2/include/asm/processor.h
@@ -69,7 +69,7 @@ static inline void release_thread(struct task_struct *dead_=
task)
 {
 }
=20
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
=20
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 9ff37ba2bb60..f8ea522a1588 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -217,15 +217,12 @@ void dump(struct pt_regs *fp)
 	pr_emerg("\n\n");
 }
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count =3D 0;
=20
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
-
 	stack_page =3D (unsigned long)p;
 	fp =3D ((struct switch_stack *)p->thread.ksp)->fp;	/* ;dgt2 */
 	do {
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/as=
m/processor.h
index ad53b3184885..aa1699c18add 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -73,7 +73,7 @@ struct thread_struct {
=20
 void start_thread(struct pt_regs *regs, unsigned long nip, unsigned long sp);
 void release_thread(struct task_struct *);
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 #define cpu_relax()     barrier()
=20
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index b0698d9ce14f..3c0c91bcdcba 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -263,7 +263,7 @@ void dump_elf_thread(elf_greg_t *dest, struct pt_regs* re=
gs)
 	dest[35] =3D 0;
 }
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	/* TODO */
=20
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/pr=
ocessor.h
index eeb7da064289..85a2dbfe5278 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -273,7 +273,7 @@ struct mm_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
=20
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
=20
 #define KSTK_EIP(tsk)	((tsk)->thread.regs.iaoq[0])
 #define KSTK_ESP(tsk)	((tsk)->thread.regs.gr[30])
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 38ec4ae81239..4f562dee65a2 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -240,15 +240,12 @@ copy_thread(unsigned long clone_flags, unsigned long us=
p,
 }
=20
 unsigned long
-get_wchan(struct task_struct *p)
+__get_wchan(struct task_struct *p)
 {
 	struct unwind_frame_info info;
 	unsigned long ip;
 	int count =3D 0;
=20
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
-
 	/*
 	 * These bracket the sleeping functions..
 	 */
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/=
processor.h
index f348e564f7dd..e39bd0ff69f3 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -300,7 +300,7 @@ struct thread_struct {
=20
 #define task_pt_regs(tsk)	((tsk)->thread.regs)
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
 #define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 50436b52c213..406d7ee9e322 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2111,14 +2111,11 @@ int validate_sp(unsigned long sp, struct task_struct =
*p,
=20
 EXPORT_SYMBOL(validate_sp);
=20
-static unsigned long __get_wchan(struct task_struct *p)
+static unsigned long ___get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
 	int count =3D 0;
=20
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
-
 	sp =3D p->thread.ksp;
 	if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD))
 		return 0;
@@ -2137,14 +2134,14 @@ static unsigned long __get_wchan(struct task_struct *=
p)
 	return 0;
 }
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long ret;
=20
 	if (!try_get_task_stack(p))
 		return 0;
=20
-	ret =3D __get_wchan(p);
+	ret =3D ___get_wchan(p);
=20
 	put_task_stack(p);
=20
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/proc=
essor.h
index 46b492c78cbb..0749924d9e55 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -66,7 +66,7 @@ static inline void release_thread(struct task_struct *dead_=
task)
 {
 }
=20
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
=20
=20
 static inline void wait_for_interrupt(void)
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 315db3d0229b..0fcdc0233fac 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -128,16 +128,14 @@ static bool save_wchan(void *arg, unsigned long pc)
 	return true;
 }
=20
-unsigned long get_wchan(struct task_struct *task)
+unsigned long __get_wchan(struct task_struct *task)
 {
 	unsigned long pc =3D 0;
=20
-	if (likely(task && task !=3D current && !task_is_running(task))) {
-		if (!try_get_task_stack(task))
-			return 0;
-		walk_stackframe(task, NULL, save_wchan, &pc);
-		put_task_stack(task);
-	}
+	if (!try_get_task_stack(task))
+		return 0;
+	walk_stackframe(task, NULL, save_wchan, &pc);
+	put_task_stack(task);
 	return pc;
 }
=20
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/proces=
sor.h
index 879b8e3f609c..f54c152bf2bf 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -192,7 +192,7 @@ static inline void release_thread(struct task_struct *tsk=
) { }
 void guarded_storage_release(struct task_struct *tsk);
 void gs_load_bc_cb(struct pt_regs *regs);
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 #define task_pt_regs(tsk) ((struct pt_regs *) \
         (task_stack_page(tsk) + THREAD_SIZE) - 1)
 #define KSTK_EIP(tsk)	(task_pt_regs(tsk)->psw.addr)
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 350e94d0cac2..e5dd46b1bff8 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -181,12 +181,12 @@ void execve_tail(void)
 	asm volatile("sfpc %0" : : "d" (0));
 }
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	struct unwind_state state;
 	unsigned long ip =3D 0;
=20
-	if (!p || p =3D=3D current || task_is_running(p) || !task_stack_page(p))
+	if (!task_stack_page(p))
 		return 0;
=20
 	if (!try_get_task_stack(p))
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/process=
or_32.h
index aa92cc933889..45240ec6b85a 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -180,7 +180,7 @@ static inline void show_code(struct pt_regs *regs)
 }
 #endif
=20
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
=20
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->regs[15])
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 717de05c81f4..1c28e3cddb60 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -182,13 +182,10 @@ __switch_to(struct task_struct *prev, struct task_struc=
t *next)
 	return prev;
 }
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long pc;
=20
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
-
 	/*
 	 * The same comment as on the Alpha applies here, too ...
 	 */
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/p=
rocessor_32.h
index b6242f7771e9..647bf0ac7beb 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -89,7 +89,7 @@ static inline void start_thread(struct pt_regs * regs, unsi=
gned long pc,
 /* Free all resources held by a thread. */
 #define release_thread(tsk)		do { } while(0)
=20
-unsigned long get_wchan(struct task_struct *);
+unsigned long __get_wchan(struct task_struct *);
=20
 #define task_pt_regs(tsk) ((tsk)->thread.kregs)
 #define KSTK_EIP(tsk)  ((tsk)->thread.kregs->pc)
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/p=
rocessor_64.h
index 5cf145f18f36..ae851e8fce4c 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -183,7 +183,7 @@ do { \
 /* Free all resources held by a thread. */
 #define release_thread(tsk)		do { } while (0)
=20
-unsigned long get_wchan(struct task_struct *task);
+unsigned long __get_wchan(struct task_struct *task);
=20
 #define task_pt_regs(tsk) (task_thread_info(tsk)->kregs)
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->tpc)
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index bbbe0cfef746..2dc0bf9fe62e 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -365,7 +365,7 @@ int copy_thread(unsigned long clone_flags, unsigned long =
sp, unsigned long arg,
 	return 0;
 }
=20
-unsigned long get_wchan(struct task_struct *task)
+unsigned long __get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias =3D 0;
 	unsigned long task_base =3D (unsigned long) task;
@@ -373,9 +373,6 @@ unsigned long get_wchan(struct task_struct *task)
 	struct reg_window32 *rw;
 	int count =3D 0;
=20
-	if (!task || task =3D=3D current || task_is_running(task))
-		goto out;
-
 	fp =3D task_thread_info(task)->ksp + bias;
 	do {
 		/* Bogus frame pointer? */
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d1cc410d2f64..f5b2cac8669f 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -663,7 +663,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct =
task_struct *src)
 	return 0;
 }
=20
-unsigned long get_wchan(struct task_struct *task)
+unsigned long __get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias =3D 0;
 	struct thread_info *tp;
@@ -671,9 +671,6 @@ unsigned long get_wchan(struct task_struct *task)
         unsigned long ret =3D 0;
 	int count =3D 0;=20
=20
-	if (!task || task =3D=3D current || task_is_running(task))
-		goto out;
-
 	tp =3D task_thread_info(task);
 	bias =3D STACK_BIAS;
 	fp =3D task_thread_info(task)->ksp + bias;
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/pr=
ocessor-generic.h
index b5cf0ed116d9..579692a40a55 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -106,6 +106,6 @@ extern struct cpuinfo_um boot_cpu_data;
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
=20
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
=20
 #endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 457a38db368b..82107373ac7e 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -364,14 +364,11 @@ unsigned long arch_align_stack(unsigned long sp)
 }
 #endif
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long stack_page, sp, ip;
 	bool seen_sched =3D 0;
=20
-	if ((p =3D=3D NULL) || (p =3D=3D current) || task_is_running(p))
-		return 0;
-
 	stack_page =3D (unsigned long) task_stack_page(p);
 	/* Bail if the process has no kernel stack for some reason */
 	if (stack_page =3D=3D 0)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab83c22d274e..349e59b2f0e3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1001,6 +1001,17 @@ config NR_CPUS
 	  This is purely to save memory: each supported CPU adds about 8KB
 	  to the kernel image.
=20
+config SCHED_CLUSTER
+	bool "Cluster scheduler support"
+	depends on SMP
+	default y
+	help
+	  Cluster scheduler support improves the CPU scheduler's decision
+	  making when dealing with machines that have clusters of CPUs.
+	  Cluster usually means a couple of CPUs which are placed closely
+	  by sharing mid-level caches, last-level cache tags or internal
+	  busses.
+
 config SCHED_SMT
 	def_bool y if SMP
=20
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index 9ad2acaaae9b..e81177edc681 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -589,7 +589,7 @@ static inline void load_sp0(unsigned long sp0)
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
=20
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
=20
 /*
  * Generic CPUID function
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 630ff08532be..08b0e90623ad 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -16,7 +16,9 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 /* cpus sharing the last level cache: */
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
+DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
+DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
 DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
=20
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
@@ -24,6 +26,11 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 	return per_cpu(cpu_llc_shared_map, cpu);
 }
=20
+static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
+{
+	return per_cpu(cpu_l2c_shared_map, cpu);
+}
+
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid);
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 9239399e5491..cc164777e661 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -103,6 +103,7 @@ static inline void setup_node_to_cpumask_map(void) { }
 #include <asm-generic/topology.h>
=20
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
+extern const struct cpumask *cpu_clustergroup_mask(int cpu);
=20
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
@@ -113,7 +114,9 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern unsigned int __max_die_per_package;
=20
 #ifdef CONFIG_SMP
+#define topology_cluster_id(cpu)		(per_cpu(cpu_l2c_id, cpu))
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
+#define topology_cluster_cpumask(cpu)		(cpu_clustergroup_mask(cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
=20
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b5e36bd0425b..fe98a1465be6 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -846,6 +846,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 		l2 =3D new_l2;
 #ifdef CONFIG_SMP
 		per_cpu(cpu_llc_id, cpu) =3D l2_id;
+		per_cpu(cpu_l2c_id, cpu) =3D l2_id;
 #endif
 	}
=20
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f8885949e8c..1c7897c33327 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -85,6 +85,9 @@ u16 get_llc_id(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(get_llc_id);
=20
+/* L2 cache ID of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) =3D BAD_APICID;
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 1afbdd1dd777..9ff480e94511 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -198,7 +198,7 @@ void sched_set_itmt_core_prio(int prio, int core_cpu)
 		 * of the priority chain and only used when
 		 * all other high priority cpus are out of capacity.
 		 */
-		smt_prio =3D prio * smp_num_siblings / i;
+		smt_prio =3D prio * smp_num_siblings / (i * i);
 		per_cpu(sched_core_priority, cpu) =3D smt_prio;
 		i++;
 	}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..8fb6bd4cbc50 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -43,6 +43,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
 #include <asm/frame.h>
+#include <asm/unwind.h>
=20
 #include "process.h"
=20
@@ -942,60 +943,22 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
  * because the task might wake up and we might look at a stack
  * changing under us.
  */
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
-	unsigned long start, bottom, top, sp, fp, ip, ret =3D 0;
-	int count =3D 0;
+	struct unwind_state state;
+	unsigned long addr =3D 0;
=20
-	if (p =3D=3D current || task_is_running(p))
-		return 0;
-
-	if (!try_get_task_stack(p))
-		return 0;
-
-	start =3D (unsigned long)task_stack_page(p);
-	if (!start)
-		goto out;
-
-	/*
-	 * Layout of the stack page:
-	 *
-	 * ----------- topmax =3D start + THREAD_SIZE - sizeof(unsigned long)
-	 * PADDING
-	 * ----------- top =3D topmax - TOP_OF_KERNEL_STACK_PADDING
-	 * stack
-	 * ----------- bottom =3D start
-	 *
-	 * The tasks stack pointer points at the location where the
-	 * framepointer is stored. The data on the stack is:
-	 * ... IP FP ... IP FP
-	 *
-	 * We need to read FP and IP, so we need to adjust the upper
-	 * bound by another unsigned long.
-	 */
-	top =3D start + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
-	top -=3D 2 * sizeof(unsigned long);
-	bottom =3D start;
-
-	sp =3D READ_ONCE(p->thread.sp);
-	if (sp < bottom || sp > top)
-		goto out;
-
-	fp =3D READ_ONCE_NOCHECK(((struct inactive_task_frame *)sp)->bp);
-	do {
-		if (fp < bottom || fp > top)
-			goto out;
-		ip =3D READ_ONCE_NOCHECK(*(unsigned long *)(fp + sizeof(unsigned long)));
-		if (!in_sched_functions(ip)) {
-			ret =3D ip;
-			goto out;
-		}
-		fp =3D READ_ONCE_NOCHECK(*(unsigned long *)fp);
-	} while (count++ < 16 && !task_is_running(p));
+	for (unwind_start(&state, p, NULL, NULL); !unwind_done(&state);
+	     unwind_next_frame(&state)) {
+		addr =3D unwind_get_return_address(&state);
+		if (!addr)
+			break;
+		if (in_sched_functions(addr))
+			continue;
+		break;
+	}
=20
-out:
-	put_task_stack(p);
-	return ret;
+	return addr;
 }
=20
 long do_arch_prctl_common(struct task_struct *task, int option,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 85f6e242b6b4..f80f4595ed41 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,6 +101,8 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
=20
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
=20
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
+
 /* Per CPU bogomips and other parameters */
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
@@ -464,6 +466,21 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpui=
nfo_x86 *o)
 	return false;
 }
=20
+static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+{
+	int cpu1 =3D c->cpu_index, cpu2 =3D o->cpu_index;
+
+	/* If the arch didn't set up l2c_id, fall back to SMT */
+	if (per_cpu(cpu_l2c_id, cpu1) =3D=3D BAD_APICID)
+		return match_smt(c, o);
+
+	/* Do not match if L2 cache id does not match: */
+	if (per_cpu(cpu_l2c_id, cpu1) !=3D per_cpu(cpu_l2c_id, cpu2))
+		return false;
+
+	return topology_sane(c, o, "l2c");
+}
+
 /*
  * Unlike the other levels, we do not enforce keeping a
  * multicore group inside a NUMA node.  If this happens, we will
@@ -523,7 +540,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuin=
fo_x86 *o)
 }
=20
=20
-#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_MC)
+#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CO=
NFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
 	return sysctl_sched_itmt_enabled ? SD_ASYM_PACKING : 0;
@@ -541,12 +558,21 @@ static int x86_smt_flags(void)
 	return cpu_smt_flags() | x86_sched_itmt_flags();
 }
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+static int x86_cluster_flags(void)
+{
+	return cpu_cluster_flags() | x86_sched_itmt_flags();
+}
+#endif
 #endif
=20
 static struct sched_domain_topology_level x86_numa_in_package_topology[] =3D=
 {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
@@ -557,6 +583,9 @@ static struct sched_domain_topology_level x86_topology[] =
=3D {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
@@ -584,6 +613,7 @@ void set_cpu_sibling_map(int cpu)
 	if (!has_mp) {
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
+		cpumask_set_cpu(cpu, cpu_l2c_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
 		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
 		c->booted_cores =3D 1;
@@ -602,6 +632,9 @@ void set_cpu_sibling_map(int cpu)
 		if ((i =3D=3D cpu) || (has_mp && match_llc(c, o)))
 			link_mask(cpu_llc_shared_mask, cpu, i);
=20
+		if ((i =3D=3D cpu) || (has_mp && match_l2c(c, o)))
+			link_mask(cpu_l2c_shared_mask, cpu, i);
+
 		if ((i =3D=3D cpu) || (has_mp && match_die(c, o)))
 			link_mask(topology_die_cpumask, cpu, i);
 	}
@@ -652,6 +685,11 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 	return cpu_llc_shared_mask(cpu);
 }
=20
+const struct cpumask *cpu_clustergroup_mask(int cpu)
+{
+	return cpu_l2c_shared_mask(cpu);
+}
+
 static void impress_friends(void)
 {
 	int cpu;
@@ -1335,6 +1373,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cp=
us)
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
 	}
=20
 	/*
@@ -1564,7 +1603,10 @@ static void remove_siblinginfo(int cpu)
=20
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
 		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
+	for_each_cpu(sibling, cpu_l2c_shared_mask(cpu))
+		cpumask_clear_cpu(cpu, cpu_l2c_shared_mask(sibling));
 	cpumask_clear(cpu_llc_shared_mask(cpu));
+	cpumask_clear(cpu_l2c_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
 	cpumask_clear(topology_die_cpumask(cpu));
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/pr=
ocessor.h
index 7f63aca6a0d3..ad15fbc57283 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -215,7 +215,7 @@ struct mm_struct;
 /* Free all resources held by a thread. */
 #define release_thread(thread) do { } while(0)
=20
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
=20
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->areg[1])
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 060165340612..47f933fed870 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -298,15 +298,12 @@ int copy_thread(unsigned long clone_flags, unsigned lon=
g usp_thread_fn,
  * These bracket the sleeping functions..
  */
=20
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long sp, pc;
 	unsigned long stack_page =3D (unsigned long) task_stack_page(p);
 	int count =3D 0;
=20
-	if (!p || p =3D=3D current || task_is_running(p))
-		return 0;
-
 	sp =3D p->thread.sp;
 	pc =3D MAKE_PC_FROM_RA(p->thread.ra, p->thread.sp);
=20
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index fe69dc518f31..701f61c01359 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -746,6 +746,73 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
 					  ACPI_PPTT_PHYSICAL_PACKAGE);
 }
=20
+/**
+ * find_acpi_cpu_topology_cluster() - Determine a unique CPU cluster value
+ * @cpu: Kernel logical CPU number
+ *
+ * Determine a topology unique cluster ID for the given CPU/thread.
+ * This ID can then be used to group peers, which will have matching ids.
+ *
+ * The cluster, if present is the level of topology above CPUs. In a
+ * multi-thread CPU, it will be the level above the CPU, not the thread.
+ * It may not exist in single CPU systems. In simple multi-CPU systems,
+ * it may be equal to the package topology level.
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found
+ * or there is no toplogy level above the CPU..
+ * Otherwise returns a value which represents the package for this CPU.
+ */
+
+int find_acpi_cpu_topology_cluster(unsigned int cpu)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+	struct acpi_pptt_processor *cpu_node, *cluster_node;
+	u32 acpi_cpu_id;
+	int retval;
+	int is_thread;
+
+	status =3D acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		acpi_pptt_warn_missing();
+		return -ENOENT;
+	}
+
+	acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
+	cpu_node =3D acpi_find_processor_node(table, acpi_cpu_id);
+	if (cpu_node =3D=3D NULL || !cpu_node->parent) {
+		retval =3D -ENOENT;
+		goto put_table;
+	}
+
+	is_thread =3D cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD;
+	cluster_node =3D fetch_pptt_node(table, cpu_node->parent);
+	if (cluster_node =3D=3D NULL) {
+		retval =3D -ENOENT;
+		goto put_table;
+	}
+	if (is_thread) {
+		if (!cluster_node->parent) {
+			retval =3D -ENOENT;
+			goto put_table;
+		}
+		cluster_node =3D fetch_pptt_node(table, cluster_node->parent);
+		if (cluster_node =3D=3D NULL) {
+			retval =3D -ENOENT;
+			goto put_table;
+		}
+	}
+	if (cluster_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
+		retval =3D cluster_node->acpi_processor_id;
+	else
+		retval =3D ACPI_PTR_DIFF(cluster_node, table);
+
+put_table:
+	acpi_put_table(table);
+
+	return retval;
+}
+
 /**
  * find_acpi_cpu_topology_hetero_id() - Get a core architecture tag
  * @cpu: Kernel logical CPU number
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 43407665918f..fc0836f460fb 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -600,6 +600,11 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 	return core_mask;
 }
=20
+const struct cpumask *cpu_clustergroup_mask(int cpu)
+{
+	return &cpu_topology[cpu].cluster_sibling;
+}
+
 void update_siblings_masks(unsigned int cpuid)
 {
 	struct cpu_topology *cpu_topo, *cpuid_topo =3D &cpu_topology[cpuid];
@@ -617,6 +622,12 @@ void update_siblings_masks(unsigned int cpuid)
 		if (cpuid_topo->package_id !=3D cpu_topo->package_id)
 			continue;
=20
+		if (cpuid_topo->cluster_id =3D=3D cpu_topo->cluster_id &&
+		    cpuid_topo->cluster_id !=3D -1) {
+			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
+			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
+		}
+
 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
=20
@@ -635,6 +646,9 @@ static void clear_cpu_topology(int cpu)
 	cpumask_clear(&cpu_topo->llc_sibling);
 	cpumask_set_cpu(cpu, &cpu_topo->llc_sibling);
=20
+	cpumask_clear(&cpu_topo->cluster_sibling);
+	cpumask_set_cpu(cpu, &cpu_topo->cluster_sibling);
+
 	cpumask_clear(&cpu_topo->core_sibling);
 	cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
 	cpumask_clear(&cpu_topo->thread_sibling);
@@ -650,6 +664,7 @@ void __init reset_cpu_topology(void)
=20
 		cpu_topo->thread_id =3D -1;
 		cpu_topo->core_id =3D -1;
+		cpu_topo->cluster_id =3D -1;
 		cpu_topo->package_id =3D -1;
 		cpu_topo->llc_id =3D -1;
=20
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 43c0940643f5..8f2b641d0b8c 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -48,6 +48,9 @@ static DEVICE_ATTR_RO(physical_package_id);
 define_id_show_func(die_id);
 static DEVICE_ATTR_RO(die_id);
=20
+define_id_show_func(cluster_id);
+static DEVICE_ATTR_RO(cluster_id);
+
 define_id_show_func(core_id);
 static DEVICE_ATTR_RO(core_id);
=20
@@ -63,6 +66,10 @@ define_siblings_read_func(core_siblings, core_cpumask);
 static BIN_ATTR_RO(core_siblings, 0);
 static BIN_ATTR_RO(core_siblings_list, 0);
=20
+define_siblings_read_func(cluster_cpus, cluster_cpumask);
+static BIN_ATTR_RO(cluster_cpus, 0);
+static BIN_ATTR_RO(cluster_cpus_list, 0);
+
 define_siblings_read_func(die_cpus, die_cpumask);
 static BIN_ATTR_RO(die_cpus, 0);
 static BIN_ATTR_RO(die_cpus_list, 0);
@@ -94,6 +101,8 @@ static struct bin_attribute *bin_attrs[] =3D {
 	&bin_attr_thread_siblings_list,
 	&bin_attr_core_siblings,
 	&bin_attr_core_siblings_list,
+	&bin_attr_cluster_cpus,
+	&bin_attr_cluster_cpus_list,
 	&bin_attr_die_cpus,
 	&bin_attr_die_cpus_list,
 	&bin_attr_package_cpus,
@@ -112,6 +121,7 @@ static struct bin_attribute *bin_attrs[] =3D {
 static struct attribute *default_attrs[] =3D {
 	&dev_attr_physical_package_id.attr,
 	&dev_attr_die_id.attr,
+	&dev_attr_cluster_id.attr,
 	&dev_attr_core_id.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49be8c8ef555..77cf4187adec 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -541,7 +541,7 @@ static int do_task_stat(struct seq_file *m, struct pid_na=
mespace *ns,
 	}
=20
 	if (permitted && (!whole || num_threads < 2))
-		wchan =3D get_wchan(task);
+		wchan =3D !task_is_running(task);
 	if (!whole) {
 		min_flt =3D task->min_flt;
 		maj_flt =3D task->maj_flt;
@@ -606,10 +606,7 @@ static int do_task_stat(struct seq_file *m, struct pid_n=
amespace *ns,
 	 *
 	 * This works with older implementations of procps as well.
 	 */
-	if (wchan)
-		seq_puts(m, " 1");
-	else
-		seq_puts(m, " 0");
+	seq_put_decimal_ull(m, " ", wchan);
=20
 	seq_put_decimal_ull(m, " ", 0);
 	seq_put_decimal_ull(m, " ", 0);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 533d5836eb9a..1f394095eb88 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -67,6 +67,7 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/rcupdate.h>
+#include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
 #include <linux/resource.h>
 #include <linux/module.h>
@@ -386,17 +387,19 @@ static int proc_pid_wchan(struct seq_file *m, struct pi=
d_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
 	unsigned long wchan;
+	char symname[KSYM_NAME_LEN];
=20
-	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		wchan =3D get_wchan(task);
-	else
-		wchan =3D 0;
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+		goto print0;
=20
-	if (wchan)
-		seq_printf(m, "%ps", (void *) wchan);
-	else
-		seq_putc(m, '0');
+	wchan =3D get_wchan(task);
+	if (wchan && !lookup_symbol_name(wchan, symname)) {
+		seq_puts(m, symname);
+		return 0;
+	}
=20
+print0:
+	seq_putc(m, '0');
 	return 0;
 }
 #endif /* CONFIG_KALLSYMS */
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 6561a06ef905..4fb8729a68d4 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -24,7 +24,7 @@
=20
 #ifdef arch_idle_time
=20
-static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
+u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle;
=20
@@ -46,7 +46,7 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int =
cpu)
=20
 #else
=20
-static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
+u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle, idle_usecs =3D -1ULL;
=20
diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index 5a1b228964fb..deb99bc9b7e6 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -12,18 +12,22 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 {
 	struct timespec64 uptime;
 	struct timespec64 idle;
-	u64 nsec;
+	u64 idle_nsec;
 	u32 rem;
 	int i;
=20
-	nsec =3D 0;
-	for_each_possible_cpu(i)
-		nsec +=3D (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
+	idle_nsec =3D 0;
+	for_each_possible_cpu(i) {
+		struct kernel_cpustat kcs;
+
+		kcpustat_cpu_fetch(&kcs, i);
+		idle_nsec +=3D get_idle_time(&kcs, i);
+	}
=20
 	ktime_get_boottime_ts64(&uptime);
 	timens_add_boottime(&uptime);
=20
-	idle.tv_sec =3D div_u64_rem(nsec, NSEC_PER_SEC, &rem);
+	idle.tv_sec =3D div_u64_rem(idle_nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec =3D rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
 			(unsigned long) uptime.tv_sec,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 974d497a897d..fbc2146050a4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1353,6 +1353,7 @@ static inline int lpit_read_residency_count_address(u64=
 *address)
 #ifdef CONFIG_ACPI_PPTT
 int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
+int find_acpi_cpu_topology_cluster(unsigned int cpu);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
@@ -1365,6 +1366,10 @@ static inline int find_acpi_cpu_topology(unsigned int =
cpu, int level)
 {
 	return -EINVAL;
 }
+static inline int find_acpi_cpu_topology_cluster(unsigned int cpu)
+{
+	return -EINVAL;
+}
 static inline int find_acpi_cpu_topology_package(unsigned int cpu)
 {
 	return -EINVAL;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index f180240dc95f..b97cea83b25e 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -62,10 +62,12 @@ void topology_set_thermal_pressure(const struct cpumask *=
cpus,
 struct cpu_topology {
 	int thread_id;
 	int core_id;
+	int cluster_id;
 	int package_id;
 	int llc_id;
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
+	cpumask_t cluster_sibling;
 	cpumask_t llc_sibling;
 };
=20
@@ -73,13 +75,16 @@ struct cpu_topology {
 extern struct cpu_topology cpu_topology[NR_CPUS];
=20
 #define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
+#define topology_cluster_id(cpu)	(cpu_topology[cpu].cluster_id)
 #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
+#define topology_cluster_cpumask(cpu)	(&cpu_topology[cpu].cluster_sibling)
 #define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
+const struct cpumask *cpu_clustergroup_mask(int cpu);
 void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index ec2a47a81e42..8cd11a223260 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -3,6 +3,7 @@
 #define _LINUX_IRQ_WORK_H
=20
 #include <linux/smp_types.h>
+#include <linux/rcuwait.h>
=20
 /*
  * An entry can be in one of four states:
@@ -16,11 +17,13 @@
 struct irq_work {
 	struct __call_single_node node;
 	void (*func)(struct irq_work *);
+	struct rcuwait irqwait;
 };
=20
 #define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
 	.node =3D { .u_flags =3D (_flags), },			\
 	.func =3D (_func),					\
+	.irqwait =3D __RCUWAIT_INITIALIZER(irqwait),		\
 }
=20
 #define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
@@ -46,6 +49,11 @@ static inline bool irq_work_is_busy(struct irq_work *work)
 	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
 }
=20
+static inline bool irq_work_is_hard(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ;
+}
+
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
=20
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 44ae1a7eb9e3..69ae6b278464 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -102,6 +102,7 @@ extern void account_system_index_time(struct task_struct =
*, u64,
 				      enum cpu_usage_stat);
 extern void account_steal_time(u64);
 extern void account_idle_time(u64);
+extern u64 get_idle_time(struct kernel_cpustat *kcs, int cpu);
=20
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 static inline void account_process_tick(struct task_struct *tsk, int user)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7f8ee09c711f..e9672de22cf2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/cpumask.h>
 #include <linux/uprobes.h>
+#include <linux/rcupdate.h>
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
@@ -572,6 +573,9 @@ struct mm_struct {
 		bool tlb_flush_batched;
 #endif
 		struct uprobes_state uprobes_state;
+#ifdef CONFIG_PREEMPT_RT
+		struct rcu_head delayed_drop;
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 		atomic_long_t hugetlb_usage;
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c1a927ddec64..5f8db54226af 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -503,6 +503,8 @@ struct sched_statistics {
=20
 	u64				block_start;
 	u64				block_max;
+	s64				sum_block_runtime;
+
 	u64				exec_max;
 	u64				slice_max;
=20
@@ -522,7 +524,7 @@ struct sched_statistics {
 	u64				nr_wakeups_passive;
 	u64				nr_wakeups_idle;
 #endif
-};
+} ____cacheline_aligned;
=20
 struct sched_entity {
 	/* For load-balancing: */
@@ -538,8 +540,6 @@ struct sched_entity {
=20
 	u64				nr_migrations;
=20
-	struct sched_statistics		statistics;
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
 	struct sched_entity		*parent;
@@ -775,10 +775,10 @@ struct task_struct {
 	int				normal_prio;
 	unsigned int			rt_priority;
=20
-	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
 	struct sched_dl_entity		dl;
+	const struct sched_class	*sched_class;
=20
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
@@ -803,6 +803,8 @@ struct task_struct {
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
=20
+	struct sched_statistics         stats;
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
 	struct hlist_head		preempt_notifiers;
@@ -2137,6 +2139,7 @@ static inline void set_task_cpu(struct task_struct *p, =
unsigned int cpu)
 #endif /* CONFIG_SMP */
=20
 extern bool sched_task_on_rq(struct task_struct *p);
+extern unsigned long get_wchan(struct task_struct *p);
=20
 /*
  * In order to reduce various lock holder preemption latencies provide an
diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 22873d276be6..d73d314d59c6 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -11,7 +11,11 @@ enum cpu_idle_type {
 	CPU_MAX_IDLE_TYPES
 };
=20
+#ifdef CONFIG_SMP
 extern void wake_up_if_idle(int cpu);
+#else
+static inline void wake_up_if_idle(int cpu) { }
+#endif
=20
 /*
  * Idle thread specific functions to determine the need_resched
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 5561486fddef..aca874d33fe6 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,6 +49,35 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * RCU callback for delayed mm drop. Not strictly RCU, but call_rcu() is
+ * by far the least expensive way to do that.
+ */
+static inline void __mmdrop_delayed(struct rcu_head *rhp)
+{
+	struct mm_struct *mm =3D container_of(rhp, struct mm_struct, delayed_drop);
+
+	__mmdrop(mm);
+}
+
+/*
+ * Invoked from finish_task_switch(). Delegates the heavy lifting on RT
+ * kernels via RCU.
+ */
+static inline void mmdrop_sched(struct mm_struct *mm)
+{
+	/* Provides a full memory barrier. See mmdrop() */
+	if (atomic_dec_and_test(&mm->mm_count))
+		call_rcu(&mm->delayed_drop, __mmdrop_delayed);
+}
+#else
+static inline void mmdrop_sched(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+#endif
+
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ef02be869cf2..ba88a6987400 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -54,7 +54,8 @@ extern asmlinkage void schedule_tail(struct task_struct *pr=
ev);
 extern void init_idle(struct task_struct *idle, int cpu);
=20
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
-extern void sched_post_fork(struct task_struct *p);
+extern void sched_post_fork(struct task_struct *p,
+			    struct kernel_clone_args *kargs);
 extern void sched_dead(struct task_struct *p);
=20
 void __noreturn do_task_dead(void);
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778b7c91..c07bfa2d80f2 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -42,6 +42,13 @@ static inline int cpu_smt_flags(void)
 }
 #endif
=20
+#ifdef CONFIG_SCHED_CLUSTER
+static inline int cpu_cluster_flags(void)
+{
+	return SD_SHARE_PKG_RESOURCES;
+}
+#endif
+
 #ifdef CONFIG_SCHED_MC
 static inline int cpu_core_flags(void)
 {
@@ -98,7 +105,7 @@ struct sched_domain {
=20
 	/* idle_balance() stats */
 	u64 max_newidle_lb_cost;
-	unsigned long next_decay_max_lb_cost;
+	unsigned long last_decay_max_lb_cost;
=20
 	u64 avg_scan_cost;		/* select_idle_sibling */
=20
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 7634cd737061..0b3704ad13c8 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -186,6 +186,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_die_id
 #define topology_die_id(cpu)			((void)(cpu), -1)
 #endif
+#ifndef topology_cluster_id
+#define topology_cluster_id(cpu)		((void)(cpu), -1)
+#endif
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
 #endif
@@ -195,6 +198,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_core_cpumask
 #define topology_core_cpumask(cpu)		cpumask_of(cpu)
 #endif
+#ifndef topology_cluster_cpumask
+#define topology_cluster_cpumask(cpu)		cpumask_of(cpu)
+#endif
 #ifndef topology_die_cpumask
 #define topology_die_cpumask(cpu)		cpumask_of(cpu)
 #endif
@@ -206,6 +212,13 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
 }
 #endif
=20
+#if defined(CONFIG_SCHED_CLUSTER) && !defined(cpu_cluster_mask)
+static inline const struct cpumask *cpu_cluster_mask(int cpu)
+{
+	return topology_cluster_cpumask(cpu);
+}
+#endif
+
 static inline const struct cpumask *cpu_cpu_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 93dab0e9580f..2d0df57c9902 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1160,6 +1160,7 @@ int autoremove_wake_function(struct wait_queue_entry *w=
q_entry, unsigned mode, i
 		(wait)->flags =3D 0;						\
 	} while (0)
=20
-bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(stru=
ct task_struct *t, void *arg), void *arg);
+typedef int (*task_call_f)(struct task_struct *p, void *arg);
+extern int task_call_func(struct task_struct *p, task_call_f func, void *arg=
);
=20
 #endif /* _LINUX_WAIT_H */
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 5876e30c5740..60f1bfc3c7b2 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -2,10 +2,11 @@
=20
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE
+	default PREEMPT_NONE_BEHAVIOUR
=20
-config PREEMPT_NONE
+config PREEMPT_NONE_BEHAVIOUR
 	bool "No Forced Preemption (Server)"
+	select PREEMPT_NONE if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -17,9 +18,10 @@ config PREEMPT_NONE
 	  raw processing power of the kernel, irrespective of scheduling
 	  latencies.
=20
-config PREEMPT_VOLUNTARY
+config PREEMPT_VOLUNTARY_BEHAVIOUR
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
+	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -35,12 +37,10 @@ config PREEMPT_VOLUNTARY
=20
 	  Select this if you are building a kernel for a desktop system.
=20
-config PREEMPT
+config PREEMPT_BEHAVIOUR
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
+	select PREEMPT
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -58,7 +58,7 @@ config PREEMPT
=20
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT
+	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -75,6 +75,17 @@ config PREEMPT_RT
=20
 endchoice
=20
+config PREEMPT_NONE
+	bool
+
+config PREEMPT_VOLUNTARY
+	bool
+
+config PREEMPT
+	bool
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+
 config PREEMPT_COUNT
        bool
=20
@@ -83,7 +94,10 @@ config PREEMPTION
        select PREEMPT_COUNT
=20
 config PREEMPT_DYNAMIC
-	bool
+	bool "Preemption behaviour defined on boot"
+	depends on HAVE_PREEMPT_DYNAMIC
+	select PREEMPT
+	default y
 	help
 	  This option allows to define the preemption model on the kernel
 	  command line parameter and thus override the default preemption
diff --git a/kernel/exit.c b/kernel/exit.c
index 91a43e57a32e..63851320ae73 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -64,6 +64,7 @@
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
 #include <linux/io_uring.h>
+#include <linux/kprobes.h>
=20
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -168,6 +169,7 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 {
 	struct task_struct *tsk =3D container_of(rhp, struct task_struct, rcu);
=20
+	kprobe_flush_task(tsk);
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
 	put_task_struct(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..0e4251dc5436 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2405,7 +2405,7 @@ static __latent_entropy struct task_struct *copy_proces=
s(
 	write_unlock_irq(&tasklist_lock);
=20
 	proc_fork_connector(p);
-	sched_post_fork(p);
+	sched_post_fork(p, args);
 	cgroup_post_fork(p, args);
 	perf_event_fork(p);
=20
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index db8c248ebc8c..f7df715ec28e 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -18,11 +18,36 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/smpboot.h>
 #include <asm/processor.h>
 #include <linux/kasan.h>
=20
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
+static DEFINE_PER_CPU(struct task_struct *, irq_workd);
+
+static void wake_irq_workd(void)
+{
+	struct task_struct *tsk =3D __this_cpu_read(irq_workd);
+
+	if (!llist_empty(this_cpu_ptr(&lazy_list)) && tsk)
+		wake_up_process(tsk);
+}
+
+#ifdef CONFIG_SMP
+static void irq_work_wake(struct irq_work *entry)
+{
+	wake_irq_workd();
+}
+
+static DEFINE_PER_CPU(struct irq_work, irq_work_wakeup) =3D
+	IRQ_WORK_INIT_HARD(irq_work_wake);
+#endif
+
+static int irq_workd_should_run(unsigned int cpu)
+{
+	return !llist_empty(this_cpu_ptr(&lazy_list));
+}
=20
 /*
  * Claim the entry so that no one else will poke at it.
@@ -52,15 +77,29 @@ void __weak arch_irq_work_raise(void)
 /* Enqueue on current CPU, work must already be claimed and preempt disabled=
 */
 static void __irq_work_queue_local(struct irq_work *work)
 {
+	struct llist_head *list;
+	bool rt_lazy_work =3D false;
+	bool lazy_work =3D false;
+	int work_flags;
+
+	work_flags =3D atomic_read(&work->node.a_flags);
+	if (work_flags & IRQ_WORK_LAZY)
+		lazy_work =3D true;
+	else if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		 !(work_flags & IRQ_WORK_HARD_IRQ))
+		rt_lazy_work =3D true;
+
+	if (lazy_work || rt_lazy_work)
+		list =3D this_cpu_ptr(&lazy_list);
+	else
+		list =3D this_cpu_ptr(&raised_list);
+
+	if (!llist_add(&work->node.llist, list))
+		return;
+
 	/* If the work is "lazy", handle it from next tick if any */
-	if (atomic_read(&work->node.a_flags) & IRQ_WORK_LAZY) {
-		if (llist_add(&work->node.llist, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->node.llist, this_cpu_ptr(&raised_list)))
-			arch_irq_work_raise();
-	}
+	if (!lazy_work || tick_nohz_tick_stopped())
+		arch_irq_work_raise();
 }
=20
 /* Enqueue the irq work @work on the current CPU */
@@ -104,17 +143,34 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (cpu !=3D smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
+
+		/*
+		 * On PREEMPT_RT the items which are not marked as
+		 * IRQ_WORK_HARD_IRQ are added to the lazy list and a HARD work
+		 * item is used on the remote CPU to wake the thread.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		    !(atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ)) {
+
+			if (!llist_add(&work->node.llist, &per_cpu(lazy_list, cpu)))
+				goto out;
+
+			work =3D &per_cpu(irq_work_wakeup, cpu);
+			if (!irq_work_claim(work))
+				goto out;
+		}
+
 		__smp_call_single_queue(cpu, &work->node.llist);
 	} else {
 		__irq_work_queue_local(work);
 	}
+out:
 	preempt_enable();
=20
 	return true;
 #endif /* CONFIG_SMP */
 }
=20
-
 bool irq_work_needs_cpu(void)
 {
 	struct llist_head *raised, *lazy;
@@ -160,6 +216,10 @@ void irq_work_single(void *arg)
 	 * else claimed it meanwhile.
 	 */
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
+
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt())
+		rcuwait_wake_up(&work->irqwait);
 }
=20
 static void irq_work_run_list(struct llist_head *list)
@@ -167,7 +227,12 @@ static void irq_work_run_list(struct llist_head *list)
 	struct irq_work *work, *tmp;
 	struct llist_node *llnode;
=20
-	BUG_ON(!irqs_disabled());
+	/*
+	 * On PREEMPT_RT IRQ-work which is not marked as HARD will be processed
+	 * in a per-CPU thread in preemptible context. Only the items which are
+	 * marked as IRQ_WORK_HARD_IRQ will be processed in hardirq context.
+	 */
+	BUG_ON(!irqs_disabled() && !IS_ENABLED(CONFIG_PREEMPT_RT));
=20
 	if (llist_empty(list))
 		return;
@@ -184,7 +249,10 @@ static void irq_work_run_list(struct llist_head *list)
 void irq_work_run(void)
 {
 	irq_work_run_list(this_cpu_ptr(&raised_list));
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
=20
@@ -194,7 +262,11 @@ void irq_work_tick(void)
=20
 	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
=20
 /*
@@ -204,8 +276,42 @@ void irq_work_tick(void)
 void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
+	might_sleep();
+
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt()) {
+		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
+				   TASK_UNINTERRUPTIBLE);
+		return;
+	}
=20
 	while (irq_work_is_busy(work))
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
+
+static void run_irq_workd(unsigned int cpu)
+{
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
+}
+
+static void irq_workd_setup(unsigned int cpu)
+{
+	sched_set_fifo_low(current);
+}
+
+static struct smp_hotplug_thread irqwork_threads =3D {
+	.store                  =3D &irq_workd,
+	.setup			=3D irq_workd_setup,
+	.thread_should_run      =3D irq_workd_should_run,
+	.thread_fn              =3D run_irq_workd,
+	.thread_comm            =3D "irq_work/%u",
+};
+
+static __init int irq_work_init_threads(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		BUG_ON(smpboot_register_percpu_thread(&irqwork_threads));
+	return 0;
+}
+early_initcall(irq_work_init_threads);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 790a573bbe00..9a38e7581a5c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1250,10 +1250,10 @@ void kprobe_busy_end(void)
 }
=20
 /*
- * This function is called from finish_task_switch when task tk becomes dead,
- * so that we can recycle any function-return probe instances associated
- * with this task. These left over instances represent probed functions
- * that have been called but will never return.
+ * This function is called from delayed_put_task_struct() when a task is
+ * dead and cleaned up to recycle any function-return probe instances
+ * associated with this task. These left over instances represent probed
+ * functions that have been called but will never return.
  */
 void kprobe_flush_task(struct task_struct *tk)
 {
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5b37a8567168..4a4d7092a2d8 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -270,6 +270,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
=20
 static int kthread(void *_create)
 {
+	static const struct sched_param param =3D { .sched_priority =3D 0 };
 	/* Copy data: it's on kthread's stack */
 	struct kthread_create_info *create =3D _create;
 	int (*threadfn)(void *data) =3D create->threadfn;
@@ -300,6 +301,13 @@ static int kthread(void *_create)
 	init_completion(&self->parked);
 	current->vfork_done =3D &self->exited;
=20
+	/*
+	 * The new thread inherited kthreadd's priority and CPU mask. Reset
+	 * back to default in case they have been changed.
+	 */
+	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
+	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_KTHREAD));
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	create->result =3D current;
@@ -397,7 +405,6 @@ struct task_struct *__kthread_create_on_node(int (*thread=
fn)(void *data),
 	}
 	task =3D create->result;
 	if (!IS_ERR(task)) {
-		static const struct sched_param param =3D { .sched_priority =3D 0 };
 		char name[TASK_COMM_LEN];
=20
 		/*
@@ -406,13 +413,6 @@ struct task_struct *__kthread_create_on_node(int (*threa=
dfn)(void *data),
 		 */
 		vsnprintf(name, sizeof(name), namefmt, args);
 		set_task_comm(task, name);
-		/*
-		 * root may have changed our (kthreadd's) priority or CPU mask.
-		 * The kernel thread should not inherit these properties.
-		 */
-		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task,
-				     housekeeping_cpumask(HK_FLAG_KTHREAD));
 	}
 	kfree(create);
 	return task;
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 291b857a6e20..5683ac0d2566 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -13,7 +13,6 @@
 #include "core.h"
 #include "patch.h"
 #include "transition.h"
-#include "../sched/sched.h"
=20
 #define MAX_STACK_ENTRIES  100
 #define STACK_ERR_BUF_SIZE 128
@@ -240,7 +239,7 @@ static int klp_check_stack_func(struct klp_func *func, un=
signed long *entries,
  * Determine whether it's safe to transition the task to the target patch st=
ate
  * by looking for any to-be-patched or to-be-unpatched functions on its stac=
k.
  */
-static int klp_check_stack(struct task_struct *task, char *err_buf)
+static int klp_check_stack(struct task_struct *task, const char **oldname)
 {
 	static unsigned long entries[MAX_STACK_ENTRIES];
 	struct klp_object *obj;
@@ -248,12 +247,8 @@ static int klp_check_stack(struct task_struct *task, cha=
r *err_buf)
 	int ret, nr_entries;
=20
 	ret =3D stack_trace_save_tsk_reliable(task, entries, ARRAY_SIZE(entries));
-	if (ret < 0) {
-		snprintf(err_buf, STACK_ERR_BUF_SIZE,
-			 "%s: %s:%d has an unreliable stack\n",
-			 __func__, task->comm, task->pid);
-		return ret;
-	}
+	if (ret < 0)
+		return -EINVAL;
 	nr_entries =3D ret;
=20
 	klp_for_each_object(klp_transition_patch, obj) {
@@ -262,11 +257,8 @@ static int klp_check_stack(struct task_struct *task, cha=
r *err_buf)
 		klp_for_each_func(obj, func) {
 			ret =3D klp_check_stack_func(func, entries, nr_entries);
 			if (ret) {
-				snprintf(err_buf, STACK_ERR_BUF_SIZE,
-					 "%s: %s:%d is sleeping on function %s\n",
-					 __func__, task->comm, task->pid,
-					 func->old_name);
-				return ret;
+				*oldname =3D func->old_name;
+				return -EADDRINUSE;
 			}
 		}
 	}
@@ -274,6 +266,22 @@ static int klp_check_stack(struct task_struct *task, cha=
r *err_buf)
 	return 0;
 }
=20
+static int klp_check_and_switch_task(struct task_struct *task, void *arg)
+{
+	int ret;
+
+	if (task_curr(task) && task !=3D current)
+		return -EBUSY;
+
+	ret =3D klp_check_stack(task, arg);
+	if (ret)
+		return ret;
+
+	clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
+	task->patch_state =3D klp_target_state;
+	return 0;
+}
+
 /*
  * Try to safely switch a task to the target patch state.  If it's currently
  * running, or it's sleeping on a to-be-patched or to-be-unpatched function,=
 or
@@ -281,13 +289,8 @@ static int klp_check_stack(struct task_struct *task, cha=
r *err_buf)
  */
 static bool klp_try_switch_task(struct task_struct *task)
 {
-	static char err_buf[STACK_ERR_BUF_SIZE];
-	struct rq *rq;
-	struct rq_flags flags;
+	const char *old_name;
 	int ret;
-	bool success =3D false;
-
-	err_buf[0] =3D '\0';
=20
 	/* check if this task has already switched over */
 	if (task->patch_state =3D=3D klp_target_state)
@@ -305,36 +308,31 @@ static bool klp_try_switch_task(struct task_struct *tas=
k)
 	 * functions.  If all goes well, switch the task to the target patch
 	 * state.
 	 */
-	rq =3D task_rq_lock(task, &flags);
+	ret =3D task_call_func(task, klp_check_and_switch_task, &old_name);
+	switch (ret) {
+	case 0:		/* success */
+		break;
=20
-	if (task_running(rq, task) && task !=3D current) {
-		snprintf(err_buf, STACK_ERR_BUF_SIZE,
-			 "%s: %s:%d is running\n", __func__, task->comm,
-			 task->pid);
-		goto done;
+	case -EBUSY:	/* klp_check_and_switch_task() */
+		pr_debug("%s: %s:%d is running\n",
+			 __func__, task->comm, task->pid);
+		break;
+	case -EINVAL:	/* klp_check_and_switch_task() */
+		pr_debug("%s: %s:%d has an unreliable stack\n",
+			 __func__, task->comm, task->pid);
+		break;
+	case -EADDRINUSE: /* klp_check_and_switch_task() */
+		pr_debug("%s: %s:%d is sleeping on function %s\n",
+			 __func__, task->comm, task->pid, old_name);
+		break;
+
+	default:
+		pr_debug("%s: Unknown error code (%d) when trying to switch %s:%d\n",
+			 __func__, ret, task->comm, task->pid);
+		break;
 	}
=20
-	ret =3D klp_check_stack(task, err_buf);
-	if (ret)
-		goto done;
-
-	success =3D true;
-
-	clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
-	task->patch_state =3D klp_target_state;
-
-done:
-	task_rq_unlock(rq, task, &flags);
-
-	/*
-	 * Due to console deadlock issues, pr_debug() can't be used while
-	 * holding the task rq lock.  Instead we have to use a temporary buffer
-	 * and print the debug message after releasing the lock.
-	 */
-	if (err_buf[0] !=3D '\0')
-		pr_debug("%s", err_buf);
-
-	return success;
+	return !ret;
 }
=20
 /*
@@ -415,8 +413,11 @@ void klp_try_complete_transition(void)
 	for_each_possible_cpu(cpu) {
 		task =3D idle_task(cpu);
 		if (cpu_online(cpu)) {
-			if (!klp_try_switch_task(task))
+			if (!klp_try_switch_task(task)) {
 				complete =3D false;
+				/* Make idle task go through the main loop. */
+				wake_up_if_idle(cpu);
+			}
 		} else if (task->patch_state !=3D klp_target_state) {
 			/* offline idle tasks can be switched immediately */
 			clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 806160c44b17..171bc848e8e3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -928,7 +928,7 @@ static void trc_read_check_handler(void *t_in)
 }
=20
 /* Callback function for scheduler to check locked-down task.  */
-static bool trc_inspect_reader(struct task_struct *t, void *arg)
+static int trc_inspect_reader(struct task_struct *t, void *arg)
 {
 	int cpu =3D task_cpu(t);
 	bool in_qs =3D false;
@@ -939,7 +939,7 @@ static bool trc_inspect_reader(struct task_struct *t, voi=
d *arg)
=20
 		// If no chance of heavyweight readers, do it the hard way.
 		if (!ofl && !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
-			return false;
+			return -EINVAL;
=20
 		// If heavyweight readers are enabled on the remote task,
 		// we can inspect its state despite its currently running.
@@ -947,7 +947,7 @@ static bool trc_inspect_reader(struct task_struct *t, voi=
d *arg)
 		n_heavy_reader_attempts++;
 		if (!ofl && // Check for "running" idle tasks on offline CPUs.
 		    !rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
-			return false; // No quiescent state, do it the hard way.
+			return -EINVAL; // No quiescent state, do it the hard way.
 		n_heavy_reader_updates++;
 		if (ofl)
 			n_heavy_reader_ofl_updates++;
@@ -962,7 +962,7 @@ static bool trc_inspect_reader(struct task_struct *t, voi=
d *arg)
 	t->trc_reader_checked =3D true;
=20
 	if (in_qs)
-		return true;  // Already in quiescent state, done!!!
+		return 0;  // Already in quiescent state, done!!!
=20
 	// The task is in a read-side critical section, so set up its
 	// state so that it will awaken the grace-period kthread upon exit
@@ -970,7 +970,7 @@ static bool trc_inspect_reader(struct task_struct *t, voi=
d *arg)
 	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
 	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
-	return true;
+	return 0;
 }
=20
 /* Attempt to extract the state for the specified task. */
@@ -992,7 +992,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
=20
 	// Attempt to nail down the task for inspection.
 	get_task_struct(t);
-	if (try_invoke_on_locked_down_task(t, trc_inspect_reader, NULL)) {
+	if (!task_call_func(t, trc_inspect_reader, NULL)) {
 		put_task_struct(t);
 		return;
 	}
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 677ee3d8671b..5e2fa6fd97f1 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -240,16 +240,16 @@ struct rcu_stall_chk_rdr {
  * Report out the state of a not-running task that is stalling the
  * current RCU grace period.
  */
-static bool check_slow_task(struct task_struct *t, void *arg)
+static int check_slow_task(struct task_struct *t, void *arg)
 {
 	struct rcu_stall_chk_rdr *rscrp =3D arg;
=20
 	if (task_curr(t))
-		return false; // It is running, so decline to inspect it.
+		return -EBUSY; // It is running, so decline to inspect it.
 	rscrp->nesting =3D t->rcu_read_lock_nesting;
 	rscrp->rs =3D t->rcu_read_unlock_special;
 	rscrp->on_blkd_list =3D !list_empty(&t->rcu_node_entry);
-	return true;
+	return 0;
 }
=20
 /*
@@ -283,7 +283,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, uns=
igned long flags)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	while (i) {
 		t =3D ts[--i];
-		if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
+		if (task_call_func(t, check_slow_task, &rscr))
 			pr_cont(" P%d", t->pid);
 		else
 			pr_cont(" P%d/%d:%c%c%c%c",
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 978fcfca5871..c7421f2d05e1 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -3,6 +3,10 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_clock.o =3D $(CC_FLAGS_FTRACE)
 endif
=20
+# The compilers are complaining about unused variables inside an if(0) scope
+# block. This is daft, shut them up.
+ccflags-y +=3D $(call cc-disable-warning, unused-but-set-variable)
+
 # These files are disabled because they produce non-interesting flaky covera=
ge
 # that is not a function of syscall inputs. E.g. involuntary context switche=
s.
 KCOV_INSTRUMENT :=3D n
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba4128a3e6..f2611b9cf503 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -74,7 +74,11 @@ __read_mostly int sysctl_resched_latency_warn_once =3D 1;
  * Number of tasks to iterate in a single balance run.
  * Limited because this is done with IRQs disabled.
  */
+#ifdef CONFIG_PREEMPT_RT
+const_debug unsigned int sysctl_sched_nr_migrate =3D 8;
+#else
 const_debug unsigned int sysctl_sched_nr_migrate =3D 32;
+#endif
=20
 /*
  * period over which we measure -rt task CPU usage in us.
@@ -1962,6 +1966,25 @@ bool sched_task_on_rq(struct task_struct *p)
 	return task_on_rq_queued(p);
 }
=20
+unsigned long get_wchan(struct task_struct *p)
+{
+	unsigned long ip =3D 0;
+	unsigned int state;
+
+	if (!p || p =3D=3D current)
+		return 0;
+
+	/* Only get wchan if task is blocked and we can keep it that way. */
+	raw_spin_lock_irq(&p->pi_lock);
+	state =3D READ_ONCE(p->__state);
+	smp_rmb(); /* see try_to_wake_up() */
+	if (state !=3D TASK_RUNNING && state !=3D TASK_WAKING && !p->on_rq)
+		ip =3D __get_wchan(p);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	return ip;
+}
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int fl=
ags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
@@ -3251,7 +3274,7 @@ unsigned long wait_task_inactive(struct task_struct *p,=
 unsigned int match_state
 			ktime_t to =3D NSEC_PER_SEC / HZ;
=20
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
 			continue;
 		}
=20
@@ -3489,11 +3512,11 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_fl=
ags)
 #ifdef CONFIG_SMP
 	if (cpu =3D=3D rq->cpu) {
 		__schedstat_inc(rq->ttwu_local);
-		__schedstat_inc(p->se.statistics.nr_wakeups_local);
+		__schedstat_inc(p->stats.nr_wakeups_local);
 	} else {
 		struct sched_domain *sd;
=20
-		__schedstat_inc(p->se.statistics.nr_wakeups_remote);
+		__schedstat_inc(p->stats.nr_wakeups_remote);
 		rcu_read_lock();
 		for_each_domain(rq->cpu, sd) {
 			if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
@@ -3505,14 +3528,14 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_fl=
ags)
 	}
=20
 	if (wake_flags & WF_MIGRATED)
-		__schedstat_inc(p->se.statistics.nr_wakeups_migrate);
+		__schedstat_inc(p->stats.nr_wakeups_migrate);
 #endif /* CONFIG_SMP */
=20
 	__schedstat_inc(rq->ttwu_count);
-	__schedstat_inc(p->se.statistics.nr_wakeups);
+	__schedstat_inc(p->stats.nr_wakeups);
=20
 	if (wake_flags & WF_SYNC)
-		__schedstat_inc(p->se.statistics.nr_wakeups_sync);
+		__schedstat_inc(p->stats.nr_wakeups_sync);
 }
=20
 /*
@@ -3691,15 +3714,11 @@ void wake_up_if_idle(int cpu)
 	if (!is_idle_task(rcu_dereference(rq->curr)))
 		goto out;
=20
-	if (set_nr_if_polling(rq->idle)) {
-		trace_sched_wake_idle_without_ipi(cpu);
-	} else {
-		rq_lock_irqsave(rq, &rf);
-		if (is_idle_task(rq->curr))
-			smp_send_reschedule(cpu);
-		/* Else CPU is not idle, do nothing here: */
-		rq_unlock_irqrestore(rq, &rf);
-	}
+	rq_lock_irqsave(rq, &rf);
+	if (is_idle_task(rq->curr))
+		resched_curr(rq);
+	/* Else CPU is not idle, do nothing here: */
+	rq_unlock_irqrestore(rq, &rf);
=20
 out:
 	rcu_read_unlock();
@@ -4106,46 +4125,61 @@ try_to_wake_up(struct task_struct *p, unsigned int st=
ate, int wake_flags)
 }
=20
 /**
- * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
+ * task_call_func - Invoke a function on task in fixed state
  * @p: Process for which the function is to be invoked, can be @current.
  * @func: Function to invoke.
  * @arg: Argument to function.
  *
- * If the specified task can be quickly locked into a definite state
- * (either sleeping or on a given runqueue), arrange to keep it in that
- * state while invoking @func(@arg).  This function can use ->on_rq and
- * task_curr() to work out what the state is, if required.  Given that
- * @func can be invoked with a runqueue lock held, it had better be quite
- * lightweight.
+ * Fix the task in it's current state by avoiding wakeups and or rq operatio=
ns
+ * and call @func(@arg) on it.  This function can use ->on_rq and task_curr()
+ * to work out what the state is, if required.  Given that @func can be invo=
ked
+ * with a runqueue lock held, it had better be quite lightweight.
  *
  * Returns:
- *	@false if the task slipped out from under the locks.
- *	@true if the task was locked onto a runqueue or is sleeping.
- *		However, @func can override this by returning @false.
+ *   Whatever @func returns
  */
-bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(stru=
ct task_struct *t, void *arg), void *arg)
+int task_call_func(struct task_struct *p, task_call_f func, void *arg)
 {
+	struct rq *rq =3D NULL;
+	unsigned int state;
 	struct rq_flags rf;
-	bool ret =3D false;
-	struct rq *rq;
+	int ret;
=20
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	if (p->on_rq) {
+
+	state =3D READ_ONCE(p->__state);
+
+	/*
+	 * Ensure we load p->on_rq after p->__state, otherwise it would be
+	 * possible to, falsely, observe p->on_rq =3D=3D 0.
+	 *
+	 * See try_to_wake_up() for a longer comment.
+	 */
+	smp_rmb();
+
+	/*
+	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
+	 * the task is blocked. Make sure to check @state since ttwu() can drop
+	 * locks at the end, see ttwu_queue_wakelist().
+	 */
+	if (state =3D=3D TASK_RUNNING || state =3D=3D TASK_WAKING || p->on_rq)
 		rq =3D __task_rq_lock(p, &rf);
-		if (task_rq(p) =3D=3D rq)
-			ret =3D func(p, arg);
+
+	/*
+	 * At this point the task is pinned; either:
+	 *  - blocked and we're holding off wakeups	 (pi->lock)
+	 *  - woken, and we're holding off enqueue	 (rq->lock)
+	 *  - queued, and we're holding off schedule	 (rq->lock)
+	 *  - running, and we're holding off de-schedule (rq->lock)
+	 *
+	 * The called function (@func) can use: task_curr(), p->on_rq and
+	 * p->__state to differentiate between these states.
+	 */
+	ret =3D func(p, arg);
+
+	if (rq)
 		rq_unlock(rq, &rf);
-	} else {
-		switch (READ_ONCE(p->__state)) {
-		case TASK_RUNNING:
-		case TASK_WAKING:
-			break;
-		default:
-			smp_rmb(); // See smp_rmb() comment in try_to_wake_up().
-			if (!p->on_rq)
-				ret =3D func(p, arg);
-		}
-	}
+
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
@@ -4196,7 +4230,7 @@ static void __sched_fork(unsigned long clone_flags, str=
uct task_struct *p)
=20
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
=20
 	RB_CLEAR_NODE(&p->dl.rb_node);
@@ -4328,8 +4362,6 @@ int sysctl_schedstats(struct ctl_table *table, int writ=
e, void *buffer,
  */
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
-	unsigned long flags;
-
 	__sched_fork(clone_flags, p);
 	/*
 	 * We mark the process as NEW here. This guarantees that
@@ -4375,24 +4407,6 @@ int sched_fork(unsigned long clone_flags, struct task_=
struct *p)
=20
 	init_entity_runnable_average(&p->se);
=20
-	/*
-	 * The child is not yet in the pid-hash so no cgroup attach races,
-	 * and the cgroup is pinned to this child due to cgroup_fork()
-	 * is ran before sched_fork().
-	 *
-	 * Silence PROVE_RCU.
-	 */
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	rseq_migrate(p);
-	/*
-	 * We're setting the CPU for the first time, we don't migrate,
-	 * so use __set_task_cpu().
-	 */
-	__set_task_cpu(p, smp_processor_id());
-	if (p->sched_class->task_fork)
-		p->sched_class->task_fork(p);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-
 #ifdef CONFIG_SCHED_INFO
 	if (likely(sched_info_on()))
 		memset(&p->sched_info, 0, sizeof(p->sched_info));
@@ -4408,8 +4422,29 @@ int sched_fork(unsigned long clone_flags, struct task_=
struct *p)
 	return 0;
 }
=20
-void sched_post_fork(struct task_struct *p)
+void sched_post_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
+	unsigned long flags;
+#ifdef CONFIG_CGROUP_SCHED
+	struct task_group *tg;
+#endif
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+#ifdef CONFIG_CGROUP_SCHED
+	tg =3D container_of(kargs->cset->subsys[cpu_cgrp_id],
+			  struct task_group, css);
+	p->sched_task_group =3D autogroup_task_group(p, tg);
+#endif
+	rseq_migrate(p);
+	/*
+	 * We're setting the CPU for the first time, we don't migrate,
+	 * so use __set_task_cpu().
+	 */
+	__set_task_cpu(p, smp_processor_id());
+	if (p->sched_class->task_fork)
+		p->sched_class->task_fork(p);
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
 	uclamp_post_fork(p);
 }
=20
@@ -4836,18 +4871,12 @@ static struct rq *finish_task_switch(struct task_stru=
ct *prev)
 	 */
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
-		mmdrop(mm);
+		mmdrop_sched(mm);
 	}
 	if (unlikely(prev_state =3D=3D TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
=20
-		/*
-		 * Remove function-return probe instances associated with this
-		 * task and put them back on the free list.
-		 */
-		kprobe_flush_task(prev);
-
 		/* Task is done with its stack. */
 		put_task_stack(prev);
=20
@@ -5580,8 +5609,7 @@ __pick_next_task(struct rq *rq, struct task_struct *pre=
v, struct rq_flags *rf)
 			return p;
 	}
=20
-	/* The idle class should always have a runnable task: */
-	BUG();
+	BUG(); /* The idle class should always have a runnable task. */
 }
=20
 #ifdef CONFIG_SCHED_CORE
@@ -5603,54 +5631,18 @@ static inline bool cookie_match(struct task_struct *a=
, struct task_struct *b)
 	return a->core_cookie =3D=3D b->core_cookie;
 }
=20
-// XXX fairness/fwd progress conditions
-/*
- * Returns
- * - NULL if there is no runnable task for this class.
- * - the highest priority task for this runqueue if it matches
- *   rq->core->core_cookie or its priority is greater than max.
- * - Else returns idle_task.
- */
-static struct task_struct *
-pick_task(struct rq *rq, const struct sched_class *class, struct task_struct=
 *max, bool in_fi)
+static inline struct task_struct *pick_task(struct rq *rq)
 {
-	struct task_struct *class_pick, *cookie_pick;
-	unsigned long cookie =3D rq->core->core_cookie;
-
-	class_pick =3D class->pick_task(rq);
-	if (!class_pick)
-		return NULL;
-
-	if (!cookie) {
-		/*
-		 * If class_pick is tagged, return it only if it has
-		 * higher priority than max.
-		 */
-		if (max && class_pick->core_cookie &&
-		    prio_less(class_pick, max, in_fi))
-			return idle_sched_class.pick_task(rq);
+	const struct sched_class *class;
+	struct task_struct *p;
=20
-		return class_pick;
+	for_each_class(class) {
+		p =3D class->pick_task(rq);
+		if (p)
+			return p;
 	}
=20
-	/*
-	 * If class_pick is idle or matches cookie, return early.
-	 */
-	if (cookie_equals(class_pick, cookie))
-		return class_pick;
-
-	cookie_pick =3D sched_core_find(rq, cookie);
-
-	/*
-	 * If class > max && class > cookie, it is the highest priority task on
-	 * the core (so far) and it must be selected, otherwise we must go with
-	 * the cookie pick in order to satisfy the constraint.
-	 */
-	if (prio_less(cookie_pick, class_pick, in_fi) &&
-	    (!max || prio_less(max, class_pick, in_fi)))
-		return class_pick;
-
-	return cookie_pick;
+	BUG(); /* The idle class should always have a runnable task. */
 }
=20
 extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool =
in_fi);
@@ -5658,11 +5650,12 @@ extern void task_vruntime_update(struct rq *rq, struc=
t task_struct *p, bool in_f
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *next, *max =3D NULL;
-	const struct sched_class *class;
+	struct task_struct *next, *p, *max =3D NULL;
 	const struct cpumask *smt_mask;
 	bool fi_before =3D false;
-	int i, j, cpu, occ =3D 0;
+	unsigned long cookie;
+	int i, cpu, occ =3D 0;
+	struct rq *rq_i;
 	bool need_sync;
=20
 	if (!sched_core_enabled(rq))
@@ -5735,12 +5728,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev=
, struct rq_flags *rf)
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-		for_each_class(class) {
-			next =3D class->pick_task(rq);
-			if (next)
-				break;
-		}
-
+		next =3D pick_task(rq);
 		if (!next->core_cookie) {
 			rq->core_pick =3D NULL;
 			/*
@@ -5753,76 +5741,51 @@ pick_next_task(struct rq *rq, struct task_struct *pre=
v, struct rq_flags *rf)
 		}
 	}
=20
-	for_each_cpu(i, smt_mask) {
-		struct rq *rq_i =3D cpu_rq(i);
-
-		rq_i->core_pick =3D NULL;
+	/*
+	 * For each thread: do the regular task pick and find the max prio task
+	 * amongst them.
+	 *
+	 * Tie-break prio towards the current CPU
+	 */
+	for_each_cpu_wrap(i, smt_mask, cpu) {
+		rq_i =3D cpu_rq(i);
=20
 		if (i !=3D cpu)
 			update_rq_clock(rq_i);
+
+		p =3D rq_i->core_pick =3D pick_task(rq_i);
+		if (!max || prio_less(max, p, fi_before))
+			max =3D p;
 	}
=20
+	cookie =3D rq->core->core_cookie =3D max->core_cookie;
+
 	/*
-	 * Try and select tasks for each sibling in descending sched_class
-	 * order.
+	 * For each thread: try and find a runnable task that matches @max or
+	 * force idle.
 	 */
-	for_each_class(class) {
-again:
-		for_each_cpu_wrap(i, smt_mask, cpu) {
-			struct rq *rq_i =3D cpu_rq(i);
-			struct task_struct *p;
-
-			if (rq_i->core_pick)
-				continue;
+	for_each_cpu(i, smt_mask) {
+		rq_i =3D cpu_rq(i);
+		p =3D rq_i->core_pick;
=20
-			/*
-			 * If this sibling doesn't yet have a suitable task to
-			 * run; ask for the most eligible task, given the
-			 * highest priority task already selected for this
-			 * core.
-			 */
-			p =3D pick_task(rq_i, class, max, fi_before);
+		if (!cookie_equals(p, cookie)) {
+			p =3D NULL;
+			if (cookie)
+				p =3D sched_core_find(rq_i, cookie);
 			if (!p)
-				continue;
+				p =3D idle_sched_class.pick_task(rq_i);
+		}
=20
-			if (!is_task_rq_idle(p))
-				occ++;
+		rq_i->core_pick =3D p;
=20
-			rq_i->core_pick =3D p;
-			if (rq_i->idle =3D=3D p && rq_i->nr_running) {
+		if (p =3D=3D rq_i->idle) {
+			if (rq_i->nr_running) {
 				rq->core->core_forceidle =3D true;
 				if (!fi_before)
 					rq->core->core_forceidle_seq++;
 			}
-
-			/*
-			 * If this new candidate is of higher priority than the
-			 * previous; and they're incompatible; we need to wipe
-			 * the slate and start over. pick_task makes sure that
-			 * p's priority is more than max if it doesn't match
-			 * max's cookie.
-			 *
-			 * NOTE: this is a linear max-filter and is thus bounded
-			 * in execution time.
-			 */
-			if (!max || !cookie_match(max, p)) {
-				struct task_struct *old_max =3D max;
-
-				rq->core->core_cookie =3D p->core_cookie;
-				max =3D p;
-
-				if (old_max) {
-					rq->core->core_forceidle =3D false;
-					for_each_cpu(j, smt_mask) {
-						if (j =3D=3D i)
-							continue;
-
-						cpu_rq(j)->core_pick =3D NULL;
-					}
-					occ =3D 1;
-					goto again;
-				}
-			}
+		} else {
+			occ++;
 		}
 	}
=20
@@ -5842,7 +5805,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev,=
 struct rq_flags *rf)
 	 * non-matching user state.
 	 */
 	for_each_cpu(i, smt_mask) {
-		struct rq *rq_i =3D cpu_rq(i);
+		rq_i =3D cpu_rq(i);
=20
 		/*
 		 * An online sibling might have gone offline before a task
@@ -6319,20 +6282,14 @@ static inline void sched_submit_work(struct task_stru=
ct *tsk)
=20
 	task_flags =3D tsk->flags;
 	/*
-	 * If a worker went to sleep, notify and ask workqueue whether
-	 * it wants to wake up a task to maintain concurrency.
-	 * As this function is called inside the schedule() context,
-	 * we disable preemption to avoid it calling schedule() again
-	 * in the possible wakeup of a kworker and because wq_worker_sleeping()
-	 * requires it.
+	 * If a worker goes to sleep, notify and ask workqueue whether it
+	 * wants to wake up a task to maintain concurrency.
 	 */
 	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
-		preempt_disable();
 		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
 		else
 			io_wq_worker_sleeping(tsk);
-		preempt_enable_no_resched();
 	}
=20
 	if (tsk_is_pi_blocked(tsk))
@@ -6586,12 +6543,13 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
  */
=20
 enum {
-	preempt_dynamic_none =3D 0,
+	preempt_dynamic_undefined =3D -1,
+	preempt_dynamic_none,
 	preempt_dynamic_voluntary,
 	preempt_dynamic_full,
 };
=20
-int preempt_dynamic_mode =3D preempt_dynamic_full;
+int preempt_dynamic_mode =3D preempt_dynamic_undefined;
=20
 int sched_dynamic_mode(const char *str)
 {
@@ -6664,7 +6622,27 @@ static int __init setup_preempt_mode(char *str)
 }
 __setup("preempt=3D", setup_preempt_mode);
=20
-#endif /* CONFIG_PREEMPT_DYNAMIC */
+static void __init preempt_dynamic_init(void)
+{
+	if (preempt_dynamic_mode =3D=3D preempt_dynamic_undefined) {
+		if (IS_ENABLED(CONFIG_PREEMPT_NONE_BEHAVIOUR)) {
+			sched_dynamic_update(preempt_dynamic_none);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BEHAVIOUR)) {
+			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else {
+			/* Default static call setting, nothing to do */
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_BEHAVIOUR));
+			preempt_dynamic_mode =3D preempt_dynamic_full;
+			pr_info("Dynamic Preempt: full\n");
+		}
+	}
+}
+
+#else /* !CONFIG_PREEMPT_DYNAMIC */
+
+static inline void preempt_dynamic_init(void) { }
+
+#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
=20
 /*
  * This is the entry point to schedule() from kernel preemption
@@ -9464,6 +9442,8 @@ void __init sched_init(void)
=20
 	init_uclamp();
=20
+	preempt_dynamic_init();
+
 	scheduler_running =3D 1;
 }
=20
@@ -9619,9 +9599,9 @@ void normalize_rt_tasks(void)
 			continue;
=20
 		p->se.exec_start =3D 0;
-		schedstat_set(p->se.statistics.wait_start,  0);
-		schedstat_set(p->se.statistics.sleep_start, 0);
-		schedstat_set(p->se.statistics.block_start, 0);
+		schedstat_set(p->stats.wait_start,  0);
+		schedstat_set(p->stats.sleep_start, 0);
+		schedstat_set(p->stats.block_start, 0);
=20
 		if (!dl_task(p) && !rt_task(p)) {
 			/*
@@ -10463,15 +10443,21 @@ static int cpu_cfs_stat_show(struct seq_file *sf, v=
oid *v)
 	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
=20
 	if (schedstat_enabled() && tg !=3D &root_task_group) {
+		struct sched_statistics *stats;
 		u64 ws =3D 0;
 		int i;
=20
-		for_each_possible_cpu(i)
-			ws +=3D schedstat_val(tg->se[i]->statistics.wait_sum);
+		for_each_possible_cpu(i) {
+			stats =3D __schedstats_from_se(tg->se[i]);
+			ws +=3D schedstat_val(stats->wait_sum);
+		}
=20
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
=20
+	seq_printf(sf, "nr_bursts %d\n", cfs_b->nr_burst);
+	seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
+
 	return 0;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -10587,16 +10573,20 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 	{
 		struct task_group *tg =3D css_tg(css);
 		struct cfs_bandwidth *cfs_b =3D &tg->cfs_bandwidth;
-		u64 throttled_usec;
+		u64 throttled_usec, burst_usec;
=20
 		throttled_usec =3D cfs_b->throttled_time;
 		do_div(throttled_usec, NSEC_PER_USEC);
+		burst_usec =3D cfs_b->burst_time;
+		do_div(burst_usec, NSEC_PER_USEC);
=20
 		seq_printf(sf, "nr_periods %d\n"
 			   "nr_throttled %d\n"
-			   "throttled_usec %llu\n",
+			   "throttled_usec %llu\n"
+			   "nr_bursts %d\n"
+			   "burst_usec %llu\n",
 			   cfs_b->nr_periods, cfs_b->nr_throttled,
-			   throttled_usec);
+			   throttled_usec, cfs_b->nr_burst, burst_usec);
 	}
 #endif
 	return 0;
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 9a80e9a474c0..48ac72696012 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -11,7 +11,7 @@ struct sched_core_cookie {
 	refcount_t refcnt;
 };
=20
-unsigned long sched_core_alloc_cookie(void)
+static unsigned long sched_core_alloc_cookie(void)
 {
 	struct sched_core_cookie *ck =3D kmalloc(sizeof(*ck), GFP_KERNEL);
 	if (!ck)
@@ -23,7 +23,7 @@ unsigned long sched_core_alloc_cookie(void)
 	return (unsigned long)ck;
 }
=20
-void sched_core_put_cookie(unsigned long cookie)
+static void sched_core_put_cookie(unsigned long cookie)
 {
 	struct sched_core_cookie *ptr =3D (void *)cookie;
=20
@@ -33,7 +33,7 @@ void sched_core_put_cookie(unsigned long cookie)
 	}
 }
=20
-unsigned long sched_core_get_cookie(unsigned long cookie)
+static unsigned long sched_core_get_cookie(unsigned long cookie)
 {
 	struct sched_core_cookie *ptr =3D (void *)cookie;
=20
@@ -53,7 +53,8 @@ unsigned long sched_core_get_cookie(unsigned long cookie)
  *
  * Returns: the old cookie
  */
-unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long =
cookie)
+static unsigned long sched_core_update_cookie(struct task_struct *p,
+					      unsigned long cookie)
 {
 	unsigned long old_cookie;
 	struct rq_flags rf;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e94314633b39..d2c072b0ef01 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1265,8 +1265,10 @@ static void update_curr_dl(struct rq *rq)
 		return;
 	}
=20
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
+
+	trace_sched_stat_runtime(curr, delta_exec, 0);
=20
 	curr->se.sum_exec_runtime +=3D delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
@@ -1472,6 +1474,82 @@ static inline bool __dl_less(struct rb_node *a, const =
struct rb_node *b)
 	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
 }
=20
+static inline struct sched_statistics *
+__schedstats_from_dl_se(struct sched_dl_entity *dl_se)
+{
+	return &dl_task_of(dl_se)->stats;
+}
+
+static inline void
+update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_s=
e)
+{
+	struct sched_statistics *stats;
+
+	if (!schedstat_enabled())
+		return;
+
+	stats =3D __schedstats_from_dl_se(dl_se);
+	__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+}
+
+static inline void
+update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
+{
+	struct sched_statistics *stats;
+
+	if (!schedstat_enabled())
+		return;
+
+	stats =3D __schedstats_from_dl_se(dl_se);
+	__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+}
+
+static inline void
+update_stats_enqueue_sleeper_dl(struct dl_rq *dl_rq, struct sched_dl_entity =
*dl_se)
+{
+	struct sched_statistics *stats;
+
+	if (!schedstat_enabled())
+		return;
+
+	stats =3D __schedstats_from_dl_se(dl_se);
+	__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats=
);
+}
+
+static inline void
+update_stats_enqueue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+			int flags)
+{
+	if (!schedstat_enabled())
+		return;
+
+	if (flags & ENQUEUE_WAKEUP)
+		update_stats_enqueue_sleeper_dl(dl_rq, dl_se);
+}
+
+static inline void
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+			int flags)
+{
+	struct task_struct *p =3D dl_task_of(dl_se);
+
+	if (!schedstat_enabled())
+		return;
+
+	if ((flags & DEQUEUE_SLEEP)) {
+		unsigned int state;
+
+		state =3D READ_ONCE(p->__state);
+		if (state & TASK_INTERRUPTIBLE)
+			__schedstat_set(p->stats.sleep_start,
+					rq_clock(rq_of_dl_rq(dl_rq)));
+
+		if (state & TASK_UNINTERRUPTIBLE)
+			__schedstat_set(p->stats.block_start,
+					rq_clock(rq_of_dl_rq(dl_rq)));
+	}
+}
+
 static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
@@ -1502,6 +1580,8 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int fl=
ags)
 {
 	BUG_ON(on_dl_rq(dl_se));
=20
+	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
+
 	/*
 	 * If this is a wakeup or a new instance, the scheduling
 	 * parameters of the task might need updating. Otherwise,
@@ -1598,6 +1678,9 @@ static void enqueue_task_dl(struct rq *rq, struct task_=
struct *p, int flags)
 		return;
 	}
=20
+	check_schedstat_required();
+	update_stats_wait_start_dl(dl_rq_of_se(&p->dl), &p->dl);
+
 	enqueue_dl_entity(&p->dl, flags);
=20
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1606,6 +1689,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_=
struct *p, int flags)
=20
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flag=
s)
 {
+	update_stats_dequeue_dl(&rq->dl, &p->dl, flags);
 	dequeue_dl_entity(&p->dl);
 	dequeue_pushable_dl_task(rq, p);
 }
@@ -1825,7 +1909,12 @@ static void start_hrtick_dl(struct rq *rq, struct task=
_struct *p)
=20
 static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool firs=
t)
 {
+	struct sched_dl_entity *dl_se =3D &p->dl;
+	struct dl_rq *dl_rq =3D &rq->dl;
+
 	p->se.exec_start =3D rq_clock_task(rq);
+	if (on_dl_rq(&p->dl))
+		update_stats_wait_end_dl(dl_rq, dl_se);
=20
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
@@ -1882,6 +1971,12 @@ static struct task_struct *pick_next_task_dl(struct rq=
 *rq)
=20
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
+	struct sched_dl_entity *dl_se =3D &p->dl;
+	struct dl_rq *dl_rq =3D &rq->dl;
+
+	if (on_dl_rq(&p->dl))
+		update_stats_wait_start_dl(dl_rq, dl_se);
+
 	update_curr_dl(rq);
=20
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 17a653b67006..7dcbaa31c5d9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -311,6 +311,7 @@ static __init int sched_init_debug(void)
=20
 	debugfs_create_u32("latency_ns", 0644, debugfs_sched, &sysctl_sched_latency=
);
 	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched=
_min_granularity);
+	debugfs_create_u32("idle_min_granularity_ns", 0644, debugfs_sched, &sysctl_=
sched_idle_min_granularity);
 	debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sc=
hed_wakeup_granularity);
=20
 	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_=
latency_warn_ms);
@@ -448,9 +449,11 @@ static void print_cfs_group_stats(struct seq_file *m, in=
t cpu, struct task_group
 	struct sched_entity *se =3D tg->se[cpu];
=20
 #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
-#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)sche=
dstat_val(F))
+#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	\
+		#F, (long long)schedstat_val(stats->F))
 #define PN(F)		SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long lo=
ng)F))
-#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS=
((long long)schedstat_val(F)))
+#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", \
+		#F, SPLIT_NS((long long)schedstat_val(stats->F)))
=20
 	if (!se)
 		return;
@@ -460,16 +463,19 @@ static void print_cfs_group_stats(struct seq_file *m, i=
nt cpu, struct task_group
 	PN(se->sum_exec_runtime);
=20
 	if (schedstat_enabled()) {
-		PN_SCHEDSTAT(se->statistics.wait_start);
-		PN_SCHEDSTAT(se->statistics.sleep_start);
-		PN_SCHEDSTAT(se->statistics.block_start);
-		PN_SCHEDSTAT(se->statistics.sleep_max);
-		PN_SCHEDSTAT(se->statistics.block_max);
-		PN_SCHEDSTAT(se->statistics.exec_max);
-		PN_SCHEDSTAT(se->statistics.slice_max);
-		PN_SCHEDSTAT(se->statistics.wait_max);
-		PN_SCHEDSTAT(se->statistics.wait_sum);
-		P_SCHEDSTAT(se->statistics.wait_count);
+		struct sched_statistics *stats;
+		stats =3D __schedstats_from_se(se);
+
+		PN_SCHEDSTAT(wait_start);
+		PN_SCHEDSTAT(sleep_start);
+		PN_SCHEDSTAT(block_start);
+		PN_SCHEDSTAT(sleep_max);
+		PN_SCHEDSTAT(block_max);
+		PN_SCHEDSTAT(exec_max);
+		PN_SCHEDSTAT(slice_max);
+		PN_SCHEDSTAT(wait_max);
+		PN_SCHEDSTAT(wait_sum);
+		P_SCHEDSTAT(wait_count);
 	}
=20
 	P(se->load.weight);
@@ -535,10 +541,11 @@ print_task(struct seq_file *m, struct rq *rq, struct ta=
sk_struct *p)
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
=20
-	SEQ_printf(m, "%9Ld.%06ld %9Ld.%06ld %9Ld.%06ld",
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.wait_sum)),
+	SEQ_printf(m, "%9lld.%06ld %9lld.%06ld %9lld.%06ld %9lld.%06ld",
+		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
 		SPLIT_NS(p->se.sum_exec_runtime),
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.sum_sleep_runtime)));
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)),
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_block_runtime)));
=20
 #ifdef CONFIG_NUMA_BALANCING
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
@@ -614,6 +621,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs=
_rq *cfs_rq)
 			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
+			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
 			cfs_rq->idle_h_nr_running);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
@@ -810,6 +819,7 @@ static void sched_debug_header(struct seq_file *m)
 	SEQ_printf(m, "  .%-40s: %Ld.%06ld\n", #x, SPLIT_NS(x))
 	PN(sysctl_sched_latency);
 	PN(sysctl_sched_min_granularity);
+	PN(sysctl_sched_idle_min_granularity);
 	PN(sysctl_sched_wakeup_granularity);
 	P(sysctl_sched_child_runs_first);
 	P(sysctl_sched_features);
@@ -954,8 +964,8 @@ void proc_sched_show_task(struct task_struct *p, struct p=
id_namespace *ns,
 		"---------------------------------------------------------"
 		"----------\n");
=20
-#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->F))
-#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->F))
+#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->stats.F))
+#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->stats.F))
=20
 	PN(se.exec_start);
 	PN(se.vruntime);
@@ -968,33 +978,34 @@ void proc_sched_show_task(struct task_struct *p, struct=
 pid_namespace *ns,
 	if (schedstat_enabled()) {
 		u64 avg_atom, avg_per_cpu;
=20
-		PN_SCHEDSTAT(se.statistics.sum_sleep_runtime);
-		PN_SCHEDSTAT(se.statistics.wait_start);
-		PN_SCHEDSTAT(se.statistics.sleep_start);
-		PN_SCHEDSTAT(se.statistics.block_start);
-		PN_SCHEDSTAT(se.statistics.sleep_max);
-		PN_SCHEDSTAT(se.statistics.block_max);
-		PN_SCHEDSTAT(se.statistics.exec_max);
-		PN_SCHEDSTAT(se.statistics.slice_max);
-		PN_SCHEDSTAT(se.statistics.wait_max);
-		PN_SCHEDSTAT(se.statistics.wait_sum);
-		P_SCHEDSTAT(se.statistics.wait_count);
-		PN_SCHEDSTAT(se.statistics.iowait_sum);
-		P_SCHEDSTAT(se.statistics.iowait_count);
-		P_SCHEDSTAT(se.statistics.nr_migrations_cold);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_affine);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_running);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_hot);
-		P_SCHEDSTAT(se.statistics.nr_forced_migrations);
-		P_SCHEDSTAT(se.statistics.nr_wakeups);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_sync);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_migrate);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_local);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_remote);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_affine);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_affine_attempts);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_passive);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_idle);
+		PN_SCHEDSTAT(sum_sleep_runtime);
+		PN_SCHEDSTAT(sum_block_runtime);
+		PN_SCHEDSTAT(wait_start);
+		PN_SCHEDSTAT(sleep_start);
+		PN_SCHEDSTAT(block_start);
+		PN_SCHEDSTAT(sleep_max);
+		PN_SCHEDSTAT(block_max);
+		PN_SCHEDSTAT(exec_max);
+		PN_SCHEDSTAT(slice_max);
+		PN_SCHEDSTAT(wait_max);
+		PN_SCHEDSTAT(wait_sum);
+		P_SCHEDSTAT(wait_count);
+		PN_SCHEDSTAT(iowait_sum);
+		P_SCHEDSTAT(iowait_count);
+		P_SCHEDSTAT(nr_migrations_cold);
+		P_SCHEDSTAT(nr_failed_migrations_affine);
+		P_SCHEDSTAT(nr_failed_migrations_running);
+		P_SCHEDSTAT(nr_failed_migrations_hot);
+		P_SCHEDSTAT(nr_forced_migrations);
+		P_SCHEDSTAT(nr_wakeups);
+		P_SCHEDSTAT(nr_wakeups_sync);
+		P_SCHEDSTAT(nr_wakeups_migrate);
+		P_SCHEDSTAT(nr_wakeups_local);
+		P_SCHEDSTAT(nr_wakeups_remote);
+		P_SCHEDSTAT(nr_wakeups_affine);
+		P_SCHEDSTAT(nr_wakeups_affine_attempts);
+		P_SCHEDSTAT(nr_wakeups_passive);
+		P_SCHEDSTAT(nr_wakeups_idle);
=20
 		avg_atom =3D p->se.sum_exec_runtime;
 		if (nr_switches)
@@ -1060,7 +1071,7 @@ void proc_sched_show_task(struct task_struct *p, struct=
 pid_namespace *ns,
 void proc_sched_set_task(struct task_struct *p)
 {
 #ifdef CONFIG_SCHEDSTATS
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 }
=20
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6a05d9b5443..13950beb01a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -59,6 +59,14 @@ unsigned int sysctl_sched_tunable_scaling =3D SCHED_TUNABL=
ESCALING_LOG;
 unsigned int sysctl_sched_min_granularity			=3D 750000ULL;
 static unsigned int normalized_sysctl_sched_min_granularity	=3D 750000ULL;
=20
+/*
+ * Minimal preemption granularity for CPU-bound SCHED_IDLE tasks.
+ * Applies only when SCHED_IDLE tasks compete with normal tasks.
+ *
+ * (default: 0.75 msec)
+ */
+unsigned int sysctl_sched_idle_min_granularity			=3D 750000ULL;
+
 /*
  * This value is kept at sysctl_sched_latency/sysctl_sched_min_granularity
  */
@@ -665,6 +673,8 @@ static u64 __sched_period(unsigned long nr_running)
 		return sysctl_sched_latency;
 }
=20
+static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
+
 /*
  * We calculate the wall-time slice from the period by taking a part
  * proportional to the weight.
@@ -674,6 +684,8 @@ static u64 __sched_period(unsigned long nr_running)
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	unsigned int nr_running =3D cfs_rq->nr_running;
+	struct sched_entity *init_se =3D se;
+	unsigned int min_gran;
 	u64 slice;
=20
 	if (sched_feat(ALT_PERIOD))
@@ -684,12 +696,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se)
 	for_each_sched_entity(se) {
 		struct load_weight *load;
 		struct load_weight lw;
+		struct cfs_rq *qcfs_rq;
=20
-		cfs_rq =3D cfs_rq_of(se);
-		load =3D &cfs_rq->load;
+		qcfs_rq =3D cfs_rq_of(se);
+		load =3D &qcfs_rq->load;
=20
 		if (unlikely(!se->on_rq)) {
-			lw =3D cfs_rq->load;
+			lw =3D qcfs_rq->load;
=20
 			update_load_add(&lw, se->load.weight);
 			load =3D &lw;
@@ -697,8 +710,14 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sch=
ed_entity *se)
 		slice =3D __calc_delta(slice, se->load.weight, load);
 	}
=20
-	if (sched_feat(BASE_SLICE))
-		slice =3D max(slice, (u64)sysctl_sched_min_granularity);
+	if (sched_feat(BASE_SLICE)) {
+		if (se_is_idle(init_se) && !sched_idle_cfs_rq(cfs_rq))
+			min_gran =3D sysctl_sched_idle_min_granularity;
+		else
+			min_gran =3D sysctl_sched_min_granularity;
+
+		slice =3D max_t(u64, slice, min_gran);
+	}
=20
 	return slice;
 }
@@ -837,8 +856,13 @@ static void update_curr(struct cfs_rq *cfs_rq)
=20
 	curr->exec_start =3D now;
=20
-	schedstat_set(curr->statistics.exec_max,
-		      max(delta_exec, curr->statistics.exec_max));
+	if (schedstat_enabled()) {
+		struct sched_statistics *stats;
+
+		stats =3D __schedstats_from_se(curr);
+		__schedstat_set(stats->exec_max,
+				max(delta_exec, stats->exec_max));
+	}
=20
 	curr->sum_exec_runtime +=3D delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
@@ -863,137 +887,70 @@ static void update_curr_fair(struct rq *rq)
 }
=20
 static inline void
-update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_wait_start_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u64 wait_start, prev_wait_start;
+	struct sched_statistics *stats;
+	struct task_struct *p =3D NULL;
=20
 	if (!schedstat_enabled())
 		return;
=20
-	wait_start =3D rq_clock(rq_of(cfs_rq));
-	prev_wait_start =3D schedstat_val(se->statistics.wait_start);
+	stats =3D __schedstats_from_se(se);
=20
-	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
-	    likely(wait_start > prev_wait_start))
-		wait_start -=3D prev_wait_start;
+	if (entity_is_task(se))
+		p =3D task_of(se);
=20
-	__schedstat_set(se->statistics.wait_start, wait_start);
+	__update_stats_wait_start(rq_of(cfs_rq), p, stats);
 }
=20
 static inline void
-update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct task_struct *p;
-	u64 delta;
+	struct sched_statistics *stats;
+	struct task_struct *p =3D NULL;
=20
 	if (!schedstat_enabled())
 		return;
=20
+	stats =3D __schedstats_from_se(se);
+
 	/*
 	 * When the sched_schedstat changes from 0 to 1, some sched se
 	 * maybe already in the runqueue, the se->statistics.wait_start
 	 * will be 0.So it will let the delta wrong. We need to avoid this
 	 * scenario.
 	 */
-	if (unlikely(!schedstat_val(se->statistics.wait_start)))
+	if (unlikely(!schedstat_val(stats->wait_start)))
 		return;
=20
-	delta =3D rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start=
);
-
-	if (entity_is_task(se)) {
+	if (entity_is_task(se))
 		p =3D task_of(se);
-		if (task_on_rq_migrating(p)) {
-			/*
-			 * Preserve migrating task's wait time so wait_start
-			 * time stamp can be adjusted to accumulate wait time
-			 * prior to migration.
-			 */
-			__schedstat_set(se->statistics.wait_start, delta);
-			return;
-		}
-		trace_sched_stat_wait(p, delta);
-	}
=20
-	__schedstat_set(se->statistics.wait_max,
-		      max(schedstat_val(se->statistics.wait_max), delta));
-	__schedstat_inc(se->statistics.wait_count);
-	__schedstat_add(se->statistics.wait_sum, delta);
-	__schedstat_set(se->statistics.wait_start, 0);
+	__update_stats_wait_end(rq_of(cfs_rq), p, stats);
 }
=20
 static inline void
-update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
+update_stats_enqueue_sleeper_fair(struct cfs_rq *cfs_rq, struct sched_entity=
 *se)
 {
+	struct sched_statistics *stats;
 	struct task_struct *tsk =3D NULL;
-	u64 sleep_start, block_start;
=20
 	if (!schedstat_enabled())
 		return;
=20
-	sleep_start =3D schedstat_val(se->statistics.sleep_start);
-	block_start =3D schedstat_val(se->statistics.block_start);
+	stats =3D __schedstats_from_se(se);
=20
 	if (entity_is_task(se))
 		tsk =3D task_of(se);
=20
-	if (sleep_start) {
-		u64 delta =3D rq_clock(rq_of(cfs_rq)) - sleep_start;
-
-		if ((s64)delta < 0)
-			delta =3D 0;
-
-		if (unlikely(delta > schedstat_val(se->statistics.sleep_max)))
-			__schedstat_set(se->statistics.sleep_max, delta);
-
-		__schedstat_set(se->statistics.sleep_start, 0);
-		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
-
-		if (tsk) {
-			account_scheduler_latency(tsk, delta >> 10, 1);
-			trace_sched_stat_sleep(tsk, delta);
-		}
-	}
-	if (block_start) {
-		u64 delta =3D rq_clock(rq_of(cfs_rq)) - block_start;
-
-		if ((s64)delta < 0)
-			delta =3D 0;
-
-		if (unlikely(delta > schedstat_val(se->statistics.block_max)))
-			__schedstat_set(se->statistics.block_max, delta);
-
-		__schedstat_set(se->statistics.block_start, 0);
-		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
-
-		if (tsk) {
-			if (tsk->in_iowait) {
-				__schedstat_add(se->statistics.iowait_sum, delta);
-				__schedstat_inc(se->statistics.iowait_count);
-				trace_sched_stat_iowait(tsk, delta);
-			}
-
-			trace_sched_stat_blocked(tsk, delta);
-
-			/*
-			 * Blocking time is in units of nanosecs, so shift by
-			 * 20 to get a milliseconds-range estimation of the
-			 * amount of time that the task spent sleeping:
-			 */
-			if (unlikely(prof_on =3D=3D SLEEP_PROFILING)) {
-				profile_hits(SLEEP_PROFILING,
-						(void *)get_wchan(tsk),
-						delta >> 20);
-			}
-			account_scheduler_latency(tsk, delta >> 10, 0);
-		}
-	}
+	__update_stats_enqueue_sleeper(rq_of(cfs_rq), tsk, stats);
 }
=20
 /*
  * Task is being enqueued - update stats:
  */
 static inline void
-update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int fla=
gs)
+update_stats_enqueue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, in=
t flags)
 {
 	if (!schedstat_enabled())
 		return;
@@ -1003,14 +960,14 @@ update_stats_enqueue(struct cfs_rq *cfs_rq, struct sch=
ed_entity *se, int flags)
 	 * a dequeue/enqueue event is a NOP)
 	 */
 	if (se !=3D cfs_rq->curr)
-		update_stats_wait_start(cfs_rq, se);
+		update_stats_wait_start_fair(cfs_rq, se);
=20
 	if (flags & ENQUEUE_WAKEUP)
-		update_stats_enqueue_sleeper(cfs_rq, se);
+		update_stats_enqueue_sleeper_fair(cfs_rq, se);
 }
=20
 static inline void
-update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int fla=
gs)
+update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, in=
t flags)
 {
=20
 	if (!schedstat_enabled())
@@ -1021,7 +978,7 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched=
_entity *se, int flags)
 	 * waiting task:
 	 */
 	if (se !=3D cfs_rq->curr)
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end_fair(cfs_rq, se);
=20
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
 		struct task_struct *tsk =3D task_of(se);
@@ -1030,10 +987,10 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sch=
ed_entity *se, int flags)
 		/* XXX racy against TTWU */
 		state =3D READ_ONCE(tsk->__state);
 		if (state & TASK_INTERRUPTIBLE)
-			__schedstat_set(se->statistics.sleep_start,
+			__schedstat_set(tsk->stats.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
 		if (state & TASK_UNINTERRUPTIBLE)
-			__schedstat_set(se->statistics.block_start,
+			__schedstat_set(tsk->stats.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
 }
@@ -1081,11 +1038,12 @@ struct numa_group {
 	unsigned long total_faults;
 	unsigned long max_faults_cpu;
 	/*
+	 * faults[] array is split into two regions: faults_mem and faults_cpu.
+	 *
 	 * Faults_cpu is used to decide whether memory should move
 	 * towards the CPU. As a consequence, these stats are weighted
 	 * more by CPU use than by memory faults.
 	 */
-	unsigned long *faults_cpu;
 	unsigned long faults[];
 };
=20
@@ -1259,8 +1217,8 @@ static inline unsigned long group_faults(struct task_st=
ruct *p, int nid)
=20
 static inline unsigned long group_faults_cpu(struct numa_group *group, int n=
id)
 {
-	return group->faults_cpu[task_faults_idx(NUMA_MEM, nid, 0)] +
-		group->faults_cpu[task_faults_idx(NUMA_MEM, nid, 1)];
+	return group->faults[task_faults_idx(NUMA_CPU, nid, 0)] +
+		group->faults[task_faults_idx(NUMA_CPU, nid, 1)];
 }
=20
 static inline unsigned long group_faults_priv(struct numa_group *ng)
@@ -2116,7 +2074,7 @@ static void numa_migrate_preferred(struct task_struct *=
p)
 }
=20
 /*
- * Find out how many nodes on the workload is actively running on. Do this by
+ * Find out how many nodes the workload is actively running on. Do this by
  * tracking the nodes from which NUMA hinting faults are triggered. This can
  * be different from the set of nodes where the workload's memory is current=
ly
  * located.
@@ -2170,7 +2128,7 @@ static void update_task_scan_period(struct task_struct =
*p,
=20
 	/*
 	 * If there were no record hinting faults then either the task is
-	 * completely idle or all activity is areas that are not of interest
+	 * completely idle or all activity is in areas that are not of interest
 	 * to automatic numa balancing. Related to that, if there were failed
 	 * migration then it implies we are migrating too quickly or the local
 	 * node is overloaded. In either case, scan slower
@@ -2427,7 +2385,7 @@ static void task_numa_placement(struct task_struct *p)
 				 * is at the beginning of the numa_faults array.
 				 */
 				ng->faults[mem_idx] +=3D diff;
-				ng->faults_cpu[mem_idx] +=3D f_diff;
+				ng->faults[cpu_idx] +=3D f_diff;
 				ng->total_faults +=3D diff;
 				group_faults +=3D ng->faults[mem_idx];
 			}
@@ -2481,7 +2439,8 @@ static void task_numa_group(struct task_struct *p, int =
cpupid, int flags,
=20
 	if (unlikely(!deref_curr_numa_group(p))) {
 		unsigned int size =3D sizeof(struct numa_group) +
-				    4*nr_node_ids*sizeof(unsigned long);
+				    NR_NUMA_HINT_FAULT_STATS *
+				    nr_node_ids * sizeof(unsigned long);
=20
 		grp =3D kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
 		if (!grp)
@@ -2492,9 +2451,6 @@ static void task_numa_group(struct task_struct *p, int =
cpupid, int flags,
 		grp->max_faults_cpu =3D 0;
 		spin_lock_init(&grp->lock);
 		grp->gid =3D p->pid;
-		/* Second half of the array tracks nids where faults happen */
-		grp->faults_cpu =3D grp->faults + NR_NUMA_HINT_FAULT_TYPES *
-						nr_node_ids;
=20
 		for (i =3D 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
 			grp->faults[i] =3D p->numa_faults[i];
@@ -2995,6 +2951,8 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se)
 	}
 #endif
 	cfs_rq->nr_running++;
+	if (se_is_idle(se))
+		cfs_rq->idle_nr_running++;
 }
=20
 static void
@@ -3008,6 +2966,8 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se)
 	}
 #endif
 	cfs_rq->nr_running--;
+	if (se_is_idle(se))
+		cfs_rq->idle_nr_running--;
 }
=20
 /*
@@ -4207,7 +4167,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entit=
y *se, int initial)
=20
 	/* sleeps up to a single latency don't count. */
 	if (!initial) {
-		unsigned long thresh =3D sysctl_sched_latency;
+		unsigned long thresh;
+
+		if (se_is_idle(se))
+			thresh =3D sysctl_sched_min_granularity;
+		else
+			thresh =3D sysctl_sched_latency;
=20
 		/*
 		 * Halve their sleep time's effect, to allow
@@ -4225,26 +4190,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entit=
y *se, int initial)
=20
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
=20
-static inline void check_schedstat_required(void)
-{
-#ifdef CONFIG_SCHEDSTATS
-	if (schedstat_enabled())
-		return;
-
-	/* Force schedstat enabled if a dependent tracepoint is active */
-	if (trace_sched_stat_wait_enabled()    ||
-			trace_sched_stat_sleep_enabled()   ||
-			trace_sched_stat_iowait_enabled()  ||
-			trace_sched_stat_blocked_enabled() ||
-			trace_sched_stat_runtime_enabled())  {
-		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, "
-			     "stat_blocked and stat_runtime require the "
-			     "kernel parameter schedstats=3Denable or "
-			     "kernel.sched_schedstats=3D1\n");
-	}
-#endif
-}
-
 static inline bool cfs_bandwidth_used(void);
=20
 /*
@@ -4318,7 +4263,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_enti=
ty *se, int flags)
 		place_entity(cfs_rq, se, 0);
=20
 	check_schedstat_required();
-	update_stats_enqueue(cfs_rq, se, flags);
+	update_stats_enqueue_fair(cfs_rq, se, flags);
 	check_spread(cfs_rq, se);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
@@ -4402,7 +4347,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_enti=
ty *se, int flags)
 	update_load_avg(cfs_rq, se, UPDATE_TG);
 	se_update_runnable(se);
=20
-	update_stats_dequeue(cfs_rq, se, flags);
+	update_stats_dequeue_fair(cfs_rq, se, flags);
=20
 	clear_buddies(cfs_rq, se);
=20
@@ -4487,7 +4432,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_ent=
ity *se)
 		 * a CPU. So account for the time it spent waiting on the
 		 * runqueue.
 		 */
-		update_stats_wait_end(cfs_rq, se);
+		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
@@ -4502,9 +4447,12 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_en=
tity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >=3D 2*se->load.weight) {
-		schedstat_set(se->statistics.slice_max,
-			max((u64)schedstat_val(se->statistics.slice_max),
-			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
+		struct sched_statistics *stats;
+
+		stats =3D __schedstats_from_se(se);
+		__schedstat_set(stats->slice_max,
+				max((u64)stats->slice_max,
+				    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
=20
 	se->prev_sum_exec_runtime =3D se->sum_exec_runtime;
@@ -4586,7 +4534,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, stru=
ct sched_entity *prev)
 	check_spread(cfs_rq, prev);
=20
 	if (prev->on_rq) {
-		update_stats_wait_start(cfs_rq, prev);
+		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
@@ -4687,11 +4635,20 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
+	s64 runtime;
+
 	if (unlikely(cfs_b->quota =3D=3D RUNTIME_INF))
 		return;
=20
 	cfs_b->runtime +=3D cfs_b->quota;
+	runtime =3D cfs_b->runtime_snap - cfs_b->runtime;
+	if (runtime > 0) {
+		cfs_b->burst_time +=3D runtime;
+		cfs_b->nr_burst++;
+	}
+
 	cfs_b->runtime =3D min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
+	cfs_b->runtime_snap =3D cfs_b->runtime;
 }
=20
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -5577,6 +5534,17 @@ static int sched_idle_rq(struct rq *rq)
 			rq->nr_running);
 }
=20
+/*
+ * Returns true if cfs_rq only has SCHED_IDLE entities enqueued. Note the use
+ * of idle_nr_running, which does not consider idle descendants of normal
+ * entities.
+ */
+static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->nr_running &&
+		cfs_rq->nr_running =3D=3D cfs_rq->idle_nr_running;
+}
+
 #ifdef CONFIG_SMP
 static int sched_idle_cpu(int cpu)
 {
@@ -5787,6 +5755,7 @@ static struct {
 	cpumask_var_t idle_cpus_mask;
 	atomic_t nr_cpus;
 	int has_blocked;		/* Idle CPUS has blocked load */
+	int needs_update;		/* Newly idle CPUs need their next_balance collated */
 	unsigned long next_balance;     /* in jiffy units */
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
 } nohz ____cacheline_aligned;
@@ -5997,12 +5966,12 @@ static int wake_affine(struct sched_domain *sd, struc=
t task_struct *p,
 	if (sched_feat(WA_WEIGHT) && target =3D=3D nr_cpumask_bits)
 		target =3D wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
=20
-	schedstat_inc(p->se.statistics.nr_wakeups_affine_attempts);
+	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
 	if (target =3D=3D nr_cpumask_bits)
 		return prev_cpu;
=20
 	schedstat_inc(sd->ttwu_move_affine);
-	schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	schedstat_inc(p->stats.nr_wakeups_affine);
 	return target;
 }
=20
@@ -6443,11 +6412,6 @@ static int select_idle_sibling(struct task_struct *p, =
int prev, int target)
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)=
) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_capacity(task_util, recent_used_cpu)) {
-		/*
-		 * Replace recent_used_cpu with prev as it is a potential
-		 * candidate for the next wake:
-		 */
-		p->recent_used_cpu =3D prev;
 		return recent_used_cpu;
 	}
=20
@@ -7806,7 +7770,7 @@ int can_migrate_task(struct task_struct *p, struct lb_e=
nv *env)
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
=20
-		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
+		schedstat_inc(p->stats.nr_failed_migrations_affine);
=20
 		env->flags |=3D LBF_SOME_PINNED;
=20
@@ -7840,7 +7804,7 @@ int can_migrate_task(struct task_struct *p, struct lb_e=
nv *env)
 	env->flags &=3D ~LBF_ALL_PINNED;
=20
 	if (task_running(env->src_rq, p)) {
-		schedstat_inc(p->se.statistics.nr_failed_migrations_running);
+		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
=20
@@ -7862,12 +7826,12 @@ int can_migrate_task(struct task_struct *p, struct lb=
_env *env)
 	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
 		if (tsk_cache_hot =3D=3D 1) {
 			schedstat_inc(env->sd->lb_hot_gained[env->idle]);
-			schedstat_inc(p->se.statistics.nr_forced_migrations);
+			schedstat_inc(p->stats.nr_forced_migrations);
 		}
 		return 1;
 	}
=20
-	schedstat_inc(p->se.statistics.nr_failed_migrations_hot);
+	schedstat_inc(p->stats.nr_failed_migrations_hot);
 	return 0;
 }
=20
@@ -8601,6 +8565,99 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
=20
+/**
+ * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull t=
asks
+ * @dst_cpu:	Destination CPU of the load balancing
+ * @sds:	Load-balancing data with statistics of the local group
+ * @sgs:	Load-balancing statistics of the candidate busiest group
+ * @sg:		The candidate busiest group
+ *
+ * Check the state of the SMT siblings of both @sds::local and @sg and decide
+ * if @dst_cpu can pull tasks.
+ *
+ * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more =
of
+ * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull ta=
sks
+ * only if @dst_cpu has higher priority.
+ *
+ * If both @dst_cpu and @sg have SMT siblings, and @sg has exactly one more
+ * busy CPU than @sds::local, let @dst_cpu pull tasks if it has higher prior=
ity.
+ * Bigger imbalances in the number of busy CPUs will be dealt with in
+ * update_sd_pick_busiest().
+ *
+ * If @sg does not have SMT siblings, only pull tasks if all of the SMT sibl=
ings
+ * of @dst_cpu are idle and @sg has lower priority.
+ */
+static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
+				    struct sg_lb_stats *sgs,
+				    struct sched_group *sg)
+{
+#ifdef CONFIG_SCHED_SMT
+	bool local_is_smt, sg_is_smt;
+	int sg_busy_cpus;
+
+	local_is_smt =3D sds->local->flags & SD_SHARE_CPUCAPACITY;
+	sg_is_smt =3D sg->flags & SD_SHARE_CPUCAPACITY;
+
+	sg_busy_cpus =3D sgs->group_weight - sgs->idle_cpus;
+
+	if (!local_is_smt) {
+		/*
+		 * If we are here, @dst_cpu is idle and does not have SMT
+		 * siblings. Pull tasks if candidate group has two or more
+		 * busy CPUs.
+		 */
+		if (sg_busy_cpus >=3D 2) /* implies sg_is_smt */
+			return true;
+
+		/*
+		 * @dst_cpu does not have SMT siblings. @sg may have SMT
+		 * siblings and only one is busy. In such case, @dst_cpu
+		 * can help if it has higher priority and is idle (i.e.,
+		 * it has no running tasks).
+		 */
+		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+	}
+
+	/* @dst_cpu has SMT siblings. */
+
+	if (sg_is_smt) {
+		int local_busy_cpus =3D sds->local->group_weight -
+				      sds->local_stat.idle_cpus;
+		int busy_cpus_delta =3D sg_busy_cpus - local_busy_cpus;
+
+		if (busy_cpus_delta =3D=3D 1)
+			return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+
+		return false;
+	}
+
+	/*
+	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
+	 * up with more than one busy SMT sibling and only pull tasks if there
+	 * are not busy CPUs (i.e., no CPU has running tasks).
+	 */
+	if (!sds->local_stat.sum_nr_running)
+		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+
+	return false;
+#else
+	/* Always return false so that callers deal with non-SMT cases. */
+	return false;
+#endif
+}
+
+static inline bool
+sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats =
*sgs,
+	   struct sched_group *group)
+{
+	/* Only do SMT checks if either local or candidate have SMT siblings */
+	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
+	    (group->flags & SD_SHARE_CPUCAPACITY))
+		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
+
+	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -8609,6 +8666,7 @@ group_type group_classify(unsigned int imbalance_pct,
  * @sg_status: Holds flag indicating the status of the sched_group
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
+				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
@@ -8617,7 +8675,7 @@ static inline void update_sg_lb_stats(struct lb_env *en=
v,
=20
 	memset(sgs, 0, sizeof(*sgs));
=20
-	local_group =3D cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
+	local_group =3D group =3D=3D sds->local;
=20
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq =3D cpu_rq(i);
@@ -8660,18 +8718,17 @@ static inline void update_sg_lb_stats(struct lb_env *=
env,
 		}
 	}
=20
-	/* Check if dst CPU is idle and preferred to this group */
-	if (env->sd->flags & SD_ASYM_PACKING &&
-	    env->idle !=3D CPU_NOT_IDLE &&
-	    sgs->sum_h_nr_running &&
-	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
-		sgs->group_asym_packing =3D 1;
-	}
-
 	sgs->group_capacity =3D group->sgc->capacity;
=20
 	sgs->group_weight =3D group->group_weight;
=20
+	/* Check if dst CPU is idle and preferred to this group */
+	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
+	    env->idle !=3D CPU_NOT_IDLE && sgs->sum_h_nr_running &&
+	    sched_asym(env, sds, sgs, group)) {
+		sgs->group_asym_packing =3D 1;
+	}
+
 	sgs->group_type =3D group_classify(env->sd->imbalance_pct, group, sgs);
=20
 	/* Computing avg_load makes sense only when group is overloaded */
@@ -9180,7 +9237,7 @@ static inline void update_sd_lb_stats(struct lb_env *en=
v, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
=20
-		update_sg_lb_stats(env, sg, sgs, &sg_status);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
=20
 		if (local_group)
 			goto next_group;
@@ -9603,6 +9660,12 @@ static struct rq *find_busiest_queue(struct lb_env *en=
v,
 		    nr_running =3D=3D 1)
 			continue;
=20
+		/* Make sure we only pull tasks from a CPU of lower priority */
+		if ((env->sd->flags & SD_ASYM_PACKING) &&
+		    sched_asym_prefer(i, env->dst_cpu) &&
+		    nr_running =3D=3D 1)
+			continue;
+
 		switch (env->migration_type) {
 		case migrate_load:
 			/*
@@ -10176,6 +10239,30 @@ void update_max_interval(void)
 	max_load_balance_interval =3D HZ*num_online_cpus()/10;
 }
=20
+static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
+{
+	if (cost > sd->max_newidle_lb_cost) {
+		/*
+		 * Track max cost of a domain to make sure to not delay the
+		 * next wakeup on the CPU.
+		 */
+		sd->max_newidle_lb_cost =3D cost;
+		sd->last_decay_max_lb_cost =3D jiffies;
+	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
+		/*
+		 * Decay the newidle max times by ~1% per second to ensure that
+		 * it is not outdated and the current max cost is actually
+		 * shorter.
+		 */
+		sd->max_newidle_lb_cost =3D (sd->max_newidle_lb_cost * 253) / 256;
+		sd->last_decay_max_lb_cost =3D jiffies;
+
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
@@ -10199,14 +10286,9 @@ static void rebalance_domains(struct rq *rq, enum cp=
u_idle_type idle)
 	for_each_domain(cpu, sd) {
 		/*
 		 * Decay the newidle max times here because this is a regular
-		 * visit to all the domains. Decay ~1% per second.
+		 * visit to all the domains.
 		 */
-		if (time_after(jiffies, sd->next_decay_max_lb_cost)) {
-			sd->max_newidle_lb_cost =3D
-				(sd->max_newidle_lb_cost * 253) / 256;
-			sd->next_decay_max_lb_cost =3D jiffies + HZ;
-			need_decay =3D 1;
-		}
+		need_decay =3D update_newidle_cost(sd, 0);
 		max_cost +=3D sd->max_newidle_lb_cost;
=20
 		/*
@@ -10375,7 +10457,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		goto out;
=20
 	if (rq->nr_running >=3D 2) {
-		flags =3D NOHZ_KICK_MASK;
+		flags =3D NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 		goto out;
 	}
=20
@@ -10389,7 +10471,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * on.
 		 */
 		if (rq->cfs.h_nr_running >=3D 1 && check_cpu_capacity(rq, sd)) {
-			flags =3D NOHZ_KICK_MASK;
+			flags =3D NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
 	}
@@ -10403,7 +10485,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
-				flags =3D NOHZ_KICK_MASK;
+				flags =3D NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 				goto unlock;
 			}
 		}
@@ -10416,7 +10498,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * to run the misfit task on.
 		 */
 		if (check_misfit_status(rq, sd)) {
-			flags =3D NOHZ_KICK_MASK;
+			flags =3D NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
=20
@@ -10443,13 +10525,16 @@ static void nohz_balancer_kick(struct rq *rq)
 		 */
 		nr_busy =3D atomic_read(&sds->nr_busy_cpus);
 		if (nr_busy > 1) {
-			flags =3D NOHZ_KICK_MASK;
+			flags =3D NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
 	}
 unlock:
 	rcu_read_unlock();
 out:
+	if (READ_ONCE(nohz.needs_update))
+		flags |=3D NOHZ_NEXT_KICK;
+
 	if (flags)
 		kick_ilb(flags);
 }
@@ -10546,12 +10631,13 @@ void nohz_balance_enter_idle(int cpu)
 	/*
 	 * Ensures that if nohz_idle_balance() fails to observe our
 	 * @idle_cpus_mask store, it must observe the @has_blocked
-	 * store.
+	 * and @needs_update stores.
 	 */
 	smp_mb__after_atomic();
=20
 	set_cpu_sd_state_idle(cpu);
=20
+	WRITE_ONCE(nohz.needs_update, 1);
 out:
 	/*
 	 * Each time a cpu enter idle, we assume that it has blocked load and
@@ -10600,12 +10686,17 @@ static void _nohz_idle_balance(struct rq *this_rq, =
unsigned int flags,
 	/*
 	 * We assume there will be no idle load after this update and clear
 	 * the has_blocked flag. If a cpu enters idle in the mean time, it will
-	 * set the has_blocked flag and trig another update of idle load.
+	 * set the has_blocked flag and trigger another update of idle load.
 	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
 	 * setting the flag, we are sure to not clear the state and not
 	 * check the load of an idle cpu.
+	 *
+	 * Same applies to idle_cpus_mask vs needs_update.
 	 */
-	WRITE_ONCE(nohz.has_blocked, 0);
+	if (flags & NOHZ_STATS_KICK)
+		WRITE_ONCE(nohz.has_blocked, 0);
+	if (flags & NOHZ_NEXT_KICK)
+		WRITE_ONCE(nohz.needs_update, 0);
=20
 	/*
 	 * Ensures that if we miss the CPU, we must see the has_blocked
@@ -10627,13 +10718,17 @@ static void _nohz_idle_balance(struct rq *this_rq, =
unsigned int flags,
 		 * balancing owner will pick it up.
 		 */
 		if (need_resched()) {
-			has_blocked_load =3D true;
+			if (flags & NOHZ_STATS_KICK)
+				has_blocked_load =3D true;
+			if (flags & NOHZ_NEXT_KICK)
+				WRITE_ONCE(nohz.needs_update, 1);
 			goto abort;
 		}
=20
 		rq =3D cpu_rq(balance_cpu);
=20
-		has_blocked_load |=3D update_nohz_stats(rq);
+		if (flags & NOHZ_STATS_KICK)
+			has_blocked_load |=3D update_nohz_stats(rq);
=20
 		/*
 		 * If time for next balance is due,
@@ -10664,8 +10759,9 @@ static void _nohz_idle_balance(struct rq *this_rq, un=
signed int flags,
 	if (likely(update_next_balance))
 		nohz.next_balance =3D next_balance;
=20
-	WRITE_ONCE(nohz.next_blocked,
-		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
+	if (flags & NOHZ_STATS_KICK)
+		WRITE_ONCE(nohz.next_blocked,
+			   now + msecs_to_jiffies(LOAD_AVG_PERIOD));
=20
 abort:
 	/* There is still blocked load, enable periodic update */
@@ -10763,9 +10859,9 @@ static int newidle_balance(struct rq *this_rq, struct=
 rq_flags *rf)
 {
 	unsigned long next_balance =3D jiffies + HZ;
 	int this_cpu =3D this_rq->cpu;
+	u64 t0, t1, curr_cost =3D 0;
 	struct sched_domain *sd;
 	int pulled_task =3D 0;
-	u64 curr_cost =3D 0;
=20
 	update_misfit_status(NULL, this_rq);
=20
@@ -10796,47 +10892,49 @@ static int newidle_balance(struct rq *this_rq, stru=
ct rq_flags *rf)
 	 */
 	rq_unpin_lock(this_rq, rf);
=20
-	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !READ_ONCE(this_rq->rd->overload)) {
+	rcu_read_lock();
+	sd =3D rcu_dereference_check_sched_domain(this_rq->sd);
+
+	if (!READ_ONCE(this_rq->rd->overload) ||
+	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
=20
-		rcu_read_lock();
-		sd =3D rcu_dereference_check_sched_domain(this_rq->sd);
 		if (sd)
 			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
=20
 		goto out;
 	}
+	rcu_read_unlock();
=20
 	raw_spin_rq_unlock(this_rq);
=20
+	t0 =3D sched_clock_cpu(this_cpu);
 	update_blocked_averages(this_cpu);
+
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		int continue_balancing =3D 1;
-		u64 t0, domain_cost;
+		u64 domain_cost;
=20
-		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
-			update_next_balance(sd, &next_balance);
+		update_next_balance(sd, &next_balance);
+
+		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
 			break;
-		}
=20
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
-			t0 =3D sched_clock_cpu(this_cpu);
=20
 			pulled_task =3D load_balance(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
 						   &continue_balancing);
=20
-			domain_cost =3D sched_clock_cpu(this_cpu) - t0;
-			if (domain_cost > sd->max_newidle_lb_cost)
-				sd->max_newidle_lb_cost =3D domain_cost;
+			t1 =3D sched_clock_cpu(this_cpu);
+			domain_cost =3D t1 - t0;
+			update_newidle_cost(sd, domain_cost);
=20
 			curr_cost +=3D domain_cost;
+			t0 =3D t1;
 		}
=20
-		update_next_balance(sd, &next_balance);
-
 		/*
 		 * Stop searching for tasks to pull if there are
 		 * now runnable tasks on this rq.
@@ -11394,7 +11492,7 @@ int alloc_fair_sched_group(struct task_group *tg, str=
uct task_group *parent)
 		if (!cfs_rq)
 			goto err;
=20
-		se =3D kzalloc_node(sizeof(struct sched_entity),
+		se =3D kzalloc_node(sizeof(struct sched_entity_stats),
 				  GFP_KERNEL, cpu_to_node(i));
 		if (!se)
 			goto err_free_rq;
@@ -11560,7 +11658,7 @@ int sched_group_set_idle(struct task_group *tg, long =
idle)
 	for_each_possible_cpu(i) {
 		struct rq *rq =3D cpu_rq(i);
 		struct sched_entity *se =3D tg->se[i];
-		struct cfs_rq *grp_cfs_rq =3D tg->cfs_rq[i];
+		struct cfs_rq *parent_cfs_rq, *grp_cfs_rq =3D tg->cfs_rq[i];
 		bool was_idle =3D cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
 		struct rq_flags rf;
@@ -11571,6 +11669,14 @@ int sched_group_set_idle(struct task_group *tg, long=
 idle)
 		if (WARN_ON_ONCE(was_idle =3D=3D cfs_rq_is_idle(grp_cfs_rq)))
 			goto next_cpu;
=20
+		if (se->on_rq) {
+			parent_cfs_rq =3D cfs_rq_of(se);
+			if (cfs_rq_is_idle(grp_cfs_rq))
+				parent_cfs_rq->idle_nr_running++;
+			else
+				parent_cfs_rq->idle_nr_running--;
+		}
+
 		idle_task_delta =3D grp_cfs_rq->h_nr_running -
 				  grp_cfs_rq->idle_h_nr_running;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7f8dace0964c..1cf435bbcd9c 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -46,11 +46,16 @@ SCHED_FEAT(DOUBLE_TICK, false)
  */
 SCHED_FEAT(NONTASK_CAPACITY, true)
=20
+#ifdef CONFIG_PREEMPT_RT
+SCHED_FEAT(TTWU_QUEUE, false)
+#else
+
 /*
  * Queue remote wakeups on the target CPU and process them
  * using the scheduler IPI. Reduces rq->lock contention/bounces.
  */
 SCHED_FEAT(TTWU_QUEUE, true)
+#endif
=20
 /*
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3daf42a0f462..bb945f8faeca 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1009,8 +1009,10 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely((s64)delta_exec <=3D 0))
 		return;
=20
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
+
+	trace_sched_stat_runtime(curr, delta_exec, 0);
=20
 	curr->se.sum_exec_runtime +=3D delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
@@ -1271,6 +1273,112 @@ static void __delist_rt_entity(struct sched_rt_entity=
 *rt_se, struct rt_prio_arr
 	rt_se->on_list =3D 0;
 }
=20
+static inline struct sched_statistics *
+__schedstats_from_rt_se(struct sched_rt_entity *rt_se)
+{
+#ifdef CONFIG_RT_GROUP_SCHED
+	/* schedstats is not supported for rt group. */
+	if (!rt_entity_is_task(rt_se))
+		return NULL;
+#endif
+
+	return &rt_task_of(rt_se)->stats;
+}
+
+static inline void
+update_stats_wait_start_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_s=
e)
+{
+	struct sched_statistics *stats;
+	struct task_struct *p =3D NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p =3D rt_task_of(rt_se);
+
+	stats =3D __schedstats_from_rt_se(rt_se);
+	if (!stats)
+		return;
+
+	__update_stats_wait_start(rq_of_rt_rq(rt_rq), p, stats);
+}
+
+static inline void
+update_stats_enqueue_sleeper_rt(struct rt_rq *rt_rq, struct sched_rt_entity =
*rt_se)
+{
+	struct sched_statistics *stats;
+	struct task_struct *p =3D NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p =3D rt_task_of(rt_se);
+
+	stats =3D __schedstats_from_rt_se(rt_se);
+	if (!stats)
+		return;
+
+	__update_stats_enqueue_sleeper(rq_of_rt_rq(rt_rq), p, stats);
+}
+
+static inline void
+update_stats_enqueue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
+			int flags)
+{
+	if (!schedstat_enabled())
+		return;
+
+	if (flags & ENQUEUE_WAKEUP)
+		update_stats_enqueue_sleeper_rt(rt_rq, rt_se);
+}
+
+static inline void
+update_stats_wait_end_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
+{
+	struct sched_statistics *stats;
+	struct task_struct *p =3D NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p =3D rt_task_of(rt_se);
+
+	stats =3D __schedstats_from_rt_se(rt_se);
+	if (!stats)
+		return;
+
+	__update_stats_wait_end(rq_of_rt_rq(rt_rq), p, stats);
+}
+
+static inline void
+update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
+			int flags)
+{
+	struct task_struct *p =3D NULL;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_entity_is_task(rt_se))
+		p =3D rt_task_of(rt_se);
+
+	if ((flags & DEQUEUE_SLEEP) && p) {
+		unsigned int state;
+
+		state =3D READ_ONCE(p->__state);
+		if (state & TASK_INTERRUPTIBLE)
+			__schedstat_set(p->stats.sleep_start,
+					rq_clock(rq_of_rt_rq(rt_rq)));
+
+		if (state & TASK_UNINTERRUPTIBLE)
+			__schedstat_set(p->stats.block_start,
+					rq_clock(rq_of_rt_rq(rt_rq)));
+	}
+}
+
 static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int =
flags)
 {
 	struct rt_rq *rt_rq =3D rt_rq_of_se(rt_se);
@@ -1344,6 +1452,8 @@ static void enqueue_rt_entity(struct sched_rt_entity *r=
t_se, unsigned int flags)
 {
 	struct rq *rq =3D rq_of_rt_se(rt_se);
=20
+	update_stats_enqueue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
 	for_each_sched_rt_entity(rt_se)
 		__enqueue_rt_entity(rt_se, flags);
@@ -1354,6 +1464,8 @@ static void dequeue_rt_entity(struct sched_rt_entity *r=
t_se, unsigned int flags)
 {
 	struct rq *rq =3D rq_of_rt_se(rt_se);
=20
+	update_stats_dequeue_rt(rt_rq_of_se(rt_se), rt_se, flags);
+
 	dequeue_rt_stack(rt_se, flags);
=20
 	for_each_sched_rt_entity(rt_se) {
@@ -1376,6 +1488,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, i=
nt flags)
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout =3D 0;
=20
+	check_schedstat_required();
+	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
+
 	enqueue_rt_entity(rt_se, flags);
=20
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1576,7 +1691,12 @@ static void check_preempt_curr_rt(struct rq *rq, struc=
t task_struct *p, int flag
=20
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bo=
ol first)
 {
+	struct sched_rt_entity *rt_se =3D &p->rt;
+	struct rt_rq *rt_rq =3D &rq->rt;
+
 	p->se.exec_start =3D rq_clock_task(rq);
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_end_rt(rt_rq, rt_se);
=20
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
@@ -1650,6 +1770,12 @@ static struct task_struct *pick_next_task_rt(struct rq=
 *rq)
=20
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
+	struct sched_rt_entity *rt_se =3D &p->rt;
+	struct rt_rq *rt_rq =3D &rq->rt;
+
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_start_rt(rt_rq, rt_se);
+
 	update_curr_rt(rq);
=20
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d3e5793e117..f0b249ec581d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -369,6 +369,7 @@ struct cfs_bandwidth {
 	u64			quota;
 	u64			runtime;
 	u64			burst;
+	u64			runtime_snap;
 	s64			hierarchical_quota;
=20
 	u8			idle;
@@ -381,7 +382,9 @@ struct cfs_bandwidth {
 	/* Statistics: */
 	int			nr_periods;
 	int			nr_throttled;
+	int			nr_burst;
 	u64			throttled_time;
+	u64			burst_time;
 #endif
 };
=20
@@ -530,6 +533,7 @@ struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
=20
 	u64			exec_clock;
@@ -1254,11 +1258,6 @@ extern void sched_core_dequeue(struct rq *rq, struct t=
ask_struct *p);
 extern void sched_core_get(void);
 extern void sched_core_put(void);
=20
-extern unsigned long sched_core_alloc_cookie(void);
-extern void sched_core_put_cookie(unsigned long cookie);
-extern unsigned long sched_core_get_cookie(unsigned long cookie);
-extern unsigned long sched_core_update_cookie(struct task_struct *p, unsigne=
d long cookie);
-
 #else /* !CONFIG_SCHED_CORE */
=20
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1422,11 +1421,6 @@ static inline struct cfs_rq *group_cfs_rq(struct sched=
_entity *grp)
=20
 extern void update_rq_clock(struct rq *rq);
=20
-static inline u64 __rq_clock_broken(struct rq *rq)
-{
-	return READ_ONCE(rq->clock);
-}
-
 /*
  * rq::clock_update_flags bits
  *
@@ -1621,14 +1615,6 @@ rq_lock(struct rq *rq, struct rq_flags *rf)
 	rq_pin_lock(rq, rf);
 }
=20
-static inline void
-rq_relock(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_rq_lock(rq);
-	rq_repin_lock(rq, rf);
-}
-
 static inline void
 rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
@@ -1809,6 +1795,7 @@ struct sched_group {
 	unsigned int		group_weight;
 	struct sched_group_capacity *sgc;
 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
+	int			flags;
=20
 	/*
 	 * The CPUs this group covers.
@@ -2402,6 +2389,7 @@ extern const_debug unsigned int sysctl_sched_migration_=
cost;
 #ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
+extern unsigned int sysctl_sched_idle_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern int sysctl_resched_latency_warn_ms;
 extern int sysctl_resched_latency_warn_once;
@@ -2709,12 +2697,18 @@ extern void cfs_bandwidth_usage_dec(void);
 #define NOHZ_BALANCE_KICK_BIT	0
 #define NOHZ_STATS_KICK_BIT	1
 #define NOHZ_NEWILB_KICK_BIT	2
+#define NOHZ_NEXT_KICK_BIT	3
=20
+/* Run rebalance_domains() */
 #define NOHZ_BALANCE_KICK	BIT(NOHZ_BALANCE_KICK_BIT)
+/* Update blocked load */
 #define NOHZ_STATS_KICK		BIT(NOHZ_STATS_KICK_BIT)
+/* Update blocked load when entering idle */
 #define NOHZ_NEWILB_KICK	BIT(NOHZ_NEWILB_KICK_BIT)
+/* Update nohz.next_balance */
+#define NOHZ_NEXT_KICK		BIT(NOHZ_NEXT_KICK_BIT)
=20
-#define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK)
+#define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK | NOHZ_NEXT_KICK)
=20
 #define nohz_flags(cpu)	(&cpu_rq(cpu)->nohz_flags)
=20
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 3f93fc3b5648..07dde2928c79 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -4,6 +4,110 @@
  */
 #include "sched.h"
=20
+void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
+			       struct sched_statistics *stats)
+{
+	u64 wait_start, prev_wait_start;
+
+	wait_start =3D rq_clock(rq);
+	prev_wait_start =3D schedstat_val(stats->wait_start);
+
+	if (p && likely(wait_start > prev_wait_start))
+		wait_start -=3D prev_wait_start;
+
+	__schedstat_set(stats->wait_start, wait_start);
+}
+
+void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
+			     struct sched_statistics *stats)
+{
+	u64 delta =3D rq_clock(rq) - schedstat_val(stats->wait_start);
+
+	if (p) {
+		if (task_on_rq_migrating(p)) {
+			/*
+			 * Preserve migrating task's wait time so wait_start
+			 * time stamp can be adjusted to accumulate wait time
+			 * prior to migration.
+			 */
+			__schedstat_set(stats->wait_start, delta);
+
+			return;
+		}
+
+		trace_sched_stat_wait(p, delta);
+	}
+
+	__schedstat_set(stats->wait_max,
+			max(schedstat_val(stats->wait_max), delta));
+	__schedstat_inc(stats->wait_count);
+	__schedstat_add(stats->wait_sum, delta);
+	__schedstat_set(stats->wait_start, 0);
+}
+
+void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
+				    struct sched_statistics *stats)
+{
+	u64 sleep_start, block_start;
+
+	sleep_start =3D schedstat_val(stats->sleep_start);
+	block_start =3D schedstat_val(stats->block_start);
+
+	if (sleep_start) {
+		u64 delta =3D rq_clock(rq) - sleep_start;
+
+		if ((s64)delta < 0)
+			delta =3D 0;
+
+		if (unlikely(delta > schedstat_val(stats->sleep_max)))
+			__schedstat_set(stats->sleep_max, delta);
+
+		__schedstat_set(stats->sleep_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
+
+		if (p) {
+			account_scheduler_latency(p, delta >> 10, 1);
+			trace_sched_stat_sleep(p, delta);
+		}
+	}
+
+	if (block_start) {
+		u64 delta =3D rq_clock(rq) - block_start;
+
+		if ((s64)delta < 0)
+			delta =3D 0;
+
+		if (unlikely(delta > schedstat_val(stats->block_max)))
+			__schedstat_set(stats->block_max, delta);
+
+		__schedstat_set(stats->block_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
+		__schedstat_add(stats->sum_block_runtime, delta);
+
+		if (p) {
+			if (p->in_iowait) {
+				__schedstat_add(stats->iowait_sum, delta);
+				__schedstat_inc(stats->iowait_count);
+				trace_sched_stat_iowait(p, delta);
+			}
+
+			trace_sched_stat_blocked(p, delta);
+
+			/*
+			 * Blocking time is in units of nanosecs, so shift by
+			 * 20 to get a milliseconds-range estimation of the
+			 * amount of time that the task spent sleeping:
+			 */
+			if (unlikely(prof_on =3D=3D SLEEP_PROFILING)) {
+				profile_hits(SLEEP_PROFILING,
+					     (void *)get_wchan(p),
+					     delta >> 20);
+			}
+			account_scheduler_latency(p, delta >> 10, 0);
+		}
+	}
+}
+
 /*
  * Current schedstat API version.
  *
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index d8f8eb0c655b..cfb0893a83d4 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -2,6 +2,8 @@
=20
 #ifdef CONFIG_SCHEDSTATS
=20
+extern struct static_key_false sched_schedstats;
+
 /*
  * Expects runqueue lock to be held for atomicity of update
  */
@@ -40,7 +42,31 @@ rq_sched_info_dequeue(struct rq *rq, unsigned long long de=
lta)
 #define   schedstat_val(var)		(var)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
=20
+void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
+			       struct sched_statistics *stats);
+
+void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
+			     struct sched_statistics *stats);
+void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
+				    struct sched_statistics *stats);
+
+static inline void
+check_schedstat_required(void)
+{
+	if (schedstat_enabled())
+		return;
+
+	/* Force schedstat enabled if a dependent tracepoint is active */
+	if (trace_sched_stat_wait_enabled()    ||
+	    trace_sched_stat_sleep_enabled()   ||
+	    trace_sched_stat_iowait_enabled()  ||
+	    trace_sched_stat_blocked_enabled() ||
+	    trace_sched_stat_runtime_enabled())
+		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, stat_=
blocked and stat_runtime require the kernel parameter schedstats=3Denable or =
kernel.sched_schedstats=3D1\n");
+}
+
 #else /* !CONFIG_SCHEDSTATS: */
+
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long =
delta) { }
 static inline void rq_sched_info_dequeue(struct rq *rq, unsigned long long d=
elta) { }
 static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long =
delta) { }
@@ -53,8 +79,31 @@ static inline void rq_sched_info_depart  (struct rq *rq, u=
nsigned long long delt
 # define   schedstat_set(var, val)	do { } while (0)
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
+
+# define __update_stats_wait_start(rq, p, stats)       do { } while (0)
+# define __update_stats_wait_end(rq, p, stats)         do { } while (0)
+# define __update_stats_enqueue_sleeper(rq, p, stats)  do { } while (0)
+# define check_schedstat_required()                    do { } while (0)
+
 #endif /* CONFIG_SCHEDSTATS */
=20
+#ifdef CONFIG_FAIR_GROUP_SCHED
+struct sched_entity_stats {
+	struct sched_entity     se;
+	struct sched_statistics stats;
+} __no_randomize_layout;
+#endif
+
+static inline struct sched_statistics *
+__schedstats_from_se(struct sched_entity *se)
+{
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (!entity_is_task(se))
+		return &container_of(se, struct sched_entity_stats, se)->stats;
+#endif
+	return &task_of(se)->stats;
+}
+
 #ifdef CONFIG_PSI
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index f988ebe3febb..0b165a25f22f 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -78,8 +78,8 @@ static void put_prev_task_stop(struct rq *rq, struct task_s=
truct *prev)
 	if (unlikely((s64)delta_exec < 0))
 		delta_exec =3D 0;
=20
-	schedstat_set(curr->se.statistics.exec_max,
-			max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
=20
 	curr->se.sum_exec_runtime +=3D delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4e8698e62f07..30169c7685b6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -526,7 +526,7 @@ static int init_rootdomain(struct root_domain *rd)
 #ifdef HAVE_RT_PUSH_IPI
 	rd->rto_cpu =3D -1;
 	raw_spin_lock_init(&rd->rto_lock);
-	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
+	rd->rto_push_work =3D IRQ_WORK_INIT_HARD(rto_push_irq_work_func);
 #endif
=20
 	rd->visit_gen =3D 0;
@@ -688,7 +688,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_do=
main *rd, int cpu)
 {
 	struct rq *rq =3D cpu_rq(cpu);
 	struct sched_domain *tmp;
-	int numa_distance =3D 0;
=20
 	/* Remove the sched domains which do not contribute to scheduling. */
 	for (tmp =3D sd; tmp; ) {
@@ -716,13 +715,22 @@ cpu_attach_domain(struct sched_domain *sd, struct root_=
domain *rd, int cpu)
 		tmp =3D sd;
 		sd =3D sd->parent;
 		destroy_sched_domain(tmp);
-		if (sd)
+		if (sd) {
+			struct sched_group *sg =3D sd->groups;
+
+			/*
+			 * sched groups hold the flags of the child sched
+			 * domain for convenience. Clear such flags since
+			 * the child is being destroyed.
+			 */
+			do {
+				sg->flags =3D 0;
+			} while (sg !=3D sd->groups);
+
 			sd->child =3D NULL;
+		}
 	}
=20
-	for (tmp =3D sd; tmp; tmp =3D tmp->parent)
-		numa_distance +=3D !!(tmp->flags & SD_NUMA);
-
 	sched_domain_debug(sd, cpu);
=20
 	rq_attach_root(rq, rd);
@@ -916,10 +924,12 @@ build_group_from_child_sched_domain(struct sched_domain=
 *sd, int cpu)
 		return NULL;
=20
 	sg_span =3D sched_group_span(sg);
-	if (sd->child)
+	if (sd->child) {
 		cpumask_copy(sg_span, sched_domain_span(sd->child));
-	else
+		sg->flags =3D sd->child->flags;
+	} else {
 		cpumask_copy(sg_span, sched_domain_span(sd));
+	}
=20
 	atomic_inc(&sg->ref);
 	return sg;
@@ -1169,6 +1179,7 @@ static struct sched_group *get_group(int cpu, struct sd=
_data *sdd)
 	if (child) {
 		cpumask_copy(sched_group_span(sg), sched_domain_span(child));
 		cpumask_copy(group_balance_mask(sg), sched_group_span(sg));
+		sg->flags =3D child->flags;
 	} else {
 		cpumask_set_cpu(cpu, sched_group_span(sg));
 		cpumask_set_cpu(cpu, group_balance_mask(sg));
@@ -1557,7 +1568,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		.last_balance		=3D jiffies,
 		.balance_interval	=3D sd_weight,
 		.max_newidle_lb_cost	=3D 0,
-		.next_decay_max_lb_cost	=3D jiffies,
+		.last_decay_max_lb_cost	=3D jiffies,
 		.child			=3D child,
 #ifdef CONFIG_SCHED_DEBUG
 		.name			=3D tl->name,
@@ -1627,6 +1638,11 @@ static struct sched_domain_topology_level default_topo=
logy[] =3D {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, cpu_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
+
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
 #endif
diff --git a/kernel/smp.c b/kernel/smp.c
index f43ede0ab183..01a7c1706a58 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1170,14 +1170,12 @@ void wake_up_all_idle_cpus(void)
 {
 	int cpu;
=20
-	preempt_disable();
-	for_each_online_cpu(cpu) {
-		if (cpu =3D=3D smp_processor_id())
-			continue;
-
-		wake_up_if_idle(cpu);
+	for_each_possible_cpu(cpu) {
+		preempt_disable();
+		if (cpu !=3D smp_processor_id() && cpu_online(cpu))
+			wake_up_if_idle(cpu);
+		preempt_enable();
 	}
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
=20
diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index b2d8b8aa2d99..8f636a23bc3f 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -455,8 +455,9 @@ sub parse_file
=20
 	open my $fh, "<", $file or return;
 	while ( <$fh> ) {
+		chomp;
 		if (may_leak_address($_)) {
-			print $file . ': ' . $_;
+			printf("$file: $_\n");
 		}
 	}
 	close $fh;
diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/se=
lftests/sched/cs_prctl_test.c
index 7db9cf822dc7..8109b17dc764 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -62,6 +62,17 @@ enum pid_type {PIDTYPE_PID =3D 0, PIDTYPE_TGID, PIDTYPE_PG=
ID};
=20
 const int THREAD_CLONE_FLAGS =3D CLONE_THREAD | CLONE_SIGHAND | CLONE_FS | C=
LONE_VM | CLONE_FILES;
=20
+struct child_args {
+	int num_threads;
+	int pfd[2];
+	int cpid;
+	int thr_tids[MAX_THREADS];
+};
+
+static struct child_args procs[MAX_PROCESSES];
+static int num_processes =3D 2;
+static int need_cleanup =3D 0;
+
 static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsign=
ed long arg4,
 		  unsigned long arg5)
 {
@@ -78,8 +89,14 @@ static int _prctl(int option, unsigned long arg2, unsigned=
 long arg3, unsigned l
 #define handle_error(msg) __handle_error(__FILE__, __LINE__, msg)
 static void __handle_error(char *fn, int ln, char *msg)
 {
+	int pidx;
 	printf("(%s:%d) - ", fn, ln);
 	perror(msg);
+	if (need_cleanup) {
+		for (pidx =3D 0; pidx < num_processes; ++pidx)
+			kill(procs[pidx].cpid, 15);
+		need_cleanup =3D 0;
+	}
 	exit(EXIT_FAILURE);
 }
=20
@@ -106,13 +123,6 @@ static unsigned long get_cs_cookie(int pid)
 	return cookie;
 }
=20
-struct child_args {
-	int num_threads;
-	int pfd[2];
-	int cpid;
-	int thr_tids[MAX_THREADS];
-};
-
 static int child_func_thread(void __attribute__((unused))*arg)
 {
 	while (1)
@@ -212,10 +222,7 @@ void _validate(int line, int val, char *msg)
=20
 int main(int argc, char *argv[])
 {
-	struct child_args procs[MAX_PROCESSES];
-
 	int keypress =3D 0;
-	int num_processes =3D 2;
 	int num_threads =3D 3;
 	int delay =3D 0;
 	int res =3D 0;
@@ -262,6 +269,7 @@ int main(int argc, char *argv[])
=20
 	printf("\n## Create a thread/process/process group hiearchy\n");
 	create_processes(num_processes, num_threads, procs);
+	need_cleanup =3D 1;
 	disp_processes(num_processes, procs);
 	validate(get_cs_cookie(0) =3D=3D 0);
=20

