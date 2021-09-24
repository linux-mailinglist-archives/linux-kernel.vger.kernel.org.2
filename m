Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75918416A74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbhIXDhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:37:13 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48518 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243927AbhIXDhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:37:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UpOFCZC_1632454534;
Received: from 30.240.96.158(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UpOFCZC_1632454534)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Sep 2021 11:35:35 +0800
Message-ID: <60cf45a1-53c9-d9d8-efda-c9ccbe08c65f@linux.alibaba.com>
Date:   Fri, 24 Sep 2021 11:35:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0)
 Gecko/20100101 Thunderbird/93.0
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        song@kernel.org, william.kucharski@oracle.com,
        Hugh Dickins <hughd@google.com>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
 <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/21 10:43 AM, Andrew Morton wrote:
> On Thu, 23 Sep 2021 01:04:54 +0800 Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:
>
>>
>>> On Sep 22, 2021, at 7:37 PM, Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
>>>> Transparent huge page has supported read-only non-shmem files. The file-
>>>> backed THP is collapsed by khugepaged and truncated when written (for
>>>> shared libraries).
>>>>
>>>> However, there is race in two possible places.
>>>>
>>>> 1) multiple writers truncate the same page cache concurrently;
>>>> 2) collapse_file rolls back when writer truncates the page cache;
>>> As I've said before, the bug here is that somehow there is a writable fd
>>> to a file with THPs.  That's what we need to track down and fix.
>> Hi, Matthew
>> I am not sure get your means. We know “mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs"
>> Introduced file-backed THPs for DSO. It is possible {very rarely} for DSO to be opened in writeable way.
>>
>> ...
>>
>>> https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradead.org/
>> All in all, what you mean is that we should solve this race at the source?
> Matthew is being pretty clear here: we shouldn't be permitting
> userspace to get a writeable fd for a thp-backed file.
>
> Why are we permitting the DSO to be opened writeably?  If there's a
> legitimate case for doing this then presumably "mm, thp: relax the

Hi, we have written a user case to trigger this race mentioned above. 
this case just create one reader

to open DSO in RDONLY mode, and keep making the mapping page of DSO use 
huge pages by madvise,

then multiple writer to open and write the same DSO.

I will send it later after simple adjust.

Thanks

> VM_DENYWRITE constraint on file-backed THPs: should be fixed or
> reverted.
>
> If there is no legitimate use case for returning a writeable fd for a
> thp-backed file then we should fail such an attempt at open().  This
> approach has back-compatibility issues which need to be thought about.
> Perhaps we should permit the open-writeably attempt to appear to
> succeed, but to really return a read-only fd?
