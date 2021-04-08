Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771B2358319
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhDHMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:18:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:39390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhDHMS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:18:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4130B007;
        Thu,  8 Apr 2021 12:18:17 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 2/8] mm,memory_hotplug: Relax fully spanned sections check
Date:   Thu,  8 Apr 2021 14:17:58 +0200
Message-Id: <20210408121804.10440-3-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210408121804.10440-1-osalvador@suse.de>
References: <20210408121804.10440-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using self-hosted vmemmap pages, the number of pages passed to
{online,offline}_pages might not fully span sections, but they always
fully span pageblocks.
Relax the check account for that case.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0cdbbfbc5757..25e59d5dc13c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -838,9 +838,14 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	int ret;
 	struct memory_notify arg;
 
-	/* We can only online full sections (e.g., SECTION_IS_ONLINE) */
+	/* We can only offline full sections (e.g., SECTION_IS_ONLINE).
+	 * However, when using e.g: memmap_on_memory, some pages are initialized
+	 * prior to calling in here. The remaining amount of pages must be
+	 * pageblock aligned.
+	 */
 	if (WARN_ON_ONCE(!nr_pages ||
-			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
+			 !IS_ALIGNED(pfn, pageblock_nr_pages) ||
+			 !IS_ALIGNED(pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
 	mem_hotplug_begin();
@@ -1573,9 +1578,14 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	int ret, node;
 	char *reason;
 
-	/* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
+	/* We can only offline full sections (e.g., SECTION_IS_ONLINE).
+	 * However, when using e.g: memmap_on_memory, some pages are initialized
+	 * prior to calling in here. The remaining amount of pages must be
+	 * pageblock aligned.
+	 */
 	if (WARN_ON_ONCE(!nr_pages ||
-			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
+			 !IS_ALIGNED(start_pfn, pageblock_nr_pages) ||
+			 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
 	mem_hotplug_begin();
-- 
2.16.3

