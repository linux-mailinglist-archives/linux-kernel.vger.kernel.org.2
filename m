Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C94B3C70AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhGMMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:49:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6921 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhGMMtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:49:16 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GPKzb56FFz7Bwf;
        Tue, 13 Jul 2021 20:42:51 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 20:46:20 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 13 Jul
 2021 20:46:20 +0800
Subject: Re: [PATCH] cacheinfo: clear cache_leaves(cpu) in
 free_cache_attributes()
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>
References: <1626148058-55230-1-git-send-email-wangxiongfeng2@huawei.com>
 <20210713113315.thsvrvqvqptc7hje@bogus>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <303cd2bf-7142-6ec9-548a-afe7f6e5ca8f@huawei.com>
Date:   Tue, 13 Jul 2021 20:46:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20210713113315.thsvrvqvqptc7hje@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 2021/7/13 19:33, Sudeep Holla wrote:
> On Tue, Jul 13, 2021 at 11:47:38AM +0800, Xiongfeng Wang wrote:
>> On ARM64, when PPTT(Processor Properties Topology Table) is not
>> implemented in ACPI boot, we will goto 'free_ci' with the following
>> print:
>>   Unable to detect cache hierarchy for CPU 0
>>
> 
> The change itself looks good and I am fine with that. However,...
> 
>> But some other codes may still use 'num_leaves' to iterate through the
> 
> Can you point me exactly where it is used to make sure there are no
> other issues associated with that.
> 
>> 'info_list', such as get_cpu_cacheinfo_id(). If 'info_list' is NULL , it
>> would crash. So clear 'num_leaves' in free_cache_attributes().
>>
> 
> And can you provide the crash dump please ? If we are not hitting any
> issue and you just figured this with code inspection, that is fine. It
> helps to determine if this needs to be backport or just good to have
> clean up.

There is no issue in the mainline kernel. get_cpu_cacheinfo_id() is only called
on x86. I didn't hit any issue using the mainline kernel.

Actually, it's our own code that crashed. My colleague Shaobo(CCed) tried to add
MPAM support on ARM64. His code called get_cpu_cacheinfo_id() and crashed when
PPTT is not implemented. Maybe he should check whether PPTT is implemented
before calling get_cpu_cacheinfo_id(), but we think it is also better to clear
cache_leaves(cpu) in free_cache_attributes().
Sorry for not clearly expressed.

Thanks,
Xiongfeng

> 
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/base/cacheinfo.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index bfc0959..dad2962 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c
>> @@ -297,6 +297,7 @@ static void free_cache_attributes(unsigned int cpu)
>>
>>  	kfree(per_cpu_cacheinfo(cpu));
>>  	per_cpu_cacheinfo(cpu) = NULL;
>> +	cache_leaves(cpu) = 0;
> 
> I initially thought it might get used and crash in cache_shared_cpu_map_remove
> but you are setting it later. So where do you suspect it to be used ? Sorry
> if I am missing something obvious, looking at this code after long time.
> 
