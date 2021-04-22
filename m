Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA52367E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhDVKYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:24:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230285AbhDVKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:24:47 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MA42wl032604;
        Thu, 22 Apr 2021 06:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=2Nb19e8D5tgBbq0MDppymybg43rPcVaUiSqQeppkMyA=;
 b=m82zVBNPNdgQSmbzoktiPNacE1+U9YLm4SXa+L1dxbnQpAnLWvhz6K+/k70yL0qZkaWj
 xlstV8bGgMieIlWVSUB/+DD5bPmsygxYaLBCgozqVN1L3mifXWE511e2uypsNxBIvRmH
 nLwTZ5s0zGACrs2xuZBCsefbF95OJlkSxnNvRHqVq4tTC8s/mAE9GJYuMj6xrTPNFdJY
 SVUNaBknf29DrrcrHts7F+C1gYxjiIgKydd0N+2DYtEBEhXZZORrekTm6EM5xW4MVUjM
 BRZI0Wzp75Fx6Hjbr8g6zq9rhsLW1swvyN9DR5wzIg1J5U5svh5SQAxDqmFWarbPxtt2 vg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38347rnum8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:23:44 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MALset013071;
        Thu, 22 Apr 2021 10:23:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 37ypxh9j0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:23:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MANFWI29426144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:23:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19A7FAE053;
        Thu, 22 Apr 2021 10:23:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E3C1AE045;
        Thu, 22 Apr 2021 10:23:35 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:23:35 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: [PATCH 00/10] sched/fair: wake_affine improvements
Date:   Thu, 22 Apr 2021 15:53:16 +0530
Message-Id: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vZ4O2JaIfri9T9wHhmM6UkZpGEXcyrxo
X-Proofpoint-ORIG-GUID: vZ4O2JaIfri9T9wHhmM6UkZpGEXcyrxo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 mlxlogscore=952 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104220084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we found that some of the benchmark numbers on Power10 were lesser
than expected. Some analysis showed that the problem lies in the fact that
L2-Cache on Power10 is at core level i.e only 4 threads share the L2-cache.

One probable solution to the problem was worked by Gautham where he posted
http://lore.kernel.org/lkml/1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com/t/#u
a patch that marks MC domain as LLC.

Here the focus is on seeing if we can improve the current core scheduler's
wakeup mechanism by looking at idle-cores and nr_busy_cpus that is already
maintained per Last level cache(aka LLC) (first 8 patches) + explore the
possibility to provide a fallback LLC domain, that can be preferred if the
current LLC is busy (last 2 patches).

Except the last 2 patches, the rest patches should work independently of the
other proposed solution. i.e if the mc-llc patch is accepted, then the last
two patches may not be needed for Power10. However this may be helpful for
other archs/platforms.

In the fallback approach, we look for a one-to-one mapping for each LLC.
However this can be easily modified to look for all LLC's in the current
LLC's parent. Also fallback is only used for sync wakeups. This is because
that is where we expect the maximum benefit of moving the task closer to the
task. For non-sync wakeups, its expected that CPU from previous LLC may be
better off.

Request you to please review and provide your feedback.

Benchmarking numbers are from Power 10 but I have verified that we don't
regress on Power 9 setup.

# lscpu
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              80
On-line CPU(s) list: 0-79
Thread(s) per core:  8
Core(s) per socket:  10
Socket(s):           1
NUMA node(s):        1
Model:               1.0 (pvr 0080 0100)
Model name:          POWER10 (architected), altivec supported
Hypervisor vendor:   pHyp
Virtualization type: para
L1d cache:           64K
L1i cache:           32K
L2 cache:            256K
L3 cache:            8K
NUMA node2 CPU(s):   0-79

Hackbench: (latency, lower is better)

v5.12-rc5
instances = 1, min = 24.102529 usecs/op, median =  usecs/op, max = 24.102529 usecs/op
instances = 2, min = 24.096112 usecs/op, median = 24.096112 usecs/op, max = 24.178903 usecs/op
instances = 4, min = 24.080541 usecs/op, median = 24.082990 usecs/op, max = 24.166873 usecs/op
instances = 8, min = 24.088969 usecs/op, median = 24.116081 usecs/op, max = 24.199853 usecs/op
instances = 16, min = 24.267228 usecs/op, median = 26.204510 usecs/op, max = 29.218360 usecs/op
instances = 32, min = 30.680071 usecs/op, median = 32.911664 usecs/op, max = 37.380470 usecs/op
instances = 64, min = 43.908331 usecs/op, median = 44.454343 usecs/op, max = 46.210298 usecs/op
instances = 80, min = 44.585754 usecs/op, median = 56.738546 usecs/op, max = 60.625826 usecs/op

