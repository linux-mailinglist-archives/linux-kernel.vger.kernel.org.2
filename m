Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965AC410BBB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhISNOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 09:14:25 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:40808 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhISNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 09:14:21 -0400
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 55A04BF267A;
        Sun, 19 Sep 2021 15:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1632057175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JYM3KfiWeSzI7eoDo2aZrdpeP/6OQZltMkiX40VCFQ=;
        b=Ho+orZ5Qc+X1k+YQbvS5p9l8XslDb2yCrSDm07UHpKR1TmGSoFhivmOPm+8i/1/GjanfOB
        29BjPLXXim6R5D0PFCcNKS8Xl5k8C825/5A9eODK/eFDdmP5+89p498m1fq/FMy4a4niGO
        IzjCsKFRGiLsY4K/9h6/NDt5ddsdjUI=
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
Subject: [RFC v2 PATCH 3/3] mm: replace open-coded PG2KB/KB2PG variants with macros
Date:   Sun, 19 Sep 2021 15:12:48 +0200
Message-Id: <20210919131248.489798-4-oleksandr@natalenko.name>
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
 arch/alpha/kernel/setup.c                     |  3 +--
 arch/mips/mm/init.c                           |  2 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c            | 17 +++++++++--------
 block/blk-sysfs.c                             |  9 +++++----
 drivers/gpu/drm/v3d/v3d_debugfs.c             |  3 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |  5 +++--
 drivers/md/md-bitmap.c                        |  4 ++--
 fs/ceph/addr.c                                |  2 +-
 fs/ceph/super.h                               |  3 ++-
 fs/fs-writeback.c                             |  2 +-
 fs/nfs/write.c                                |  4 ++--
 fs/nfsd/nfscache.c                            |  3 ++-
 fs/proc/meminfo.c                             |  4 ++--
 fs/proc/task_mmu.c                            |  3 ++-
 kernel/events/core.c                          |  2 +-
 kernel/fork.c                                 |  2 +-
 mm/backing-dev.c                              |  2 +-
 mm/hugetlb.c                                  |  2 +-
 mm/mmap.c                                     |  6 +++---
 mm/nommu.c                                    |  4 ++--
 mm/page-writeback.c                           |  4 ++--
 mm/page_alloc.c                               |  2 +-
 mm/shmem.c                                    |  3 +--
 mm/swap_state.c                               |  5 ++---
 mm/swapfile.c                                 | 11 +++++------
 mm/util.c                                     |  6 +++---
 26 files changed, 58 insertions(+), 55 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index b4fbbba30aa2..c4282224c950 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -355,8 +355,7 @@ setup_memory(void *kernel_end)
 	if (mem_size_limit && max_low_pfn >= mem_size_limit)
 	{
 		printk("setup: forcing memory size to %ldK (from %ldK).\n",
-		       mem_size_limit << (PAGE_SHIFT - 10),
-		       max_low_pfn    << (PAGE_SHIFT - 10));
+		       PG2KB(mem_size_limit), PG2KB(max_low_pfn));
 		max_low_pfn = mem_size_limit;
 	}
 
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 19347dc6bbf8..351a44437377 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -414,7 +414,7 @@ void __init paging_init(void)
 	if (cpu_has_dc_aliases && max_low_pfn != highend_pfn) {
 		printk(KERN_WARNING "This processor doesn't support highmem."
 		       " %ldk highmem ignored\n",
-		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
+		       PG2KB(highend_pfn - max_low_pfn));
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
 	}
 #endif
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index b5f43049fa5f..327aef0ff945 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -18,6 +18,7 @@
  * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
@@ -204,8 +205,8 @@ static void __init
 save_var_mtrr(unsigned int reg, unsigned long basek, unsigned long sizek,
 	      unsigned char type)
 {
-	range_state[reg].base_pfn = basek >> (PAGE_SHIFT - 10);
-	range_state[reg].size_pfn = sizek >> (PAGE_SHIFT - 10);
+	range_state[reg].base_pfn = KB2PG(basek);
+	range_state[reg].size_pfn = KB2PG(sizek);
 	range_state[reg].type = type;
 }
 
