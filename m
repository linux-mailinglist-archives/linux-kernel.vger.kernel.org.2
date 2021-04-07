Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74463566AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349606AbhDGIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:22:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234059AbhDGIVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617783700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m3JZQ76Lk/bU7ik3mcWkmrq+4nBKvW17MCmmVyxB7lw=;
        b=FUYhfplpuretZ8z4Ls3TdJEHgyq3WTcTUH14CnOnGd38WZf7oMYTp2fMHEho8RhLwENHvS
        1fKX2nNGb83WPGqtSfof+Xyl1vHsyoXpe5drYDEjrvrx6rJ/ZNZ+OXs4mI7/quAyWa0yBG
        hbzs0OXvyrV2ft2xA2zbXlji3bLfFVE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 533BDB03B;
        Wed,  7 Apr 2021 08:21:40 +0000 (UTC)
Date:   Wed, 7 Apr 2021 10:21:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
Message-ID: <YG1rkScNu7ILsgLK@dhcp22.suse.cz>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-5-mike.kravetz@oracle.com>
 <YGwwO0galuKQsD0J@dhcp22.suse.cz>
 <b684d7bc-4c59-0beb-3af7-a75e76e77a87@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b684d7bc-4c59-0beb-3af7-a75e76e77a87@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-04-21 09:49:13, Mike Kravetz wrote:
> On 4/6/21 2:56 AM, Michal Hocko wrote:
> > On Mon 05-04-21 16:00:39, Mike Kravetz wrote:
[...]
> >> @@ -2298,6 +2312,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
> >>  		/*
> >>  		 * Freed from under us. Drop new_page too.
> >>  		 */
> >> +		remove_hugetlb_page(h, new_page, false);
> >>  		update_and_free_page(h, new_page);
> >>  		goto unlock;
> >>  	} else if (page_count(old_page)) {
> >> @@ -2305,6 +2320,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
> >>  		 * Someone has grabbed the page, try to isolate it here.
> >>  		 * Fail with -EBUSY if not possible.
> >>  		 */
> >> +		remove_hugetlb_page(h, new_page, false);
> >>  		update_and_free_page(h, new_page);
> >>  		spin_unlock(&hugetlb_lock);
> >>  		if (!isolate_huge_page(old_page, list))
> > 
> > the page is not enqued anywhere here so remove_hugetlb_page would blow
> > when linked list debugging is enabled.
> 
> I also thought this would be an issue.  However, INIT_LIST_HEAD would
> have been called for the page so,

OK, this is true for a freshly allocated hugetlb page (prep_new_huge_page.
It's a very sublte dependency though. In case somebody ever wants to
fortify linked lists and decides to check list_del on an empty list then
this would wait silently to blow up.

> Going forward, I agree it would be better to perhaps add a list_empty
> check so that things do not blow up if the debugging code is changed.

Yes this is less tricky then a bool flag or making more stages of the
tear down. 2 stages are more than enough IMHO.

> At one time I also thought of splitting the functionality in
> alloc_fresh_huge_page and prep_new_huge_page so that it would only
> allocate/prep the page but not increment nr_huge_pages.

We already have that distinction. alloc_buddy_huge_page is there to
allocate a fresh huge page without any hstate  accunting. Considering
that giga pages are not supported for the migration anyway, maybe this
would make Oscar's work slightly less tricky?
-- 
Michal Hocko
SUSE Labs
