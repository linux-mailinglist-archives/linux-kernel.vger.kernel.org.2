Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACC9437445
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhJVJFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232547AbhJVJFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:05:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2E5E611CB;
        Fri, 22 Oct 2021 09:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634893403;
        bh=o2rX01+ZUM8v0v0greyBGNE1DypzwZSAOJDUMHdaR9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PikmEw5O9n/9NAmxCZiLlNkGV6RCd4XSU1m/fL5uWP7HQNhd2kw0+t+2tdSITSLGY
         2xROdyWrASKgeHi94rnKJLMBnHKQmHbid1Pz8mtnBAXMswVK++0zHPqICAOlHNoiEL
         LCLTIpApVY6DNiU44nX6mAGQuCiyDc719shhRWV48DhkzbtodUKxOMmEPQHH9trWEO
         m/A/zjxF00gEWyL45NEGKtwvbycxEVAmHsLKUSgTHhdf1fiCGY7Xc6LNFx4pXOKrSG
         KKclpoWD1OZrhT70Q1gmc+Nc6qc5z0KrKDSMYqgYfmtI3z9RTafGSDaFf8kketmBO2
         RgXd0YO4zCe8w==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     peterx@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/4] Docs/admin-guide/mm/pagemap: Wordsmith page flags descriptions
Date:   Fri, 22 Oct 2021 09:03:11 +0000
Message-Id: <20211022090311.3856-5-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022090311.3856-1-sj@kernel.org>
References: <20211022090311.3856-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some descriptions of page flags in 'pagemap.rst' are written in
assumption of none-rst, which respects every new line, as below:

    7 - SLAB
       page is managed by the SLAB/SLOB/SLUB/SLQB kernel memory allocator
       When compound page is used, SLUB/SLQB will only set this flag on the head

Because rst ignores the new line between the first sentence and second
sentence, resulting html looks a little bit weird, as below.

    7 - SLAB
    page is managed by the SLAB/SLOB/SLUB/SLQB kernel memory allocator When
                                                                       ^
    compound page is used, SLUB/SLQB will only set this flag on the head
    page; SLOB will not flag it at all.

This commit makes it more natural and consistent with other parts in the
rendered version.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/pagemap.rst | 53 ++++++++++++------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index fdc19fbc1083..242d84315066 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -90,13 +90,14 @@ Short descriptions to the page flags
 ====================================
 
 0 - LOCKED
-   page is being locked for exclusive access, e.g. by undergoing read/write IO
+   The page is being locked for exclusive access, e.g. by undergoing read/write
+   IO.
 7 - SLAB
-   page is managed by the SLAB/SLOB/SLUB/SLQB kernel memory allocator
+   The page is managed by the SLAB/SLOB/SLUB/SLQB kernel memory allocator.
    When compound page is used, SLUB/SLQB will only set this flag on the head
    page; SLOB will not flag it at all.
 10 - BUDDY
-    a free memory block managed by the buddy system allocator
+    A free memory block managed by the buddy system allocator.
     The buddy system organizes free memory in blocks of various orders.
     An order N block has 2^N physically contiguous pages, with the BUDDY flag
     set for and _only_ for the first page.
@@ -112,65 +113,65 @@ Short descriptions to the page flags
 16 - COMPOUND_TAIL
     A compound page tail (see description above).
 17 - HUGE
-    this is an integral part of a HugeTLB page
+    This is an integral part of a HugeTLB page.
 19 - HWPOISON
-    hardware detected memory corruption on this page: don't touch the data!
+    Hardware detected memory corruption on this page: don't touch the data!
 20 - NOPAGE
-    no page frame exists at the requested address
+    No page frame exists at the requested address.
 21 - KSM
-    identical memory pages dynamically shared between one or more processes
+    Identical memory pages dynamically shared between one or more processes.
 22 - THP
-    contiguous pages which construct transparent hugepages
+    Contiguous pages which construct transparent hugepages.
 23 - OFFLINE
-    page is logically offline
+    The page is logically offline.
 24 - ZERO_PAGE
-    zero page for pfn_zero or huge_zero page
+    Zero page for pfn_zero or huge_zero page.
 25 - IDLE
-    page has not been accessed since it was marked idle (see
+    The page has not been accessed since it was marked idle (see
     :ref:`Documentation/admin-guide/mm/idle_page_tracking.rst <idle_page_tracking>`).
     Note that this flag may be stale in case the page was accessed via
     a PTE. To make sure the flag is up-to-date one has to read
     ``/sys/kernel/mm/page_idle/bitmap`` first.
 26 - PGTABLE
-    page is in use as a page table
+    The page is in use as a page table.
 
 IO related page flags
 ---------------------
 
 1 - ERROR
-   IO error occurred
+   IO error occurred.
 3 - UPTODATE
-   page has up-to-date data
+   The page has up-to-date data.
    ie. for file backed page: (in-memory data revision >= on-disk one)
 4 - DIRTY
-   page has been written to, hence contains new data
+   The page has been written to, hence contains new data.
    i.e. for file backed page: (in-memory data revision >  on-disk one)
 8 - WRITEBACK
-   page is being synced to disk
+   The page is being synced to disk.
 
 LRU related page flags
 ----------------------
 
 5 - LRU
-   page is in one of the LRU lists
+   The page is in one of the LRU lists.
 6 - ACTIVE
-   page is in the active LRU list
+   The page is in the active LRU list.
 18 - UNEVICTABLE
-   page is in the unevictable (non-)LRU list It is somehow pinned and
+   The page is in the unevictable (non-)LRU list It is somehow pinned and
    not a candidate for LRU page reclaims, e.g. ramfs pages,
-   shmctl(SHM_LOCK) and mlock() memory segments
+   shmctl(SHM_LOCK) and mlock() memory segments.
 2 - REFERENCED
-   page has been referenced since last LRU list enqueue/requeue
+   The page has been referenced since last LRU list enqueue/requeue.
 9 - RECLAIM
-   page will be reclaimed soon after its pageout IO completed
+   The page will be reclaimed soon after its pageout IO completed.
 11 - MMAP
-   a memory mapped page
+   A memory mapped page.
 12 - ANON
-   a memory mapped page that is not part of a file
+   A memory mapped page that is not part of a file.
 13 - SWAPCACHE
-   page is mapped to swap space, i.e. has an associated swap entry
+   The page is mapped to swap space, i.e. has an associated swap entry.
 14 - SWAPBACKED
-   page is backed by swap/RAM
+   The page is backed by swap/RAM.
 
 The page-types tool in the tools/vm directory can be used to query the
 above flags.
-- 
2.17.1

