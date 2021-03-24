Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5183D347D41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhCXQEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:04:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:41932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236916AbhCXQE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:04:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616601865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V9iPv8fbewkZMzGZxeZestui1eX3Pr0sLFCxpSUHIGA=;
        b=SzXzWY6VpAKj6d9RwukPRmT/120eOmJvA7d+Ytlr7a8IQCgTXoYZ/Gtltj0JQADg/SHYQs
        ugIWvf8CnRwu+oO3mDrG44qvXGveUg5BCjFL92i7rpiSuFfR7Xqpq8KKGwv3f15c0RcHFq
        k+npGZqwYbZKkVHbQYhBtAeCOg5XZ44=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CABDAD80;
        Wed, 24 Mar 2021 16:04:25 +0000 (UTC)
Date:   Wed, 24 Mar 2021 17:04:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 15:52:38, David Hildenbrand wrote:
> On 24.03.21 15:42, Michal Hocko wrote:
> > On Wed 24-03-21 13:03:29, Michal Hocko wrote:
> > > On Wed 24-03-21 11:12:59, Oscar Salvador wrote:
> > [...]
> > > > I kind of understand to be reluctant to use vmemmap_pages terminology here, but
> > > > unfortunately we need to know about it.
> > > > We could rename nr_vmemmap_pages to offset_buddy_pages or something like that.
> > > 
> > > I am not convinced. It seems you are justr trying to graft the new
> > > functionality in. But I still believe that {on,off}lining shouldn't care
> > > about where their vmemmaps come from at all. It should be a
> > > responsibility of the code which reserves that space to compansate for
> > > accounting. Otherwise we will end up with a hard to maintain code
> > > because expectations would be spread at way too many places. Not to
> > > mention different pfns that the code should care about.
> > 
> > The below is a quick hack on top of this patch to illustrate my
> > thinking. I have dug out all the vmemmap pieces out of the
> > {on,off}lining and hooked all the accounting when the space is reserved.
> > This just compiles without any deeper look so there are likely some
> > minor problems but I haven't really encountered any major problems or
> > hacks to introduce into the code. The separation seems to be possible.
> > The diffstat also looks promising. Am I missing something fundamental in
> > this?
> > 
> 
> From a quick glimpse, this touches on two things discussed in the past:
> 
> 1. If the underlying memory block is offline, all sections are offline. Zone
> shrinking code will happily skip over the vmemmap pages and you can end up
> with out-of-zone pages assigned to the zone. Can happen in corner cases.

You are right. But do we really care? Those pages should be of no
interest to anybody iterating through zones/nodes anyway.

> There is no way to know that the memmap of these pages was initialized and
> is of value.
> 
> 2. You heavily fragment zone layout although you might end up with
> consecutive zones (e.g., online all hotplugged memory movable)

What would be consequences?

-- 
Michal Hocko
SUSE Labs
