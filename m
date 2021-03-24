Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47BE3473D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhCXIns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:43:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:42284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234262AbhCXInk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:43:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616575418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cnv9o+YxLuD1qTXpONvaw+ySFYu0LbsCuQMUfJJE1Cg=;
        b=Ret7YQUa5IX1n2tf18nAekK9Ytlnb01tMiYfFXmVQ5o/MepwPrvX6QLPn7KTFZGHuWb0m9
        oVkdD967+yLGE4J0D7XuGrxuywONddWngf50BUocjllnA92+uczBQcTn/clWMDxHLtfr8H
        AA9xojLofYGWNQp8WeiyBMHRMiYVe4k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC1ADAB9B;
        Wed, 24 Mar 2021 08:43:38 +0000 (UTC)
Date:   Wed, 24 Mar 2021 09:43:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 7/8] hugetlb: add update_and_free_page_no_sleep for
 irq context
Message-ID: <YFr7t1a+gEvLPuAw@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-8-mike.kravetz@oracle.com>
 <YFhYHZ9onwdZMeDi@hirez.programming.kicks-ass.net>
 <2383057a-29dc-383b-720f-7cdcdd015e40@oracle.com>
 <YFjdpDwKaqwvW1I9@carbon.dhcp.thefacebook.com>
 <8a28c691-1e7c-1463-9d59-da31a2926adc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a28c691-1e7c-1463-9d59-da31a2926adc@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-03-21 11:51:04, Mike Kravetz wrote:
> On 3/22/21 11:10 AM, Roman Gushchin wrote:
> > On Mon, Mar 22, 2021 at 10:42:23AM -0700, Mike Kravetz wrote:
> >> Cc: Roman, Christoph
> >>
> >> On 3/22/21 1:41 AM, Peter Zijlstra wrote:
> >>> On Fri, Mar 19, 2021 at 03:42:08PM -0700, Mike Kravetz wrote:
> >>>> The locks acquired in free_huge_page are irq safe.  However, in certain
> >>>> circumstances the routine update_and_free_page could sleep.  Since
> >>>> free_huge_page can be called from any context, it can not sleep.
> >>>>
> >>>> Use a waitqueue to defer freeing of pages if the operation may sleep.  A
> >>>> new routine update_and_free_page_no_sleep provides this functionality
> >>>> and is only called from free_huge_page.
> >>>>
> >>>> Note that any 'pages' sent to the workqueue for deferred freeing have
> >>>> already been removed from the hugetlb subsystem.  What is actually
> >>>> deferred is returning those base pages to the low level allocator.
> >>>
> >>> So maybe I'm stupid, but why do you need that work in hugetlb? Afaict it
> >>> should be in cma_release().
> >>
> >> My thinking (which could be totally wrong) is that cma_release makes no
> >> claims about calling context.  From the code, it is pretty clear that it
> >> can only be called from task context with no locks held.  Although,
> >> there could be code incorrectly calling it today hugetlb does.  Since
> >> hugetlb is the only code with this new requirement, it should do the
> >> work.
> >>
> >> Wait!!!  That made me remember something.
> >> Roman had code to create a non-blocking version of cma_release().
> >> https://lore.kernel.org/linux-mm/20201022225308.2927890-1-guro@fb.com/
> >>
> >> There were no objections, and Christoph even thought there may be
> >> problems with callers of dma_free_contiguous.
> >>
> >> Perhaps, we should just move forward with Roman's patches to create
> >> cma_release_nowait() and avoid this workqueue stuff?
> > 
> > Sounds good to me. If it's the preferred path, I can rebase and resend
> > those patches (they been carried for some time by Zi Yan for his 1GB THP work,
> > but they are completely independent).
> 
> Thanks Roman,
> 
> Yes, this is the preferred path.  If there is a non blocking version of
> cma_release, then it makes fixup of hugetlb put_page path much easier.

I do not object to the plan I just want to point out that the sparse
vmemmap for hugetlb pages will need to recognize sleep/nosleep variants
of the freeing path as well to handle its vmemmap repopulate games.

-- 
Michal Hocko
SUSE Labs
