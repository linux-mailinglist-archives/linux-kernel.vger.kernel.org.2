Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634FD390D80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 02:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhEZAo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 20:44:58 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:23900 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhEZAo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 20:44:57 -0400
Received: from [0.0.0.0] (unknown [14.154.30.253])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id E88AF80134;
        Wed, 26 May 2021 08:43:22 +0800 (CST)
Subject: Re: [PATCH v2] mm/page_alloc: fix counting of free pages after take
 off from buddy
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "david@redhat.com" <david@redhat.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <8cd355d2-1adc-4189-7b65-cfea13129db5@sangfor.com.cn>
 <20210508035533.23222-1-dinghui@sangfor.com.cn>
 <20210525083228.GA3327407@hori.linux.bs1.fc.nec.co.jp>
From:   Ding Hui <dinghui@sangfor.com.cn>
Message-ID: <1eabe244-4568-e1e1-7f9e-235175cc8c1d@sangfor.com.cn>
Date:   Wed, 26 May 2021 08:43:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525083228.GA3327407@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQx1KHlZMTkxKQxhKH09KH05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46Kio6ED8TFRpPISFKATIy
        FgkaChlVSlVKTUlKQkNCQ0tITktMVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKT1VKTk9VSEtVSU5IWVdZCAFZQUhNS0s3Bg++
X-HM-Tid: 0a79a62044d2b037kuuue88af80134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/25 16:32, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sat, May 08, 2021 at 11:55:33AM +0800, Ding Hui wrote:
>> Recently we found there is a lot MemFree left in /proc/meminfo after
>> do a lot of pages soft offline.
>>
>> I think it's incorrect since NR_FREE_PAGES should not contain HWPoison pages.
>> For offline free pages, after a successful call take_page_off_buddy(), the
>> page is no longer belong to buddy allocator, and will not be used any more,
>> but we missed accounting NR_FREE_PAGES in this situation.
>>
>> Do update like rmqueue() does.
>>
>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
>> ---
>> V2:
>> use __mod_zone_freepage_state instead of __mod_zone_page_state
>>
>>   mm/page_alloc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cfc72873961d..e124a615303b 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8947,6 +8947,7 @@ bool take_page_off_buddy(struct page *page)
>>   			del_page_from_free_list(page_head, zone, page_order);
>>   			break_down_buddy_pages(zone, page_head, page, 0,
>>   						page_order, migratetype);
>> +			__mod_zone_freepage_state(zone, -1, migratetype);
> 
> Page offline code (see set_migratetype_isolate()) seems to handle
> NR_FREE_PAGES counter in its own way, so I think that it's more correct to
> call __mod_zone_freepage_state() only when is_migrate_isolate(migratetype))
> is false.
> 
> Otherwise, the patch looks good to me.
> 

Thanks for reply and suggestion, I'll send v3 patch later.

>>   			ret = true;
>>   			break;
>>   		}
>> -- 
>> 2.17.1


-- 
Thanks,
- Ding Hui
