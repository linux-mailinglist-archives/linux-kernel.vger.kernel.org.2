Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391C93768ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbhEGQkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:40:33 -0400
Received: from foss.arm.com ([217.140.110.172]:35852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238317AbhEGQkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:40:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EF8611FB;
        Fri,  7 May 2021 09:39:31 -0700 (PDT)
Received: from [192.168.1.16] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A01FC3F73B;
        Fri,  7 May 2021 09:39:28 -0700 (PDT)
Subject: Re: [PATCH v2] sched/pelt: Keep UTIL_AVG_UNCHANGED flag in sync when
 calculating last_enqueued_diff
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        xuewyan@foxmail.com
References: <20210507112031.23073-1-xuewen.yan94@gmail.com>
 <20210507123528.GA106818@e120877-lin.cambridge.arm.com>
 <da0fe50a-f419-e6a1-d67f-76fbe5cbf520@arm.com>
 <20210507153827.GA176408@e120877-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c265d9ab-f06f-692f-df43-464bf4f2ea68@arm.com>
Date:   Fri, 7 May 2021 18:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210507153827.GA176408@e120877-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2021 17:38, Vincent Donnefort wrote:
> On Fri, May 07, 2021 at 03:36:47PM +0200, Dietmar Eggemann wrote:
>> On 07/05/2021 14:35, Vincent Donnefort wrote:
>>> On Fri, May 07, 2021 at 07:20:31PM +0800, Xuewen Yan wrote:
>>>> From: Xuewen Yan <xuewen.yan@unisoc.com>
>>>>
>>>> Last_enqueued_diff's meaning: "diff = util_est.enqueued(p) - task_util(p)".
>>>> When calculating last_enqueued_diff, we add UTIL_AVG_UNCHANGED flag, which
>>>> is the LSB, for task_util, but don't add the flag for util_est.enqueued.
>>>> However the enqueued's flag had been cleared when the task util changed.
>>>> As a result, we add +1 to the diff, this is therefore reducing slightly
>>>> UTIL_EST_MARGIN.
>>>
>>> Unless I miss something it actually depends on the situation, doesn't it?
>>>
>>> if ue.enqueued > task_util(), we remove 1 from the diff => UTIL_EST_MARGIN + 1
>>>
>>> if ue.enqueued < task_util(), we add 1 to the diff => UTIL_EST_MARGIN -1
>>
>> I get:
>>
>> ue.enqueued & UTIL_AVG_UNCHANGED = 0
>>
>> last_enqueued_diff = ue.enqueued_old                    -  ue.enqueued_new
>>
>> last_enqueued_diff = (ue.enqueued | UTIL_AVG_UNCHANGED) - (task_util(p) | UTIL_AVG_UNCHANGED)
>>
>>                                    ^^^^^^^^^^^^^^^^^^^^
>>                                    added by patch
>>
>>
>> ue.enqueued_old didn't have the flag, otherwise would return earlier
>>
>> task_util(p) could have the LSB set but we just set it to make sure it's set
>>
>> So last_enqueued_diff is 1 larger.
> 
> But we take the abs() of last_enqueued_diff.
> 
> If we consider the following examples:
> 
>    enqueued_old = 5, enqueued_new = 9
>    diff = 5 - (9 + 1) => 5 - 10 => -5
> 
>    enqueued_old = 9, enqueued_new = 5
>    diff = 9 - (5 + 1) => 9 - 6 => 3
> 
> In both cases the delta is supposed to be 4. But in the first case we end-up
> with 5. In the second, we end-up with 3. That's why I meant the effect on the
> diff depends on who's greater, ue.enqueued or task_util().

Ah, OK, due to the abs() in within_margin(). But util's LSB is lost due
to the flag anyway. Hence I assume e.g. enqueued_new = 9 should be
(task_util() = 8) + 1 (| flag) in the example.

OTHA, implementing UTIL_AVG_UNCHANGED as LSB and making this visible on
the util_est 'API' has other issues too. The condition
`!task_util_est(p)` can never be true in find_energy_efficient_cpu()
because of UTIL_AVG_UNCHANGED.

So why not use `UTIL_AVG_UNCHANGED = 0x80000000` and just keep its use
internal (between cfs_se_util_change() and util_est_update()), i.e. not
exporting it (via _task_util_est()) and not eclipsing util_est's LSB
value?

--->8---

From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Fri, 5 Feb 2021 14:48:42 +0100
Subject: [PATCH] sched/fair: Fix util_est UTIL_AVG_UNCHANGED behaviour

The util_est internal UTIL_AVG_UNCHANGED flag which is used to prevent
unnecessary util_est updates uses the LSB of util_est.enqueued. It is
exposed via _task_util_est() (and task_util_est()).

Commit 92a801e5d5b7 ("sched/fair: Mask UTIL_AVG_UNCHANGED usages")
mentions that the LSB is lost for util_est resolution but
find_energy_efficient_cpu() checks if task_util_est() returns 0 to
return prev_cpu early.

Because of _task_util_est() returning the actual util est value or'ed w/
UTIL_AVG_UNCHANGED for a dequeued task this can never be true w/
SCHED_FEAT(UTIL_EST, true).

To fix this use the MSB of util_est.enqueued instead and keep the flag
util_est internal, i.e. don't export it via _task_util_est().

MSB of unsigned int util_est.enqueued shouldn't be used for a task
since the maximal possible util_avg value for a task is 1024.

As a caveat the code behind the util_est_se trace point has to filter
UTIL_AVG_UNCHANGED to see the real util_est.enqueued value which should
be easy to do.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c |  5 +++--
 kernel/sched/pelt.h | 11 ++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d75af1ecfb4..dd30e362c3cc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3902,7 +3902,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
 {
 	struct util_est ue = READ_ONCE(p->se.avg.util_est);
 
-	return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
+	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
 }
 
 static inline unsigned long task_util_est(struct task_struct *p)
@@ -4002,7 +4002,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * Reset EWMA on utilization increases, the moving average is used only
 	 * to smooth utilization decreases.
 	 */
-	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
+	ue.enqueued = task_util(p);
 	if (sched_feat(UTIL_EST_FASTUP)) {
 		if (ue.ewma < ue.enqueued) {
 			ue.ewma = ue.enqueued;
@@ -4051,6 +4051,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	ue.ewma  += last_ewma_diff;
 	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
+	ue.enqueued |= UTIL_AVG_UNCHANGED;
 	WRITE_ONCE(p->se.avg.util_est, ue);
 
 	trace_sched_util_est_se_tp(&p->se);
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 1462846d244e..476faf61f14a 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -43,13 +43,14 @@ static inline u32 get_pelt_divider(struct sched_avg *avg)
 }
 
 /*
- * When a task is dequeued, its estimated utilization should not be update if
- * its util_avg has not been updated at least once.
+ * When a task is dequeued, its estimated utilization should not be updated if
+ * its util_avg has not been updated in the meantime.
  * This flag is used to synchronize util_avg updates with util_est updates.
- * We map this information into the LSB bit of the utilization saved at
- * dequeue time (i.e. util_est.dequeued).
+ * We map this information into the MSB bit of util_est.enqueued at dequeue
+ * time. Since max value of util_est.enqueued for a task is 1024 (PELT
+ * util_avg for a task) it is safe to use MSB here.
  */
-#define UTIL_AVG_UNCHANGED 0x1
+#define UTIL_AVG_UNCHANGED 0x80000000
 
 static inline void cfs_se_util_change(struct sched_avg *avg)
 {
-- 
2.25.1

















































