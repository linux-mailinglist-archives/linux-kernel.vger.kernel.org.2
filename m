Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF59431F653
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhBSJL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:11:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:41234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhBSJGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:06:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48FC6AEDA;
        Fri, 19 Feb 2021 09:05:56 +0000 (UTC)
Date:   Fri, 19 Feb 2021 10:05:53 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <20210219090548.GA17266@linux>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
 <20210218100917.GA4842@localhost.localdomain>
 <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
 <20210218133250.GA7983@localhost.localdomain>
 <YC5yzNB9xT76fkod@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC5yzNB9xT76fkod@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 02:59:40PM +0100, Michal Hocko wrote:
> > It should be:
> > 
> >  allocate_a_new_page (new_page's refcount = 1)
> >  put_page(new_page); (new_page's refcount = 0)
> >  dissolve_old_page
> >   : if fail
> >      dissolve_new_page (we can dissolve it as refcount == 0)
> > 
> > I hope this clarifies it .
> 
> OK, I see the problem now. And your above solution is not really
> optimal either. Your put_page would add the page to the pool and so it
> could be used by somebody. One way around it would be either directly
> manipulating reference count which is fugly or you can make it a
> temporal page (alloc_migrate_huge_page) or maybe even better not special
> case this here but rather allow migrating free hugetlb pages in the
> migrate_page path.

I have been weighting up this option because it seemed the most clean way to
proceed. Having the hability to migrate free hugepages directly from migrate_page
would spare us this function.
But there is a problem. migrate_pages needs the pages to be on a list (by
page->lru). That is no problem for used pages, but for freehugepages we would
have to remove the page from hstate->hugepage_freelists, meaning that if userspace
comes along and tries to get a hugepage (a hugepage he previously allocated by
e.g: /proc/sys/.../nr_hugepages), it will fail.

So I am not really sure we can go this way. Unless we are willing to accept
that temporary userspace can get ENOMEM if it tries to use a hugepage, which
I do not think it is a good idea.
Another way to go would be to make up for the free hugepages to be migrated and
allocate the same amount, but that starts to go down a rabbit hole.

I yet need to give it some more spins, but all in all, I think the easiest way
forward way might be to do something like:

alloc_and_dissolve_huge_page {

   new_page = alloc_fresh_huge_page(h, gfp_mask, nid, NULL, NULL);
   if (new_page) {
           /*
            * Put the page in the freelist hugepage pool.
            * We might race with someone coming by and grabbing the page,
            * but that is fine since we mark the page as Temporary in case
            * both old and new_page fail to be dissolved, so new_page
            * will be freed when its last reference is gone.
            */
           put_page(new_page);
      
           if (!dissolve_free_huge_page(page)) {
                   /*
                    * Old page could be dissolved.
                    */
                   ret = true;
           } else if (dissolve_free_huge_page(new_page)) {
                  /*
                   * Page might have been dissolved by admin by doing
                   * "echo 0 > /proc/../nr_hugepages". Check it before marking
                   * the page.
                   */
                  spin_lock(&hugetlb_lock);
                  /* Mark the page Temporary in case we fail to dissolve both
                   * the old page and new_page. It will be freed when the last
                   * user drops it.
                   */
                  if (PageHuge(new_page))
                          SetPageHugeTemporary(new_page);
                  spin_unlock(&hugetlb_lock);
           }
   }

There is one more thing to cover though.
Between the dissolve_free_huge_page(new_page) and the PageHuge check, the
page might have been freed, and so enqueued (because we did not mark it as 
Temporary yet). If that is the case, we would later mark the page as Temporary
being in the freepool, not nice.

One way out would be to pass a boolean parameter to dissolve_free_huge_page(),
that tells whether the page should be marked Temporary in case the operation fails.
That would ease things a lot because __everything__ is being done under the lock,
which means the page cannot go away in the meantime.

Just my thoughts.

What do you think?


-- 
Oscar Salvador
SUSE L3
