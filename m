Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4067F3C2195
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhGIJbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:31:42 -0400
Received: from mail-m17640.qiye.163.com ([59.111.176.40]:47556 "EHLO
        mail-m17640.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhGIJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:31:41 -0400
DKIM-Signature: a=rsa-sha256;
        b=XAH0IEfcRfeZE7UB/65emWi7kublQJLvo590LGrtaCreJgfQ3tfTL5KYUQbqHQpCCf7fUxNcYQWtXWumlz6991kod97e02TJnGTpkApl6ZfItpt4Z0DbmbMswYCKvN8qRy4jXtehwsoX/aB6z5UBu0CXI8+zGBpRUYB/KiZ7Lnw=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=k9wd7HqyzcT7Q175fHyVzh2jv7YkhXwVzBNioWAiaPU=;
        h=date:mime-version:subject:message-id:from;
Received: from NJ-11133793.vivo.xyz (unknown [36.152.145.180])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id 5558954030E;
        Fri,  9 Jul 2021 17:28:56 +0800 (CST)
From:   Yang Huan <link@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yang Huan <link@vivo.com>
Subject: [PATCH] mm/vmalloc: try alloc_pages_bulk first to get order 0 pages fast
Date:   Fri,  9 Jul 2021 17:28:31 +0800
Message-Id: <20210709092831.10602-1-link@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQklDQ1ZPTx5JHk1KTE5NSR9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PlE6MSo6ST9CKhIcGikOUQwL
        KBwaCTxVSlVKTUlOQ0lJQkhNQ0tOVTMWGhIXVRcSFRA7DRINFFUYFBZFWVdZEgtZQVlITVVKTklV
        Sk9OVUpDS1lXWQgBWUFJTENPNwY+
X-HM-Tid: 0a7a8a993d71d995kuws5558954030e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vmalloc may offen get pages by loop invoke alloc_pags, this is
cost too much time in count watermark/cpuset or something.
Let's just try alloc by alloc_pages_bulk, if failed, fullback in
original path.

With my own test, simulate loop alloc_page and alloc_pages_bulk_array,
get this:
size		1M	10M	20M	30
normal		44	1278	3665	5581
test		34	889	2167	3300
optimize	22%	30%	40%	40%
And in my vmalloc top sort, zram/f2fs may alloc more than 20MB, so,
It's worth to use alloc_pages_bulk.

Signed-off-by: Yang Huan <link@vivo.com>
---
 mm/vmalloc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a13ac524f6ff..b5af7b4e30bc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2791,17 +2791,23 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 
 	area->pages = pages;
-	area->nr_pages = nr_small_pages;
+	area->nr_pages = 0;
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
 
 	page_order = vm_area_page_order(area);
-
+	/* first try alloc in alloc bulk when order is 0*/
+	if (!page_order) {
+		area->nr_pages = alloc_pages_bulk_array(
+			gfp_mask, nr_small_pages, area->pages);
+		if (likely(area->nr_pages == nr_small_pages))
+			goto success;
+	}
 	/*
 	 * Careful, we allocate and map page_order pages, but tracking is done
 	 * per PAGE_SIZE page so as to keep the vm_struct APIs independent of
 	 * the physical/mapped size.
 	 */
-	for (i = 0; i < area->nr_pages; i += 1U << page_order) {
+	for (i = area->nr_pages; i < nr_small_pages; i += 1U << page_order) {
 		struct page *page;
 		int p;
 
@@ -2824,6 +2830,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		if (gfpflags_allow_blocking(gfp_mask))
 			cond_resched();
 	}
+	area->nr_pages = nr_small_pages;
+success:
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
 	if (vmap_pages_range(addr, addr + size, prot, pages, page_shift) < 0) {
-- 
2.32.0

