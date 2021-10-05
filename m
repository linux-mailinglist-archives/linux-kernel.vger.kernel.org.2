Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89D1421C41
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhJECAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:00:36 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:58381 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229568AbhJECAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:00:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UqcME4E_1633399122;
Received: from 30.25.244.41(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UqcME4E_1633399122)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Oct 2021 09:58:43 +0800
Message-ID: <9bde2c4c-de26-442c-0a1c-799954440c77@linux.alibaba.com>
Date:   Tue, 5 Oct 2021 09:58:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0)
 Gecko/20100101 Thunderbird/93.0
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Song Liu <song@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
References: <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
 <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org>
 <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <YVT+KWFA8hfSKU+m@casper.infradead.org>
 <CAPhsuW7tDh2cbA6QpZ993fuwOK=LKVsDYjymA4983riQw4QTkA@mail.gmail.com>
 <8d8fb192-bd8d-8a08-498d-ca7204d4a716@linux.alibaba.com>
 <YVtQZ1vxhe/W+adm@casper.infradead.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <YVtQZ1vxhe/W+adm@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/21 3:05 AM, Matthew Wilcox wrote:
> On Tue, Oct 05, 2021 at 01:26:50AM +0800, Rongwei Wang wrote:
>> Hi,
>> I have run our cases these two days to stress test new Patch #1. The new
>> Patch #1 mainly add filemap_invalidate_{un}lock before and after
>> truncate_pagecache(), basing on original Patch #1. And the crash has not
>> happened.
> 
> You shouldn't need most of patch 1.
> 
> In fact, the only two patches you should need would be this:
> 
> +++ b/mm/filemap.c
> @@ -2093,7 +2093,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
>                  if (!xa_is_value(page)) {
>                          if (page->index < start)
>                                  goto put;
> -                       VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
>                          if (page->index + thp_nr_pages(page) - 1 > end)
>                                  goto put;
>                          if (!trylock_page(page))
> 
> (already in Andrew's tree) and:
> 
>> -               if (filemap_nr_thps(inode->i_mapping))
>> +               if (filemap_nr_thps(inode->i_mapping)) {
>> +                       filemap_invalidate_lock(inode->i_mapping);
>>                          truncate_pagecache(inode, 0);
>> +                       filemap_invalidate_unlock(inode->i_mapping);
>> +               }
> 
> If you can still hit a bug with just those two patches, then something
> else is going wrong, and needs to be investigated.
OK, I see what your mean. I will send Patch v3 and only keep 
filemap_invalidate_{un}lock in Patch #1.

Thanks!
> 
