Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72BD37FB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhEMPwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:52:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:24114 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232418AbhEMPvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:51:13 -0400
IronPort-SDR: Fr4f6t6w0N1vAlMDogBTxJjScs7MHmQdvB6j5vExWu66sWk5OZ5jPI++3TSpABLIK+WKuAWCME
 4Z/fMVC06weA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="179568904"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="179568904"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 08:49:59 -0700
IronPort-SDR: byZaZfiEz25Q+1bpN14ZhaFKifHc/nXjHhdGv2IlmgtKleGnAHnHNRKvqV2bRFohkVw6BhYZ+b
 41QWXjjg3XPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="610418827"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2021 08:49:58 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v3 0/6] sched/fair: Fix load balancing of SMT siblings with ASYM_PACKING
Date:   Thu, 13 May 2021 08:49:03 -0700
Message-Id: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 the series. v1 and v2 patches and test results can be found in
[1] and [2], respectively.

=== Problem statement ===
On SMT-enabled hardware, ASYM_PACKING can cause the load balancer to choose
low priority CPUs over medium priority CPUs.

When balancing load in scheduling domains with the SD_ASYM_PACKING flag,
idle CPUs of higher priority pull tasks from CPUs of lower priority. This
balancing is done by comparing pairs of scheduling groups. There may also
be scheduling groups composed of CPUs that are SMT siblings.

When using SD_ASYM_PACKING on x86 with Intel Turbo Boost Max Technology 3.0
(ITMT), the priorities of a scheduling group of CPUs that has N SMT
siblings are assigned as N*P, N*P/2, N*P/3, ..., P, where P is the
priority assigned by the hardware to the physical core and N is the number
of SMT siblings.

Systems such as Intel Comet Lake can have some cores supporting SMT, while
others do not. As a result, it is possible to have medium non-SMT
priorities, Q, such that N*P > Q > P.

When comparing groups for load balancing, the priority of the CPU doing the
load balancing is only compared with the preferred CPU of the candidate
busiest group (N*P vs Q in the example above). Thus, scheduling groups
with a preferred CPU with priority N*P always pull tasks from the
scheduling group with priority Q and then such tasks are spread across the
“SMT” domain. Conversely, since N*P > Q, CPUs with priority Q cannot
pull tasks from a group with a preferred CPU with priority N*P, even
though Q > P.

Doing load balancing based on load (i.e. if the busiest group is of type
group_overloaded) will not help if the system is not fully busy as the
involved groups will have only one task and load balancing will
not be deemed as necessary.

The behavior described above results in leaving CPUs with medium priority
idle, while CPUs with lower priority are busy. Furthermore, such CPUs of
lower priority are SMT siblings of high priority CPUs, which are also busy.

This patchset fixes this behavior by also checking the idle state of the
SMT siblings of both the CPU doing the load balance and the busiest
candidate group.

I ran a few benchmarks with and without this version of the patchset on
an Intel(R) Core(TM) i9-7900X CPU. I kept online both SMT siblings of two
high priority cores. I offlined the lower priority SMT siblings of four
low priority cores. I offlined the rest of the cores. The resulting
priority configuration meets the N*P > Q > P condition described above.

The baseline for the results is an unmodified v5.12 kernel. Results
show a comparative percentage of improvement (positive) or degradation
(negative). Each test case is repeated five times, and the standard
deviation among repetitions is also documented.

In order to judge only the improvements this patchset provides, Table 1
shows the results when setting the CPU's frequency at 1000MHz. It can be
observed that the patches bring an overall positive impact for tests
that exhibit low variance. Some of the test cases, however, show a high
variance and it is difficult to assess the impact. Still, a few test
cases with low variance exhibit slight degradation.

Table 2 shows the results when using hardware-controlled performance
performance states (HWP), a common use case. In this case, the impact of
the patches is also overall positive with a few test cases showing slight
degradation.

Thanks and BR,
Ricardo

========
Changes since v2:
  * Removed arch_sched_asym_prefer_early() and re-evaluation of the
    candidate busiest group in update_sd_pick_busiest(). (PeterZ)
  * Introduced sched_group::flags to reflect the properties of CPUs
    in the scheduling group. This helps to identify scheduling groups
    whose CPUs are SMT siblings. (PeterZ)
  * Modified update_sg_lb_stats() to get statistics of the scheduling
    domain as an argument. This provides it with the statistics of the
    local domain. (PeterZ)
  * Introduced sched_asym() to decide if a busiest candidate group can
    be marked for asymmetric packing.
  * Reworded patch 1 for clarity. (PeterZ)

========
Changes since v1:
  * Don't bailout in update_sd_pick_busiest() if dst_cpu cannot pull
    tasks. Instead, reclassify the candidate busiest group, as it
    may still be selected. (PeterZ)
  * Avoid an expensive and unnecessary call to cpumask_weight() when
    determining if a sched_group is comprised of SMT siblings.
    (PeterZ).
  * Updated test results using the v2 patches.

