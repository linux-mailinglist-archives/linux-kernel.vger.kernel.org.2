Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBAC40C47A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhIOLoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:44:34 -0400
Received: from relay.sw.ru ([185.231.240.75]:40270 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232526AbhIOLod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=81lya9o+zF6tso2afua76Z8Or6SzheGH2IL+qPP3swU=; b=e1kLTcI7TqaW2QAtOkP
        7WX4J+NclS5N7WYGLw0iLtT7eiDqLdZ41kP+wfILI54kWWVsoM05DJbmXJ9YC2sHbEMZWy6LrUumn
        iT0FN56YMTkbO7AwhBl+Hh4F8dTJFCdK4FnZhnav7hXk6Rj7kFs4zk1xdIzUGrP0c5RYYnIFVpM=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mQTJn-0024Zj-4u; Wed, 15 Sep 2021 14:43:11 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH mm] mm/vmalloc: repair warn_alloc()s in __vmalloc_area_node()
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Message-ID: <f4f3187b-9684-e426-565d-827c2a9bbb0e@virtuozzo.com>
Date:   Wed, 15 Sep 2021 14:43:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f255935b9767 ("mm: cleanup the gfp_mask handling in
__vmalloc_area_node") added __GFP_NOWARN to gfp_mask unconditionally
however it disabled all output inside warn_alloc() call.
This patch saves original gfp_mask and provides it to all warn_alloc() calls.

Fixes: f255935b9767 ("mm: cleanup the gfp_mask handling in __vmalloc_area_node")
Cc: Christoph Hellwig <hch@lst.de>

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/vmalloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 551011399974..ff8538b1b28f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2888,6 +2888,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				 int node)
 {
 	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
+	const gfp_t orig_gfp_mask = gfp_mask;
 	unsigned long addr = (unsigned long)area->addr;
 	unsigned long size = get_vm_area_size(area);
 	unsigned long array_size;
@@ -2908,7 +2909,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 
 	if (!area->pages) {
-		warn_alloc(gfp_mask, NULL,
+		warn_alloc(orig_gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to allocated page array size %lu",
 			nr_small_pages * PAGE_SIZE, array_size);
 		free_vm_area(area);
@@ -2928,7 +2929,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 * allocation request, free them via __vfree() if any.
 	 */
 	if (area->nr_pages != nr_small_pages) {
-		warn_alloc(gfp_mask, NULL,
+		warn_alloc(orig_gfp_mask, NULL,
 			"vmalloc error: size %lu, page order %u, failed to allocate pages",
 			area->nr_pages * PAGE_SIZE, page_order);
 		goto fail;
@@ -2936,7 +2937,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	if (vmap_pages_range(addr, addr + size, prot, area->pages,
 			page_shift) < 0) {
-		warn_alloc(gfp_mask, NULL,
+		warn_alloc(orig_gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to map pages",
 			area->nr_pages * PAGE_SIZE);
 		goto fail;
-- 
2.31.1

