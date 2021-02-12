Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C037319C03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBLJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:41:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhBLJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613122790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJIh+57vZZX62sUHqf9Qg0OO0KLGj7Jhm7EDFFjgYrE=;
        b=bxSWt59IXe7Ph68jERmrp8ud+1hNqgsKdIFfEMhkrxDMjiOgbS4hOg4JEUdHM9yxleZSY+
        0esU68H67mH2u8XubGEln94mzlDqvlxpEA94VJakwlZq/yzphj1tg3LWmhk9tiqJ9FKLoh
        c4UjjRuOtyfyrjgEnWpTLly7X4AcdrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-s08ifoYOOVywTnddxRfoeQ-1; Fri, 12 Feb 2021 04:39:45 -0500
X-MC-Unique: s08ifoYOOVywTnddxRfoeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 185691936B66;
        Fri, 12 Feb 2021 09:39:44 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 298E65D74A;
        Fri, 12 Feb 2021 09:39:41 +0000 (UTC)
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org, will@kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
 <683c812a-ce3d-ef74-10d1-eaf8a3ae93d4@redhat.com>
 <fb562021-9981-4434-cc4a-e813a7752adb@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 0/3] mm/page_alloc: Fix pageblock_order with
 HUGETLB_PAGE_SIZE_VARIABLE
