Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE98631DAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhBQNvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:51:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:50274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbhBQNvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:51:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613569828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LJwaVsNSdE6pGCu42lC4Cr77EcHivp6g9WAAtymIv4g=;
        b=s6GwlmutP0OO1buPuwUcMPcNUBshhtdznCjLE2fl6CjSgq2EADJM6PWgLhIXF0pSKvGqxU
        nvPilNP17O3xu7/0/R+bs2j56CNYJv+FU8lYwYKYP9LmVXT/XzI+SkEmgZYAHZnoCAal3n
        qhZPgs5jRhW0bfMqyfbR7OmkJb3JH94=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE58EB761;
        Wed, 17 Feb 2021 13:50:28 +0000 (UTC)
Date:   Wed, 17 Feb 2021 14:50:26 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <YC0fIhEHRDOVzK8U@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0agxVWYRKGm5IO@dhcp22.suse.cz>
 <182f6a4a-6f95-9911-7730-8718ab72ece2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182f6a4a-6f95-9911-7730-8718ab72ece2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-02-21 14:36:47, David Hildenbrand wrote:
> On 17.02.21 14:30, Michal Hocko wrote:
> > On Wed 17-02-21 11:08:15, Oscar Salvador wrote:
> > > Free hugetlb pages are tricky to handle so as to no userspace application
> > > notices disruption, we need to replace the current free hugepage with
> > > a new one.
> > > 
> > > In order to do that, a new function called alloc_and_dissolve_huge_page
> > > is introduced.
> > > This function will first try to get a new fresh hugetlb page, and if it
> > > succeeds, it will dissolve the old one.
> > > 
> > > With regard to the allocation, since we do not know whether the old page
> > > was allocated on a specific node on request, the node the old page belongs
> > > to will be tried first, and then we will fallback to all nodes containing
> > > memory (N_MEMORY).
> > 
> > I do not think fallback to a different zone is ok. If yes then this
> > really requires a very good reasoning. alloc_contig_range is an
> > optimistic allocation interface at best and it shouldn't break carefully
> > node aware preallocation done by administrator.
> 
> What does memory offlining do when migrating in-use hugetlbfs pages? Does it
> always keep the node?

No it will break the node pool. The reasoning behind that is that
offlining is an explicit request from the userspace and it is expected
to break affinities because it is a destructive action from the memory
capacity point of view. It is impossible to have former affinity while
you are cutting the memory off under its user.

> I think keeping the node is the easiest/simplest approach for now.
> 
> > 
> > > Note that gigantic hugetlb pages are fenced off since there is a cyclic
> > > dependency between them and alloc_contig_range.
> > 
> > Why do we need/want to do all this in the first place?
> 
> cma and virtio-mem (especially on ZONE_MOVABLE) really want to handle
> hugetlbfs pages.

Do we have any real life examples? Or does this fall more into, let's
optimize an existing implementation category.
-- 
Michal Hocko
SUSE Labs
