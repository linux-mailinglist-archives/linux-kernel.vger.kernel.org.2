Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7016E3820DE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 22:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhEPUW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 16:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbhEPUWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 16:22:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F9FC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 13:21:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x19so5759732lfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cF2r85Mr4qUSBfbgYkkNE934MHXCK0CTayY0Q/HL8fs=;
        b=SuMLTgGZwt/rQoxCVTlgbXsljsshfJPeu32D1fPDttHErdjridjR6B8/gU6r/hYq2S
         AioVnehGpCcMGOK7f4wC2/25Go62R92MUPUjmcT84qAjW9GM5bXqSmKMJe8MU5MQUO+B
         C1JsqtSyn/65gLSJnNL2RNxkheklb6hi3UjIMPR/8SywEd+J5Q6+vOkxneOdJPRibnK/
         uLi7nsQabeEqwAhzXHvJPbwqbncWKQB/GauWIDbAe+NbF6eQalRdGdUbiLhWm3xj/gVl
         O8OEWLN7IpY57O06nLimeRFsLbvFplW8vMVSN8594GWs3IlwEYRG+DxcQEfxZELgAwmm
         6LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cF2r85Mr4qUSBfbgYkkNE934MHXCK0CTayY0Q/HL8fs=;
        b=G9YBDsWkk+Kk1SMUDIhwixN83WXYqfuHaEwW59RkntCiCkkb/IFxzGG9iggsR9I/Vl
         jg64F9tChpNjOXMG9lTsnIwJ97yADTDH4+vpK1N8KWsoqZChYKQAHoVUG1xfyUcd5e/R
         redRaNl4hq4o6c5TIsy4C0ej0+IzBeup/rxjtMItXTuG7B5biSblPdMtQkvfozy6Wdxx
         kUZ8ihb3ANxzjbFOU9kdLjc23DxsMQhSE6Z3ZOirohS8S2gB8NstJJZ1CDgoZznjf1vy
         IqMh7pL/SJF1tlJXDtwJNX6+nQt4IJegVE5QqAr8FTBXGc8tmeKJvbstwddqiWTrLquv
         7g3A==
X-Gm-Message-State: AOAM531z9WV5AoWZWYb/OARKXe9zoUwsrUyAD5y3aKsoTBP+7rpsKmZb
        wSZpdakPx3oYK4yGMd5d+/c=
X-Google-Smtp-Source: ABdhPJxHExqEsLgO7J9y5KnkY1yEERii8lCTOv/3bJAnr9MP0mUzPnpLw4VB4MQIQy2+FxYaUCDvdA==
X-Received: by 2002:ac2:561a:: with SMTP id v26mr6360757lfd.602.1621196468675;
        Sun, 16 May 2021 13:21:08 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y28sm378195lfg.210.2021.05.16.13.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 13:21:08 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/3] mm/vmalloc: Switch to bulk allocator in __vmalloc_area_node()
Date:   Sun, 16 May 2021 22:20:55 +0200
Message-Id: <20210516202056.2120-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210516202056.2120-1-urezki@gmail.com>
References: <20210516202056.2120-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently there has been introduced a page bulk allocator for
users which need to get number of pages per one call request.

For order-0 pages switch to an alloc_pages_bulk_array_node()
instead of alloc_pages_node(), the reason is the former is
not capable of allocating set of pages, thus a one call is
per one page.

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
 mm/vmalloc.c | 76 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5d96fee17226..a8e50278019a 100644
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
@@ -2791,43 +2789,53 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	area->pages = pages;
-	area->nr_pages = nr_small_pages;
+	area->nr_pages = 0;
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
+		area->nr_pages = alloc_pages_bulk_array_node(
+			gfp_mask, node, nr_small_pages, area->pages);
+	} else {
+		/*
+		 * Careful, we allocate and map page_order pages, but tracking is done
+		 * per PAGE_SIZE page so as to keep the vm_struct APIs independent of
+		 * the physical/mapped size.
+		 */
+		while (area->nr_pages < nr_small_pages) {
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
+
+			area->nr_pages += 1U << page_order;
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

