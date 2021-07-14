Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE93C896E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhGNRO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229684AbhGNRO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626282725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+u7BWcRWLoQNWyKJOQaPMWksN5UwirJlXh6tTZi510=;
        b=AWnO2nu9gdisLnZ0R6GogXB6oSPgJS5I5/qSEUauh+VrD5j4FMDNDgtmBn7TR5B8NA00Ly
        qjubtLtPJL7F5s9xiKCtJHMjtmPWc43V/o5BOQi3/H/oa1im86bdZDxoa8YNrRRG8PnTwb
        XM5rx8bZIXA980nV9/Ay0iNquX7z2D0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-HZaT3c9ZOwyHgp0TUTM5RQ-1; Wed, 14 Jul 2021 13:12:03 -0400
X-MC-Unique: HZaT3c9ZOwyHgp0TUTM5RQ-1
Received: by mail-qv1-f69.google.com with SMTP id l4-20020a0ce8440000b02902d89f797d08so2104779qvo.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/+u7BWcRWLoQNWyKJOQaPMWksN5UwirJlXh6tTZi510=;
        b=XaZ3am7tzOshwl1KDK6MrOV8a+4waPJEXN8UENvXJ8/GCKWfmLEbt2nZDEOruOag5j
         DcJ3CGO/9tK/bHzUiph1LXr/P/+rDSwdakvhoHUL93yy557ogrU1SyV9IE/gfJRQjMxN
         idcaYO3Mq/2vEi80i/EfiSLwAJVYxyAoeQSFTCzIbaKC/X7OnIDc+TWsHi8PKhxFd7Q+
         ZP6YJ10ptThweSbcAkXKE5jJDfOfA7Ro7WAeD9FlR90yS+4dsEDbi2oXp0KIEKB7bR8K
         nxyVnRrBUUZ97TL6OrvFxXzqVE3urPeAncNbVaHRz8Gb25PT8iSXJx15VFPuz92t0s/+
         UmNw==
X-Gm-Message-State: AOAM53236MFuzsqiDFOSX3hoYTFlm0ynOrVomwUVbLiRMHTXU6kKDQuZ
        PF9fGi/5XuopZ86Sn4WDPp872kCRpZg/ByX4gvycMP5TF6G1zenRnL8l2v8u9j1Cc4EgY6wzVYR
        XG2av/DHfrnEyVEKi3z6/mpo5
X-Received: by 2002:ac8:5853:: with SMTP id h19mr10295755qth.66.1626282723387;
        Wed, 14 Jul 2021 10:12:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyndPdH5BTegzcOmOxSmhX4dkEPZGrFPJ8X9gKoVpK4Gm+R6Uw+5+pGKoSBxNBkGXhdPso+QQ==
X-Received: by 2002:ac8:5853:: with SMTP id h19mr10295722qth.66.1626282723147;
        Wed, 14 Jul 2021 10:12:03 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id t62sm1274934qkc.26.2021.07.14.10.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:12:02 -0700 (PDT)
Date:   Wed, 14 Jul 2021 13:12:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH 1/1] pagemap: report swap location for shared pages
Message-ID: <YO8a4FpvBVEIBgjK@t490s>
References: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
 <20210714152426.216217-2-tiberiu.georgescu@nutanix.com>
 <YO8L5PTdAs+vPeIx@t490s>
 <0e38ef52-0ac7-c15b-114b-3316973fc7dc@redhat.com>
 <f39be587-31f4-72c0-7d39-dad02a0f5777@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f39be587-31f4-72c0-7d39-dad02a0f5777@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 06:30:05PM +0200, David Hildenbrand wrote:
