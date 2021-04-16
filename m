Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9D361F93
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbhDPMOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:14:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:37450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232130AbhDPMOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:14:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EEB0B035;
        Fri, 16 Apr 2021 12:14:10 +0000 (UTC)
Date:   Fri, 16 Apr 2021 14:14:04 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v9 5/7] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YHl/jDs/TDg3in4I@localhost.localdomain>
References: <20210416070023.4742-1-osalvador@suse.de>
 <20210416070023.4742-6-osalvador@suse.de>
 <20210416094920.GA8560@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416094920.GA8560@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:49:20PM +0800, Baoquan He wrote:
> On 04/16/21 at 09:00am, Oscar Salvador wrote:
> ...  
> > +/*
> > + * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
> > + * @h: struct hstate old page belongs to
> > + * @old_page: Old page to dissolve
> > + * Returns 0 on success, otherwise negated error.
> > + */
> > +static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
> > +{
> > +	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> > +	int nid = page_to_nid(old_page);
> > +	struct page *new_page;
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * Before dissolving the page, we need to allocate a new one for the
> > +	 * pool to remain stable. Using alloc_buddy_huge_page() allows us to
> > +	 * not having to deal with prep_new_page() and avoids dealing of any
> 				   ~ prep_new_huge_page() ?

Yep, clumsy.
@Andrew: could you please amend that or should I send a new version?

Thanks

-- 
Oscar Salvador
SUSE L3
