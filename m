Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD63D19AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhGUVrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 17:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229794AbhGUVrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626906488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FI7Ns0ZdVAKMqXH/EU6QHqkRQy2TyEEXty0F6uwC/2Y=;
        b=B5LIEPH8ZZKWmgSA2radsVM5pVVyaBgEXygJgcK5JnuUhDfZJIu+VrBRNxKkSHUoOXLxQY
        Jq/LNcIaOEL5yGSGA8AWVOmnpCxNGPmczL809L2rVRMeyCwfOEsnUSG0JxRzJ4i7s0d2Ul
        Bq6TI+swhNQcXOwpFezW6du7E7bzCoY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-Cjx9JFLJPn-6SOX47HrbbQ-1; Wed, 21 Jul 2021 18:28:06 -0400
X-MC-Unique: Cjx9JFLJPn-6SOX47HrbbQ-1
Received: by mail-qk1-f197.google.com with SMTP id 8-20020a3704080000b02903b914d9e335so2674233qke.17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FI7Ns0ZdVAKMqXH/EU6QHqkRQy2TyEEXty0F6uwC/2Y=;
        b=NQFb30SHu4i+wV2gqf7qWCi4zinZtibO+MgrUFczKVZ8kYUc0mUz4ES6NXPKUwXF3D
         L6MWRqjF/OHlbMwX5ckzY7+tfXYl1cPqUTx/AkFWnamBGOJbe4hfORR3p6TIn4Iw2s/p
         zaqi/uZpfBWcxqQmw1E5nZR0vyTGV4gra4XYQ/p5zgSUbw0c/bt13j8yPc3qvCgp6zvy
         UFEU2Ijn9S0Um92NBsaqlwZkXsqEOEH7Zg/xT4cpHoWhABr6ng2iPMb14MKpq2+3BWuo
         cHES4RjAbfA0Wh5wUmqkiX9TOZsuw0Hsi7rbbd1pyWFhGifgx3Sn8wYXfrL2lcg/Ie+m
         yw+A==
X-Gm-Message-State: AOAM533qJ0BA3IOsawJ1hng0/Xk1bRMwy8Hz1lv+XIxJ2tltf3Us9Eu5
        XqHWDU+bWvxZgtd6E918jkGkIZ8Ke17B0BIZmcAbCkVl+pmIUmh8KA/LmMXrsaIL0YdiNg+YHnj
        k/HNPAwbMnzpvv+WcJmzpKyOA
X-Received: by 2002:a05:6214:846:: with SMTP id dg6mr39164009qvb.9.1626906486382;
        Wed, 21 Jul 2021 15:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHUXXRpAflEVE5cyFlmDTjyYIrA4sbqdJvPxJn/e8eQYNd1u9cN2EKqcPXbPSGJHIVnbH6hw==
X-Received: by 2002:a05:6214:846:: with SMTP id dg6mr39163991qvb.9.1626906486105;
        Wed, 21 Jul 2021 15:28:06 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id i4sm9921034qka.130.2021.07.21.15.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:28:05 -0700 (PDT)
Date:   Wed, 21 Jul 2021 18:28:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "ovzxemul@gmail.com" <ovzxemul@gmail.com>
Subject: Re: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Message-ID: <YPifc+eRNSs/rjv1@t490s>
References: <20210715201422.211004-1-peterx@redhat.com>
 <20210715201651.212134-1-peterx@redhat.com>
 <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com>
 <YPWiRsNaearMNB2g@t490s>
 <D2FD5D85-BA6D-492E-801F-E5003452DA70@nutanix.com>
 <YPW8xaejtl68AYCk@t490s>
 <CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
 <5c3c84ee-02f6-a2af-13b8-5dcf70676641@redhat.com>
 <CY4PR0201MB3460AAED19F46CD184B2AB30E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR0201MB3460AAED19F46CD184B2AB30E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ivan,

