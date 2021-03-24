Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5578A347E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhCXQut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:50:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236600AbhCXQu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:50:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616604625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p896MMjCXKF7WbFHC1Pv0dLoztsugQ2zM49PvrwbtpU=;
        b=RS92b6YxaBBHvVYi8Xl7jczc15olHnDz/6vFsgQT0RCaEilJPP5oWB3ptbhLRvXYb+o/53
        UBvnQak+Z1+eIOxGB5+pWPxQx7CFKpaEJDx30YfAKbJWEfSDN7ZA5vpU8MkLe/CY/9deMd
        w9RXrwfDujAqQq7PDRXGVzbg+ZqxNMo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFFF6AC1D;
        Wed, 24 Mar 2021 16:50:25 +0000 (UTC)
Date:   Wed, 24 Mar 2021 17:50:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 5/8] hugetlb: change free_pool_huge_page to
 remove_pool_huge_page
Message-ID: <YFtt0IgJ0lnCxJ0O@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-6-mike.kravetz@oracle.com>
 <YFiqJSGjMMG3diWp@dhcp22.suse.cz>
 <fd723ea8-da7c-bd59-8d8a-e506be1b3af5@oracle.com>
 <YFmfegQjCKuY05jy@dhcp22.suse.cz>
 <d1fb9303-0053-947d-e714-c9414c456a08@oracle.com>
 <YFr7EbGx25KsYfVg@dhcp22.suse.cz>
 <43595c4b-7f3f-f812-b4fe-66c900718e85@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43595c4b-7f3f-f812-b4fe-66c900718e85@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 09:38:17, Mike Kravetz wrote:
> On 3/24/21 1:40 AM, Michal Hocko wrote:
> > On Tue 23-03-21 18:03:07, Mike Kravetz wrote:
> > [...]
> >> Since you brought up cgroups ... what is your opinion on lock hold time
> >> in hugetlb_cgroup_css_offline?  We could potentially be calling
> >> hugetlb_cgroup_move_parent for every hugetlb page while holding the lock
> >> with interrupts disabled.
> > 
> > I am not familiar with hugetlb cgroup code TBH. But from a quick look
> > there is not much of heavy lifting there. If we find out that this is
> > really visible we can do the lock dance with cond_resched and retry with
> > the iteration again. Or is there any strong reason to process the list
> > in a single go?
> 
> AFAICT, the primary reason for processing the list in a single go is
> that the lock protects the list.  If you drop the lock, the list can
> change ...
> 
> I have come up with a (not so pretty) way of processing the list in
> batches of pages.  But, I dod not want to introduce that if there is no
> need.  Perhaps just take a wait and see approach for now.
> 
> I'll see if I can come up with some timing information to determine
> if/when we may have an issue.

I wouldn't bother at this stage. This can be done on top.
-- 
Michal Hocko
SUSE Labs
