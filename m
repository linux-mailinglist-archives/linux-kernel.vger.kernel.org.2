Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACD835EC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhDNEys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:54:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:55056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhDNEyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:54:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B958DB01D;
        Wed, 14 Apr 2021 04:54:25 +0000 (UTC)
Date:   Wed, 14 Apr 2021 06:54:23 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/7] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YHZ1f11qlGP+J2hP@localhost.localdomain>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-6-osalvador@suse.de>
 <338f73f5-cff6-61c1-5252-01d9b30be627@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338f73f5-cff6-61c1-5252-01d9b30be627@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 03:29:02PM -0700, Mike Kravetz wrote:
> >   spin_lock_irq(hugetlb_lock)
> >   1) update_and_free_page
> >        PageHuge() == F
> >        __free_pages()
> >   2) enqueue_huge_page
> >        SetPageHugeFreed()
> >   spin_unlock(&hugetlb_lock)
> 
> Very small nit, the above should be spin_unlock_irq(&hugetlb_lock)

Right, I missed it somehow.

> > +	/*
> > +	 * The page might have been dissolved from under our feet, so make sure
> > +	 * to carefully check the state under the lock.
> > +	 * Return success when racing as if we dissolved the page ourselves.
> > +	 */
> > +	spin_lock_irq(&hugetlb_lock);
> > +	if (PageHuge(page)) {
> > +		head = compound_head(page);
> > +		h = page_hstate(head);
> > +	} else {
> > +		spin_unlock(&hugetlb_lock);
> 
> Should be be spin_unlock_irq(&hugetlb_lock);
> 
> Other than that, it looks good.

Yeah, I will amend it in the next version.

Thanks Mike!


-- 
Oscar Salvador
SUSE L3
