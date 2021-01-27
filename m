Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA3F30583D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhA0KWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:22:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235777AbhA0KT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611742707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LeueFFtmc2r/D9kvr3PLBuOowgUJrNaT10Vf8WSqmXE=;
        b=AoxYXZ90w7hy4dnwQbkk3CKWVdH836d7LjLjWUvbj2n0zPpZya0WmrGKCCBrU2dap089R0
        rpXf5Tv8wz7dyF01jfISVwDuN7FG2giQYrCIwtJYK1vTHjsy4a0uH8gwU3kBKAaUjet1pY
        d/P92GwwGq77u/JFMWc88DfM9QgpfBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-msfCqRKCPteJWQSiLSA3uw-1; Wed, 27 Jan 2021 05:18:23 -0500
X-MC-Unique: msfCqRKCPteJWQSiLSA3uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E923A9CDA0;
        Wed, 27 Jan 2021 10:18:21 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E96E86EF55;
        Wed, 27 Jan 2021 10:18:19 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 1/2] mm/cma: expose all pages to the buddy if activation of an area fails
Date:   Wed, 27 Jan 2021 11:18:12 +0100
Message-Id: <20210127101813.6370-2-david@redhat.com>
In-Reply-To: <20210127101813.6370-1-david@redhat.com>
References: <20210127101813.6370-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, if activation fails, we might already have exposed some pages to
the buddy for CMA use (although they will never get actually used by CMA),
and some pages won't be exposed to the buddy at all.

Let's check for "single zone" early and on error, don't expose any pages
for CMA use - instead, expose them to the buddy available for any use.
Simply call free_reserved_page() on every single page - easier than
going via free_reserved_area(), converting back and forth between pfns
and virt addresses.

In addition, make sure to fixup totalcma_pages properly.

Example: 6 GiB QEMU VM with "... hugetlb_cma=2G movablecore=20% ...":
  [    0.006891] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
  [    0.006893] cma: Reserved 2048 MiB at 0x0000000100000000
  [    0.006893] hugetlb_cma: reserved 2048 MiB on node 0
  ...
  [    0.175433] cma: CMA area hugetlb0 could not be activated

Before this patch:
  # cat /proc/meminfo
  MemTotal:        5867348 kB
  MemFree:         5692808 kB
  MemAvailable:    5542516 kB
  ...
  CmaTotal:        2097152 kB
  CmaFree:         1884160 kB

After this patch:
  # cat /proc/meminfo
  MemTotal:        6077308 kB
  MemFree:         5904208 kB
  MemAvailable:    5747968 kB
  ...
  CmaTotal:              0 kB
  CmaFree:               0 kB

Note: cma_init_reserved_mem() makes sure that we always cover full
pageblocks / MAX_ORDER - 1 pages.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/cma.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 0ba69cd16aeb..23d4a97c834a 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -94,34 +94,29 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
 
 static void __init cma_activate_area(struct cma *cma)
 {
-	unsigned long base_pfn = cma->base_pfn, pfn = base_pfn;
-	unsigned i = cma->count >> pageblock_order;
+	unsigned long base_pfn = cma->base_pfn, pfn;
 	struct zone *zone;
 
 	cma->bitmap = bitmap_zalloc(cma_bitmap_maxno(cma), GFP_KERNEL);
 	if (!cma->bitmap)
 		goto out_error;
 
-	WARN_ON_ONCE(!pfn_valid(pfn));
-	zone = page_zone(pfn_to_page(pfn));
-
-	do {
-		unsigned j;
-
-		base_pfn = pfn;
-		for (j = pageblock_nr_pages; j; --j, pfn++) {
-			WARN_ON_ONCE(!pfn_valid(pfn));
-			/*
-			 * alloc_contig_range requires the pfn range
-			 * specified to be in the same zone. Make this
-			 * simple by forcing the entire CMA resv range
-			 * to be in the same zone.
-			 */
-			if (page_zone(pfn_to_page(pfn)) != zone)
-				goto not_in_zone;
-		}
-		init_cma_reserved_pageblock(pfn_to_page(base_pfn));
-	} while (--i);
+	/*
+	 * alloc_contig_range() requires the pfn range specified to be in the
+	 * same zone. Simplify by forcing the entire CMA resv range to be in the
+	 * same zone.
+	 */
+	WARN_ON_ONCE(!pfn_valid(base_pfn));
+	zone = page_zone(pfn_to_page(base_pfn));
+	for (pfn = base_pfn + 1; pfn < base_pfn + cma->count; pfn++) {
+		WARN_ON_ONCE(!pfn_valid(pfn));
+		if (page_zone(pfn_to_page(pfn)) != zone)
+			goto not_in_zone;
+	}
+
+	for (pfn = base_pfn; pfn < base_pfn + cma->count;
+	     pfn += pageblock_nr_pages)
+		init_cma_reserved_pageblock(pfn_to_page(pfn));
 
 	mutex_init(&cma->lock);
 
@@ -135,6 +130,10 @@ static void __init cma_activate_area(struct cma *cma)
 not_in_zone:
 	bitmap_free(cma->bitmap);
 out_error:
+	/* Expose all pages to the buddy, they are useless for CMA. */
+	for (pfn = base_pfn; pfn < base_pfn + cma->count; pfn++)
+		free_reserved_page(pfn_to_page(pfn));
+	totalcma_pages -= cma->count;
 	cma->count = 0;
 	pr_err("CMA area %s could not be activated\n", cma->name);
 	return;
-- 
2.29.2

