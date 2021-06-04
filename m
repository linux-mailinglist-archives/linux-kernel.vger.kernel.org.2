Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F839BF04
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDRpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFDRpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:45:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9713AC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kPfCKHq5qPuRR/PUNf7xuTzUEgaFOPuNN665O2fOMb8=; b=myO+bgIXWgBFx0ToWrp8epd0iT
        kfK1VwZpcy51yLbEkaB4cLS8u0+vhijn5MNItIyGWP0ghJud/I3EOhRPR7NaeeNny3NZJmTsu5Ur0
        728HuDF+JH506DQqNvtdknj5HjQsQ891j40UgissulFjj+Ide7LU5iBCE3n6I3tua1MY9xufPEgZU
        MDJYFd9lPAyFGSof9UROVj96LsIOqcFYIUkt/rand/gXFLckqJUiYzhZHn7kZ4ph4H0/OasF41z20
        Po0Jy6rmSztfSkzW/hRGmGBCgZQwO2OPpx2m2eV7zrZqZqmY309QXyCc0EbCdXxdOfrWncsYkFy7w
        DDXtllew==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lpDq5-00DRHH-0D; Fri, 04 Jun 2021 17:42:36 +0000
Date:   Fri, 4 Jun 2021 18:42:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm/thp: fix page_vma_mapped_walk() if huge page
 mapped by ptes
Message-ID: <YLpmCBhmQcAayzCF@casper.infradead.org>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011411290.2148@eggly.anvils>
 <20210604162402.iclcdd3ywynkoamy@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604162402.iclcdd3ywynkoamy@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 07:24:02PM +0300, Kirill A. Shutemov wrote:
> >  		/* when pud is not present, pte will be NULL */
> > -		pvmw->pte = huge_pte_offset(mm, pvmw->address, page_size(page));
> > +		pvmw->pte = huge_pte_offset(mm, pvmw->address,
> > +					    page_size(pvmw->page));
> 
> AFAICS, it exactly fits into 80-column.

.. not after putting the 'pvmw->' before 'page'.

> >  		if (!pvmw->pte)
> >  			return false;
> >  
> > -		pvmw->ptl = huge_pte_lockptr(page_hstate(page), mm, pvmw->pte);
> > +		pvmw->ptl = huge_pte_lockptr(page_hstate(pvmw->page),
> > +					     mm, pvmw->pte);
> 
> And this one end on 79.

likewise.  I mean, the 'mm' could go on the previous line, but that's
beyond my level of code format caring.
