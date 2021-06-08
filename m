Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70F839EE44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 07:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFHFps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 01:45:48 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48914 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhFHFpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 01:45:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UbjJSIq_1623131032;
Received: from xuyu-mbp15.local(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0UbjJSIq_1623131032)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Jun 2021 13:43:52 +0800
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com,
        Greg Thelen <gthelen@google.com>, Wei Xu <weixugc@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
 <alpine.LSU.2.11.2106010947370.1090@eggly.anvils>
 <b05ab98d-3a0d-ec23-96dd-5c970aa61580@linux.alibaba.com>
 <alpine.LSU.2.11.2106020831590.6388@eggly.anvils>
 <6c4e0df7-1f06-585f-d113-f38db6c819b5@linux.alibaba.com>
 <b9db2528-e3fa-da5a-ba30-4fc5d217957a@google.com>
From:   Yu Xu <xuyu@linux.alibaba.com>
Message-ID: <49d5601c-6ea5-5973-bcbe-bee0c1d4f7de@linux.alibaba.com>
Date:   Tue, 8 Jun 2021 13:43:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <b9db2528-e3fa-da5a-ba30-4fc5d217957a@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 12:44 PM, Hugh Dickins wrote:
> On Mon, 7 Jun 2021, Yu Xu wrote:
>> On 6/2/21 11:57 PM, Hugh Dickins wrote:
>>> On Wed, 2 Jun 2021, Yu Xu wrote:
>>>> On 6/2/21 12:55 AM, Hugh Dickins wrote:
>>>>> On Wed, 2 Jun 2021, Xu Yu wrote:
>>>>>
>>>>>> We notice that hung task happens in a conner but practical scenario when
>>>>>> CONFIG_PREEMPT_NONE is enabled, as follows.
>>>>>>
>>>>>> Process 0                       Process 1                     Process
>>>>>> 2..Inf
>>>>>> split_huge_page_to_list
>>>>>>        unmap_page
>>>>>>            split_huge_pmd_address
>>>>>>                                    __migration_entry_wait(head)
>>>>>>                                                                  __migration_entry_wait(tail)
>>>>>>        remap_page (roll back)
>>>>>>            remove_migration_ptes
>>>>>>                rmap_walk_anon
>>>>>>                    cond_resched
>>>>>>
>>>>>> Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
>>>>>> copy_to_user, which will immediately fault again without rescheduling,
>>>>>> and thus occupy the cpu fully.
>>>>>>
>>>>>> When there are too many processes performing __migration_entry_wait on
>>>>>> tail page, remap_page will never be done after cond_resched.
>>>>>>
>>>>>> This relaxes __migration_entry_wait on tail page, thus gives remap_page
>>>>>> a chance to complete.
>>>>>>
>>>>>> Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
>>>>>> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
>>>>>
>>>>> Well caught: you're absolutely right that there's a bug there.
>>>>> But isn't cond_resched() just papering over the real bug, and
>>>>> what it should do is a "page = compound_head(page);" before the
>>>>> get_page_unless_zero()? How does that work out in your testing?
>>>>
>>>> compound_head works. The patched kernel is alive for hours under
>>>> our reproducer, which usually makes the vanilla kernel hung after
>>>> tens of minutes at most.
>>>
>>> Oh, that's good news, thanks.
>>>
>>> (It's still likely that a well-placed cond_resched() somewhere in
>>> mm/gup.c would also be a good idea, but none of us have yet got
>>> around to identifying where.)
>>
>> We neither. If really have to do it outside of __migration_entry_wait,
>> return value of __migration_entry_wait is needed, and many related
>> functions have to updated, which may be undesirable.
> 
> No, it would not be necessary to plumb through a return value from
> __migration_entry_wait(): I didn't mean that this GUP cond_resched()
> should be done only for the migration case, but (I guess) on any path
> where handle_mm_fault() returns "success" for a retry, yet the retry
> of follow_page_mask() fails.
> 
> But now that I look, I see there is already a cond_resched() there!

Do you mean might_sleep in mmap_read_trylock within do_user_addr_fault?

If so, our environment has CONFIG_PREEMPT_NONE is enabled, and the
__migration_entry_wait happens in kernel when do something like
copy_to_user (e.g., fstat).


> 
> So I'm puzzled as to how your cond_resched() in __migration_entry_wait()
> appeared to help - well, you never actually said that it helped, but I
> assume that it did, or you wouldn't have bothered to send that patch?
> 
> It's irrelevant, now that we've admitted there should be a
> "page = compound_head(page)" in there, and you have said that helps,
> and that's the patch we want to send now.  But it troubles me, to be
> unable to explain it.  Two cond_resched()s are not twice as good as one.
> 
>>
>>>
>>>>
>>>> If we use compound_head, the behavior of __migration_entry_wait(tail)
>>>> changes from "retry fault" to "prevent THP from being split". Is that
>>>> right?  Then which is preferred? If it were me, I would prefer "retry
>>>> fault".
>>>
>>> As Matthew remarked, you are asking very good questions, and split
>>> migration entries are difficult to think about.  But I believe you'll
>>> find it works out okay.
>>>
>>> The point of *put_and_* wait_on_page_locked() is that it does drop
>>> the page reference you acquired with get_page_unless_zero, as soon
>>> as the page is on the wait queue, before actually waiting.
>>>
>>> So splitting the THP is only prevented for a brief interval.  Now,
>>> it's true that if there are very many tasks faulting on portions
>>> of the huge page, in that interval between inserting the migration
>>> entries and freezing the huge page's refcount to 0, they can reduce
>>> the chance of splitting considerably.  But that's not an excuse for
>>> for doing get_page_unless_zero() on the wrong thing, as it was doing.
>>
>> We finally come to your solution, i.e., compound_head.
>>
>> In that case, who should resend the compound_head patch to this issue?
>> shall we do with your s.o.b?
> 
> I was rather expecting you to send the patch: with your s.o.b, not mine.
> You could say "Suggested-by: Hugh Dickins <hughd@google.com>" if you like.
> 
> And I suggest that you put that "page = compound_head(page);" line
> immediately after the "page = migration_entry_to_page(entry);" line,
> so as not to interfere with the comment above get_page_unless_zero().
> 
> (No need for a comment on the compound_head(): it's self-explanatory.)
> 
> I did meanwhile research other callers of migration_entry_to_page():
> it had been on my mind, that others might need a compound_head() too,
> and perhaps it should be done inside migration_entry_to_page() itself.
> 
> But so far as I can tell (I don't really know about the s390 one),
> the others are okay, and it would just be unnecessary overhead
> (in particular, the mm_counter() stuff looks correct on a tail).
> 
> I *think* the right Fixes tag would be
> Fixes: ba98828088ad ("thp: add option to setup migration entries during PMD split")
> though I'm not sure of that; it's probably good enough.
> 
> (With all this direction, I did wonder if it would be kinder just to
> send a patch myself, but using some of your comments: but I didn't
> understand "conner" in your description, so couldn't do that.)
> 
> Thanks!
> Hugh
> 

-- 
Thanks,
Yu
