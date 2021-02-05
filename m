Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF0310256
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhBEBpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:45:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231650AbhBEBpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612489413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4gmKyOKs+UNMlatEK5Udmfiip3bQql1jRbCQJCWFfmk=;
        b=IqO9XrrejvIdCCWD+u5M2jWhwUv3TMVmp81KVIIdQGgLh+tNPxjo98h5mtVIPa+uaSM5Rg
        yQ9PqUVts8YLKhoGpPBci9apvlIDofAtkyadePKCkUY7I8OL5p3kXtUo+7JLtIfR7BZICF
        3zjS/vT95x/7/106G8lFfH64GUqedIo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-aAsXL1NqOuGZcrT4GviSoQ-1; Thu, 04 Feb 2021 20:43:32 -0500
X-MC-Unique: aAsXL1NqOuGZcrT4GviSoQ-1
Received: by mail-qk1-f197.google.com with SMTP id 70so4426060qkh.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 17:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4gmKyOKs+UNMlatEK5Udmfiip3bQql1jRbCQJCWFfmk=;
        b=pS/FL/Rgs/CToBQ/OtnRPKftvsVSLH19trUvLEyIDGfVHd343o80aTA7Z1alzTyRvm
         BaPz3w6QPHgZ9FuI79VVod3RmCQK4hrmljDGuQbf4z8Gz0l18hXpJuxxNfF+Mn02BtSU
         tNbIxmOS6MG/Mdp4TaMhaZL9PoLzZ4iNFGZuSId7ODnY+S8M+k4EE+Jwi0dcJ941vQ1V
         4EiMXLzwZFJX4R6zCjLA9ljQp/ehBnZwsZFhiNuDtr9cQLHnXrvtp2rcdMYXJuEo6PkX
         UB9Ni0K70/jbuHK6KksyppmNtR8DoJ18RU+03syOkEppnZUF0hRstqG/RgvG75NsDfye
         bP7A==
X-Gm-Message-State: AOAM530iV1/969lHzxY52q0bBs3f9an7PhA0CitAKsBKYAzY99bdkSAE
        C5yBRWN+M7mIGVrICUN6rRoLfaVarCOudKasLlAr3HOIc63zyQlKo21s5c9THZqIGYrwf7NAyDo
        mqGMAXIi9b5xVwQnGNca0CnvA
X-Received: by 2002:ac8:1283:: with SMTP id y3mr2363235qti.328.1612489411597;
        Thu, 04 Feb 2021 17:43:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMkXQJ7T8Fbl7lpWdsejP8eakfPGlddlfc7TkS0SS+QjWdyIgC+nzEuSRkH0w5pwMpSJlDPg==
X-Received: by 2002:ac8:1283:: with SMTP id y3mr2363215qti.328.1612489411322;
        Thu, 04 Feb 2021 17:43:31 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id o10sm6386855qtg.37.2021.02.04.17.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 17:43:30 -0800 (PST)
Date:   Thu, 4 Feb 2021 20:43:28 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/4] hugetlb: Do early cow when page pinned on src mm
Message-ID: <20210205014328.GW6468@xz-x1>
References: <20210204145033.136755-1-peterx@redhat.com>
 <20210204145033.136755-5-peterx@redhat.com>
 <d45d4ce3-f386-708b-0f7a-4950df6721d9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d45d4ce3-f386-708b-0f7a-4950df6721d9@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 03:25:37PM -0800, Mike Kravetz wrote:
