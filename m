Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C161B31EF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhBRTRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234650AbhBRR53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613670960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hgus6Jh48EXSiuN6NRTTRChhTP22InEzFrKGu7j+/f0=;
        b=Eoz93E8UDEXOAy+EmrIW7/3SKJYs1L5EAd3A1TFwsVnKruJqRkIlOHPfbmrqePjU09/IXL
        87jw2kMjHYso+I75PH0m3dxSpWfFh6JpcNM8WNHHCFveBh2F+0MSEy81Z9GrtAQ/DdftNi
        MJPqpbuBGiKAmU3AT+jlDmKQ5xAzNF0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-2T0MC4vIO1qOR0FhqsdWFQ-1; Thu, 18 Feb 2021 12:55:58 -0500
X-MC-Unique: 2T0MC4vIO1qOR0FhqsdWFQ-1
Received: by mail-qv1-f70.google.com with SMTP id q104so1584971qvq.20
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hgus6Jh48EXSiuN6NRTTRChhTP22InEzFrKGu7j+/f0=;
        b=Uzt1PF1M9tF390f9f9LZKL6mIh1ZPUd+oZwubA6ICAcq2UyisJlu+J1PKDuyxkhzWY
         76/gNCwP2RuAYSTpMNAT6Tr26WkUJ7YANjGdt+TW7GV+YjWkeRcWzGR1/BYOeH+PWugR
         2pFRrgh0DaI3VP8UHQZn+aj+uQ++J3NG43RVdfFslTFm4zLZz30T13WyNdiagLYz4mEj
         pugibGZ836G/0clp5q2kd+T2eGbNHmcC6955Lu+Ho5k6yRXD/SJWcUDpSjz2XhXVDYBC
         0m9dznq7K0GituNfE0ZAhfe3E1CYOFw9/h5tz4ccR6SmpVOURVbQDMJOF7NHBiNikTWr
         s6+g==
X-Gm-Message-State: AOAM531aGYyXeCrQISeSvNyZbEF4rzPMzkll6yVyKvkUn0ZDVecFuz0C
        s6YZWVWpsggwf0U4+SDLrj9p9wn/y0NDPoY3DJU6FSavjbCAwtQKq0dXn8W6rBU65njOzLmVh0W
        7vsMJylbjGFQ8FexPeuAEnkTr
X-Received: by 2002:a37:7fc2:: with SMTP id a185mr5673095qkd.202.1613670958111;
        Thu, 18 Feb 2021 09:55:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7kQEHs9A+nPCZeDDOR0L4XNbrDzLBb36tqy/NHHh6MTnMGgE0nltV0zwmGpXEglTgsLKuFw==
X-Received: by 2002:a37:7fc2:: with SMTP id a185mr5673073qkd.202.1613670957892;
        Thu, 18 Feb 2021 09:55:57 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id e190sm4571993qkd.122.2021.02.18.09.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 09:55:57 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:55:55 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 4/4] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
Message-ID: <20210218175555.GC108961@xz-x1>
References: <20210217204418.54259-1-peterx@redhat.com>
 <20210217204619.54761-1-peterx@redhat.com>
 <20210217204619.54761-3-peterx@redhat.com>
 <f2122560-fbb9-c0fc-1b05-6d82ccf4525c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2122560-fbb9-c0fc-1b05-6d82ccf4525c@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 05:46:30PM -0800, Mike Kravetz wrote:
> On 2/17/21 12:46 PM, Peter Xu wrote:
> > Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
> > userfaultfd-wp is always based on pgtable entries, so they cannot be shared.
> > 
> > Walk the hugetlb range and unshare all such mappings if there is, right before
> > UFFDIO_REGISTER will succeed and return to userspace.
> > 
> > This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
> > is completely disabled for userfaultfd-wp registered range.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  fs/userfaultfd.c        |  4 ++++
> >  include/linux/hugetlb.h |  1 +
> >  mm/hugetlb.c            | 51 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 56 insertions(+)
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 894cc28142e7..e259318fcae1 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/sched/signal.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/mm.h>
> > +#include <linux/mmu_notifier.h>
> >  #include <linux/poll.h>
> >  #include <linux/slab.h>
> >  #include <linux/seq_file.h>
> > @@ -1448,6 +1449,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  		vma->vm_flags = new_flags;
> >  		vma->vm_userfaultfd_ctx.ctx = ctx;
> >  
> > +		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> > +			hugetlb_unshare_all_pmds(vma);
> > +
> >  	skip:
> >  		prev = vma;
> >  		start = vma->vm_end;
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 3b4104021dd3..97ecfd4c20b2 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -188,6 +188,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
> >  		unsigned long address, unsigned long end, pgprot_t newprot);
> >  
> >  bool is_hugetlb_entry_migration(pte_t pte);
> > +void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
> >  
> >  #else /* !CONFIG_HUGETLB_PAGE */
> >  
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f53a0b852ed8..83c006ea3ff9 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5723,4 +5723,55 @@ void __init hugetlb_cma_check(void)
> >  	pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
> >  }
> >  
> > +/*
> > + * This function will unconditionally remove all the shared pmd pgtable entries
> > + * within the specific vma for a hugetlbfs memory range.
> > + */
> 
> Thanks for updating this!
> 
> > +void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> > +{
> > +	struct hstate *h = hstate_vma(vma);
> > +	unsigned long sz = huge_page_size(h);
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	struct mmu_notifier_range range;
> > +	unsigned long address, start, end;
> > +	spinlock_t *ptl;
> > +	pte_t *ptep;
> > +
> > +	if (!(vma->vm_flags & VM_MAYSHARE))
> > +		return;
> > +
> > +	start = ALIGN(vma->vm_start, PUD_SIZE);
> > +	end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
> > +
> > +	if (start >= end)
> > +		return;
> > +
> > +	/*
> > +	 * No need to call adjust_range_if_pmd_sharing_possible(), because
> > +	 * we're going to operate on the whole vma
> 
> not necessary, but perhaps change to:
> 	 * we're going to operate on ever PUD_SIZE aligned sized range
> 	 * within the vma.
> 
> > +	 * we're going to operate on the whole vma
> > +	 */
> > +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
> > +				vma->vm_start, vma->vm_end);
> 
> Should we use start, end here instead of vma->vm_start, vma->vm_end ?
> 
> > +	mmu_notifier_invalidate_range_start(&range);
> > +	i_mmap_lock_write(vma->vm_file->f_mapping);
> > +	for (address = start; address < end; address += PUD_SIZE) {
> > +		unsigned long tmp = address;
> > +
> > +		ptep = huge_pte_offset(mm, address, sz);
> > +		if (!ptep)
> > +			continue;
> > +		ptl = huge_pte_lock(h, mm, ptep);
> > +		/* We don't want 'address' to be changed */
> > +		huge_pmd_unshare(mm, vma, &tmp, ptep);
> > +		spin_unlock(ptl);
> > +	}
> > +	flush_hugetlb_tlb_range(vma, vma->vm_start, vma->vm_end);
> 
> start, end ?

Right we can even shrink the notifier, I'll respin shortly.  Thanks,

-- 
Peter Xu

