Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C16134A374
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCZIzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:55:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:36120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhCZIzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:55:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B797AB8A;
        Fri, 26 Mar 2021 08:55:06 +0000 (UTC)
Date:   Fri, 26 Mar 2021 09:55:03 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YF2hZ5Q27yb6jC7w@localhost.localdomain>
References: <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
 <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz>
 <YFy+olsdS4iwrovN@dhcp22.suse.cz>
 <YF0JerCFXzcmMKzp@localhost.localdomain>
 <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 09:35:03AM +0100, Michal Hocko wrote:
> No problem there. I will not insist on my approach unless I can convince
> you that it is a better solution. It seems I have failed and I can live
> with that.

Well, I am glad we got to discuss it at least.

> > +static int memory_block_online(unsigned long start_pfn, unsigned long nr_pages,
> > +			       unsigned long nr_vmemmap_pages, int online_type,
> > +			       int nid)
> > +{
> > +	int ret;
> > +	/*
> > +	 * Despite vmemmap pages having a different lifecycle than the pages
> > +	 * they describe, initialiating and accounting vmemmap pages at the
> > +	 * online/offline stage eases things a lot.
> 
> This requires quite some explaining.

Definitely, I will expand on that and provide some context.

 
> Yes this is much better! Just a minor suggestion would be to push
> memory_block all the way to memory_block_online (it oline a memory
> block). I would also slightly prefer to provide 2 helpers that would make
> it clear that this is to reserve/cleanup the vmemamp space (defined in
> the memory_hotplug proper).

Glad to hear that!
By pushing memory_block all the way to memory_block_{online,offline}, you
mean passing the memblock struct together with nr_vmemmap_pages,
only_type and nid to memory_block_{offline,online}, and derive in there
the start_pfn and nr_pages?

Wrt. to the two helpers, I agree with you.
Actually, I would find quite disturbing to deal with zones in that code
domain.
I will add two proper helpers in memory_hotplug to deal with vmemmap.

If it comes out the way I envision, it could end up quite clean, and much
less disturbing.

Thanks Michal

-- 
Oscar Salvador
SUSE L3
