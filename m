Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF8636692E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhDUK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:28:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:38094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239292AbhDUK1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:27:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76BEDB2D6;
        Wed, 21 Apr 2021 10:27:10 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v10 6/8] mm,memory_hotplug: Add kernel boot option to enable memmap_on_memory
Date:   Wed, 21 Apr 2021 12:26:59 +0200
Message-Id: <20210421102701.25051-7-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210421102701.25051-1-osalvador@suse.de>
References: <20210421102701.25051-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Self stored memmap leads to a sparse memory situation which is unsuitable
for workloads that requires large contiguous memory chunks, so make this
an opt-in which needs to be explicitly enabled.

To control this, let memory_hotplug have its own memory space, as suggested
by David, so we can add memory_hotplug.memmap_on_memory parameter.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++++++++
 mm/Makefile                                     |  5 ++++-
 mm/memory_hotplug.c                             | 10 +++++++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..af32c17cd4eb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2794,6 +2794,23 @@
 			seconds.  Use this parameter to check at some
 			other rate.  0 disables periodic checking.
 
+	memory_hotplug.memmap_on_memory
+			[KNL,X86,ARM] Boolean flag to enable this feature.
+			Format: {on | off (default)}
+			When enabled, runtime hotplugged memory will
+			allocate its internal metadata (struct pages)
+			from the hotadded memory which will allow to
+			hotadd a lot of memory without requiring
+			additional memory to do so.
+			This feature is disabled by default because it
+			has some implication on large (e.g. GB)
+			allocations in some configurations (e.g. small
+			memory blocks).
+			The state of the flag can be read in
+			/sys/module/memory_hotplug/parameters/memmap_on_memory.
+			Note that even when enabled, there are a few cases where
+			the feature is not effective.
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
index d2de1fab75e2..e39db4321f71 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -42,7 +42,15 @@
 #include "internal.h"
 #include "shuffle.h"
 
-static bool memmap_on_memory;
+
+/*
+ * memory_hotplug.memmap_on_memory parameter
+ */
+static bool memmap_on_memory __ro_after_init;
+#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
+module_param(memmap_on_memory, bool, 0444);
+MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
+#endif
 
 /*
  * online_page_callback contains pointer to current page onlining function.
-- 
2.16.3