Message-ID: <cb92e4a0-47fc-f461-3189-a99142bbed4c@redhat.com>
Date:   Fri, 12 Feb 2021 10:39:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <fb562021-9981-4434-cc4a-e813a7752adb@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.21 08:02, Anshuman Khandual wrote:
> 
> On 2/11/21 2:07 PM, David Hildenbrand wrote:
>> On 11.02.21 07:22, Anshuman Khandual wrote:
>>> The following warning gets triggered while trying to boot a 64K page size
>>> without THP config kernel on arm64 platform.
>>>
>>> WARNING: CPU: 5 PID: 124 at mm/vmstat.c:1080 __fragmentation_index+0xa4/0xc0
>>> Modules linked in:
>>> CPU: 5 PID: 124 Comm: kswapd0 Not tainted 5.11.0-rc6-00004-ga0ea7d62002 #159
>>> Hardware name: linux,dummy-virt (DT)
>>> [    8.810673] pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
>>> [    8.811732] pc : __fragmentation_index+0xa4/0xc0
>>> [    8.812555] lr : fragmentation_index+0xf8/0x138
>>> [    8.813360] sp : ffff0000864079b0
>>> [    8.813958] x29: ffff0000864079b0 x28: 0000000000000372
>>> [    8.814901] x27: 0000000000007682 x26: ffff8000135b3948
>>> [    8.815847] x25: 1fffe00010c80f48 x24: 0000000000000000
>>> [    8.816805] x23: 0000000000000000 x22: 000000000000000d
>>> [    8.817764] x21: 0000000000000030 x20: ffff0005ffcb4d58
>>> [    8.818712] x19: 000000000000000b x18: 0000000000000000
>>> [    8.819656] x17: 0000000000000000 x16: 0000000000000000
>>> [    8.820613] x15: 0000000000000000 x14: ffff8000114c6258
>>> [    8.821560] x13: ffff6000bff969ba x12: 1fffe000bff969b9
>>> [    8.822514] x11: 1fffe000bff969b9 x10: ffff6000bff969b9
>>> [    8.823461] x9 : dfff800000000000 x8 : ffff0005ffcb4dcf
>>> [    8.824415] x7 : 0000000000000001 x6 : 0000000041b58ab3
>>> [    8.825359] x5 : ffff600010c80f48 x4 : dfff800000000000
>>> [    8.826313] x3 : ffff8000102be670 x2 : 0000000000000007
>>> [    8.827259] x1 : ffff000086407a60 x0 : 000000000000000d
>>> [    8.828218] Call trace:
>>> [    8.828667]  __fragmentation_index+0xa4/0xc0
>>> [    8.829436]  fragmentation_index+0xf8/0x138
>>> [    8.830194]  compaction_suitable+0x98/0xb8
>>> [    8.830934]  wakeup_kcompactd+0xdc/0x128
>>> [    8.831640]  balance_pgdat+0x71c/0x7a0
>>> [    8.832327]  kswapd+0x31c/0x520
>>> [    8.832902]  kthread+0x224/0x230
>>> [    8.833491]  ret_from_fork+0x10/0x30
>>> [    8.834150] ---[ end trace 472836f79c15516b ]---
>>>
>>> This warning comes from __fragmentation_index() when the requested order
>>> is greater than MAX_ORDER.
>>>
>>> static int __fragmentation_index(unsigned int order,
>>>                   struct contig_page_info *info)
>>> {
>>>           unsigned long requested = 1UL << order;
>>>
>>>           if (WARN_ON_ONCE(order >= MAX_ORDER)) <===== Triggered here
>>>                   return 0;
>>>
>>> Digging it further reveals that pageblock_order has been assigned a value
>>> which is greater than MAX_ORDER failing the above check. But why this
>>> happened ? Because HUGETLB_PAGE_ORDER for the given config on arm64 is
>>> greater than MAX_ORDER.
>>>
>>> The solution involves enabling HUGETLB_PAGE_SIZE_VARIABLE which would make
>>> pageblock_order a variable instead of constant HUGETLB_PAGE_ORDER. But that
>>> change alone also did not really work as pageblock_order still got assigned
>>> as HUGETLB_PAGE_ORDER in set_pageblock_order(). HUGETLB_PAGE_ORDER needs to
>>> be less than MAX_ORDER for its appropriateness as pageblock_order otherwise
>>> just fallback to MAX_ORDER - 1 as before. While here it also fixes a build
>>> problem via type casting MAX_ORDER in rmem_cma_setup().
>>
>> I'm wondering, is there any real value in allowing FORCE_MAX_ZONEORDER to be "11" with ARM64_64K_PAGES/ARM64_16K_PAGES?
> 
> MAX_ORDER should be as high as would be required for the current config.
> Unless THP is enabled, there is no need for it to be any higher than 11.
> But I might be missing historical reasons around this as well. Probably
> others from arm64 could help here.

Theoretically yes, practically no. If nobody cares about a 
configuration, no need to make the code more complicated for that 
configuration.

> 
>>
>> Meaning: are there any real use cases that actually build a kernel without TRANSPARENT_HUGEPAGE and with ARM64_64K_PAGES/ARM64_16K_PAGES?
> 
> THP is always optional. Besides kernel builds without THP should always
> be supported. Assuming that all builds will have THP enabled, might not
> be accurate.
> 
>>
>> As builds are essentially broken, I assume this is not that relevant? Or how long has it been broken?
> 
> Git blame shows that it's been there for some time now. But how does
> that make this irrelevant ? A problem should be fixed nonetheless.

When exactly did I say not to fix it? I'm saying if nobody uses it, we 
might be able to simplify.

> 
>>
>> It might be easier to just drop the "TRANSPARENT_HUGEPAGE" part from the FORCE_MAX_ZONEORDER config.
>>
> 
> Not sure if it would be a good idea to unnecessarily have larger MAX_ORDER
> value for a given config. But I might be missing other contexts here.

My point is: keep it simple if there is no need to make it complicated. 
If these arm64 variants are the only cases where we run into that issue 
and nobody uses them ("hat it's been there for some time now"), why make 
stuff complicated?

The current code seems to assume that HUGETLB_PAGE_ORDER <= MAX_ORDER. 
Instead of changing that for optimizing an unused use case (it is 
broken), just simplify the arm64 conditions. I'd even say add a

/*
  * Some code assumes that HUGETLB_PAGE_ORDER <= MAX_ORDER. For now, only
  * !TRANSPARENT_HUGEPAGE could lead in archs creating such setups.
  * Forbid it for now; anybody that has a valid use case has to sanitize
  * the code.
  */
BUILD_BUG_ON(HUGETLB_PAGE_ORDER <= MAX_ORDER);


But again, if there are valid use cases then sure, let's make the code 
fully compatible with HUGETLB_PAGE_ORDER > MAX_ORDER.


BTW: can we be sure that you caught all issues? For example:

#define COMPACTION_HPAGE_ORDER  HUGETLB_PAGE_ORDER

I'm not sure if it will work as expected if HUGETLB_PAGE_ORDER > 
MAX_ORDER ... fill_contig_page_info() will never find any suitable free 
blocks ...

-- 
Thanks,

David / dhildenb

