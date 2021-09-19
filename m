Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5E410BBA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhISNOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 09:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhISNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 09:14:20 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A70C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 06:12:55 -0700 (PDT)
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 90110BF2679;
        Sun, 19 Sep 2021 15:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1632057173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPpVuU5fCmV644DkU6MkHhLhsXMVa0d9pBF2o3fXArE=;
        b=NBznNYOGfeEMsYVfUB6a+KLVf8oQjWSQoYbuhEJllkuXNjPclEGcMC3hF6464wAemkqh5r
        DaXaaZHAyyLSQYsc2ubVs15d1r9ktqhRIhnartIX4nR11qDIxJvzK/OjLM99vQJ6yM32Sx
        zTAKNOyHpZYLO/Uu03HB69D1PlZknyo=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [RFC v2 PATCH 2/3] mm: replace custom PG2KB/KB2PG macros with common ones
Date:   Sun, 19 Sep 2021 15:12:47 +0200
Message-Id: <20210919131248.489798-3-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919131248.489798-1-oleksandr@natalenko.name>
References: <20210919131248.489798-1-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 arch/arc/include/asm/arcregs.h       |  4 +-
 arch/powerpc/platforms/pseries/cmm.c | 17 +++---
 arch/s390/appldata/appldata_mem.c    | 19 +++----
 drivers/base/node.c                  | 69 +++++++++++------------
 drivers/scsi/mpt3sas/mpt3sas_base.c  |  5 +-
 drivers/xen/xen-balloon.c            | 11 ++--
 include/trace/events/writeback.h     | 19 +++----
 kernel/debug/kdb/kdb_main.c          |  3 +-
 mm/backing-dev.c                     | 20 +++----
 mm/memcontrol.c                      | 18 +++---
 mm/oom_kill.c                        | 16 +++---
 mm/page_alloc.c                      | 84 ++++++++++++++--------------
 12 files changed, 136 insertions(+), 149 deletions(-)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 2162023195c5..87becc380d6a 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -146,13 +146,13 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/mm.h>
 #include <soc/arc/aux.h>
 
 /* Helpers */
 #define TO_KB(bytes)		((bytes) >> 10)
 #define TO_MB(bytes)		(TO_KB(bytes) >> 10)
