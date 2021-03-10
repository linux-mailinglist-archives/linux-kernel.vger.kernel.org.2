Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C40334132
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhCJPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:09:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:34278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhCJPJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:09:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5512AAC1F;
        Wed, 10 Mar 2021 15:09:00 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 0/4] Make alloc_contig_range handle Hugetlb pages
Date:   Wed, 10 Mar 2021 16:08:49 +0100
Message-Id: <20210310150853.13541-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 -> v4:
 - Addressed some feedback from David and Michal
 - Make more clear what hugetlb_lock protects in isolate_or_dissolve_huge_page
 - Start reporting proper error codes from isolate_migratepages_{range,block}
 - Bail out earlier in __alloc_contig_migrate_range on -ENOMEM
 - Addressed internal feedback from Vastlimil wrt. compaction code changes

v2 -> v3:
 - Drop usage of high-level generic helpers in favour of
   low-level approach (per Michal)
 - Check for the page to be marked as PageHugeFreed
 - Add a one-time retry in case someone grabbed the free huge page
   from under us

v1 -> v2:
 - Adressed feedback by Michal
 - Restrict the allocation to a node with __GFP_THISNODE
 - Drop PageHuge check in alloc_and_dissolve_huge_page
 - Re-order comments in isolate_or_dissolve_huge_page
 - Extend comment in isolate_migratepages_block
 - Place put_page right after we got the page, otherwise
   dissolve_free_huge_page will fail

 RFC -> v1:
 - Drop RFC
 - Addressed feedback from David and Mike
 - Fence off gigantic pages as there is a cyclic dependency between
   them and alloc_contig_range
 - Re-organize the code to make race-window smaller and to put
   all details in hugetlb code
 - Drop nodemask initialization. First a node will be tried and then we
   will back to other nodes containing memory (N_MEMORY). Details in
   patch#1's changelog
 - Count new page as surplus in case we failed to dissolve the old page
   and the new one. Details in patch#1.

Cover letter:

 alloc_contig_range lacks the hability for handling HugeTLB pages.
 This can be problematic for some users, e.g: CMA and virtio-mem, where those
 users will fail the call if alloc_contig_range ever sees a HugeTLB page, even
 when those pages lay in ZONE_MOVABLE and are free.
 That problem can be easily solved by replacing the page in the free hugepage
 pool.

 In-use HugeTLB are no exception though, as those can be isolated and migrated
 as any other LRU or Movable page.

 This patchset aims for improving alloc_contig_range->isolate_migratepages_block,
 so HugeTLB pages can be recognized and handled.

 Since we also need to start reporting errors down the chain (e.g: -ENOMEM due to
 not be able to allocate a new hugetlb page), isolate_migratepages_{range,block}
 interfaces  need to change to start reporting error codes instead of the pfn == 0
 vs pfn != 0 scheme it is using right now.
 From now on, isolate_migratepages_block will not return the next pfn to be scanned
 anymore, but -EINTR, -ENOMEM or 0, so we the next pfn to be scanned will be recorded
 in cc->migrate_pfn field (as it is already done in isolate_migratepages_range()).

 Below is an insight from David (thanks), where the problem can clearly be seen:

 "Start a VM with 4G. Hotplug 1G via virtio-mem and online it to
  ZONE_MOVABLE. Allocate 512 huge pages.

  [root@localhost ~]# cat /proc/meminfo
  MemTotal:        5061512 kB
  MemFree:         3319396 kB
  MemAvailable:    3457144 kB
  ...
  HugePages_Total:     512
  HugePages_Free:      512
  HugePages_Rsvd:        0
  HugePages_Surp:        0
  Hugepagesize:       2048 kB

  The huge pages get partially allocate from ZONE_MOVABLE. Try unplugging
  1G via virtio-mem (remember, all ZONE_MOVABLE). Inside the guest:

  [  180.058992] alloc_contig_range: [1b8000, 1c0000) PFNs busy
  [  180.060531] alloc_contig_range: [1b8000, 1c0000) PFNs busy
  [  180.061972] alloc_contig_range: [1b8000, 1c0000) PFNs busy
  [  180.063413] alloc_contig_range: [1b8000, 1c0000) PFNs busy
  [  180.064838] alloc_contig_range: [1b8000, 1c0000) PFNs busy
  [  180.065848] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
  [  180.066794] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
  [  180.067738] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
  [  180.068669] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
  [  180.069598] alloc_contig_range: [1bfc00, 1c0000) PFNs busy"

 And then with this patchset running:

 "Same experiment with ZONE_MOVABLE:

  a) Free huge pages: all memory can get unplugged again.

  b) Allocated/populated but idle huge pages: all memory can get unplugged
     again.

  c) Allocated/populated but all 512 huge pages are read/written in a
     loop: all memory can get unplugged again, but I get a single

  [  121.192345] alloc_contig_range: [180000, 188000) PFNs busy

  Most probably because it happened to try migrating a huge page while it
  was busy. As virtio-mem retries on ZONE_MOVABLE a couple of times, it
  can deal with this temporary failure.

  Last but not least, I did something extreme:

  # cat /proc/meminfo
  MemTotal:        5061568 kB
  MemFree:          186560 kB
  MemAvailable:     354524 kB
  ...
  HugePages_Total:    2048
  HugePages_Free:     2048
  HugePages_Rsvd:        0
  HugePages_Surp:        0

  Triggering unplug would require to dissolve+alloc - which now fails when
  trying to allocate an additional ~512 huge pages (1G).

  As expected, I can properly see memory unplug not fully succeeding. + I
  get a fairly continuous stream of

  [  226.611584] alloc_contig_range: [19f400, 19f800) PFNs busy
  ...

  But more importantly, the hugepage count remains stable, as configured
  by the admin (me):

  HugePages_Total:    2048
  HugePages_Free:     2048
  HugePages_Rsvd:        0
  HugePages_Surp:        0"

Oscar Salvador (4):
  mm,page_alloc: Bail out earlier on -ENOMEM in
    alloc_contig_migrate_range
  mm,compaction: Let isolate_migratepages_{range,block} return error
    codes
  mm: Make alloc_contig_range handle free hugetlb pages
  mm: Make alloc_contig_range handle in-use hugetlb pages

 include/linux/hugetlb.h |   7 +++
 mm/compaction.c         |  89 ++++++++++++++++++++++++----------
 mm/hugetlb.c            | 125 +++++++++++++++++++++++++++++++++++++++++++++++-
 mm/internal.h           |   2 +-
 mm/page_alloc.c         |  15 ++++--
 mm/vmscan.c             |   5 +-
 6 files changed, 209 insertions(+), 34 deletions(-)

-- 
2.16.3

