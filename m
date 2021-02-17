Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1C31DADD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhBQNnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:43:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:46016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233401AbhBQNnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:43:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55C69B75E;
        Wed, 17 Feb 2021 13:42:28 +0000 (UTC)
Date:   Wed, 17 Feb 2021 14:42:26 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <20210217134221.GA32488@linux>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0agxVWYRKGm5IO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC0agxVWYRKGm5IO@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 02:30:43PM +0100, Michal Hocko wrote:
> On Wed 17-02-21 11:08:15, Oscar Salvador wrote:
> I do not think fallback to a different zone is ok. If yes then this
> really requires a very good reasoning. alloc_contig_range is an
> optimistic allocation interface at best and it shouldn't break carefully
> node aware preallocation done by administrator.

Yeah, previous version (RFC) was more careful with that.
I somehow thought that it might be ok to fallback to other nodes in case
we failed to allocate on the preferred nid.

I will get RFC handling back wrt. allocation once I gather more feedback.

> 
> > Note that gigantic hugetlb pages are fenced off since there is a cyclic
> > dependency between them and alloc_contig_range.
> 
> Why do we need/want to do all this in the first place?

When trying to allocate a memory chunk with alloc_contig_range, it will fail
if it ever sees a Hugetlb page because isolate_migratepages_range() does not
"recognize" those for migration (or to put it different, does not know about
them).

Given that HugeTLB pages can be migrated or dissolved if free, it makes sense
to enable isolate_migratepages_range() to recognize HugeTLB pages in order
to handle them, as it currently does with LRU and Movable pages.

-- 
Oscar Salvador
SUSE L3
