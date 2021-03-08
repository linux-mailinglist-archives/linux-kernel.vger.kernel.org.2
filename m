Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799F4331060
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhCHOHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:07:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhCHOG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615212418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63LYmPLrfJ8KifIgwmybBujkdfwC9STV33E842vx5Bs=;
        b=gODGu5fU+jLxAwETa6l46X2zeVNw6KJTUg8hjALxTa32vUFFRA4NJLDFzqtZsT4GbKprh9
        veEmbkLvuNPVRiP3md2p1+JwE3cuHSP6UBniI3BvheUw/bvGSiseWs7VdAhPU/HwEr2e9M
        aN1fytoxRM9xlAgF04MM6Pr99Y265ik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-NJVchPOqMbudJ4dpdgmFJQ-1; Mon, 08 Mar 2021 09:06:54 -0500
X-MC-Unique: NJVchPOqMbudJ4dpdgmFJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B37A51005D45;
        Mon,  8 Mar 2021 14:06:52 +0000 (UTC)
Received: from [10.36.113.123] (ovpn-113-123.ams2.redhat.com [10.36.113.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 758F650C0D;
        Mon,  8 Mar 2021 14:06:50 +0000 (UTC)
Subject: Re: [PATCH v3 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20210304100002.7740-1-osalvador@suse.de>
 <20210304100002.7740-2-osalvador@suse.de>
 <830F715B-82B4-4A13-861F-B3A89327F722@nvidia.com>
 <YEYvAzPoaOkrsEaf@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <51662b87-35bd-ff18-17dd-b2a99d1095d7@redhat.com>
Date:   Mon, 8 Mar 2021 15:06:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEYvAzPoaOkrsEaf@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.21 15:04, Oscar Salvador wrote:
> On Sun, Mar 07, 2021 at 10:16:36PM -0500, Zi Yan wrote:
>> +Mike for hugetlb discussion.
>>
>> Just thinking about how it might impact gigantic page allocation like hugetlb.
>> When MHP_MEMMAP_ON_MEMORY is on, memmap pages are placed at the beginning
>> of each hot added memory block, so available PFNs from two consecutive
>> hot added memory blocks are not all contiguous, separated by memmap pages.
>> If the memory block size is <= 1GB, there is no way of reserving gigantic
>> pages for hugetlb during runtime using alloc_contig_pages from any hot
>> added memory. Am I getting this right?
> 
> Yes, that is why it is stated both in boot parameter documentation and
> patch changelog that this feature does not play well in those setups
> where your workload is in need of large contiguous chunks of memory,
> that being gigantic hugetlb or just normal memory.
> 
>> I see this implication is documented at the high level in patch 3. Just
>> wonder if we want to be more specific. Or hugetlb is rarely used along
>> with hot-add memory.
> 
> I think it is quite normal to see hugetlb and hotplug operations in the
> same environment.
> One thing excludes the other, just need to be careful when it comes to
> potential pitfalls during offline operations.
> 
> I guess we could mention hugetlb pages in the documentation, if it feels
> it is necesary.

Runtime allocation of gigantic pages without CMA is absolutely 
unreliable either way. IMHO, a tunable for the admin is good enough.

-- 
Thanks,

David / dhildenb

