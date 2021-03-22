Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7318A343DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCVKYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230022AbhCVKXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:23:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 538ED6198D;
        Mon, 22 Mar 2021 10:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616408622;
        bh=PolohzF88aaUXjrAtz/IbqRVrmQCd7br4yDbMlmgpCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPBJ/NXJDU/0d4NUpa2FI+0Yrkialh6Abq1d/yy+CUfb2LGZbDcBkPqCjXKKTvQeJ
         lGa/n1DebXDE8HN+9soDKmvY+7IHG025pGS1LSNlq6dKTVtd49V+v2ebaQxQhUqB8s
         t6cEa7/ksq3ZligFlZ+hHeaZR0wPIpl7WXAujByKGKuqu3kKHIkCuiULYkCfF7rMsB
         p+DV4K2W9brgCSH5vzRE63RIwH8jdeK7LJ5ftX+Xtr6mYjCG8SiCip6pgXG6XCaNPS
         RG32nh5vjBDb+VsR+yhnqwASfPGfnvuLEebjAL/ubTTP5iZWIRwasvFBWhN8sMir2s
         3yQWS6H7dTIMg==
Date:   Mon, 22 Mar 2021 12:23:35 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Bui Quang Minh <minhquangbui99@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] userfaultfd: Write protect when virtual memory range has
 no page table entry
Message-ID: <YFhwJ+ftD6UURkDL@kernel.org>
References: <20210319152428.52683-1-minhquangbui99@gmail.com>
 <YFhuDf6L7nkUoT7q@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFhuDf6L7nkUoT7q@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Peter

On Mon, Mar 22, 2021 at 11:14:37AM +0100, Michal Hocko wrote:
> Le'ts Andrea and Mike
> 
> On Fri 19-03-21 22:24:28, Bui Quang Minh wrote:
> > userfaultfd_writeprotect() use change_protection() to clear write bit in
> > page table entries (pte/pmd). So, later write to this virtual address
> > range causes a page fault, which is then handled by userspace program.
> > However, change_protection() has no effect when there is no page table
> > entries associated with that virtual memory range (a newly mapped memory
> > range). As a result, later access to that memory range causes allocating a
> > page table entry with write bit still set (due to VM_WRITE flag in
> > vma->vm_flags).
> > 
> > Add checks for VM_UFFD_WP in vma->vm_flags when allocating new page table
> > entry in missing page table entry page fault path.
> 
> From the above it is not really clear whether this is a usability
> problem or a bug of the interface.
> 
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > ---
> >  mm/huge_memory.c | 12 ++++++++++++
> >  mm/memory.c      | 10 ++++++++++
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index ae907a9c2050..9bb16a55a48c 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -636,6 +636,11 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> >  
> >  		entry = mk_huge_pmd(page, vma->vm_page_prot);
> >  		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> > +		if (userfaultfd_wp(vma)) {
> > +			entry = pmd_wrprotect(entry);
> > +			entry = pmd_mkuffd_wp(entry);
> > +		}
> > +
> >  		page_add_new_anon_rmap(page, vma, haddr, true);
> >  		lru_cache_add_inactive_or_unevictable(page, vma);
> >  		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> > @@ -643,6 +648,13 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> >  		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> >  		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> >  		mm_inc_nr_ptes(vma->vm_mm);
> > +
> > +		if (userfaultfd_huge_pmd_wp(vma, *vmf->pmd)) {
> > +			spin_unlock(vmf->ptl);
> > +			count_vm_event(THP_FAULT_ALLOC);
> > +			count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
> > +			return handle_userfault(vmf, VM_UFFD_WP);
> > +		}
> >  		spin_unlock(vmf->ptl);
> >  		count_vm_event(THP_FAULT_ALLOC);
> >  		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 5efa07fb6cdc..b835746545bf 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3564,6 +3564,11 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> >  	if (vma->vm_flags & VM_WRITE)
> >  		entry = pte_mkwrite(pte_mkdirty(entry));
> >  
> > +	if (userfaultfd_wp(vma)) {
> > +		entry = pte_wrprotect(entry);
> > +		entry = pte_mkuffd_wp(entry);
> > +	}
> > +
> >  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> >  			&vmf->ptl);
> >  	if (!pte_none(*vmf->pte)) {
> > @@ -3590,6 +3595,11 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> >  
> >  	/* No need to invalidate - it was non-present before */
> >  	update_mmu_cache(vma, vmf->address, vmf->pte);
> > +
> > +	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> > +		pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +		return handle_userfault(vmf, VM_UFFD_WP);
> > +	}
> >  unlock:
> >  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> >  	return ret;
> > -- 
> > 2.25.1
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
