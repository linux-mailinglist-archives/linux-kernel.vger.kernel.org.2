Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C3D3924A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 03:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhE0B7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 21:59:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5564 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhE0B7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 21:59:17 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fr9qb2HP8zjX8s;
        Thu, 27 May 2021 09:54:51 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 09:57:43 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 27 May
 2021 09:57:41 +0800
Subject: Re: [PATCH 1/1] sched/topology: Fix a spelling mistake in error
 message
To:     Ingo Molnar <mingo@kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210526021856.9060-1-thunder.leizhen@huawei.com>
 <42d36255-c1a6-956a-b56b-0c09eee125ec@infradead.org>
 <5571d34f-1965-8d8e-3033-6352dd0dcaee@huawei.com>
 <YK3wOkX6I78j73zD@gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ee11a1b4-04b5-8768-f26b-cf5310b77b3c@huawei.com>
Date:   Thu, 27 May 2021 09:57:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YK3wOkX6I78j73zD@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/26 14:52, Ingo Molnar wrote:
> 
> * Leizhen (ThunderTown) <thunder.leizhen@huawei.com> wrote:
> 
>>
>>
>> On 2021/5/26 10:32, Randy Dunlap wrote:
>>> On 5/25/21 7:18 PM, Zhen Lei wrote:
>>>> The misspelled word 'borken' should be 'broken'.
>>>>
>>>> Fixes: 6ae72dff3759 ("sched: Robustify topology setup")
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  kernel/sched/topology.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>> index 55a0a243e871..80295e224442 100644
>>>> --- a/kernel/sched/topology.c
>>>> +++ b/kernel/sched/topology.c
>>>> @@ -1937,7 +1937,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>>>>  
>>>>  		if (!cpumask_subset(sched_domain_span(child),
>>>>  				    sched_domain_span(sd))) {
>>>> -			pr_err("BUG: arch topology borken\n");
>>>> +			pr_err("BUG: arch topology broken\n");
>>>
>>> Would "borked" or "b0rken" be clearer?
>>
>> These two words don't seem to exist at all. Linux is an open-source
>> code for the world, so it's better to use a more common word.
> 
> What?
> 
> Please google:
> 
>     "borken" meaning

Hi, Ingo and Randy:
  I apologize to you both. In fact, I googled 'borken' before posting this patch.
But the result is: Borken is a German town. But I really didn't Google "borked"
and "b0rken", I just looked it up with an English dictionary software, but it
doesn't exist.
  As Randy's advice, it would be better to use "borked". At least it doesn't feel
like the 'r' and 'o' in "broken" are written in reverse order. There is no semantic
error in using "broken" in this sentence.

> 
> Please stop these pointless patches.

He who does not know is not guilty.

> 
> Thanks,
> 
> 	Ingo
> 
> .
> 