@@ -216,8 +217,8 @@ static void __init set_var_mtrr_all(unsigned int address_bits)
 	unsigned int reg;
 
 	for (reg = 0; reg < num_var_ranges; reg++) {
-		basek = range_state[reg].base_pfn << (PAGE_SHIFT - 10);
-		sizek = range_state[reg].size_pfn << (PAGE_SHIFT - 10);
+		basek = PG2KB(range_state[reg].base_pfn);
+		sizek = PG2KB(range_state[reg].size_pfn);
 		type = range_state[reg].type;
 
 		set_var_mtrr(reg, basek, sizek, type, address_bits);
@@ -415,8 +416,8 @@ set_var_mtrr_range(struct var_mtrr_state *state, unsigned long base_pfn,
 	if (state->reg >= num_var_ranges)
 		return;
 
-	basek = base_pfn << (PAGE_SHIFT - 10);
-	sizek = size_pfn << (PAGE_SHIFT - 10);
+	basek = PG2KB(base_pfn);
+	sizek = PG2KB(size_pfn);
 
 	/* See if I can merge with the last range: */
 	if ((basek <= 1024) ||
@@ -533,12 +534,12 @@ static void __init print_out_mtrr_range_state(void)
 
 	for (i = 0; i < num_var_ranges; i++) {
 
-		size_base = range_state[i].size_pfn << (PAGE_SHIFT - 10);
+		size_base = PG2KB(range_state[i].size_pfn);
 		if (!size_base)
 			continue;
 
 		size_base = to_size_factor(size_base, &size_factor);
-		start_base = range_state[i].base_pfn << (PAGE_SHIFT - 10);
+		start_base = PG2KB(range_state[i].base_pfn);
 		start_base = to_size_factor(start_base, &start_factor);
 		type = range_state[i].type;
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 614d9d47de36..25e0bcc1208f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -4,6 +4,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
@@ -92,7 +93,7 @@ static ssize_t queue_ra_show(struct request_queue *q, char *page)
 
 	if (!q->disk)
 		return -EINVAL;
-	ra_kb = q->disk->bdi->ra_pages << (PAGE_SHIFT - 10);
+	ra_kb = PG2KB(q->disk->bdi->ra_pages);
 	return queue_var_show(ra_kb, page);
 }
 
@@ -107,7 +108,7 @@ queue_ra_store(struct request_queue *q, const char *page, size_t count)
 	ret = queue_var_store(&ra_kb, page, count);
 	if (ret < 0)
 		return ret;
-	q->disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
+	q->disk->bdi->ra_pages = KB2PG(ra_kb);
 	return ret;
 }
 
@@ -240,7 +241,7 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 {
 	unsigned long max_sectors_kb,
 		max_hw_sectors_kb = queue_max_hw_sectors(q) >> 1,
-			page_kb = 1 << (PAGE_SHIFT - 10);
+			page_kb = PG2KB(1);
 	ssize_t ret = queue_var_store(&max_sectors_kb, page, count);
 
 	if (ret < 0)
@@ -255,7 +256,7 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 	spin_lock_irq(&q->queue_lock);
 	q->limits.max_sectors = max_sectors_kb << 1;
 	if (q->disk)
-		q->disk->bdi->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
+		q->disk->bdi->io_pages = KB2PG(max_sectors_kb);
 	spin_unlock_irq(&q->queue_lock);
 
 	return ret;
diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index e76b24bb8828..29461f9056b3 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -4,6 +4,7 @@
 #include <linux/circ_buf.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
+#include <linux/mm.h>
 #include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 
@@ -203,7 +204,7 @@ static int v3d_debugfs_bo_stats(struct seq_file *m, void *unused)
 	seq_printf(m, "allocated bos:          %d\n",
 		   v3d->bo_stats.num_allocated);
 	seq_printf(m, "allocated bo size (kb): %ld\n",
-		   (long)v3d->bo_stats.pages_allocated << (PAGE_SHIFT - 10));
+		   PG2KB((long)v3d->bo_stats.pages_allocated));
 	mutex_unlock(&v3d->bo_lock);
 
 	return 0;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
index b2c4af331c9d..1083a054d235 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
@@ -32,6 +32,7 @@
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
 #include <linux/idr.h>
+#include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
 
@@ -92,14 +93,14 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_manager *man,
 				new_max_pages = gman->max_gmr_pages * 2;
 			if (new_max_pages > gman->max_gmr_pages && new_max_pages >= gman->used_gmr_pages) {
 				DRM_WARN("vmwgfx: increasing guest mob limits to %u kB.\n",
-					 ((new_max_pages) << (PAGE_SHIFT - 10)));
+					 PG2KB(new_max_pages));
 
 				gman->max_gmr_pages = new_max_pages;
 			} else {
 				char buf[256];
 				snprintf(buf, sizeof(buf),
 					 "vmwgfx, error: guest graphics is out of memory (mob limit at: %ukB).\n",
-					 ((gman->max_gmr_pages) << (PAGE_SHIFT - 10)));
+					 PG2KB(gman->max_gmr_pages));
 				vmw_host_printf(buf);
 				DRM_WARN("%s", buf);
 				goto nospace;
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index e29c6298ef5c..85277df1da5a 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -2038,8 +2039,7 @@ void md_bitmap_status(struct seq_file *seq, struct bitmap *bitmap)
 		   "%lu%s chunk",
 		   counts->pages - counts->missing_pages,
 		   counts->pages,
-		   (counts->pages - counts->missing_pages)
-		   << (PAGE_SHIFT - 10),
+		   PG2KB(counts->pages - counts->missing_pages),
 		   chunk_kb ? chunk_kb : bitmap->mddev->bitmap_info.chunksize,
 		   chunk_kb ? "KB" : "B");
 	if (bitmap->storage.file) {
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 99b80b5c7a93..e9d296cffb83 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -57,7 +57,7 @@
  * accounting is preserved.
  */
 
-#define CONGESTION_ON_THRESH(congestion_kb) (congestion_kb >> (PAGE_SHIFT-10))
+#define CONGESTION_ON_THRESH(congestion_kb) KB2PG(congestion_kb)
 #define CONGESTION_OFF_THRESH(congestion_kb)				\
 	(CONGESTION_ON_THRESH(congestion_kb) -				\
 	 (CONGESTION_ON_THRESH(congestion_kb) >> 2))
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a40eb14c282a..328d40843dbc 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -9,6 +9,7 @@
 #include <linux/completion.h>
 #include <linux/exportfs.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/mempool.h>
 #include <linux/pagemap.h>
 #include <linux/wait.h>
@@ -908,7 +909,7 @@ static inline int default_congestion_kb(void)
 	 * This allows larger machines to have larger/more transfers.
 	 * Limit the default to 256M
 	 */
-	congestion_kb = (16*int_sqrt(totalram_pages())) << (PAGE_SHIFT-10);
+	congestion_kb = PG2KB(16*int_sqrt(totalram_pages()));
 	if (congestion_kb > 256*1024)
 		congestion_kb = 256*1024;
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 81ec192ce067..1b694e6a27c0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -34,7 +34,7 @@
 /*
  * 4MB minimal write chunk size
  */
-#define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
+#define MIN_WRITEBACK_PAGES	KB2PG(4096UL)
 
 /*
  * Passed into wb_writeback(), essentially a subset of writeback_control
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index eae9bf114041..9b565808c12f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -401,7 +401,7 @@ static int wb_priority(struct writeback_control *wbc)
 
 int nfs_congestion_kb;
 
-#define NFS_CONGESTION_ON_THRESH 	(nfs_congestion_kb >> (PAGE_SHIFT-10))
+#define NFS_CONGESTION_ON_THRESH 	KB2PG(nfs_congestion_kb)
 #define NFS_CONGESTION_OFF_THRESH	\
 	(NFS_CONGESTION_ON_THRESH - (NFS_CONGESTION_ON_THRESH >> 2))
 
@@ -2173,7 +2173,7 @@ int __init nfs_init_writepagecache(void)
 	 * This allows larger machines to have larger/more transfers.
 	 * Limit the default to 256M
 	 */
-	nfs_congestion_kb = (16*int_sqrt(totalram_pages())) << (PAGE_SHIFT-10);
+	nfs_congestion_kb = PG2KB(16*int_sqrt(totalram_pages()));
 	if (nfs_congestion_kb > 256*1024)
 		nfs_congestion_kb = 256*1024;
 
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 96cdf77925f3..aeb464f88fa7 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -9,6 +9,7 @@
  * Copyright (C) 1995, 1996 Olaf Kirch <okir@monad.swb.de>
  */
 
+#include <linux/mm.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -70,7 +71,7 @@ nfsd_cache_size_limit(void)
 	unsigned int limit;
 	unsigned long low_pages = totalram_pages() - totalhigh_pages();
 
-	limit = (16 * int_sqrt(low_pages)) << (PAGE_SHIFT-10);
+	limit = PG2KB(16 * int_sqrt(low_pages));
 	return min_t(unsigned int, limit, 256*1024);
 }
 
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6fa761c9cc78..5443be3060a8 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -25,7 +25,7 @@ void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
 
 static void show_val_kb(struct seq_file *m, const char *s, unsigned long num)
 {
-	seq_put_decimal_ull_width(m, s, num << (PAGE_SHIFT - 10), 8);
+	seq_put_decimal_ull_width(m, s, PG2KB(num), 8);
 	seq_write(m, " kB\n", 4);
 }
 