-#define PAGES_TO_KB(n_pages)	((n_pages) << (PAGE_SHIFT - 10))
-#define PAGES_TO_MB(n_pages)	(PAGES_TO_KB(n_pages) >> 10)
+#define PAGES_TO_MB(n_pages)	(PG2KB(n_pages) >> 10)
 
 
 /*
diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 45a3a3022a85..c22b9b66b930 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/kthread.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/oom.h>
 #include <linux/reboot.h>
@@ -39,8 +40,6 @@
 #define CMM_DISABLE		0
 #define CMM_OOM_KB		1024
 #define CMM_MIN_MEM_MB		256
-#define KB2PAGES(_p)		((_p)>>(PAGE_SHIFT-10))
-#define PAGES2KB(_p)		((_p)<<(PAGE_SHIFT-10))
 
 #define CMM_MEM_HOTPLUG_PRI	1
 
@@ -215,13 +214,13 @@ static int cmm_oom_notify(struct notifier_block *self,
 			  unsigned long dummy, void *parm)
 {
 	unsigned long *freed = parm;
-	long nr = KB2PAGES(oom_kb);
+	long nr = KB2PG(oom_kb);
 
 	cmm_dbg("OOM processing started\n");
 	nr = cmm_free_pages(nr);
 	loaned_pages_target = atomic_long_read(&loaned_pages);
-	*freed += KB2PAGES(oom_kb) - nr;
-	oom_freed_pages += KB2PAGES(oom_kb) - nr;
+	*freed += KB2PG(oom_kb) - nr;
+	oom_freed_pages += KB2PG(oom_kb) - nr;
 	cmm_dbg("OOM processing complete\n");
 	return NOTIFY_OK;
 }
@@ -251,7 +250,7 @@ static void cmm_get_mpp(void)
 					    PAGE_SIZE);
 		target = page_loan_request + __loaned_pages;
 	} else {
-		target = KB2PAGES(simulate_loan_target_kb);
+		target = KB2PG(simulate_loan_target_kb);
 		page_loan_request = target - __loaned_pages;
 	}
 
@@ -342,13 +341,13 @@ static int cmm_thread(void *dummy)
 	}							\
 	static DEVICE_ATTR(name, 0444, show_##name, NULL)
 
-CMM_SHOW(loaned_kb, "%lu\n", PAGES2KB(atomic_long_read(&loaned_pages)));
-CMM_SHOW(loaned_target_kb, "%lu\n", PAGES2KB(loaned_pages_target));
+CMM_SHOW(loaned_kb, "%lu\n", PG2KB(atomic_long_read(&loaned_pages)));
+CMM_SHOW(loaned_target_kb, "%lu\n", PG2KB(loaned_pages_target));
 
 static ssize_t show_oom_pages(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", PAGES2KB(oom_freed_pages));
+	return sprintf(buf, "%lu\n", PG2KB(oom_freed_pages));
 }
 
 static ssize_t store_oom_pages(struct device *dev,
diff --git a/arch/s390/appldata/appldata_mem.c b/arch/s390/appldata/appldata_mem.c
index 21c3147bd92a..35f02d18d88c 100644
--- a/arch/s390/appldata/appldata_mem.c
+++ b/arch/s390/appldata/appldata_mem.c
@@ -8,6 +8,7 @@
  * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
@@ -20,8 +21,6 @@
 #include "appldata.h"
 
 
-#define P2K(x) ((x) << (PAGE_SHIFT - 10))	/* Converts #Pages to KB */
-
 /*
  * Memory data
  *
@@ -94,17 +93,17 @@ static void appldata_get_mem_data(void *data)
 
 	si_meminfo(&val);
 	mem_data->sharedram = val.sharedram;
-	mem_data->totalram  = P2K(val.totalram);
-	mem_data->freeram   = P2K(val.freeram);
-	mem_data->totalhigh = P2K(val.totalhigh);
-	mem_data->freehigh  = P2K(val.freehigh);
-	mem_data->bufferram = P2K(val.bufferram);
-	mem_data->cached    = P2K(global_node_page_state(NR_FILE_PAGES)
+	mem_data->totalram  = PG2KB(val.totalram);
+	mem_data->freeram   = PG2KB(val.freeram);
+	mem_data->totalhigh = PG2KB(val.totalhigh);
+	mem_data->freehigh  = PG2KB(val.freehigh);
+	mem_data->bufferram = PG2KB(val.bufferram);
+	mem_data->cached    = PG2KB(global_node_page_state(NR_FILE_PAGES)
 				- val.bufferram);
 
 	si_swapinfo(&val);
-	mem_data->totalswap = P2K(val.totalswap);
-	mem_data->freeswap  = P2K(val.freeswap);
+	mem_data->totalswap = PG2KB(val.totalswap);
+	mem_data->freeswap  = PG2KB(val.freeswap);
 
 	mem_data->timestamp = get_tod_clock();
 	mem_data->sync_count_2++;
diff --git a/drivers/base/node.c b/drivers/base/node.c
index c56d34f8158f..fcacb3d58167 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -365,7 +365,6 @@ static void node_init_caches(unsigned int nid) { }
 static void node_remove_caches(struct node *node) { }
 #endif
 
-#define K(x) ((x) << (PAGE_SHIFT - 10))
 static ssize_t node_read_meminfo(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -395,20 +394,20 @@ static ssize_t node_read_meminfo(struct device *dev,
 			    "Node %d Inactive(file): %8lu kB\n"
 			    "Node %d Unevictable:    %8lu kB\n"
 			    "Node %d Mlocked:        %8lu kB\n",
-			    nid, K(i.totalram),
-			    nid, K(i.freeram),
-			    nid, K(i.totalram - i.freeram),
-			    nid, K(swapcached),
-			    nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
+			    nid, PG2KB(i.totalram),
+			    nid, PG2KB(i.freeram),
+			    nid, PG2KB(i.totalram - i.freeram),
+			    nid, PG2KB(swapcached),
+			    nid, PG2KB(node_page_state(pgdat, NR_ACTIVE_ANON) +
 				   node_page_state(pgdat, NR_ACTIVE_FILE)),
-			    nid, K(node_page_state(pgdat, NR_INACTIVE_ANON) +
+			    nid, PG2KB(node_page_state(pgdat, NR_INACTIVE_ANON) +
 				   node_page_state(pgdat, NR_INACTIVE_FILE)),
-			    nid, K(node_page_state(pgdat, NR_ACTIVE_ANON)),
-			    nid, K(node_page_state(pgdat, NR_INACTIVE_ANON)),
-			    nid, K(node_page_state(pgdat, NR_ACTIVE_FILE)),
-			    nid, K(node_page_state(pgdat, NR_INACTIVE_FILE)),
-			    nid, K(node_page_state(pgdat, NR_UNEVICTABLE)),
-			    nid, K(sum_zone_node_page_state(nid, NR_MLOCK)));
+			    nid, PG2KB(node_page_state(pgdat, NR_ACTIVE_ANON)),
+			    nid, PG2KB(node_page_state(pgdat, NR_INACTIVE_ANON)),
+			    nid, PG2KB(node_page_state(pgdat, NR_ACTIVE_FILE)),
+			    nid, PG2KB(node_page_state(pgdat, NR_INACTIVE_FILE)),
+			    nid, PG2KB(node_page_state(pgdat, NR_UNEVICTABLE)),
+			    nid, PG2KB(sum_zone_node_page_state(nid, NR_MLOCK)));
 
 #ifdef CONFIG_HIGHMEM
 	len += sysfs_emit_at(buf, len,
@@ -416,10 +415,10 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d HighFree:       %8lu kB\n"
 			     "Node %d LowTotal:       %8lu kB\n"
 			     "Node %d LowFree:        %8lu kB\n",
-			     nid, K(i.totalhigh),
-			     nid, K(i.freehigh),
-			     nid, K(i.totalram - i.totalhigh),
-			     nid, K(i.freeram - i.freehigh));
+			     nid, PG2KB(i.totalhigh),
+			     nid, PG2KB(i.freehigh),
+			     nid, PG2KB(i.totalram - i.totalhigh),
+			     nid, PG2KB(i.freeram - i.freehigh));
 #endif
 	len += sysfs_emit_at(buf, len,
 			     "Node %d Dirty:          %8lu kB\n"
@@ -448,32 +447,32 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d FilePmdMapped: %8lu kB\n"
 #endif
 			     ,
-			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
-			     nid, K(node_page_state(pgdat, NR_WRITEBACK)),
-			     nid, K(node_page_state(pgdat, NR_FILE_PAGES)),
-			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
-			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
-			     nid, K(i.sharedram),
+			     nid, PG2KB(node_page_state(pgdat, NR_FILE_DIRTY)),
+			     nid, PG2KB(node_page_state(pgdat, NR_WRITEBACK)),
+			     nid, PG2KB(node_page_state(pgdat, NR_FILE_PAGES)),
+			     nid, PG2KB(node_page_state(pgdat, NR_FILE_MAPPED)),
+			     nid, PG2KB(node_page_state(pgdat, NR_ANON_MAPPED)),
+			     nid, PG2KB(i.sharedram),
 			     nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
 #ifdef CONFIG_SHADOW_CALL_STACK
 			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
-			     nid, K(node_page_state(pgdat, NR_PAGETABLE)),
+			     nid, PG2KB(node_page_state(pgdat, NR_PAGETABLE)),
 			     nid, 0UL,
-			     nid, K(sum_zone_node_page_state(nid, NR_BOUNCE)),
-			     nid, K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
-			     nid, K(sreclaimable +
+			     nid, PG2KB(sum_zone_node_page_state(nid, NR_BOUNCE)),
+			     nid, PG2KB(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
+			     nid, PG2KB(sreclaimable +
 				    node_page_state(pgdat, NR_KERNEL_MISC_RECLAIMABLE)),
-			     nid, K(sreclaimable + sunreclaimable),
-			     nid, K(sreclaimable),
-			     nid, K(sunreclaimable)
+			     nid, PG2KB(sreclaimable + sunreclaimable),
+			     nid, PG2KB(sreclaimable),
+			     nid, PG2KB(sunreclaimable)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			     ,
-			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
-			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
-			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
-			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED))
+			     nid, PG2KB(node_page_state(pgdat, NR_ANON_THPS)),
+			     nid, PG2KB(node_page_state(pgdat, NR_SHMEM_THPS)),
+			     nid, PG2KB(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
+			     nid, PG2KB(node_page_state(pgdat, NR_FILE_THPS)),
+			     nid, PG2KB(node_page_state(pgdat, NR_FILE_PMDMAPPED))
 #endif
 			    );
 	len += hugetlb_report_node_meminfo(buf, len, nid);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 27eb652b564f..bb11f31f8431 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -44,6 +44,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -2988,8 +2989,6 @@ _base_build_sg_ieee(struct MPT3SAS_ADAPTER *ioc, void *psge,
 	}
 }
 
-#define convert_to_kb(x) ((x) << (PAGE_SHIFT - 10))
-
 /**
  * _base_config_dma_addressing - set dma addressing
  * @ioc: per adapter object
@@ -3026,7 +3025,7 @@ _base_config_dma_addressing(struct MPT3SAS_ADAPTER *ioc, struct pci_dev *pdev)
 
 	si_meminfo(&s);
 	ioc_info(ioc, "%d BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (%ld kB)\n",
-		ioc->dma_mask, convert_to_kb(s.totalram));
+		ioc->dma_mask, PG2KB(s.totalram));
 
 	return 0;
 }
diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
index 8cd583db20b1..fdd39e5e1a1e 100644
--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -34,6 +34,7 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/mm.h>
 #include <linux/mm_types.h>
 #include <linux/init.h>
 #include <linux/capability.h>
@@ -47,8 +48,6 @@
 #include <xen/page.h>
 #include <xen/mem-reservation.h>
 
-#define PAGES2KB(_p) ((_p)<<(PAGE_SHIFT-10))
-
 #define BALLOON_CLASS_NAME "xen_memory"
 
 #ifdef CONFIG_MEMORY_HOTPLUG
@@ -142,9 +141,9 @@ EXPORT_SYMBOL_GPL(xen_balloon_init);
 	}								\
 	static DEVICE_ATTR_RO(name)
 
-BALLOON_SHOW(current_kb, "%lu\n", PAGES2KB(balloon_stats.current_pages));
-BALLOON_SHOW(low_kb, "%lu\n", PAGES2KB(balloon_stats.balloon_low));
-BALLOON_SHOW(high_kb, "%lu\n", PAGES2KB(balloon_stats.balloon_high));
+BALLOON_SHOW(current_kb, "%lu\n", PG2KB(balloon_stats.current_pages));
+BALLOON_SHOW(low_kb, "%lu\n", PG2KB(balloon_stats.balloon_low));
+BALLOON_SHOW(high_kb, "%lu\n", PG2KB(balloon_stats.balloon_high));
 
 static DEVICE_ULONG_ATTR(schedule_delay, 0444, balloon_stats.schedule_delay);
 static DEVICE_ULONG_ATTR(max_schedule_delay, 0644, balloon_stats.max_schedule_delay);
@@ -155,7 +154,7 @@ static DEVICE_BOOL_ATTR(scrub_pages, 0644, xen_scrub_pages);
 static ssize_t target_kb_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	return sprintf(buf, "%lu\n", PAGES2KB(balloon_stats.target_pages));
+	return sprintf(buf, "%lu\n", PG2KB(balloon_stats.target_pages));
 }
 
 static ssize_t target_kb_store(struct device *dev,
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 7dccb66474f7..3a30e0cb3bee 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_WRITEBACK_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_WRITEBACK_H
 
+#include <linux/mm.h>
 #include <linux/tracepoint.h>
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
@@ -570,8 +571,6 @@ TRACE_EVENT(global_dirty_state,
 	)
 );
 
-#define KBps(x)			((x) << (PAGE_SHIFT - 10))
-
 TRACE_EVENT(bdi_dirty_ratelimit,
 
 	TP_PROTO(struct bdi_writeback *wb,
@@ -593,13 +592,13 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 
 	TP_fast_assign(
 		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
-		__entry->write_bw	= KBps(wb->write_bandwidth);
-		__entry->avg_write_bw	= KBps(wb->avg_write_bandwidth);
-		__entry->dirty_rate	= KBps(dirty_rate);
-		__entry->dirty_ratelimit = KBps(wb->dirty_ratelimit);
-		__entry->task_ratelimit	= KBps(task_ratelimit);
+		__entry->write_bw	= PG2KB(wb->write_bandwidth);
+		__entry->avg_write_bw	= PG2KB(wb->avg_write_bandwidth);
+		__entry->dirty_rate	= PG2KB(dirty_rate);
+		__entry->dirty_ratelimit = PG2KB(wb->dirty_ratelimit);
+		__entry->task_ratelimit	= PG2KB(task_ratelimit);
 		__entry->balanced_dirty_ratelimit =
-					KBps(wb->balanced_dirty_ratelimit);
+					PG2KB(wb->balanced_dirty_ratelimit);
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 	),
 
@@ -666,8 +665,8 @@ TRACE_EVENT(balance_dirty_pages,
 		__entry->bdi_setpoint	= __entry->setpoint *
 						bdi_thresh / (thresh + 1);
 		__entry->bdi_dirty	= bdi_dirty;
-		__entry->dirty_ratelimit = KBps(dirty_ratelimit);
-		__entry->task_ratelimit	= KBps(task_ratelimit);
+		__entry->dirty_ratelimit = PG2KB(dirty_ratelimit);
+		__entry->task_ratelimit	= PG2KB(task_ratelimit);
 		__entry->dirtied	= dirtied;
 		__entry->dirtied_pause	= current->nr_dirtied_pause;
 		__entry->think		= current->dirty_paused_when == 0 ? 0 :
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index fa6deda894a1..b1bbc8f39171 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2522,10 +2522,9 @@ static int kdb_summary(int argc, const char **argv)
 		LOAD_INT(val.loads[2]), LOAD_FRAC(val.loads[2]));
 
 	/* Display in kilobytes */
