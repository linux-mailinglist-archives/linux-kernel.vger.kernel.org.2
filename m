Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EAA3F497B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhHWLOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:14:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14410 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhHWLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:13:57 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GtTyr6zxyzbdQ6;
        Mon, 23 Aug 2021 19:09:24 +0800 (CST)
Received: from [10.174.177.35] (10.174.177.35) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 23 Aug 2021 19:13:13 +0800
Subject: Re: [PATCH 2/3] mm/memory_hotplug: fix potential permanent lru cache
 disable
To:     Oscar Salvador <osalvador@suse.de>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <mhocko@suse.com>, <minchan@kernel.org>, <cgoldswo@codeaurora.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210821094246.10149-1-linmiaohe@huawei.com>
 <20210821094246.10149-3-linmiaohe@huawei.com>
 <f42d89e40a604944dbefe0b729c1a685@suse.de>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3a124653-31de-5eb6-3812-73c4ea20bbbf@huawei.com>
Date:   Mon, 23 Aug 2021 19:13:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f42d89e40a604944dbefe0b729c1a685@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.35]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/23 17:15, Oscar Salvador wrote:
> On 2021-08-21 11:42, Miaohe Lin wrote:
>> If offline_pages failed after lru_cache_disable(), it forgot to do
>> lru_cache_enable() in error path. So we would have lru cache disabled
>> permanently in this case.
>>
>> Fixes: d479960e44f2 ("mm: disable LRU pagevec during the migration temporarily")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 

Many thanks for your review and reply. :)

> Should this go to stable?
> In case we fail to enable it again, we will bypass the pvec cache anytime we add a new page to the LRU which might lead to severe performance regression?
> 

Agree with you. I think this should go to stable too.

>> ---
>>  mm/memory_hotplug.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index d986d3791986..9fd0be32a281 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -2033,6 +2033,7 @@ int __ref offline_pages(unsigned long start_pfn,
>> unsigned long nr_pages,
>>      undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
>>      memory_notify(MEM_CANCEL_OFFLINE, &arg);
>>  failed_removal_pcplists_disabled:
>> +    lru_cache_enable();
>>      zone_pcp_enable(zone);
>>  failed_removal:
>>      pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
> 

