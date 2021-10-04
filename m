Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A37421523
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhJDR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:28:45 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:41313 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234027AbhJDR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:28:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UqagJ8d_1633368411;
Received: from 30.25.232.32(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UqagJ8d_1633368411)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Oct 2021 01:26:52 +0800
Message-ID: <8d8fb192-bd8d-8a08-498d-ca7204d4a716@linux.alibaba.com>
Date:   Tue, 5 Oct 2021 01:26:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0)
 Gecko/20100101 Thunderbird/93.0
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Content-Language: en-US
To:     Song Liu <song@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <CAPhsuW7tDh2cbA6QpZ993fuwOK=LKVsDYjymA4983riQw4QTkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have run our cases these two days to stress test new Patch #1. The new 
Patch #1 mainly add filemap_invalidate_{un}lock before and after 
truncate_pagecache(), basing on original Patch #1. And the crash has not 
happened.

Now, I keep the original Patch #1, then adding the code below which 
suggested by liu song (I'm not sure which one I should add in the next 
version, Suggested-by or Signed-off-by? If you know, please remind me).

-               if (filemap_nr_thps(inode->i_mapping))
+               if (filemap_nr_thps(inode->i_mapping)) {
+                       filemap_invalidate_lock(inode->i_mapping);
                         truncate_pagecache(inode, 0);
+                       filemap_invalidate_unlock(inode->i_mapping);
+               }

And the reason for keeping the original Patch #1 is mainly to fix the 
race between collapse_file and truncate_pagecache. It seems necessary. 
Despite the two-day test, I did not reproduce this race any more.

In addition, I also test the below method:

diff --git a/mm/truncate.c b/mm/truncate.c
index 3f47190f98a8..33604e4ce60a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -210,8 +210,6 @@ invalidate_complete_page(struct address_space 
*mapping, struct page *page)

  int truncate_inode_page(struct address_space *mapping, struct page *page)
  {
-       VM_BUG_ON_PAGE(PageTail(page), page);
-
         if (page->mapping != mapping)
                 return -EIO;

I am not very sure this VM_BUG_ON_PAGE(PageTail) is what Hugh means. And
the test results show that only removing this VM_BUG_ON_PAGE(PageTail) 
has no effect. So, I still keep the original Patch #1 to fix one race.

I plan to send Patch v3 after receiving your reply.

Thanks!

On 9/30/21 8:41 AM, Song Liu wrote:
> On Wed, Sep 29, 2021 at 5:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Wed, Sep 29, 2021 at 04:41:48PM -0700, Song Liu wrote:
>>> The issue is NOT caused by concurrent khugepaged:collapse_file() and
>>> truncate_pagecache(inode, 0). With some printks, we can see a clear
>>> time gap (>2 second )  between collapse_file() finishes, and
>>> truncate_pagecache() (which crashes soon). Therefore, my earlier
>>> suggestion that adds deny_write_access() to collapse_file() does NOT
>>> work.
>>>
>>> The crash is actually caused by concurrent truncate_pagecache(inode, 0).
>>> If I change the number of write thread in stress_madvise_dso.c to one,
>>> (IOW, one thread_read and one thread_write), I cannot reproduce the
>>> crash anymore.
>>>
>>> I think this means we cannot fix this issue in collapse_file(), because it
>>> finishes long before the crash.
>>
>> Ah!  So are we missing one or more of these locks:
>>
>>          inode_lock(inode);
>>          filemap_invalidate_lock(mapping);
>>
>> in the open path?
> 
> The following fixes the crash in my test. But I am not sure whether this is the
> best fix.
> 
> Rongwei, could you please run more tests on it?
> 
> Thanks,
> Song
> 
> 
> diff --git i/fs/open.c w/fs/open.c
> index daa324606a41f..d13c4668b2e53 100644
> --- i/fs/open.c
> +++ w/fs/open.c
> @@ -856,8 +856,11 @@ static int do_dentry_open(struct file *f,
>                   * of THPs into the page cache will fail.
>                   */
>                  smp_mb();
> -               if (filemap_nr_thps(inode->i_mapping))
> +               if (filemap_nr_thps(inode->i_mapping)) {
> +                       filemap_invalidate_lock(inode->i_mapping);
>                          truncate_pagecache(inode, 0);
> +                       filemap_invalidate_unlock(inode->i_mapping);
> +               }
>          }
> 
>          return 0;
> 
