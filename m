Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D8A3C6799
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 02:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhGMAtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 20:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233505AbhGMAta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 20:49:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A083C60FDB;
        Tue, 13 Jul 2021 00:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626137201;
        bh=6bUuDtl3T5ukpb4KgsVCNQhFQQRp/NYEnjIyp76CrDI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RTrcqMpIAK3M4VifUJz1XrGglzqn+jXET/gtby1x5QC4eq63YXZ9TE0mp5tNWwarj
         RyQ5mYymQ+98Fd2NTxd1eGDKSWqcMGr7UbnvMI69Oh53mQxqdX/cSFX8ppp2odDBTS
         gNtM1rlndrkx2r81evSvCSIpKT+gvQFVQzkHzhoKEtMSxRo/ECtK28Q5YDW4WPNr3r
         KpEiD3zNzb+8vWD8Soul+U7d7neyrGJtZo0yyX+hDryuYNIcHVnWuzpHe+1mPSGPfN
         VTneLTyAmzJsB74eCwgB0jaeYisDuEK/W6VOmoJmZ5pD4x2xeR1vvq/V99nMQP3Ue9
         LgtqrqDG7bH7Q==
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
References: <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org> <YONJpQapR7BRnW/J@google.com>
 <YONTRlrJugeVq6Fj@casper.infradead.org>
 <20210706091211.GR3840@techsingularity.net>
 <85bb893b-0dc4-5f57-23ec-3f84814b7072@kernel.org>
 <20210707095706.GT3840@techsingularity.net>
 <fc0de0c2-a3b6-df91-5b90-524768a85d82@kernel.org>
 <YOvm2faBUjKmZI7Q@dhcp22.suse.cz>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ce628979-6f1c-0070-9680-841c87745639@kernel.org>
Date:   Tue, 13 Jul 2021 08:46:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOvm2faBUjKmZI7Q@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/12 14:53, Michal Hocko wrote:
> On Sat 10-07-21 16:11:38, Chao Yu wrote:
>> On 2021/7/7 17:57, Mel Gorman wrote:
>>> I think it would work but it would be preferable to find out why the
>>> tail page has an order set in the first place. I've looked over
>>
>> Agreed.
>>
>>> mm/page_alloc.c and mm/compaction.c a few times and did not spot where
>>> set_private_page(page, 0) is missed when it should be covered by
>>> clear_page_guard or del_page_from_free_list :(
>>
>> I didn't enable CONFIG_DEBUG_PAGEALLOC, so we will expect page private
>> should be cleared by del_page_from_free_list(), but I guess it only clears
>> the buddy's private field rather than original page's, so I added below
>> diff and check the dmesg, it looks stall private value in original page
>> will be left commonly... Let me know if I missed something?
> 
> Page private should be cleared when the page is freed to the allocator.
> Have a look at PAGE_FLAGS_CHECK_AT_FREE.

Quoted from Jaegeuk's comments in [1]

"Hmm, I can see it in 4.14 and 5.10 kernel.

The trace is on:

  30875 [ 1065.118750] c3     87  f2fs_migrate_page+0x354/0x45c
  30876 [ 1065.123872] c3     87  move_to_new_page+0x70/0x30c
  30877 [ 1065.128813] c3     87  migrate_pages+0x3a0/0x964
  30878 [ 1065.133583] c3     87  compact_zone+0x608/0xb04
  30879 [ 1065.138257] c3     87  kcompactd+0x378/0x4ec
  30880 [ 1065.142664] c3     87  kthread+0x11c/0x12c
  30881 [ 1065.146897] c3     87  ret_from_fork+0x10/0x18

  It seems compaction_alloc() gets a free page which doesn't reset the fields?"

https://lore.kernel.org/linux-f2fs-devel/YOvm2faBUjKmZI7Q@dhcp22.suse.cz/T/#m98a4a5e777f5b0e7366b367463efafd2133dd681

So problem here we met is: in f2fs_migrate_page(), newpage may has stall .private
value rather than PG_private flag, which may cause f2fs will treat the page with
wrong private status.

> 
>> ---
>>   mm/page_alloc.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index a06bcfe6f786..1e7031ff548e 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1029,6 +1029,7 @@ static inline void __free_one_page(struct page *page,
>>   	unsigned long combined_pfn;
>>   	unsigned int max_order;
>>   	struct page *buddy;
>> +	struct page *orig_page = page;
>>   	bool to_tail;
>>
>>   	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
>> @@ -1097,6 +1098,10 @@ static inline void __free_one_page(struct page *page,
>>
>>   done_merging:
>>   	set_buddy_order(page, order);
>> +	if (orig_page != page) {
>> +		if (WARN_ON_ONCE(orig_page->private))
>> +			pr_info("2order:%x, origpage.private:%x", order, orig_page->private);
>> +	}
> 
> Why is this expected? Buddy allocator uses page private to store order.
> Whether we are merging to the freed page or coalesce it to a different

The order was only set in head page, right? Since it looks __free_one_page() tries
to clear page.private for every buddy with del_page_from_free_list().

If that is true, after done_merging label in __free_one_page, if original page is
a tail page, we may missed to clear its page.private field?

Thanks,

> page is not all that important.
> 
