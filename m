Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BFB375E84
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 03:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhEGBrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 21:47:51 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:51120 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhEGBru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 21:47:50 -0400
Received: from [0.0.0.0] (unknown [14.154.28.254])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id 3CD6580324;
        Fri,  7 May 2021 09:46:49 +0800 (CST)
Subject: Re: [RFC PATCH] mm/page_alloc: fix counting of free pages after take
 off from buddy
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210421020426.5914-1-dinghui@sangfor.com.cn>
 <dd242708-e3f5-ab9f-64d4-9efe3b7168ce@redhat.com>
 <20210506024943.GA1777607@hori.linux.bs1.fc.nec.co.jp>
 <33be44ea-f377-c049-03ff-3b45289ab5f7@sangfor.com.cn>
 <20210506073055.GA1848917@hori.linux.bs1.fc.nec.co.jp>
From:   Ding Hui <dinghui@sangfor.com.cn>
Message-ID: <6af291a0-41fa-8112-5297-6a4cdf2337b6@sangfor.com.cn>
Date:   Fri, 7 May 2021 09:46:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210506073055.GA1848917@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkwdTlZKTEJCTE4aHUsaGk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6Ihw*Vj8QATohDDcXEEM1
        KyEKCktVSlVKTUlLSE5JS0tCQ0xOVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKT1VKTk9VSUNVSU5PWVdZCAFZQUxCTko3Bg++
X-HM-Tid: 0a794481851db037kuuu3cd6580324
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/6 15:30, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, May 06, 2021 at 12:01:34PM +0800, Ding Hui wrote:
>> On 2021/5/6 10:49, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> On Wed, Apr 28, 2021 at 04:54:59PM +0200, David Hildenbrand wrote:
>>>> On 21.04.21 04:04, Ding Hui wrote:
>>>>> Recently we found there is a lot MemFree left in /proc/meminfo after
>>>>> do a lot of pages soft offline.
>>>>>
>>>>> I think it's incorrect since NR_FREE_PAGES should not contain HWPoison pages.
>>>>> After take_page_off_buddy, the page is no longer belong to buddy
>>>>> allocator, and will not be used any more, but we maybe missed accounting
>>>>> NR_FREE_PAGES in this situation.
>>>>>
>>>>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
>>>>> ---
>>>>>     mm/page_alloc.c | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index cfc72873961d..8d65b62784d8 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -8947,6 +8947,7 @@ bool take_page_off_buddy(struct page *page)
>>>>>     			del_page_from_free_list(page_head, zone, page_order);
>>>>>     			break_down_buddy_pages(zone, page_head, page, 0,
>>>>>     						page_order, migratetype);
>>>>> +			__mod_zone_page_state(zone, NR_FREE_PAGES, -1);
>>>>>     			ret = true;
>>>>>     			break;
>>>>>     		}
>>>>>
>>>>
>>>> Should this use __mod_zone_freepage_state() instead?
>>>
>>> Yes, __mod_zone_freepage_state() looks better to me.
>>>
>>> And I think that maybe an additional __mod_zone_freepage_state() in
>>> unpoison_memory() is necessary to cancel the decrement.  I thought of the
>>> following, but it doesn't build because get_pfnblock_migratetype() is
>>> available only in mm/page_alloc.c, so you might want to add a small exported
>>> routine in mm/page_alloc.c and let it called from unpoison_memory().
>>>
>>>     @@ -1899,8 +1899,12 @@ int unpoison_memory(unsigned long pfn)
>>>             }
>>>             if (!get_hwpoison_page(p, flags, 0)) {
>>>     -               if (TestClearPageHWPoison(p))
>>>     +               if (TestClearPageHWPoison(p)) {
>>>     +                       int migratetype = get_pfnblock_migratetype(p, pfn);
>>>     +
>>>                             num_poisoned_pages_dec();
>>>     +                       __mod_zone_freepage_state(page_zone(p), 1, migratetype);
>>>     +               }
>>>                     unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
>>>                                      pfn, &unpoison_rs);
>>>                     return 0;
>>>
>>
>> I think there is another problem:
>> In normal case, we keep the last refcount of the hwpoison page, so
>> get_hwpoison_page should return 1. The NR_FREE_PAGES will be adjusted when
>> call put_page.
> 
> I think that take_page_off_buddy() should not be called for this case
> (the error page have remaining refcount).  So it seems that no need to
> update NR_FREE_PAGES ?
> 

Yes, take_page_off_buddy() only used for free pages, but we will call 
page_ref_inc() after that, on the other hand for in used pages, we 
increased the refcount by get_any_page(), so in both cases, the 
hwpoisoned pages have refcount great than zero.

I think there is no need to update NR_FREE_PAGES explicitly in 
unpoison_memory(), the put_page() will help us to update NR_FREE_PAGES 
and put the page back to buddy.

>> At race condition, we maybe leak the page because we does not put it back to
>> buddy in unpoison_memory, however the HWPoison flag, num_poisoned_pages,
>> NR_FREE_PAGES is adjusted correctly.
>>
>> CPU0                        CPU1
>>
>> soft_offline_page
>>    soft_offline_free_page
>>      page_handle_poison
>>        take_page_off_buddy
>>        SetPageHWPoison
>>                              unpoison_memory
>>                                if (!get_hwpoison_page(p))
>>                                  TestClearPageHWPoison
>>                                    num_poisoned_pages_dec
>>                                  __mod_zone_freepage_state
>>                                  return 0
>>                                  /* miss put the page back to buddy */
>>        page_ref_inc
>>        num_poisoned_pages_inc
> 
> Thanks for checking this, unpoison_memory() is racy.  Recently we are suggesting
> to introduce mf_mutex by [1].  Although this patch is not merged to mainline yet,
> but it could be used to prevent the above race too.
> 
> [1] https://lore.kernel.org/linux-mm/20210427062953.2080293-2-nao.horiguchi@gmail.com/
> 

I'll look forward to it, thanks.

>>
>> How about do nothing and return -EBUSY (so the caller can retry) if unpoison
>> a zero refcount page , or return 0 like 230ac719c500 ("mm/hwpoison: don't
>> try to unpoison containment-failed pages") does ?
>>
>>    @@ -1736,11 +1736,9 @@ int unpoison_memory(unsigned long pfn)
>>      }
>>
>>      if (!get_hwpoison_page(p, flags, 0)) {
>>    -       if (TestClearPageHWPoison(p))
>>    -           num_poisoned_pages_dec();
>>    -       unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
>>    +       unpoison_pr_info("Unpoison: Software-unpoisoned zero refcount page
>> %#lx\n",
>>    				 pfn, &unpoison_rs);
>>    -       return 0;
>>    +       return -EBUSY;
> 
> Currently unpoison_memory() does not work as reverse operation of take_page_off_buddy()
> (it's simply broken), so implementing it at one time would be better.
> I'll take time to fix unpoison_memory().
> 

Thanks for your work.
Actually, I'm not sure about the exactly meaning of "broken", it seems 
that the basic function of unpoison_memory() is ok if not considered the 
race conditions.


-- 
Thanks,
- Ding Hui
