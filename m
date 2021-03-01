Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74638327EBA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhCAM6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:58:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:38008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235203AbhCAM6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:58:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C459AC24;
        Mon,  1 Mar 2021 12:58:02 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:57:59 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Make alloc_contig_range handle Hugetlb pages
Message-ID: <20210301125754.GA4003@linux>
References: <20210222135137.25717-1-osalvador@suse.de>
 <ff780dd6-f473-5476-fc1c-9f9bbcdb17c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff780dd6-f473-5476-fc1c-9f9bbcdb17c8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 01:43:00PM +0100, David Hildenbrand wrote:
> Same experiment with ZONE_MOVABLE:
> 
> a) Free huge pages: all memory can get unplugged again.
> 
> b) Allocated/populated but idle huge pages: all memory can get unplugged
> again.
> 
> c) Allocated/populated but all 512 huge pages are read/written in a loop:
> all memory can get unplugged again, but I get a single
> 
> [  121.192345] alloc_contig_range: [180000, 188000) PFNs busy
> 
> Most probably because it happened to try migrating a huge page while it was
> busy. As virtio-mem retries on ZONE_MOVABLE a couple of times, it can deal
> with this temporary failure.
> 
> 
> 
> Last but not least, I did something extreme:
> 
> ]# cat /proc/meminfo
> MemTotal:        5061568 kB
> MemFree:          186560 kB
> MemAvailable:     354524 kB
> ...
> HugePages_Total:    2048
> HugePages_Free:     2048
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> 
> Triggering unplug would require to dissolve+alloc - which now fails when
> trying to allocate an additional ~512 huge pages (1G).
> 
> 
> As expected, I can properly see memory unplug not fully succeeding. + I get
> a fairly continuous stream of
> 
> [  226.611584] alloc_contig_range: [19f400, 19f800) PFNs busy
> ...
> 
> But more importantly, the hugepage count remains stable, as configured by
> the admin (me):
> 
> HugePages_Total:    2048
> HugePages_Free:     2048
> HugePages_Rsvd:        0
> HugePages_Surp:        0

Thanks for giving it a spin David, that is highly appreciated ;-)!

I will add above information in next's version changelog if you do not mind,
so the before-and-after can be seen clearly.

I shall send v4 in the course of the next few days.

-- 
Oscar Salvador
SUSE L3
