Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D21340229
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCRJeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:34:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13190 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhCRJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:34:00 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1MGr1z7XzmZCK;
        Thu, 18 Mar 2021 17:31:32 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.203) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Mar 2021
 17:33:51 +0800
Subject: Re: [Linuxarm] Re: [PATCH 2/3] drivers/perf: convert sysfs scnprintf
 family to sysfs_emit_at
To:     Joe Perches <joe@perches.com>, <john.garry@huawei.com>,
        <zhangshaokun@hisilicon.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <1615974111-45601-1-git-send-email-liuqi115@huawei.com>
 <1615974111-45601-3-git-send-email-liuqi115@huawei.com>
 <eae7016a8cd8f426987dd5c4a2a56c4ec6d28a6e.camel@perches.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <a2ccfc0f-5790-ef03-d357-ab606f40b3c5@huawei.com>
Date:   Thu, 18 Mar 2021 17:33:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <eae7016a8cd8f426987dd5c4a2a56c4ec6d28a6e.camel@perches.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/17 22:57, Joe Perches wrote:
> On Wed, 2021-03-17 at 17:41 +0800, Qi Liu wrote:
>> Use the generic sysfs_emit_at() function take place of scnprintf()
> []
>> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> []
>> @@ -328,41 +328,37 @@ static ssize_t arm_ccn_pmu_event_show(struct device *dev,
>>   			struct arm_ccn_pmu_event, attr);
>>   	ssize_t res;
>>   
>>
>> -	res = scnprintf(buf, PAGE_SIZE, "type=0x%x", event->type);
>> +	res = sysfs_emit(buf, "type=0x%x", event->type);
>>   	if (event->event)
>> -		res += scnprintf(buf + res, PAGE_SIZE - res, ",event=0x%x",
>> +		res += sysfs_emit_at(buf + res, res, ",event=0x%x",
>>   				event->event);
> 
> sysfs_emit_at should always use buf, not buf + offset.
> res should be int and is the offset from buf for the output
> 
> so the form should be similar to
> 
> 	int len;
> 
> 	len = sysfs_emit(buf, "type=0x%x", event->type);
> 	if (event->event) {
> 		len += sysfs_emit_at(buf, len, ",event=0x%x", event->event);
> 
> 		etc...
> 
Hi Joe,

I'll fix the use of sysfs_emit_at in next version, thanks.
But I think it's better to keep the res as ssize_t, as the return value 
of this function is ssize_t.

Thanks,

Qi

> _______________________________________________
> Linuxarm mailing list -- linuxarm@openeuler.org
> To unsubscribe send an email to linuxarm-leave@openeuler.org
> 