v5.12-rc5 + mc-llc
instances = 1, min = 18.676505 usecs/op, median =  usecs/op, max = 18.676505 usecs/op
instances = 2, min = 18.488627 usecs/op, median = 18.488627 usecs/op, max = 18.574946 usecs/op
instances = 4, min = 18.428399 usecs/op, median = 18.589051 usecs/op, max = 18.872548 usecs/op
instances = 8, min = 18.597389 usecs/op, median = 18.783815 usecs/op, max = 19.265532 usecs/op
instances = 16, min = 21.922350 usecs/op, median = 22.737792 usecs/op, max = 24.832429 usecs/op
instances = 32, min = 29.770446 usecs/op, median = 31.996687 usecs/op, max = 34.053042 usecs/op
instances = 64, min = 53.067842 usecs/op, median = 53.295139 usecs/op, max = 53.473059 usecs/op
instances = 80, min = 44.423288 usecs/op, median = 44.713767 usecs/op, max = 45.159761 usecs/op

v5.12-rc5 + this patchset
instances = 1, min = 19.368805 usecs/op, median =  usecs/op, max = 19.368805 usecs/op
instances = 2, min = 19.423674 usecs/op, median = 19.423674 usecs/op, max = 19.506203 usecs/op
instances = 4, min = 19.454523 usecs/op, median = 19.596947 usecs/op, max = 19.863620 usecs/op
instances = 8, min = 20.005272 usecs/op, median = 20.239924 usecs/op, max = 20.878947 usecs/op
instances = 16, min = 21.856779 usecs/op, median = 24.102147 usecs/op, max = 25.496110 usecs/op
instances = 32, min = 31.460159 usecs/op, median = 32.809621 usecs/op, max = 33.939650 usecs/op
instances = 64, min = 39.506553 usecs/op, median = 43.835221 usecs/op, max = 45.645505 usecs/op
instances = 80, min = 43.805716 usecs/op, median = 44.314757 usecs/op, max = 48.910236 usecs/op

Summary:
mc-llc and this patchset seem to be performing much better than vanilla v5.12-rc5

DayTrader (throughput, higher is better)
		     v5.12-rc5   v5.12-rc5     v5.12-rc5
                                 + mc-llc      + patchset
64CPUs/1JVM/ 60Users  6373.7      7520.5        7232.3
64CPUs/1JVM/ 80Users  6742.1      7940.9        7732.8
64CPUs/1JVM/100Users  6482.2      7730.3        7540
64CPUs/2JVM/ 60Users  6335        8081.6        7914.3
64CPUs/2JVM/ 80Users  6360.8      8259.6        8138.6
64CPUs/2JVM/100Users  6215.6      8046.5        8039.2
64CPUs/4JVM/ 60Users  5385.4      7685.3        7706.1
64CPUs/4JVM/ 80Users  5380.8      7753.3        7721.5
64CPUs/4JVM/100Users  5275.2      7549.2        7608.3

Summary: Across all profiles, this patchset or mc-llc out perform
vanilla v5.12-rc5
Not: Only 64 cores were online during this test.

schbench (latency: lesser is better)
======== Running schbench -m 3 -r 30 =================
Latency percentiles (usec) runtime 10 (s) (2545 total samples)
v5.12-rc5                  |  v5.12-rc5 + mc-llc                 | v5.12-rc5 + patchset

50.0th: 56 (1301 samples)  |     50.0th: 49 (1309 samples)       | 50.0th: 50 (1310 samples)
75.0th: 76 (623 samples)   |     75.0th: 66 (628 samples)        | 75.0th: 68 (632 samples)
90.0th: 93 (371 samples)   |     90.0th: 78 (371 samples)        | 90.0th: 80 (354 samples)
95.0th: 107 (123 samples)  |     95.0th: 87 (117 samples)        | 95.0th: 86 (126 samples)
*99.0th: 12560 (102 samples)    *99.0th: 100 (97 samples)        | *99.0th: 103 (97 samples)
99.5th: 15312 (14 samples) |     99.5th: 104 (12 samples)        | 99.5th: 1202 (13 samples)
99.9th: 19936 (9 samples)  |     99.9th: 106 (8 samples)         | 99.9th: 14992 (10 samples)
min=13, max=20684          |     min=15, max=113                 | min=15, max=18721

Latency percentiles (usec) runtime 20 (s) (7649 total samples)

50.0th: 51 (3884 samples)  |     50.0th: 50 (3935 samples)       | 50.0th: 49 (3841 samples)
75.0th: 69 (1859 samples)  |     75.0th: 66 (1817 samples)       | 75.0th: 67 (1965 samples)
90.0th: 87 (1173 samples)  |     90.0th: 80 (1204 samples)       | 90.0th: 78 (1134 samples)
95.0th: 97 (368 samples)   |     95.0th: 87 (342 samples)        | 95.0th: 83 (359 samples)
*99.0th: 8624 (290 samples)|     *99.0th: 98 (294 samples)       | *99.0th: 93 (296 samples)
99.5th: 11344 (37 samples) |     99.5th: 102 (37 samples)        | 99.5th: 98 (34 samples)
99.9th: 18592 (31 samples) |     99.9th: 106 (30 samples)        | 99.9th: 7544 (28 samples)
min=13, max=20684          |     min=12, max=113                 | min=13, max=18721

