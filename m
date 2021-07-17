Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6C3CC0A8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 03:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhGQB5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 21:57:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7381 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhGQB46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 21:56:58 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GRWJx1QS4z7t7m;
        Sat, 17 Jul 2021 09:50:25 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 17 Jul 2021 09:54:00 +0800
Subject: Re: [PATCH 2/3] mm/vmstat: simplify the array size calculation
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210715122911.15700-1-linmiaohe@huawei.com>
 <20210715122911.15700-3-linmiaohe@huawei.com>
 <79fb76da-f811-7030-abd6-1dd970e7ab53@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c980d49b-3953-3eff-8e2a-d7d24e53bdfa@huawei.com>
Date:   Sat, 17 Jul 2021 09:54:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <79fb76da-f811-7030-abd6-1dd970e7ab53@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/16 20:58, David Hildenbrand wrote:
> On 15.07.21 14:29, Miaohe Lin wrote:
>> We can replace the array_num * sizeof(array[0]) with sizeof(array) to
>> simplify the code.
> 
> Could have mentioned taht your fixing indentation of one "return true;"
> 

Yes, but I thought that's too trivial to mention... I would pay attention to it later.

> LGTM
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Many thanks for your review and reply!

> 
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/vmstat.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 57e8e7fda7aa..76aef9510f6d 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1889,17 +1889,15 @@ static bool need_update(int cpu)
>>           /*
>>            * The fast way of checking if there are any vmstat diffs.
>>            */
>> -        if (memchr_inv(pzstats->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
>> -                   sizeof(pzstats->vm_stat_diff[0])))
>> +        if (memchr_inv(pzstats->vm_stat_diff, 0, sizeof(pzstats->vm_stat_diff)))
>>               return true;
>>             if (last_pgdat == zone->zone_pgdat)
>>               continue;
>>           last_pgdat = zone->zone_pgdat;
>>           n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
>> -        if (memchr_inv(n->vm_node_stat_diff, 0, NR_VM_NODE_STAT_ITEMS *
>> -                   sizeof(n->vm_node_stat_diff[0])))
>> -            return true;
>> +        if (memchr_inv(n->vm_node_stat_diff, 0, sizeof(n->vm_node_stat_diff)))
>> +            return true;
>>       }
>>       return false;
>>   }
>>
> 
> 

