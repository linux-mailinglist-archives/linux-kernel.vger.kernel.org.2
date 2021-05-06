Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC5B3758C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbhEFQyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:54:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50518 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236006AbhEFQyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:54:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146GXPSq118938;
        Thu, 6 May 2021 12:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=oN4YcI/MwrKGj+l8/8ycPGzT2RPoCHQsr1hy2vj/MyE=;
 b=UcCZWS+kLYT2twT3YtdrVDCqRZ4L4WHxPFhPErTGsPY59X6EUMdYw+HsUftPyAv+OrTx
 tc2nKlBkNTokXz1r3kxiWDIq/vIhn4Gp3Vz6ZobcWJtTLYqDZz0pnSufnV8+bzLxxeJX
 juQKvCiBUbhr6WmRuOsoK4NI5/l2aJD7fFKzdZx8+M12LFV6w2qw4Q8maJsr9sDM9LvE
 O3qQKkGZR8aWJpZYveyOxcpzrB6D1uI1w1tVqhV+1lPU5dtvub89eL71TWidgcq8OHIY
 mzebiaCQXC87R4Os7P55g5yNQ6zogoqOo/v8sf+ZImbz7Wt1bIX8p1Y1b7tnC/0KsVU3 3w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38cgf3rn7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 12:53:35 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 146GrXJH005178;
        Thu, 6 May 2021 16:53:33 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 38cfrqr869-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 16:53:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 146Gr5o037683668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 16:53:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06C285204F;
        Thu,  6 May 2021 16:53:31 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id ADBD05204E;
        Thu,  6 May 2021 16:53:28 +0000 (GMT)
Date:   Thu, 6 May 2021 22:23:28 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH v2 0/8] sched/fair: wake_affine improvements
Message-ID: <20210506165328.GO2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T7fKUvBjZftDErS9e1fkJ1hKxabdsll1
X-Proofpoint-ORIG-GUID: T7fKUvBjZftDErS9e1fkJ1hKxabdsll1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2021-05-06 22:15:35]:

Mel had asked for additional profile data that could be collected 
for idlecore

# lscpu
Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   46 bits physical, 48 bits virtual
CPU(s):                          48
On-line CPU(s) list:             0-47
Thread(s) per core:              2
Core(s) per socket:              12
Socket(s):                       2
NUMA node(s):                    2
Vendor ID:                       GenuineIntel
CPU family:                      6
Model:                           63
Model name:                      Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz
Stepping:                        2
CPU MHz:                         1200.000
CPU max MHz:                     3500.0000
CPU min MHz:                     1200.0000
BogoMIPS:                        5200.05
Virtualization:                  VT-x
L1d cache:                       768 KiB
L1i cache:                       768 KiB
L2 cache:                        6 MiB
L3 cache:                        60 MiB
NUMA node0 CPU(s):               0-11,24-35
NUMA node1 CPU(s):               12-23,36-47

# cat test.sh
#! /bin/bash
tbench_srv &

#20 iterations of tbench on 48 CPU, 2 node syste
for i in $(seq 1 20); do
	#enable schedstat just before tbench
	echo 1 | sudo tee /proc/sys/kernel/sched_schedstats
	tbench -t 60 48 127.0.0.1
	#disable schedstat just before tbench
	echo 0 | sudo tee /proc/sys/kernel/sched_schedstats
	IDLE_COUNT=$(awk '/nr_idlecore_write/{a+=$NF}END{print a}' /proc/sched_debug)
	NR_IDLE_COUNT=$(($IDLE_COUNT-$NR_IDLE_COUNT))
	SELECT_COUNT=$(awk '/nr_idlecore_select/{a+=$NF}END{print a}' /proc/sched_debug)
	NR_SELECT_COUNT=$(($SELECT_COUNT-$NR_SELECT_COUNT))
	# select means we selected an idle core when the preferred CPU is
	# busy. write means, unconditional set of idlecore.
	# seqno total_updates=select+write select write
	echo $i $(($NR_IDLE_COUNT+$NR_SELECT_COUNT)) $NR_SELECT_COUNT $NR_IDLE_COUNT
done
#

a5e13c6df0e4 aka v5.12-rc5
seqno  nr_update_idle_core  nr_select_idle_core  nr_write_idle_core
1      11515                0                    11515
2      13439                0                    13439
3      42339                0                    42339
4      13642                0                    13642
5      44770                0                    44770
6      32402                0                    32402
7      65638                0                    65638
8      106601               0                    106601
9      99819                0                    99819
10     106754               0                    106754
11     107899               0                    107899
12     112432               0                    112432
13     125329               0                    125329
14     127363               0                    127363
15     133821               0                    133821
16     127495               0                    127495
17     133957               0                    133957
18     185021               0                    185021
19     137139               0                    137139
20     221413               0                    221413

 N           Min           Max        Median           Avg        Stddev
