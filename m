Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70BC41D14F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhI3CQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:16:15 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:51706 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232383AbhI3CQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:16:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uq4fOIK_1632968067;
Received: from 30.240.97.26(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Uq4fOIK_1632968067)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Sep 2021 10:14:28 +0800
Message-ID: <af7b28df-8021-bf2c-79b3-beb58f9dc97b@linux.alibaba.com>
Date:   Thu, 30 Sep 2021 10:14:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0)
 Gecko/20100101 Thunderbird/93.0
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Content-Language: en-US
To:     Song Liu <song@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
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
Yes, I'd like to.
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
Learned something, Thanks!

But, the race between collapse_file and truncate_pagecache, I am not 
sure whether it exists or not. If exists, whether this patch only can 
fix truncate_pagecache concurrent?

Anyway, I will run more tests on it at first.

Thanks!
>                          truncate_pagecache(inode, 0);
> +                       filemap_invalidate_unlock(inode->i_mapping);
> +               }
>          }
> 
>          return 0;
> 
