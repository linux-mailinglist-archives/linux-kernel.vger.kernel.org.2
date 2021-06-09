Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1778A3A0901
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhFIB2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:28:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3803 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhFIB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:28:42 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G08Tb0rB1zWsQv;
        Wed,  9 Jun 2021 09:21:55 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 09:26:46 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 09:26:46 +0800
Subject: Re: [PATCH v3 8/9] drivers/perf: Simpilfy EVENT ATTR macro in
 arm_dsu_pmu.c
To:     Will Deacon <will@kernel.org>, Qi Liu <liuqi115@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linuxarm <linuxarm@huawei.com>
References: <1623123201-45634-1-git-send-email-liuqi115@huawei.com>
 <1623123201-45634-9-git-send-email-liuqi115@huawei.com>
 <20210608085245.GA8791@willie-the-truck>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <6faf9ebb-ed43-5fdb-f8b2-419c807ca45b@huawei.com>
Date:   Wed, 9 Jun 2021 09:26:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210608085245.GA8791@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Will,
On 2021/6/8 16:52, Will Deacon wrote:
> On Tue, Jun 08, 2021 at 11:33:20AM +0800, Qi Liu wrote:
>> Use common macro PMU_EVENT_ATTR_ID to simplify DSU_EVENT_ATTR.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   drivers/perf/arm_dsu_pmu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
>> index 196faea..bed8376 100644
>> --- a/drivers/perf/arm_dsu_pmu.c
>> +++ b/drivers/perf/arm_dsu_pmu.c
>> @@ -82,7 +82,7 @@
>>   	})[0].attr.attr)
>>   
>>   #define DSU_EVENT_ATTR(_name, _config)		\
>> -	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_event_show, (unsigned long)_config)
>> +	PMU_EVENT_ATTR_ID(_name, dsu_pmu_sysfs_event_show, _config)
>>   
>>   #define DSU_FORMAT_ATTR(_name, _config)		\
>>   	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_format_show, (char *)_config)
> 
> I'm not convinced this is any simpler. We still have two users of the
> DSU_EXT_ATTR macro and the net effect is no change in line count.
> 
Got it, I'll drop this patch and sent a new patchset.

Thanks,
Qi
> Will
> .
> 

