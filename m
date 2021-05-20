Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54074389FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhETIdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:33:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3620 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhETIdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:33:14 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fm2w331W8zmX7y;
        Thu, 20 May 2021 16:29:23 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 16:31:39 +0800
Received: from [10.67.102.248] (10.67.102.248) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 16:31:39 +0800
Subject: Re: [PATCH] arm_pmu: Fix write counter incorrect in ARMv7 big-endian
 mode
To:     Mark Rutland <mark.rutland@arm.com>, <will@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux@armlinux.org.uk>,
        <suzuki.poulose@arm.com>, <julien.thierry.kdev@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210430012659.232110-1-yangjihong1@huawei.com>
 <20210430123408.GD53304@C02TD0UTHF1T.local>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <e5dab6a1-9407-bcee-56ff-4a74fa45c9de@huawei.com>
Date:   Thu, 20 May 2021 16:31:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210430123408.GD53304@C02TD0UTHF1T.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Mark

On 2021/4/30 20:34, Mark Rutland wrote:
> On Fri, Apr 30, 2021 at 09:26:59AM +0800, Yang Jihong wrote:
>> Commit 3a95200d3f89a ("arm_pmu: Change API to support 64bit counter values")
>> changes the input "value" type from 32-bit to 64-bit,
>> which introduces the following problem:
>> ARMv7 PMU counters is 32-bit width, in big-endian mode, write counter uses
>> high 32-bit, which writes an incorrect value.
> 
> It might be worth noting that the reason for this is that when a 64-bit
> value is split across two 32-bit registers, the high/low halves are
> split to match how LDRD would load a 64-bit quantity (and so differs
> across big/little endian), but the "r" constraint consistently uses the
> first of the two regiseters.
> 
> Given that, this patch makes sense to me (and I didn't spot any related
> issues), so:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thank you for your review. :)
Yang.
> 
> Will, I assume you'll pick this up.
> 
> Mark.
> 
>>
>> Before:
>>
>>   Performance counter stats for 'ls':
>>
>>                2.22 msec task-clock                #    0.675 CPUs utilized
>>                   0      context-switches          #    0.000 K/sec
>>                   0      cpu-migrations            #    0.000 K/sec
>>                  49      page-faults               #    0.022 M/sec
>>          2150476593      cycles                    #  966.663 GHz
>>          2148588788      instructions              #    1.00  insn per cycle
>>          2147745484      branches                  # 965435.074 M/sec
>>          2147508540      branch-misses             #   99.99% of all branches
>>
>> None of the above hw event counters are correct.
>>
>> Solution:
>>
>> "value" forcibly converted to 32-bit type before being written to PMU register.
>>
>> After:
>>
>>   Performance counter stats for 'ls':
>>
>>                2.09 msec task-clock                #    0.681 CPUs utilized
>>                   0      context-switches          #    0.000 K/sec
>>                   0      cpu-migrations            #    0.000 K/sec
>>                  46      page-faults               #    0.022 M/sec
>>             2807301      cycles                    #    1.344 GHz
>>             1060159      instructions              #    0.38  insn per cycle
>>              250496      branches                  #  119.914 M/sec
>>               23192      branch-misses             #    9.26% of all branches
>>
>> Fixes: 3a95200d3f89a ("arm_pmu: Change API to support 64bit counter values")
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   arch/arm/kernel/perf_event_v7.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
>> index 2924d7910b10..eb2190477da1 100644
>> --- a/arch/arm/kernel/perf_event_v7.c
>> +++ b/arch/arm/kernel/perf_event_v7.c
>> @@ -773,10 +773,10 @@ static inline void armv7pmu_write_counter(struct perf_event *event, u64 value)
>>   		pr_err("CPU%u writing wrong counter %d\n",
>>   			smp_processor_id(), idx);
>>   	} else if (idx == ARMV7_IDX_CYCLE_COUNTER) {
>> -		asm volatile("mcr p15, 0, %0, c9, c13, 0" : : "r" (value));
>> +		asm volatile("mcr p15, 0, %0, c9, c13, 0" : : "r" ((u32)value));
>>   	} else {
>>   		armv7_pmnc_select_counter(idx);
>> -		asm volatile("mcr p15, 0, %0, c9, c13, 2" : : "r" (value));
>> +		asm volatile("mcr p15, 0, %0, c9, c13, 2" : : "r" ((u32)value));
>>   	}
>>   }
>>   
>> -- 
>> 2.30.GIT
>>
> .
> 