> On 2/4/21 6:50 AM, Peter Xu wrote:
> > This is the last missing piece of the COW-during-fork effort when there're
> > pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
> > pinned pages during fork() for ptes", 2020-09-27) for more information, since
> > we do similar things here rather than pte this time, but just for hugetlb.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/hugetlb.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 56 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 9e6ea96bf33b..5793936e00ef 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -3734,11 +3734,27 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
> >  		return false;
> >  }
> >  
> > +static void
> > +hugetlb_copy_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
> > +		  struct page *old_page, struct page *new_page)
> > +{
> > +	struct hstate *h = hstate_vma(vma);
> > +	unsigned int psize = pages_per_huge_page(h);
> > +
> > +	copy_user_huge_page(new_page, old_page, addr, vma, psize);
> 
> copy_user_huge_page calls cond_resched() and has might_sleep().  Imagine
> the time it takes to copy 1G.  Usually called without holding locks, but
> this new code is calling it with ptl locks held.  The copy should be done
> outside the ptl, but you will need the ptl to update the pte/rmap.  So,
> doing all this within one neat helper like this may not be possible.

Right, I'll move the copy outside, thanks for spotting this.

> 
> > +	__SetPageUptodate(new_page);
> > +	ClearPagePrivate(new_page);
> > +	set_page_huge_active(new_page);
> 
> Code to replace the above ClearPagePrivate and set_page_huge_active is
> in Andrew's tree.  With changes in Andrew's tree, this would be:
> 
> 	ClearHPageRestoreReserve(new_page);
> 	SetHPageMigratable(new_page);

Indeed these names are much better than using the default ones.  At the
meantime I'll rebase to linux-next/akpm.  Sorry it's always not easy for me to
find the right branch...

> 
> Ideally, the SetHPageMigratable would be done after the set_pte and add_rmap
> so the page does not get migrated before these operations.  However, this
> can not happen since we are holding the ptl.  So, no problem here.  If code
> is restructured to call copy_user_huge_page outside ptl, keep this in mind.
> 
> Also, technically ClearHPageRestoreReserve is not needed as it would not be
> set by alloc_huge_page because we did not consume a reserve.  However, better
> to leave in place in case someone wants to use helper for something else.

OK, I'll keep it for clearness.

> 
> > +	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
> > +	hugepage_add_new_anon_rmap(new_page, vma, addr);
> > +	hugetlb_count_add(psize, vma->vm_mm);
> > +}
> > +
> >  int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >  			    struct vm_area_struct *vma)
> >  {
> >  	pte_t *src_pte, *dst_pte, entry, dst_entry;
> > -	struct page *ptepage;
> > +	struct page *ptepage, *prealloc = NULL;
> >  	unsigned long addr;
> >  	int cow;
> >  	struct hstate *h = hstate_vma(vma);
> > @@ -3787,7 +3803,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >  		dst_entry = huge_ptep_get(dst_pte);
> >  		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
> >  			continue;
> > -
> > +again:
> >  		dst_ptl = huge_pte_lock(h, dst, dst_pte);
> >  		src_ptl = huge_pte_lockptr(h, src, src_pte);
> >  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);

Side question: Mike, do you know why we need this lock_nested()?  Could the src
lock be taken due to any reason already?  It confused me when I read the chunk.

> > @@ -3816,6 +3832,39 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >  			}
> >  			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
> >  		} else {
> > +			entry = huge_ptep_get(src_pte);
> > +			ptepage = pte_page(entry);
> > +			get_page(ptepage);
> > +
> > +			/*
> > +			 * This is a rare case where we see pinned hugetlb
> > +			 * pages while they're prone to COW.  We need to do the
> > +			 * COW earlier during fork.
> > +			 *
> > +			 * When pre-allocating the page we need to be without
> > +			 * all the locks since we could sleep when allocate.
> > +			 */
> > +			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
> > +				if (!prealloc) {
> > +					put_page(ptepage);
> > +					spin_unlock(src_ptl);
> > +					spin_unlock(dst_ptl);
> > +					prealloc = alloc_huge_page(vma, addr, 1);
> > +					if (!prealloc) {
> 
> alloc_huge_page will return error codes, so you need to check IS_ERR(prealloc)
> not just NULL.

Definitely, I'll fix.

Thanks,

-- 
Peter Xu

