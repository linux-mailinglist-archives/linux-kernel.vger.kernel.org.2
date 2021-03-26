Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE79E34AA21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCZOi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:38:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhCZOim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:38:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616769521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DurayHOhToArSvSYK8RAMhFhC6jUS8VXy76iO4nFyq8=;
        b=GUFM+RVHwSoPMYHr7+s2a4JxX35egujR4bvC8Zd+TvehRnX+Y/Zv6e4phB3kRQHnNjRY3E
        3XHPhkNMLLrJwGsOrwh992u3tpSYTyY8bGSQnELN0jqre0iDkC68nnDzRUu7541mcFggV8
        wOD2yGbfTp0NUhMti1Ua1lctgs5nEH0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7555DAC6A;
        Fri, 26 Mar 2021 14:38:41 +0000 (UTC)
Date:   Fri, 26 Mar 2021 15:38:40 +0100
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
Message-ID: <YF3x8BW1+2o50mds@dhcp22.suse.cz>
References: <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
 <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz>
 <YFy+olsdS4iwrovN@dhcp22.suse.cz>
 <YF0JerCFXzcmMKzp@localhost.localdomain>
 <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
 <5be95091-b4ac-8e05-4694-ac5c65f790a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be95091-b4ac-8e05-4694-ac5c65f790a4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-03-21 09:52:58, David Hildenbrand wrote:
[...]
> Something else to note:
> 
> 
> We'll not call the memory notifier (e.g., MEM_ONLINE) for the vmemmap. The
> result is that
> 
> 1. We won't allocate extended struct pages for the range. Don't think this
> is really problematic (pages are never allocated/freed, so I guess we don't
> care - like ZONE_DEVICE code).

Agreed. I do not think we need them. Future might disagree but let's
handle it when we have a clear demand.

> 2. We won't allocate kasan shadow memory. We most probably have to do it
> explicitly via kasan_add_zero_shadow()/kasan_remove_zero_shadow(), see
> mm/memremap.c:pagemap_range()

I think this is similar to the above. Does kasan has to know about
memory which will never be used for anything?

> Further a locking rework might be necessary. We hold the device hotplug
> lock, but not the memory hotplug lock. E.g., for get_online_mems(). Might
> have to move that out online_pages.

Could you be more explicit why this locking is needed? What it would
protect from for vmemmap pages?
-- 
Michal Hocko
SUSE Labs
