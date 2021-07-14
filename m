Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED213C85EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbhGNOV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:21:26 -0400
Received: from foss.arm.com ([217.140.110.172]:35498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhGNOV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:21:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3572D31B;
        Wed, 14 Jul 2021 07:18:34 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CBF33F694;
        Wed, 14 Jul 2021 07:18:32 -0700 (PDT)
Subject: Re: [RFC PATCH 1/1] sched: do active load balance in balance callback
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <CALOAHbAS26LP2p9Fe7m6xynZmazYENmx_HfTV4LebwPWr7XLmA@mail.gmail.com>
 <87tukxm66r.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <5d9bfd3b-1b14-e741-de3b-9c9b30663b9d@arm.com>
Date:   Wed, 14 Jul 2021 16:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87tukxm66r.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2021 14:27, Valentin Schneider wrote:
> On 11/07/21 15:40, Yafang Shao wrote:
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 4ca80df205ce..a0a90a37e746 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -8208,6 +8208,7 @@ void __init sched_init(void)
>>                 rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
>>                 rq->balance_callback = &balance_push_callback;
>>                 rq->active_balance = 0;
>> +               rq->active_balance_target = NULL;
>>                 rq->next_balance = jiffies;
>>                 rq->push_cpu = 0;
>>                 rq->cpu = i;
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 23663318fb81..9aaa75250cdc 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7751,36 +7751,6 @@ static void detach_task(struct task_struct *p,
>> struct lb_env *env)
> 
> Your mail client is breaking lines which pretty much wrecks the
> patch. Please use git send-email to submit patches, or look at
> Documentation/process/email-clients.rst to figure out how to tweak your
> client. 

Yeah, wasn't able to apply this patch either.





