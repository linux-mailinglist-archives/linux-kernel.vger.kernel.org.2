Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F81366928
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbhDUK1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:27:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:38072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238557AbhDUK1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:27:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08DF5AF0C;
        Wed, 21 Apr 2021 10:27:07 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v10 2/8] mm,memory_hotplug: Relax fully spanned sections check
Date:   Wed, 21 Apr 2021 12:26:55 +0200
Message-Id: <20210421102701.25051-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210421102701.25051-1-osalvador@suse.de>
References: <20210421102701.25051-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want {online,offline}_pages to operate on whole memblocks, but
memmap_on_memory will poke pageblock_nr_pages aligned holes in the
beginning, which is a special case we want to allow.
Relax the check to account for that case.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0cdbbfbc5757..e6aafd17a01a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -838,9 +838,16 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	int ret;
 	struct memory_notify arg;
 
-	/* We can only online full sections (e.g., SECTION_IS_ONLINE) */
+	/*
+	 * {on,off}lining is constrained to full memory sections (or more
+	 * precisly to memory blocks from the user space POV).
+	 * memmap_on_memory is an exception because it reserves initial part
+	 * of the physical memory space for vmemmaps. That space is pageblock
+	 * aligned.
+	 */
 	if (WARN_ON_ONCE(!nr_pages ||
-			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
+			 !IS_ALIGNED(pfn, pageblock_nr_pages) ||
+			 !IS_ALIGNED(pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
 	mem_hotplug_begin();
@@ -1573,9 +1580,16 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	int ret, node;
 	char *reason;
 
-	/* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
+	/*
+	 * {on,off}lining is constrained to full memory sections (or more
+	 * precisly to memory blocks from the user space POV).
+	 * memmap_on_memory is an exception because it reserves initial part
+	 * of the physical memory space for vmemmaps. That space is pageblock
+	 * aligned.
+	 */
 	if (WARN_ON_ONCE(!nr_pages ||
-			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
+			 !IS_ALIGNED(start_pfn, pageblock_nr_pages) ||
+			 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
 	mem_hotplug_begin();
-- 
2.16.3

