Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4048D34A37B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCZI6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:58:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:38618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCZI5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:57:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63FDDAB8A;
        Fri, 26 Mar 2021 08:57:46 +0000 (UTC)
Date:   Fri, 26 Mar 2021 09:57:43 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YF2iBxueewnKIG3V@localhost.localdomain>
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

On Fri, Mar 26, 2021 at 09:52:58AM +0100, David Hildenbrand wrote:
> Might have to set fully spanned section online. (vmemmap >= SECTION_SIZE)

Hi David,

could you elaborate on this a bit?

> Something else to note:
> 
> 
> We'll not call the memory notifier (e.g., MEM_ONLINE) for the vmemmap. The
> result is that
> 
> 1. We won't allocate extended struct pages for the range. Don't think this
> is really problematic (pages are never allocated/freed, so I guess we don't
> care - like ZONE_DEVICE code).
> 
> 2. We won't allocate kasan shadow memory. We most probably have to do it
> explicitly via kasan_add_zero_shadow()/kasan_remove_zero_shadow(), see
> mm/memremap.c:pagemap_range()
> 
> 
> Further a locking rework might be necessary. We hold the device hotplug
> lock, but not the memory hotplug lock. E.g., for get_online_mems(). Might
> have to move that out online_pages.

I will have a look and see how it goes.

 

-- 
Oscar Salvador
SUSE L3
