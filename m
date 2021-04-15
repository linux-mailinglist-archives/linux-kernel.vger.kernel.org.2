Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAD7360443
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhDOIaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:30:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:38514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhDOI37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:29:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06EC4AE72;
        Thu, 15 Apr 2021 08:29:36 +0000 (UTC)
Date:   Thu, 15 Apr 2021 10:29:33 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/7] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YHf5bW9GTxeSwfZN@localhost.localdomain>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-6-osalvador@suse.de>
 <YHWfQjegLi4xekhM@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHWfQjegLi4xekhM@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 03:40:18PM +0200, Michal Hocko wrote:
> > +		/*
> > +		 * Call __prep_new_huge_page() to construct the hugetlb page, and
> > +		 * enqueue it then to place it in the freelists. After this,
> > +		 * counters are back on track. Free hugepages have a refcount of 0,
> > +		 * so we need to decrease new_page's count as well.
> > +		 */
> > +		__prep_new_huge_page(new_page);
> > +		__prep_account_new_huge_page(h, nid);
> 
> I think it would help to put something like the following into the
> comment above this really strange construct.
> 
> 		/*
> 		 * new_page needs to be initialized with the standard
> 		 * hugetlb state. This is normally done by
> 		 * prep_new_huge_page but that takes hugetlb_lock which
> 		 * is already held so we need to open code it here.
> 		 * Reference count trick is needed because allocator
> 		 * gives us referenced page but the pool requires pages
> 		 * with 0 refcount.
> 		 */

Ok, I will try to add more info, thanks Michal!

-- 
Oscar Salvador
SUSE L3