Latency percentiles (usec) runtime 30 (s) (12785 total samples)

50.0th: 50 (6614 samples)  |     50.0th: 49 (6544 samples)       | 50.0th: 48 (6527 samples)
75.0th: 67 (3059 samples)  |     75.0th: 65 (3100 samples)       | 75.0th: 64 (3143 samples)
90.0th: 84 (1894 samples)  |     90.0th: 79 (1912 samples)       | 90.0th: 76 (1985 samples)
95.0th: 94 (586 samples)   |     95.0th: 87 (646 samples)        | 95.0th: 81 (585 samples)
*99.0th: 8304 (507 samples)|     *99.0th: 101 (496 samples)      | *99.0th: 90 (453 samples)
99.5th: 11696 (62 samples) |     99.5th: 104 (45 samples)        | 99.5th: 94 (66 samples)
99.9th: 18592 (51 samples) |     99.9th: 110 (51 samples)        | 99.9th: 1202 (49 samples)
min=12, max=21421          |     min=1, max=126                  | min=3, max=18721

Summary:
mc-llc is the best option, but this patchset also helps compared to vanilla v5.12-rc5


mongodb (threads=6) (throughput, higher is better)
					 Throughput         read        clean      update
					                    latency     latency    latency
v5.12-rc5            JVM=YCSB_CLIENTS=14  68116.05 ops/sec   1109.82 us  944.19 us  1342.29 us
v5.12-rc5            JVM=YCSB_CLIENTS=21  64802.69 ops/sec   1772.64 us  944.69 us  2099.57 us
v5.12-rc5            JVM=YCSB_CLIENTS=28  61792.78 ops/sec   2490.48 us  930.09 us  2928.03 us
v5.12-rc5            JVM=YCSB_CLIENTS=35  59604.44 ops/sec   3236.86 us  870.28 us  3787.48 us

v5.12-rc5 + mc-llc   JVM=YCSB_CLIENTS=14  70948.51 ops/sec   1060.21 us  842.02 us  1289.44 us
v5.12-rc5 + mc-llc   JVM=YCSB_CLIENTS=21  68732.48 ops/sec   1669.91 us  871.57 us  1975.19 us
v5.12-rc5 + mc-llc   JVM=YCSB_CLIENTS=28  66674.81 ops/sec   2313.79 us  889.59 us  2702.36 us
v5.12-rc5 + mc-llc   JVM=YCSB_CLIENTS=35  64397.51 ops/sec   3010.66 us  966.28 us  3484.19 us

v5.12-rc5 + patchset JVM=YCSB_CLIENTS=14  67403.29 ops/sec   1121.80 us  797.81 us  1357.28 us
v5.12-rc5 + patchset JVM=YCSB_CLIENTS=21  63952.79 ops/sec   1792.86 us  779.59 us  2130.54 us
v5.12-rc5 + patchset JVM=YCSB_CLIENTS=28  62198.83 ops/sec   2469.60 us  780.00 us  2914.48 us
v5.12-rc5 + patchset JVM=YCSB_CLIENTS=35  60333.81 ops/sec   3192.41 us  822.09 us  3748.24 us

Summary:
mc-llc outperforms, this patchset and upstream almost give similar performance.


Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Parth Shah <parth@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Rik van Riel <riel@surriel.com>

Srikar Dronamraju (10):
  sched/fair: Update affine statistics when needed
  sched/fair: Maintain the identity of idle-core
  sched/fair: Update idle-core more often
  sched/fair: Prefer idle CPU to cache affinity
  sched/fair: Call wake_affine only if necessary
  sched/idle: Move busy_cpu accounting to idle callback
  sched/fair: Remove ifdefs in waker_affine_idler_llc
  sched/fair: Dont iterate if no idle CPUs
  sched/topology: Introduce fallback LLC
  powerpc/smp: Add fallback flag to powerpc MC domain

 arch/powerpc/kernel/smp.c      |   7 +-
 include/linux/sched/sd_flags.h |   7 +
 include/linux/sched/topology.h |   3 +-
 kernel/sched/fair.c            | 229 +++++++++++++++++++++++++++------
 kernel/sched/features.h        |   1 +
 kernel/sched/idle.c            |  33 ++++-
 kernel/sched/sched.h           |   6 +
 kernel/sched/topology.c        |  54 +++++++-
 8 files changed, 296 insertions(+), 44 deletions(-)

-- 
2.18.2