On Wed, Jul 21, 2021 at 07:54:44PM +0000, Ivan Teterevkov wrote:
> On Wed, Jul 21, 2021 4:20 PM +0000, David Hildenbrand wrote:
> > On 21.07.21 16:38, Ivan Teterevkov wrote:
> > > On Mon, Jul 19, 2021 5:56 PM +0000, Peter Xu wrote:
> > >> I'm also curious what would be the real use to have an accurate
> > >> PM_SWAP accounting.  To me current implementation may not provide
> > >> accurate value but should be good enough for most cases.  However not
> > >> sure whether it's also true for your use case.
> > >
> > > We want the PM_SWAP bit implemented (for shared memory in the pagemap
> > > interface) to enhance the live migration for some fraction of the
> > > guest VMs that have their pages swapped out to the host swap. Once
> > > those pages are paged in and transferred over network, we then want to
> > > release them with madvise(MADV_PAGEOUT) and preserve the working set
> > > of the guest VMs to reduce the thrashing of the host swap.
> > 
> > There are 3 possibilities I think (swap is just another variant of the page cache):
> > 
> > 1) The page is not in the page cache, e.g., it resides on disk or in a swap file.
> > pte_none().
> > 2) The page is in the page cache and is not mapped into the page table.
> > pte_none().
> > 3) The page is in the page cache and mapped into the page table.
> > !pte_none().
> > 
> > Do I understand correctly that you want to identify 1) and indicate it via
> > PM_SWAP?
> 
> Yes, and I also want to outline the context so we're on the same page.
> 
> This series introduces the support for userfaultfd-wp for shared memory
> because once a shared page is swapped, its PTE is cleared. Upon retrieval
> from a swap file, there's no way to "recover" the _PAGE_SWP_UFFD_WP flag
> because unlike private memory it's not kept in PTE or elsewhere.
> 
> We came across the same issue with PM_SWAP in the pagemap interface, but
> fortunately, there's the place that we could query: the i_pages field of
> the struct address_space (XArray). In https://lkml.org/lkml/2021/7/14/595
> we do it similarly to what shmem_fault() does when it handles #PF.
> 
> Now, in the context of this series, we were exploring whether it makes
> any practical sense to introduce more brand new flags to the special
> PTE to populate the pagemap flags "on the spot" from the given PTE.
> 
> However, I can't see how (and why) to achieve that specifically for
> PM_SWAP even with an extra bit: the XArray is precisely what we need for
> the live migration use case. Another flag PM_SOFT_DIRTY suffers the same
> problem as UFFD_WP_SWP_PTE_SPECIAL before this patch series, but we don't
> need it at the moment.
> 
> Hope that clarification makes sense?

Yes it helps, thanks.

So I can understand now on how that patch comes initially, even if it may not
work for PM_SOFT_DIRTY but it seems working indeed for PM_SWAP.

However I have a concern that I raised also in the other thread: I think
there'll be an extra and meaningless xa_load() for all the real pte_none()s
that aren't swapped out but just having no page at the back from the very
beginning.  That happens much more frequent when the memory being observed by
pagemap is mapped in a huge chunk and sparsely mapped.

With old code we'll simply skip those ptes, but now I have no idea how much
overhead would a xa_load() brings.

Btw, I think there's a way to implement such an idea similar to the swap
special uffd-wp pte - when page reclaim of shmem pages, instead of putting a
none pte there maybe we can also have one bit set in the none pte showing that
this pte is swapped out.  When the page faulted back we just drop that bit.

That bit could be also scanned by pagemap code to know that this page was
swapped out.  That should be much lighter than xa_load(), and that identifies
immediately from a real none pte just by reading the value.

Do you think this would work?

> 
> The only outstanding note I have is about the compatibility of our
> patches around pte_to_pagemap_entry(). I think the resulting code
> should look like this:
> 
> 	static pagemap_entry_t pte_to_pagemap_entry(...)
> 	{
> 		if (pte_present(pte)) {
> 			...
> 		} else if (is_swap_pte(pte) || shmem_file(vma->vm_file)) {
> 			...
> 			if (pte_swp_uffd_wp_special(pte)) {
> 				flags |= PM_UFFD_WP;
> 			}
> 		}
> 	}
> 
> The is_swap_pte() branch will be taken for the swapped out shared pages,
> thanks to shmem_file(), so the pte_swp_uffd_wp_special() can be checked
> inside.
> 
> Alternatively, we could just remove "else" statement:
> 
> 	static pagemap_entry_t pte_to_pagemap_entry(...)
> 	{
> 		if (pte_present(pte)) {
> 			...
> 		} else if (is_swap_pte(pte) || shmem_file(vma->vm_file)) {
> 			...
> 		}
> 
> 		if (pte_swp_uffd_wp_special(pte)) {
> 			flags |= PM_UFFD_WP;
> 		}
> 	}
> 
> What do you reckon?

I don't worry too much on how we implement those in details yet.  Both look
fine to me.

Thanks,

-- 
Peter Xu

