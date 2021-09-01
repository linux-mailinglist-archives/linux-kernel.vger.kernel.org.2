Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C93FD6B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243646AbhIAJWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243630AbhIAJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:22:50 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22330C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 02:21:54 -0700 (PDT)
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 45D77BC74EE;
        Wed,  1 Sep 2021 11:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1630488112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDRnWqhlco5JCW5f1NaLYfAx0MFzj7s9R//s8xX4W5I=;
        b=FIwqGF/5g/BJ5Lr2DHYrL26Zwe9qfLbefLbn2BUOty9/sgNbN98FM+5tTfh4PNLnVOo2Y5
        ETChMzdMNrqWE9thvG6ySsm7tAhbyO0nTDPPN9bLPYsyOr4hvA5993DGBSd27c9OY4fez2
        8ZcApiIM+R6cBOmyhCFdB2HAYhXDSu0=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [RFC PATCH 1/1] mm: provide one common K(x) macro
Date:   Wed,  1 Sep 2021 11:21:49 +0200
Message-Id: <20210901092149.994791-2-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210901092149.994791-1-oleksandr@natalenko.name>
References: <20210901092149.994791-1-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are various places where the K(x) macro is defined. This commit
gets rid of multiple definitions and provides a common one.

This doesn't solve open-coding this macro in various other places. This
should be addressed by another subsequent commit.

Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 drivers/base/node.c                 |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c |  5 ++---
 drivers/xen/xen-balloon.c           | 11 +++++------
 include/linux/mm_tools.h            |  9 +++++++++
 include/trace/events/writeback.h    | 19 +++++++++----------
 kernel/debug/kdb/kdb_main.c         |  2 +-
 mm/backing-dev.c                    |  3 +--
 mm/memcontrol.c                     |  2 +-
 mm/oom_kill.c                       |  3 +--
 mm/page_alloc.c                     |  3 +--
 10 files changed, 31 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/mm_tools.h

diff --git a/drivers/base/node.c b/drivers/base/node.c
index c56d34f8158f..0f6be7750e60 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/mm_tools.h>
 #include <linux/memory.h>
 #include <linux/vmstat.h>
 #include <linux/notifier.h>
@@ -365,7 +366,6 @@ static void node_init_caches(unsigned int nid) { }
 static void node_remove_caches(struct node *node) { }
 #endif
 
-#define K(x) ((x) << (PAGE_SHIFT - 10))
 static ssize_t node_read_meminfo(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 6c82435bc9cc..a822952d8b1a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -61,6 +61,7 @@
 #include <linux/kthread.h>
 #include <asm/page.h>        /* To get host page size per arch */
 #include <linux/aer.h>
+#include <linux/mm_tools.h>
 
 
 #include "mpt3sas_base.h"
@@ -2986,8 +2987,6 @@ _base_build_sg_ieee(struct MPT3SAS_ADAPTER *ioc, void *psge,
 	}
 }
 
-#define convert_to_kb(x) ((x) << (PAGE_SHIFT - 10))
-
 /**
  * _base_config_dma_addressing - set dma addressing
  * @ioc: per adapter object
@@ -3024,7 +3023,7 @@ _base_config_dma_addressing(struct MPT3SAS_ADAPTER *ioc, struct pci_dev *pdev)
 
 	si_meminfo(&s);
 	ioc_info(ioc, "%d BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (%ld kB)\n",
-		ioc->dma_mask, convert_to_kb(s.totalram));
+		ioc->dma_mask, K(s.totalram));
 
 	return 0;
 }
diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
index 8cd583db20b1..d295a6f132f6 100644
--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -34,6 +34,7 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/mm_tools.h>
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
+BALLOON_SHOW(current_kb, "%lu\n", K(balloon_stats.current_pages));
+BALLOON_SHOW(low_kb, "%lu\n", K(balloon_stats.balloon_low));
+BALLOON_SHOW(high_kb, "%lu\n", K(balloon_stats.balloon_high));
 
 static DEVICE_ULONG_ATTR(schedule_delay, 0444, balloon_stats.schedule_delay);
 static DEVICE_ULONG_ATTR(max_schedule_delay, 0644, balloon_stats.max_schedule_delay);
@@ -155,7 +154,7 @@ static DEVICE_BOOL_ATTR(scrub_pages, 0644, xen_scrub_pages);
 static ssize_t target_kb_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	return sprintf(buf, "%lu\n", PAGES2KB(balloon_stats.target_pages));
+	return sprintf(buf, "%lu\n", K(balloon_stats.target_pages));
 }
 
 static ssize_t target_kb_store(struct device *dev,
diff --git a/include/linux/mm_tools.h b/include/linux/mm_tools.h
new file mode 100644
index 000000000000..fcee439bc8db
--- /dev/null
+++ b/include/linux/mm_tools.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_TOOLS_H
+#define _LINUX_MM_TOOLS_H
+
+#include <asm/page.h>
+
+#define K(x)	((x) << (PAGE_SHIFT - 10))
+
+#endif /* _LINUX_MM_TOOLS_H */
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 7dccb66474f7..ee3ccfacc3c1 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -8,6 +8,7 @@
 #include <linux/tracepoint.h>
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
+#include <linux/mm_tools.h>
 
 #define show_inode_state(state)					\
 	__print_flags(state, "|",				\
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
+		__entry->write_bw	= K(wb->write_bandwidth);
+		__entry->avg_write_bw	= K(wb->avg_write_bandwidth);
+		__entry->dirty_rate	= K(dirty_rate);
+		__entry->dirty_ratelimit = K(wb->dirty_ratelimit);
+		__entry->task_ratelimit	= K(task_ratelimit);
 		__entry->balanced_dirty_ratelimit =
-					KBps(wb->balanced_dirty_ratelimit);
+					K(wb->balanced_dirty_ratelimit);
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 	),
 
