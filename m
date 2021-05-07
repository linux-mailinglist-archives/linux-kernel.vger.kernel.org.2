Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64D376642
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhEGNiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:38:00 -0400
Received: from foss.arm.com ([217.140.110.172]:59490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235759AbhEGNh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:37:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 832D7106F;
        Fri,  7 May 2021 06:36:58 -0700 (PDT)
Received: from [192.168.1.16] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4354F3F718;
        Fri,  7 May 2021 06:36:56 -0700 (PDT)
Subject: Re: [PATCH v2] sched/pelt: Keep UTIL_AVG_UNCHANGED flag in sync when
 calculating last_enqueued_diff
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        xuewyan@foxmail.com
References: <20210507112031.23073-1-xuewen.yan94@gmail.com>
 <20210507123528.GA106818@e120877-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <da0fe50a-f419-e6a1-d67f-76fbe5cbf520@arm.com>
Date:   Fri, 7 May 2021 15:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210507123528.GA106818@e120877-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2021 14:35, Vincent Donnefort wrote:
> On Fri, May 07, 2021 at 07:20:31PM +0800, Xuewen Yan wrote:
>> From: Xuewen Yan <xuewen.yan@unisoc.com>
>>
>> Last_enqueued_diff's meaning: "diff = util_est.enqueued(p) - task_util(p)".
>> When calculating last_enqueued_diff, we add UTIL_AVG_UNCHANGED flag, which
>> is the LSB, for task_util, but don't add the flag for util_est.enqueued.
>> However the enqueued's flag had been cleared when the task util changed.
>> As a result, we add +1 to the diff, this is therefore reducing slightly
>> UTIL_EST_MARGIN.
> 
> Unless I miss something it actually depends on the situation, doesn't it?
> 
> if ue.enqueued > task_util(), we remove 1 from the diff => UTIL_EST_MARGIN + 1
> 
> if ue.enqueued < task_util(), we add 1 to the diff => UTIL_EST_MARGIN -1

I get:

ue.enqueued & UTIL_AVG_UNCHANGED = 0

last_enqueued_diff = ue.enqueued_old                    -  ue.enqueued_new

last_enqueued_diff = (ue.enqueued | UTIL_AVG_UNCHANGED) - (task_util(p) | UTIL_AVG_UNCHANGED)

                                   ^^^^^^^^^^^^^^^^^^^^
                                   added by patch


ue.enqueued_old didn't have the flag, otherwise would return earlier

task_util(p) could have the LSB set but we just set it to make sure it's set

So last_enqueued_diff is 1 larger.

But UTIL_EST_MARGIN stays `SCHED_CAPACITY_SCALE / 100` ?

Did I miss something here?

>>
>> Add the flag for util_est.enqueued to have a accurate computation.
>>
>> Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
>>
>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>> ---
>>  kernel/sched/fair.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e5e457fa9dc8..94d77b4fa601 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3996,7 +3996,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>>  	if (ue.enqueued & UTIL_AVG_UNCHANGED)
>>  		return;
>>  
>> -	last_enqueued_diff = ue.enqueued;
>> +	last_enqueued_diff = (ue.enqueued | UTIL_AVG_UNCHANGED);
>>  
>>  	/*
>>  	 * Reset EWMA on utilization increases, the moving average is used only
>> -- 
>> 2.29.0
>>

