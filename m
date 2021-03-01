Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F0A327B99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhCAKJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:09:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:36372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231594AbhCAKH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:07:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1EDEADE5;
        Mon,  1 Mar 2021 10:06:47 +0000 (UTC)
Date:   Mon, 1 Mar 2021 11:06:45 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 4/7] mm,memory_hotplug: Enforce struct page size to be
 multiple of PMD
Message-ID: <20210301100640.GA32425@linux>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-5-osalvador@suse.de>
 <13253f19-d0e9-e27c-046a-c2669c5ee33d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13253f19-d0e9-e27c-046a-c2669c5ee33d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:26:50PM +0100, David Hildenbrand wrote:
> On 09.02.21 14:38, Oscar Salvador wrote:
> > When struct page's size is not multiple of PMD, these do not get
> > fully populated when adding sections, hence two sections will
> > intersect the same the PMD. This goes against the vmemmap-per-device
> > premise, so reject it if that is the case.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > ---
> >   mm/memory_hotplug.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 95695483a622..d3fb036d33fd 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -57,10 +57,11 @@ static __meminit int memmap_on_memory_store(const char *val,
> >   					    const struct kernel_param *kp)
> >   {
> >   	/*
> > -	 * Fail silently in case we cannot enable it due to platform constraints.
> > +	 * Fail silently in case we cannot enable it due to system constraints.
> >   	 * User can always check whether it is enabled or not via /sys/module.
> >   	 */
> > -	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE))
> > +	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE) ||
> > +	    (PMD_SIZE % sizeof(struct page)))
> >   		return 0;
> >   	return param_set_bool(val, kp);
> > 
> 
> Squash that into #1 - it's part of basic operation.

Just to be sure we are on the same page.
You mean to move this patch and patch#5 into the runtime check in
mhp_supports_memmap_on_memory(), right?


-- 
Oscar Salvador
SUSE L3