-#define K(x) ((x) << (PAGE_SHIFT - 10))
 	kdb_printf("\nMemTotal:       %8lu kB\nMemFree:        %8lu kB\n"
 		   "Buffers:        %8lu kB\n",
-		   K(val.totalram), K(val.freeram), K(val.bufferram));
+		   PG2KB(val.totalram), PG2KB(val.freeram), PG2KB(val.bufferram));
 	return 0;
 }
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 4a9d4e27d0d9..b1d9c7bb35b3 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -33,8 +33,6 @@ LIST_HEAD(bdi_list);
 /* bdi_wq serves all asynchronous writeback tasks */
 struct workqueue_struct *bdi_wq;
 
-#define K(x) ((x) << (PAGE_SHIFT - 10))
-
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -87,14 +85,14 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		   "b_dirty_time:       %10lu\n"
 		   "bdi_list:           %10u\n"
 		   "state:              %10lx\n",
-		   (unsigned long) K(wb_stat(wb, WB_WRITEBACK)),
-		   (unsigned long) K(wb_stat(wb, WB_RECLAIMABLE)),
-		   K(wb_thresh),
-		   K(dirty_thresh),
-		   K(background_thresh),
-		   (unsigned long) K(wb_stat(wb, WB_DIRTIED)),
-		   (unsigned long) K(wb_stat(wb, WB_WRITTEN)),
-		   (unsigned long) K(wb->write_bandwidth),
+		   (unsigned long) PG2KB(wb_stat(wb, WB_WRITEBACK)),
+		   (unsigned long) PG2KB(wb_stat(wb, WB_RECLAIMABLE)),
+		   PG2KB(wb_thresh),
+		   PG2KB(dirty_thresh),
+		   PG2KB(background_thresh),
+		   (unsigned long) PG2KB(wb_stat(wb, WB_DIRTIED)),
+		   (unsigned long) PG2KB(wb_stat(wb, WB_WRITTEN)),
+		   (unsigned long) PG2KB(wb->write_bandwidth),
 		   nr_dirty,
 		   nr_io,
 		   nr_more_io,
