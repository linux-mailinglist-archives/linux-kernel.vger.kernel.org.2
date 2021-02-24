Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F543239CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhBXJq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:46:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:39132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234800AbhBXJoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:44:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614159811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EdANJnLlcHdxyT/mwFy+OimQhvEQG9gfr4G0prGzmwI=;
        b=Xsev2XBNSB8PqSBtco9KgKVJSEIwz9tqHR774OM/6ZQmmj+tB4T4fV+VZ+cHDCLHMEwKcm
        KbmnzO5SBFmc5e4WYuTtEzNsSxefrdN84HhSicpLkFHCCJgoEqY8DgGPqiegpdKLZLvMpb
        GAwtoz5Kt9VFjuKJQBSlFU3FOV5pOhY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70879AE05;
        Wed, 24 Feb 2021 09:43:31 +0000 (UTC)
Date:   Wed, 24 Feb 2021 10:43:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: fix uninitialized subpool pointer
Message-ID: <YDYfwuSjFsa8iWTT@dhcp22.suse.cz>
References: <20210223215544.313871-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223215544.313871-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-02-21 13:55:44, Mike Kravetz wrote:
> Gerald Schaefer reported a panic on s390 in hugepage_subpool_put_pages()
> with linux-next 5.12.0-20210222.
> Call trace:
>   hugepage_subpool_put_pages.part.0+0x2c/0x138
>   __free_huge_page+0xce/0x310
>   alloc_pool_huge_page+0x102/0x120
>   set_max_huge_pages+0x13e/0x350
>   hugetlb_sysctl_handler_common+0xd8/0x110
>   hugetlb_sysctl_handler+0x48/0x58
>   proc_sys_call_handler+0x138/0x238
>   new_sync_write+0x10e/0x198
>   vfs_write.part.0+0x12c/0x238
>   ksys_write+0x68/0xf8
>   do_syscall+0x82/0xd0
>   __do_syscall+0xb4/0xc8
>   system_call+0x72/0x98
> 
> This is a result of the change which moved the hugetlb page subpool
> pointer from page->private to page[1]->private.  When new pages are
> allocated from the buddy allocator, the private field of the head
> page will be cleared, but the private field of subpages is not modified.
> Therefore, old values may remain.

Very interesting. I have expected that the page->private would be in a
reasonable state when allocated. On the other hand hugetlb doesn't do
__GFP_COMP so tail pages are not initialized by the allocator.
 
> Fix by initializing hugetlb page subpool pointer in prep_new_huge_page().
> 
> Fixes: f1280272ae4d ("hugetlb: use page.private for hugetlb specific page flags")

This is not a stable sha to refer to as it comes from linux next.

> Reported-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I think this would be worth a separate patch rather than having it
folded into the original patch. Thi is really subtle.

> ---
>  mm/hugetlb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c232cb67dda2..7ae5c18c98a7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1465,6 +1465,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
>  	INIT_LIST_HEAD(&page->lru);
>  	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> +	hugetlb_set_page_subpool(page, NULL);
>  	set_hugetlb_cgroup(page, NULL);
>  	set_hugetlb_cgroup_rsvd(page, NULL);
>  	spin_lock(&hugetlb_lock);
> -- 
> 2.29.2
> 

-- 
Michal Hocko
SUSE Labs
