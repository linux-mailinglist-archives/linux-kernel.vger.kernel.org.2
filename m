Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94C3341A14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCSKbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:31:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:60908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhCSKbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:31:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88490AE05;
        Fri, 19 Mar 2021 10:31:23 +0000 (UTC)
Date:   Fri, 19 Mar 2021 11:31:21 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210319103120.GB6868@linux>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <c41ea8ac-e99d-6d23-c7b9-5ca25ffb72bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41ea8ac-e99d-6d23-c7b9-5ca25ffb72bb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 11:20:19AM +0100, David Hildenbrand wrote:
> > +bool mhp_supports_memmap_on_memory(unsigned long size)
> > +{
> > +	unsigned long nr_vmemmap_pages = size / PAGE_SIZE;
> > +	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
> > +	unsigned long remaining_size = size - vmemmap_size;
> > +
> > +	/*
> > +	 * Besides having arch support and the feature enabled at runtime, we
> > +	 * need a few more assumptions to hold true:
> > +	 *
> > +	 * a) We span a single memory block: memory onlining/offlinin;g happens
> 
> s/offlinin;g/offlining;/

Bleh, terrible :-(

> IS_ALIGNED(remaining_size, pageblock_nr_pages << PAGE_SHIFT);

Yaiks

Hopefully Andrew can amend these two nits? 

> (another pair of eyes certainly wouldn't hurt :) )

definitely, but those are pricy as you may know :-D

> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks a lot for the throughout review David, highly appreciated!
 

-- 
Oscar Salvador
SUSE L3
