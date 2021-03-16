Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9977033D89C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbhCPQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:04:12 -0400
Received: from m42-2.mailgun.net ([69.72.42.2]:10889 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238407AbhCPQDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:03:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615910620; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=jh7HFSQnFs4ajf8ZV8AYNVqo9DcUQaYuT9VGc9cRwRo=; b=MbxbV+gwY/Sv2hoRIFu9soDooAjpnd94zhPbtDsyHqaO/87jeMq8m5KQq4syun4S1f3KQvvH
 NS6nhPWhTSqwhTeys9lzw9AWM8imMyh8aV9g3WIIElAOY9qAHBdtiY3qyGIfCe1G6/pwrtcx
 MaHaBLlRvGK0jwfIaKqJTHRU61A=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6050d6da1de5dd7b99fd01bb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Mar 2021 16:03:38
 GMT
Sender: clingutla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 30392C43465; Tue, 16 Mar 2021 16:03:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.43.40] (unknown [223.185.115.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clingutla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 508B8C433CA;
        Tue, 16 Mar 2021 16:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 508B8C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=clingutla@codeaurora.org
Subject: Re: [PATCH v3 1/7] sched/fair: Ignore percpu threads for imbalance
 pulls
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com>
 <20210311120527.167870-2-valentin.schneider@arm.com>
 <bdea6c4f-262b-c3cb-637e-d4896e688dd3@arm.com>
From:   Chandra Sekhar Lingutla <clingutla@codeaurora.org>
Message-ID: <e113aa70-c26b-c43f-a113-5a3b66793e46@codeaurora.org>
Date:   Tue, 16 Mar 2021 21:33:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bdea6c4f-262b-c3cb-637e-d4896e688dd3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On 3/16/2021 9:19 PM, Dietmar Eggemann wrote:
> On 11/03/2021 13:05, Valentin Schneider wrote:
>> From: Lingutla Chandrasekhar <clingutla@codeaurora.org>
>>
>> In load balancing, when balancing group is unable to pull task
>> due to ->cpus_ptr constraints from busy group, then it sets
>> LBF_SOME_PINNED to lb env flags, as a consequence, sgc->imbalance
>> is set for its parent domain level. which makes the group
>> classified as imbalance to get help from another balancing cpu.
>>
>> Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and
> Does it have to be a big.LITTLE system? I assume this issue also happens
> on an SMP system.

Yah, issue can happen on SMP system as well.  I will let Valentin update 
the commit text on
his next version of this series.

>> CPUs 2-3 as Bigs with below scenario:
>> - CPU0 doing newly_idle balancing
>> - CPU1 running percpu kworker and RT task (small tasks)
> What's the role of the small RT task here in the story?
This is to satisfy 'busiest->nr_running > 1' checks.
>> - CPU2 running 2 big tasks
>> - CPU3 running 1 medium task
>>
>> While CPU0 is doing newly_idle load balance at MC level, it fails to
>> pull percpu kworker from CPU1 and sets LBF_SOME_PINNED to lb env flag
>> and set sgc->imbalance at DIE level domain. As LBF_ALL_PINNED not cleared,
>> it tries to redo the balancing by clearing CPU1 in env cpus, but it don't
>> find other busiest_group, so CPU0 stops balacing at MC level without
>> clearing 'sgc->imbalance' and restart the load balacing at DIE level.
>>
>> And CPU0 (balancing cpu) finds LITTLE's group as busiest_group with group
>> type as imbalance, and Bigs that classified the level below imbalance type
>> would be ignored to pick as busiest, and the balancing would be aborted
>> without pulling any tasks (by the time, CPU1 might not have running tasks).
>>
>> It is suboptimal decision to classify the group as imbalance due to
>> percpu threads. So don't use LBF_SOME_PINNED for per cpu threads.
> This sentence mentioned per-cpu threads (and so does the patch name) but
> the implementation (only) deals with per-cpu kernel threads. IMHO, it
> would be good to align this.
I will let Valentin update this on next version.
>> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
>> [Use kthread_is_per_cpu() rather than p->nr_cpus_allowed]
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>   kernel/sched/fair.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2e2ab1e00ef9..83aea97fbf22 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7565,6 +7565,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>   	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>>   		return 0;
>>   
>> +	/* Disregard pcpu kthreads; they are where they need to be. */
>> +	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
>> +		return 0;
>> +
>>   	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>>   		int cpu;
>>   
>>
