Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18AE345018
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhCVTky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhCVTkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:40:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B11CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bbKq2TN24ehai17x54FTajuPZY8Y2HOgf1z2a1oFDYM=; b=eMBWqZNOQwUsdB2mgz/CqQEgf6
        Z8B5Ij5hAWqr/XbEBV16kSiKqeqe3tqD/86ydgEeERKsgX4ghr2/RC+Uekt4Zf+jyx4/anr7uMWHy
        uuG2dH+HtfRtuCNC7KbFBv5lNeK4jE6NvfmlUYSrw0m80uSoKEIS2mayvdDC+nzPIj4qUJqV6d6QG
        pRMOagFX+7TbAo+u2IoaqosO1ipVWUR9Thd9bmwFHc4gipggu0l0Qvfkuf9JwqrsTEg5T6bJTRMc3
        k2ghvKCazeq7g6ZFagydv8ZlPMMcaY7dA/L46Xp9wJszaHmngZ1QQYNnfk2dO0LPvOEGcpepEtqZ3
        XhLChCng==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOQNw-008yqi-BF; Mon, 22 Mar 2021 19:38:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/2] mm/vmalloc: Use kvmalloc to allocate the table of pages
Date:   Mon, 22 Mar 2021 19:38:20 +0000
Message-Id: <20210322193820.2140045-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322193820.2140045-1-willy@infradead.org>
References: <20210322193820.2140045-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're trying to allocate 4MB of memory, the table will be 8KiB in size
(1024 pointers * 8 bytes per pointer), which can usually be satisfied
by a kmalloc (which is significantly faster).  Instead of changing this
open-coded implementation, just use kvmalloc().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmalloc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 96444d64129a..32b640a84250 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2802,13 +2802,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		gfp_mask |= __GFP_HIGHMEM;
 
 	/* Please note that the recursion is strictly bounded. */
-	if (array_size > PAGE_SIZE) {
-		pages = __vmalloc_node(array_size, 1, nested_gfp, node,
+	pages = kvmalloc_node_caller(array_size, nested_gfp, node,
 					area->caller);
-	} else {
-		pages = kmalloc_node(array_size, nested_gfp, node);
-	}
-
 	if (!pages) {
 		free_vm_area(area);
 		return NULL;
-- 
2.30.2

