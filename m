Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8D33424D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhCJP7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:59:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:37494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232191AbhCJP7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:59:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19E5AAC1F;
        Wed, 10 Mar 2021 15:59:01 +0000 (UTC)
Date:   Wed, 10 Mar 2021 16:58:58 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
Message-ID: <20210310155843.GA14328@linux>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309001855.142453-1-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 04:18:52PM -0800, Mike Kravetz wrote:
> The concurrent use of multiple hugetlb page sizes on a single system
> is becoming more common.  One of the reasons is better TLB support for
> gigantic page sizes on x86 hardware.  In addition, hugetlb pages are
> being used to back VMs in hosting environments.
> 
> When using hugetlb pages to back VMs in such environments, it is
> sometimes desirable to preallocate hugetlb pools.  This avoids the delay
> and uncertainty of allocating hugetlb pages at VM startup.  In addition,
> preallocating huge pages minimizes the issue of memory fragmentation that
> increases the longer the system is up and running.
> 
> In such environments, a combination of larger and smaller hugetlb pages
> are preallocated in anticipation of backing VMs of various sizes.  Over
> time, the preallocated pool of smaller hugetlb pages may become
> depleted while larger hugetlb pages still remain.  In such situations,
> it may be desirable to convert larger hugetlb pages to smaller hugetlb
> pages.

Hi Mike,

The usecase sounds neat.

> 
> Converting larger to smaller hugetlb pages can be accomplished today by
> first freeing the larger page to the buddy allocator and then allocating
> the smaller pages.  However, there are two issues with this approach:
> 1) This process can take quite some time, especially if allocation of
>    the smaller pages is not immediate and requires migration/compaction.
> 2) There is no guarantee that the total size of smaller pages allocated
>    will match the size of the larger page which was freed.  This is
>    because the area freed by the larger page could quickly be
>    fragmented.
> 
> To address these issues, introduce the concept of hugetlb page demotion.
> Demotion provides a means of 'in place' splitting a hugetlb page to
> pages of a smaller size.  For example, on x86 one 1G page can be
> demoted to 512 2M pages.  Page demotion is controlled via sysfs files.
> - demote_size	Read only target page size for demotion

What about those archs where we have more than two hugetlb sizes?
IIRC, in powerpc you can have that, right?
If so, would it make sense for demote_size to be writable so you can pick
the size? 


> - demote	Writable number of hugetlb pages to be demoted

Below you mention that due to reservation, the amount of demoted pages can
be less than what the admin specified.
Would it make sense to have a place where someone can check how many pages got
actually demoted?
Or will this follow nr_hugepages' scheme and will always reflect the number of
current demoted pages?

> Only hugetlb pages which are free at the time of the request can be demoted.
> Demotion does not add to the complexity surplus pages.  Demotion also honors
> reserved huge pages.  Therefore, when a value is written to the sysfs demote
> file that value is only the maximum number of pages which will be demoted.
> It is possible fewer will actually be demoted.
> 
> If demote_size is PAGESIZE, demote will simply free pages to the buddy
> allocator.

Wrt. vmemmap discussion with David.
I also think we could compute how many vmemmap pages we are going to need to
re-shape the vmemmap layout and allocate those upfront.
And I think this approach would be just more simple.

I plan to have a look at the patches later today or tomorrow.

Thanks

-- 
Oscar Salvador
SUSE L3
