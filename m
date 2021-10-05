Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4938A42219E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhJEJFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:05:06 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:46038 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233490AbhJEJFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:05:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UqdvfmN_1633424581;
Received: from 30.25.232.89(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UqdvfmN_1633424581)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Oct 2021 17:03:01 +0800
Message-ID: <847363b1-1b31-dcc8-6d6c-7b5d8a6d1972@linux.alibaba.com>
Date:   Tue, 5 Oct 2021 17:03:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0)
 Gecko/20100101 Thunderbird/93.0
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
References: <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com>
 <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
 <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org>
 <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <YVT+KWFA8hfSKU+m@casper.infradead.org>
 <CAPhsuW7tDh2cbA6QpZ993fuwOK=LKVsDYjymA4983riQw4QTkA@mail.gmail.com>
 <8d8fb192-bd8d-8a08-498d-ca7204d4a716@linux.alibaba.com>
 <d2776967-bb9f-985b-6d38-d1d1dc83cd7b@google.com>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <d2776967-bb9f-985b-6d38-d1d1dc83cd7b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/21 10:58 AM, Hugh Dickins wrote:
> On Tue, 5 Oct 2021, Rongwei Wang wrote:
> 
>> Hi,
>> I have run our cases these two days to stress test new Patch #1. The new Patch
>> #1 mainly add filemap_invalidate_{un}lock before and after
>> truncate_pagecache(), basing on original Patch #1. And the crash has not
>> happened.
>>
>> Now, I keep the original Patch #1, then adding the code below which suggested
>> by liu song (I'm not sure which one I should add in the next version,
>> Suggested-by or Signed-off-by? If you know, please remind me).
>>
>> -               if (filemap_nr_thps(inode->i_mapping))
>> +               if (filemap_nr_thps(inode->i_mapping)) {
>> +                       filemap_invalidate_lock(inode->i_mapping);
>>                          truncate_pagecache(inode, 0);
>> +                       filemap_invalidate_unlock(inode->i_mapping);
>> +               }
> 
> I won't NAK that patch; but I still believe it's unnecessary, and don't
> see how it protects against all the races (collapse_file() does not use
> that lock, whereas collapse_file() does use page lock).  And if you're
> hoping to fix 5.10, then you will have to backport those invalidate_lock
> patches there too (they're really intended to protect hole-punching).
> 
>>
>> And the reason for keeping the original Patch #1 is mainly to fix the race
>> between collapse_file and truncate_pagecache. It seems necessary. Despite the
>> two-day test, I did not reproduce this race any more.
>>
>> In addition, I also test the below method:
>>
>> diff --git a/mm/truncate.c b/mm/truncate.c
>> index 3f47190f98a8..33604e4ce60a 100644
>> --- a/mm/truncate.c
>> +++ b/mm/truncate.c
>> @@ -210,8 +210,6 @@ invalidate_complete_page(struct address_space *mapping,
>> struct page *page)
>>
>>   int truncate_inode_page(struct address_space *mapping, struct page *page)
>>   {
>> -       VM_BUG_ON_PAGE(PageTail(page), page);
>> -
>>          if (page->mapping != mapping)
>>                  return -EIO;
>>
>> I am not very sure this VM_BUG_ON_PAGE(PageTail) is what Hugh means. And
>> the test results show that only removing this VM_BUG_ON_PAGE(PageTail) has no
>> effect. So, I still keep the original Patch #1 to fix one race.
> 
> Yes, that's exactly what I meant, and thank you for intending to try it.
> 
> But if that patch had "no effect", then I think you were not running the
> kernel with that patch applied: because it deletes the BUG on line 213
> of mm/truncate.c, which is what you reported in the first mail!
> 
> Or, is line 213 of mm/truncate.c in your 5.10.46-hugetext+ kernel
> something else?  I've been looking at 5.15-rc.
Hi, Hugh

I'm sorry the confusing '5.10.46-hugetext+'. I am also look and test at 
5.15-rc.
> 
> But I wasn't proposing to delete it merely to hide the BUG: as I hope
> I explained, we could move it below the page->mapping check, but it
> wouldn't really be of any value there since tails have NULL page->mapping
> anyway (well, I didn't check first and second tails, maybe mapping gets
> reused for some compound page field in those). I was proposing to delete
> it because the page->mapping check then weeds out the racy case once
> we're holding page lock, without the need for adding anything special.
> 
> Hugh
Today, I try again to create some cases to reproduce the race, such as 
ensuring that multiple processes are always executing 
‘truncate_pagecache’ and only mapping 2M DSO. In this way, I try to 
ensure that the target of 'collapse_file' and 'truncate_pagecache' can 
only be the same VMA, to increase the probability of reproducing that 
race. But, I can't reproduce that race any more.

In fact, according to the previous experience, the current number of 
attempts should be able to reproduce that race.

If you have the idea about creating this case, please tell me, and I can 
try again. Or we can solve it when it appears again.

Thanks!
> 
