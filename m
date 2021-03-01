Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC932806F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhCAONi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:13:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236254AbhCAOLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614607772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ri9XDuJqxC9BSq44voletKdjAlrsHvrvulgnxCXLswI=;
        b=JsJdpMeilWOvnC2pI4V1f7vJ/JaUEoYHMYQYnx2LHMDOifU239uF0s6TVh74ZOqxlQDIm/
        mELvi7oZ2M6cqF9y3QSLMh9XzBLB8niwwWctbcKZ4eA38dnJ5VMCGdXleiKZW+o+EupLhV
        bLDXGO7/j1yG7qhmb3uoIpiG8yGTZfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-YKLDpw9JOCe6-C14jCxYpw-1; Mon, 01 Mar 2021 09:09:31 -0500
X-MC-Unique: YKLDpw9JOCe6-C14jCxYpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7DC5189C2A9;
        Mon,  1 Mar 2021 14:09:09 +0000 (UTC)
Received: from [10.36.114.87] (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD81A5B4A7;
        Mon,  1 Mar 2021 14:09:07 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <3f071dd4-3181-f4e0-fd56-1a70f6ac72fe@redhat.com>
Date:   Mon, 1 Mar 2021 15:09:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222135137.25717-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.21 14:51, Oscar Salvador wrote:
> alloc_contig_range will fail if it ever sees a HugeTLB page within the
> range we are trying to allocate, even when that page is free and can be
> easily reallocated.
> This has proved to be problematic for some users of alloc_contic_range,
> e.g: CMA and virtio-mem, where those would fail the call even when those
> pages lay in ZONE_MOVABLE and are free.
> 
> We can do better by trying to replace such page.
> 
> Free hugepages are tricky to handle so as to no userspace application
> notices disruption, we need to replace the current free hugepage with
> a new one.
> 
> In order to do that, a new function called alloc_and_dissolve_huge_page
> is introduced.
> This function will first try to get a new fresh hugepage, and if it
> succeeds, it will replace the old one in the free hugepage pool.
> 
> All operations are being handled under hugetlb_lock, so no races are
> possible. The only exception is when page's refcount is 0, but it still
> has not been flagged as PageHugeFreed.
> In this case we retry as the window race is quite small and we have high
> chances to succeed next time.
> 
> With regard to the allocation, we restrict it to the node the page belongs
> to with __GFP_THISNODE, meaning we do not fallback on other node's zones.
> 
> Note that gigantic hugetlb pages are fenced off since there is a cyclic
> dependency between them and alloc_contig_range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   include/linux/hugetlb.h |   6 +++
>   mm/compaction.c         |  12 ++++++
>   mm/hugetlb.c            | 111 +++++++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 127 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index b5807f23caf8..72352d718829 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -505,6 +505,7 @@ struct huge_bootmem_page {
>   	struct hstate *hstate;
>   };
>   
> +bool isolate_or_dissolve_huge_page(struct page *page);
>   struct page *alloc_huge_page(struct vm_area_struct *vma,
>   				unsigned long addr, int avoid_reserve);
>   struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> @@ -775,6 +776,11 @@ void set_page_huge_active(struct page *page);
>   #else	/* CONFIG_HUGETLB_PAGE */
>   struct hstate {};
>   
> +static inline bool isolate_or_dissolve_huge_page(struct page *page)
> +{
> +	return false;
> +}
> +
>   static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
>   					   unsigned long addr,
>   					   int avoid_reserve)
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 190ccdaa6c19..d52506ed9db7 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -905,6 +905,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   			valid_page = page;
>   		}
>   
> +		if (PageHuge(page) && cc->alloc_contig) {
> +			if (!isolate_or_dissolve_huge_page(page))
> +				goto isolate_fail;


So, the callchain is:

alloc_contig_range()->__alloc_contig_migrate_range()->isolate_migratepages_range()->isolate_migratepages_block()

The case I am thinking about is if we run out of memory and would return 
-ENOMEM from alloc_and_dissolve_huge_page(). We silently drop the real 
error (e.g., -ENOMEM vs. -EBUSY vs. e.g., -EAGAIN) we had in 
isolate_or_dissolve_huge_page().


I think we should not swallo such return values in 
isolate_or_dissolve_huge_page() and instead properly report esp. -ENOMEM 
properly up this callchain now. Otherwise we'll end up retrying / 
reporting -EBUSY, which is misleading.

 From isolate_migratepages_range()/isolate_migratepages_block() we'll 
keep reporting "pfn > 0".

a) In isolate_migratepages_range() we'll keep iterating over pageblocks 
although we should just fail with -ENOMEM right away.

b) In __alloc_contig_migrate_range() we'll keep retrying up to 5 times 
although we should just fail with -ENOMEM. We end up returning "-EBUSY" 
after retrying.

c) In alloc_contig_range() we'll continue trying to isolate although we 
should just return -ENOMEM.


I think we have should start returning proper errors from 
isolate_migratepages_range()/isolate_migratepages_block() on critical 
issues (-EINTR, -ENOMEM) instead of going via "!pfn vs. pfn" and 
retrying on "pfn".

So we should then fail with -ENOMEM during isolate_migratepages_range() 
cleanly, just as we would do when we get -ENOMEM during migrate_pages().



-- 
Thanks,

David / dhildenb

