Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9500B36830D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbhDVPK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:10:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:52052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236586AbhDVPKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:10:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619104211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTxz0RbWnUOZh4apGxwrsu84odP0er4fykNXzBAMpag=;
        b=OX0bucQn5aKzgc3RTioNoOR5BErPdayoju9pA5S5pCYLyODdOwrADpSziKmUf+9lpeLHq/
        9Mf3LUt3Pz6e3HoQaDoc3vmW9oI3MwNlLswg5N8qCQBao4KAVZC3OEBWO7GVTKg5IwH9Ia
        GF/vmkAWug36+NLP+GZgc6yX11cDe8o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63C6EB174;
        Thu, 22 Apr 2021 15:10:11 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/3] xen: assume XENFEAT_gnttab_map_avail_bits being set for pv guests
Date:   Thu, 22 Apr 2021 17:10:07 +0200
Message-Id: <20210422151007.2205-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210422151007.2205-1-jgross@suse.com>
References: <20210422151007.2205-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XENFEAT_gnttab_map_avail_bits is always set in Xen 4.0 and newer.
Remove coding assuming it might be zero.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/gntdev.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index f01d58c7a042..93818816e137 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -266,20 +266,13 @@ static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
 {
 	struct gntdev_grant_map *map = data;
 	unsigned int pgnr = (addr - map->vma->vm_start) >> PAGE_SHIFT;
-	int flags = map->flags | GNTMAP_application_map | GNTMAP_contains_pte;
+	int flags = map->flags | GNTMAP_application_map | GNTMAP_contains_pte |
+		    (1 << _GNTMAP_guest_avail0);
 	u64 pte_maddr;
 
 	BUG_ON(pgnr >= map->count);
 	pte_maddr = arbitrary_virt_to_machine(pte).maddr;
 
-	/*
-	 * Set the PTE as special to force get_user_pages_fast() fall
-	 * back to the slow path.  If this is not supported as part of
-	 * the grant map, it will be done afterwards.
-	 */
-	if (xen_feature(XENFEAT_gnttab_map_avail_bits))
-		flags |= (1 << _GNTMAP_guest_avail0);
-
 	gnttab_set_map_op(&map->map_ops[pgnr], pte_maddr, flags,
 			  map->grants[pgnr].ref,
 			  map->grants[pgnr].domid);
@@ -288,14 +281,6 @@ static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
 	return 0;
 }
 
-#ifdef CONFIG_X86
-static int set_grant_ptes_as_special(pte_t *pte, unsigned long addr, void *data)
-{
-	set_pte_at(current->mm, addr, pte, pte_mkspecial(*pte));
-	return 0;
-}
-#endif
-
 int gntdev_map_grant_pages(struct gntdev_grant_map *map)
 {
 	int i, err = 0;
@@ -1053,23 +1038,6 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		err = vm_map_pages_zero(vma, map->pages, map->count);
 		if (err)
 			goto out_put_map;
-	} else {
-#ifdef CONFIG_X86
-		/*
-		 * If the PTEs were not made special by the grant map
-		 * hypercall, do so here.
-		 *
-		 * This is racy since the mapping is already visible
-		 * to userspace but userspace should be well-behaved
-		 * enough to not touch it until the mmap() call
-		 * returns.
-		 */
-		if (!xen_feature(XENFEAT_gnttab_map_avail_bits)) {
-			apply_to_page_range(vma->vm_mm, vma->vm_start,
-					    vma->vm_end - vma->vm_start,
-					    set_grant_ptes_as_special, NULL);
-		}
-#endif
 	}
 
 	return 0;
-- 
2.26.2

