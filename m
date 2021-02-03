Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6F30DD2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhBCOs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:48:28 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:13543 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhBCOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612363705; x=1643899705;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Svcsvzf3Ng+V+7E2OJ6vov2g0Z2eg1nQgvarWUEuu8Q=;
  b=t+7DlkEvYP6ZDoMzReHtNlWTAES6Pu9OZBIJfgPU3XJnoofCnBkWnntT
   RV+UR8EqDcD1nU6nDHq7ZcS2i9cPk5HohgzZ5Iudp4W/eAxdOjQhQXKVJ
   XTGFqJkP/rimKztoxuasezoM3eVfbnVbb1KL4yiSkAcvGXQ2p/0wf0h1d
   U=;
X-IronPort-AV: E=Sophos;i="5.79,398,1602547200"; 
   d="scan'208";a="79457428"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 03 Feb 2021 14:47:37 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id BFE1F240BE6;
        Wed,  3 Feb 2021 14:47:32 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.244) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 14:47:24 +0000
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <aarcange@redhat.com>, <akpm@linux-foundation.org>,
        <gokhale2@llnl.gov>, <hch@lst.de>, <jack@suse.cz>,
        <jannh@google.com>, <jhubbard@nvidia.com>, <kirill@shutemov.name>,
        <ktkhai@virtuozzo.com>, <leonro@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <mcfadden8@llnl.gov>, <oleg@redhat.com>, <peterx@redhat.com>,
        <torvalds@linux-foundation.org>, <wzam@amazon.com>,
        <yang.shi@linux.alibaba.com>
References: <20210202171327.GN4718@ziepe.ca>
 <20210203124358.59017-1-galpress@amazon.com> <20210203140015.GP4718@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <e2f897f8-b6af-0d4a-6a69-b47da5564165@amazon.com>
Date:   Wed, 3 Feb 2021 16:47:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203140015.GP4718@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.244]
X-ClientProxiedBy: EX13D27UWB001.ant.amazon.com (10.43.161.169) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 16:00, Jason Gunthorpe wrote:
> On Wed, Feb 03, 2021 at 02:43:58PM +0200, Gal Pressman wrote:
>>> On Tue, Feb 02, 2021 at 12:05:36PM -0500, Peter Xu wrote:
>>>
>>>>> Gal, you could also MADV_DONTFORK this range if you are explicitly
>>>>> allocating them via special mmap.
>>>>
>>>> Yeah I wanted to mention this one too but I just forgot when reply: the issue
>>>> thread previously pasted smells like some people would like to drop
>>>> MADV_DONTFORK, but if it's able to still be applied I don't know why
>>>> not..
>>>
>>> I want to drop the MADV_DONTFORK for dynamic data memory allocated by
>>> the application layers (eg with malloc) without knowledge of how they
>>> will be used.
>>>
>>> This case is a buffer internal to the communication system that we
>>> know at allocation time how it will be used; so an explicit,
>>> deliberate, MADV_DONTFORK is fine
>>
>> We are referring to libfabric's bounce buffers, correct?
>> Libfabric could be considered as the "app" here, it's not clear why these
>> buffers should be DONTFORK'd before ibv_reg_mr() but others don't.
> 
> I assumed they were internal to the EFA code itself.

The hugepages allocation is part of libfabric generic bufpool implementation:
https://github.com/ofiwg/libfabric/blob/cde8665ca5ec2fb957260490d0c8700d8ac69863/include/linux/osd.h#L64

I guess we could madvise them at the libfabric provider's layer.

>> Anyway, it should be simple enough to madvise them after allocation, although I
>> think it's part of libfabric's generic code (which isn't necessarily used on
>> top of rdma-core).
> 
> Ah, so that is a reasonable justification for wanting to fix this in
> the kernel..
> 
> Lets give Peter some time first.
> 
> The other direction to validate this approach is to remove the
> MAP_HUGETLB flags and rely on THP instead, and/or mark them as
> MAP_SHARED.
> 
> I'm not sure generic code should be use using MAP_HUGETLB..

It's using MAP_HUGETLB but has a fallback in case it fails:

		ret = ofi_alloc_hugepage_buf((void **) &buf_region->alloc_region,
					     pool->alloc_size);
		/* If we can't allocate huge pages, fall back to normal
		 * allocations for all future attempts.
		 */
		if (ret) {
			pool->attr.flags &= ~OFI_BUFPOOL_HUGEPAGES;
			goto retry;
		}
		buf_region->flags = OFI_BUFPOOL_HUGEPAGES;


> This would be enough to confirm that everything else is working as
> expected
Agree.
