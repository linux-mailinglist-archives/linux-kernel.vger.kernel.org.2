Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5318836F80A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhD3JoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:44:24 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:18330 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhD3JoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:44:22 -0400
Received: from [0.0.0.0] (unknown [14.154.30.39])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id 9D1E3800C9;
        Fri, 30 Apr 2021 17:43:30 +0800 (CST)
Subject: Re: [RFC PATCH] mm/page_alloc: fix counting of free pages after take
 off from buddy
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210421020426.5914-1-dinghui@sangfor.com.cn>
 <dd242708-e3f5-ab9f-64d4-9efe3b7168ce@redhat.com>
From:   Ding Hui <dinghui@sangfor.com.cn>
Message-ID: <8cd355d2-1adc-4189-7b65-cfea13129db5@sangfor.com.cn>
Date:   Fri, 30 Apr 2021 17:43:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <dd242708-e3f5-ab9f-64d4-9efe3b7168ce@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGU1LHlZDSEgeS0xDS0gfQxpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KyI6ERw5IT8WOE9CMAgxDyg*
        MzcKChdVSlVKTUpCTExOQ0pKSk1KVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKT1VKTk9VSEtVSEJZV1kIAVlBSUNPSDcG
X-HM-Tid: 0a7922296d45b037kuuu9d1e3800c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/28 22:54, David Hildenbrand wrote:
> On 21.04.21 04:04, Ding Hui wrote:
>> Recently we found there is a lot MemFree left in /proc/meminfo after
>> do a lot of pages soft offline.
>>
>> I think it's incorrect since NR_FREE_PAGES should not contain HWPoison 
>> pages.
>> After take_page_off_buddy, the page is no longer belong to buddy
>> allocator, and will not be used any more, but we maybe missed accounting
>> NR_FREE_PAGES in this situation.
>>
>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
>> ---
>>   mm/page_alloc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cfc72873961d..8d65b62784d8 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8947,6 +8947,7 @@ bool take_page_off_buddy(struct page *page)
>>               del_page_from_free_list(page_head, zone, page_order);
>>               break_down_buddy_pages(zone, page_head, page, 0,
>>                           page_order, migratetype);
>> +            __mod_zone_page_state(zone, NR_FREE_PAGES, -1);
>>               ret = true;
>>               break;
>>           }
>>
> 
> Should this use __mod_zone_freepage_state() instead?
> 

Yes, you're right.
I'll use it in v2.

-- 
Thanks,
- Ding Hui