@@ -124,7 +124,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_MEMORY_FAILURE
 	seq_printf(m, "HardwareCorrupted: %5lu kB\n",
-		   atomic_long_read(&num_poisoned_pages) << (PAGE_SHIFT - 10));
+		   PG2KB(atomic_long_read(&num_poisoned_pages)));
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cf25be3e0321..11798f84292c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3,6 +3,7 @@
 #include <linux/vmacache.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
+#include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/highmem.h>
@@ -26,7 +27,7 @@
 #include "internal.h"
 
 #define SEQ_PUT_DEC(str, val) \
-		seq_put_decimal_ull_width(m, str, (val) << (PAGE_SHIFT-10), 8)
+		seq_put_decimal_ull_width(m, str, PG2KB(val), 8)
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
 	unsigned long text, lib, swap, anon, file, shmem;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 349f80aa9e7d..ee290e405d00 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6267,7 +6267,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	user_extra = nr_pages + 1;
 
 accounting:
-	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
+	user_lock_limit = KB2PG(sysctl_perf_event_mlock);
 
 	/*
 	 * Increase the limit linearly with more CPUs:
diff --git a/kernel/fork.c b/kernel/fork.c
index 723125f2cbed..04302967685f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2325,7 +2325,7 @@ static __latent_entropy struct task_struct *copy_process(
 	}
 
 	p->nr_dirtied = 0;
-	p->nr_dirtied_pause = 128 >> (PAGE_SHIFT - 10);
+	p->nr_dirtied_pause = KB2PG(128);
 	p->dirty_paused_when = 0;
 
 	p->pdeath_signal = 0;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index b1d9c7bb35b3..c0820114e1dd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -140,7 +140,7 @@ static ssize_t read_ahead_kb_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	bdi->ra_pages = read_ahead_kb >> (PAGE_SHIFT - 10);
+	bdi->ra_pages = KB2PG(read_ahead_kb);
 
 	return count;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6378c1066459..f496cef8abef 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4050,7 +4050,7 @@ void hugetlb_show_meminfo(void)
 void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm)
 {
 	seq_printf(m, "HugetlbPages:\t%8lu kB\n",
-		   atomic_long_read(&mm->hugetlb_usage) << (PAGE_SHIFT - 10));
+		   PG2KB(atomic_long_read(&mm->hugetlb_usage)));
 }
 
 /* Return the number pages of memory we physically have, in PAGE_SIZE units. */
