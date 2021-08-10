Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303613E5097
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbhHJBVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:21:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8386 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhHJBVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:21:45 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GkFRp2LYrz85pZ;
        Tue, 10 Aug 2021 09:17:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 09:21:17 +0800
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 10 Aug
 2021 09:21:17 +0800
Subject: Re: [PATCH] locking/rtmutex: Add the missing 'ES' of macro
 CONFIG_DEBUG_RT_MUTEXES
To:     Will Deacon <will@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210731123011.4555-1-thunder.leizhen@huawei.com>
 <20210809144107.GA1458@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <196ac7c4-f6db-247c-689e-13e7bbae5660@huawei.com>
Date:   Tue, 10 Aug 2021 09:21:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210809144107.GA1458@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/9 22:41, Will Deacon wrote:
> On Sat, Jul 31, 2021 at 08:30:11PM +0800, Zhen Lei wrote:
>> The build option name is defined as DEBUG_RT_MUTEXES in lib/Kconfig.debug,
>> commit f41dcc18698e ("locking/rtmutex: Move debug functions as inlines
>> into common header") can also corroborate this.
>>
>> Fixes: f7efc4799f81 ("locking/rtmutex: Inline chainwalk depth check")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/locking/rtmutex.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
>> index b5d9bb5202c6..ad0db322ed3b 100644
>> --- a/kernel/locking/rtmutex.c
>> +++ b/kernel/locking/rtmutex.c
>> @@ -343,7 +343,7 @@ static __always_inline bool
>>  rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
>>  			      enum rtmutex_chainwalk chwalk)
>>  {
>> -	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEX))
>> +	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
>>  		return waiter != NULL;
>>  	return chwalk == RT_MUTEX_FULL_CHAINWALK;
> 
> Oops, yes. How did you find this?

I found it by chance. When locating a futex problem, I was confused when
reading this part of the code. I used "git grep -wn CONFIG_DEBUG_RT_MUTEX"
to search for the implementation in other places. But I found that it was
not used in other places, then I checked the patch history and found it.

> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Will
> .
> 
