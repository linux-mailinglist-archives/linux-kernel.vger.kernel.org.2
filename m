Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79741F95B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 04:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhJBCYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 22:24:13 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:50765 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232278AbhJBCYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 22:24:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UqFeYLV_1633141344;
Received: from 192.168.31.179(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UqFeYLV_1633141344)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Oct 2021 10:22:25 +0800
Message-ID: <635ae57e-454e-0ef9-784d-3736b3bf44ac@linux.alibaba.com>
Date:   Sat, 2 Oct 2021 10:22:23 +0800
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
References: <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
 <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org>
 <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <67906bf5-4de9-8433-3d70-cc8fc5cc2347@linux.alibaba.com>
 <CAPhsuW4_-ju9QgB7J4imrhQvH6ZqoOkVtVOVX11Yk_ZRakwQ+A@mail.gmail.com>
 <3d264ed9-f8fd-60d4-7125-f9f745ebeb52@google.com>
 <YVXXq0ssvW6P525J@casper.infradead.org>
 <f889db88-7b7d-ddb0-a7ed-3eda85d3eb96@google.com>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <f889db88-7b7d-ddb0-a7ed-3eda85d3eb96@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/21 12:49 AM, Hugh Dickins wrote:
> On Thu, 30 Sep 2021, Matthew Wilcox wrote:
>> On Wed, Sep 29, 2021 at 10:24:44PM -0700, Hugh Dickins wrote:
>>>
>>> Aside from the above page->index mischeck in find_lock_entries(),
>>> I now think this bug needs nothing more than simply removing the
>>> VM_BUG_ON_PAGE(PageTail(page), page) from truncate_inode_page().
>>
>> I don't think that's right.  This bug was also observed when calling
>> truncate(), so there's clearly a situation where two concurrent calls
>> to truncate_pagecache() leaves a THP in the cache.
> 
> I assume you're thinking of one of the fuzzer blkdev ones:
> https://lore.kernel.org/linux-mm/CACkBjsbtF_peC7N_4mRfHML_BeiPe+O9DahTfr84puSG_J9rcQ@mail.gmail.com/
> or
> https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/
> 
> I haven't started on those ones yet: yes, I imagine one or both of those
> will need a further fix (S_ISREG() check somewhere if we're lucky; but
> could well be nastier); but for the bug in this thread, I expect
> removing the VM_BUG_ON_PAGE(PageTail) to be enough.
Thanks for your advices!

I'm so sorry that delay the test due to my recent vacation. I plan to 
start further test tomorrow. I think removing the 
VM_BUG_ON_PAGE(PageTail) is a good idea, but also think using 
filemap_invalidate_lock is safer and necessary. And of course, this is 
just my own view! So, now, I tend to use filemap_invalidate_lock and
either check page mapping again or remove VM_BUG_ON_PAGE(PageTail).

Anyway, I will run more tests and then give feedback.

Thanks!
> 
> If you're thinking of something else, please send a link if you can - thanks.
> 
> Hugh
> 
