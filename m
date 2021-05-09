Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5B137781E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 21:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhEITkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 15:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEITkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 15:40:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A283BC061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 12:38:56 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p12so18183704ljg.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9KHoUwqxbexOhqNv8F1Ywyb8vsO2FBF8NuW/VNOiPo=;
        b=VaZ5jstwwQCops8VcXABpwtZedX2N9xGSqxNt94hO02IGPASRBxnIMwnDKVET16xIi
         qrW9cC7TB3wiCLgTDnnj9R1JMDHfvUU/N7jVA/46hjEV8jZkc9PdX4CtqaPZejlKJVUp
         ETz4JyWiit7zgBhH8pkTWPAL3OW++bggSY7s8K7R3cKRt8KBX9HqpHsIyJAxbyptwYUp
         7tHEmMuazGZlkq8s1AxphPfoqkf71QP0FICuzJbptiSV+NoAzL5W24z1O5RNM3BfOrRn
         HXLZI4BQBCnWlqdDzHonZEbrNU7Wg+GhQBCjZar4gDpxl+NrGpuGnfuR35q+q74fSAVk
         6hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9KHoUwqxbexOhqNv8F1Ywyb8vsO2FBF8NuW/VNOiPo=;
        b=dnCSiD1OXE8NA7PVR4o+ZwO5vD5EAAT9Ckj3D1RsGUzRtWzwWN65i28Cxn5OrVtLfK
         voIJKgg2lIVNVnq46gNd9mSIoVRo9nmEKxJvyg9/I15G0KkQNvBVJ0F+F7M31xHSCNkc
         4xjMdNG+mcIIOvzZ5o4zUDK96YNUgZPJi7QToD2/t1GqHkETA6dE1j80Ce3c21cyrOhx
         x5TRMRQo8bKZ/9JPs9cGVj1A8XMvsFXbOJSQUZeqZfjfYJLuq05vGDvmpmg9Nu6kAmbw
         Ge4AEa3aA4cHu67YXkUwbFw/A1QeXRGNBxBBOVJ+EVCW6p2bh20c77BQ86/tHft6SqzW
         zbTA==
X-Gm-Message-State: AOAM530irkVx5bOObBko8WhOrzE0dY+hFC5rh1yV1W0FABhnhU5X/9kZ
        PBEoasr09WlNy8j2ErQzTH8=
X-Google-Smtp-Source: ABdhPJwoKB66eyiScOwS2EQBs77oKT0vsxLrKNhx3uXTnls4aHYUOxRXMZAoxnrRucSwVYo2UlrlIw==
X-Received: by 2002:a2e:b5cd:: with SMTP id g13mr17743675ljn.0.1620589135179;
        Sun, 09 May 2021 12:38:55 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m17sm1999269lfh.146.2021.05.09.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 12:38:54 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/2] mm/vmalloc: Switch to bulk allocator in __vmalloc_area_node()
Date:   Sun,  9 May 2021 21:38:43 +0200
Message-Id: <20210509193844.2562-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently there has been introduced a page bulk allocator for
users which need to get number of pages per one call request.

For order-0 pages switch to __alloc_pages_bulk() instead of
alloc_pages_node(), the reason is the former is not capable
of allocating set of pages, thus a one call is per one page.

Second, according to my tests the bulk allocator uses less
cycles even for scenarios when only one page is requested.
Running the "perf" on same test case shows below difference:

<default>
  - 45.18% __vmalloc_node
     - __vmalloc_node_range
        - 35.60% __alloc_pages
           - get_page_from_freelist
                3.36% __list_del_entry_valid
                3.00% check_preemption_disabled
                1.42% prep_new_page
<default>

<patch>
  - 31.00% __vmalloc_node
     - __vmalloc_node_range
        - 14.48% __alloc_pages_bulk
             3.22% __list_del_entry_valid
           - 0.83% __alloc_pages
                get_page_from_freelist
<patch>

The "test_vmalloc.sh" also shows performance improvements:

fix_size_alloc_test_4MB   loops: 1000000 avg: 89105095 usec
fix_size_alloc_test       loops: 1000000 avg: 513672   usec
full_fit_alloc_test       loops: 1000000 avg: 748900   usec
long_busy_list_alloc_test loops: 1000000 avg: 8043038  usec
random_size_alloc_test    loops: 1000000 avg: 4028582  usec
fix_align_alloc_test      loops: 1000000 avg: 1457671  usec

