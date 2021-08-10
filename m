Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDFD3E86B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhHJXrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:47:37 -0400
Received: from out0.migadu.com ([94.23.1.103]:39516 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235501AbhHJXrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:47:35 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1628639230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ggLsS7yz1kOGaLQ3EmXt3GWbT2jgyKyTzpDsbhnW9U4=;
        b=XF1pS+k7eSAhin5XDAOYUApD2tBQV4RDKbjbW1fjqU0v4YgDWcMTfYtDbNECo7qgjvtZsb
        uziWUrqbgMq/hZ9QxNRhy0NqyBNmGUBmIIyrXKZlI1wQhyrFWbuLmYX+deUY6XjBlqwKyr
        NYaeoKy+xnNjW+8GQiqMsYedV9TPRps=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] mm/slub, kasan: fix checking page_alloc allocations on free
Date:   Wed, 11 Aug 2021 01:46:51 +0200
Message-Id: <ef00ee9e0cf2b8fbcdf639d5038c373b69c0e1e1.1628639145.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: andrey.konovalov@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

A fix for stat counters f227f0faf63b ("slub: fix unreclaimable slab stat
for bulk free") used page_address(page) as kfree_hook() argument instead
of object. While the change is technically correct, it breaks KASAN's
ability to detect improper (unaligned) pointers passed to kfree() and
causes the kmalloc_pagealloc_invalid_free test to fail.

This patch changes free_nonslab_page() to pass object to kfree_hook()
instead of page_address(page) as it was before the fix.

Fixed: f227f0faf63b ("slub: fix unreclaimable slab stat for bulk free")
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 mm/slub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index af984e4990e8..56079dd33c74 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3236,12 +3236,12 @@ struct detached_freelist {
 	struct kmem_cache *s;
 };
 
-static inline void free_nonslab_page(struct page *page)
+static inline void free_nonslab_page(void *object, struct page *page)
 {
 	unsigned int order = compound_order(page);
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
-	kfree_hook(page_address(page));
+	kfree_hook(object);
 	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
 	__free_pages(page, order);
 }
@@ -3282,7 +3282,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	if (!s) {
 		/* Handle kalloc'ed objects */
 		if (unlikely(!PageSlab(page))) {
-			free_nonslab_page(page);
+			free_nonslab_page(object, page);
 			p[size] = NULL; /* mark object processed */
 			return size;
 		}
@@ -4258,7 +4258,7 @@ void kfree(const void *x)
 
 	page = virt_to_head_page(x);
 	if (unlikely(!PageSlab(page))) {
-		free_nonslab_page(page);
+		free_nonslab_page(object, page);
 		return;
 	}
 	slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
-- 
2.25.1

