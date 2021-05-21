Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB0738C570
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhEULMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhEULMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:12:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFCFC061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:10:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m11so29127728lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dY2y9aKeo/ZMCSdKUAsnLMpDCyQEYPOq6MG/ijjQDaY=;
        b=dR+Rc/II7qPL3N657JzarIqj64kAMMQxAXaBZsaso4Dt3Zwl7VdOaAveVfdp7bu1hA
         4R0Q9WRqODbQ5j5xMJrYmxtxVG5zbsd82qyz3dr1+XtLl/PTXLkTwTSC/mOfBNKRV4De
         Azjz+SKAXu3r/kD/zrpzgcBdg4z8U4+DRFEDAUGfspjOGOKykxUX7Cj8jMC4sBP+WZ6U
         eihcExCjCmBZ/AlgXDLnhEgdcjpsaWrhAL7tD27rFy2bE6umQj0kObCHF+nqjnujSFBT
         LkUOYlU4PSAs1ml4dhs0moo5TDmgeyCZ8zTlLCecWefECcO/7mjClLfl32Jy4Zdl684V
         IoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dY2y9aKeo/ZMCSdKUAsnLMpDCyQEYPOq6MG/ijjQDaY=;
        b=oOBt2ezGHarJuia+2mof2Rlt0ocywkcmamuXrJvFc1yxGXO6X82nmLp0FzCP9ZaXd3
         +Qxtg6SnN2pyrWsbE2d+eZ5vAVlXoW55fTOv92BJrwes5ffqEYd2dRSqAwI44dJ6TKEg
         zFZaLJX+4BYKBd8nPHoMpSEdRvpnMH696hJ5DCubTPUxqZpswq9SwECPl/7VJ5snoip/
         hdfFqo4+WAQDoOe3fA+s6UNkvE/CABMCr/IZMICSSaKr0uSEUBMVyot+6UCthHqhf5wM
         oJtYry9U2VTw0sRHnePm5fcWjtJJ4Ci4AC4iqTC980SrSUmkixPcFzd1nQg7p4j+E2JZ
         K4Ow==
X-Gm-Message-State: AOAM533eS78UyMY59B3kTnd9xGO2d+E72UgBN+YWRzI1qI3eVQsD3DTc
        aIU9H4Ei8UvhL2cS2RcT8Sw=
X-Google-Smtp-Source: ABdhPJwZxhvncSAhwQZtONlWM3JjUIIzWRUhLTqnTisq19WJZSpKdSi5N9TwKW6T+pxzITZB9Ipvpg==
X-Received: by 2002:a05:6512:3882:: with SMTP id n2mr1839065lft.193.1621595442266;
        Fri, 21 May 2021 04:10:42 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id d19sm606661ljg.52.2021.05.21.04.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:10:41 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] mm/vmalloc: Fallback to a single page allocator
Date:   Fri, 21 May 2021 13:10:33 +0200
Message-Id: <20210521111033.2243-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for order-0 pages we use a bulk-page allocator to get
set of pages. From the other hand not allocating all pages is
something that might occur. In that case we should fallbak to
the single-page allocator trying to get missing pages, because
it is more permissive(direct reclaim, etc).

Introduce a vm_area_alloc_pages() function where the described
logic is implemented.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 81 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 29 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b2a0cbfa37c1..4d9c422124d3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2756,6 +2756,54 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
+static inline unsigned int
+vm_area_alloc_pages(gfp_t gfp, int nid, unsigned int page_order,
+	unsigned long nr_small_pages, struct page **pages)
+{
+	unsigned int nr_allocated = 0;
+
+	/*
+	 * For order-0 pages we make use of bulk allocator, if
+	 * the page array is partly or not at all populated due
+	 * to fails, fallback to a single page allocator that is
+	 * more permissive.
+	 */
+	if (!page_order)
+		nr_allocated = alloc_pages_bulk_array_node(
+			gfp, nid, nr_small_pages, pages);
+	else
+		/*
+		 * Compound pages required for remap_vmalloc_page if
+		 * high-order pages.
+		 */
+		gfp |= __GFP_COMP;
+
+	/* High-order pages or fallback path if "bulk" fails. */
+	while (nr_allocated < nr_small_pages) {
+		struct page *page;
+		int i;
+
+		page = alloc_pages_node(nid, gfp, page_order);
+		if (unlikely(!page))
+			break;
+
+		/*
+		 * Careful, we allocate and map page_order pages, but
+		 * tracking is done per PAGE_SIZE page so as to keep the
+		 * vm_struct APIs independent of the physical/mapped size.
+		 */
+		for (i = 0; i < (1U << page_order); i++)
+			pages[nr_allocated + i] = page + i;
+
+		if (gfpflags_allow_blocking(gfp))
+			cond_resched();
+
+		nr_allocated += 1U << page_order;
+	}
+
+	return nr_allocated;
+}
+
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				 pgprot_t prot, unsigned int page_shift,
 				 int node)
@@ -2789,37 +2837,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	area->nr_pages = 0;
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
 	page_order = vm_area_page_order(area);
 
-	if (!page_order) {
-		area->nr_pages = alloc_pages_bulk_array_node(
-			gfp_mask, node, nr_small_pages, area->pages);
-	} else {
-		/*
-		 * Careful, we allocate and map page_order pages, but tracking is done
-		 * per PAGE_SIZE page so as to keep the vm_struct APIs independent of
-		 * the physical/mapped size.
-		 */
-		while (area->nr_pages < nr_small_pages) {
-			struct page *page;
-			int i;
-
-			/* Compound pages required for remap_vmalloc_page */
-			page = alloc_pages_node(node, gfp_mask | __GFP_COMP, page_order);
-			if (unlikely(!page))
-				break;
-
-			for (i = 0; i < (1U << page_order); i++)
-				area->pages[area->nr_pages + i] = page + i;
-
-			if (gfpflags_allow_blocking(gfp_mask))
-				cond_resched();
-
-			area->nr_pages += 1U << page_order;
-		}
-	}
+	area->nr_pages = vm_area_alloc_pages(gfp_mask, node,
+		page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
@@ -2835,7 +2857,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		goto fail;
 	}
 
-	if (vmap_pages_range(addr, addr + size, prot, area->pages, page_shift) < 0) {
+	if (vmap_pages_range(addr, addr + size, prot, area->pages,
+			page_shift) < 0) {
 		warn_alloc(gfp_mask, NULL,
 			   "vmalloc size %lu allocation failure: "
 			   "failed to map pages",
-- 
2.20.1

