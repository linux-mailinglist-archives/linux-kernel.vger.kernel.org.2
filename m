Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4093E3EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 06:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhHIET2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 00:19:28 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38903 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231753AbhHIETQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 00:19:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UiMU8Wu_1628482734;
Received: from 30.21.164.105(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UiMU8Wu_1628482734)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Aug 2021 12:18:55 +0800
Subject: Re: [PATCH 1/5] mm: migrate: Move the page count validation to the
 proper place
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
 <1f7e1d083864fbb17a20a9c8349d2e8b427e20a3.1628174413.git.baolin.wang@linux.alibaba.com>
 <YQwBD55FZyoY+C5D@casper.infradead.org>
 <a02346d7-1a79-eb92-cb1f-033e6b58fa3f@linux.alibaba.com>
 <YQ3puWSgUvfvIYjv@casper.infradead.org>
 <36956352-246a-b3c2-3ade-2a6c22e2cd5a@linux.alibaba.com>
 <YQ+xQDFdU2SVSo5M@casper.infradead.org>
 <4f25b4e9-0069-1749-32cf-d4644f13be4e@linux.alibaba.com>
 <YQ//xFekzbMODFXy@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <7ec1d098-0021-ae82-8d73-dd9c2eb80dab@linux.alibaba.com>
Date:   Mon, 9 Aug 2021 12:19:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQ//xFekzbMODFXy@casper.infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/9 0:01, Matthew Wilcox wrote:
> On Sun, Aug 08, 2021 at 11:13:28PM +0800, Baolin Wang wrote:
>> On 2021/8/8 18:26, Matthew Wilcox wrote:
>>> On Sun, Aug 08, 2021 at 10:55:30AM +0800, Baolin Wang wrote:
>>>> Hi,
>>>>
>>>>> On Fri, Aug 06, 2021 at 11:07:18AM +0800, Baolin Wang wrote:
>>>>>> Hi Matthew,
>>>>>>
>>>>>>> On Thu, Aug 05, 2021 at 11:05:56PM +0800, Baolin Wang wrote:
>>>>>>>> We've got the expected count for anonymous page or file page by
>>>>>>>> expected_page_refs() at the beginning of migrate_page_move_mapping(),
>>>>>>>> thus we should move the page count validation a little forward to
>>>>>>>> reduce duplicated code.
>>>>>>>
>>>>>>> Please add an explanation to the changelog for why it's safe to pull
>>>>>>> this out from under the i_pages lock.
>>>>>>
>>>>>> Sure. In folio_migrate_mapping(), we are sure that the migration page was
>>>>>> isolated from lru list and locked, so I think there are no race to get the
>>>>>> page count without i_pages lock. Please correct me if I missed something
>>>>>> else. Thanks.
>>>>>
>>>>> Unless the page has been removed from i_pages, this isn't a correct
>>>>> explanation.  Even if it has been removed from i_pages, unless an
>>>>> RCU grace period has passed, another CPU may still be able to inc the
>>>>> refcount on it (temporarily).  The same is true for the page tables,
>>>>> by the way; if someone is using get_user_pages_fast(), they may still
>>>>> be able to see the page.
>>>>
>>>> I don't think this is an issue, cause now we've established a migration pte
>>>> for this migration page under page lock. If the user want to get page by
>>>> get_user_pages_fast(), it will wait for the page miggration finished by
>>>> migration_entry_wait(). So I still think there is no need to check the
>>>> migration page count under the i_pages lock.
>>>
>>> I don't know whether the patch is correct or not, but you aren't nearly
>>> paranoid enough.  Consider this sequence of events:
>>
>> Thanks for describing this scenario.
>>
>>>
>>> CPU 0:				CPU 1:
>>> get_user_pages_fast()
>>> lockless_pages_from_mm()
>>> local_irq_save()
>>> gup_pgd_range()
>>> gup_p4d_range()
>>> gup_pud_range()
>>> gup_pmd_range()
>>> gup_pte_range()
>>> pte_t pte = ptep_get_lockless(ptep);
>>> 				migrate_vma_collect_pmd()
>>> 				ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl)
>>> 				ptep_get_and_clear(mm, addr, ptep);
>>> page = pte_page(pte);
>>> 				set_pte_at(mm, addr, ptep, swp_pte);
>>> 				migrate_page_move_mapping()
>>> head = try_grab_compound_head(page, 1, flags);
>>
>> On CPU0, after grab the page count, it will validate the PTE again. If swap
>> PTE has been established for this page, it will drop the count and go to the
>> slow path.
>> if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>> 	put_compound_head(head, 1, flags);
>> 	goto pte_unmap;
>> }
>>
>> So CPU1 can not observe the abnormal higher refcount in this case if I did
>> not miss anything.
> 
> This is a race between CPUs.  There is no synchronisation between them,
> so CPU 1 can absolutely see the refcount higher temporarily.  Yes,
> CPU 0 will eventually put the refcount, but CPU 1 can observe it high.

OK, I understood your concern. I agree CPU 1 can observe refcount higher 
temporarily, but the migrate_page_move_mapping() has passed the page 
count validation, and will think the page mapping can be migrated, since 
CPU0 will failed to get the page count to go to the slow path.

If the CPU0 increase the page count after page_count() validation in 
migrate_page_move_mapping() on CPU1, and CPU1 will freeze the page count 
to repalce the mapping.
if (!page_ref_freeze(page, expected_count)) {
	xas_unlock_irq(&xas);
	return -EAGAIN;
}

So CPU0 will failed to increase page count by try_grab_compound_head() 
if this page count is under freezing; or CPU1 will failed to freeze the 
page count if CPU0 increases page count successfully, which will abort 
the migration; or after the CPU1 freezing, the CPU0 will increase the 
page count successfully, but will put the page count since PTE was 
changed. Until now, I did not see any terrible things when validating 
the page count in migrate_page_move_mapping() if I understood correctly.

But I have another question, should we change to use ptep_get_lockless() 
instead of pte_val(*ptep) to validate the PTE in gup_pte_range(), to 
avoid getting the old value?
@@ -2185,7 +2185,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long 
addr, unsigned long end,
                         goto pte_unmap;
                 }

-               if (unlikely(pte_val(pte) != pte_val(*ptep))) {
+               if (unlikely(pte_val(pte) != ptep_get_lockless(ptep))) {
                         put_compound_head(head, 1, flags);
                         goto pte_unmap;
                 }
