Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63E3331058
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhCHOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:05:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:33926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhCHOEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:04:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D379ADDB;
        Mon,  8 Mar 2021 14:04:53 +0000 (UTC)
Date:   Mon, 8 Mar 2021 15:04:51 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YEYvAzPoaOkrsEaf@localhost.localdomain>
References: <20210304100002.7740-1-osalvador@suse.de>
 <20210304100002.7740-2-osalvador@suse.de>
 <830F715B-82B4-4A13-861F-B3A89327F722@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <830F715B-82B4-4A13-861F-B3A89327F722@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 10:16:36PM -0500, Zi Yan wrote:
> +Mike for hugetlb discussion.
> 
> Just thinking about how it might impact gigantic page allocation like hugetlb.
> When MHP_MEMMAP_ON_MEMORY is on, memmap pages are placed at the beginning
> of each hot added memory block, so available PFNs from two consecutive
> hot added memory blocks are not all contiguous, separated by memmap pages.
> If the memory block size is <= 1GB, there is no way of reserving gigantic
> pages for hugetlb during runtime using alloc_contig_pages from any hot
> added memory. Am I getting this right?

Yes, that is why it is stated both in boot parameter documentation and
patch changelog that this feature does not play well in those setups
where your workload is in need of large contiguous chunks of memory,
that being gigantic hugetlb or just normal memory.

> I see this implication is documented at the high level in patch 3. Just
> wonder if we want to be more specific. Or hugetlb is rarely used along
> with hot-add memory.

I think it is quite normal to see hugetlb and hotplug operations in the
same environment.
One thing excludes the other, just need to be careful when it comes to
potential pitfalls during offline operations.

I guess we could mention hugetlb pages in the documentation, if it feels
it is necesary.


-- 
Oscar Salvador
SUSE L3