20         11515        221413        107899       97439.4     57524.696

Average of 1353 updates per second.


635bb392f382 aka v5.12-rc5 + patches
seqno  nr_update_idle_core  nr_select_idle_core  nr_write_idle_core
1      2112856              218                  2112638
2      1727892              84                   1727808
3      3662807              280                  3662527
4      3623563              220                  3623343
5      4972825              308                  4972517
6      3625828              258                  3625570
7      6703820              407                  6703413
8      5565289              390                  5564899
9      8376039              528                  8375511
10     6643273              405                  6642868
11     10041803             605                  10041198
12     8322148              537                  8321611
13     11941494             729                  11940765
14     10125633             704                  10124929
15     12810965             797                  12810168
16     12269912             857                  12269055
17     14798232             912                  14797320
18     14378202             980                  14377222
19     15705273             935                  15704338
20     16407305             1122                 16406183

 N           Min           Max        Median           Avg        Stddev
20       1727892      16407305       8376039     8690757.9     4718172.5

Average of 120704 updates per second which is around 89X times without the
patch.

-- 
Thanks and Regards
Srikar Dronamraju

---->8----------------------------------------------------8<--------------

From e361fdd4234ff718247f0ee20f4f836ccbbc1df8 Mon Sep 17 00:00:00 2001
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date: Thu, 6 May 2021 19:33:51 +0530
Subject: sched: Show idlecore update stats

Not for inclusion; Just for demonstration.

nr_idlecore_write: idlecore set unconditionally.
nr_idlecore_select; wakeup found an idle core when the current CPU was
busy.

nr_idlecore updates = nr_idlecore_write + nr_idlecore_select

Not-Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/debug.c |  2 ++
 kernel/sched/fair.c  | 12 +++++++++---
 kernel/sched/sched.h |  2 ++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 486f403a778b..b50e0c5acf46 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -715,6 +715,8 @@ do {									\
 		P(ttwu_count);
 		P(ttwu_local);
 	}
+	P(nr_idlecore_write);
+	P(nr_idlecore_select);
 #undef P
 
 	spin_lock_irqsave(&sched_debug_lock, flags);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83104d3bd0f9..4ef0b7d959d5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5890,16 +5890,20 @@ static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cp
 
 	idle_core = READ_ONCE(pref_sds->idle_core);
 	if (idle_core > -1 && cpumask_test_cpu(idle_core, p->cpus_ptr) &&
-				test_reset_idle_core(pref_sds, idle_core))
+				test_reset_idle_core(pref_sds, idle_core)) {
+		schedstat_inc(cpu_rq(idle_core)->nr_idlecore_select);
 		return idle_core;
+	}
 
 	if (available_idle_cpu(try_cpu) || sched_idle_cpu(try_cpu))
 		return try_cpu;
 
 	idle_core = READ_ONCE(try_sds->idle_core);
 	if (idle_core > -1 && cpumask_test_cpu(idle_core, p->cpus_ptr) &&
-				test_reset_idle_core(try_sds, idle_core))
+				test_reset_idle_core(try_sds, idle_core)) {
+		schedstat_inc(cpu_rq(idle_core)->nr_idlecore_select);
 		return idle_core;
+	}
 
 	pnr_busy = atomic_read(&pref_sds->nr_busy_cpus);
 	tnr_busy = atomic_read(&try_sds->nr_busy_cpus);
@@ -6082,8 +6086,10 @@ static inline void set_idle_core(int cpu, int val)
 	struct sched_domain_shared *sds;
 
 	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
+	if (sds) {
 		WRITE_ONCE(sds->idle_core, val);
+		schedstat_inc(cpu_rq(cpu)->nr_idlecore_write);
+	}
 }
 
 static inline int get_idle_core(int cpu, int def)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index baf8d9a4cb26..06d81a9e0a48 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1060,6 +1060,8 @@ struct rq {
 #ifdef CONFIG_SMP
 	unsigned int		nr_pinned;
 #endif
+	unsigned int		nr_idlecore_write;
+	unsigned int		nr_idlecore_select;
 	unsigned int		push_busy;
 	struct cpu_stop_work	push_work;
 };
-- 
2.25.1
