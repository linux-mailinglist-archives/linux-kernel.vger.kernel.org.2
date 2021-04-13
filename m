Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB28735DFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbhDMNXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:23:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239012AbhDMNXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:23:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618320191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3IkqxJ6xu7XI08DFS8bNsW/a5R8eDQtSo0M3e8Jemww=;
        b=q3tg5TKTOSTiOnnBgjcW9StqvbqMsb+3vrsRHYOq0DqL1MFgiCl5DsHe6rzJwE3obcWtYU
        H4Dzf8V8VjqlgXHxQiHgZD5rABr2wiCTCqnKAc5JtbA2ccBn9ugO8x+FWZL8dRyXFTB5Qh
        sngWrg0Jw7NkPKQJdk7VGj0GXPVJnWg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 924F2AFE2;
        Tue, 13 Apr 2021 13:23:11 +0000 (UTC)
Date:   Tue, 13 Apr 2021 15:23:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
Message-ID: <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413104747.12177-4-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 12:47:43, Oscar Salvador wrote:
> Currently, the clearing of the flag is done under the lock, but this
> is unnecessary as we just allocated the page and we did not give it
> away yet, so no one should be messing with it.
> 
> Also, this helps making clear that here the lock is only protecting the
> counter.

While moving the flag clearing is ok I am wondering why do we need that
in the first place. I think it is just a leftover from 6c0371490140
("hugetlb: convert PageHugeFreed to HPageFreed flag"). Prior to that a tail
page as been used to keep track of the state but now all happens in the
head page and the flag uses page->private which is always initialized
when allocated by the allocator (post_alloc_hook).

Or do we need it for giga pages which are not allocated by the page
allocator? If yes then moving it to prep_compound_gigantic_page would be
better.

So should we just drop it here?

> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 54d81d5947ed..e40d5fe5c63c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1490,10 +1490,10 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  	hugetlb_set_page_subpool(page, NULL);
>  	set_hugetlb_cgroup(page, NULL);
>  	set_hugetlb_cgroup_rsvd(page, NULL);
> +	ClearHPageFreed(page);
>  	spin_lock_irq(&hugetlb_lock);
>  	h->nr_huge_pages++;
>  	h->nr_huge_pages_node[nid]++;
> -	ClearHPageFreed(page);
>  	spin_unlock_irq(&hugetlb_lock);
>  }
>  
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
