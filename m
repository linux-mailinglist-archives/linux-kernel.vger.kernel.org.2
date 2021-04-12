Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6239B35BBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhDLIKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbhDLIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:10:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A14C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TguJ2GPrgAOuTqINpCRxcU7hNVbLhj0fwULRtq3UU1o=; b=tXVKWgzFI9zH3GWTObAPMxRBO7
        qW1DBUMrGFm+8Qwf/5f5kaJgjQbPbuZpcBeMgGrqDamtRBPvw1pTpVr2UJ4wkG7xmDe6Di8Yizw13
        9GTs5P337jFcp1hh0+0w8DIuS2T1XcA/8X/8jZXO7LbqsXqd+cuSpUUH7XqRWZsrciuqpSa3T6ViU
        VHOH37AwdqrzYt8L/E5mcoFjehXgk/K7L0tv2LZGLuGVe+Usvs4yY8oqKCCGZ2mUiosLBOEzNf0su
        6HIQYT4g52hXFae7hh3SOYBAdzsTIEwobt/9jEhPDphWTjWsOUGbej5uU3GqxaW17j9jeBURm2Uxm
        3kRDFgFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVrcl-003yd8-5W; Mon, 12 Apr 2021 08:08:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7519D3001E1;
        Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3A78625F21530; Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Message-ID: <20210412080611.702979288@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 10:00:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: [PATCH 3/7] xen/gntdev: Remove apply_to_page_range() use from module
References: <20210412080012.357146277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on apply_to_page_range() being available to
modules, move its use into core kernel code and export it's
application.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/xen/gntdev-common.h |    2 ++
 drivers/xen/gntdev.c        |   30 +-----------------------------
 drivers/xen/grant-table.c   |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 29 deletions(-)

--- a/drivers/xen/gntdev-common.h
+++ b/drivers/xen/gntdev-common.h
@@ -86,4 +86,6 @@ bool gntdev_test_page_count(unsigned int
 
 int gntdev_map_grant_pages(struct gntdev_grant_map *map);
 
+int gnttab_use_ptemod(struct vm_area_struct *vma, struct gntdev_grant_map *map);
+
 #endif
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -262,32 +262,6 @@ void gntdev_put_map(struct gntdev_priv *
 
 /* ------------------------------------------------------------------ */
 
-static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
-{
-	struct gntdev_grant_map *map = data;
-	unsigned int pgnr = (addr - map->vma->vm_start) >> PAGE_SHIFT;
-	int flags = map->flags | GNTMAP_application_map | GNTMAP_contains_pte;
-	u64 pte_maddr;
-
-	BUG_ON(pgnr >= map->count);
-	pte_maddr = arbitrary_virt_to_machine(pte).maddr;
-
-	/*
-	 * Set the PTE as special to force get_user_pages_fast() fall
-	 * back to the slow path.  If this is not supported as part of
-	 * the grant map, it will be done afterwards.
-	 */
-	if (xen_feature(XENFEAT_gnttab_map_avail_bits))
-		flags |= (1 << _GNTMAP_guest_avail0);
-
-	gnttab_set_map_op(&map->map_ops[pgnr], pte_maddr, flags,
-			  map->grants[pgnr].ref,
-			  map->grants[pgnr].domid);
-	gnttab_set_unmap_op(&map->unmap_ops[pgnr], pte_maddr, flags,
-			    INVALID_GRANT_HANDLE);
-	return 0;
-}
-
 int gntdev_map_grant_pages(struct gntdev_grant_map *map)
 {
 	int i, err = 0;
@@ -1028,9 +1002,7 @@ static int gntdev_mmap(struct file *flip
 		mmu_interval_read_begin(&map->notifier);
 
 		map->pages_vm_start = vma->vm_start;
-		err = apply_to_page_range(vma->vm_mm, vma->vm_start,
-					  vma->vm_end - vma->vm_start,
-					  find_grant_ptes, map);
+		err = gnttab_use_ptemod(vma, map);
 		if (err) {
 			pr_warn("find_grant_ptes() failure.\n");
 			goto out_put_map;
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1591,6 +1591,43 @@ int gnttab_init(void)
 }
 EXPORT_SYMBOL_GPL(gnttab_init);
 
+#include <xen/gntdev.h>
+#include "gntdev-common.h"
+
+static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
+{
+	struct gntdev_grant_map *map = data;
+	unsigned int pgnr = (addr - map->vma->vm_start) >> PAGE_SHIFT;
+	int flags = map->flags | GNTMAP_application_map | GNTMAP_contains_pte;
+	u64 pte_maddr;
+
+	BUG_ON(pgnr >= map->count);
+	pte_maddr = arbitrary_virt_to_machine(pte).maddr;
+
+	/*
+	 * Set the PTE as special to force get_user_pages_fast() fall
+	 * back to the slow path.  If this is not supported as part of
+	 * the grant map, it will be done afterwards.
+	 */
+	if (xen_feature(XENFEAT_gnttab_map_avail_bits))
+		flags |= (1 << _GNTMAP_guest_avail0);
+
+	gnttab_set_map_op(&map->map_ops[pgnr], pte_maddr, flags,
+			  map->grants[pgnr].ref,
+			  map->grants[pgnr].domid);
+	gnttab_set_unmap_op(&map->unmap_ops[pgnr], pte_maddr, flags,
+			    INVALID_GRANT_HANDLE);
+	return 0;
+}
+
+int gnttab_use_ptemod(struct vm_area_struct *vma, struct gntdev_grant_map *map)
+{
+	return apply_to_page_range(vma->vm_mm, vma->vm_start,
+				   vma->vm_end - vma->vm_start,
+				   find_grant_ptes, map);
+}
+EXPORT_SYMBOL_GPL(gnttab_use_ptemod);
+
 static int __gnttab_init(void)
 {
 	if (!xen_domain())


