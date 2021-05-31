Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0B39559B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 08:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhEaGum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 02:50:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:53712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhEaGuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 02:50:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622443739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+lr7oE5hWOvbLfQreFLJO+2NuHgm+ZeXzWkRJMgDAnI=;
        b=G7KTuedXlFr6twlSfk3OFs2Qvzo9RsPBZ9+rmSZBK1XMvAzfI6zZsxjQXwYMhOqBu92CsE
        wrL+wG3jxyWWAxtJyUHyGuduIRth8Ql6amjcfcZSvJhj1+nQxQV1uVZV9JTuyjWZqPByfl
        QozDHaVHxp6tIc8xAPHGFHnZGvoRBjw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7BFD3B24F;
        Mon, 31 May 2021 06:48:59 +0000 (UTC)
Date:   Mon, 31 May 2021 08:48:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: hugetlb: fix dissolve_free_huge_page use of
 tail/head page
Message-ID: <YLSG2vUTv+QSAw8a@dhcp22.suse.cz>
References: <20210527231225.226987-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527231225.226987-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-05-21 16:12:25, Mike Kravetz wrote:
> The routine dissolve_free_huge_page can be passed the tail page of a
> hugetlb page.  The tail page is incorrectly passed on to the routines
> alloc_huge_page_vmemmap and add_hugetlb_page which expect a hugetlb
> head page.
> 
> Operating on a tail page instead of head page could result in addressing
> exceptions or vmemmap corruption.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> The code with this issue is only in mmotm (and next).  Specifically
> mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page
> Andrew, I assume you will fix in your tree.

Yes, folding this in sounds like the best way forward.

> 
>  mm/hugetlb.c            | 4 ++--
>  scripts/rust-version.sh | 0
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 scripts/rust-version.sh
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 69a4b551c157..d2461c1f32dd 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1954,7 +1954,7 @@ int dissolve_free_huge_page(struct page *page)
>  		 * Attempt to allocate vmemmmap here so that we can take
>  		 * appropriate action on failure.
>  		 */
> -		rc = alloc_huge_page_vmemmap(h, page);
> +		rc = alloc_huge_page_vmemmap(h, head);
>  		if (!rc) {
>  			/*
>  			 * Move PageHWPoison flag from head page to the raw
> @@ -1968,7 +1968,7 @@ int dissolve_free_huge_page(struct page *page)
>  			update_and_free_page(h, head, false);
>  		} else {
>  			spin_lock_irq(&hugetlb_lock);
> -			add_hugetlb_page(h, page, false);
> +			add_hugetlb_page(h, head, false);
>  			h->max_huge_pages++;
>  			spin_unlock_irq(&hugetlb_lock);
>  		}
> diff --git a/scripts/rust-version.sh b/scripts/rust-version.sh
> old mode 100644
> new mode 100755
> -- 
> 2.31.1
> 

-- 
Michal Hocko
SUSE Labs
