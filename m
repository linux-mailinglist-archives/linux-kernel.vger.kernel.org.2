Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ACD398A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFBNWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:22:18 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56702 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229583AbhFBNWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:22:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Ub3L4fy_1622640032;
Received: from xuyu-mbp15.local(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0Ub3L4fy_1622640032)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Jun 2021 21:20:33 +0800
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com,
        Greg Thelen <gthelen@google.com>, Wei Xu <weixugc@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
 <alpine.LSU.2.11.2106010947370.1090@eggly.anvils>
From:   Yu Xu <xuyu@linux.alibaba.com>
Message-ID: <b05ab98d-3a0d-ec23-96dd-5c970aa61580@linux.alibaba.com>
Date:   Wed, 2 Jun 2021 21:20:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2106010947370.1090@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 12:55 AM, Hugh Dickins wrote:
> On Wed, 2 Jun 2021, Xu Yu wrote:
> 
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
>> copy_to_user, which will immediately fault again without rescheduling,
>> and thus occupy the cpu fully.
>>
>> When there are too many processes performing __migration_entry_wait on
>> tail page, remap_page will never be done after cond_resched.
>>
>> This relaxes __migration_entry_wait on tail page, thus gives remap_page
>> a chance to complete.
>>
>> Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
>> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> 
> Well caught: you're absolutely right that there's a bug there.
> But isn't cond_resched() just papering over the real bug, and
> what it should do is a "page = compound_head(page);" before the
> get_page_unless_zero()? How does that work out in your testing?

compound_head works. The patched kernel is alive for hours under
our reproducer, which usually makes the vanilla kernel hung after
tens of minutes at most.

If we use compound_head, the behavior of __migration_entry_wait(tail)
changes from "retry fault" to "prevent THP from being split". Is that
right?  Then which is preferred? If it were me, I would prefer "retry
fault".


> 
> Hugh
> 
>> ---
>>   mm/migrate.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index b234c3f3acb7..df2dc39fe566 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -301,8 +301,11 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>>   	 * is zero; but we must not call put_and_wait_on_page_locked() without
>>   	 * a ref. Use get_page_unless_zero(), and just fault again if it fails.
>>   	 */
>> -	if (!get_page_unless_zero(page))
>> -		goto out;
>> +	if (!get_page_unless_zero(page)) {
>> +		pte_unmap_unlock(ptep, ptl);
>> +		cond_resched();
>> +		return;
>> +	}
>>   	pte_unmap_unlock(ptep, ptl);
>>   	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
>>   	return;
>> -- 
>> 2.20.1.2432.ga663e714
>>
>>
>>

-- 
Thanks,
Yu
