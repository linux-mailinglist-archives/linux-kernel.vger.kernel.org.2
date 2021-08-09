Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021683E3E71
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 05:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhHIDvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 23:51:33 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13251 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhHIDvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:51:32 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GjhvQ15l4z1CTqj;
        Mon,  9 Aug 2021 11:50:58 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 11:51:09 +0800
Received: from [10.67.102.197] (10.67.102.197) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 9 Aug 2021 11:51:09 +0800
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
To:     Waiman Long <llong@redhat.com>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <boqun.feng@gmail.com>
CC:     <wangle6@huawei.com>, <xiaoqian9@huawei.com>, <shaolexi@huawei.com>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <48cddad4-0388-ae8b-f98b-1629b9ae590a@redhat.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <1a5b0f50-b071-2d1c-5277-b6d7f652c257@huawei.com>
Date:   Mon, 9 Aug 2021 11:51:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <48cddad4-0388-ae8b-f98b-1629b9ae590a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema774-chm.china.huawei.com (10.1.198.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/9 11:01, Waiman Long wrote:
> On 8/8/21 10:12 PM, Xiaoming Ni wrote:
>> Semaphore is sleeping lock. Add might_sleep() to down*() family
>> (with exception of down_trylock()) to detect atomic context sleep.
>>
>> Previously discussed with Peter Zijlstra, see link:
>>   
>> https://lore.kernel.org/lkml/20210806082320.GD22037@worktop.programming.kicks-ass.net 
>>
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> ---
>>   kernel/locking/semaphore.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
>> index 9aa855a96c4a..9ee381e4d2a4 100644
>> --- a/kernel/locking/semaphore.c
>> +++ b/kernel/locking/semaphore.c
>> @@ -54,6 +54,7 @@ void down(struct semaphore *sem)
>>   {
>>       unsigned long flags;
>> +    might_sleep();
>>       raw_spin_lock_irqsave(&sem->lock, flags);
>>       if (likely(sem->count > 0))
>>           sem->count--;
>> @@ -77,6 +78,7 @@ int down_interruptible(struct semaphore *sem)
>>       unsigned long flags;
>>       int result = 0;
>> +    might_sleep();
>>       raw_spin_lock_irqsave(&sem->lock, flags);
>>       if (likely(sem->count > 0))
>>           sem->count--;
>> @@ -103,6 +105,7 @@ int down_killable(struct semaphore *sem)
>>       unsigned long flags;
>>       int result = 0;
>> +    might_sleep();
>>       raw_spin_lock_irqsave(&sem->lock, flags);
>>       if (likely(sem->count > 0))
>>           sem->count--;
>> @@ -157,6 +160,7 @@ int down_timeout(struct semaphore *sem, long timeout)
>>       unsigned long flags;
>>       int result = 0;
>> +    might_sleep();
>>       raw_spin_lock_irqsave(&sem->lock, flags);
>>       if (likely(sem->count > 0))
>>           sem->count--;
> 
> I think it is simpler to just put a "might_sleep()" in __down_common() 
> which is the function where sleep can actually happen.
> 

If the actual atomic context hibernation occurs, the corresponding alarm 
log is generated in __schedule_bug().
	__schedule()
		--> schedule_debug()
			--> __schedule_bug()

However, "might_sleep()" indicates the possibility of sleep, so that 
code writers can identify and fix the problem as soon as possible, but 
does not trigger atomic context sleep.

Is it better to put "might_sleep()" in each down API entry than 
__down_common() to help identify potential code problems?

Thanks
Xiaoming Ni