========      Table 1. Test results of patches at 10000MHz     ========
=======================================================================
hackbench
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            group-2          1.00 (  4.17)   +0.41 (  1.35)
process-pipe            group-4          1.00 (  5.26)   +4.02 (  3.80)
process-pipe            group-8          1.00 ( 12.57)   +1.34 ( 16.28)
process-sockets         group-2          1.00 (  1.04)   +0.83 (  0.58)
process-sockets         group-4          1.00 (  0.57)   -0.38 (  1.13)
process-sockets         group-8          1.00 (  6.39)   +1.15 (  3.44)
threads-pipe            group-2          1.00 (  2.50)   +1.47 (  1.78)
threads-pipe            group-4          1.00 (  5.55)   +2.68 (  4.88)
threads-pipe            group-8          1.00 ( 12.85)   -0.89 ( 10.56)
threads-sockets         group-2          1.00 (  2.11)   +1.77 (  0.77)
threads-sockets         group-4          1.00 (  0.70)   +1.11 (  0.92)
threads-sockets         group-8          1.00 (  1.20)   -1.79 (  1.88)

netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  thread-2         1.00 (  0.72)   -1.42 (  0.45)
TCP_RR                  thread-4         1.00 (  0.38)   +4.57 (  0.44)
TCP_RR                  thread-8         1.00 (  9.29)   +1.09 ( 15.02)
TCP_RR                  thread-16        1.00 ( 21.18)   +0.88 ( 23.62)
UDP_RR                  thread-2         1.00 (  0.23)   -2.41 (  0.49)
UDP_RR                  thread-4         1.00 (  0.19)   +4.54 (  0.37)
UDP_RR                  thread-8         1.00 (  6.83)   -0.78 (  7.70)
UDP_RR                  thread-16        1.00 ( 20.85)   -0.00 ( 19.52)

tbench
======
case                    load            baseline(std%)  compare%( std%)
loopback                thread-2         1.00 (  0.15)   -1.48 (  0.15)
loopback                thread-4         1.00 (  0.25)   +3.65 (  0.36)
loopback                thread-8         1.00 (  0.16)   +0.74 (  0.28)
loopback                thread-16        1.00 (  0.32)   +0.85 (  0.32)

schbench
========
case                    load            baseline(std%)  compare%( std%)
normal                  mthread-2        1.00 (  0.10)   -0.05 (  0.00)
normal                  mthread-4        1.00 (  0.00)   +0.00 (  0.00)
normal                  mthread-8        1.00 (  4.81)   +5.57 (  2.61)

========      Table 2. Test results of patches with HWP        ========
=======================================================================

hackbench
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            group-2          1.00 (  2.59)   +2.93 (  2.10)
process-pipe            group-4          1.00 (  4.05)   +5.82 (  4.55)
process-pipe            group-8          1.00 (  7.37)   -0.09 ( 15.19)
process-sockets         group-2          1.00 (  1.64)   -1.48 (  1.61)
process-sockets         group-4          1.00 (  0.95)   -1.97 (  1.44)
process-sockets         group-8          1.00 (  1.84)   -0.64 (  2.08)
threads-pipe            group-2          1.00 (  3.02)   -0.09 (  1.70)
threads-pipe            group-4          1.00 (  5.39)   +3.42 (  4.59)
threads-pipe            group-8          1.00 (  5.56)   +1.96 ( 10.98)
threads-sockets         group-2          1.00 (  1.10)   +1.99 (  1.67)
threads-sockets         group-4          1.00 (  0.45)   +1.56 (  1.10)
threads-sockets         group-8          1.00 (  3.56)   +3.27 (  1.47)

netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  thread-2         1.00 (  0.36)  +21.26 (  1.40)
TCP_RR                  thread-4         1.00 (  0.31)   +1.74 (  0.31)
TCP_RR                  thread-8         1.00 ( 11.70)   -1.03 ( 13.55)
TCP_RR                  thread-16        1.00 ( 23.49)   -0.43 ( 22.79)
UDP_RR                  thread-2         1.00 (  0.19)  +16.29 (  0.97)
UDP_RR                  thread-4         1.00 (  0.13)   +3.51 (  0.51)
UDP_RR                  thread-8         1.00 (  8.95)   +0.05 ( 10.84)
UDP_RR                  thread-16        1.00 ( 21.54)   +0.10 ( 22.89)

tbench
======
case                    load            baseline(std%)  compare%( std%)
loopback                thread-2         1.00 (  0.22)  +10.81 (  1.23)
loopback                thread-4         1.00 (  2.56)  +61.43 (  0.56)
loopback                thread-8         1.00 (  0.41)   -0.10 (  0.42)
loopback                thread-16        1.00 (  0.60)   +0.59 (  0.21)

schbench
========
case                    load            baseline(std%)  compare%( std%)
normal                  mthread-2        1.00 (  0.00)   +0.00 (  0.00)
normal                  mthread-4        1.00 (  0.00)   +0.00 (  0.00)
normal                  mthread-8        1.00 (  0.00)   -2.67 (  5.20)

========
[1]. https://lore.kernel.org/lkml/20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/lkml/20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com/

Ricardo Neri (6):
  sched/topology: Introduce sched_group::flags
  sched/fair: Optimize checking for group_asym_packing
  sched/fair: Provide update_sg_lb_stats() with sched domain statistics
  sched/fair: Carve out logic to mark a group for asymmetric packing
  sched/fair: Consider SMT in ASYM_PACKING load balance
  x86/sched: Enable SMT checks for asymmetric packing in load balancing

 arch/x86/kernel/itmt.c         |  10 +++
 include/linux/sched/topology.h |   1 +
 kernel/sched/fair.c            | 135 ++++++++++++++++++++++++++++++---
 kernel/sched/sched.h           |   1 +
 kernel/sched/topology.c        |   7 +-
 5 files changed, 142 insertions(+), 12 deletions(-)

-- 
2.17.1

