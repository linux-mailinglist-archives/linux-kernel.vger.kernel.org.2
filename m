Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D17632624A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBZMHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:07:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhBZMHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:07:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0BE13B02A;
        Fri, 26 Feb 2021 12:06:24 +0000 (UTC)
Date:   Fri, 26 Feb 2021 13:06:21 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 5/7] mm,memory_hotplug: Enforce pageblock alignment
 when memmap_on_memory
Message-ID: <20210226120621.GB3661@localhost.localdomain>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-6-osalvador@suse.de>
 <9fcd9246-8e27-2991-a32f-539d9a430514@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fcd9246-8e27-2991-a32f-539d9a430514@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:27:33PM +0100, David Hildenbrand wrote:
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index d3fb036d33fd..1a4d5dd1a2c8 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -56,12 +56,16 @@ static int memmap_on_memory_show(char *buffer, const struct kernel_param *kp)
> >   static __meminit int memmap_on_memory_store(const char *val,
> >   					    const struct kernel_param *kp)
> >   {
> > +	unsigned long pageblock_size = PFN_PHYS(pageblock_nr_pages);
> > +
> >   	/*
> >   	 * Fail silently in case we cannot enable it due to system constraints.
> >   	 * User can always check whether it is enabled or not via /sys/module.
> >   	 */
> >   	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE) ||
> > -	    (PMD_SIZE % sizeof(struct page)))
> > +	    (PMD_SIZE % sizeof(struct page)) ||
> > +	    !(MIN_MEMORY_BLOCK_SIZE - PMD_SIZE) ||
> > +	    !(MIN_MEMORY_BLOCK_SIZE - PMD_SIZE) % pageblock_size)
> >   		return 0;
> >   	return param_set_bool(val, kp);
> > 
> 
> Dito, rather squash in #1 and add a comment explaining what's happening
> there.

I was not sure about putting this and the PMD aligned patch as a
standalone patch, but I thought it might ease the review.
But I have no problem in placing them in patch#1 and put some more
detail into the changelog.

-- 
Oscar Salvador
SUSE L3
