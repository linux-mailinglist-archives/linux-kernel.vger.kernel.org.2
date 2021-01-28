Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6928B307350
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhA1KAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:00:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:60244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231779AbhA1J74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:59:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58EA1AC97;
        Thu, 28 Jan 2021 09:59:14 +0000 (UTC)
Date:   Thu, 28 Jan 2021 10:59:06 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 1/2] mm/cma: expose all pages to the buddy if
 activation of an area fails
Message-ID: <20210128095906.GA5250@localhost.localdomain>
References: <20210127101813.6370-1-david@redhat.com>
 <20210127101813.6370-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127101813.6370-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:18:12AM +0100, David Hildenbrand wrote:
> Right now, if activation fails, we might already have exposed some pages to
> the buddy for CMA use (although they will never get actually used by CMA),
> and some pages won't be exposed to the buddy at all.
> 
> Let's check for "single zone" early and on error, don't expose any pages
> for CMA use - instead, expose them to the buddy available for any use.
> Simply call free_reserved_page() on every single page - easier than
> going via free_reserved_area(), converting back and forth between pfns
> and virt addresses.
> 
> In addition, make sure to fixup totalcma_pages properly.
> 
> Example: 6 GiB QEMU VM with "... hugetlb_cma=2G movablecore=20% ...":
>   [    0.006891] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
>   [    0.006893] cma: Reserved 2048 MiB at 0x0000000100000000
>   [    0.006893] hugetlb_cma: reserved 2048 MiB on node 0
>   ...
>   [    0.175433] cma: CMA area hugetlb0 could not be activated
> 
> Before this patch:
>   # cat /proc/meminfo
>   MemTotal:        5867348 kB
>   MemFree:         5692808 kB
>   MemAvailable:    5542516 kB
>   ...
>   CmaTotal:        2097152 kB
>   CmaFree:         1884160 kB
> 
> After this patch:
>   # cat /proc/meminfo
>   MemTotal:        6077308 kB
>   MemFree:         5904208 kB
>   MemAvailable:    5747968 kB
>   ...
>   CmaTotal:              0 kB
>   CmaFree:               0 kB
> 
> Note: cma_init_reserved_mem() makes sure that we always cover full
> pageblocks / MAX_ORDER - 1 pages.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Besides benefit of the error handling, I find this code much more
cleaer:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
