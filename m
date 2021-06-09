Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19BC3A0A76
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbhFIDIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:08:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8100 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhFIDIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:08:19 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0Bkt5hfzzYsFY;
        Wed,  9 Jun 2021 11:03:34 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 11:06:24 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 11:06:24 +0800
Subject: Re: [PATCH 1/1] ring-buffer: remove leading spaces before tabs
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210608081051.13382-1-thunder.leizhen@huawei.com>
 <20210608105943.2376328c@oasis.local.home>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <60fcce9f-abf5-4dd0-1bba-a1f19ec251d0@huawei.com>
Date:   Wed, 9 Jun 2021 11:06:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210608105943.2376328c@oasis.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/8 22:59, Steven Rostedt wrote:
> On Tue, 8 Jun 2021 16:10:51 +0800
> Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
>> 1) Run the following command to find and remove the leading spaces before
>>    tabs:
>>    find kernel/trace/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
>> 2) Manually check and correct if necessary
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Sorry, but I do not accept whitespace changes. Clean ups like this is
> only welcomed if they come along with actual changes to the code around

It's the wrong way of thinking. It's like having mosquitoes in the house and
killing a mosquito only when you meet it. Mosquitoes will exist for a long
time, and not all mosquitoes will be killed. People who have been in the house
will always face being bitten unless they don't care.


> them. Otherwise, this just causes extra churn and unwelcomed work for
> the maintainer.

Yes, the changes are a little less. There is no owner for the whole kernel
module. So I had to take it apart. As a programmer, since I discovered it,
I had an instinctive drive to fix it. Even if it won't be accepted.

> 
> -- Steve
> 
> 
>> ---
>>  kernel/trace/ring_buffer.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>> index 833ade3d0b00..a555258556c5 100644
>> --- a/kernel/trace/ring_buffer.c
>> +++ b/kernel/trace/ring_buffer.c
>> @@ -5887,7 +5887,7 @@ static __init int test_ringbuffer(void)
>>  		}
>>  
>>  		kthread_bind(rb_threads[cpu], cpu);
>> - 		wake_up_process(rb_threads[cpu]);
>> +		wake_up_process(rb_threads[cpu]);
>>  	}
>>  
>>  	/* Now create the rb hammer! */
> 
> 
> .
> 

