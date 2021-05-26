Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C921D391250
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhEZIa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:30:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6637 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhEZIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:30:25 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FqkYN3H08z1BR5v;
        Wed, 26 May 2021 16:26:00 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 16:28:48 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 26 May
 2021 16:28:48 +0800
Subject: Re: [PATCH 1/1] sched/topology: Fix a spelling mistake in error
 message
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210526021856.9060-1-thunder.leizhen@huawei.com>
 <42d36255-c1a6-956a-b56b-0c09eee125ec@infradead.org>
 <5571d34f-1965-8d8e-3033-6352dd0dcaee@huawei.com>
 <YK3xSVbwub51ZnaD@hirez.programming.kicks-ass.net>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <14062431-f87b-1f51-6bbc-f54da8abca8d@huawei.com>
Date:   Wed, 26 May 2021 16:28:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YK3xSVbwub51ZnaD@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/26 14:57, Peter Zijlstra wrote:
> On Wed, May 26, 2021 at 10:42:31AM +0800, Leizhen (ThunderTown) wrote:
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
> Language is a living thing; also:
> 
>   https://www.urbandictionary.com/define.php?term=borked

OK, I got it. Thanks.

> 
> I realize that as a non-native speaker idioms and colloquialisms are
> difficult, but if we sanitize the language we'll end up with something
> dreadfully dull and less expressive.
> 
> Also; this is a rather trivial play on words, to break the word broken,
> it should apply to pretty much any (written) language. It should be an
> evident pun to all except computer spell checkers (they so lack humour).
> 
> Also, I too am a non-native speaker, although I suspect I have it easier
> for my native tongue is at least in the same language group as English.
> 
> 
> .
> 

