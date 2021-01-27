Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EDC30505D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbhA0EEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhA0DC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:02:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B2CC0617A9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=60WoA0haalgCAug6TGsXGutfGgc3qh6P4UHF0YYcunc=; b=mI2AtubiUQoYZfxsg0Q/vN6JmI
        4CdZ092ntuvOBqOowp3+K+9wzzo/RP9CY2aTZj/zfnZuGlVixoIyUqnRS8/4FcBRaaVZTaeKHvLr5
        Bfps/iMMOOiaBxbQA1hQTxFkSB5BfBFJl9UpSMFsC4dEA3Ha+K/AZttGdxivvzBjnmbhvHZ9KqDK5
        91MjTe3DC2qFQBFUoVKDak8vOVET3IO5Wpmi4qk4rfKhrR5MPZhgZEXL5UnlPzsISsumGB1qjCkzO
        mU30vp5xW4bDMp6uTqXR8cUgSvcHhmGsrkpUNBx20jPRA8hWIF3KyXbAHgS3An1SckSoTDQPcD0Cn
        7RbjZwMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4aVa-006WTR-Kv; Wed, 27 Jan 2021 02:24:41 +0000
Date:   Wed, 27 Jan 2021 02:24:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
Message-ID: <20210127022438.GQ308988@casper.infradead.org>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
 <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
 <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
 <4d3914e9-f448-8a86-9fc6-e71cec581115@oracle.com>
 <20210127000730.GB4605@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127000730.GB4605@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 08:07:30PM -0400, Jason Gunthorpe wrote:
> I'm looking at Matt's folio patches and see:
> 
> +static inline struct folio *next_folio(struct folio *folio)
> +{
> +       return folio + folio_nr_pages(folio);
> +}

This is a replacement for places that would do 'page++'.  eg it's
used by the bio iterator where we already checked that the phys addr
and the struct page are contiguous.

> And checking page_trans_huge_mapcount():
> 
> 	for (i = 0; i < thp_nr_pages(page); i++) {
> 		mapcount = atomic_read(&page[i]._mapcount) + 1;

I think we are guaranteed this for transparent huge pages.  At least
for now.  Zi Yan may have some thoughts for his work on 1GB transhuge
pages ...

> And we have the same logic in hmm_vma_walk_pud():
> 
> 	if (pud_huge(pud) && pud_devmap(pud)) {
> 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> 		for (i = 0; i < npages; ++i, ++pfn)
> 			hmm_pfns[i] = pfn | cpu_flags;
> 
> So, if page[n] does not access the tail pages of a compound we have
> many more people who are surprised by this than just GUP.
> 
> Where are these special rules for hugetlb compound tails documented?
> Why does it need to be like this? 
> 
> Isn't it saner to forbid a compound and its tails from being
> non-linear in the page array? That limits when compounds can be
> created, but seems more likely to happen than a full mm audit to find
> all the places that assume linearity.
> 
> Jason
