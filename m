Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0563478A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhCXMiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:38:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233111AbhCXMho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:37:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616589463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZtgFaOg9Su1Yf0TQH/ROrKjdESYBrkslJWw39nM9B8s=;
        b=oioWrSvcZsBqeA2OHs+ANwAYR1Tq55BbrkzRcMM5VnRBNPdq3Tx2Q5GOWTkceHSz4Jt8lH
        MpCmHE5QAAqNhjVZ/s+ynOHOThytklhkw5UB/Tlu0ATCiPZ7IhR1qHtYrT3jjTJA0ysL8E
        mjMWhizBKYz8+vH1LxQhtp+R6TybYUg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E52F7AD38;
        Wed, 24 Mar 2021 12:37:42 +0000 (UTC)
Date:   Wed, 24 Mar 2021 13:37:35 +0100
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
Message-ID: <YFsydJNF63OEcCaY@dhcp22.suse.cz>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFssRr7gZEPfHieA@dhcp22.suse.cz>
 <c3ff7038-a694-d311-c246-b881a2f55be7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ff7038-a694-d311-c246-b881a2f55be7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 13:23:47, David Hildenbrand wrote:
> On 24.03.21 13:10, Michal Hocko wrote:
> > On Wed 24-03-21 13:03:29, Michal Hocko wrote:
> > > On Wed 24-03-21 11:12:59, Oscar Salvador wrote:
> > [...]
> > 
> > an additional remark
> > 
> > > > - online_pages()->move_pfn_range_to_zone(): Accounts for node/zone's spanned pages
> > > > - online_pages()->zone->present_pages += nr_pages;
> > 
> > I am pretty sure you shouldn't account vmmemmap pages to the target zone
> > in some cases - e.g. vmemmap cannot be part of the movable zone, can it?
> > So this would be yet another special casing. This patch has got it wrong
> > unless I have missed some special casing.
> > 
> 
> It's a bit unfortunate that we have to discuss the very basic design
> decisions again.

It would be great to have those basic design decisions layed out in the
changelog.

> @Oscar, maybe you can share the links where we discussed all this and add
> some of it to the patch description.
> 
> I think what we have right here is good enough for an initial version, from
> where on we can improve things without having to modify calling code.

I have to say I really dislike vmemmap proliferation into
{on,off}lining. It just doesn't belong there from a layering POV. All
this code should care about is to hand over pages to the allocator and
make them visible.

Is that a sufficient concern to nack the whole thing? No, I do not think
so. But I do not see any particular rush to have this work needs to be
merged ASAP.

-- 
Michal Hocko
SUSE Labs