@@ -157,7 +155,7 @@ static ssize_t name##_show(struct device *dev,				\
 }									\
 static DEVICE_ATTR_RW(name);
 
-BDI_SHOW(read_ahead_kb, K(bdi->ra_pages))
+BDI_SHOW(read_ahead_kb, PG2KB(bdi->ra_pages))
 
 static ssize_t min_ratio_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 47dc4959ead8..5071380c77f0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -53,6 +53,7 @@
 #include <linux/fs.h>
 #include <linux/seq_file.h>
 #include <linux/vmpressure.h>
+#include <linux/mm.h>
 #include <linux/mm_inline.h>
 #include <linux/swap_cgroup.h>
 #include <linux/cpu.h>
@@ -1471,7 +1472,6 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	return s.buffer;
 }
 
-#define K(x) ((x) << (PAGE_SHIFT-10))
 /**
  * mem_cgroup_print_oom_context: Print OOM information relevant to
  * memory controller.
@@ -1507,19 +1507,19 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	char *buf;
 
 	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
-		K((u64)page_counter_read(&memcg->memory)),
-		K((u64)READ_ONCE(memcg->memory.max)), memcg->memory.failcnt);
+		PG2KB((u64)page_counter_read(&memcg->memory)),
+		PG2KB((u64)READ_ONCE(memcg->memory.max)), memcg->memory.failcnt);
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		pr_info("swap: usage %llukB, limit %llukB, failcnt %lu\n",
-			K((u64)page_counter_read(&memcg->swap)),
-			K((u64)READ_ONCE(memcg->swap.max)), memcg->swap.failcnt);
+			PG2KB((u64)page_counter_read(&memcg->swap)),
+			PG2KB((u64)READ_ONCE(memcg->swap.max)), memcg->swap.failcnt);
 	else {
 		pr_info("memory+swap: usage %llukB, limit %llukB, failcnt %lu\n",
-			K((u64)page_counter_read(&memcg->memsw)),
-			K((u64)memcg->memsw.max), memcg->memsw.failcnt);
+			PG2KB((u64)page_counter_read(&memcg->memsw)),
+			PG2KB((u64)memcg->memsw.max), memcg->memsw.failcnt);
 		pr_info("kmem: usage %llukB, limit %llukB, failcnt %lu\n",
-			K((u64)page_counter_read(&memcg->kmem)),
-			K((u64)memcg->kmem.max), memcg->kmem.failcnt);
+			PG2KB((u64)page_counter_read(&memcg->kmem)),
+			PG2KB((u64)memcg->kmem.max), memcg->kmem.failcnt);
 	}
 
 	pr_info("Memory cgroup stats for ");
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 431d38c3bba8..9c7a6ec4b298 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -485,8 +485,6 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_victims_wait);
 
 static bool oom_killer_disabled __read_mostly;
 
-#define K(x) ((x) << (PAGE_SHIFT-10))
-
 /*
  * task->mm can be NULL if the task is the exited group leader.  So to
  * determine whether the task is using a particular mm, we examine all the
@@ -599,9 +597,9 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 
 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 			task_pid_nr(tsk), tsk->comm,
-			K(get_mm_counter(mm, MM_ANONPAGES)),
-			K(get_mm_counter(mm, MM_FILEPAGES)),
-			K(get_mm_counter(mm, MM_SHMEMPAGES)));
+			PG2KB(get_mm_counter(mm, MM_ANONPAGES)),
+			PG2KB(get_mm_counter(mm, MM_FILEPAGES)),
+			PG2KB(get_mm_counter(mm, MM_SHMEMPAGES)));
 out_finish:
 	trace_finish_task_reaping(tsk->pid);
 out_unlock:
@@ -894,10 +892,10 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
 	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
-		message, task_pid_nr(victim), victim->comm, K(mm->total_vm),
-		K(get_mm_counter(mm, MM_ANONPAGES)),
-		K(get_mm_counter(mm, MM_FILEPAGES)),
-		K(get_mm_counter(mm, MM_SHMEMPAGES)),
+		message, task_pid_nr(victim), victim->comm, PG2KB(mm->total_vm),
+		PG2KB(get_mm_counter(mm, MM_ANONPAGES)),
+		PG2KB(get_mm_counter(mm, MM_FILEPAGES)),
+		PG2KB(get_mm_counter(mm, MM_SHMEMPAGES)),
 		from_kuid(&init_user_ns, task_uid(victim)),
 		mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);
 	task_unlock(victim);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b610b05d9b8..5fad2f6d7d5f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5836,8 +5836,6 @@ static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask
 	return !node_isset(nid, *nodemask);
 }
 
-#define K(x) ((x) << (PAGE_SHIFT-10))
-
 static void show_migration_types(unsigned char type)
 {
 	static const char types[MIGRATE_TYPES] = {
@@ -5946,28 +5944,28 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			" all_unreclaimable? %s"
 			"\n",
 			pgdat->node_id,
-			K(node_page_state(pgdat, NR_ACTIVE_ANON)),
-			K(node_page_state(pgdat, NR_INACTIVE_ANON)),
-			K(node_page_state(pgdat, NR_ACTIVE_FILE)),
-			K(node_page_state(pgdat, NR_INACTIVE_FILE)),
-			K(node_page_state(pgdat, NR_UNEVICTABLE)),
-			K(node_page_state(pgdat, NR_ISOLATED_ANON)),
-			K(node_page_state(pgdat, NR_ISOLATED_FILE)),
-			K(node_page_state(pgdat, NR_FILE_MAPPED)),
-			K(node_page_state(pgdat, NR_FILE_DIRTY)),
-			K(node_page_state(pgdat, NR_WRITEBACK)),
-			K(node_page_state(pgdat, NR_SHMEM)),
+			PG2KB(node_page_state(pgdat, NR_ACTIVE_ANON)),
+			PG2KB(node_page_state(pgdat, NR_INACTIVE_ANON)),
+			PG2KB(node_page_state(pgdat, NR_ACTIVE_FILE)),
+			PG2KB(node_page_state(pgdat, NR_INACTIVE_FILE)),
+			PG2KB(node_page_state(pgdat, NR_UNEVICTABLE)),
+			PG2KB(node_page_state(pgdat, NR_ISOLATED_ANON)),
+			PG2KB(node_page_state(pgdat, NR_ISOLATED_FILE)),
+			PG2KB(node_page_state(pgdat, NR_FILE_MAPPED)),
+			PG2KB(node_page_state(pgdat, NR_FILE_DIRTY)),
+			PG2KB(node_page_state(pgdat, NR_WRITEBACK)),
+			PG2KB(node_page_state(pgdat, NR_SHMEM)),
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
-			K(node_page_state(pgdat, NR_ANON_THPS)),
+			PG2KB(node_page_state(pgdat, NR_SHMEM_THPS)),
+			PG2KB(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
+			PG2KB(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
-			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
+			PG2KB(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
 			node_page_state(pgdat, NR_KERNEL_STACK_KB),
 #ifdef CONFIG_SHADOW_CALL_STACK
 			node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
-			K(node_page_state(pgdat, NR_PAGETABLE)),
+			PG2KB(node_page_state(pgdat, NR_PAGETABLE)),
 			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
 				"yes" : "no");
 	}
@@ -6005,24 +6003,24 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			" free_cma:%lukB"
 			"\n",
 			zone->name,
-			K(zone_page_state(zone, NR_FREE_PAGES)),
-			K(min_wmark_pages(zone)),
-			K(low_wmark_pages(zone)),
-			K(high_wmark_pages(zone)),
-			K(zone->nr_reserved_highatomic),
-			K(zone_page_state(zone, NR_ZONE_ACTIVE_ANON)),
-			K(zone_page_state(zone, NR_ZONE_INACTIVE_ANON)),
-			K(zone_page_state(zone, NR_ZONE_ACTIVE_FILE)),
-			K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
-			K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
-			K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
-			K(zone->present_pages),
-			K(zone_managed_pages(zone)),
-			K(zone_page_state(zone, NR_MLOCK)),
-			K(zone_page_state(zone, NR_BOUNCE)),
-			K(free_pcp),
-			K(this_cpu_read(zone->per_cpu_pageset->count)),
-			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
+			PG2KB(zone_page_state(zone, NR_FREE_PAGES)),
+			PG2KB(min_wmark_pages(zone)),
+			PG2KB(low_wmark_pages(zone)),
+			PG2KB(high_wmark_pages(zone)),
+			PG2KB(zone->nr_reserved_highatomic),
+			PG2KB(zone_page_state(zone, NR_ZONE_ACTIVE_ANON)),
+			PG2KB(zone_page_state(zone, NR_ZONE_INACTIVE_ANON)),
+			PG2KB(zone_page_state(zone, NR_ZONE_ACTIVE_FILE)),
+			PG2KB(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
+			PG2KB(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
+			PG2KB(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
+			PG2KB(zone->present_pages),
+			PG2KB(zone_managed_pages(zone)),
+			PG2KB(zone_page_state(zone, NR_MLOCK)),
+			PG2KB(zone_page_state(zone, NR_BOUNCE)),
+			PG2KB(free_pcp),
+			PG2KB(this_cpu_read(zone->per_cpu_pageset->count)),
+			PG2KB(zone_page_state(zone, NR_FREE_CMA_PAGES)));
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
@@ -6056,11 +6054,11 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		spin_unlock_irqrestore(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
 			printk(KERN_CONT "%lu*%lukB ",
-			       nr[order], K(1UL) << order);
+			       nr[order], PG2KB(1UL) << order);
 			if (nr[order])
 				show_migration_types(types[order]);
 		}
-		printk(KERN_CONT "= %lukB\n", K(total));
+		printk(KERN_CONT "= %lukB\n", PG2KB(total));
 	}
 
 	hugetlb_show_meminfo();
@@ -8136,7 +8134,7 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 	}
 
 	if (pages && s)
-		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
+		pr_info("Freeing %s memory: %ldK\n", s, PG2KB(pages));
 
 	return pages;
 }
@@ -8181,13 +8179,13 @@ void __init mem_init_print_info(void)
 		", %luK highmem"
 #endif
 		")\n",
-		K(nr_free_pages()), K(physpages),
+		PG2KB(nr_free_pages()), PG2KB(physpages),
 		codesize >> 10, datasize >> 10, rosize >> 10,
 		(init_data_size + init_code_size) >> 10, bss_size >> 10,
-		K(physpages - totalram_pages() - totalcma_pages),
-		K(totalcma_pages)
+		PG2KB(physpages - totalram_pages() - totalcma_pages),
+		PG2KB(totalcma_pages)
 #ifdef	CONFIG_HIGHMEM
-		, K(totalhigh_pages())
+		, PG2KB(totalhigh_pages())
 #endif
 		);
 }
-- 
2.33.0

