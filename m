Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D941B42858E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhJKDYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:24:19 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38950 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233793AbhJKDYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:24:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UrJgEv6_1633922535;
Received: from 30.240.97.150(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UrJgEv6_1633922535)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 11:22:16 +0800
Message-ID: <4da91be0-7370-9ae7-d294-8ddd9859bf58@linux.alibaba.com>
Date:   Mon, 11 Oct 2021 11:22:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0)
 Gecko/20100101 Thunderbird/93.0
Subject: Re: [PATCH v4 2/2] mm, thp: bail out early in collapse_file for
 writeback page
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, song@kernel.org,
        william.kucharski@oracle.com, hughd@google.com, shy828301@gmail.com
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20211011022241.97072-1-rongwei.wang@linux.alibaba.com>
 <20211011022241.97072-3-rongwei.wang@linux.alibaba.com>
 <YWOqpgZlqjLhX6oC@casper.infradead.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <YWOqpgZlqjLhX6oC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/21 11:08 AM, Matthew Wilcox wrote:
> On Mon, Oct 11, 2021 at 10:22:41AM +0800, Rongwei Wang wrote:
>> Currently collapse_file does not explicitly check PG_writeback, instead,
>> page_has_private and try_to_release_page are used to filter writeback
>> pages. This does not work for xfs with blocksize equal to or larger
>> than pagesize, because in such case xfs has no page->private.
>>
>> This makes collapse_file bail out early for writeback page. Otherwise,
>> xfs end_page_writeback will panic as follows.
>>
>> Fixes: eb6ecbed0aa2 ("mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs")
> 
> This is the wrong Fixes line.  This same bug exists earlier than this.
> Your testing may not show it before then, but if you mmap something
> that isn't an executable, you can provoke it.  It should be:
> 
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> 
> (unless there's something I'm missing?)
Hi, Matthew
I forget the Patch #2 fix the bug that is different with Patch #1. I 
will update this.

Thanks for your remind!
> 
> Also, this should surely have a Cc: stable@vger.kernel.org in the
> tags section?  It's a user-visible bug, we want it backported.
OK, Thanks!
> 
>> Suggested-by: Yang Shi <shy828301@gmail.com>
>> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
>> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
>> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> ---
>>   mm/khugepaged.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 045cc579f724..48de4e1b0783 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1763,6 +1763,10 @@ static void collapse_file(struct mm_struct *mm,
>>   				filemap_flush(mapping);
>>   				result = SCAN_FAIL;
>>   				goto xa_unlocked;
>> +			} else if (PageWriteback(page)) {
>> +				xas_unlock_irq(&xas);
>> +				result = SCAN_FAIL;
>> +				goto xa_unlocked;
>>   			} else if (trylock_page(page)) {
>>   				get_page(page);
>>   				xas_unlock_irq(&xas);
>> @@ -1798,7 +1802,8 @@ static void collapse_file(struct mm_struct *mm,
>>   			goto out_unlock;
>>   		}
>>   
>> -		if (!is_shmem && PageDirty(page)) {
>> +		if (!is_shmem && (PageDirty(page) ||
>> +				  PageWriteback(page))) {
>>   			/*
>>   			 * khugepaged only works on read-only fd, so this
>>   			 * page is dirty because it hasn't been flushed
>> -- 
>> 2.27.0
>>