> On 14.07.21 18:24, David Hildenbrand wrote:
> > On 14.07.21 18:08, Peter Xu wrote:
> > > On Wed, Jul 14, 2021 at 03:24:26PM +0000, Tiberiu Georgescu wrote:
> > > > When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
> > > > entry is cleared. In many cases, there is no difference between swapped-out
> > > > shared pages and newly allocated, non-dirty pages in the pagemap interface.
> > > > 
> > > > This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
> > > > make use of the XArray associated with the virtual memory area struct
> > > > passed as an argument. The XArray contains the location of virtual pages
> > > > in the page cache, swap cache or on disk. If they are on either of the
> > > > caches, then the original implementation still works. If not, then the
> > > > missing information will be retrieved from the XArray.
> > > > 
> > > > Co-developed-by: Florian Schmidt <florian.schmidt@nutanix.com>
> > > > Signed-off-by: Florian Schmidt <florian.schmidt@nutanix.com>
> > > > Co-developed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
> > > > Signed-off-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
> > > > Co-developed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
> > > > Signed-off-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
> > > > Signed-off-by: Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
> > > > ---
> > > >    fs/proc/task_mmu.c | 37 +++++++++++++++++++++++++++++--------
> > > >    1 file changed, 29 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index eb97468dfe4c..b17c8aedd32e 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -1359,12 +1359,25 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
> > > >    	return err;
> > > >    }
> > > > +static void *get_xa_entry_at_vma_addr(struct vm_area_struct *vma,
> > > > +		unsigned long addr)
> > > > +{
> > > > +	struct inode *inode = file_inode(vma->vm_file);
> > > > +	struct address_space *mapping = inode->i_mapping;
> > > > +	pgoff_t offset = linear_page_index(vma, addr);
> > > > +
> > > > +	return xa_load(&mapping->i_pages, offset);
> > > > +}
> > > > +
> > > >    static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
> > > >    		struct vm_area_struct *vma, unsigned long addr, pte_t pte)
> > > >    {
> > > >    	u64 frame = 0, flags = 0;
> > > >    	struct page *page = NULL;
> > > > +	if (vma->vm_flags & VM_SOFTDIRTY)
> > > > +		flags |= PM_SOFT_DIRTY;
> > > > +
> > > >    	if (pte_present(pte)) {
> > > >    		if (pm->show_pfn)
> > > >    			frame = pte_pfn(pte);
> > > > @@ -1374,13 +1387,22 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
> > > >    			flags |= PM_SOFT_DIRTY;
> > > >    		if (pte_uffd_wp(pte))
> > > >    			flags |= PM_UFFD_WP;
> > > > -	} else if (is_swap_pte(pte)) {
> > > > +	} else if (is_swap_pte(pte) || shmem_file(vma->vm_file)) {
> > > >    		swp_entry_t entry;
> > > > -		if (pte_swp_soft_dirty(pte))
> > > > -			flags |= PM_SOFT_DIRTY;
> > > > -		if (pte_swp_uffd_wp(pte))
> > > > -			flags |= PM_UFFD_WP;
> > > > -		entry = pte_to_swp_entry(pte);
> > > > +		if (is_swap_pte(pte)) {
> > > > +			entry = pte_to_swp_entry(pte);
> > > > +			if (pte_swp_soft_dirty(pte))
> > > > +				flags |= PM_SOFT_DIRTY;
> > > > +			if (pte_swp_uffd_wp(pte))
> > > > +				flags |= PM_UFFD_WP;
> > > > +		} else {
> > > > +			void *xa_entry = get_xa_entry_at_vma_addr(vma, addr);
> > > > +
> > > > +			if (xa_is_value(xa_entry))
> > > > +				entry = radix_to_swp_entry(xa_entry);
> > > > +			else
> > > > +				goto out;
> > > > +		}
> > > >    		if (pm->show_pfn)
> > > >    			frame = swp_type(entry) |
> > > >    				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
> > > > @@ -1393,9 +1415,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
> > > >    		flags |= PM_FILE;
> > > >    	if (page && page_mapcount(page) == 1)
> > > >    		flags |= PM_MMAP_EXCLUSIVE;
> > > > -	if (vma->vm_flags & VM_SOFTDIRTY)
> > > > -		flags |= PM_SOFT_DIRTY;
> > > 
> > > IMHO moving this to the entry will only work for the initial iteration, however
> > > it won't really help anything, as soft-dirty should always be used in pair with
> > > clear_refs written with value "4" first otherwise all pages will be marked
> > > soft-dirty then the pagemap data is meaningless.
> > > 
> > > After the "write 4" op VM_SOFTDIRTY will be cleared and I expect the test case
> > > to see all zeros again even with the patch.
> > > 
> > > I think one way to fix this is to do something similar to uffd-wp: we leave a
> > > marker in pte showing that this is soft-dirtied pte even if swapped out.
> > 
> > How exactly does such a pte look like? Simply pte_none() with another
> > bit set?

Yes something like that.  The pte can be defined at will, as long as never used
elsewhere.

> > 
> > > However we don't have a mechanism for that yet in current linux, and the
> > > uffd-wp series is the first one trying to introduce something like that.
> > 
> > Can you give me a pointer? I'm very interested in learning how to
> > identify this case.
> > 
> 
> I assume it's
> https://lore.kernel.org/lkml/20210527202117.30689-1-peterx@redhat.com/

Yes.

-- 
Peter Xu

