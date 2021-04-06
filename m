Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DA35519A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245373AbhDFLLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:11:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:49670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234057AbhDFLLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:11:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38D8CB154;
        Tue,  6 Apr 2021 11:11:26 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 2/8] mm,memory_hotplug: Relax fully spanned sections check
Date:   Tue,  6 Apr 2021 13:11:09 +0200
Message-Id: <20210406111115.8953-3-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210406111115.8953-1-osalvador@suse.de>
References: <20210406111115.8953-1-osalvador@suse.de>
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
---
 mm/memory_hotplug.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0cdbbfbc5757..5fe3e3942b19 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -838,9 +838,13 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
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
+			 !IS_ALIGNED(pfn | nr_pages, pageblock_nr_pages)))
 		return -EINVAL;
 
 	mem_hotplug_begin();
@@ -1573,9 +1577,13 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
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
+			 !IS_ALIGNED(start_pfn | nr_pages, pageblock_nr_pages)))
 		return -EINVAL;
 
 	mem_hotplug_begin();
-- 
2.16.3

