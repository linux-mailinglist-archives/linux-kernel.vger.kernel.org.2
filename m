Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AC631F869
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBSL2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:28:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:40834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhBSLZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:25:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613733895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lOOtfoPKE3BcGeguv92jXUEX7ahJX8CXJnXAjcq1auM=;
        b=vUpLLFtX5pt3E4q+IV/bVp4EkvDSaSxxtdGK8F/wywLbQpB4b8oEuL9pF4S5+pA7Jx2EWQ
        KGznwrWK9yktMtcxy/YWUsbUsaJkknjj5y5k2m1hP2SCReKR5ykl8/mdFs+2Ljo+DY8WSf
        A6s2KB45GB/wVlZsZn7QW9M9/FHHhbI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA0A1ACBF;
        Fri, 19 Feb 2021 11:24:55 +0000 (UTC)
Date:   Fri, 19 Feb 2021 12:24:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <YC+gBtcN1bE/kYFc@dhcp22.suse.cz>
References: <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
 <20210218100917.GA4842@localhost.localdomain>
 <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
 <20210218133250.GA7983@localhost.localdomain>
 <YC5yzNB9xT76fkod@dhcp22.suse.cz>
 <20210219090548.GA17266@linux>
 <YC+LWksScdiuPw7X@dhcp22.suse.cz>
 <20210219103943.GA19945@linux>
 <YC+ZBIwXKEZCy1Bk@dhcp22.suse.cz>
 <20210219111703.GA20286@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219111703.GA20286@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-02-21 12:17:11, Oscar Salvador wrote:
> On Fri, Feb 19, 2021 at 11:55:00AM +0100, Michal Hocko wrote:
> > It is not the lock that I care about but more about counters. The
> > intention was that there is a single place to handle both enqueing and
> > dequeing. As not all places require counters to be updated. E.g. the
> > migration which just replaces one page by another.
> 
> I see.
> alloc_fresh_huge_page->prep_new_huge_page increments h->nr_huge_pages{_node}
> counters.
> Which means:
> 
> >       new_page = alloc_fresh_huge_page();
> >       if (!new_page)
> >               goto fail;
> >       spin_lock(hugetlb_lock);
> >       if (!PageHuge(old_page)) {
> >               /* freed from under us, nothing to do */ 
> >               __update_and_free_page(new_page);
> 
> Here we need update_and_free_page, otherwise we would be leaving a stale value
> in h->nr_huge_pages{_node}. 
> 
> >               goto unlock;
> >       }
> >       list_del(&old_page->lru);
> >       __update_and_free_page(old_page);
> 
> Same here.
> 
> >       __enqueue_huge_page(new_page);
> 
> This is ok since h->free_huge_pages{_node} do not need to be updated.

Fair enough. I didn't get to think this through obviously, but you
should get the idea ;)
-- 
Michal Hocko
SUSE Labs
