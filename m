Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803153479C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhCXNk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:40:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235508AbhCXNkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:40:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616593230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fGJhpVQ2ygvTcqyB7BGZDKbHMPmYinPLpC19q8LrgoE=;
        b=erfT6L07rc/gL7ONI/CNEU/2gpu18MKemZwVqVZ8aMHTR1SwLPJ8LCZ987rM2gGnArIIoI
        TfOVNwKPKyCxZKAHB5e2yTx7LQjn1oUcKWKrq1TOY1Zt+X4pRV04dVjnDtml1bKP7x8znQ
        upQVS+S/zBvDiDGXFhYiV1HeQx74+6k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04E3FAD71;
        Wed, 24 Mar 2021 13:40:30 +0000 (UTC)
Date:   Wed, 24 Mar 2021 14:40:29 +0100
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
Message-ID: <YFtBTeBBCPnBesQ5@dhcp22.suse.cz>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFssRr7gZEPfHieA@dhcp22.suse.cz>
 <c3ff7038-a694-d311-c246-b881a2f55be7@redhat.com>
 <YFsydJNF63OEcCaY@dhcp22.suse.cz>
 <32bc6e31-0200-1e8c-895c-3f60ed072fc2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32bc6e31-0200-1e8c-895c-3f60ed072fc2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 14:13:31, David Hildenbrand wrote:
> On 24.03.21 13:37, Michal Hocko wrote:
> > On Wed 24-03-21 13:23:47, David Hildenbrand wrote:
> > > On 24.03.21 13:10, Michal Hocko wrote:
> > > > On Wed 24-03-21 13:03:29, Michal Hocko wrote:
> > > > > On Wed 24-03-21 11:12:59, Oscar Salvador wrote:
> > > > [...]
> > > > 
> > > > an additional remark
> > > > 
> > > > > > - online_pages()->move_pfn_range_to_zone(): Accounts for node/zone's spanned pages
> > > > > > - online_pages()->zone->present_pages += nr_pages;
> > > > 
> > > > I am pretty sure you shouldn't account vmmemmap pages to the target zone
> > > > in some cases - e.g. vmemmap cannot be part of the movable zone, can it?
> > > > So this would be yet another special casing. This patch has got it wrong
> > > > unless I have missed some special casing.
> > > > 
> > > 
> > > It's a bit unfortunate that we have to discuss the very basic design
> > > decisions again.
> > 
> > It would be great to have those basic design decisions layed out in the
> > changelog.
> > 
> > > @Oscar, maybe you can share the links where we discussed all this and add
> > > some of it to the patch description.
> > > 
> > > I think what we have right here is good enough for an initial version, from
> > > where on we can improve things without having to modify calling code.
> > 
> > I have to say I really dislike vmemmap proliferation into
> > {on,off}lining. It just doesn't belong there from a layering POV. All
> > this code should care about is to hand over pages to the allocator and
> > make them visible.
> 
> Well, someone has to initialize the vmemmap of the vmemmap pages ( which is
> itself :) ),

Yeah, and I would expect this to be done when the vmemmap space is
reserved. This is at the hotadd time and we do not know the zone but
that shouldn't really matter because their zone can be quite arbitrary
kernel zone. As mentioned previously I do not think associating those
with zone movable is a good idea as they are fundamentally not movable.
It is likely that the zone doesn't really matter for these pages anyway
and the only think we do care about is that they are not poisoned and
there is at least something but again it would be much better to have a
single place where all those details are done (including accounting)
rather than trying to wrap head around different pfns when onlining
pages and grow potential and suble bugs there.

> and as the vemmap does not span complete sections things can
> get very weird as we can only set whole sections online (there was more to
> that, I think it's buried in previous discussions).

Yes the section can only online as whole. This is an important "detail"
and it would deserve some more clarification in the changelog as well.
You have invested quite some energy into code consolidation and checks
to make sure that hotplugged code doesn't have holes and this work bends
those rules. vmemmap is effectivelly a hole in a memblock/section. I
think we should re-evaluate some of those constrains rather than try to
work them around somehow.
-- 
Michal Hocko
SUSE Labs
