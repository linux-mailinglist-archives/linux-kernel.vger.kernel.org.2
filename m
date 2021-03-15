Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD3533AE2D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCOJGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhCOJGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615799208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tu56plWuCOh7ZMu2ov52VFZ55gzNJGM5LNOunI44hdg=;
        b=PnRfJrb0w8LES1LdH5Iqt7VbNgBoYis8Uuela4J8Hh+lyEX25GYEFwiQ2KiFfOnWfPGcU9
        7981C5xs3m53vwvrcfySUtYaQUHWBU28I+LtKVNXl1SEXwT1/92VMVYL56kxxBInQcgL3t
        DJMlAjCi7bF8oj1Uz68JAONx8QYB0m0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-i7wQ4hWzPamZ2WUmNEWMvQ-1; Mon, 15 Mar 2021 05:06:46 -0400
X-MC-Unique: i7wQ4hWzPamZ2WUmNEWMvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8023100D92F;
        Mon, 15 Mar 2021 09:06:44 +0000 (UTC)
Received: from [10.36.112.200] (ovpn-112-200.ams2.redhat.com [10.36.112.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D0F11C4;
        Mon, 15 Mar 2021 09:06:41 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210310150853.13541-1-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v4 0/4] Make alloc_contig_range handle Hugetlb pages
Message-ID: <c7ba5bba-77fb-6c43-2067-2ebc83b014da@redhat.com>
Date:   Mon, 15 Mar 2021 10:06:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310150853.13541-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.21 16:08, Oscar Salvador wrote:
> v3 -> v4:
>   - Addressed some feedback from David and Michal
>   - Make more clear what hugetlb_lock protects in isolate_or_dissolve_huge_page
>   - Start reporting proper error codes from isolate_migratepages_{range,block}
>   - Bail out earlier in __alloc_contig_migrate_range on -ENOMEM
>   - Addressed internal feedback from Vastlimil wrt. compaction code changes
> 
> v2 -> v3:
>   - Drop usage of high-level generic helpers in favour of
>     low-level approach (per Michal)
>   - Check for the page to be marked as PageHugeFreed
>   - Add a one-time retry in case someone grabbed the free huge page
>     from under us
> 
> v1 -> v2:
>   - Adressed feedback by Michal
>   - Restrict the allocation to a node with __GFP_THISNODE
>   - Drop PageHuge check in alloc_and_dissolve_huge_page
>   - Re-order comments in isolate_or_dissolve_huge_page
>   - Extend comment in isolate_migratepages_block
>   - Place put_page right after we got the page, otherwise
>     dissolve_free_huge_page will fail
> 
>   RFC -> v1:
>   - Drop RFC
>   - Addressed feedback from David and Mike
>   - Fence off gigantic pages as there is a cyclic dependency between
>     them and alloc_contig_range
>   - Re-organize the code to make race-window smaller and to put
>     all details in hugetlb code
>   - Drop nodemask initialization. First a node will be tried and then we
>     will back to other nodes containing memory (N_MEMORY). Details in
>     patch#1's changelog
>   - Count new page as surplus in case we failed to dissolve the old page
>     and the new one. Details in patch#1.
> 
> Cover letter:
> 
>   alloc_contig_range lacks the hability for handling HugeTLB pages.
>   This can be problematic for some users, e.g: CMA and virtio-mem, where those
>   users will fail the call if alloc_contig_range ever sees a HugeTLB page, even
>   when those pages lay in ZONE_MOVABLE and are free.
>   That problem can be easily solved by replacing the page in the free hugepage
>   pool.
> 
>   In-use HugeTLB are no exception though, as those can be isolated and migrated
>   as any other LRU or Movable page.
> 
>   This patchset aims for improving alloc_contig_range->isolate_migratepages_block,
>   so HugeTLB pages can be recognized and handled.
> 
>   Since we also need to start reporting errors down the chain (e.g: -ENOMEM due to
>   not be able to allocate a new hugetlb page), isolate_migratepages_{range,block}
>   interfaces  need to change to start reporting error codes instead of the pfn == 0
>   vs pfn != 0 scheme it is using right now.
>   From now on, isolate_migratepages_block will not return the next pfn to be scanned
>   anymore, but -EINTR, -ENOMEM or 0, so we the next pfn to be scanned will be recorded
>   in cc->migrate_pfn field (as it is already done in isolate_migratepages_range()).
> 
>   Below is an insight from David (thanks), where the problem can clearly be seen:
> 
>   "Start a VM with 4G. Hotplug 1G via virtio-mem and online it to
>    ZONE_MOVABLE. Allocate 512 huge pages.
> 
>    [root@localhost ~]# cat /proc/meminfo
>    MemTotal:        5061512 kB
>    MemFree:         3319396 kB
>    MemAvailable:    3457144 kB
>    ...
>    HugePages_Total:     512
>    HugePages_Free:      512
>    HugePages_Rsvd:        0
>    HugePages_Surp:        0
>    Hugepagesize:       2048 kB
> 
>    The huge pages get partially allocate from ZONE_MOVABLE. Try unplugging
>    1G via virtio-mem (remember, all ZONE_MOVABLE). Inside the guest:
> 
>    [  180.058992] alloc_contig_range: [1b8000, 1c0000) PFNs busy
>    [  180.060531] alloc_contig_range: [1b8000, 1c0000) PFNs busy
>    [  180.061972] alloc_contig_range: [1b8000, 1c0000) PFNs busy
>    [  180.063413] alloc_contig_range: [1b8000, 1c0000) PFNs busy
>    [  180.064838] alloc_contig_range: [1b8000, 1c0000) PFNs busy
>    [  180.065848] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
>    [  180.066794] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
>    [  180.067738] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
>    [  180.068669] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
>    [  180.069598] alloc_contig_range: [1bfc00, 1c0000) PFNs busy"
> 
>   And then with this patchset running:
> 
>   "Same experiment with ZONE_MOVABLE:
> 
>    a) Free huge pages: all memory can get unplugged again.
> 
>    b) Allocated/populated but idle huge pages: all memory can get unplugged
>       again.
> 
>    c) Allocated/populated but all 512 huge pages are read/written in a
>       loop: all memory can get unplugged again, but I get a single
> 
>    [  121.192345] alloc_contig_range: [180000, 188000) PFNs busy
> 
>    Most probably because it happened to try migrating a huge page while it
>    was busy. As virtio-mem retries on ZONE_MOVABLE a couple of times, it
>    can deal with this temporary failure.
> 
>    Last but not least, I did something extreme:
> 
>    # cat /proc/meminfo
>    MemTotal:        5061568 kB
>    MemFree:          186560 kB
>    MemAvailable:     354524 kB
>    ...
>    HugePages_Total:    2048
>    HugePages_Free:     2048
>    HugePages_Rsvd:        0
>    HugePages_Surp:        0
> 
>    Triggering unplug would require to dissolve+alloc - which now fails when
>    trying to allocate an additional ~512 huge pages (1G).
> 
>    As expected, I can properly see memory unplug not fully succeeding. + I
>    get a fairly continuous stream of
> 
>    [  226.611584] alloc_contig_range: [19f400, 19f800) PFNs busy
>    ...
> 
>    But more importantly, the hugepage count remains stable, as configured
>    by the admin (me):
> 
>    HugePages_Total:    2048
>    HugePages_Free:     2048
>    HugePages_Rsvd:        0
>    HugePages_Surp:        0"
> 
> Oscar Salvador (4):
>    mm,page_alloc: Bail out earlier on -ENOMEM in
>      alloc_contig_migrate_range
>    mm,compaction: Let isolate_migratepages_{range,block} return error
>      codes
>    mm: Make alloc_contig_range handle free hugetlb pages
>    mm: Make alloc_contig_range handle in-use hugetlb pages
> 
>   include/linux/hugetlb.h |   7 +++
>   mm/compaction.c         |  89 ++++++++++++++++++++++++----------
>   mm/hugetlb.c            | 125 +++++++++++++++++++++++++++++++++++++++++++++++-
>   mm/internal.h           |   2 +-
>   mm/page_alloc.c         |  15 ++++--
>   mm/vmscan.c             |   5 +-
>   6 files changed, 209 insertions(+), 34 deletions(-)
> 

BTW, I stumbled yesterday over

alloc_contig_pages()->pfn_range_valid_contig():

	if (page_count(page) > 0)
		rerurn false;
	if (PageHuge(page))
		return false;

As used by memtrace and for gigantic pages. We can now

a) Drop these check completely, as it's best-effort only and racy. 
alloc_contig_pages()/alloc_contig_range() will handle it properly.

b) Similarly, check for gigantic pages and/or movability/migratability.

Dropping both checks might be the right thing to do: might significantly 
increase allocation chances -- as we actually end up migrating busy 
pages ...

-- 
Thanks,

David / dhildenb

