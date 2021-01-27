Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2991A305031
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbhA0DuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389714AbhA0AIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:08:12 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A71C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 16:07:32 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id n14so277156qvg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 16:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IBWE4/cCmXLrxz784nnplj3SLPB8dWgUq6dNaUorHT4=;
        b=QF7Z3d3fC6UKcyB2/nWlOspF0mplMjaV+U2y7anDeGg+P2upfXQJ5v6YzR7MuClr/h
         VbY2EqVLYBhUiLaRViHWEIvp85YpaGpQUYcHal+IoxZuDxXcIqQqHc6L1Uo4qKeBy4HN
         hMDway+t5l3BBgh24nW4BeRN0WAG39i3OnA1KNeJ+8rPrdAQg+Z3Njl0YFyg5L015ZHK
         6no/DAAnz7I0gkZn0n6CM4i3tm/eWZJyZGMBuZWPgFMGro/mjVcKEgRGBmzmCce5xbJn
         v6/y++kNi8mHwbgfC/EwugtGP1znSC8CMJEqbebuFQE/QeD88YUzn9qshDZ3wA6j7rEy
         r71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IBWE4/cCmXLrxz784nnplj3SLPB8dWgUq6dNaUorHT4=;
        b=bzFC+gOAPY7FTy8uzvqJ16sNc2WT9JUDSJg/m+QZPz+tthDrX1XWzDscw4+FQ0SELo
         WII0Pmhil+fvLFm+PnNhUEq5ChnivV8M6tTurtF/7F5cJTrz34CGlnvoyoKG6imCMNGs
         fybQIWvANcPDxmolBHtuq4mpZEvv3HiF6jual/3IfsgAhmScX7HafFf2b0akwG9m3NDQ
         Ceg7u21bOIJLCfwkqwYnH3fhJEcoddoAANvBiWV6o/30I90wwL7nRXvgk75y5JpJw7IU
         8MFXaOv3ckOI1BobuPwTHypIP0pGJ271bZp6cXF0UREIAZvnQHj/RMH64tKpNtCV7rLT
         Jw1w==
X-Gm-Message-State: AOAM533iR0rkFNq9Mto/acDDoD7HYQK4PtQaxeayUGSI5Bexa1LT4pty
        DTYW5Rxug+YshIJg9R1EgPUByw==
X-Google-Smtp-Source: ABdhPJxxAIqZ7rQx8opfiPosQgy3Ujmb6ScY0g0jp9rkapdTWJuzYCWaTBiQ+Ay3/In8ANgvaH3JYQ==
X-Received: by 2002:ad4:5bc8:: with SMTP id t8mr8172516qvt.36.1611706051522;
        Tue, 26 Jan 2021 16:07:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id i3sm101444qkd.119.2021.01.26.16.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 16:07:31 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l4YMs-007HIh-Ic; Tue, 26 Jan 2021 20:07:30 -0400
Date:   Tue, 26 Jan 2021 20:07:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
Message-ID: <20210127000730.GB4605@ziepe.ca>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
 <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
 <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
 <4d3914e9-f448-8a86-9fc6-e71cec581115@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3914e9-f448-8a86-9fc6-e71cec581115@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 01:21:46PM -0800, Mike Kravetz wrote:
> On 1/26/21 11:21 AM, Joao Martins wrote:
> > On 1/26/21 6:08 PM, Mike Kravetz wrote:
> >> On 1/25/21 12:57 PM, Joao Martins wrote:
> >>> 
> >>> +static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
> >>> +				 int refs, struct page **pages,
> >>> +				 struct vm_area_struct **vmas)
> >>> +{
> >>> +	int nr;
> >>> +
> >>> +	for (nr = 0; nr < refs; nr++) {
> >>> +		if (likely(pages))
> >>> +			pages[nr] = page++;
> >>> +		if (vmas)
> >>> +			vmas[nr] = vma;
> >>> +	}
> >>> +}
> >>> +
> >>>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >>>  			 struct page **pages, struct vm_area_struct **vmas,
> >>>  			 unsigned long *position, unsigned long *nr_pages,
> >>> @@ -4918,28 +4932,16 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >>>  			continue;
> >>>  		}
> >>>  
> >>> -		refs = 0;
> >>> +		refs = min3(pages_per_huge_page(h) - pfn_offset,
> >>> +			    (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
> >>>  
> >>> -same_page:
> >>> -		if (pages)
> >>> -			pages[i] = mem_map_offset(page, pfn_offset);
> >>> +		if (pages || vmas)
> >>> +			record_subpages_vmas(mem_map_offset(page, pfn_offset),
> >>
> >> The assumption made here is that mem_map is contiguous for the range of
> >> pages in the hugetlb page.  I do not believe you can make this assumption
> >> for (gigantic) hugetlb pages which are > MAX_ORDER_NR_PAGES.  For example,
> >>
> 
> Thinking about this a bit more ...
> 
> mem_map can be accessed contiguously if we have a virtual memmap.  Correct?
> I suspect virtual memmap may be the most common configuration today.  However,
> it seems we do need to handle other configurations.
> 
> > That would mean get_user_pages_fast() and put_user_pages_fast() are broken for anything
> > handling PUDs or above? See record_subpages() in gup_huge_pud() or even gup_huge_pgd().
> > It's using the same page++.
> 
> Yes, I believe those would also have the issue.
> Cc: John and Jason as they have spent a significant amount of time in gup
> code recently.  There may be something that makes that code safe?

I'm looking at Matt's folio patches and see:

+static inline struct folio *next_folio(struct folio *folio)
+{
+       return folio + folio_nr_pages(folio);
+}

And checking page_trans_huge_mapcount():

	for (i = 0; i < thp_nr_pages(page); i++) {
		mapcount = atomic_read(&page[i]._mapcount) + 1;

And we have the same logic in hmm_vma_walk_pud():

	if (pud_huge(pud) && pud_devmap(pud)) {
		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
		for (i = 0; i < npages; ++i, ++pfn)
			hmm_pfns[i] = pfn | cpu_flags;

So, if page[n] does not access the tail pages of a compound we have
many more people who are surprised by this than just GUP.

Where are these special rules for hugetlb compound tails documented?
Why does it need to be like this? 

Isn't it saner to forbid a compound and its tails from being
non-linear in the page array? That limits when compounds can be
created, but seems more likely to happen than a full mm audit to find
all the places that assume linearity.

Jason
