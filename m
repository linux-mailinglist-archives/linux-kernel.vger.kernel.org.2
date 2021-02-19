Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A5931F6E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBSJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:57:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:48752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhBSJ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:57:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613728603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pSIhQidfu0Q5u3LjyNZr9MXzltQyM//XcNXBDgi7F4=;
        b=kpQ8XcU0aoviZ9pVMeuuBUzY6fz6Q9b+o4iTGbAA1ERcc5Awt+ZtIEnTNkFgVad6aAsswk
        nH803hFI+HUS7rLEGYZklC+5wJEeqkdBAdSF2Kj7sfON/9e7p9xY9oQc2hRsNB5yIZLs0K
        LWNo8AwWLVJTD9rdV9AsAEN6T47r+Jg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ACD74ACBF;
        Fri, 19 Feb 2021 09:56:43 +0000 (UTC)
Date:   Fri, 19 Feb 2021 10:56:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <YC+LWksScdiuPw7X@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
 <20210218100917.GA4842@localhost.localdomain>
 <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
 <20210218133250.GA7983@localhost.localdomain>
 <YC5yzNB9xT76fkod@dhcp22.suse.cz>
 <20210219090548.GA17266@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219090548.GA17266@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-02-21 10:05:53, Oscar Salvador wrote:
> On Thu, Feb 18, 2021 at 02:59:40PM +0100, Michal Hocko wrote:
> > > It should be:
> > > 
> > >  allocate_a_new_page (new_page's refcount = 1)
> > >  put_page(new_page); (new_page's refcount = 0)
> > >  dissolve_old_page
> > >   : if fail
> > >      dissolve_new_page (we can dissolve it as refcount == 0)
> > > 
> > > I hope this clarifies it .
> > 
> > OK, I see the problem now. And your above solution is not really
> > optimal either. Your put_page would add the page to the pool and so it
> > could be used by somebody. One way around it would be either directly
> > manipulating reference count which is fugly or you can make it a
> > temporal page (alloc_migrate_huge_page) or maybe even better not special
> > case this here but rather allow migrating free hugetlb pages in the
> > migrate_page path.
> 
> I have been weighting up this option because it seemed the most clean way to
> proceed. Having the hability to migrate free hugepages directly from migrate_page
> would spare us this function.
> But there is a problem. migrate_pages needs the pages to be on a list (by
> page->lru). That is no problem for used pages, but for freehugepages we would
> have to remove the page from hstate->hugepage_freelists, meaning that if userspace
> comes along and tries to get a hugepage (a hugepage he previously allocated by
> e.g: /proc/sys/.../nr_hugepages), it will fail.

Good point. I should have realized that.
 
> So I am not really sure we can go this way. Unless we are willing to accept
> that temporary userspace can get ENOMEM if it tries to use a hugepage, which
> I do not think it is a good idea.

No, this is not acceptable.

> Another way to go would be to make up for the free hugepages to be migrated and
> allocate the same amount, but that starts to go down a rabbit hole.
> 
> I yet need to give it some more spins, but all in all, I think the easiest way
> forward way might be to do something like:
> 
> alloc_and_dissolve_huge_page {
> 
>    new_page = alloc_fresh_huge_page(h, gfp_mask, nid, NULL, NULL);
>    if (new_page) {
>            /*
>             * Put the page in the freelist hugepage pool.
>             * We might race with someone coming by and grabbing the page,
>             * but that is fine since we mark the page as Temporary in case
>             * both old and new_page fail to be dissolved, so new_page
>             * will be freed when its last reference is gone.
>             */
>            put_page(new_page);
>       
>            if (!dissolve_free_huge_page(page)) {
>                    /*
>                     * Old page could be dissolved.
>                     */
>                    ret = true;
>            } else if (dissolve_free_huge_page(new_page)) {
>                   /*
>                    * Page might have been dissolved by admin by doing
>                    * "echo 0 > /proc/../nr_hugepages". Check it before marking
>                    * the page.
>                    */
>                   spin_lock(&hugetlb_lock);
>                   /* Mark the page Temporary in case we fail to dissolve both
>                    * the old page and new_page. It will be freed when the last
>                    * user drops it.
>                    */
>                   if (PageHuge(new_page))
>                           SetPageHugeTemporary(new_page);
>                   spin_unlock(&hugetlb_lock);
>            }
>    }

OK, this should work but I am really wondering whether it wouldn't be
just simpler to replace the old page by a new one in the free list
directly. Or is there any reason we have to go through the generic
helpers path? I mean something like this

	new_page = alloc_fresh_huge_page();
	if (!new_page)
		goto fail;
	spin_lock(hugetlb_lock);
	if (!PageHuge(old_page)) {
		/* freed from under us, nothing to do */ 
		__update_and_free_page(new_page);
		goto unlock;
	}
	list_del(&old_page->lru);
	__update_and_free_page(old_page);
	__enqueue_huge_page(new_page);
unlock:
	spin_unlock(hugetlb_lock);

This will require to split update_and_free_page and enqueue_huge_page to
counters independent parts but that shouldn't be a big deal. But it will
also protect from any races. Not an act of beauty but seems less hackish
to me.
-- 
Michal Hocko
SUSE Labs
