Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1BB41D127
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347693AbhI3Bzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:55:50 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:39470 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347583AbhI3Bzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:55:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uq44vIu_1632966844;
Received: from 30.240.97.26(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Uq44vIu_1632966844)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Sep 2021 09:54:05 +0800
Message-ID: <67906bf5-4de9-8433-3d70-cc8fc5cc2347@linux.alibaba.com>
Date:   Thu, 30 Sep 2021 09:54:04 +0800
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
References: <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
 <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com>
 <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
 <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org>
 <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/21 7:41 AM, Song Liu wrote:
> On Wed, Sep 29, 2021 at 10:56 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
> [...]
>>> Now, I am able to crash the system on
>>>      find_lock_entries () {
>>>       ...
>>>         VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
>>>      }
>>> I guess it is related. I will test more.
>>
>> That's a bogus VM_BUG_ON.  I have a patch in my tree to delete it.
>> Andrew has it too, but for some reason, he hasn't sent it on to Linus.
>>
>> +++ b/mm/filemap.c
>> @@ -2093,7 +2093,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
>>                  if (!xa_is_value(page)) {
>>                          if (page->index < start)
>>                                  goto put;
>> -                       VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
>>                          if (page->index + thp_nr_pages(page) - 1 > end)
>>                                  goto put;
>>                          if (!trylock_page(page))
> 
> Yes, after removing this line, I am able to see the same bug.
> 
> Here is my finding so far:
> 
> The issue is NOT caused by concurrent khugepaged:collapse_file() and
> truncate_pagecache(inode, 0). With some printks, we can see a clear
> time gap (>2 second )  between collapse_file() finishes, and
> truncate_pagecache() (which crashes soon). Therefore, my earlier
> suggestion that adds deny_write_access() to collapse_file() does NOT
> work.
> 
> The crash is actually caused by concurrent truncate_pagecache(inode, 0).
> If I change the number of write thread in stress_madvise_dso.c to one,
> (IOW, one thread_read and one thread_write), I cannot reproduce the
> crash anymore.
Whether CONFIG_DEBUG_VM is enabled in your vm?

I think the second possibility mentioned above will been found if you 
enable CONFIG_DEBUG_VM:

1) multiple writers truncate the same page cache concurrently;
2) collapse_file rolls back when writer truncates the page cache;

The following log will be print after enable CONFIG_DEBUG_VM:

[22216.789904]  do_idle+0xb4/0x104
[22216.789906]  cpu_startup_entry+0x34/0x9c
[22216.790144] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 
0.0.0 02/06/2015
[22216.790553]  secondary_start_kernel+0x104/0x180
[22216.790778] Call trace:
[22216.791300] Code: d4210000 b0006161 910d4021 94013b45 (d4210000)
[22216.791662]  dump_backtrace+0x0/0x1ec
[22216.791664]  show_stack+0x24/0x30
[22216.791956] ---[ end trace dc769a61c1af087b ]---
[22216.792295]  dump_stack+0xd0/0x128
[22216.792299]  bad_page+0xe4/0x110
[22216.792579] Kernel panic - not syncing: Oops - BUG: Fatal exception 
in interrupt
[22216.792937]  check_free_page_bad+0x84/0x90
[22216.792940]  free_pcp_prepare+0x1fc/0x21c
[22216.793253] SMP: stopping secondary CPUs
[22216.793525]  free_unref_page+0x2c/0xec
[22216.805537]  __put_page+0x60/0x70
[22216.805931]  collapse_file+0xdc8/0x12f0
[22216.806385]  khugepaged_scan_file+0x2dc/0x37c
[22216.806900]  khugepaged_scan_mm_slot+0x2e0/0x380
[22216.807450]  khugepaged_do_scan+0x2dc/0x2fc
[22216.807946]  khugepaged+0x38/0x100
[22216.808342]  kthread+0x11c/0x120
[22216.808735] Kernel Offset: disabled
[22216.809153] CPU features: 0x0040002,62208238
[22216.809681] Memory Limit: none
[22216.813477] Starting crashdump kernel...

So I think the race also exists between collapse_file and 
truncate_pagecache.

> 
> I think this means we cannot fix this issue in collapse_file(), because it
> finishes long before the crash.
> 
> Thanks,
> Song
> 
