Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEE3354B84
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 06:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhDFELv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:11:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:56295 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhDFELu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:11:50 -0400
IronPort-SDR: 5iu0SI/rRvBYKwZM7b6M4KMMQZEy7501GhS1wZ3E2gBUEmdltngPTKLOD3KHDi+R7q+lVDh7Vc
 ylQiGlNQMz7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193017344"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="193017344"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 21:11:42 -0700
IronPort-SDR: uB+xPBc16sXjRnYuU82jh7urdeDFTkKk90luMJ1tsEEGvCs7di+duZ+q/mIZ34P3k6n5W9MotI
 EeblOUeqn2ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="518864611"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2021 21:11:42 -0700
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
Subject: [PATCH 0/4] sched/fair: Fix load balancing of SMT siblings with ASYM_PACKING
Date:   Mon,  5 Apr 2021 21:11:04 -0700
Message-Id: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
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

When using SD_ASYM_PACKING on x86 with Intel Turbo Boost Max Turbo 3.0
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
scheduling group with priority Q and then such tasks are spread in the
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

I ran a few benchmarks with and without this patchset on an Intel(R)
Core(TM) i9-7900X CPU. I kept online both SMT siblings of two high
priority cores. I offlined the lower priority SMT siblings of three low
priority cores. I offlined the rest of the cores. The resulting priority
configuration meets the N*P > Q > P condition described above.

The baseline for the results is an unmodified v5.12-rc3 kernel. Results
show a comparative percentage of improvement (positive) or degradation
(negative). Each test case is repeated three times, and the standard
deviation among repetitions is also documented.

In order to judge only the improvements this patchset provide, Table 1
shows the results when setting the CPU's frequency at 800MHz. It can be
observed that the patches bring an overall positive impact, especially on
schench. Regressions are mostly of less than 1%.

Table 2 shows the results when using hardware-controlled performance
performance states (HWP), a common use case. In this case, the impact of
the patches is overall positive, especially on schbench. Although some
regressions are also observed.

Thanks and BR,
Ricardo

========       Table 1. Test results of patches at 800MHz      ========
=======================================================================
hackbench
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            group-1          1.00 (  3.19)   +1.50 (  4.10)
process-pipe            group-2          1.00 (  1.07)   -0.82 (  0.63)
process-pipe            group-4          1.00 (  2.61)   +1.35 (  4.88)
process-pipe            group-8          1.00 (  6.81)   +0.90 ( 17.64)
process-sockets         group-1          1.00 (  0.35)   +0.37 (  1.37)
process-sockets         group-2          1.00 (  0.69)   -0.42 (  0.81)
process-sockets         group-4          1.00 (  1.89)   -0.06 (  1.83)
process-sockets         group-8          1.00 (  3.10)   -6.92 (  8.11)
threads-pipe            group-1          1.00 (  5.89)   +6.42 (  2.68)
threads-pipe            group-2          1.00 (  2.26)   +2.81 (  3.36)
threads-pipe            group-4          1.00 (  4.01)   +0.51 (  5.17)
threads-pipe            group-8          1.00 ( 16.17)  +18.85 ( 11.37)
threads-sockets         group-1          1.00 (  1.00)   -3.96 (  2.34)
threads-sockets         group-2          1.00 (  1.22)   +0.67 (  1.26)
threads-sockets         group-4          1.00 (  0.51)   +0.39 (  0.32)
threads-sockets         group-8          1.00 (  3.39)   +2.19 (  3.16)

netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  thread-1         1.00 (  0.41)   -0.47 (  0.25)
TCP_RR                  thread-3         1.00 (  0.41)   +2.74 (  0.29)
TCP_RR                  thread-7         1.00 ( 11.00)   +0.29 ( 16.64)
TCP_RR                  thread-14        1.00 ( 23.14)   +0.71 ( 22.57)
UDP_RR                  thread-1         1.00 (  0.13)   -0.24 (  0.20)
UDP_RR                  thread-3         1.00 (  0.32)   +3.82 (  0.46)
UDP_RR                  thread-7         1.00 (  8.85)   +0.43 ( 13.60)
UDP_RR                  thread-14        1.00 ( 20.71)   +0.58 ( 21.85)

