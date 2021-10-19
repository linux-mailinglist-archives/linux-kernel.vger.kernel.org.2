Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775734339B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhJSPKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232109AbhJSPKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3525F6103D;
        Tue, 19 Oct 2021 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656071;
        bh=OWvKAr2to9kAJNZAYsVeoYRYbSQNFp01JVyK9wyJw+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9+al89Zh9k+IFNfsLlPn5zFktmRa/DXo4MnENdFNGlxDhFaBkSkEnsf0cWuAcYYn
         p7rSdavdFiCNkvNRhqgTqO4E6zjKPOYY3JZAZqXBIwr5t4SGx/GFJQCibeQpLyTOHw
         XNqjNw1FLvcF/8LXOwpFqCOuRvYYggWFdbNBe+HfL2NimQmcbC2NPSt6ayIOyDXgnc
         we19vyf+hmwXx+mXfs/e7Wk/bFjxeZGPIPDYfcy32NnqUhBeS13sqdt2n92oGqu/Yv
         95+Zm80PS2E9n4F1cb5DVngUviKpIKKSYoHDsqLh2uVsZo53Ni213wN0IKvUGsy7E4
         1BEoFP+a3vw3g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] mm/damon/paddr: Support the pageout scheme
Date:   Tue, 19 Oct 2021 15:07:17 +0000
Message-Id: <20211019150731.16699-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the DAMON primitives for physical address space
support the pageout action for DAMON-based Operation Schemes.  With this
commit, hence, users can easily implement system-level data access-aware
reclamations using DAMOS.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d7a2ecd09ed0..957ada55de77 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -11,7 +11,9 @@
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/swap.h>
 
+#include "../internal.h"
 #include "prmtv-common.h"
 
 static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
@@ -211,6 +213,39 @@ bool damon_pa_target_valid(void *t)
 	return true;
 }
 
+int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme)
+{
+	unsigned long addr;
+	LIST_HEAD(page_list);
+
+	if (scheme->action != DAMOS_PAGEOUT)
+		return -EINVAL;
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct page *page = damon_get_page(PHYS_PFN(addr));
+
+		if (!page)
+			continue;
+
+		ClearPageReferenced(page);
+		test_and_clear_page_young(page);
+		if (isolate_lru_page(page)) {
+			put_page(page);
+			continue;
+		}
+		if (PageUnevictable(page)) {
+			putback_lru_page(page);
+		} else {
+			list_add(&page->lru, &page_list);
+			put_page(page);
+		}
+	}
+	reclaim_pages(&page_list);
+	cond_resched();
+	return 0;
+}
+
 void damon_pa_set_primitives(struct damon_ctx *ctx)
 {
 	ctx->primitive.init = NULL;
@@ -220,5 +255,5 @@ void damon_pa_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.reset_aggregated = NULL;
 	ctx->primitive.target_valid = damon_pa_target_valid;
 	ctx->primitive.cleanup = NULL;
-	ctx->primitive.apply_scheme = NULL;
+	ctx->primitive.apply_scheme = damon_pa_apply_scheme;
 }
-- 
2.17.1