@@ -666,8 +665,8 @@ TRACE_EVENT(balance_dirty_pages,
 		__entry->bdi_setpoint	= __entry->setpoint *
 						bdi_thresh / (thresh + 1);
 		__entry->bdi_dirty	= bdi_dirty;
-		__entry->dirty_ratelimit = KBps(dirty_ratelimit);
-		__entry->task_ratelimit	= KBps(task_ratelimit);
+		__entry->dirty_ratelimit = K(dirty_ratelimit);
+		__entry->task_ratelimit	= K(task_ratelimit);
 		__entry->dirtied	= dirtied;
 		__entry->dirtied_pause	= current->nr_dirtied_pause;
 		__entry->think		= current->dirty_paused_when == 0 ? 0 :
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index fa6deda894a1..10faf224c55a 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mm.h>
+#include <linux/mm_tools.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
 #include <linux/kgdb.h>
@@ -2522,7 +2523,6 @@ static int kdb_summary(int argc, const char **argv)
 		LOAD_INT(val.loads[2]), LOAD_FRAC(val.loads[2]));
 
 	/* Display in kilobytes */
-#define K(x) ((x) << (PAGE_SHIFT - 10))
 	kdb_printf("\nMemTotal:       %8lu kB\nMemFree:        %8lu kB\n"
 		   "Buffers:        %8lu kB\n",
 		   K(val.totalram), K(val.freeram), K(val.bufferram));
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 4a9d4e27d0d9..0caf624ec99f 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/mm.h>
+#include <linux/mm_tools.h>
 #include <linux/sched/mm.h>
 #include <linux/sched.h>
 #include <linux/module.h>
@@ -33,8 +34,6 @@ LIST_HEAD(bdi_list);
 /* bdi_wq serves all asynchronous writeback tasks */
 struct workqueue_struct *bdi_wq;
 
-#define K(x) ((x) << (PAGE_SHIFT - 10))
-
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 999e626f4111..1164eb3e6d40 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -54,6 +54,7 @@
 #include <linux/seq_file.h>
 #include <linux/vmpressure.h>
 #include <linux/mm_inline.h>
+#include <linux/mm_tools.h>
 #include <linux/swap_cgroup.h>
 #include <linux/cpu.h>
 #include <linux/oom.h>
@@ -1471,7 +1472,6 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	return s.buffer;
 }
 
-#define K(x) ((x) << (PAGE_SHIFT-10))
 /**
  * mem_cgroup_print_oom_context: Print OOM information relevant to
  * memory controller.
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 431d38c3bba8..c1ba2051d3cf 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -20,6 +20,7 @@
 
 #include <linux/oom.h>
 #include <linux/mm.h>
+#include <linux/mm_tools.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
@@ -485,8 +486,6 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_victims_wait);
 
 static bool oom_killer_disabled __read_mostly;
 
-#define K(x) ((x) << (PAGE_SHIFT-10))
-
 /*
  * task->mm can be NULL if the task is the exited group leader.  So to
  * determine whether the task is using a particular mm, we examine all the
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91edb930b8ab..9cca67008ed8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -17,6 +17,7 @@
 
 #include <linux/stddef.h>
 #include <linux/mm.h>
+#include <linux/mm_tools.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
 #include <linux/interrupt.h>
@@ -5840,8 +5841,6 @@ static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask
 	return !node_isset(nid, *nodemask);
 }
 
-#define K(x) ((x) << (PAGE_SHIFT-10))
-
 static void show_migration_types(unsigned char type)
 {
 	static const char types[MIGRATE_TYPES] = {
-- 
2.33.0

