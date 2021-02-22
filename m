Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5AD321A14
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhBVOSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:18:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:45934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhBVNwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:52:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7427DAD29;
        Mon, 22 Feb 2021 13:51:41 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 0/2] Make alloc_contig_range handle Hugetlb pages
Date:   Mon, 22 Feb 2021 14:51:35 +0100
Message-Id: <20210222135137.25717-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Oscar Salvador (2):
  mm: Make alloc_contig_range handle free hugetlb pages
  mm: Make alloc_contig_range handle in-use hugetlb pages

 include/linux/hugetlb.h |   7 +++
 mm/compaction.c         |  22 +++++++++
 mm/hugetlb.c            | 124 +++++++++++++++++++++++++++++++++++++++++++++++-
 mm/vmscan.c             |   5 +-
 4 files changed, 154 insertions(+), 4 deletions(-)

-- 
2.16.3

