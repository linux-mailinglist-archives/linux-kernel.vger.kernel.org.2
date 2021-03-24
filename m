Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30055347BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhCXPJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbhCXPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:08:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2333C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=abzLZDSImtUt7gowe+fZWKLMOfxUM8lbrZGEl5NlJeE=; b=DP5U0ziYjavGXyvDlMHC5tOdpp
        2+6l7JStA6bWAK2kdHpRNk+Sozs5P0azkTYpOvTb+Iq0jmPFsDg44/qJ/UKN+sCzBloTUL4d2ehp8
        LDBCJQli5Z/nUYz4FzXZ8kmaldxiwgm2tPNh7TvBjhKvJU/8JVrgZ6C2L1FZx0rJqkCfk58zzZ82K
        XaNpR5cZe1gS7m6vpLv6CxSp24Ib06w1kbGfIwVD2jqCQnL0SjMDP5mBNKt6UCSF2QTB9u+j8m2Qm
        98oD8at91d10HUiHnFSsCG14+xiOesFUkGhK9HR/DFZearCRujZ9D7uGe8V3AI86e7GHXpZxAD1j4
        w+Q97wSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lP56J-00BUEF-Gj; Wed, 24 Mar 2021 15:07:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 3/4] mm/vmalloc: Use kvmalloc to allocate the table of pages
Date:   Wed, 24 Mar 2021 15:05:17 +0000
Message-Id: <20210324150518.2734402-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210324150518.2734402-1-willy@infradead.org>
References: <20210324150518.2734402-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're trying to allocate 4MB of memory, the table will be 8KiB in size
(1024 pointers * 8 bytes per pointer), which can usually be satisfied
by a kmalloc (which is significantly faster).  Instead of changing this
open-coded implementation, just use kvmalloc().

This improves the allocation speed of vmalloc(4MB) by approximately
5% in our benchmark.  It's still dominated by the 1024 calls to
alloc_pages_node(), which will be the subject of a later patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmalloc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a22241e9c363..a9ed2a4b697e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2801,13 +2801,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
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

