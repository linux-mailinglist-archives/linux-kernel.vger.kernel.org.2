Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1417325F46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhBZIl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:41:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:43260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhBZIjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:39:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614328716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ryNEoNrCU7SPStlbI4pZYs4/RAqN6mJpaGrcrqsuyT4=;
        b=kqPUtCnkz5X8zHmu2iF/9P7RwnnGl9g+rV3GmSwWupGNXw4KeotqBW8boZs9DRfQQBiRkU
        K7tFA/9V6arLBwUVYQ2y7PFEcQgvShArJDBV25WFz6zXgHG7bwx/t7iuS+vwk2BTa9eUeQ
        YYfXd+Ejq+sv20lqhpzXCaH8B4zzm1U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68A12AAAE;
        Fri, 26 Feb 2021 08:38:36 +0000 (UTC)
Date:   Fri, 26 Feb 2021 09:38:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YDizi3/TKYnSi5Zo@dhcp22.suse.cz>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-2-osalvador@suse.de>
 <YDiyvQ2SCXxCjPJ2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDiyvQ2SCXxCjPJ2@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-02-21 09:35:10, Michal Hocko wrote:
> On Mon 22-02-21 14:51:36, Oscar Salvador wrote:
> > alloc_contig_range will fail if it ever sees a HugeTLB page within the
> > range we are trying to allocate, even when that page is free and can be
> > easily reallocated.
> > This has proved to be problematic for some users of alloc_contic_range,
> > e.g: CMA and virtio-mem, where those would fail the call even when those
> > pages lay in ZONE_MOVABLE and are free.
> > 
> > We can do better by trying to replace such page.
> > 
> > Free hugepages are tricky to handle so as to no userspace application
> > notices disruption, we need to replace the current free hugepage with
> > a new one.
> > 
> > In order to do that, a new function called alloc_and_dissolve_huge_page
> > is introduced.
> > This function will first try to get a new fresh hugepage, and if it
> > succeeds, it will replace the old one in the free hugepage pool.
> > 
> > All operations are being handled under hugetlb_lock, so no races are
> > possible. The only exception is when page's refcount is 0, but it still
> > has not been flagged as PageHugeFreed.
> 
> I think it would be helpful to call out that specific case explicitly
> here. I can see only one scenario (are there more?)
> __free_huge_page()		isolate_or_dissolve_huge_page
> 				  PageHuge() == T
> 				  alloc_and_dissolve_huge_page
> 				    alloc_fresh_huge_page()
> 				    spin_lock(hugetlb_lock)
> 				    // PageHuge() && !PageHugeFreed &&
> 				    // !PageCount()
> 				    spin_unlock(hugetlb_lock)
>   spin_lock(hugetlb_lock)
>   1) update_and_free_page
>        PageHuge() == F
>        __free_pages()
>   2) enqueue_huge_page
>        SetPageHugeFreed()
>   spin_unlock(&hugetlb_lock)			    
> 
> > In this case we retry as the window race is quite small and we have high
> > chances to succeed next time.
> > 
> > With regard to the allocation, we restrict it to the node the page belongs
> > to with __GFP_THISNODE, meaning we do not fallback on other node's zones.
> > 
> > Note that gigantic hugetlb pages are fenced off since there is a cyclic
> > dependency between them and alloc_contig_range.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Thanks this looks much better than the initial version. One nit below.
> Acked-by: Michal Hocko <mhocko@suse.com>

Btw. if David has some numbers it would be great to add them to the
changelog.
-- 
Michal Hocko
SUSE Labs
