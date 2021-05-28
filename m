Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031FD393B57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 04:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhE1CWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 22:22:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5122 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhE1CWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 22:22:13 -0400
Received: from dggeml762-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FrpHn72rwzYnHq;
        Fri, 28 May 2021 10:17:57 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggeml762-chm.china.huawei.com (10.1.199.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 10:20:38 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 10:20:37 +0800
Subject: Re: [PATCH] mm/page_alloc: fix counting of managed_pages
To:     Baoquan He <bhe@redhat.com>
References: <20210527125707.3760259-1-liushixin2@huawei.com>
 <20210527234750.GB31898@MiWiFi-R3L-srv>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        yangerkun <yangerkun@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <138221ad-5ae0-6db6-3572-b8324fb73fdd@huawei.com>
Date:   Fri, 28 May 2021 10:20:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210527234750.GB31898@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/28 7:47, Baoquan He wrote:
> On 05/27/21 at 08:57pm, Liu Shixin wrote:
>> The commit f63661566fad (mm/page_alloc.c: clear out zone->lowmem_reserve[]
>> if the zone is empty) clear out zone->lowmem_reserve[] if zone is empty.
>> But when zone is not empty and sysctl_lowmem_reserve_ratio[i] is set to zero,
>> zone_managed_pages(zone) is not counted in the managed_pages either. This is
>> inconsistent with the description of lowmen_reserve, so fix it.
> Right, this is a good catch. Thanks for the fixing. 
>
> Is it worth adding words in Documentation/admin-guide/sysctl/vm.rst
> to notice this?
>
> Reviewed-by: Baoquan He <bhe@redhat.com>
>
> Thanks
> Baoquan

With this patch, It's consistent with the calculation description of zone[i]'s protection[j].

This is implicit in the description so I don't think it's necessary to notice this.

>> Fixes: f63661566fad ("mm/page_alloc.c: clear out zone->lowmem_reserve[] if the zone is empty")
>> Reported-by: yangerkun <yangerkun@huawei.com>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  mm/page_alloc.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index aaa1655cf682..49a2efce5a84 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8061,14 +8061,14 @@ static void setup_per_zone_lowmem_reserve(void)
>>  			unsigned long managed_pages = 0;
>>  
>>  			for (j = i + 1; j < MAX_NR_ZONES; j++) {
>> -				if (clear) {
>> -					zone->lowmem_reserve[j] = 0;
>> -				} else {
>> -					struct zone *upper_zone = &pgdat->node_zones[j];
>> +				struct zone *upper_zone = &pgdat->node_zones[j];
>> +
>> +				managed_pages += zone_managed_pages(upper_zone);
>>  
>> -					managed_pages += zone_managed_pages(upper_zone);
>> +				if (clear)
>> +					zone->lowmem_reserve[j] = 0;
>> +				else
>>  					zone->lowmem_reserve[j] = managed_pages / ratio;
>> -				}
>>  			}
>>  		}
>>  	}
>> -- 
>> 2.18.0.huawei.25
>>
>>
> .
>