diff --git a/mm/mmap.c b/mm/mmap.c
index b22a07f5e761..95c4883d2a87 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3703,7 +3703,7 @@ static int init_user_reserve(void)
 {
 	unsigned long free_kbytes;
 
-	free_kbytes = global_zone_page_state(NR_FREE_PAGES) << (PAGE_SHIFT - 10);
+	free_kbytes = PG2KB(global_zone_page_state(NR_FREE_PAGES));
 
 	sysctl_user_reserve_kbytes = min(free_kbytes / 32, 1UL << 17);
 	return 0;
@@ -3724,7 +3724,7 @@ static int init_admin_reserve(void)
 {
 	unsigned long free_kbytes;
 
-	free_kbytes = global_zone_page_state(NR_FREE_PAGES) << (PAGE_SHIFT - 10);
+	free_kbytes = PG2KB(global_zone_page_state(NR_FREE_PAGES));
 
 	sysctl_admin_reserve_kbytes = min(free_kbytes / 32, 1UL << 13);
 	return 0;
@@ -3768,7 +3768,7 @@ static int reserve_mem_notifier(struct notifier_block *nb,
 
 		break;
 	case MEM_OFFLINE:
-		free_kbytes = global_zone_page_state(NR_FREE_PAGES) << (PAGE_SHIFT - 10);
+		free_kbytes = PG2KB(global_zone_page_state(NR_FREE_PAGES));
 
 		if (sysctl_user_reserve_kbytes > free_kbytes) {
 			init_user_reserve();
diff --git a/mm/nommu.c b/mm/nommu.c
index 8943dc0e2132..783526838176 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1803,7 +1803,7 @@ static int __meminit init_user_reserve(void)
 {
 	unsigned long free_kbytes;
 
-	free_kbytes = global_zone_page_state(NR_FREE_PAGES) << (PAGE_SHIFT - 10);
+	free_kbytes = PG2KB(global_zone_page_state(NR_FREE_PAGES));
 
 	sysctl_user_reserve_kbytes = min(free_kbytes / 32, 1UL << 17);
 	return 0;
@@ -1824,7 +1824,7 @@ static int __meminit init_admin_reserve(void)
 {
 	unsigned long free_kbytes;
 
-	free_kbytes = global_zone_page_state(NR_FREE_PAGES) << (PAGE_SHIFT - 10);
+	free_kbytes = PG2KB(global_zone_page_state(NR_FREE_PAGES));
 
 	sysctl_admin_reserve_kbytes = min(free_kbytes / 32, 1UL << 13);
 	return 0;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 9c64490171e0..1e3ab56ded46 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -50,7 +50,7 @@
  * Try to keep balance_dirty_pages() call intervals higher than this many pages
  * by raising pause time to max_pause when falls below it.
  */
-#define DIRTY_POLL_THRESH	(128 >> (PAGE_SHIFT - 10))
+#define DIRTY_POLL_THRESH	KB2PG(128)
 
 /*
  * Estimate write bandwidth at 200ms intervals.
@@ -1893,7 +1893,7 @@ void balance_dirty_pages_ratelimited(struct address_space *mapping)
 
 	ratelimit = current->nr_dirtied_pause;
 	if (wb->dirty_exceeded)
-		ratelimit = min(ratelimit, 32 >> (PAGE_SHIFT - 10));
+		ratelimit = min(ratelimit, KB2PG(32));
 
 	preempt_disable();
 	/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5fad2f6d7d5f..8617559ca211 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8350,7 +8350,7 @@ static void setup_per_zone_lowmem_reserve(void)
 
 static void __setup_per_zone_wmarks(void)
 {
-	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
+	unsigned long pages_min = KB2PG(min_free_kbytes);
 	unsigned long lowmem_pages = 0;
 	struct zone *zone;
 	unsigned long flags;
diff --git a/mm/shmem.c b/mm/shmem.c
index 6f975d4e08f4..95a9e0e81779 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3565,8 +3565,7 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	struct shmem_sb_info *sbinfo = SHMEM_SB(root->d_sb);
 
 	if (sbinfo->max_blocks != shmem_default_max_blocks())
-		seq_printf(seq, ",size=%luk",
-			sbinfo->max_blocks << (PAGE_SHIFT - 10));
+		seq_printf(seq, ",size=%luk", PG2KB(sbinfo->max_blocks));
 	if (sbinfo->max_inodes != shmem_default_max_inodes())
 		seq_printf(seq, ",nr_inodes=%lu", sbinfo->max_inodes);
 	if (sbinfo->mode != (0777 | S_ISVTX))
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8d4104242100..0a11ca2aba50 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -76,9 +76,8 @@ void show_swap_cache_info(void)
 	printk("Swap cache stats: add %lu, delete %lu, find %lu/%lu\n",
 		swap_cache_info.add_total, swap_cache_info.del_total,
 		swap_cache_info.find_success, swap_cache_info.find_total);
-	printk("Free swap  = %ldkB\n",
-		get_nr_swap_pages() << (PAGE_SHIFT - 10));
-	printk("Total swap = %lukB\n", total_swap_pages << (PAGE_SHIFT - 10));
+	printk("Free swap  = %ldkB\n", PG2KB(get_nr_swap_pages()));
+	printk("Total swap = %lukB\n", PG2KB(total_swap_pages));
 }
 
 void *get_shadow_from_swap_cache(swp_entry_t entry)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e3dcaeecc50f..1a8f95edd3c3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2770,8 +2770,8 @@ static int swap_show(struct seq_file *swap, void *v)
 		return 0;
 	}
 
-	bytes = si->pages << (PAGE_SHIFT - 10);
-	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
+	bytes = PG2KB(si->pages);
+	inuse = PG2KB(si->inuse_pages);
 
 	file = si->swap_file;
 	len = seq_file_path(swap, file, " \t\n\\");
@@ -2996,8 +2996,7 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
 	}
 	if (last_page > maxpages) {
 		pr_warn("Truncating oversized swap area, only using %luk out of %luk\n",
-			maxpages << (PAGE_SHIFT - 10),
-			last_page << (PAGE_SHIFT - 10));
+			PG2KB(maxpages), PG2KB(last_page));
 	}
 	if (maxpages > last_page) {
 		maxpages = last_page + 1;
@@ -3338,8 +3337,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	enable_swap_info(p, prio, swap_map, cluster_info, frontswap_map);
 
 	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s\n",
-		p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
-		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
+		PG2KB(p->pages), name->name, p->prio,
+		nr_extents, PG2KB((unsigned long long)span),
 		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
 		(p->flags & SWP_DISCARDABLE) ? "D" : "",
 		(p->flags & SWP_AREA_DISCARD) ? "s" : "",
diff --git a/mm/util.c b/mm/util.c
index 4ac87f1b30f1..6d301ddfc395 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -848,7 +848,7 @@ unsigned long vm_commit_limit(void)
 	unsigned long allowed;
 
 	if (sysctl_overcommit_kbytes)
-		allowed = sysctl_overcommit_kbytes >> (PAGE_SHIFT - 10);
+		allowed = KB2PG(sysctl_overcommit_kbytes);
 	else
 		allowed = ((totalram_pages() - hugetlb_total_pages())
 			   * sysctl_overcommit_ratio / 100);
@@ -921,13 +921,13 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 	 * Reserve some for root
 	 */
 	if (!cap_sys_admin)
-		allowed -= sysctl_admin_reserve_kbytes >> (PAGE_SHIFT - 10);
+		allowed -= KB2PG(sysctl_admin_reserve_kbytes);
 
 	/*
 	 * Don't let a single process grow so big a user can't recover
 	 */
 	if (mm) {
-		long reserve = sysctl_user_reserve_kbytes >> (PAGE_SHIFT - 10);
+		long reserve = KB2PG(sysctl_user_reserve_kbytes);
 
 		allowed -= min_t(long, mm->total_vm / 32, reserve);
 	}
-- 
2.33.0