fix_size_alloc_test_4MB   loops: 1000000 avg: 62083711 usec
fix_size_alloc_test       loops: 1000000 avg: 449207   usec
full_fit_alloc_test       loops: 1000000 avg: 735985   usec
long_busy_list_alloc_test loops: 1000000 avg: 5176052  usec
random_size_alloc_test    loops: 1000000 avg: 2589252  usec
fix_align_alloc_test      loops: 1000000 avg: 1365009  usec

For example 4MB allocations illustrates ~30% gain, all the
rest is also better.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 74 ++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5d96fee17226..dbc6744400d5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2766,8 +2766,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	unsigned long array_size;
 	unsigned int nr_small_pages = size >> PAGE_SHIFT;
 	unsigned int page_order;
-	struct page **pages;
-	unsigned int i;
 
 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
 	gfp_mask |= __GFP_NOWARN;
@@ -2776,13 +2774,13 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
-		pages = __vmalloc_node(array_size, 1, nested_gfp, node,
+		area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
 					area->caller);
 	} else {
-		pages = kmalloc_node(array_size, nested_gfp, node);
+		area->pages = kmalloc_node(array_size, nested_gfp, node);
 	}
 
-	if (!pages) {
+	if (!area->pages) {
 		free_vm_area(area);
 		warn_alloc(gfp_mask, NULL,
 			   "vmalloc size %lu allocation failure: "
@@ -2791,43 +2789,51 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	area->pages = pages;
-	area->nr_pages = nr_small_pages;
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
-
 	page_order = vm_area_page_order(area);
 
-	/*
-	 * Careful, we allocate and map page_order pages, but tracking is done
-	 * per PAGE_SIZE page so as to keep the vm_struct APIs independent of
-	 * the physical/mapped size.
-	 */
-	for (i = 0; i < area->nr_pages; i += 1U << page_order) {
-		struct page *page;
-		int p;
-
-		/* Compound pages required for remap_vmalloc_page */
-		page = alloc_pages_node(node, gfp_mask | __GFP_COMP, page_order);
-		if (unlikely(!page)) {
-			/* Successfully allocated i pages, free them in __vfree() */
-			area->nr_pages = i;
-			atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
-			warn_alloc(gfp_mask, NULL,
-				   "vmalloc size %lu allocation failure: "
-				   "page order %u allocation failed",
-				   area->nr_pages * PAGE_SIZE, page_order);
-			goto fail;
-		}
+	if (!page_order) {
+		area->nr_pages = __alloc_pages_bulk(gfp_mask, node,
+			NULL, nr_small_pages, NULL, area->pages);
+	} else {
+		/*
+		 * Careful, we allocate and map page_order pages, but tracking is done
+		 * per PAGE_SIZE page so as to keep the vm_struct APIs independent of
+		 * the physical/mapped size.
+		 */
+		for (area->nr_pages = 0; area->nr_pages < nr_small_pages;
+				area->nr_pages += 1U << page_order) {
+			struct page *page;
+			int i;
+
+			/* Compound pages required for remap_vmalloc_page */
+			page = alloc_pages_node(node, gfp_mask | __GFP_COMP, page_order);
+			if (unlikely(!page))
+				break;
 
-		for (p = 0; p < (1U << page_order); p++)
-			area->pages[i + p] = page + p;
+			for (i = 0; i < (1U << page_order); i++)
+				area->pages[area->nr_pages + i] = page + i;
 
-		if (gfpflags_allow_blocking(gfp_mask))
-			cond_resched();
+			if (gfpflags_allow_blocking(gfp_mask))
+				cond_resched();
+		}
 	}
+
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
-	if (vmap_pages_range(addr, addr + size, prot, pages, page_shift) < 0) {
+	/*
+	 * If not enough pages were obtained to accomplish an
+	 * allocation request, free them via __vfree() if any.
+	 */
+	if (area->nr_pages != nr_small_pages) {
+		warn_alloc(gfp_mask, NULL,
+			"vmalloc size %lu allocation failure: "
+			"page order %u allocation failed",
+			area->nr_pages * PAGE_SIZE, page_order);
+		goto fail;
+	}
+
+	if (vmap_pages_range(addr, addr + size, prot, area->pages, page_shift) < 0) {
 		warn_alloc(gfp_mask, NULL,
 			   "vmalloc size %lu allocation failure: "
 			   "failed to map pages",
-- 
2.20.1

