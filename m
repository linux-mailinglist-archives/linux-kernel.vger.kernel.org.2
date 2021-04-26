Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C723036AA85
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 04:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhDZCJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 22:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231502AbhDZCJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 22:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619402926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQcuUEVJbsB5DNTPE7G1glwcuGeqhKTzKJYzQ0TQxuQ=;
        b=NgQQ1huimlRQ3JoNKqCZ5Kj12zmtDBl6Lt/nBs2OklWfxBFQlZL2462hrc3HFpPrGBxLer
        gfqcAA1/FOoAklEgyejXkE+W+NlE4+09U1BNh9Q+pRWCwjnSuaES9OnjerC8s8hpK/vfVW
        MkJ6T/+kq6ObOybCKoqCQi9q4xebaQQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-mK_WNwmGM8mkyRVBOiAExA-1; Sun, 25 Apr 2021 22:08:45 -0400
X-MC-Unique: mK_WNwmGM8mkyRVBOiAExA-1
Received: by mail-qt1-f199.google.com with SMTP id d10-20020a05622a100ab02901b8224bae03so15301420qte.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 19:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQcuUEVJbsB5DNTPE7G1glwcuGeqhKTzKJYzQ0TQxuQ=;
        b=GKwXLt0D4ATlh+RYGzQDQuRx+NNcLcCX/bv3F6EF/I+zIukrHwlFWJvB455VuuNriN
         gGQZUrH17OYTn3tST0ozm0+NgXCPhL7nRvHQzXqSGlnvH4TeJ75nUREgqqtZ8GYx40Ij
         LcI4+FAYzbERC7x6byn1hbr6h/Y/phY2MeIq//v3DR5OWb8tlU7BkyfhRNaNibpfT/49
         4vAhyM2lxhIxWxyeHiQOAApTpVKEr4a0u9MjfOx06xwaZbB82I3kZiSyGlOxO1g9gWnU
         G2ocGBmglvvnd3EPJ45TbUIyVQHvWqJw3kmDatvkx9gqLpbNe7f9djTkwJwXv0VFc8E8
         VIvA==
X-Gm-Message-State: AOAM530FQqHI3TNaIliaX7XuvTx0zmsuYLZLUqDjA23wJawSTx/7dQq5
        z5Qq3XJGavcmItLQ4KwjaomIUtMvIaisK6dVzOjJ7sbdkLryy5Hs6D0NL22T/v8sS7Su40kJDxE
        HXpX/n5bq/Mf3Ui265681+dcn
X-Received: by 2002:a37:e315:: with SMTP id y21mr15191433qki.176.1619402924576;
        Sun, 25 Apr 2021 19:08:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt2GznUvIrmBPfYns2DPvVFTePiNP5J2ZSP6QzSMxzm67mEjFqK9PpUipX9kw3yFKRcueXdw==
X-Received: by 2002:a37:e315:: with SMTP id y21mr15191416qki.176.1619402924268;
        Sun, 25 Apr 2021 19:08:44 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id d10sm3324391qki.122.2021.04.25.19.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 19:08:43 -0700 (PDT)
Date:   Sun, 25 Apr 2021 22:08:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 19/23] hugetlb/userfaultfd: Handle uffd-wp special pte in
 hugetlb pf handler
Message-ID: <20210426020842.GB85002@xz-x1>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323005049.35862-1-peterx@redhat.com>
 <3178f1ff-f8da-7fdd-68ef-8c35972ca2e1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3178f1ff-f8da-7fdd-68ef-8c35972ca2e1@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 03:45:39PM -0700, Mike Kravetz wrote:
