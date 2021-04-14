Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B335EA93
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346144AbhDNCF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:05:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:7629 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232171AbhDNCFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:05:53 -0400
IronPort-SDR: H62BzvZj1/dtAI82tP1OEYOXQpr0QWy6rfNyNHMdBFEKqf6d1YnXCpwK0tK8cvAqKBzLQ7SLLS
 zsk720qx2+HA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194571772"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="194571772"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 19:05:29 -0700
IronPort-SDR: BahqCTx9YUXkyx7fuL4z3ATD2WwOsAieggqYXNn+e2I8/2KzA9+Tj4kxTOyDkjvlHxVlpY5hZo
 RPBTU8DucGAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="450625202"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2021 19:05:29 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
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
Subject: [PATCH v2 0/4] sched/fair: Fix load balancing of SMT siblings with ASYM_PACKING
Date:   Tue, 13 Apr 2021 19:04:32 -0700
Message-Id: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

The baseline for the results is an unmodified v5.12-rc3 kernel. Results
show a comparative percentage of improvement (positive) or degradation
(negative). Each test case is repeated five times, and the standard
deviation among repetitions is also documented.

In order to judge only the improvements this patchset provides, Table 1
shows the results when setting the CPU's frequency at 1000MHz. It can be
observed that the patches bring an overall positive impact for tests
that exhibit low variance. Some of the test cases, however, show a high
variance and it is difficult to assess the impact.

Table 2 shows the results when using hardware-controlled performance
performance states (HWP), a common use case. In this case, the impact of
the patches is also overall positive. schbench exhibits a small
degradation. However, it also exhibits a large variance.

v1 patches and test results can be found in [1].

Thanks and BR,
Ricardo

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
process-pipe            group-1          1.00 (  4.01)   +6.98 (  3.05)
process-pipe            group-2          1.00 (  4.17)   +1.20 (  2.21)
process-pipe            group-4          1.00 (  5.26)   +4.54 (  2.67)
process-pipe            group-8          1.00 ( 12.57)   -2.49 ( 11.70)
process-sockets         group-1          1.00 (  0.65)   +3.77 (  0.87)
process-sockets         group-2          1.00 (  1.04)   +0.45 (  0.49)
process-sockets         group-4          1.00 (  0.57)   +0.16 (  1.63)
process-sockets         group-8          1.00 (  6.39)   +0.58 (  6.16)
threads-pipe            group-1          1.00 (  2.82)   +1.04 (  3.60)
threads-pipe            group-2          1.00 (  2.50)   +3.53 (  1.44)
threads-pipe            group-4          1.00 (  5.55)   -0.02 (  1.05)
threads-pipe            group-8          1.00 ( 12.85)   -1.00 ( 14.05)
threads-sockets         group-1          1.00 (  1.26)   +4.54 (  1.92)
threads-sockets         group-2          1.00 (  2.11)   +2.80 (  0.40)
threads-sockets         group-4          1.00 (  0.70)   +0.61 (  0.88)
threads-sockets         group-8          1.00 (  1.20)   +0.29 (  2.20)

netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  thread-2         1.00 (  0.72)   +3.48 (  0.40)
TCP_RR                  thread-4         1.00 (  0.38)   +4.11 (  0.35)
TCP_RR                  thread-8         1.00 (  9.29)   -0.67 ( 14.12)
TCP_RR                  thread-16        1.00 ( 21.18)   -0.10 ( 20.92)
UDP_RR                  thread-2         1.00 (  0.23)   +4.08 (  0.16)
UDP_RR                  thread-4         1.00 (  0.19)   +3.53 (  0.27)
UDP_RR                  thread-8         1.00 (  6.83)   -1.63 ( 11.09)
UDP_RR                  thread-16        1.00 ( 20.85)   -1.02 ( 21.20)

tbench
======
case                    load            baseline(std%)  compare%( std%)
loopback                thread-2         1.00 (  0.15)   +4.49 (  0.20)
loopback                thread-4         1.00 (  0.25)   +3.99 (  0.32)
loopback                thread-8         1.00 (  0.16)   +0.49 (  0.30)
loopback                thread-16        1.00 (  0.32)   +0.49 (  0.21)

