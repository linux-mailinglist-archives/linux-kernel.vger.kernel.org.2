Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE9349220
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhCYMfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:35:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhCYMfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:35:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616675717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ynL0k1T6kwpOmMRhTkakmSeYvHh3I47txNFPOjVLC4c=;
        b=QepAxUwWtAHPIj7hW9gmS3cG/hkM/6R8gdQGyYyHP/slWDrt5Gm9zpATP1mntQVwJq4Z23
        1ajVVdOlqcpq456kNspHnpr6/d8gmbxhL4783sW8GgfD0sNrbfXy2Iyl2V1lGhEEf0ZnUm
        eJVunSpwXrFAQO9BI9HlLWyK94BapPA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4792DAD8A;
        Thu, 25 Mar 2021 12:35:17 +0000 (UTC)
Date:   Thu, 25 Mar 2021 13:35:16 +0100
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
Message-ID: <YFyDhKPqS15HdO0Y@dhcp22.suse.cz>
References: <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain>
 <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
 <YFxsBRORtgqUF/FZ@localhost.localdomain>
 <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 12:08:43, David Hildenbrand wrote:
> On 25.03.21 11:55, Oscar Salvador wrote:
> > On Thu, Mar 25, 2021 at 10:17:33AM +0100, Michal Hocko wrote:
> > > Why do you think it is wrong to initialize/account pages when they are
> > > used? Keep in mind that offline pages are not used until they are
> > > onlined. But vmemmap pages are used since the vmemmap is established
> > > which happens in the hotadd stage.
> > 
> > Yes, that is true.
> > vmemmap pages are used right when we populate the vmemmap space.
> > 
> 
> Note: I once herd of a corner-case use case where people offline memory
> blocks to then use the "free" memory via /dev/mem for other purposes ("large
> physical memory"). Not that I encourage such use cases, but they would be
> fundamentally broken if the vmemmap ends up on offline memory and is
> supposed to keep its state ...

I am not aware of such a use case, it surely sounds, ehm creative, but
nothing really new. But such a usecase sounds quite incompatible with
this feature whether we account vmemmap at hotadd or hotremove because
they would need to understand that part of the memory they have hotadded
is not useable.

[...]
> > - When moving the initialization/accounting to hot-add/hot-remove,
> >    the section containing the vmemmap pages will remain offline.
> >    It might get onlined once the pages get online in online_pages(),
> >    or not if vmemmap pages span a whole section.
> >    I remember (but maybe David rmemeber better) that that was a problem
> >    wrt. pfn_to_online_page() and hybernation/kdump.
> >    So, if that is really a problem, we would have to care of ot setting
> >    the section to the right state.
> 
> Good memory. Indeed, hibernation/kdump won't save the state of the vmemmap,
> because the memory is marked as offline and, thus, logically without any
> valuable content.

Could you point me to the respective hibernation code please? I always
get lost in that area. Anyway, we do have the same problem even if the
whole accounting is handled during {on,off}lining, no?

I am not really worried about kdump though. As the memory is offline
then losing itse vmemmap is a mere annoyance.


> > - AFAICS, doing all the above brings us to former times were some
> >    initialization/accounting was done in a previous stage, and I remember
> >    it was pushed hard to move those in online/offline_pages().
> >    Are we ok with that?
> >    As I said, we might have to set the right zone in hot-add stage, as
> >    otherwise problems might come up.
> >    Being that case, would not that also be conflating different concepts
> >    at a wrong phases?
> > 
> 
> I expressed my opinion already, no need to repeat. Sub-section online maps
> would make it cleaner, but I am still not convinced we want/need that.

Nah, subsections are more tricky than necessary and if we can live
without them and have it just as pmem weirdness is more than enough ;)
-- 
Michal Hocko
SUSE Labs
