Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1331669C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhBJM1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:27:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:58964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhBJMX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:23:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612959791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dsqc8ndJdURpL2hssLBy0cKI35i8iQHpKXZ5s9miM54=;
        b=Gwrjv6r+Ug52YikQrv8w1KdjcXPsc4u2zdbH8P4PWBeGlz0o8NjmprdDO3TjIcmfIMBsRB
        9e95oVVNUsDnWNRer+IMs419+lpFOKDszcrS1khEvQv24F5cHhF174xQRJrE5Wn2NifYCj
        XnUZKazgkdiOIve3hGp3LkOuR6ppgYM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BEF6AAC97;
        Wed, 10 Feb 2021 12:23:11 +0000 (UTC)
Date:   Wed, 10 Feb 2021 13:23:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: remove lru_add_drain_all in alloc_contig_range
Message-ID: <YCPQLkmxLX1Zli9C@dhcp22.suse.cz>
References: <20210209175048.361638-1-minchan@kernel.org>
 <accc057c-e639-7510-f722-4a4d166c80b6@redhat.com>
 <20210209190332.GA3363@localhost.localdomain>
 <49491777-6d61-db4d-5e90-7a8b9045faca@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49491777-6d61-db4d-5e90-7a8b9045faca@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-02-21 13:17:33, Vlastimil Babka wrote:
> On 2/9/21 8:03 PM, Oscar Salvador wrote:
> > On Tue, Feb 09, 2021 at 07:17:59PM +0100, David Hildenbrand wrote:
> >> I was expecting some magical reason why this is still required but I am not
> >> able to find a compelling one. Maybe this is really some historical
> >> artifact.
> >> 
> >> Let's see if other people know why this call here still exists.
> > 
> > I also stumbled upon this while working on adding hugetlb support for
> > alloc_acontig_range [1].
> > I have to confess I puzzled me a bit.
> > 
> > I saw it going back to when the function was first introduced by 
> > 
> > commit 041d3a8cdc18dc375a128d90bbb753949a81b1fb
> > Author: Michal Nazarewicz <mina86@mina86.com>
> > Date:   Thu Dec 29 13:09:50 2011 +0100
> > 
> >     mm: page_alloc: introduce alloc_contig_range()
> > 
> > 
> > It does not make much sense to me. At this point our pages are free, so
> > we do not care about LRU handling here.
> > But I might be missing something.
> 
> AFAICS, at the time page migration used putback_lru_page() to release the
> migration source page. This would put the page on lru pvec even if it was in
> fact not mapped anywhere anymore, and only the drain would actually free it.
> Seems Minchan optimized this in 2016 by c6c919eb90e0 ("mm: use put_page() to
> free page instead of putback_lru_page()")

This would be a great addition to the changelog. Thanks a lot Vlastimil,
you saved me from some archeology. With that mentioned feel free to add

Acked-by: Michal Hocko <mhocko@usse.com>

> 
> > [1] https://lore.kernel.org/linux-mm/20210208103935.GA32103@linux/T/#md651fc6e73c656105179382f92f8b2d6073051d1
> > 
> > 
> 

-- 
Michal Hocko
SUSE Labs
