Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20B0398478
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhFBIrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:47:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3346 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbhFBIrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:47:18 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw2YD3k11z19Ps4;
        Wed,  2 Jun 2021 16:40:48 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:45:31 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 2 Jun
 2021 16:45:30 +0800
Subject: Re: [PATCH v2 1/9] perf: Add EVENT_ATTR_ID to simplify event
 attributes
To:     Will Deacon <will@kernel.org>, Qi Liu <liuqi115@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
References: <1621417919-6632-1-git-send-email-liuqi115@huawei.com>
 <1621417919-6632-2-git-send-email-liuqi115@huawei.com>
 <20210601131020.GD28025@willie-the-truck>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <30abdbec-3174-1f8a-47d4-63a4de3b1e47@huawei.com>
Date:   Wed, 2 Jun 2021 16:45:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210601131020.GD28025@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Will,

Thanks for reviewing this patch.

On 2021/6/1 21:10, Will Deacon wrote:
> On Wed, May 19, 2021 at 05:51:51PM +0800, Qi Liu wrote:
>> Similar EVENT_ATTR macros are defined in many PMU drivers,
>> like HiSilicon PMU driver, Arm PMU driver, Arm SMMU PMU
>> driver. So Add a generic macro to simplify code.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   include/linux/perf_event.h | 6 ++++++
>>   kernel/events/core.c       | 2 ++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index f5a6a2f..d0aa74e 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1576,6 +1576,12 @@ static struct perf_pmu_events_attr _var = {				    \
>>   	.event_str	= _str,						    \
>>   };
>>   
>> +#define PMU_EVENT_ATTR_ID(_name, _id)					     \
>> +	(&((struct perf_pmu_events_attr[]) {				     \
>> +		{ .attr = __ATTR(_name, 0444, perf_event_sysfs_show, NULL),  \
>> +		  .id = _id, }						     \
>> +	})[0].attr.attr)
>> +
>>   #define PMU_FORMAT_ATTR(_name, _format)					\
>>   static ssize_t								\
>>   _name##_show(struct device *dev,					\
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 0ac818b..330d9cc 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -13295,6 +13295,8 @@ ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
>>   
>>   	if (pmu_attr->event_str)
>>   		return sprintf(page, "%s\n", pmu_attr->event_str);
>> +	else
>> +		return sprintf(page, "config=%#llx\n", pmu_attr->id);
> 
> I think it's a really bad idea to hardcode this here. For example, I think
> this patch series breaks user ABI for the SMMU PMU which used to print:
> 
> 	"event=0x%02llx\n"
> 
> and by the looks of it many of the other conversions are unsound too.
> 
Got it, so I'll use pmu_attr->event_str here, for example,
SMMU_EVENT_ATTR(cycles, "event=0x00")

As PMU_EVENT_ATTR_STRING is already defined in linux/perf_event.h，and is 
used in drivers of multi architectures, add a new common macro might be 
better than modify PMU_EVENT_ATTR_STRING.
Do you have any suggestion about the name of new common macro?

Thanks,
Qi
> I'm all for a common macro, but the string needs to be determined by the
> driver.
> 
> Will
> .
> 




