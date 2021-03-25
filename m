Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99301349458
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhCYOkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:40:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:47874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhCYOkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:40:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616683205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kysqydu6n/BcioxbRVAh8G87sWEE9K41NwnN+9Mu1XY=;
        b=Syb5a3qJ58DcnqHkieD37jiATjK2+yHARp5LvfjoZ5j7NkEU8FWPFxER5cKlLesmsQvEWD
        EkUwqX5Q569ZT6p5ING+ueNrqmYU6qN7p+g04n+/oBVLEuXpVIvA4SVOTGQTVqvMKsUOJ/
        rdjKyxIncpqpSQ5gKTsrk7UvuUZOEyU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65FFFADAA;
        Thu, 25 Mar 2021 14:40:05 +0000 (UTC)
Date:   Thu, 25 Mar 2021 15:40:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YFygxF5Rx0ESCfKB@dhcp22.suse.cz>
References: <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain>
 <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
 <YFxsBRORtgqUF/FZ@localhost.localdomain>
 <YFyBeulR04Oc7eu2@dhcp22.suse.cz>
 <YFyX8jRWqfqCoGo/@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFyX8jRWqfqCoGo/@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 15:02:26, Oscar Salvador wrote:
> On Thu, Mar 25, 2021 at 01:26:34PM +0100, Michal Hocko wrote:
> > Yeah, David has raised the contiguous flag for zone already. And to be
> > completely honest I fail to see why we should shape a design based on an
> > optimization. If anything we can teach set_zone_contiguous to simply
> > ignore zone affiliation of vmemmap pages. I would be really curious if
> > that would pose any harm to the compaction code as they are reserved and
> > compaction should simply skip them.
> 
> No, compaction code is clever enough to skip over those pages as it
> already does for any Reserved page.
> My comment was more towards having the zone contiguous.
> 
> I know it is an optimization, but
> 
>  commit 7cf91a98e607c2f935dbcc177d70011e95b8faff
>  Author: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>  Date:   Tue Mar 15 14:57:51 2016 -0700
>  
>  mm/compaction: speed up pageblock_pfn_to_page() when zone is contiguous
> 
> talks about 30% of improvment. I am not sure if those numbers would
> still hold nowawadys, but it feels wrong to drop it to the ground when
> we can do better there, and IMHO, it does not overly complicate things.

Again, do not shape design around an optimization. If this turns out a
real problem then it can be handled on top.

> > THere is nothing like a proper zone.
> 
> I guess not, but for me it makes sense that vmemmap pages stay within
> the same zone as the pages they describe.

This is not the case for normal hotplug so why this should be any
different.

> Of course, this is a matter of opinions/taste.
> 
> > Not sure what you are referring to but if you have prior to f1dd2cd13c4b
> > ("mm, memory_hotplug: do not associate hotadded memory to zones until
> > online") then this was entirely a different story. Users do care where
> > they memory goes because that depends on the usecase but do they care
> > about vmemmap?
> 
> As I said, that is not what I am worried about.
> Users do not really care where those pages end up, that is transparent
> to them (wrt. vmemmap pages), but we (internally) kind of do.
> 
> So, as I said, I see advantatges of using your way, but I see downsides
> as:
> 
> - I would like to consider zone, and for that we would have to pull
>   some of the functions that check for the zone at an aearly stage, and
>   the mere thought sounds ugly.

This is impossible and whatever kind of heuristic you come up with might
be wrong.

> - Section containing vmemmap can remain offline and would have to come
>   up to sort that out

Yes, this is a problem indeed and as I've said in other email this would
be a problem for your initial implementation as well if the memory block
is still offline. I suspect we need to treat these Vmemmap pages as
online (via pfn_to_online_page).
-- 
Michal Hocko
SUSE Labs
