Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62335EC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 07:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbhDNFAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 01:00:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:56184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhDNFAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 01:00:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B040ABB1;
        Wed, 14 Apr 2021 04:59:50 +0000 (UTC)
Date:   Wed, 14 Apr 2021 06:59:48 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] mm,hugetlb: Split prep_new_huge_page functionality
Message-ID: <YHZ2xCeo+aVgD28c@localhost.localdomain>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-5-osalvador@suse.de>
 <94992151-03fc-dedd-3e09-811908d26d04@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94992151-03fc-dedd-3e09-811908d26d04@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:33:41PM -0700, Mike Kravetz wrote:
> > -static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> > +/*
> > + * Must be called with the hugetlb lock held
> > + */
> > +static void __prep_account_new_huge_page(struct hstate *h, int nid)
> > +{
> > +	h->nr_huge_pages++;
> > +	h->nr_huge_pages_node[nid]++;
> 
> I would prefer if we also move setting the destructor to this routine.
> 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);

Uhm, but that is the routine that does the accounting, it feels wrong
here, plus...

> 
> That way, PageHuge() will be false until it 'really' is a huge page.
> If not, we could potentially go into that retry loop in
> dissolve_free_huge_page or alloc_and_dissolve_huge_page in patch 5.

...I do not follow here, could you please elaborate some more?
Unless I am missing something, behaviour should not be any different with this
patch.

Thanks


-- 
Oscar Salvador
SUSE L3
