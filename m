Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44ADE306AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhA1B7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:59:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11205 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhA1B7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:59:41 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DR3WV3JSXzl9Qm;
        Thu, 28 Jan 2021 09:57:26 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 09:58:58 +0800
Subject: Re: [PATCH] mm/memory_hotplug: use helper function zone_end_pfn() to
 get end_pfn
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210127093211.37714-1-linmiaohe@huawei.com>
 <9e15556f-8535-d8ae-d5b1-db264d377c20@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <029811ed-4988-769b-a9f4-7787cf0779c5@huawei.com>
Date:   Thu, 28 Jan 2021 09:58:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9e15556f-8535-d8ae-d5b1-db264d377c20@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/27 17:40, David Hildenbrand wrote:
> On 27.01.21 10:32, Miaohe Lin wrote:
>> Commit 108bcc96ef70 ("mm: add & use zone_end_pfn() and zone_spans_pfn()")
>> introduced the helper zone_end_pfn() to calculate the zone end pfn.  But
>> update_pgdat_span() forgot to use it. Use this helper and re-name local
>> variable zone_end_pfn to end_pfn to fix below compilation error:
>>
>> mm/memory_hotplug.c: In function ‘update_pgdat_span’:
>> mm/memory_hotplug.c:448:32: error: called object ‘zone_end_pfn’ is not a
>> function or function pointer
>>     unsigned long zone_end_pfn = zone_end_pfn(zone);
>>                                  ^~~~~~~~~~~~
>> mm/memory_hotplug.c:448:17: note: declared here
>>     unsigned long zone_end_pfn = zone_end_pfn(zone);
>>                   ^~~~~~~~~~~~
>>
> 
> Please don't talk about compilation issues your changes introduce in that detail, that's just confusing and looks like something would already be broken. Please simplify to something like

I will keep this in mind. Thanks.

> 
> "Let's use zone_end_pfn(zone). We have to rename the local variable to avoid an identifier clash (variable vs. function)."
> 
> With that
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Many thanks for review and reply.

>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/memory_hotplug.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 710e469fb3a1..0483db52b85f 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -493,20 +493,19 @@ static void update_pgdat_span(struct pglist_data *pgdat)
>>         for (zone = pgdat->node_zones;
>>            zone < pgdat->node_zones + MAX_NR_ZONES; zone++) {
>> -        unsigned long zone_end_pfn = zone->zone_start_pfn +
>> -                         zone->spanned_pages;
>> +        unsigned long end_pfn = zone_end_pfn(zone);
>>             /* No need to lock the zones, they can't change. */
>>           if (!zone->spanned_pages)
>>               continue;
>>           if (!node_end_pfn) {
>>               node_start_pfn = zone->zone_start_pfn;
>> -            node_end_pfn = zone_end_pfn;
>> +            node_end_pfn = end_pfn;
>>               continue;
>>           }
>>   -        if (zone_end_pfn > node_end_pfn)
>> -            node_end_pfn = zone_end_pfn;
>> +        if (end_pfn > node_end_pfn)
>> +            node_end_pfn = end_pfn;
>>           if (zone->zone_start_pfn < node_start_pfn)
>>               node_start_pfn = zone->zone_start_pfn;
>>       }
>>
> 
> 

