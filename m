Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3549135ECDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348555AbhDNGEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:04:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348556AbhDNGEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:04:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618380262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+2Ssby07S60nylEFaEVC0kcFk8cqBXASSGiNOFJJrU=;
        b=aWs2owsBfcMfFsA6IhkWMGFmirqk8xYxoZ0kB9aAKkrbWFD8JCBrZue4VBgq1wIvNZqMPZ
        D0/nE+9oUBv8qZknzhEV4iyTQJ3U1V9KbfTfTrKOmBrb6oJsn1/Ga97ceTgbc2QHence/2
        2XopKsvIDA7NAFXG/vEquobGIQGsCgo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CF8DAD77;
        Wed, 14 Apr 2021 06:04:22 +0000 (UTC)
Date:   Wed, 14 Apr 2021 08:04:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
Message-ID: <YHaF5efHcJJ71UP9@dhcp22.suse.cz>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de>
 <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
 <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 14:19:03, Mike Kravetz wrote:
> On 4/13/21 6:23 AM, Michal Hocko wrote:
> > On Tue 13-04-21 12:47:43, Oscar Salvador wrote:
[...]
> > Or do we need it for giga pages which are not allocated by the page
> > allocator? If yes then moving it to prep_compound_gigantic_page would be
> > better.
> 
> I am pretty sure dynamically allocated giga pages have page->Private
> cleared as well.  It is not obvious, but the alloc_contig_range code
> used to put together giga pages will end up calling isolate_freepages_range
> that will call split_map_pages and then post_alloc_hook for each MAX_ORDER
> block.

Thanks for saving me from crawling that code.

> As mentioned, this is not obvious and I would hate to rely on this
> behavior not changing.

Thinking about it some more, having some (page granularity) allocator
not clearing page private would be a serious problem for anybody relying
on its state. So I am not sure this can change.
 
> > So should we just drop it here?
> 
> The only place where page->private may not be initialized is when we do
> allocations at boot time from memblock.  In this case, we will add the
> pages to the free list via put_page/free_huge_page so the appropriate
> flags will be cleared before anyone notices.

Pages allocated by the bootmem should be pre initialized from the boot,
no?

> I'm wondering if we should just do a set_page_private(page, 0) here in
> prep_new_huge_page since we now use that field for flags.  Or, is that
> overkill?

I would rather not duplicate the work done by underlying allocators. I
do not think other users of the allocator want to do the same so why
should hugetlb be any different.
-- 
Michal Hocko
SUSE Labs
