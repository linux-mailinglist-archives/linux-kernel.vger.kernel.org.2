Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D09444954
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhKCUJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 16:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCUJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 16:09:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E6C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 13:07:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu18so7593984lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NPgQOWllbolCn3GA8pPnlXJFYgWP5jNVx5VhxEy+M4I=;
        b=hTHwtSsmO30+AU1dwz0KwbQnD7qLpZDbaiRaqoBo5FPPp0MyVotAP47eUpoLz+ksIx
         Qxzt3wnaMqazN0CZE2oQ/BWQO37t5AvewcFECrllBAO/jt1OSU6gzRkSOxcUd4Edc1ok
         0qKydQtH2EqQvmGfjrhFK3NkPjH9yjq24JMOfoxqaDjF8wUEgcSZweHVJ4t8n/G6H4oQ
         VoEW2MoFKXes1a8D/rndkZjFAeOdNv1YQ25TggiEUTWFwGOJPhuaUrDpTzWarzf7h4Ob
         YUzWKhvRjteret1SN2ARmUkwkHlkV5ihAAOgkY6YHyToqah0H/s/EPinAlTGO1WAkfjU
         CAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NPgQOWllbolCn3GA8pPnlXJFYgWP5jNVx5VhxEy+M4I=;
        b=l7uLWp8g4HUG62iNkAxJD8+KDRHlspuLyBoyMXqBnyWVwMISEFbGQvj/f9JrhFR1Vn
         HxEawSa4D/w61ngKeYYCTrCOt9uouTWD8qXrAcUCATDOyxOAYjgg1A/ISH748HHQGXny
         gdoX/wVYrXJ82CbyE8IZPinhEmI4xOhQfFvaqfmPmm0arW0JHlnRXleJVdRZMl6r0rA5
         BWQr1/acZphIudTzFWUz8nqjJTQdaH1+wnvCTW5/ZfOcVxULAru5z/+W55Chd4RExTTN
         vCP4ZhFljPNL759Fp9Cs2YVicenYh5rOcwfbPqW6GOdtiWKJUSaxS5lrxKloh9ZAvWLJ
         hSGw==
X-Gm-Message-State: AOAM5335JKgQ5kwtx2AyM3k5Nls/HdP03Wqih1vnfbqd5To0w+bjxPqw
        V5BNITe1c1vEBwBsR8WcI06Yu6KVy6qzkg==
X-Google-Smtp-Source: ABdhPJy8hfy2Cv1OWaCUXjQgRl9PW42lSjmMNzP+bbfdJKHMcXMQHOs8n80BwJ1qdxYi/AwrLm4DLQ==
X-Received: by 2002:a19:c352:: with SMTP id t79mr2168599lff.251.1635970032842;
        Wed, 03 Nov 2021 13:07:12 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u5sm288984lfo.280.2021.11.03.13.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 13:07:12 -0700 (PDT)
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
Subject: [PATCH] mm/vmalloc: Eliminate an extra orig_gfp_mask
Date:   Wed,  3 Nov 2021 21:07:03 +0100
Message-Id: <20211103200703.2265-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That extra variable has been introduced just for keeping an original
passed gfp_mask because it is updated with __GFP_NOWARN on entry, thus
error handling messages were broken.

Instead we can keep an original gfp_mask without modifying it and add
an extra __GFP_NOWARN flag together with gfp_mask as a parameter to
the vm_area_alloc_pages() function. It will make it less confused.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d2a00ad4e1dd..3b549ff5c95e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2920,7 +2920,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				 int node)
 {
 	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
-	const gfp_t orig_gfp_mask = gfp_mask;
 	unsigned long addr = (unsigned long)area->addr;
 	unsigned long size = get_vm_area_size(area);
 	unsigned long array_size;
@@ -2928,7 +2927,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	unsigned int page_order;
 
 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
-	gfp_mask |= __GFP_NOWARN;
+
 	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
 		gfp_mask |= __GFP_HIGHMEM;
 
@@ -2941,7 +2940,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 
 	if (!area->pages) {
-		warn_alloc(orig_gfp_mask, NULL,
+		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to allocated page array size %lu",
 			nr_small_pages * PAGE_SIZE, array_size);
 		free_vm_area(area);
@@ -2951,8 +2950,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
 	page_order = vm_area_page_order(area);
 
-	area->nr_pages = vm_area_alloc_pages(gfp_mask, node,
-		page_order, nr_small_pages, area->pages);
+	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
+		node, page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
@@ -2961,7 +2960,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 * allocation request, free them via __vfree() if any.
 	 */
 	if (area->nr_pages != nr_small_pages) {
-		warn_alloc(orig_gfp_mask, NULL,
+		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, page order %u, failed to allocate pages",
 			area->nr_pages * PAGE_SIZE, page_order);
 		goto fail;
@@ -2969,7 +2968,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	if (vmap_pages_range(addr, addr + size, prot, area->pages,
 			page_shift) < 0) {
-		warn_alloc(orig_gfp_mask, NULL,
+		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to map pages",
 			area->nr_pages * PAGE_SIZE);
 		goto fail;
-- 
2.17.1

