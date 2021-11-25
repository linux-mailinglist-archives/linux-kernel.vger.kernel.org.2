Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE245D92B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhKYL0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:26:52 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27296 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhKYLYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:24:52 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J0FnX4rNzzbhtB;
        Thu, 25 Nov 2021 19:21:36 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 19:21:39 +0800
Received: from [10.174.177.232] (10.174.177.232) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 19:21:39 +0800
Subject: Re: [PATCH 2/2] sched/pelt: Change the type of parameter running to
 bool
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
References: <20211125030019.10447-1-tangyizhou@huawei.com>
 <20211125030019.10447-3-tangyizhou@huawei.com>
 <YZ9dqgjSkA/Uv+7D@hirez.programming.kicks-ass.net>
From:   Tang Yizhou <tangyizhou@huawei.com>
Message-ID: <312ecbd2-2079-16b9-42c1-fe7e840417e4@huawei.com>
Date:   Thu, 25 Nov 2021 19:21:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <YZ9dqgjSkA/Uv+7D@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.232]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/25 17:55, Peter Zijlstra wrote:
> On Thu, Nov 25, 2021 at 11:00:19AM +0800, Tang Yizhou wrote:
>> Parameter 'running' in function ___update_load_sum() and
>> accumulate_sum() describes whether an se is running or not, so change
>> the type of it to bool to make the code more readable.
>>
>> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
>> ---
>>  kernel/sched/pelt.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>> index 3584df2a0b8e..2010b3bd6e49 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -104,7 +104,7 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
>>   */
>>  static __always_inline u32
>>  accumulate_sum(u64 delta, struct sched_avg *sa,
>> -	       unsigned long load, unsigned long runnable, int running)
>> +	       unsigned long load, unsigned long runnable, bool running)
>>  {
>>  	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
>>  	u64 periods;
>> @@ -182,7 +182,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
>>   */
>>  static __always_inline int
>>  ___update_load_sum(u64 now, struct sched_avg *sa,
>> -		  unsigned long load, unsigned long runnable, int running)
>> +		  unsigned long load, unsigned long runnable, bool running)
>>  {
>>  	u64 delta;
> 
> And this function has:
> 
> 	runnable = running = 0;
> 
> and then people complain about assigning 0 to _Bool, and then we get
> idiocy like:
> 
> 	runnable = running = false;

How about:
        running = runnable = 0;

> 
> Please...
> .
> 

Thanks,
Tang
