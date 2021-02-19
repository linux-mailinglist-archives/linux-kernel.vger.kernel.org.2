Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17C331F734
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhBSKQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:16:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:55640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhBSKPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:15:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D735FACCF;
        Fri, 19 Feb 2021 10:14:34 +0000 (UTC)
Date:   Fri, 19 Feb 2021 11:14:32 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <20210219101427.GA19588@linux>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
 <20210218100917.GA4842@localhost.localdomain>
 <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
 <20210218133250.GA7983@localhost.localdomain>
 <YC5yzNB9xT76fkod@dhcp22.suse.cz>
 <20210219090548.GA17266@linux>
 <YC+LWksScdiuPw7X@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC+LWksScdiuPw7X@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 10:56:42AM +0100, Michal Hocko wrote:
> OK, this should work but I am really wondering whether it wouldn't be
> just simpler to replace the old page by a new one in the free list
> directly. Or is there any reason we have to go through the generic
> helpers path? I mean something like this
> 
> 	new_page = alloc_fresh_huge_page();
> 	if (!new_page)
> 		goto fail;
> 	spin_lock(hugetlb_lock);
> 	if (!PageHuge(old_page)) {
> 		/* freed from under us, nothing to do */ 
> 		__update_and_free_page(new_page);
> 		goto unlock;
> 	}
> 	list_del(&old_page->lru);
> 	__update_and_free_page(old_page);
> 	__enqueue_huge_page(new_page);
> unlock:
> 	spin_unlock(hugetlb_lock);
> 
> This will require to split update_and_free_page and enqueue_huge_page to
> counters independent parts but that shouldn't be a big deal. But it will
> also protect from any races. Not an act of beauty but seems less hackish
> to me.

Yes, I think this would to the trick, and it is race-free.
Let me play with it a bit and see what I can come up with.

Thanks for the valuable insight.

-- 
Oscar Salvador
SUSE L3
