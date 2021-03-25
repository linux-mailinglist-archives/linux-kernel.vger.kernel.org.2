Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4D3496EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhCYQgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:36:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:42830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhCYQgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:36:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616690183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yrwkguyULD2OndhuiqBr1FUJwjqFFmGTyWszNJaHC08=;
        b=uaMJ0tqw/NPZGkOpNw2y6tKLH6HOrMIxLLhc0MjiNEzNbydeEY8upX22P2+Z53DuQ3jH9y
        Npggk1RnOiekFNQAzyN3i+kIOZWdWNju09irdhbK+uycH7MVbFp5MNMrAF0K1BdfW3T0sF
        kc8Tk7XWnYeDLjKFsIvfnUMSmBGd++A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D93DAAC16;
        Thu, 25 Mar 2021 16:36:22 +0000 (UTC)
Date:   Thu, 25 Mar 2021 17:36:17 +0100
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
Message-ID: <YFy8ARml4R7/snVs@dhcp22.suse.cz>
References: <31110e58-c99a-8dee-6f6e-98f456b77759@redhat.com>
 <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
 <062bc5d7-a83c-1c1a-7b77-9f043643f4fa@redhat.com>
 <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
 <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
 <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 17:20:23, David Hildenbrand wrote:
> On 25.03.21 17:07, Michal Hocko wrote:
> > On Thu 25-03-21 16:35:58, Michal Hocko wrote:
> > [...]
> > > So there is indeed a difference. One way around that would be to mark
> > > vmemmap pages (e.g. PageReserved && magic value stored somewhere in the
> > > struct page - resembling bootmem vmemmaps) or mark section fully backing
> > > vmemmaps as online (ugly).
> > 
> > I am not yet ready to give up on this. Here is a quick stab at the
> > pfn_to_online_page approach. It is not great but it is not really
> > terrible either. I think we can do better and skip
> 
> We both seem to have a different taste, to phrase it in a nice way :) ; but
> well, you seem to have set your mind (just like I seem to have set mine when
> trying to find a nice and somewhat-clean way to handle this when discussing
> it in the past).

I definitely do not want to fight for a certain solution just for the
sake of it. I really dislike how the lifetime of the reserved space and
its accounting are completely detached. But hey, I do understand that
a worse solution from the design perspective can be better due to
practical reasons or constrains.

I haven't seen the hibernation problem before and I do recognize it is
a nasty one. If all it takes is to make pfn_to_online_page work (and my
previous attempt is incorrect because it should consult block rather
than section pfn range) and there are no other downsides then I would
still prefer to go with my proposal.  If there are still other things to
plug then, well, practicality is going to win.

So before I give up on the "proper" design card, are there more
subtleties to watch for? You have certainly given this much more thought
than I have.
-- 
Michal Hocko
SUSE Labs
