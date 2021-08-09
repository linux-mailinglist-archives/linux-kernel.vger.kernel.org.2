Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9F3E479B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhHIOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:36:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13301 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbhHIOd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:33:56 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gjz2t49Pbz84Qv;
        Mon,  9 Aug 2021 22:28:22 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 22:33:19 +0800
Received: from [10.67.102.197] (10.67.102.197) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 9 Aug 2021 22:33:18 +0800
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
To:     Waiman Long <llong@redhat.com>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <boqun.feng@gmail.com>
CC:     <wangle6@huawei.com>, <xiaoqian9@huawei.com>, <shaolexi@huawei.com>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <48cddad4-0388-ae8b-f98b-1629b9ae590a@redhat.com>
 <1a5b0f50-b071-2d1c-5277-b6d7f652c257@huawei.com>
 <65fe396a-b10d-2388-8229-05fd43d58927@redhat.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <2266017d-df76-1208-0e1f-0b066c788f66@huawei.com>
Date:   Mon, 9 Aug 2021 22:33:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <65fe396a-b10d-2388-8229-05fd43d58927@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema774-chm.china.huawei.com (10.1.198.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/9 20:52, Waiman Long wrote:
> On 8/8/21 11:51 PM, Xiaoming Ni wrote:
>> On 2021/8/9 11:01, Waiman Long wrote:
>>>
>>> I think it is simpler to just put a "might_sleep()" in 
>>> __down_common() which is the function where sleep can actually happen.
>>>
>>
>> If the actual atomic context hibernation occurs, the corresponding 
>> alarm log is generated in __schedule_bug().
>>     __schedule()
>>         --> schedule_debug()
>>             --> __schedule_bug()
>>
>> However, "might_sleep()" indicates the possibility of sleep, so that 
>> code writers can identify and fix the problem as soon as possible, but 
>> does not trigger atomic context sleep.
>>
>> Is it better to put "might_sleep()" in each down API entry than 
>> __down_common() to help identify potential code problems? 
> 
> Putting "might_sleep()" in each down_*() functions mean that whenever we 
> add a new API function, we have to remember to add "might_sleep()". If
> we put it in down_common(), it will work for any newly added API 
> function in the future even though I doubt we will add any.
> 
If the code enters down_common(), it is not "might" sleep but "will" 
sleep, and an alarm is printed in __schedule_bug() later.

"might_sleep()" is used to check potential problems, and 
"_schedule_bug()" is used to check actual faults.

So, I still think we should add "might_sleep()" to each down_*() 
function to alert code owner to potential problems early.

Thanks
Xiaoming Ni