> On 3/22/21 5:50 PM, Peter Xu wrote:
> > Teach the hugetlb page fault code to understand uffd-wp special pte.  For
> > example, when seeing such a pte we need to convert any write fault into a read
> > one (which is fake - we'll retry the write later if so).  Meanwhile, for
> > handle_userfault() we'll need to make sure we must wait for the special swap
> > pte too just like a none pte.
> > 
> > Note that we also need to teach UFFDIO_COPY about this special pte across the
> > code path so that we can safely install a new page at this special pte as long
> > as we know it's a stall entry.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  fs/userfaultfd.c |  5 ++++-
> >  mm/hugetlb.c     | 34 +++++++++++++++++++++++++++-------
> >  mm/userfaultfd.c |  5 ++++-
> >  3 files changed, 35 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 72956f9cc892..f6fa34f58c37 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -245,8 +245,11 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> >  	/*
> >  	 * Lockless access: we're in a wait_event so it's ok if it
> >  	 * changes under us.
> > +	 *
> > +	 * Regarding uffd-wp special case, please refer to comments in
> > +	 * userfaultfd_must_wait().
> >  	 */
> > -	if (huge_pte_none(pte))
> > +	if (huge_pte_none(pte) || pte_swp_uffd_wp_special(pte))
> >  		ret = true;
> >  	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
> >  		ret = true;
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 64e424b03774..448ef745d5ee 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4369,7 +4369,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
> >  static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >  			struct vm_area_struct *vma,
> >  			struct address_space *mapping, pgoff_t idx,
> > -			unsigned long address, pte_t *ptep, unsigned int flags)
> > +			unsigned long address, pte_t *ptep,
> > +			pte_t old_pte, unsigned int flags)
> >  {
> >  	struct hstate *h = hstate_vma(vma);
> >  	vm_fault_t ret = VM_FAULT_SIGBUS;
> > @@ -4493,7 +4494,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >  
> >  	ptl = huge_pte_lock(h, mm, ptep);
> >  	ret = 0;
> > -	if (!huge_pte_none(huge_ptep_get(ptep)))
> > +	if (!pte_same(huge_ptep_get(ptep), old_pte))
> >  		goto backout;
> >  
> >  	if (anon_rmap) {
> > @@ -4503,6 +4504,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >  		page_dup_rmap(page, true);
> >  	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
> >  				&& (vma->vm_flags & VM_SHARED)));
> > +	if (unlikely(flags & FAULT_FLAG_UFFD_WP)) {
> > +		WARN_ON_ONCE(flags & FAULT_FLAG_WRITE);
> > +		/* We should have the write bit cleared already, but be safe */
> > +		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
> > +	}
> >  	set_huge_pte_at(mm, haddr, ptep, new_pte);
> >  
> >  	hugetlb_count_add(pages_per_huge_page(h), mm);
> > @@ -4584,9 +4590,16 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >  		if (unlikely(is_hugetlb_entry_migration(entry))) {
> >  			migration_entry_wait_huge(vma, mm, ptep);
> >  			return 0;
> > -		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
> > +		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
> >  			return VM_FAULT_HWPOISON_LARGE |
> >  				VM_FAULT_SET_HINDEX(hstate_index(h));
> > +		} else if (unlikely(is_swap_special_pte(entry))) {
> > +			/* Must be a uffd-wp special swap pte */
> > +			WARN_ON_ONCE(!pte_swp_uffd_wp_special(entry));
> > +			flags |= FAULT_FLAG_UFFD_WP;
> > +			/* Emulate a read fault */
> > +			flags &= ~FAULT_FLAG_WRITE;
> > +		}
> 
> The comment above this if/else block points out that we hold no locks
> and are only checking conditions that would cause a quick return.  Yet,
> this new code is potentially modifying flags.  Pretty sure we can race
> and have the entry change.
> 
> Not sure of all the side effects of emulating a read if changed entry is
> not a uffd-wp special swap pte and we emulate read when we should not.
> 
> Perhaps we should just put this check and modification of flags after
> taking the fault mutex and before the change below?

That's a great point.  Even the WARN_ON_ONCE could trigger if the pte got
modified in parallel, so definitely broken.

Yes I'd better do that with the pgtable lock, mostly hugetlb_no_page() should
be the only function to handle this special case. So maybe I don't need to
emulate the READ fault at all, but just check pte_swp_uffd_wp_special() with
the lock, then do wrprotect properly should suffice.  Maybe that's even true
for shmem, I'll think more about it.

Thanks!

-- 
Peter Xu

