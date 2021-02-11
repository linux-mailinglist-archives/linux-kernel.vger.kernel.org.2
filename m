Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397C0319543
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBKVjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:39:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:47368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhBKVjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:39:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6577CAE91;
        Thu, 11 Feb 2021 21:38:26 +0000 (UTC)
Date:   Thu, 11 Feb 2021 22:38:23 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm,page_alloc: Make alloc_contig_range handle
 free hugetlb pages
Message-ID: <20210211213823.GB3597@localhost.localdomain>
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-3-osalvador@suse.de>
 <5a6c0efb-4667-c382-8c3e-fd95b6ae839e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a6c0efb-4667-c382-8c3e-fd95b6ae839e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 05:16:29PM -0800, Mike Kravetz wrote:
> Should probably check for -EBUSY as this means someone started using
> the page while we were allocating a new one.  It would complicate the
> code to try and do the 'right thing'.  Right thing might be getting
> dissolving the new pool page and then trying to isolate this in use
> page.  Of course things could change again while you are doing that. :(

Yeah, I kept the error handling rather low just be clear about the
approach I was leaning towards, but yes, we should definitely check
for -EBUSY on dissolve_free_huge_page().

And it might be that dissolve_free_huge_page() returns -EBUSY on the old
page, and we need to dissolve the freshly allocated one as it is not
going to be used, and that might fail as well due to reserves for
instance, or maybe someone started using it?
I have to confess that I need to check the reservation code closer to be
aware of corner cases.

We used to try to be clever in such situations in memory-failure code,
but at some point you end up thinking "ok, how many retries are
considered enough?".
That code was trickier as we were handling uncorrected/corrected memory
errors, so we strived to do our best, but here we can be more flexible
as the whole thing is racy per se, and just fail if we find too many
obstacles.

I shall resume work early next week. 

Thanks for the tips ;-)

-- 
Oscar Salvador
SUSE L3