schbench
========
case                    load            baseline(std%)  compare%( std%)
normal                  mthread-1        1.00 ( 15.87)  -17.76 (  8.38)
normal                  mthread-2        1.00 (  0.10)   -0.05 (  0.00)
normal                  mthread-4        1.00 (  0.00)   +0.00 (  0.00)
normal                  mthread-8        1.00 (  4.81)   +5.57 (  2.61)


========      Table 2. Test results of patches with HWP        ========
=======================================================================
hackbench
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            group-1          1.00 (  0.76)   +0.14 (  1.11)
process-pipe            group-2          1.00 (  2.59)   +0.88 (  3.16)
process-pipe            group-4          1.00 (  4.05)   +1.13 (  4.86)
process-pipe            group-8          1.00 (  7.37)   -2.34 ( 14.43)
process-sockets         group-1          1.00 ( 15.98)   +7.77 (  1.44)
process-sockets         group-2          1.00 (  1.64)   +0.00 (  1.59)
process-sockets         group-4          1.00 (  0.95)   -1.54 (  0.85)
process-sockets         group-8          1.00 (  1.84)   -3.27 (  4.86)
threads-pipe            group-1          1.00 (  3.27)   +0.64 (  2.91)
threads-pipe            group-2          1.00 (  3.02)   -0.09 (  1.50)
threads-pipe            group-4          1.00 (  5.39)   -6.34 (  3.11)
threads-pipe            group-8          1.00 (  5.56)   +4.61 ( 14.91)
threads-sockets         group-1          1.00 (  2.76)   +4.70 (  0.94)
threads-sockets         group-2          1.00 (  1.10)   +3.56 (  1.41)
threads-sockets         group-4          1.00 (  0.45)   +2.11 (  1.32)
threads-sockets         group-8          1.00 (  3.56)   +3.62 (  2.43)

netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  thread-2         1.00 (  0.36)   +9.85 (  2.09)
TCP_RR                  thread-4         1.00 (  0.31)   +1.30 (  0.53)
TCP_RR                  thread-8         1.00 ( 11.70)   -0.42 ( 13.31)
TCP_RR                  thread-16        1.00 ( 23.49)   -0.55 ( 21.79)
UDP_RR                  thread-2         1.00 (  0.19)  +13.11 (  7.48)
UDP_RR                  thread-4         1.00 (  0.13)   +2.69 (  0.26)
UDP_RR                  thread-8         1.00 (  8.95)   -1.39 ( 12.39)
UDP_RR                  thread-16        1.00 ( 21.54)   -0.77 ( 20.97)

tbench
======
case                    load            baseline(std%)  compare%( std%)
loopback                thread-2         1.00 (  0.22)   +5.26 (  0.46)
loopback                thread-4         1.00 (  2.56)  +52.11 (  0.73)
loopback                thread-8         1.00 (  0.41)   +0.53 (  0.42)
loopback                thread-16        1.00 (  0.60)   +1.39 (  0.33)

schbench
========
case                    load            baseline(std%)  compare%( std%)
normal                  mthread-1        1.00 ( 12.01)   -1.72 (  2.08)
normal                  mthread-2        1.00 (  0.00)   +0.00 (  0.00)
normal                  mthread-4        1.00 (  0.00)   +0.00 (  0.00)
normal                  mthread-8        1.00 (  0.00)   +0.00 (  0.00)

========
[1]. https://lore.kernel.org/lkml/20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com/

Ricardo Neri (4):
  sched/fair: Optimize checking for group_asym_packing
  sched/fair: Introduce arch_sched_asym_prefer_early()
  sched/fair: Consider SMT in ASYM_PACKING load balance
  x86/sched: Enable checks of the state of SMT siblings in load
    balancing

 arch/x86/kernel/itmt.c         |  15 ++++
 include/linux/sched/topology.h |   2 +
 kernel/sched/fair.c            | 140 ++++++++++++++++++++++++++++++++-
 3 files changed, 155 insertions(+), 2 deletions(-)

-- 
2.17.1