tbench
======
case                    load            baseline(std%)  compare%( std%)
loopback                thread-1         1.00 (  0.10)   +0.06 (  0.27)
loopback                thread-3         1.00 (  0.27)   +3.87 (  0.11)
loopback                thread-7         1.00 (  0.28)   -0.27 (  1.29)
loopback                thread-14        1.00 (  0.07)   +0.52 (  0.24)

schbench
========
case                    load            baseline(std%)  compare%( std%)
normal                  mthread-1        1.00 (  2.33)  +32.38 (  1.99)
normal                  mthread-2        1.00 (  0.00)   +0.00 (  0.00)
normal                  mthread-4        1.00 (  0.00)   +0.00 (  0.00)
normal                  mthread-8        1.00 (  3.01)   -2.16 (  3.04)

========      Table 2. Test results of patches with HWP        ========
=======================================================================

hackbench
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            group-1          1.00 (  4.73)   -3.23 (  2.62)
process-pipe            group-2          1.00 (  2.32)   +0.13 (  0.36)
process-pipe            group-4          1.00 (  3.85)   +1.95 (  3.92)
process-pipe            group-8          1.00 ( 14.31)   +2.12 ( 13.44)
process-sockets         group-1          1.00 (  3.10)   -1.22 (  1.95)
process-sockets         group-2          1.00 (  0.91)   -1.30 (  1.20)
process-sockets         group-4          1.00 (  0.87)   -1.29 (  1.35)
process-sockets         group-8          1.00 (  4.98)   +1.21 (  4.57)
threads-pipe            group-1          1.00 (  0.76)   +2.87 (  0.89)
threads-pipe            group-2          1.00 (  1.41)   -3.19 (  1.18)
threads-pipe            group-4          1.00 (  2.37)   -1.22 (  1.41)
threads-pipe            group-8          1.00 ( 15.12)   +6.64 (  5.82)
threads-sockets         group-1          1.00 (  2.73)   +0.89 (  0.92)
threads-sockets         group-2          1.00 (  1.59)   -4.32 (  1.23)
threads-sockets         group-4          1.00 (  0.35)   -1.42 (  1.13)
threads-sockets         group-8          1.00 (  0.77)   +0.23 (  1.35)

netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  thread-1         1.00 (  0.27)   +0.05 (  0.41)
TCP_RR                  thread-3         1.00 (  4.71)   +8.43 (  0.45)
TCP_RR                  thread-7         1.00 ( 10.15)   -1.16 ( 16.95)
TCP_RR                  thread-14        1.00 ( 23.46)   +0.21 ( 23.69)
UDP_RR                  thread-1         1.00 (  0.16)   +1.52 (  0.81)
UDP_RR                  thread-3         1.00 (  4.00)   +8.33 (  0.50)
UDP_RR                  thread-7         1.00 (  7.39)   -0.99 ( 11.34)
UDP_RR                  thread-14        1.00 ( 23.74)   -0.51 ( 21.87)

tbench
======
case                    load            baseline(std%)  compare%( std%)
loopback                thread-1         1.00 (  0.51)   -0.86 (  0.08)
loopback                thread-3         1.00 (  1.40)  +52.18 (  1.13)
loopback                thread-7         1.00 (  0.94)   +0.31 (  0.20)
loopback                thread-14        1.00 (  0.21)   -0.24 (  0.47)

schbench
========
case                    load            baseline(std%)  compare%( std%)
normal                  mthread-1        1.00 ( 20.14)  +61.19 (  5.44)
normal                  mthread-2        1.00 (  0.00)   +0.00 (  0.00)
normal                  mthread-4        1.00 (  0.00)   +0.00 (  0.00)
normal                  mthread-8        1.00 (  3.05)   -2.16 (  2.99)

Ricardo Neri (4):
  sched/fair: Optimize checking for group_asym_packing
  sched/fair: Introduce arch_sched_asym_prefer_early()
  sched/fair: Consider SMT in ASYM_PACKING load balance
  x86/sched: Enable checks of the state of SMT siblings in load
    balancing

 arch/x86/kernel/itmt.c         |  15 ++++
 include/linux/sched/topology.h |   2 +
 kernel/sched/fair.c            | 135 ++++++++++++++++++++++++++++++++-
 3 files changed, 150 insertions(+), 2 deletions(-)

-- 
2.17.1

