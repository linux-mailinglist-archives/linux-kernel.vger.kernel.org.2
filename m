Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20396348C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhCYJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:17:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:48370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhCYJRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:17:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616663854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hdpgy5pn6ZGkaExhDkpvCTiM0lv7yolQBMjfVF/kwEc=;
        b=JGALdqblWorvtdJf+/L/iGf4o/C5OX7rpiXOqAvmNlAcpiFkZFDJTZl0U8EiJL1Z3rp/MM
        MckTXup3lQFHKmH7heQdtp5QgIWPmuHf+CdjnMJyb5v9HgKZOSgr5WCOhOPbqGAUOdsDgi
        F8KhceOkYo4mk9Ao8E1BTe38M/wZ1XI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A777AC16;
        Thu, 25 Mar 2021 09:17:34 +0000 (UTC)
Date:   Thu, 25 Mar 2021 10:17:33 +0100
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
Message-ID: <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFxEp0cfcJmcz5bP@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 09:07:03, Oscar Salvador wrote:
> On Wed, Mar 24, 2021 at 08:16:53PM +0100, David Hildenbrand wrote:
> > > > 1. If the underlying memory block is offline, all sections are offline. Zone
> > > > shrinking code will happily skip over the vmemmap pages and you can end up
> > > > with out-of-zone pages assigned to the zone. Can happen in corner cases.
> > > 
> > > You are right. But do we really care? Those pages should be of no
> > > interest to anybody iterating through zones/nodes anyway.
> > 
> > Well, we were just discussing getting zone/node links + span right for all
> > pages (including for special reserved pages), because it already resulted in
> > BUGs. So I am not convinced that we *don't* have to care.
> > 
> > However, I agree that most code that cares about node/zone spans shouldn't
> > care - e.g., never call set_pfnblock_flags_mask() on such blocks.
> > 
> > But I guess there are corner cases where we would end up with
> > zone_is_empty() == true, not sure what that effect would be ... at least the
> > node cannot vanish as we disallow offlining it while we have a memory block
> > linked to it.
> 
> Having quickly looked at Michal's change, I have to say that it does not
> look that bad, but I think it is doing the initialization/accounting at
> the wrong stage,

Why do you think it is wrong to initialize/account pages when they are
used? Keep in mind that offline pages are not used until they are
onlined. But vmemmap pages are used since the vmemmap is established
which happens in the hotadd stage.

> plus the fact that I dislike to place those pages in
> ZONE_NORMAL, although they are not movable.
> But I think the vmemmap pages should lay within the same zone the pages
> they describe, doing so simplifies things, and I do not see any outright
> downside.

Well, both ways likely have its pros and cons. Nevertheless, if the
vmemmap storage is independent (which is the case for normal hotplug)
then the state is consistent over hotadd, {online, offline} N times,
hotremove cycles.  Which is conceptually reasonable as vmemmap doesn't
go away on each offline.

If you are going to bind accounting to the online/offline stages then
the accounting changes each time you go through the cycle and depending
on the onlining type it would travel among zones. I find it quite
confusing as the storage for vmemmap hasn't changed any of its
properties.

[...]

> This is just an idea I did not get to think carefully, but what if we
> do it in helpers right before calling online_pages()/offline_pages()
> in memory_block_action() ?

That would result in a less confusing code in {on,off}lining code
operating on two sets of pfns, nr_pages. But fundamentally I still
consider it a suboptimal to have accounting which is detached from the
life cycle. If we really want to go that path we should have a very good
reason for that.
-- 
Michal Hocko
SUSE Labs
