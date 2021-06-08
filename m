Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AAA39F7B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhFHNYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:24:25 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52922 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232775AbhFHNYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:24:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ublzg6m_1623158548;
Received: from xuyu-mbp15.local(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0Ublzg6m_1623158548)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Jun 2021 21:22:28 +0800
Subject: Re: [PATCH v2] mm, thp: use head page in __migration_entry_wait
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, hughd@google.com,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com
References: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
 <20210608120026.ugfh72ydjeba44bo@box.shutemov.name>
From:   Yu Xu <xuyu@linux.alibaba.com>
Message-ID: <57e151a8-03b2-3458-0178-21edb4ce97d2@linux.alibaba.com>
Date:   Tue, 8 Jun 2021 21:22:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210608120026.ugfh72ydjeba44bo@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 8:00 PM, Kirill A. Shutemov wrote:
> On Tue, Jun 08, 2021 at 05:22:39PM +0800, Xu Yu wrote:
>> We notice that hung task happens in a conner but practical scenario when
>> CONFIG_PREEMPT_NONE is enabled, as follows.
>>
>> Process 0                       Process 1                     Process 2..Inf
>> split_huge_page_to_list
>>      unmap_page
>>          split_huge_pmd_address
>>                                  __migration_entry_wait(head)
>>                                                                __migration_entry_wait(tail)
>>      remap_page (roll back)
>>          remove_migration_ptes
>>              rmap_walk_anon
>>                  cond_resched
>>
>> Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
>> copy_to_user in fstat, which will immediately fault again without
>> rescheduling, and thus occupy the cpu fully.
>>
>> When there are too many processes performing __migration_entry_wait on
>> tail page, remap_page will never be done after cond_resched.
>>
>> This makes __migration_entry_wait operate on the compound head page,
>> thus waits for remap_page to complete, whether the THP is split
>> successfully or roll back.
>>
>> Note that put_and_wait_on_page_locked helps to drop the page reference
>> acquired with get_page_unless_zero, as soon as the page is on the wait
>> queue, before actually waiting. So splitting the THP is only prevented
>> for a brief interval.
>>
>> Fixes: ba98828088ad ("thp: add option to setup migration entries during PMD split")
>> Suggested-by: Hugh Dickins <hughd@google.com>
>> Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
>> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> 
> Looks good to me:
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> But there's one quirk: if split succeed we effectively wait on wrong
> page to be unlocked. And it may take indefinite time if split_huge_page()
> was called on the head page.

Inspired by you, I look into the codes, and have a new question (nothing
to do with this patch).

If we split_huge_page_to_list on *tail* page (in fact, I haven't seen
that used yet),

mm/huge_memory.c:2666 checks "VM_BUG_ON_PAGE(!PageLocked(head), head);"
in split_huge_page_to_list(), while

mm/huge_memory.c:2497 does "unlock_page(subpage)", where subpage can
be head in this scenario, in __split_huge_page().

My confusion is
1) how the pin on the @subpage is got outside split_huge_page_to_list()?
    can we ever get tail page?

2) head page is locked outside split_huge_page_to_list(), but unlocked
    in __split_huge_page()?


> 
> Maybe we should consider waking up head waiter on head page, even if it is
> still locked after split?
> 
> Something like this (untested):
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..f79a38e21e53 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2535,6 +2535,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   		 */
>   		put_page(subpage);
>   	}
> +
> +	if (page == head)
> +		wake_up_page_bit(page, PG_locked);
>   }
> 
>   int total_mapcount(struct page *page)
> 

-- 
Thanks,
Yu
