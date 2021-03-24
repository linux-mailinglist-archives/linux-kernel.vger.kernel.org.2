Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13648346FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhCXCuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:50:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14514 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhCXCtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:49:47 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4t1Z2vNxzPlZP;
        Wed, 24 Mar 2021 10:47:14 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Mar 2021
 10:49:43 +0800
Subject: Re: [PATCH] locking/mutex: Remove repeated declaration
To:     Ingo Molnar <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <1616461774-18644-1-git-send-email-zhangshaokun@hisilicon.com>
 <20210323112356.GC3939639@gmail.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <18e11fe3-5866-f46a-9366-a5065d2147ed@hisilicon.com>
Date:   Wed, 24 Mar 2021 10:49:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323112356.GC3939639@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 2021/3/23 19:23, Ingo Molnar wrote:
> 
> * Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> 
>> Commit 0cd39f4600ed ("locking/seqlock, headers: Untangle the spaghetti monster")
>> introduces 'struct ww_acquire_ctx' again, remove the repeated declaration.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Waiman Long <longman@redhat.com>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>  include/linux/mutex.h | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
>> index 0cd631a19727..d80c0e22c822 100644
>> --- a/include/linux/mutex.h
>> +++ b/include/linux/mutex.h
>> @@ -20,8 +20,6 @@
>>  #include <linux/osq_lock.h>
>>  #include <linux/debug_locks.h>
>>  
>> -struct ww_acquire_ctx;
>> -
>>  /*
>>   * Simple, straightforward mutexes with strict semantics:
>>   *
> 
> Please also group the pre-declarations together, that's the canonical 
> pattern we use in headers.

Ok,

> 
> I.e. have something like this at the top:
> 

Got it, I will do it in next version.

Thanks,
Shaokun

>   struct ww_class;
>   struct ww_acquire_ctx;
> 
> Thanks,
> 
> 	Ingo
> .
> 
