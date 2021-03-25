Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00EE3491E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCYM06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:26:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:47356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhCYM0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:26:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616675196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HS/ApyYJx+KXsB6jVo02Qx7J6vlQhgTkv4jPcOfGutk=;
        b=aJ0JArRv8L+zMYHlkE6qOXTCAy48TVCl7oBHDbtOFdBiYVTF7651q8BweU7nkYWZhzDkR9
        GiwgTq4NaZ9Rtk3omYPy8cFGV/jU/rx9AEQGmZuboLLGiFQ1bGM4F3enWCEwhSlhC7Hy0z
        t5oUgjDHBbgj7/R6LBz+yEU8Jq0+G44=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22DABAD8A;
        Thu, 25 Mar 2021 12:26:36 +0000 (UTC)
Date:   Thu, 25 Mar 2021 13:26:34 +0100
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
Message-ID: <YFyBeulR04Oc7eu2@dhcp22.suse.cz>
References: <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain>
 <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
 <YFxsBRORtgqUF/FZ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFxsBRORtgqUF/FZ@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 11:55:01, Oscar Salvador wrote:
> On Thu, Mar 25, 2021 at 10:17:33AM +0100, Michal Hocko wrote:
> > Why do you think it is wrong to initialize/account pages when they are
> > used? Keep in mind that offline pages are not used until they are
> > onlined. But vmemmap pages are used since the vmemmap is established
> > which happens in the hotadd stage.
> 
> Yes, that is true.
> vmemmap pages are used right when we populate the vmemmap space.
> 
> > > plus the fact that I dislike to place those pages in
> > > ZONE_NORMAL, although they are not movable.
> > > But I think the vmemmap pages should lay within the same zone the pages
> > > they describe, doing so simplifies things, and I do not see any outright
> > > downside.
> > 
> > Well, both ways likely have its pros and cons. Nevertheless, if the
> > vmemmap storage is independent (which is the case for normal hotplug)
> > then the state is consistent over hotadd, {online, offline} N times,
> > hotremove cycles.  Which is conceptually reasonable as vmemmap doesn't
> > go away on each offline.
> > 
> > If you are going to bind accounting to the online/offline stages then
> > the accounting changes each time you go through the cycle and depending
> > on the onlining type it would travel among zones. I find it quite
> > confusing as the storage for vmemmap hasn't changed any of its
> > properties.
> 
> That is a good point I guess.
> vmemmap pages do not really go away until the memory is unplugged.
> 
> But I see some questions to raise:
> 
> - As I said, I really dislike it tiding vmemmap memory to ZONE_NORMAL
>   unconditionally and this might result in the problems David mentioned.
>   I remember David and I discussed such problems but the problems with
>   zones not being contiguos have also been discussed in the past and
>   IIRC, we reached the conclusion that a maximal effort should be made
>   to keep them that way, otherwise other things suffer e.g: compaction
>   code.

Yeah, David has raised the contiguous flag for zone already. And to be
completely honest I fail to see why we should shape a design based on an
optimization. If anything we can teach set_zone_contiguous to simply
ignore zone affiliation of vmemmap pages. I would be really curious if
that would pose any harm to the compaction code as they are reserved and
compaction should simply skip them.

>   So if we really want to move the initialization/account to the
>   hot-add/hot-remove stage, I would really like to be able to set the
>   proper zone in there (that is, the same zone where the memory will lay).

THere is nothing like a proper zone.

> - When moving the initialization/accounting to hot-add/hot-remove,
>   the section containing the vmemmap pages will remain offline.

Yes this sucks! I do not have a good answer for that as the
online/offline granularity seems rather coarse on that.

>   It might get onlined once the pages get online in online_pages(),
>   or not if vmemmap pages span a whole section.
>   I remember (but maybe David rmemeber better) that that was a problem
>   wrt. pfn_to_online_page() and hybernation/kdump.
>   So, if that is really a problem, we would have to care of ot setting
>   the section to the right state.
> 
> - AFAICS, doing all the above brings us to former times were some
>   initialization/accounting was done in a previous stage, and I remember
>   it was pushed hard to move those in online/offline_pages().

Not sure what you are referring to but if you have prior to f1dd2cd13c4b
("mm, memory_hotplug: do not associate hotadded memory to zones until
online") then this was entirely a different story. Users do care where
they memory goes because that depends on the usecase but do they care
about vmemmap?

-- 
Michal Hocko
SUSE Labs
