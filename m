Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC51391AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhEZPA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:00:56 -0400
Received: from foss.arm.com ([217.140.110.172]:46188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233472AbhEZPAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:00:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 957A21516;
        Wed, 26 May 2021 07:59:22 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963363F73D;
        Wed, 26 May 2021 07:59:20 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
References: <20210514103748.737809-1-dietmar.eggemann@arm.com>
 <20210519160633.GA230499@e120877-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cb72557a-6039-df95-7e25-a7f37d3f9cef@arm.com>
Date:   Wed, 26 May 2021 16:59:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519160633.GA230499@e120877-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2021 18:06, Vincent Donnefort wrote:
> On Fri, May 14, 2021 at 12:37:48PM +0200, Dietmar Eggemann wrote:
>> The util_est internal UTIL_AVG_UNCHANGED flag which is used to prevent
>> unnecessary util_est updates uses the LSB of util_est.enqueued. It is
>> exposed via _task_util_est() (and task_util_est()).
>>
>> Commit 92a801e5d5b7 ("sched/fair: Mask UTIL_AVG_UNCHANGED usages")
>> mentions that the LSB is lost for util_est resolution but
>> find_energy_efficient_cpu() checks if task_util_est() returns 0 to
>> return prev_cpu early.
>>
>> _task_util_est() returns the max value of util_est.ewma and
>> util_est.enqueued or'ed w/ UTIL_AVG_UNCHANGED.
>> So task_util_est() returning the max of task_util() and
>> _task_util_est() will never return 0 under the default
>> SCHED_FEAT(UTIL_EST, true).
>>
>> To fix this use the MSB of util_est.enqueued instead and keep the flag
>> util_est internal, i.e. don't export it via _task_util_est().
>>
>> The maximal possible util_avg value for a task is 1024 so the MSB of
>> 'unsigned int util_est.enqueued' isn't used to store a util value.
>>
>> As a caveat the code behind the util_est_se trace point has to filter
>> UTIL_AVG_UNCHANGED to see the real util_est.enqueued value which should
>> be easy to do.
>>
>> This also fixes an issue report by Xuewen Yan that util_est_update()
>> only used UTIL_AVG_UNCHANGED for the subtrahend of the equation:
>>
>>   last_enqueued_diff = ue.enqueued - (task_util() | UTIL_AVG_UNCHANGED)
>>
>> Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> I don't believe this made it through our integration branch testing, so I gave a
> try manually on my Hikey with LISA's UtilConvergence test. 20 iterations of that
> test passed without any problem.
> 
>> ---
>>  kernel/sched/fair.c |  5 +++--
>>  kernel/sched/pelt.h | 13 +++++++------
>>  2 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 161b92aa1c79..0150d440b0a2 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3856,7 +3856,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
>>  {
>>  	struct util_est ue = READ_ONCE(p->se.avg.util_est);
>>  
>> -	return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
>> +	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
>>  }
> 
> 
> Shall we also update proc_sched_show_task() to avoid reading this flag there?

Ah yes, forgot about this one! Thanks for the review.

This can be fixed by fixed by moving UTIL_AVG_UNCHANGED from
kernel/sched/pelt.h into include/linux/sched.h (next to the already
existing util_est stuff there) and using it in proc_sched_show_task()
for se.avg.util_est.enqueued.

What do you think?

--8<--
Subject: [PATCH] Fix proc_sched_show_task()

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched.h | 10 ++++++++++
 kernel/sched/debug.c  |  3 ++-
 kernel/sched/pelt.h   | 10 ----------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c7e7d50e2fdc..0a0bca694536 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -357,6 +357,16 @@ struct util_est {
 #define UTIL_EST_WEIGHT_SHIFT		2
 } __attribute__((__aligned__(sizeof(u64))));
 
+/*
+ * This flag is used to synchronize util_est with util_avg updates.
+ * When a task is dequeued, its util_est should not be updated if its util_avg
+ * has not been updated in the meantime.
+ * This information is mapped into the MSB bit of util_est.enqueued at dequeue
+ * time. Since max value of util_est.enqueued for a task is 1024 (PELT util_avg
+ * for a task) it is safe to use MSB.
+ */
+#define UTIL_AVG_UNCHANGED 0x80000000
+
 /*
  * The load/runnable/util_avg accumulates an infinite geometric series
  * (see __update_load_avg_cfs_rq() in kernel/sched/pelt.c).
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3bdee5fd7d29..0c5ec2776ddf 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -885,6 +885,7 @@ static const struct seq_operations sched_debug_sops = {
 #define __PS(S, F) SEQ_printf(m, "%-45s:%21Ld\n", S, (long long)(F))
 #define __P(F) __PS(#F, F)
 #define   P(F) __PS(#F, p->F)
+#define   PM(F, M) __PS(#F, p->F & (M))
 #define __PSN(S, F) SEQ_printf(m, "%-45s:%14Ld.%06ld\n", S, SPLIT_NS((long long)(F)))
 #define __PN(F) __PSN(#F, F)
 #define   PN(F) __PSN(#F, p->F)
@@ -1011,7 +1012,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
-	P(se.avg.util_est.enqueued);
+	PM(se.avg.util_est.enqueued, ~UTIL_AVG_UNCHANGED);
 #endif
 #ifdef CONFIG_UCLAMP_TASK
 	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 178290a8d150..e06071bf3472 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -42,16 +42,6 @@ static inline u32 get_pelt_divider(struct sched_avg *avg)
 	return LOAD_AVG_MAX - 1024 + avg->period_contrib;
 }
 
-/*
- * When a task is dequeued, its estimated utilization should not be updated if
- * its util_avg has not been updated in the meantime.
- * This flag is used to synchronize util_avg updates with util_est updates.
- * We map this information into the MSB bit of util_est.enqueued at dequeue
- * time. Since max value of util_est.enqueued for a task is 1024 (PELT
- * util_avg for a task) it is safe to use MSB here.
- */
-#define UTIL_AVG_UNCHANGED 0x80000000
-
 static inline void cfs_se_util_change(struct sched_avg *avg)
 {
 	unsigned int enqueued;
-- 
2.25.1
