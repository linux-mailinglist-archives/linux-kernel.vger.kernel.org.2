Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DD032D04E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbhCDKBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:01:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:54782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238107AbhCDKAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:00:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A5ABAD74;
        Thu,  4 Mar 2021 10:00:10 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 3/5] mm,memory_hotplug: Add kernel boot option to enable memmap_on_memory
Date:   Thu,  4 Mar 2021 11:00:00 +0100
Message-Id: <20210304100002.7740-4-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210304100002.7740-1-osalvador@suse.de>
References: <20210304100002.7740-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Self stored memmap leads to a sparse memory situation which is unsuitable
for workloads that requires large contiguous memory chunks, so make this
an opt-in which needs to be explicitly enabled.

To control this, let memory_hotplug have its own memory space, as suggested
by David, so we can add memory_hotplug.memmap_on_memory parameter.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
 mm/Makefile                                     |  5 ++++-
 mm/memory_hotplug.c                             |  8 +++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..e626dab39c60 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2794,6 +2794,20 @@
 			seconds.  Use this parameter to check at some
 			other rate.  0 disables periodic checking.
 
+	memory_hotplug.memmap_on_memory
+			[KNL,X86,ARM] Boolean flag to enable this feature.
+			Format: {on | off (default)}
+			When enabled, memory to build the pages tables for the
+			memmap array describing the hot-added range will be taken
+			from the range itself, so the memmap page tables will be
+			self-hosted.
+			Since only single memory device ranges are supported at
+			the moment, this option is disabled by default because
+			it might have an impact on workloads that needs large
+			contiguous memory chunks.
+			The state of the flag can be read in
+			/sys/module/memory_hotplug/parameters/memmap_on_memory.
+
 	memtest=	[KNL,X86,ARM,PPC] Enable memtest
 			Format: <integer>
 			default : 0 <disable>
diff --git a/mm/Makefile b/mm/Makefile
index 72227b24a616..82ae9482f5e3 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -58,9 +58,13 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 page-alloc-y := page_alloc.o
 page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
 
+# Give 'memory_hotplug' its own module-parameter namespace
+memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
+
 obj-y += page-alloc.o
 obj-y += init-mm.o
 obj-y += memblock.o
+obj-y += $(memory-hotplug-y)
 
 ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
@@ -83,7 +87,6 @@ obj-$(CONFIG_SLUB) += slub.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_FAILSLAB) += failslab.o
-obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 63e5a0e9a6f3..94b0ec3d2ff2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -42,7 +42,13 @@
 #include "internal.h"
 #include "shuffle.h"
 
-static bool memmap_on_memory;
+
+/*
+ * memory_hotplug.memmap_on_memory parameter
+ */
+static bool memmap_on_memory __ro_after_init;
+module_param(memmap_on_memory, bool, 0444);
+MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
 
 /*
  * online_page_callback contains pointer to current page onlining function.
-- 
2.16.3

